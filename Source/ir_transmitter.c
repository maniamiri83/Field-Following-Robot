
// EFM8 Pin Layout:
// P1.4 - 150 Ohm -> SFH4546 Anode -> Cathode -> GND (IR TX)
// P1.5 - TSOP33338 OUT                              (IR RX)
// P0.6 - Speaker Circuit                            (Horn)
// P1.6 - Battery Voltage Divider (10k+10k from 9V)  (Battery)
// P2.1 - JOY_URX Analog  (10k+10k divider from 5V)
// P2.2 - JOY_URY Analog  (10k+10k divider from 5V)
// P2.3 - JOY_SW  Pull-up to 5V
// P2.4 - BTN1    Pull-up to 5V
// P2.5 - BTN2    Pull-up to 5V
// P1.1 - LCD_D6 
// P1.2 - LCD_D5
// P1.3 - LCD_D4 
// P1.7 - LCD_RS 
// P2.0 - LCD_E

#include <EFM8LB1.h>
#include <stdio.h>
#include <string.h>

#define BATT_CH QFP32_MUX_P1_6 // Battery voltage on P1.6
#define JOY_URX_CH   QFP32_MUX_P2_1
#define JOY_URY_CH   QFP32_MUX_P2_2

#define SYSCLK          72000000L
#define SARCLK          18000000L
#define CHARS_PER_LINE  16
#define BAUDRATE		115200

#define IR_HALF_US    13
#define IR_HALF_FULL  32
#define IR_HALF_MID   16

#define JOY_HIGH   9000
#define JOY_LOW    3000

#define BTN1_LONG_MS   800   // Long press for Program Mode
#define BTN2_LONG_MS   500
#define BTN3_LONG_MS   1000  // Long press for lock / early save in program mode

#define LCD_RS  P1_7
#define LCD_E   P2_0
#define LCD_D4  P1_3
#define LCD_D5  P1_2
#define LCD_D6  P1_1
#define LCD_D7  P1_0

#define IR_TX   P1_4
#define IR_RX   P1_5
#define JOY_SW  P2_3
#define BTN1    P2_5
#define BTN2    P2_4
#define BTN3    P2_6

//----------------------------------
// Commands                        |
//----------------------------------
#define CMD_STOP        0x01
#define CMD_FORWARD     0x02
#define CMD_BACKWARD    0x03
#define CMD_LEFT        0x04
#define CMD_RIGHT       0x05
#define CMD_ROTATE_180  0x06
#define CMD_PATH_1      0x10
#define CMD_PATH_2      0x11
#define CMD_PATH_3      0x12
#define CMD_PATH_4      0x13
#define CMD_AUTO_START  0x30
#define CMD_AUTO_STOP   0x31
#define CMD_PAUSE       0x40
#define CMD_RESUME      0x41
#define CMD_HORN        0x20
#define CMD_JOYSTICK    0x50

// Program Mode Commands
#define CMD_PROG_START  0x60  // Signal start of programming
#define CMD_PROG_STEP   0x61  // Send a step followed by step number and direction
#define CMD_PROG_END    0x62  // Signal end of programming

#define CMD_NONE        0xFF

// Joystick Calibration
#define JOY_MID        5070u
#define JOY_DEAD        500u
#define FWD_RANGE      3630u
#define BWD_RANGE      3670u
#define TURN_MAX       3630u

//----------------------------------
// Password Lock State             |
//----------------------------------
unsigned char saved_password = 0;      // 4-bit password (0000-1111)
bit           password_set = 0;        // Has password been set?
bit           is_locked = 0;           // Is remote currently locked?

//----------------------------------
// Program Mode State              |
//----------------------------------
unsigned char xdata program_path[8];  // XDATA for extended memory
unsigned char program_step = 0;       // Keep in DATA (single byte)

//----------------------------------
// Stopwatch State (Auto only)     |
//----------------------------------
unsigned int  stopwatch_seconds = 0;  // Total seconds elapsed
unsigned char stopwatch_minutes = 0;  // Minutes (derived from seconds)
unsigned char stopwatch_secs    = 0;  // Seconds within minute (0-59)
bit           stopwatch_paused  = 0;  // Is stopwatch paused?
bit           timer_tick        = 0;  // Set by Timer2 ISR every ~1 second

// Simple function to put a 4-digit number into a string at a specific position
void Print4Digit(char *str, unsigned int val) {
    str[0] = (val / 1000) % 10 + '0';
    str[1] = (val / 100) % 10 + '0';
    str[2] = (val / 10) % 10 + '0';
    str[3] = (val % 10) + '0';
}

