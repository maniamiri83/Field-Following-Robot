// ================================================================
// receiver_f.c -- STM32L051 
// ================================================================
// Architecture: fully non-blocking main loop.
//   - IR receive has a short timeout so it never hangs waiting
//   - Auto field-following runs one iteration per loop cycle
//   - VL53L0X runs in continuous mode during AUTO mode
//   - If obstacle detected: motors stop
//   - When obstacle disappears: auto movement resumes
// ================================================================

#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include "../Common/Include/stm32l051xx.h"
#include "motor_f.h"
#include "vl53l0x.h"
#include "obstacle.h"

#define IR_RX_PIN        (GPIOB->IDR & BIT3)
#define SPK_ON()         (GPIOB->ODR |=  BIT5)
#define SPK_OFF()        (GPIOB->ODR &= ~BIT5)

#define IR_START_US       636u
#define IR_HALFBIT_US     208u
#define IR_BIT_PERIOD_US  416u
#define IR_PKT_TIMEOUT    20u   // ms to wait for a packet start burst

// Field detector channels
#define FIELD_L_CH    8u    // PB0  left
#define FIELD_R_CH    9u    // PB1  right
#define FIELD_C_CH    0u    // PA0  centre

// Commands
#define CMD_STOP        0x01
#define CMD_FORWARD     0x02
#define CMD_BACKWARD    0x03
#define CMD_LEFT        0x04
#define CMD_RIGHT       0x05
#define CMD_ROTATE_180  0x06
#define CMD_JOYSTICK    0x50
#define CMD_PATH_1      0x10
#define CMD_PATH_2      0x11
#define CMD_PATH_3      0x12
#define CMD_AUTO_START  0x30
#define CMD_AUTO_STOP   0x31
#define CMD_HORN        0x20
#define CMD_PAUSE       0x40
#define CMD_RESUME      0x41 // pause feature 

#define MIN_MOTOR_SPEED  10


// programing and path define
#define CMD_PATH_4 		0x13
#define CMD_PROG_START	0x60
#define CMD_PROG_STEP	0x61
#define CMD_PROG_END	0x62


// Robot state
static unsigned char robot_mode = 0;   // 0=MANUAL 1=AUTO
static unsigned char robot_path = 1;   // 1,2,3,4

// ToF / obstacle state
static unsigned char tof_ready = 0;
static bool obstacle_blocked = false;
static uint16_t obstacle_range_mm = 0;


// pause feature bool
static bool remote_paused = false;

// path 4
static unsigned char custom_path[8] = {3,3,3,3,3,3,3,3};  // Default all STOP


extern void set_custom_path(const unsigned char *new_path);

// ================================================================
// Configure_Pins
// ================================================================
void Configure_Pins(void)
{
    RCC->IOPENR |= BIT0 | BIT1;

    // PA0 (ADC_IN0): centre detector — analog
    GPIOA->MODER |=  (BIT0 | BIT1);
    GPIOA->PUPDR &= ~(BIT0 | BIT1);

    // PB0 (ADC_IN8): left detector — analog
    GPIOB->MODER |=  (BIT0 | BIT1);
    GPIOB->PUPDR &= ~(BIT0 | BIT1);

    // PB1 (ADC_IN9): right detector — analog
    GPIOB->MODER |=  (BIT2 | BIT3);
    GPIOB->PUPDR &= ~(BIT2 | BIT3);

    // PB3: IR RX input + pull-up
    GPIOB->MODER &= ~(BIT6 | BIT7);
    GPIOB->PUPDR  = (GPIOB->PUPDR & ~(BIT6|BIT7)) | BIT6;

    // PB5: speaker output
    GPIOB->MODER   = (GPIOB->MODER & ~(BIT10|BIT11)) | BIT10;
    GPIOB->OTYPER &= ~BIT5;
    SPK_OFF();

    // H-bridge + LEDs managed inside motor_init()
}

// ================================================================
// ADC
// ================================================================
void ADC_Init(void)
{
    RCC->APB2ENR |= BIT9;
    ADC1->CR |= BIT31;
    while (ADC1->CR & BIT31);
    ADC1->CR |= BIT0;
    while (!(ADC1->ISR & BIT0));
    ADC1->SMPR |= (BIT0|BIT1|BIT2);
}

uint16_t ADC_Read(uint8_t channel)
{
    ADC1->CHSELR = (1u << channel);
    ADC1->CR |= BIT2;
    while (!(ADC1->ISR & BIT2));
    return (uint16_t)(ADC1->DR);
}

