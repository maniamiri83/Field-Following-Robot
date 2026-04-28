#include "motor.h"
#include <stdint.h>

// LED indicators (Wired in ir_receiver.c Configure_Pins)
#define LED_LEFT_ON()   (GPIOA->ODR |=  (1u << 1))
#define LED_LEFT_OFF()  (GPIOA->ODR &= ~(1u << 1))
#define LED_RIGHT_ON()  (GPIOA->ODR |=  (1u << 2))
#define LED_RIGHT_OFF() (GPIOA->ODR &= ~(1u << 2))

#define F_CPU  32000000L
#define DEF_F  100000L // 10us tick (100kHz base frequency)

// Duration of a 180-degree spin in milliseconds
#define ROTATE_180_MS  2800u
#define ROTATE_180_SPD   50

volatile int PWM_Counter = 0;

// Initialise to 0 speed, forward direction
volatile int left_speed = 0;
volatile int right_speed = 0;
volatile int left_dir = 1;
volatile int right_dir = 1;

// Set to 1 by ir_receiver.c (via auto_stop()) to break the auto loop
// auto_start() polls this each iteration and exits
volatile unsigned char auto_running         = 0;
unsigned char          auto_intersection_cnt = 0;
unsigned char          auto_in_intersection   = 0;

//----------------------------------
// Motor Control Functions         |
//----------------------------------
void left_wheel_forward() {
    GPIOA->ODR |=  (1u << 6);
    GPIOA->ODR &= ~(1u << 7);
}

void left_wheel_backward() {
    GPIOA->ODR &= ~(1u << 6);
    GPIOA->ODR |=  (1u << 7);
}

void right_wheel_forward() {
    GPIOA->ODR |=  (1u << 12);
    GPIOA->ODR &= ~(1u << 11);
}

void right_wheel_backward() {
    GPIOA->ODR &= ~(1u << 12);
    GPIOA->ODR |=  (1u << 11);
}

// Drive both pins high to brake the motor
void left_wheel_stop() {
    GPIOA->ODR |= (1u << 6);
    GPIOA->ODR |= (1u << 7);
}

void right_wheel_stop() {
    GPIOA->ODR |= (1u << 11);
    GPIOA->ODR |= (1u << 12);
}

void motor_stop() {
    left_wheel_stop();
    right_wheel_stop();
}

//----------------------------------
// Timer and Hardware Setup        |
//----------------------------------
void Hardware_Init(void) {
    // Set up timer 2 using register configuration
    RCC->APB1ENR |= BIT0;           // Turn on clock for timer2
    TIM2->ARR = (F_CPU/DEF_F) - 1;  // Set auto-reload for 10us tick
    NVIC->ISER[0] |= BIT15;         // Enable timer 2 interrupts in the NVIC
    TIM2->CR1 |= BIT4;              // Downcounting
    TIM2->CR1 |= BIT7;              // ARPE enable
    TIM2->DIER |= BIT0;             // Enable update event (reload event) interrupt 
    TIM2->CR1 |= BIT0;              // Enable counting
    
    __enable_irq();                 // Enable global interrupts
}

// SysTick-based blocking delay for use within motor.c only
// Each call and always restored to disabled state afterward
static void motor_delay_ms(unsigned int ms)
{
    unsigned int i;
    unsigned int ticks = 32000u; // 1ms at 32MHz
    for (i = 0; i < ms; i++) {
        SysTick->LOAD = ticks - 1u;
        SysTick->VAL  = 0;
        SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk;
        while (!(SysTick->CTRL & BIT16));
        SysTick->CTRL = 0;
    }
}