// Function Declarations
char _c51_external_startup(void);
void Timer3us(unsigned char us);
void waitms(unsigned int ms);
void InitPinADC(unsigned char portno, unsigned char pin_num);
void InitADC(void);
unsigned int ADC_at_Pin(unsigned char pin);
void LCD_pulse(void);
void LCD_byte(unsigned char x);
void WriteData(unsigned char x);
void WriteCommand(unsigned char x);
void LCD_4BIT(void);
void LCDprint(char *s, unsigned char line, bit clear);
void IR_HalfPeriod(bit is_space);
unsigned char IR_LoopbackByte(unsigned char tx_byte);
unsigned char IR_LoopbackPacket(unsigned char cmd);
void Update_Status_Line(void);
unsigned char Read_Joystick(void);
void Send_Joystick_Proportional(void);
void Show_Command(unsigned char cmd);
const char *Cmd_Label(unsigned char cmd);
unsigned char Get_Battery_Percent(void);
void Password4BitToString(unsigned char val, char *str);
unsigned char Password_Entry_Screen(char *line1_msg);
void Program_Mode(void);  // Program Mode function
const char *Direction_Label(unsigned char dir);  // Direction label helper
void Init_Timer2_1Hz(void);
void Update_Stopwatch_Display(void);

//----------------------------------
// State                           |
//----------------------------------
unsigned char current_path = 1;
bit           auto_mode    = 0;

char _c51_external_startup(void)
{
    SFRPAGE = 0x00;
    WDTCN = 0xDE;
    WDTCN = 0xAD;
    VDM0CN |= 0x80;
    RSTSRC  = 0x02;
    SFRPAGE = 0x10;
    PFE0CN  = 0x20;
    SFRPAGE = 0x00;
    CLKSEL = 0x00; CLKSEL = 0x00;
    while ((CLKSEL & 0x80) == 0);
    CLKSEL = 0x03; CLKSEL = 0x03;
    while ((CLKSEL & 0x80) == 0);

	P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
    P1MDOUT |= 0x9F;
    P2MDOUT |= 0x01;

    SFRPAGE = 0x20;
    P2MDIN &= ~0x06;
    P2SKIP  |=  0x06;
    SFRPAGE = 0x00;

    XBR0 = 0x01; // 0x00 to 0x01, to enable UART0 on P0.4(TX) and P0.5(RX)   
    XBR1 = 0x00;
    XBR2 = 0x41; // 0x40 to 0x41, to enable uart 1

	// Configure Uart 0
	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	SCON0 = 0x10;
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready

    IR_TX   = 0;
    return 0;
}

void putchar (char c) 
{
    SFRPAGE = 0x20;
	if (c == '\n') 
	{
		while (!TI);
		TI=0;
		SBUF0 = '\r';
	}
	while (!TI);
	TI=0;
	SBUF0 = c;
	SFRPAGE = 0x00;
}


void Timer3us(unsigned char us)
{
    unsigned char i;
    CKCON0 |= 0x40;
    TMR3RL  = (-(SYSCLK) / 1000000L);
    TMR3    = TMR3RL;
    TMR3CN0 = 0x04;
    for (i = 0; i < us; i++) {
        while (!(TMR3CN0 & 0x80));
        TMR3CN0 &= ~0x80;
    }
    TMR3CN0 = 0;
}

void waitms(unsigned int ms)
{
    unsigned int  j;
    unsigned char k;
    for (j = 0; j < ms; j++)
        for (k = 0; k < 4; k++) Timer3us(250);
}

void InitPinADC(unsigned char portno, unsigned char pin_num)
{
    unsigned char mask = 1 << pin_num;
    SFRPAGE = 0x20;
    switch (portno) {
        case 0: P0MDIN &= ~mask; P0SKIP |= mask; break;
        case 1: P1MDIN &= ~mask; P1SKIP |= mask; break;
        case 2: P2MDIN &= ~mask; P2SKIP |= mask; break;
        default: break;
    }
    SFRPAGE = 0x00;
}

void InitADC(void)
{
    SFRPAGE = 0x00;
    ADEN = 0;
    ADC0CN1 = (0x2 << 6) | (0x0 << 3) | (0x0 << 0);
    ADC0CF0 = ((SYSCLK / SARCLK) << 3) | (0x0 << 2);
    ADC0CF1 = (0 << 7) | (0x1E << 0);
    ADC0CN0 = 0x00;
    ADC0CF2 = (0x0 << 7) | (0x1 << 5) | (0x1F << 0);
    ADC0CN2 = 0x00;
    ADEN = 1;
}

unsigned int ADC_at_Pin(unsigned char pin)
{
    ADC0MX = pin;
    ADINT  = 0;
    ADBUSY = 1;     
    while (!ADINT); // Wait for first conversion (Throw-away)
    
    ADINT  = 0;
    ADBUSY = 1;     
    while (!ADINT); // Wait for second conversion (Actual value)
    return ADC0;
}