// ================================================================
// Timing
// ================================================================
void Timer_us(unsigned int us)
{
    unsigned int ticks = us * 32u;
    if (!ticks) return;
    if (ticks > 0x00FFFFFFu) ticks = 0x00FFFFFFu;
    SysTick->LOAD = ticks;
    SysTick->VAL  = ticks;
    SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk;
    while (!(SysTick->CTRL & BIT16));
    SysTick->CTRL = 0;
}

void delay_ms(unsigned int ms)
{
    unsigned int i;
    for (i = 0; i < ms; i++) Timer_us(1000u);
}

// ================================================================
// I2C for VL53L0X  (PB6=SCL, PB7=SDA)
// ================================================================
void I2C_init(void)
{
    RCC->IOPENR  |= BIT1;   // GPIOB
    RCC->APB1ENR |= BIT21;  // I2C1

    // PB6 = I2C1_SCL, AF1
    GPIOB->MODER = (GPIOB->MODER & ~(BIT12 | BIT13)) | BIT13;
    GPIOB->AFR[0] = (GPIOB->AFR[0] & ~(0xFu << 24)) | (0x1u << 24);

    // PB7 = I2C1_SDA, AF1
    GPIOB->MODER = (GPIOB->MODER & ~(BIT14 | BIT15)) | BIT15;
    GPIOB->AFR[0] = (GPIOB->AFR[0] & ~(0xFu << 28)) | (0x1u << 28);

    GPIOB->OTYPER  |= BIT6 | BIT7;
    GPIOB->OSPEEDR |= BIT12 | BIT14;

    I2C1->TIMINGR = (uint32_t)0x70420f13;
}