void motor_init() {
    // Enable GPIOA clock
    RCC->IOPENR |= BIT0;

    // PA6: Left FWD. MODER bits [13:12] -> output (01)
    GPIOA->MODER = (GPIOA->MODER & ~(0x3u << 12)) | (0x1u << 12);
    GPIOA->OTYPER &= ~(1u << 6);

    // PA7: Left BWD. MODER bits [15:14] -> output (01)
    GPIOA->MODER = (GPIOA->MODER & ~(0x3u << 14)) | (0x1u << 14);
    GPIOA->OTYPER &= ~(1u << 7);

    // PA11: Right BWD. MODER bits [23:22] -> output (01)
    GPIOA->MODER = (GPIOA->MODER & ~(0x3u << 22)) | (0x1u << 22);
    GPIOA->OTYPER &= ~(1u << 11);

    // PA12: Right FWD. MODER bits [25:24] -> output (01)
    GPIOA->MODER = (GPIOA->MODER & ~(0x3u << 24)) | (0x1u << 24);
    GPIOA->OTYPER &= ~(1u << 12);

    // PA1: Left LED output
    GPIOA->MODER = (GPIOA->MODER & ~(0x3u << 2)) | (0x1u << 2);
    GPIOA->OTYPER &= ~(1u << 1);
    LED_LEFT_OFF();

    // PA2: Right LED output
    GPIOA->MODER = (GPIOA->MODER & ~(0x3u << 4)) | (0x1u << 4);
    GPIOA->OTYPER &= ~(1u << 2);
    LED_RIGHT_OFF();

    motor_stop(); // Motors start in a safe state
    Hardware_Init(); // Start the PWM background timer
}

//----------------------------------
// PWM Interrupt Service Routine   |
//----------------------------------
void TIM2_Handler(void) {
    TIM2->SR &= ~BIT0; // Clear update interrupt flag
    PWM_Counter++;
    
    // Left motor PWM Logic
    if(left_speed > PWM_Counter) {
        if (left_dir == 1) left_wheel_forward();
        else left_wheel_backward();
    } else {
        left_wheel_stop();
    }
    
    // Right motor PWM Logic
    if(right_speed > PWM_Counter) {
        if (right_dir == 1) right_wheel_forward();
        else right_wheel_backward();
    } else {
        right_wheel_stop();
    }
    
    // Roll over counter at 100 for a 1kHz PWM frequency
    if (PWM_Counter >= 100) {
        PWM_Counter = 0;
    }   
}

// Spins the robot 180 degrees in place (Left wheel goes backward, Right wheel goes forward)
void motor_rotate_180(void)
{
    left_dir  = -1;
    right_dir =  1;
    left_speed  = ROTATE_180_SPD;
    right_speed = ROTATE_180_SPD;

    motor_delay_ms(ROTATE_180_MS);

    left_speed  = 0;
    right_speed = 0;
    motor_stop();
}

//----------------------------------
// Auto Turn Left & Right          |
//----------------------------------
#define AUTO_TURN_MS   1100u   // ~90 deg at speed 50 (half of ROTATE_180_MS)
#define AUTO_TURN_SPD    50

static void auto_turn_left(void)
{
    LED_LEFT_ON();
    // Left backward, Right forward
    left_dir    = -1;
    right_dir   =  1;
    left_speed  = AUTO_TURN_SPD;
    right_speed = AUTO_TURN_SPD;
    motor_delay_ms(AUTO_TURN_MS);
    left_speed  = 0;
    right_speed = 0;
    motor_stop();
    motor_delay_ms(200);
    LED_LEFT_OFF();
}

static void auto_turn_right(void)
{
    LED_RIGHT_ON();
    // Left forward, Right backward
    left_dir    =  1;
    right_dir   = -1;
    left_speed  = AUTO_TURN_SPD;
    right_speed = AUTO_TURN_SPD;
    motor_delay_ms(AUTO_TURN_MS);
    left_speed  = 0;
    right_speed = 0;
    motor_stop();
    motor_delay_ms(200);
    LED_RIGHT_OFF();
}

static void auto_turn_forward(void)
{
    // No turn, LEDs off
    LED_LEFT_OFF();
    LED_RIGHT_OFF();
}

static uint16_t auto_ADC_Read(uint8_t channel)
{
    ADC1->CHSELR = (1u << channel);
    ADC1->CR |= BIT2;
    while (!(ADC1->ISR & BIT2));
    return (uint16_t)(ADC1->DR);
}

//----------------------------------
// Path Table                      |
//----------------------------------
// [intersection-1][path-1] indexed as path_table[path][intersection]
// 0=Forward, 1=Left, 2=Right, 3=Stop

static const unsigned char path_table[3][8] = {
    // Path 1: F  L  L  F  R  L  R  S
    {0, 1, 1, 0, 2, 1, 2, 3},
    // Path 2: L  R  L  R  F  F  S  S
    {1, 2, 1, 2, 0, 0, 3, 3},
    // Path 3: R  F  R  L  R  L  F  S
    {2, 0, 2, 1, 2, 1, 0, 3}
};

// Separate modifiable array for custom Path 4
static unsigned char custom_path_4[8] = {3, 3, 3, 3, 3, 3, 3, 3}; // Default all STOP