unsigned char Get_Battery_Percent(void)
{
    unsigned int batt_adc;
    unsigned long pin_mv;
    unsigned long V_battery_mv;
    long battery_percent;

    // Read twice to settle
    ADC_at_Pin(BATT_CH);
    batt_adc = ADC_at_Pin(BATT_CH);
    
    if (batt_adc == 0) return 0;

    // Using 1700mV reference and ADC max ~8191 (13-bit)
    pin_mv = ((unsigned long)batt_adc * 1700UL) / 8191UL;
    
    // With 100k + 10k divider (multiply by 11)
    V_battery_mv = pin_mv * 11UL;
    
    // Map to percentage (9000mV = 100%, 5000mV = 0%)
    if (V_battery_mv >= 9000UL) return 100;
    if (V_battery_mv <= 5000UL) return 0;
    
    // Linear mapping: (V - 5000) / (9000 - 5000) ? 100
    battery_percent = ((V_battery_mv - 5000UL) * 100UL) / 4000UL;
    
    return (unsigned char)battery_percent;
}

void LCD_pulse(void) { LCD_E=1; Timer3us(40); LCD_E=0; }

void LCD_byte(unsigned char x)
{
    ACC=x;
    LCD_D7=ACC_7; LCD_D6=ACC_6; LCD_D5=ACC_5; LCD_D4=ACC_4;
    LCD_pulse(); Timer3us(40);
    ACC=x;
    LCD_D7=ACC_3; LCD_D6=ACC_2; LCD_D5=ACC_1; LCD_D4=ACC_0;
    LCD_pulse();
}

void WriteData(unsigned char x)    { LCD_RS=1; LCD_byte(x); waitms(2); }
void WriteCommand(unsigned char x) { LCD_RS=0; LCD_byte(x); waitms(5); }

void LCD_4BIT(void)
{
    LCD_E=0; waitms(20);
    WriteCommand(0x33); WriteCommand(0x33); WriteCommand(0x32);
    WriteCommand(0x28); WriteCommand(0x0C); WriteCommand(0x01);
    waitms(20);
}

void LCDprint(char *s, unsigned char line, bit clear)
{
    int j;
    WriteCommand(line==2 ? 0xC0 : 0x80);
    waitms(5);
    for (j=0; s[j]!=0; j++) WriteData(s[j]);
    if (clear) for (; j<CHARS_PER_LINE; j++) WriteData(' ');
}

void IR_HalfPeriod(bit is_space)
{
    if (is_space) IR_TX ^= 1;
    else          IR_TX  = 0;
    Timer3us(IR_HALF_US);
}

unsigned char IR_LoopbackByte(unsigned char tx_byte)
{
    unsigned char rx_byte = 0;
    unsigned char i, h;
    bit is_space;

    for (h=0; h<IR_HALF_FULL; h++) IR_HalfPeriod(1);
    IR_TX = 0;

    for (i=0; i<8; i++)
    {
        is_space = ((tx_byte & 0x01) == 0) ? 1 : 0;
        tx_byte >>= 1;
        rx_byte >>= 1;

        for (h=0; h<IR_HALF_MID; h++) IR_HalfPeriod(is_space);
        IR_TX = 0;
        if (IR_RX == 1) rx_byte |= 0x80;

        for (h=0; h<IR_HALF_MID; h++) IR_HalfPeriod(is_space);
        IR_TX = 0;
    }

    for (h=0; h<IR_HALF_FULL; h++) IR_HalfPeriod(0);
    IR_TX = 0;

    return rx_byte;
}

unsigned char IR_LoopbackPacket(unsigned char cmd)
{
    unsigned char rx_cmd, rx_chk;
    unsigned char expected_chk = (unsigned char)(0xFF - cmd);
    rx_cmd = IR_LoopbackByte(cmd);
    rx_chk = IR_LoopbackByte(expected_chk);
    IR_TX = 0;
    if (rx_cmd == cmd && rx_chk == expected_chk) return rx_cmd;
    return CMD_NONE;
}

void Update_Status_Line(void)
{
    char s[17];
    if (auto_mode) strncpy(s, "AUTO   || ", 10);
    else           strncpy(s, "MANUAL || ", 10);
    s[10]='P'; s[11]='A'; s[12]='T'; s[13]='H'; s[14]=':';
    s[15]='0'+current_path;
    s[16]=0;
    LCDprint(s, 2, 0);
}

unsigned char Read_Joystick(void)
{
    unsigned int urx = ADC_at_Pin(JOY_URX_CH);
    unsigned int ury = ADC_at_Pin(JOY_URY_CH);
    if      (urx > JOY_HIGH) return CMD_RIGHT;
    else if (urx < JOY_LOW)  return CMD_LEFT;
    else if (ury < JOY_LOW)  return CMD_FORWARD;
    else if (ury > JOY_HIGH) return CMD_BACKWARD;
    else                     return CMD_STOP;
}

const char *Cmd_Label(unsigned char cmd)
{
    switch (cmd) {
        case CMD_STOP:       return "STOP    ";
        case CMD_FORWARD:    return "FORWARD  ";
        case CMD_BACKWARD:   return "BACKWARD ";
        case CMD_LEFT:       return "LEFT     ";
        case CMD_RIGHT:      return "RIGHT    ";
        case CMD_ROTATE_180: return "ROT 180  ";
        case CMD_PATH_1:     return "PATH  1  ";
        case CMD_PATH_2:     return "PATH  2  ";
        case CMD_PATH_3:     return "PATH  3  ";
        case CMD_PATH_4:     return "PATH  4  ";
        case CMD_AUTO_START: return "AUTO  ON ";
        case CMD_AUTO_STOP:  return "AUTO OFF ";
        case CMD_PAUSE:      return "PAUSED   ";
        case CMD_RESUME:     return "RESUMING ";
        case CMD_HORN:       return "HORN!!   ";
        default:             return "???      ";
    }
}