unsigned char i2c_read_addr8_data8(unsigned char address, unsigned char *value)
{
    I2C1->CR1 = I2C_CR1_PE;
    I2C1->CR2 = I2C_CR2_AUTOEND | (1 << 16) | (0x52);
    I2C1->CR2 |= I2C_CR2_START;
    while ((I2C1->ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {}

    I2C1->TXDR = address;
    while ((I2C1->ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {}

    Timer_us(1000u);

    I2C1->CR1 = I2C_CR1_PE | I2C_CR1_RXIE;
    I2C1->CR2 = I2C_CR2_AUTOEND | (1 << 16) | I2C_CR2_RD_WRN | (0x52);
    I2C1->CR2 |= I2C_CR2_START;

    while ((I2C1->ISR & I2C_ISR_RXNE) != I2C_ISR_RXNE) {}
    *value = I2C1->RXDR;

    Timer_us(1000u);
    return 1;
}

unsigned char i2c_read_addr8_data16(unsigned char address, unsigned short *value)
{
    I2C1->CR1 = I2C_CR1_PE;
    I2C1->CR2 = I2C_CR2_AUTOEND | (1 << 16) | (0x52);
    I2C1->CR2 |= I2C_CR2_START;
    while ((I2C1->ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {}

    I2C1->TXDR = address;
    while ((I2C1->ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {}

    Timer_us(1000u);

    I2C1->CR1 = I2C_CR1_PE | I2C_CR1_RXIE;
    I2C1->CR2 = I2C_CR2_AUTOEND | (2 << 16) | I2C_CR2_RD_WRN | (0x52);
    I2C1->CR2 |= I2C_CR2_START;

    while ((I2C1->ISR & I2C_ISR_RXNE) != I2C_ISR_RXNE) {}
    *value = ((unsigned short)I2C1->RXDR) << 8;

    while ((I2C1->ISR & I2C_ISR_RXNE) != I2C_ISR_RXNE) {}
    *value |= I2C1->RXDR;

    Timer_us(1000u);
    return 1;
}

unsigned char i2c_write_addr8_data8(unsigned char address, unsigned char value)
{
    I2C1->CR1 = I2C_CR1_PE;
    I2C1->CR2 = I2C_CR2_AUTOEND | (2 << 16) | (0x52);
    I2C1->CR2 |= I2C_CR2_START;
    while ((I2C1->ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {}

    I2C1->TXDR = address;
    while ((I2C1->ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {}

    I2C1->TXDR = value;
    while ((I2C1->ISR & I2C_ISR_TXE) != I2C_ISR_TXE) {}

    Timer_us(1000u);
    return 1;
}

// ================================================================
// ToF init helper
// ================================================================
static void ToF_Init_Once(void)
{
    if (tof_ready) return;

    I2C_init();

    if (vl53l0x_init())
    {
        tof_ready = 1;
        obstacle_reset();
    }
}

// ================================================================
// Speaker
// ================================================================
void Speaker_Beep(unsigned int freq_hz, unsigned int dur_ms)
{
    unsigned long half_us, cycles, i;
    if (!freq_hz) { delay_ms(dur_ms); return; }
    half_us = 500000UL / (unsigned long)freq_hz;
    cycles  = ((unsigned long)freq_hz * (unsigned long)dur_ms) / 1000UL;
    for (i = 0; i < cycles; i++) {
        SPK_ON();  Timer_us((unsigned int)half_us);
        SPK_OFF(); Timer_us((unsigned int)half_us);
    }
    SPK_OFF();
}

// ================================================================
// IR receive — non-blocking
// ================================================================
static unsigned char wait_edge(unsigned char wait_high, unsigned int timeout_us)
{
    unsigned int to = 0;
    unsigned int limit = timeout_us / 10u;
    if (wait_high) {
        while (IR_RX_PIN == 0) { Timer_us(10u); if (++to > limit) return 0; }
    } else {
        while (IR_RX_PIN != 0) { Timer_us(10u); if (++to > limit) return 0; }
    }
    return 1;
}

static unsigned char Sample_Byte_Safe(void)
{
    unsigned char b = 0, i;
    Timer_us(IR_START_US + IR_HALFBIT_US);
    for (i = 0; i < 8; i++) {
        b >>= 1;
        if (IR_RX_PIN != 0) b |= 0x80;
        if (i < 7) Timer_us(IR_BIT_PERIOD_US);
    }
    return b;
}

unsigned char IR_TryReceive(unsigned char *b1_out, unsigned char *b2_out,
                             unsigned char *b3_out, unsigned char *b4_out)
{
    unsigned char b1, b2, b3, b4;

    if (!wait_edge(1, 2000u)) return 0;
    if (!wait_edge(0, 20000u)) return 0;

    b1 = Sample_Byte_Safe();

    
    if (b1 == CMD_JOYSTICK || b1 == CMD_PROG_STEP) { 
        if (!wait_edge(1, 5000u)) return 0;
        if (!wait_edge(0, 5000u)) return 0;
        b2 = Sample_Byte_Safe();
        if (!wait_edge(1, 5000u)) return 0;
        if (!wait_edge(0, 5000u)) return 0;
        b3 = Sample_Byte_Safe();
        if (!wait_edge(1, 5000u)) return 0;
        if (!wait_edge(0, 5000u)) return 0;
        b4 = Sample_Byte_Safe();
        
        // Validate 4-byte checksum
        if ((unsigned char)(b1+b2+b3+b4) != 0xFF) return 0;
        
        *b1_out = b1; *b2_out = b2; *b3_out = b3; *b4_out = b4;
        return 4;
    } else {
        // Standard 2-byte command
        if (!wait_edge(1, 5000u)) return 0;
        if (!wait_edge(0, 5000u)) return 0;
        b2 = Sample_Byte_Safe();
        if ((unsigned char)(b1+b2) != 0xFF) return 0;
        *b1_out = b1; *b2_out = b2; *b3_out = 0; *b4_out = 0;
        return 2;
    }
}

// ================================================================
// Handle_Command
// ================================================================
void Handle_Command(unsigned char cmd, unsigned char lv, unsigned char rv)
{
    if (cmd == CMD_JOYSTICK && robot_mode == 0) {
        left_dir  = (lv & 0x80) ? 1 : -1;
        right_dir = (rv & 0x80) ? 1 : -1;
        left_speed  = (int)(lv & 0x7F);
        right_speed = (int)(rv & 0x7F);
        if (left_speed  > 100) left_speed  = 100;
        if (right_speed > 100) right_speed = 100;
        if (left_speed  < MIN_MOTOR_SPEED) left_speed  = 0;
        if (right_speed < MIN_MOTOR_SPEED) right_speed = 0;
        if (!left_speed && !right_speed) motor_stop();
        return;
    }

    switch (cmd) {
        case CMD_STOP:
            left_speed = 0;
            right_speed = 0;
            motor_stop();
            break;

        case CMD_FORWARD:
            left_dir = 1; right_dir = 1;
            left_speed = 100; right_speed = 100;
            break;

        case CMD_BACKWARD:
            left_dir = -1; right_dir = -1;
            left_speed = 100; right_speed = 100;
            break;

        case CMD_LEFT:
            left_dir = -1; right_dir = 1;
            left_speed = 100; right_speed = 100;
            break;

        case CMD_RIGHT:
            left_dir = 1; right_dir = -1;
            left_speed = 100; right_speed = 100;
            break;

        case CMD_ROTATE_180:
            motor_rotate_180();
            break;

        case CMD_PATH_1:
            robot_path = 1;
            break;

        case CMD_PATH_2:
            robot_path = 2;
            break;

        case CMD_PATH_3:
            robot_path = 3;
            break;
            
        case CMD_PATH_4:
            robot_path = 4;
            break;
            
		case CMD_PAUSE: 
            if (robot_mode == 1) remote_paused = true;
            break;

        case CMD_RESUME:
            remote_paused = false;
            break;
		
		case CMD_PROG_START:
    {
        unsigned char i;
        for (i = 0; i < 8; i++){
            custom_path[i] = 0x01;
        }
            
        Speaker_Beep(2000u, 100u);
        delay_ms(100);
        Speaker_Beep(2000u, 100u);
        break;
    }           

case CMD_PROG_END:
    // Updates the motor path table
    set_custom_path(custom_path);
    
    // Triple beep to confirm path saved
    Speaker_Beep(2500u, 150u);
    delay_ms(100);
    Speaker_Beep(2500u, 150u);
    delay_ms(100);
    Speaker_Beep(2500u, 150u);
    break;

        
        case CMD_AUTO_START:
            ToF_Init_Once();
            robot_mode = 1;
            auto_running = 1;
            auto_reset();
            obstacle_reset();
            obstacle_blocked = false;
            remote_paused = false; // Reset remote pause on start
            
            if (tof_ready) vl53l0x_start_continuous();

            left_dir  = 1;
            right_dir = 1;
            left_speed  = AUTO_BASE_SPEED;
            right_speed = AUTO_BASE_SPEED;
            break;

        case CMD_AUTO_STOP:
            robot_mode   = 0;
            auto_running = 0;
            obstacle_blocked = false;
            remote_paused = false; // Reset remote pause on stop

            if (tof_ready) vl53l0x_stop_continuous();

            left_speed = 0;
            right_speed = 0;
            motor_stop();
            break;

        case CMD_HORN:
            Speaker_Beep(2500u, 200u);
            break;

        default:
            break;
    }
}

void Handle_Program_Step(unsigned char step_num, unsigned char direction)
{
	//validate step num and dir
	if (step_num >= 8) return; //invalid step
	if (direction > 3) return; // invalud dir

	// store step
	custom_path[step_num] = direction;
	
	// beep for check
	Speaker_Beep(2200u, 120u);
}

// ================================================================
// Main
// ================================================================
void main(void)
{
    unsigned char b1, b2, b3, b4, pkt;

    Configure_Pins();
    ADC_Init();
    motor_init();
    delay_ms(200);

    Speaker_Beep(1500u, 80u);
    delay_ms(80u);
    Speaker_Beep(2000u, 80u);

    while (1)
    {
        //Step 1: check for IR command
        pkt = IR_TryReceive(&b1, &b2, &b3, &b4);
        
        if (pkt == 4) {
            // Check if this is a programming step packet
            if (b1 == CMD_PROG_STEP) {
                if ((unsigned char)(b1 + b2 + b3 + b4) == 0xFF) {
                    Handle_Program_Step(b2, b3);  // b2 = step_num, b3 = direction
                }
            } else {
                // Regular 4-byte command (joystick)
                Handle_Command(b1, b2, b3);
            }
        }
        else if (pkt == 2) {
            // Regular 2-byte command
            Handle_Command(b1, 0, 0);
        }

        // Step 2: auto field following + obstacle gate
        if (robot_mode == 1 && auto_running)
        {
            if (tof_ready && vl53l0x_measurement_ready())
            {
                if (vl53l0x_read_range_continuous(&obstacle_range_mm))
                {
                    obstacle_blocked = obstacle_detected(obstacle_range_mm);
                }
            }

            if (obstacle_blocked || remote_paused)
            {
                auto_hold_stop();
            }
            else
            {
                auto_step(robot_path,
                          ADC_Read(FIELD_L_CH),
                          ADC_Read(FIELD_R_CH),
                          ADC_Read(FIELD_C_CH));
            }
        }
    }
}