// Helper function to get direction at intersection
static unsigned char get_direction_at_intersection(unsigned char robot_path, unsigned char intersection_num)
{
    if (intersection_num >= 8) return 3; // STOP if out of bounds
    
    if (robot_path == 4) {
        // Use custom Path 4
        return custom_path_4[intersection_num];
    } else if (robot_path >= 1 && robot_path <= 3) {
        // Use predefined paths
        return path_table[robot_path - 1][intersection_num];
    }
    
    return 3; // Default to STOP
}

// Called once when entering automatic mode to clear intersection state
void auto_reset(void)
{
    auto_intersection_cnt = 0;
    auto_in_intersection  = 0;
}

// Called once per main loop iteration
// Reads d1/d2/d3, steers, and handles intersections
void auto_step(unsigned char robot_path,
               uint16_t d1, uint16_t d2, uint16_t d3)
{
    uint16_t d2c;
    int diff, steer, ls, rs;
    unsigned int bk;
    unsigned char action;

    d2c = (d2 > AUTO_D2_OFFSET) ? (d2 - AUTO_D2_OFFSET) : 0;

    // Intersection detection
    if (d3 > AUTO_THRESHOLD && !auto_in_intersection)
    {
        auto_in_intersection = 1;

        // Beep
        for (bk = 0; bk < 200; bk++) {
            GPIOB->ODR |=  BIT5;
            SysTick->LOAD = 200u*32u; SysTick->VAL=0;
            SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk|SysTick_CTRL_ENABLE_Msk;
            while(!(SysTick->CTRL & BIT16)); SysTick->CTRL=0;
            GPIOB->ODR &= ~BIT5;
            SysTick->LOAD = 200u*32u; SysTick->VAL=0;
            SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk|SysTick_CTRL_ENABLE_Msk;
            while(!(SysTick->CTRL & BIT16)); SysTick->CTRL=0;
        }

        action = (auto_intersection_cnt < 8) ?
                  get_direction_at_intersection(robot_path, auto_intersection_cnt) : 3;
        auto_intersection_cnt++;

        left_speed = 0; right_speed = 0; motor_stop();
        motor_delay_ms(200);

        switch (action) {
            case 0: auto_turn_forward(); break;
            case 1: auto_turn_left();    break;
            case 2: auto_turn_right();   break;
            case 3:
                auto_running = 0;
                return;
        }

        left_dir  = 1; right_dir  = 1;
        left_speed  = AUTO_BASE_SPEED;
        right_speed = AUTO_BASE_SPEED;
        return;
    }
    else if (d3 < AUTO_THRESHOLD)
    {
        auto_in_intersection = 0;
    }

    // If wire lost, go straight
    if (d1 < AUTO_THRESHOLD && d2c < AUTO_THRESHOLD) {
        left_dir  = 1; right_dir  = 1;
        left_speed  = AUTO_BASE_SPEED;
        right_speed = AUTO_BASE_SPEED;
        return;
    }

    // Proportional steering
    diff = (int)d1 - (int)d2c;
    if (diff > (int)AUTO_DEAD_BAND || diff < -(int)AUTO_DEAD_BAND) {
        steer = (diff * AUTO_STEER_MAX) / (int)AUTO_MAX_SIGNAL;
        if (steer >  AUTO_STEER_MAX) steer =  AUTO_STEER_MAX;
        if (steer < -AUTO_STEER_MAX) steer = -AUTO_STEER_MAX;
    } else {
        steer = 0;
    }

    ls = AUTO_BASE_SPEED - steer;
    rs = AUTO_BASE_SPEED + steer;
    if (ls > 100) ls = 100; if (ls < 0) ls = 0;
    if (rs > 100) rs = 100; if (rs < 0) rs = 0;

    left_dir  = 1; right_dir  = 1;
    left_speed  = ls;
    right_speed = rs;
}

void auto_stop(void)
{
    auto_running = 0;
    left_speed  = 0;
    right_speed = 0;
    motor_stop();
}

void auto_hold_stop(void)
{
    left_speed = 0;
    right_speed = 0;
    motor_stop();
}

// Update custom path 4 with data from receiver
void set_custom_path(const unsigned char *new_path)
{
    unsigned char i;
    for (i = 0; i < 8; i++) {
        custom_path_4[i] = new_path[i];
    }
}