// Direction label for program mode
const char *Direction_Label(unsigned char dir)
{
    switch (dir) {
        case 0: return "FORWARD ";
        case 1: return "LEFT    ";
        case 2: return "RIGHT   ";
        case 3: return "STOP    ";
        default: return "???     ";
    }
}

void Show_Command(unsigned char cmd)
{
    unsigned int raw_adc;
    unsigned long pin_mv, battery_mv;
    unsigned char percent;
    const char *label = Cmd_Label(cmd);
    char xdata line[17]; 
    unsigned char i;

    raw_adc = ADC_at_Pin(BATT_CH);
    percent = Get_Battery_Percent();

    // Calculate actual voltages for debugging
    pin_mv = ((unsigned long)raw_adc * 2400UL) / 4095UL;
    battery_mv = pin_mv * 3UL;

    // Clear buffer
    for(i=0; i<16; i++) line[i] = ' ';
    line[16] = 0;

    // Command label
    for(i=0; i<8 && label[i] != 0; i++) {
        line[i] = label[i];
    }

    // Battery percentage
    line[11] = 'B';
    line[12] = ':';
    if (percent >= 100) {
        line[13] = '1'; line[14] = '0'; line[15] = '0';
    } else {
        line[13] = ' ';
        line[14] = (percent / 10) + '0';
        line[15] = (percent % 10) + '0';
    }
    LCDprint(line, 1, 1);

}

void Send_Joystick_Proportional(void)
{
    unsigned int urx, ury;
    int base, turn, lv, rv;
    unsigned char lb, rb, chk;
    char xdata disp[17];  // XDATA for extended memory
    unsigned char percent;

    urx = ADC_at_Pin(JOY_URX_CH);
    ury = ADC_at_Pin(JOY_URY_CH);

    // Joystick scaling logic
    if (ury > (JOY_MID + JOY_DEAD)) {
        base = (int)((long)(ury - JOY_MID - JOY_DEAD) * 100L / (long)FWD_RANGE);
        if (base > 100) base = 100;
    } else if (ury < (JOY_MID - JOY_DEAD)) {
        base = -(int)((long)(JOY_MID - JOY_DEAD - ury) * 100L / (long)BWD_RANGE);
        if (base < -100) base = -100;
    } else {
        base = 0;
    }

    if (urx > (JOY_MID + JOY_DEAD)) {
        turn = (int)((long)(urx - JOY_MID - JOY_DEAD) * 50L / (long)TURN_MAX);
        if (turn > 50) turn = 50;
    } else if (urx < (JOY_MID - JOY_DEAD)) {
        turn = -(int)((long)(JOY_MID - JOY_DEAD - urx) * 50L / (long)TURN_MAX);
        if (turn < -50) turn = -50;
    } else {
        turn = 0;
    }

    if (base == 0 && turn == 0) {
        IR_LoopbackPacket(CMD_STOP);
        Show_Command(CMD_STOP);
        return;
    }

    lv = base + turn;
    rv = base - turn;
    if (lv >  100) lv =  100;
    if (lv < -100) lv = -100;
    if (rv >  100) rv =  100;
    if (rv < -100) rv = -100;

    lb = (lv >= 0) ? (0x80 | (unsigned char) lv)  : (unsigned char)(-lv);
    rb = (rv >= 0) ? (0x80 | (unsigned char) rv)   : (unsigned char)(-rv);
    chk = (unsigned char)(0xFF - CMD_JOYSTICK - lb - rb);

    IR_LoopbackByte(CMD_JOYSTICK);
    IR_LoopbackByte(lb);
    IR_LoopbackByte(rb);
    IR_LoopbackByte(chk);
    IR_TX = 0;

    percent = Get_Battery_Percent();

    // Display (e.g. L100 R100 B:95%)
    disp[0]='L';
    disp[1]='0'+((lv<0?-lv:lv)/100%10);
    disp[2]='0'+((lv<0?-lv:lv)/10%10);
    disp[3]='0'+((lv<0?-lv:lv)%10);
    disp[4]=' ';
    disp[5]='R';
    disp[6]='0'+((rv<0?-rv:rv)/100%10);
    disp[7]='0'+((rv<0?-rv:rv)/10%10);
    disp[8]='0'+((rv<0?-rv:rv)%10);
    disp[9]=' ';
    disp[10]='B';
    disp[11]=':';
    if(percent >= 100) {
        disp[12]='1'; disp[13]='0'; disp[14]='0';
    } else {
        disp[12]=' '; // Space
        disp[13]='0'+(percent/10);
        disp[14]='0'+(percent%10);
    }
    disp[15]='%';
    disp[16]=0;
    LCDprint(disp, 1, 1);
}

//----------------------------------
// Password Functions              |
//----------------------------------
// Convert 4-bit password to "0000"-"1111" string format
void Password4BitToString(unsigned char val, char *str)
{
    str[0] = (val & 0x08) ? '1' : '0';
    str[1] = (val & 0x04) ? '1' : '0';
    str[2] = (val & 0x02) ? '1' : '0';
    str[3] = (val & 0x01) ? '1' : '0';
    str[4] = 0;
}

// Password entry screen with shifting mechanism
// Returns the 4-bit password entered
unsigned char Password_Entry_Screen(char *line1_msg)
{
    unsigned char pass = 0;  // 4-bit value (0000)
    char xdata line2[17];
    char pass_str[5];
    
    while (1)
    {
        // Display current password
        Password4BitToString(pass, pass_str);
        line2[0] = 'P'; line2[1] = 'a'; line2[2] = 's'; line2[3] = 's';
        line2[4] = ':'; line2[5] = ' ';
        line2[6] = pass_str[0];
        line2[7] = pass_str[1];
        line2[8] = pass_str[2];
        line2[9] = pass_str[3];
        line2[10] = ' '; line2[11] = ' '; line2[12] = ' ';
        line2[13] = ' '; line2[14] = ' '; line2[15] = ' '; line2[16] = 0;
        
        LCDprint(line1_msg, 1, 1);
        LCDprint(line2, 2, 1);
        
        // BTN1: Input 0 (Shift left, add 0)
        if (BTN1 == 0)
        {
            waitms(20); // Debounce
            if (BTN1 == 0)
            {
                pass = (pass << 1) & 0x0F; // Shift left, add 0, keep 4 bits
                while (BTN1 == 0); // Wait for release
                waitms(50);
            }
        }
        
        // BTN2: Input 1 (Shift left, add 1)
        else if (BTN2 == 0)
        {
            waitms(20); // Debounce
            if (BTN2 == 0)
            {
                pass = ((pass << 1) | 0x01) & 0x0F; // Shift left, add 1, keep 4 bits
                while (BTN2 == 0); // Wait for release
                waitms(50);
            }
        }
        
        // BTN3: Confirm password
        else if (BTN3 == 0)
        {
            waitms(20); // Debounce
            if (BTN3 == 0)
            {
                while (BTN3 == 0); // Wait for release
                return pass; // Return the entered password
            }
        }
        
        waitms(50);
    }
}

//----------------------------------
// Timer2 for Stopwatch            |
// (1 Hz interrupt)                |
//----------------------------------
void Init_Timer2_1Hz(void)
{
    // Timer2 in 16-bit auto-reload mode
    // SYSCLK = 72 MHz
    // 100 Hz (10 ms) interrupt
    // Prescaler = SYSCLK/12 = 6 MHz
    // 100 Hz: Reload = 65536 - 60000 = 5536
    
    TMR2CN0 = 0x00;     // Stop Timer2, clear overflow flag
    CKCON0 &= ~0x30;    // Timer2 using SYSCLK/12 = 6 MHz
	TMR2RL = 5536;      // Reload value for 100 Hz (10 ms)
    TMR2 = TMR2RL;      // Initialise Timer2
    ET2 = 1;            // Enable Timer2 interrupts
    TR2 = 1;            // Start Timer2
}

// Timer2 ISR, called every 10ms (100 Hz)
void Timer2_ISR(void) interrupt 5
{
    static unsigned char tick_count = 0;
    
    TF2H = 0; // Clear Timer2 interrupt flag
    
    if (auto_mode && !stopwatch_paused) {
        tick_count++;
        if (tick_count >= 100) { // 100 * 10ms = 1 second
            tick_count = 0;
            timer_tick = 1; // Signal main loop to update stopwatch
        }
    }
}

void Update_Stopwatch_Display(void)
{
    char xdata line[17]; 
    unsigned char percent;
    
    stopwatch_minutes = (unsigned char)(stopwatch_seconds / 60);
    stopwatch_secs = (unsigned char)(stopwatch_seconds % 60);
    percent = Get_Battery_Percent();
    
    // Static prefix
    line[0] = 'T'; line[1] = 'i'; line[2] = 'm'; line[3] = 'e';
    line[4] = ':';
    
    // Fixed-width Time: " MM:SS" or "  M:SS"
    // Using fixed positions prevents the battery from jumping around
    line[5] = (stopwatch_minutes >= 10) ? ('0' + (stopwatch_minutes / 10)) : ' ';
    line[6] = '0' + (stopwatch_minutes % 10);
    line[7] = ':';
    line[8] = '0' + (stopwatch_secs / 10);
    line[9] = '0' + (stopwatch_secs % 10);
    
    line[10] = ' '; // Spacer
    line[11] = 'B';
    line[12] = ':';
    
    // Battery Logic (0-100)
    if (percent >= 100) {
        line[13] = '1';
        line[14] = '0';
        line[15] = '0';
    } else {
        line[13] = ' '; // Leading space for alignment
        line[14] = (percent >= 10) ? ('0' + (percent / 10)) : ' ';
        line[15] = '0' + (percent % 10);
    }
    
    line[16] = '\0'; // Properly terminate at the end of the 16-char buffer
    
    LCDprint(line, 1, 1);
}

//----------------------------------
// Program Mode Function           |
//----------------------------------
void Program_Mode(void)
{
    unsigned char current_option = 3; // Start with STOP (0=F, 1=L, 2=R, 3=S)
    char xdata line1[17];
    char xdata line2[17];
    unsigned int btn3_held;
    unsigned char i;
    unsigned char rx_ack; // Store acknowledgment
    
    program_step = 0; // Reset step counter
    
    // Initialize program_path with STOP
    for (i = 0; i < 8; i++) {
        program_path[i] = 3; // Default to STOP
    }
    
    // Send CMD_PROG_START to STM32 and wait for acknowledgment
    rx_ack = IR_LoopbackPacket(CMD_PROG_START);
    
    // Show if STM32 acknowledged, debug only
    if (rx_ack == CMD_PROG_START) {
        LCDprint("Program Mode:   ", 1, 1);
        LCDprint("STM32 Ready!    ", 2, 1);
    } else {
        LCDprint("Program Mode:   ", 1, 1);
        LCDprint("Loading...      ", 2, 1);
    }
    waitms(800);
    
    while (program_step < 8)
    {
        // Display current step and option
        line1[0] = 'S'; line1[1] = 't'; line1[2] = 'e'; line1[3] = 'p';
        line1[4] = ' ';
        line1[5] = '0' + (program_step + 1); // Display as 1-8
        line1[6] = '/'; line1[7] = '8'; line1[8] = ':';
        line1[9] = ' '; line1[10] = ' '; line1[11] = ' ';
        line1[12] = ' '; line1[13] = ' '; line1[14] = ' ';
        line1[15] = ' '; line1[16] = 0;
        
        // Show current option
        for (i = 0; i < 8; i++) {
            line2[i] = Direction_Label(current_option)[i];
        }
        for (; i < 16; i++) line2[i] = ' ';
        line2[16] = 0;
        
        LCDprint(line1, 1, 1);
        LCDprint(line2, 2, 1);
        
        // BTN1: Cycle forward (STOP -> FORWARD -> RIGHT -> LEFT -> STOP)
        if (BTN1 == 0)
        {
            waitms(20); // Debounce
            if (BTN1 == 0)
            {
                current_option++;
                if (current_option > 3) current_option = 0;
                
                while (BTN1 == 0); // Wait for release
                waitms(100);
            }
        }
        
        // BTN2: Cycle backward (STOP -> LEFT -> RIGHT -> FORWARD -> STOP)
        else if (BTN2 == 0)
        {
            waitms(20); // Debounce
            if (BTN2 == 0)
            {
                if (current_option == 0) current_option = 3;
                else current_option--;
                
                while (BTN2 == 0); // Wait for release
                waitms(100);
            }
        }
        
        // BTN3: Confirm option OR long press to save early
        else if (BTN3 == 0)
        {
            waitms(20); // Debounce
            if (BTN3 == 0)
            {
                btn3_held = 0;
                
                // Check for long press
                while (BTN3 == 0 && btn3_held < 1200)
                {
                    waitms(10);
                    btn3_held += 10;
                }
                
                if (btn3_held >= BTN3_LONG_MS)
                {
                    // Long press to save path early
                    program_path[program_step] = current_option;
                    
                    // Send current step (4-byte packet)
                    IR_LoopbackByte(CMD_PROG_STEP);
                    IR_LoopbackByte(program_step);
                    IR_LoopbackByte(current_option);
                    IR_LoopbackByte((unsigned char)(0xFF - CMD_PROG_STEP - program_step - current_option));
                    IR_TX = 0;
                    waitms(100); // Give STM32 time to beep
                    
                    program_step++;
                    
                    // Fill remaining steps with STOP
                    for (i = program_step; i < 8; i++)
                    {
                        program_path[i] = 3; // STOP
                        
                        // Send STOP for remaining steps (4-byte packet)
                        IR_LoopbackByte(CMD_PROG_STEP);
                        IR_LoopbackByte(i);
                        IR_LoopbackByte(3);  // STOP
                        IR_LoopbackByte((unsigned char)(0xFF - CMD_PROG_STEP - i - 3));
                        IR_TX = 0;
                        waitms(100); // Give STM32 time to beep
                    }
                    
                    // Exit loop to finish programming
                    break;
                }
                else
                {
                    // Short press to confirm current option and move to next step
                    program_path[program_step] = current_option;
                    
                    // Send this step to STM32 (4-byte packet)
                    IR_LoopbackByte(CMD_PROG_STEP);
                    IR_LoopbackByte(program_step);
                    IR_LoopbackByte(current_option);
                    IR_LoopbackByte((unsigned char)(0xFF - CMD_PROG_STEP - program_step - current_option));
                    IR_TX = 0;
                    waitms(100); // Give STM32 time to beep
                    
                    program_step++;
                    
                    // Reset to STOP for next step
                    current_option = 3;
                    
                    while (BTN3 == 0); // Wait for release
                    waitms(100);
                }
            }
        }
        waitms(50);
    }
    
    // Send CMD_PROG_END to STM32
    rx_ack = IR_LoopbackPacket(CMD_PROG_END);
    waitms(100); // Give STM32 time to beep 3 times
    
    // Show confirmation
    LCDprint("Path 4 Saved!   ", 1, 1);
    if (rx_ack == CMD_PROG_END) {
        LCDprint("Path Received    ", 2, 1);
    } else {
        LCDprint("Loading...      ", 2, 1);
    }
    waitms(1500);
}

//----------------------------------
// Main Program                    |
//----------------------------------
void main(void)
{
    unsigned char cmd, rx, last_joystick;
    unsigned int  urx, ury;
    char xdata line2[17];
    unsigned char i;
    unsigned int  btn1_held, btn2_held, btn3_held;
    unsigned char entered_pass;
    unsigned char battery_percent;
    char battery_percent_carr[3]; // Battery percent as char array to send through serial
    int carr_idx; // Index to access each entry of char array
    
    InitPinADC(2, 1); // Joystick X
    InitPinADC(2, 2); // Joystick Y
    InitPinADC(1, 6); // Battery voltage
    InitADC();
    waitms(300);
    LCD_4BIT();
    
    // Initialize Timer2 for stopwatch
    Init_Timer2_1Hz();
    EA = 1; // Enable global interrupts

    // Password setup screen, occurs only once after reset
    LCDprint("Set Password:   ", 1, 1);
    LCDprint("Pass: 0000      ", 2, 1);
    waitms(1000);
    
    saved_password = Password_Entry_Screen("Set Password:   ");
    password_set = 1;
    
    // Show confirmation
    LCDprint("Password Set!   ", 1, 1);
    waitms(1000);
    
    // Analog-to-digital converter calibration screen
    for (i=0; i<30; i++) {
        urx = ADC_at_Pin(JOY_URX_CH);
        ury = ADC_at_Pin(JOY_URY_CH);
        line2[0]='X'; line2[1]='=';
        line2[2]='0'+((urx/10000)%10);
        line2[3]='0'+((urx/1000)%10);
        line2[4]='0'+((urx/100)%10);
        line2[5]='0'+((urx/10)%10);
        line2[6]='0'+(urx%10);
        line2[7]=' ';
        line2[8]='Y'; line2[9]='=';
        line2[10]='0'+((ury/10000)%10);
        line2[11]='0'+((ury/1000)%10);
        line2[12]='0'+((ury/100)%10);
        line2[13]='0'+((ury/10)%10);
        line2[14]='0'+(ury%10);
        line2[15]=' '; line2[16]=0;
        LCDprint("ADC OK-MOVE JOY ", 1, 0);
        LCDprint(line2, 2, 0);
        waitms(100);
    }

    last_joystick = Read_Joystick();
    LCDprint(">STOP          < ", 1, 0);
    Update_Status_Line();
    waitms(300);

    // Main loop
    while (1)
    {
        // Update stopwatch if in automatic mode
        if (auto_mode && timer_tick) {
            timer_tick = 0;
            stopwatch_seconds++;
            Update_Stopwatch_Display();
        }

        // Locked mode, requires password
        if (is_locked)
        {
            entered_pass = Password_Entry_Screen("LOCKED          ");
            
            // Check if password matches
            if (entered_pass == saved_password)
            {
                // Correct password
                is_locked = 0;
                LCDprint("Unlocked        ", 1, 1);
                LCDprint("Returning...    ", 2, 1);
                waitms(1000);
                LCDprint("STOP            ", 1, 0);
                Update_Status_Line();
            }
            else
            {
                // Wrong password - show error and loop back
                LCDprint("Wrong Password  ", 1, 1);
                LCDprint("Try Again       ", 2, 1);
                waitms(1000);
                // Loop continues, will show locked screen again
            }
            continue;  // Skip rest of main loop
        }
        // Normal operation
        // BTN3 behavior depends on mode
        if (auto_mode == 1)
        {
            // In automatic mode, BTN3 = PAUSE
            if (BTN3 == 0)
            {
                IR_LoopbackPacket(CMD_PAUSE);
                Show_Command(CMD_PAUSE);
                
                while (BTN3 == 0) {
                    waitms(20); 
                }
                
                IR_LoopbackPacket(CMD_RESUME);
                Show_Command(CMD_RESUME);
                waitms(200);
                Update_Status_Line();
            }
        }
        else
        {
            // In manual mode, long press BTN3 = LOCK
            if (BTN3 == 0)
            {
                waitms(20); // Debounce
                if (BTN3 == 0)
                {
                    btn3_held = 0;
                    while (BTN3 == 0 && btn3_held < 1200)
                    {
                        waitms(10);
                        btn3_held += 10;
                    }
                    
                    if (btn3_held >= BTN3_LONG_MS)
                    {
                        // Long press will lock the remote
                        is_locked = 1;
                        LCDprint("Locking...      ", 1, 1);
                        waitms(500);
                        // Loop will restart and show lock screen
                        continue;
                    }
                    
                    while (BTN3 == 0); // Wait for release
                }
            }
        }

        // BT1: Horn (short press) OR Program Mode (long press while in manual mode)
        if (BTN1 == 0)
        {
            waitms(20);  // Debounce
            if (BTN1 == 0)
            {
                // Only check for long press in manual mode
                if (auto_mode == 0)
                {
                    btn1_held = 0;
                    while (BTN1 == 0 && btn1_held < 1000)
                    {
                        waitms(10);
                        btn1_held += 10;
                    }
                    
                    if (btn1_held >= BTN1_LONG_MS)
                    {
                        // Long press in manual mode enters program mode
                        while (BTN1 == 0); // Wait for release
                        Program_Mode();
                        
                        // After programming, return to main screen
                        LCDprint("STOP            ", 1, 0);
                        Update_Status_Line();
                        waitms(100);
                    }
                    else
                    {
                        // Short press to honk the horn
                        rx = IR_LoopbackPacket(CMD_HORN);
                        Show_Command(CMD_HORN);
                        while (BTN1 == 0); // Wait for release
                        waitms(200);
                    }
                }
                else
                {
                    // In automatic mode, always horn (no long press check)
                    rx = IR_LoopbackPacket(CMD_HORN);
                    Show_Command(CMD_HORN);
                    while (BTN1 == 0); // Wait for release
                    waitms(200);
                }
            }
        }

        // BTN2: Cycle path (Short press in manual mode) OR Pause Stopwatch (Automatic mode)
        // Auto Toggle (Long press)
        else if (BTN2 == 0)
        {
            waitms(20);
            if (BTN2 == 0)
            {
                btn2_held = 0;
                while (BTN2 == 0 && btn2_held < 600) {
                    waitms(10);
                    btn2_held += 10;
                }

                if (btn2_held >= BTN2_LONG_MS)
                {
                    // If long pressed, toggle between auto and manual
                    auto_mode = !auto_mode;
                    cmd = auto_mode ? CMD_AUTO_START : CMD_AUTO_STOP;
                    rx = IR_LoopbackPacket(cmd);
                    Show_Command(cmd);

                    if (auto_mode) {
                        // Reset and start stopwatch
                        stopwatch_seconds = 0;
                        stopwatch_paused = 0;
                        Update_Stopwatch_Display();
                        waitms(100);
                    }
                }
                else
                {
                    // Short press
                    if (auto_mode == 1) {
                        // In automatic mode, pause/resume stopwatch
                        stopwatch_paused = !stopwatch_paused;
                        if (stopwatch_paused) {
                            LCDprint("Time: PAUSED    ", 1, 1);
                        } else {
                            Update_Stopwatch_Display();
                        }
                        waitms(200);
                    }
                    else {
                        // In manual mode, cycle path
                        current_path++;
                        if (current_path > 4) current_path = 1; // Cycles 1-4

                        cmd = (current_path == 1) ? CMD_PATH_1 :
                              (current_path == 2) ? CMD_PATH_2 :
                              (current_path == 3) ? CMD_PATH_3 : CMD_PATH_4;

                        rx = IR_LoopbackPacket(cmd);
                        Show_Command(cmd);
                    }
                }

                Update_Status_Line();
                while (BTN2 == 0);
            }
        }
        
        // Joystick SW: Rotate 180
        else if (JOY_SW == 0)
        {
            waitms(20);
            if (JOY_SW == 0)
            {
                rx = IR_LoopbackPacket(CMD_ROTATE_180);
                Show_Command(CMD_ROTATE_180);
                waitms(200);
                while (JOY_SW == 0);
            }
        }

        // Joystick Direction (Only update display if not in automatic mode)
        else
        {
            if (auto_mode) {
                // In automode, don't update display with joystick commands
                // Stopwatch display is updated by timer interrupt
            } else {
                // In manual mode, update display with joystick commands
                Send_Joystick_Proportional();
            }
        }
		
		// Serial data transfer (battery percentage, mode, path)
		
		battery_percent = Get_Battery_Percent();
		battery_percent_carr[0] = '0' + (battery_percent / 100) % 10;
		battery_percent_carr[1] = '0' + (battery_percent / 10) % 10;
		battery_percent_carr[2] = '0' + battery_percent % 10;
        for (carr_idx = 0; carr_idx < sizeof(battery_percent_carr) / sizeof(char); carr_idx++)
        {
            putchar(battery_percent_carr[carr_idx]);
        }

        putchar(' ');
        putchar(auto_mode + '0');

        putchar(' ');
        putchar(current_path + '0');
        
        putchar('\n');
		
        waitms(80);
    }
}
