;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Tue Mar 31 17:01:23 2026
;--------------------------------------------------------
$name tramsitterStopwatch
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _Password4BitToString_PARM_2
	public _InitPinADC_PARM_2
	public _main
	public _Timer2_ISR
	public _Print4Digit
	public _program_path
	public _IR_HalfPeriod_PARM_1
	public _LCDprint_PARM_3
	public _auto_mode
	public _timer_tick
	public _stopwatch_paused
	public _is_locked
	public _password_set
	public _LCDprint_PARM_2
	public _current_path
	public _Print4Digit_PARM_2
	public _stopwatch_secs
	public _stopwatch_minutes
	public _stopwatch_seconds
	public _program_step
	public _saved_password
	public __c51_external_startup
	public _putchar
	public _Timer3us
	public _waitms
	public _InitPinADC
	public _InitADC
	public _ADC_at_Pin
	public _Get_Battery_Percent
	public _LCD_pulse
	public _LCD_byte
	public _WriteData
	public _WriteCommand
	public _LCD_4BIT
	public _LCDprint
	public _IR_HalfPeriod
	public _IR_LoopbackByte
	public _IR_LoopbackPacket
	public _Update_Status_Line
	public _Read_Joystick
	public _Cmd_Label
	public _Direction_Label
	public _Show_Command
	public _Send_Joystick_Proportional
	public _Password4BitToString
	public _Password_Entry_Screen
	public _Init_Timer2_1Hz
	public _Update_Stopwatch_Display
	public _Program_Mode
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_saved_password:
	ds 1
_program_step:
	ds 1
_stopwatch_seconds:
	ds 2
_stopwatch_minutes:
	ds 1
_stopwatch_secs:
	ds 1
_Print4Digit_PARM_2:
	ds 2
_current_path:
	ds 1
_LCDprint_PARM_2:
	ds 1
_Update_Status_Line_s_1_110:
	ds 17
_Send_Joystick_Proportional_lb_1_125:
	ds 1
_Send_Joystick_Proportional_percent_1_125:
	ds 1
_Send_Joystick_Proportional_sloc0_1_0:
	ds 2
_Password_Entry_Screen_pass_str_1_138:
	ds 5
_Timer2_ISR_tick_count_1_149:
	ds 1
_main_i_1_176:
	ds 1
_main_battery_percent_carr_1_176:
	ds 3
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_Password4BitToString_PARM_2:
	ds 3
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_password_set:
	DBIT	1
_is_locked:
	DBIT	1
_stopwatch_paused:
	DBIT	1
_timer_tick:
	DBIT	1
_auto_mode:
	DBIT	1
_LCDprint_PARM_3:
	DBIT	1
_IR_HalfPeriod_PARM_1:
	DBIT	1
_IR_LoopbackByte_is_space_1_105:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
_program_path:
	ds 8
_Show_Command_line_1_120:
	ds 17
_Send_Joystick_Proportional_disp_1_125:
	ds 17
_Password_Entry_Screen_line2_1_138:
	ds 17
_Update_Stopwatch_Display_line_1_153:
	ds 17
_Program_Mode_line1_1_157:
	ds 17
_Program_Mode_line2_1_157:
	ds 17
_main_line2_1_176:
	ds 17
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x002b
	ljmp	_Timer2_ISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;tick_count                Allocated with name '_Timer2_ISR_tick_count_1_149'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:659: static unsigned char tick_count = 0;
	mov	_Timer2_ISR_tick_count_1_149,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:89: unsigned char saved_password = 0;      // 4-bit password (0000-1111)
	mov	_saved_password,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:97: unsigned char program_step = 0;       // Keep in DATA (single byte)
	mov	_program_step,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:102: unsigned int  stopwatch_seconds = 0;  // Total seconds elapsed
	clr	a
	mov	_stopwatch_seconds,a
	mov	(_stopwatch_seconds + 1),a
;	C:\Vincent\source\tramsitterStopwatch.c:103: unsigned char stopwatch_minutes = 0;  // Minutes (derived from seconds)
	mov	_stopwatch_minutes,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:104: unsigned char stopwatch_secs    = 0;  // Seconds within minute (0-59)
	mov	_stopwatch_secs,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:148: unsigned char current_path = 1;
	mov	_current_path,#0x01
;	C:\Vincent\source\tramsitterStopwatch.c:90: bit           password_set = 0;        // Has password been set?
	clr	_password_set
;	C:\Vincent\source\tramsitterStopwatch.c:91: bit           is_locked = 0;           // Is remote currently locked?
	clr	_is_locked
;	C:\Vincent\source\tramsitterStopwatch.c:105: bit           stopwatch_paused  = 0;  // Is stopwatch paused?
	clr	_stopwatch_paused
;	C:\Vincent\source\tramsitterStopwatch.c:106: bit           timer_tick        = 0;  // Set by Timer2 ISR every ~1 second
	clr	_timer_tick
;	C:\Vincent\source\tramsitterStopwatch.c:149: bit           auto_mode    = 0;
	clr	_auto_mode
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'Print4Digit'
;------------------------------------------------------------
;val                       Allocated with name '_Print4Digit_PARM_2'
;str                       Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:109: void Print4Digit(char *str, unsigned int val) {
;	-----------------------------------------
;	 function Print4Digit
;	-----------------------------------------
_Print4Digit:
	using	0
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Vincent\source\tramsitterStopwatch.c:110: str[0] = (val / 1000) % 10 + '0';
	mov	__divuint_PARM_2,#0xE8
	mov	(__divuint_PARM_2 + 1),#0x03
	mov	dpl,_Print4Digit_PARM_2
	mov	dph,(_Print4Digit_PARM_2 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__divuint
	mov	r5,dpl
	mov	r6,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r5
	mov	dph,r6
	lcall	__moduint
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,#0x30
	add	a,r5
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrput
;	C:\Vincent\source\tramsitterStopwatch.c:111: str[1] = (val / 100) % 10 + '0';
	mov	a,#0x01
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	__divuint_PARM_2,#0x64
	clr	a
	mov	(__divuint_PARM_2 + 1),a
	mov	dpl,_Print4Digit_PARM_2
	mov	dph,(_Print4Digit_PARM_2 + 1)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	__divuint
	mov	r0,dpl
	mov	r1,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r0
	mov	dph,r1
	lcall	__moduint
	mov	r0,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,#0x30
	add	a,r0
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrput
;	C:\Vincent\source\tramsitterStopwatch.c:112: str[2] = (val / 10) % 10 + '0';
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	__divuint_PARM_2,#0x0A
	clr	a
	mov	(__divuint_PARM_2 + 1),a
	mov	dpl,_Print4Digit_PARM_2
	mov	dph,(_Print4Digit_PARM_2 + 1)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	__divuint
	mov	r0,dpl
	mov	r1,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r0
	mov	dph,r1
	lcall	__moduint
	mov	r0,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,#0x30
	add	a,r0
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrput
;	C:\Vincent\source\tramsitterStopwatch.c:113: str[3] = (val % 10) + '0';
	mov	a,#0x03
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,_Print4Digit_PARM_2
	mov	dph,(_Print4Digit_PARM_2 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__moduint
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,#0x30
	add	a,r5
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ljmp	__gptrput
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:151: char _c51_external_startup(void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	C:\Vincent\source\tramsitterStopwatch.c:153: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:154: WDTCN = 0xDE;
	mov	_WDTCN,#0xDE
;	C:\Vincent\source\tramsitterStopwatch.c:155: WDTCN = 0xAD;
	mov	_WDTCN,#0xAD
;	C:\Vincent\source\tramsitterStopwatch.c:156: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:157: RSTSRC  = 0x02;
	mov	_RSTSRC,#0x02
;	C:\Vincent\source\tramsitterStopwatch.c:158: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Vincent\source\tramsitterStopwatch.c:159: PFE0CN  = 0x20;
	mov	_PFE0CN,#0x20
;	C:\Vincent\source\tramsitterStopwatch.c:160: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:161: CLKSEL = 0x00; CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
	mov	_CLKSEL,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:162: while ((CLKSEL & 0x80) == 0);
L003001?:
	mov	a,_CLKSEL
	jnb	acc.7,L003001?
;	C:\Vincent\source\tramsitterStopwatch.c:163: CLKSEL = 0x03; CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
	mov	_CLKSEL,#0x03
;	C:\Vincent\source\tramsitterStopwatch.c:164: while ((CLKSEL & 0x80) == 0);
L003004?:
	mov	a,_CLKSEL
	jnb	acc.7,L003004?
;	C:\Vincent\source\tramsitterStopwatch.c:166: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Vincent\source\tramsitterStopwatch.c:167: P1MDOUT |= 0x9F;
	orl	_P1MDOUT,#0x9F
;	C:\Vincent\source\tramsitterStopwatch.c:168: P2MDOUT |= 0x01;
	orl	_P2MDOUT,#0x01
;	C:\Vincent\source\tramsitterStopwatch.c:170: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Vincent\source\tramsitterStopwatch.c:171: P2MDIN &= ~0x06;
	anl	_P2MDIN,#0xF9
;	C:\Vincent\source\tramsitterStopwatch.c:172: P2SKIP  |=  0x06;
	orl	_P2SKIP,#0x06
;	C:\Vincent\source\tramsitterStopwatch.c:173: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:175: XBR0 = 0x01; // 0x00 to 0x01, to enable UART0 on P0.4(TX) and P0.5(RX)   
	mov	_XBR0,#0x01
;	C:\Vincent\source\tramsitterStopwatch.c:176: XBR1 = 0x00;
	mov	_XBR1,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:177: XBR2 = 0x41; // 0x40 to 0x41, to enable uart 1
	mov	_XBR2,#0x41
;	C:\Vincent\source\tramsitterStopwatch.c:183: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Vincent\source\tramsitterStopwatch.c:184: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Vincent\source\tramsitterStopwatch.c:185: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Vincent\source\tramsitterStopwatch.c:186: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Vincent\source\tramsitterStopwatch.c:187: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Vincent\source\tramsitterStopwatch.c:188: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Vincent\source\tramsitterStopwatch.c:189: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Vincent\source\tramsitterStopwatch.c:191: IR_TX   = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:192: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putchar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:195: void putchar (char c) 
;	-----------------------------------------
;	 function putchar
;	-----------------------------------------
_putchar:
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:197: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Vincent\source\tramsitterStopwatch.c:198: if (c == '\n') 
	cjne	r2,#0x0A,L004006?
;	C:\Vincent\source\tramsitterStopwatch.c:200: while (!TI);
L004001?:
;	C:\Vincent\source\tramsitterStopwatch.c:201: TI=0;
	jbc	_TI,L004017?
	sjmp	L004001?
L004017?:
;	C:\Vincent\source\tramsitterStopwatch.c:202: SBUF0 = '\r';
	mov	_SBUF0,#0x0D
;	C:\Vincent\source\tramsitterStopwatch.c:204: while (!TI);
L004006?:
;	C:\Vincent\source\tramsitterStopwatch.c:205: TI=0;
	jbc	_TI,L004018?
	sjmp	L004006?
L004018?:
;	C:\Vincent\source\tramsitterStopwatch.c:206: SBUF0 = c;
	mov	_SBUF0,r2
;	C:\Vincent\source\tramsitterStopwatch.c:207: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:211: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:214: CKCON0 |= 0x40;
	orl	_CKCON0,#0x40
;	C:\Vincent\source\tramsitterStopwatch.c:215: TMR3RL  = (-(SYSCLK) / 1000000L);
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Vincent\source\tramsitterStopwatch.c:216: TMR3    = TMR3RL;
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Vincent\source\tramsitterStopwatch.c:217: TMR3CN0 = 0x04;
	mov	_TMR3CN0,#0x04
;	C:\Vincent\source\tramsitterStopwatch.c:218: for (i = 0; i < us; i++) {
	mov	r3,#0x00
L005004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L005007?
;	C:\Vincent\source\tramsitterStopwatch.c:219: while (!(TMR3CN0 & 0x80));
L005001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L005001?
;	C:\Vincent\source\tramsitterStopwatch.c:220: TMR3CN0 &= ~0x80;
	anl	_TMR3CN0,#0x7F
;	C:\Vincent\source\tramsitterStopwatch.c:218: for (i = 0; i < us; i++) {
	inc	r3
	sjmp	L005004?
L005007?:
;	C:\Vincent\source\tramsitterStopwatch.c:222: TMR3CN0 = 0;
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;k                         Allocated to registers r6 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:225: void waitms(unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Vincent\source\tramsitterStopwatch.c:229: for (j = 0; j < ms; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L006005?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L006009?
;	C:\Vincent\source\tramsitterStopwatch.c:230: for (k = 0; k < 4; k++) Timer3us(250);
	mov	r6,#0x00
L006001?:
	cjne	r6,#0x04,L006018?
L006018?:
	jnc	L006007?
	mov	dpl,#0xFA
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_Timer3us
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r6
	sjmp	L006001?
L006007?:
;	C:\Vincent\source\tramsitterStopwatch.c:229: for (j = 0; j < ms; j++)
	inc	r4
	cjne	r4,#0x00,L006005?
	inc	r5
	sjmp	L006005?
L006009?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pin_num                   Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:233: void InitPinADC(unsigned char portno, unsigned char pin_num)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:235: unsigned char mask = 1 << pin_num;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L007013?
L007011?:
	add	a,acc
L007013?:
	djnz	b,L007011?
	mov	r3,a
;	C:\Vincent\source\tramsitterStopwatch.c:236: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Vincent\source\tramsitterStopwatch.c:237: switch (portno) {
	cjne	r2,#0x00,L007014?
	sjmp	L007001?
L007014?:
	cjne	r2,#0x01,L007015?
	sjmp	L007002?
L007015?:
;	C:\Vincent\source\tramsitterStopwatch.c:238: case 0: P0MDIN &= ~mask; P0SKIP |= mask; break;
	cjne	r2,#0x02,L007005?
	sjmp	L007003?
L007001?:
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P0MDIN,a
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Vincent\source\tramsitterStopwatch.c:239: case 1: P1MDIN &= ~mask; P1SKIP |= mask; break;
	sjmp	L007005?
L007002?:
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P1MDIN,a
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Vincent\source\tramsitterStopwatch.c:240: case 2: P2MDIN &= ~mask; P2SKIP |= mask; break;
	sjmp	L007005?
L007003?:
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P2MDIN,a
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Vincent\source\tramsitterStopwatch.c:242: }
L007005?:
;	C:\Vincent\source\tramsitterStopwatch.c:243: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:246: void InitADC(void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Vincent\source\tramsitterStopwatch.c:248: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:249: ADEN = 0;
	clr	_ADEN
;	C:\Vincent\source\tramsitterStopwatch.c:250: ADC0CN1 = (0x2 << 6) | (0x0 << 3) | (0x0 << 0);
	mov	_ADC0CN1,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:251: ADC0CF0 = ((SYSCLK / SARCLK) << 3) | (0x0 << 2);
	mov	_ADC0CF0,#0x20
;	C:\Vincent\source\tramsitterStopwatch.c:252: ADC0CF1 = (0 << 7) | (0x1E << 0);
	mov	_ADC0CF1,#0x1E
;	C:\Vincent\source\tramsitterStopwatch.c:253: ADC0CN0 = 0x00;
	mov	_ADC0CN0,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:254: ADC0CF2 = (0x0 << 7) | (0x1 << 5) | (0x1F << 0);
	mov	_ADC0CF2,#0x3F
;	C:\Vincent\source\tramsitterStopwatch.c:255: ADC0CN2 = 0x00;
	mov	_ADC0CN2,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:256: ADEN = 1;
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:259: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:262: ADINT  = 0;
	clr	_ADINT
;	C:\Vincent\source\tramsitterStopwatch.c:263: ADBUSY = 1;     
	setb	_ADBUSY
;	C:\Vincent\source\tramsitterStopwatch.c:264: while (!ADINT); // Wait for first conversion (throw-away)
L009001?:
;	C:\Vincent\source\tramsitterStopwatch.c:266: ADINT  = 0;
	jbc	_ADINT,L009013?
	sjmp	L009001?
L009013?:
;	C:\Vincent\source\tramsitterStopwatch.c:267: ADBUSY = 1;     
	setb	_ADBUSY
;	C:\Vincent\source\tramsitterStopwatch.c:268: while (!ADINT); // Wait for second conversion (actual value)
L009004?:
	jnb	_ADINT,L009004?
;	C:\Vincent\source\tramsitterStopwatch.c:269: return ADC0;
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Get_Battery_Percent'
;------------------------------------------------------------
;batt_adc                  Allocated to registers r2 r3 
;pin_mv                    Allocated to registers 
;V_battery_mv              Allocated to registers r2 r3 r4 r5 
;battery_percent           Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:272: unsigned char Get_Battery_Percent(void)
;	-----------------------------------------
;	 function Get_Battery_Percent
;	-----------------------------------------
_Get_Battery_Percent:
;	C:\Vincent\source\tramsitterStopwatch.c:280: ADC_at_Pin(BATT_CH);
	mov	dpl,#0x0C
	lcall	_ADC_at_Pin
;	C:\Vincent\source\tramsitterStopwatch.c:281: batt_adc = ADC_at_Pin(BATT_CH);
	mov	dpl,#0x0C
	lcall	_ADC_at_Pin
	mov	r2,dpl
	mov	r3,dph
;	C:\Vincent\source\tramsitterStopwatch.c:283: if (batt_adc == 0) return 0;
	mov	a,r2
	orl	a,r3
	jnz	L010002?
	mov	dpl,a
	ret
L010002?:
;	C:\Vincent\source\tramsitterStopwatch.c:286: pin_mv = ((unsigned long)batt_adc * 1700UL) / 8191UL;
	mov	__mullong_PARM_2,r2
	mov	(__mullong_PARM_2 + 1),r3
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
	mov	dptr,#0x06A4
	clr	a
	mov	b,a
	lcall	__mullong
	mov	__divulong_PARM_2,#0xFF
	mov	(__divulong_PARM_2 + 1),#0x1F
	mov	(__divulong_PARM_2 + 2),#0x00
	mov	(__divulong_PARM_2 + 3),#0x00
	lcall	__divulong
	mov	__mullong_PARM_2,dpl
	mov	(__mullong_PARM_2 + 1),dph
	mov	(__mullong_PARM_2 + 2),b
	mov	(__mullong_PARM_2 + 3),a
;	C:\Vincent\source\tramsitterStopwatch.c:289: V_battery_mv = pin_mv * 11UL;
	mov	dptr,#(0x0B&0x00ff)
	clr	a
	mov	b,a
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Vincent\source\tramsitterStopwatch.c:292: if (V_battery_mv >= 9000UL) return 100;
	clr	c
	mov	a,r2
	subb	a,#0x28
	mov	a,r3
	subb	a,#0x23
	mov	a,r4
	subb	a,#0x00
	mov	a,r5
	subb	a,#0x00
	jc	L010004?
	mov	dpl,#0x64
	ret
L010004?:
;	C:\Vincent\source\tramsitterStopwatch.c:293: if (V_battery_mv <= 5000UL) return 0;
	clr	c
	mov	a,#0x88
	subb	a,r2
	mov	a,#0x13
	subb	a,r3
	clr	a
	subb	a,r4
	clr	a
	subb	a,r5
	jc	L010006?
	mov	dpl,#0x00
	ret
L010006?:
;	C:\Vincent\source\tramsitterStopwatch.c:296: battery_percent = ((V_battery_mv - 5000UL) * 100UL) / 4000UL;
	mov	a,r2
	add	a,#0x78
	mov	__mullong_PARM_2,a
	mov	a,r3
	addc	a,#0xec
	mov	(__mullong_PARM_2 + 1),a
	mov	a,r4
	addc	a,#0xff
	mov	(__mullong_PARM_2 + 2),a
	mov	a,r5
	addc	a,#0xff
	mov	(__mullong_PARM_2 + 3),a
	mov	dptr,#(0x64&0x00ff)
	clr	a
	mov	b,a
	lcall	__mullong
	mov	__divulong_PARM_2,#0xA0
	mov	(__divulong_PARM_2 + 1),#0x0F
	mov	(__divulong_PARM_2 + 2),#0x00
	mov	(__divulong_PARM_2 + 3),#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:298: return (unsigned char)battery_percent;
	ljmp	__divulong
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:301: void LCD_pulse(void) { LCD_E=1; Timer3us(40); LCD_E=0; }
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
	setb	_P2_0
	mov	dpl,#0x28
	lcall	_Timer3us
	clr	_P2_0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:303: void LCD_byte(unsigned char x)
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:305: ACC=x;
	mov	_ACC,r2
;	C:\Vincent\source\tramsitterStopwatch.c:306: LCD_D7=ACC_7; LCD_D6=ACC_6; LCD_D5=ACC_5; LCD_D4=ACC_4;
	mov	c,_ACC_7
	mov	_P1_0,c
	mov	c,_ACC_6
	mov	_P1_1,c
	mov	c,_ACC_5
	mov	_P1_2,c
	mov	c,_ACC_4
	mov	_P1_3,c
;	C:\Vincent\source\tramsitterStopwatch.c:307: LCD_pulse(); Timer3us(40);
	push	ar2
	lcall	_LCD_pulse
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:308: ACC=x;
	mov	_ACC,r2
;	C:\Vincent\source\tramsitterStopwatch.c:309: LCD_D7=ACC_3; LCD_D6=ACC_2; LCD_D5=ACC_1; LCD_D4=ACC_0;
	mov	c,_ACC_3
	mov	_P1_0,c
	mov	c,_ACC_2
	mov	_P1_1,c
	mov	c,_ACC_1
	mov	_P1_2,c
	mov	c,_ACC_0
	mov	_P1_3,c
;	C:\Vincent\source\tramsitterStopwatch.c:310: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:313: void WriteData(unsigned char x)    { LCD_RS=1; LCD_byte(x); waitms(2); }
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	setb	_P1_7
	lcall	_LCD_byte
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:314: void WriteCommand(unsigned char x) { LCD_RS=0; LCD_byte(x); waitms(5); }
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	clr	_P1_7
	lcall	_LCD_byte
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:316: void LCD_4BIT(void)
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\Vincent\source\tramsitterStopwatch.c:318: LCD_E=0; waitms(20);
	clr	_P2_0
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:319: WriteCommand(0x33); WriteCommand(0x33); WriteCommand(0x32);
	mov	dpl,#0x33
	lcall	_WriteCommand
	mov	dpl,#0x33
	lcall	_WriteCommand
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\Vincent\source\tramsitterStopwatch.c:320: WriteCommand(0x28); WriteCommand(0x0C); WriteCommand(0x01);
	mov	dpl,#0x28
	lcall	_WriteCommand
	mov	dpl,#0x0C
	lcall	_WriteCommand
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Vincent\source\tramsitterStopwatch.c:321: waitms(20);
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;s                         Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:324: void LCDprint(char *s, unsigned char line, bit clear)
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Vincent\source\tramsitterStopwatch.c:327: WriteCommand(line==2 ? 0xC0 : 0x80);
	mov	a,#0x02
	cjne	a,_LCDprint_PARM_2,L016013?
	mov	r5,#0xC0
	sjmp	L016014?
L016013?:
	mov	r5,#0x80
L016014?:
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\Vincent\source\tramsitterStopwatch.c:328: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:329: for (j=0; s[j]!=0; j++) WriteData(s[j]);
	mov	r5,#0x00
	mov	r6,#0x00
L016003?:
	mov	a,r5
	add	a,r2
	mov	r7,a
	mov	a,r6
	addc	a,r3
	mov	r0,a
	mov	ar1,r4
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	jz	L016006?
	mov	dpl,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_WriteData
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	cjne	r5,#0x00,L016003?
	inc	r6
	sjmp	L016003?
L016006?:
;	C:\Vincent\source\tramsitterStopwatch.c:330: if (clear) for (; j<CHARS_PER_LINE; j++) WriteData(' ');
	jnb	_LCDprint_PARM_3,L016011?
	mov	ar2,r5
	mov	ar3,r6
L016007?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L016011?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L016007?
	inc	r3
	sjmp	L016007?
L016011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'IR_HalfPeriod'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:333: void IR_HalfPeriod(bit is_space)
;	-----------------------------------------
;	 function IR_HalfPeriod
;	-----------------------------------------
_IR_HalfPeriod:
;	C:\Vincent\source\tramsitterStopwatch.c:335: if (is_space) IR_TX ^= 1;
	jnb	_IR_HalfPeriod_PARM_1,L017002?
	cpl	_P1_4
	sjmp	L017003?
L017002?:
;	C:\Vincent\source\tramsitterStopwatch.c:336: else          IR_TX  = 0;
	clr	_P1_4
L017003?:
;	C:\Vincent\source\tramsitterStopwatch.c:337: Timer3us(IR_HALF_US);
	mov	dpl,#0x0D
	ljmp	_Timer3us
;------------------------------------------------------------
;Allocation info for local variables in function 'IR_LoopbackByte'
;------------------------------------------------------------
;tx_byte                   Allocated to registers r2 
;rx_byte                   Allocated to registers r3 
;i                         Allocated to registers r4 
;h                         Allocated to registers r4 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:340: unsigned char IR_LoopbackByte(unsigned char tx_byte)
;	-----------------------------------------
;	 function IR_LoopbackByte
;	-----------------------------------------
_IR_LoopbackByte:
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:342: unsigned char rx_byte = 0;
	mov	r3,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:346: for (h=0; h<IR_HALF_FULL; h++) IR_HalfPeriod(1);
	mov	r4,#0x00
L018003?:
	cjne	r4,#0x20,L018041?
L018041?:
	jnc	L018006?
	setb	_IR_HalfPeriod_PARM_1
	push	ar2
	push	ar3
	push	ar4
	lcall	_IR_HalfPeriod
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r4
	sjmp	L018003?
L018006?:
;	C:\Vincent\source\tramsitterStopwatch.c:347: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:349: for (i=0; i<8; i++)
	mov	r4,#0x00
L018015?:
	cjne	r4,#0x08,L018043?
L018043?:
	jnc	L018018?
;	C:\Vincent\source\tramsitterStopwatch.c:351: is_space = ((tx_byte & 0x01) == 0) ? 1 : 0;
	mov	a,#0x01
	anl	a,r2
	mov	r5,a
	cjne	a,#0x01,L018045?
L018045?:
	mov	_IR_LoopbackByte_is_space_1_105,c
;	C:\Vincent\source\tramsitterStopwatch.c:352: tx_byte >>= 1;
	mov	a,r2
	clr	c
	rrc	a
	mov	r2,a
;	C:\Vincent\source\tramsitterStopwatch.c:353: rx_byte >>= 1;
	mov	a,r3
	clr	c
	rrc	a
	mov	r3,a
;	C:\Vincent\source\tramsitterStopwatch.c:355: for (h=0; h<IR_HALF_MID; h++) IR_HalfPeriod(is_space);
	mov	r5,#0x00
L018007?:
	cjne	r5,#0x10,L018046?
L018046?:
	jnc	L018010?
	mov	c,_IR_LoopbackByte_is_space_1_105
	mov	_IR_HalfPeriod_PARM_1,c
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_IR_HalfPeriod
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	sjmp	L018007?
L018010?:
;	C:\Vincent\source\tramsitterStopwatch.c:356: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:357: if (IR_RX == 1) rx_byte |= 0x80;
	jnb	_P1_5,L018032?
	orl	ar3,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:359: for (h=0; h<IR_HALF_MID; h++) IR_HalfPeriod(is_space);
L018032?:
	mov	r5,#0x00
L018011?:
	cjne	r5,#0x10,L018049?
L018049?:
	jnc	L018014?
	mov	c,_IR_LoopbackByte_is_space_1_105
	mov	_IR_HalfPeriod_PARM_1,c
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_IR_HalfPeriod
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	sjmp	L018011?
L018014?:
;	C:\Vincent\source\tramsitterStopwatch.c:360: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:349: for (i=0; i<8; i++)
	inc	r4
	sjmp	L018015?
L018018?:
;	C:\Vincent\source\tramsitterStopwatch.c:363: for (h=0; h<IR_HALF_FULL; h++) IR_HalfPeriod(0);
	mov	r2,#0x00
L018019?:
	cjne	r2,#0x20,L018051?
L018051?:
	jnc	L018022?
	clr	_IR_HalfPeriod_PARM_1
	push	ar2
	push	ar3
	lcall	_IR_HalfPeriod
	pop	ar3
	pop	ar2
	inc	r2
	sjmp	L018019?
L018022?:
;	C:\Vincent\source\tramsitterStopwatch.c:364: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:366: return rx_byte;
	mov	dpl,r3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'IR_LoopbackPacket'
;------------------------------------------------------------
;cmd                       Allocated to registers r2 
;rx_cmd                    Allocated to registers r4 
;rx_chk                    Allocated to registers r5 
;expected_chk              Allocated to registers r3 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:369: unsigned char IR_LoopbackPacket(unsigned char cmd)
;	-----------------------------------------
;	 function IR_LoopbackPacket
;	-----------------------------------------
_IR_LoopbackPacket:
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:372: unsigned char expected_chk = (unsigned char)(0xFF - cmd);
	mov	a,#0xFF
	clr	c
	subb	a,r2
	mov	r3,a
;	C:\Vincent\source\tramsitterStopwatch.c:373: rx_cmd = IR_LoopbackByte(cmd);
	mov	dpl,r2
	push	ar2
	push	ar3
	lcall	_IR_LoopbackByte
	mov	r4,dpl
	pop	ar3
;	C:\Vincent\source\tramsitterStopwatch.c:374: rx_chk = IR_LoopbackByte(expected_chk);
	mov	dpl,r3
	push	ar3
	push	ar4
	lcall	_IR_LoopbackByte
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:375: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:376: if (rx_cmd == cmd && rx_chk == expected_chk) return rx_cmd;
	mov	a,r4
	cjne	a,ar2,L019002?
	mov	a,r5
	cjne	a,ar3,L019002?
	mov	dpl,r4
;	C:\Vincent\source\tramsitterStopwatch.c:377: return CMD_NONE;
	ret
L019002?:
	mov	dpl,#0xFF
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Update_Status_Line'
;------------------------------------------------------------
;s                         Allocated with name '_Update_Status_Line_s_1_110'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:380: void Update_Status_Line(void)
;	-----------------------------------------
;	 function Update_Status_Line
;	-----------------------------------------
_Update_Status_Line:
;	C:\Vincent\source\tramsitterStopwatch.c:383: if (auto_mode) strncpy(s, "AUTO   || ", 10);
	jnb	_auto_mode,L020002?
	mov	_strncpy_PARM_2,#__str_0
	mov	(_strncpy_PARM_2 + 1),#(__str_0 >> 8)
	mov	(_strncpy_PARM_2 + 2),#0x80
	mov	_strncpy_PARM_3,#0x0A
	clr	a
	mov	(_strncpy_PARM_3 + 1),a
	mov	dptr,#_Update_Status_Line_s_1_110
	mov	b,#0x40
	lcall	_strncpy
	sjmp	L020003?
L020002?:
;	C:\Vincent\source\tramsitterStopwatch.c:384: else           strncpy(s, "MANUAL || ", 10);
	mov	_strncpy_PARM_2,#__str_1
	mov	(_strncpy_PARM_2 + 1),#(__str_1 >> 8)
	mov	(_strncpy_PARM_2 + 2),#0x80
	mov	_strncpy_PARM_3,#0x0A
	clr	a
	mov	(_strncpy_PARM_3 + 1),a
	mov	dptr,#_Update_Status_Line_s_1_110
	mov	b,#0x40
	lcall	_strncpy
L020003?:
;	C:\Vincent\source\tramsitterStopwatch.c:385: s[10]='P'; s[11]='A'; s[12]='T'; s[13]='H'; s[14]=':';
	mov	(_Update_Status_Line_s_1_110 + 0x000a),#0x50
	mov	(_Update_Status_Line_s_1_110 + 0x000b),#0x41
	mov	(_Update_Status_Line_s_1_110 + 0x000c),#0x54
	mov	(_Update_Status_Line_s_1_110 + 0x000d),#0x48
	mov	(_Update_Status_Line_s_1_110 + 0x000e),#0x3A
;	C:\Vincent\source\tramsitterStopwatch.c:386: s[15]='0'+current_path;
	mov	a,#0x30
	add	a,_current_path
	mov	(_Update_Status_Line_s_1_110 + 0x000f),a
;	C:\Vincent\source\tramsitterStopwatch.c:387: s[16]=0;
	mov	(_Update_Status_Line_s_1_110 + 0x0010),#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:388: LCDprint(s, 2, 0);
	mov	_LCDprint_PARM_2,#0x02
	clr	_LCDprint_PARM_3
	mov	dptr,#_Update_Status_Line_s_1_110
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'Read_Joystick'
;------------------------------------------------------------
;urx                       Allocated to registers r2 r3 
;ury                       Allocated to registers r4 r5 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:391: unsigned char Read_Joystick(void)
;	-----------------------------------------
;	 function Read_Joystick
;	-----------------------------------------
_Read_Joystick:
;	C:\Vincent\source\tramsitterStopwatch.c:393: unsigned int urx = ADC_at_Pin(JOY_URX_CH);
	mov	dpl,#0x0E
	lcall	_ADC_at_Pin
	mov	r2,dpl
	mov	r3,dph
;	C:\Vincent\source\tramsitterStopwatch.c:394: unsigned int ury = ADC_at_Pin(JOY_URY_CH);
	mov	dpl,#0x0F
	push	ar2
	push	ar3
	lcall	_ADC_at_Pin
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:395: if      (urx > JOY_HIGH) return CMD_RIGHT;
	clr	c
	mov	a,#0x28
	subb	a,r2
	mov	a,#0x23
	subb	a,r3
	jnc	L021011?
	mov	dpl,#0x05
	ret
L021011?:
;	C:\Vincent\source\tramsitterStopwatch.c:396: else if (urx < JOY_LOW)  return CMD_LEFT;
	clr	c
	mov	a,r2
	subb	a,#0xB8
	mov	a,r3
	subb	a,#0x0B
	jnc	L021008?
	mov	dpl,#0x04
	ret
L021008?:
;	C:\Vincent\source\tramsitterStopwatch.c:397: else if (ury < JOY_LOW)  return CMD_FORWARD;
	clr	c
	mov	a,r4
	subb	a,#0xB8
	mov	a,r5
	subb	a,#0x0B
	jnc	L021005?
	mov	dpl,#0x02
	ret
L021005?:
;	C:\Vincent\source\tramsitterStopwatch.c:398: else if (ury > JOY_HIGH) return CMD_BACKWARD;
	clr	c
	mov	a,#0x28
	subb	a,r4
	mov	a,#0x23
	subb	a,r5
	jnc	L021002?
	mov	dpl,#0x03
;	C:\Vincent\source\tramsitterStopwatch.c:399: else                     return CMD_STOP;
	ret
L021002?:
	mov	dpl,#0x01
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Cmd_Label'
;------------------------------------------------------------
;cmd                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:403: const char *Cmd_Label(unsigned char cmd)
;	-----------------------------------------
;	 function Cmd_Label
;	-----------------------------------------
_Cmd_Label:
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:405: switch (cmd) {
	cjne	r2,#0x01,L022035?
	sjmp	L022001?
L022035?:
	cjne	r2,#0x02,L022036?
	sjmp	L022002?
L022036?:
	cjne	r2,#0x03,L022037?
	sjmp	L022003?
L022037?:
	cjne	r2,#0x04,L022038?
	sjmp	L022004?
L022038?:
	cjne	r2,#0x05,L022039?
	sjmp	L022005?
L022039?:
	cjne	r2,#0x06,L022040?
	sjmp	L022006?
L022040?:
	cjne	r2,#0x10,L022041?
	sjmp	L022007?
L022041?:
	cjne	r2,#0x11,L022042?
	ljmp	L022008?
L022042?:
	cjne	r2,#0x12,L022043?
	ljmp	L022009?
L022043?:
	cjne	r2,#0x13,L022044?
	ljmp	L022010?
L022044?:
	cjne	r2,#0x20,L022045?
	ljmp	L022015?
L022045?:
	cjne	r2,#0x30,L022046?
	ljmp	L022011?
L022046?:
	cjne	r2,#0x31,L022047?
	ljmp	L022012?
L022047?:
	cjne	r2,#0x40,L022048?
	ljmp	L022013?
L022048?:
	cjne	r2,#0x41,L022049?
	ljmp	L022014?
L022049?:
	ljmp	L022016?
;	C:\Vincent\source\tramsitterStopwatch.c:406: case CMD_STOP:       return "STOP    ";
L022001?:
	mov	dptr,#__str_2
	mov	b,#0x80
	ret
;	C:\Vincent\source\tramsitterStopwatch.c:407: case CMD_FORWARD:    return "FORWARD  ";
L022002?:
	mov	dptr,#__str_3
	mov	b,#0x80
	ret
;	C:\Vincent\source\tramsitterStopwatch.c:408: case CMD_BACKWARD:   return "BACKWARD ";
L022003?:
	mov	dptr,#__str_4
	mov	b,#0x80
	ret
;	C:\Vincent\source\tramsitterStopwatch.c:409: case CMD_LEFT:       return "LEFT     ";
L022004?:
	mov	dptr,#__str_5
	mov	b,#0x80
	ret
;	C:\Vincent\source\tramsitterStopwatch.c:410: case CMD_RIGHT:      return "RIGHT    ";
L022005?:
	mov	dptr,#__str_6
	mov	b,#0x80
	ret
;	C:\Vincent\source\tramsitterStopwatch.c:411: case CMD_ROTATE_180: return "ROT 180  ";
L022006?:
	mov	dptr,#__str_7
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:412: case CMD_PATH_1:     return "PATH  1  ";
	ret
L022007?:
	mov	dptr,#__str_8
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:413: case CMD_PATH_2:     return "PATH  2  ";
	ret
L022008?:
	mov	dptr,#__str_9
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:414: case CMD_PATH_3:     return "PATH  3  ";
	ret
L022009?:
	mov	dptr,#__str_10
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:415: case CMD_PATH_4:     return "PATH  4  ";  // NEW
	ret
L022010?:
	mov	dptr,#__str_11
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:416: case CMD_AUTO_START: return "AUTO  ON ";
	ret
L022011?:
	mov	dptr,#__str_12
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:417: case CMD_AUTO_STOP:  return "AUTO OFF ";
	ret
L022012?:
	mov	dptr,#__str_13
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:418: case CMD_PAUSE:      return "PAUSED   ";
	ret
L022013?:
	mov	dptr,#__str_14
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:419: case CMD_RESUME:     return "RESUMING ";
	ret
L022014?:
	mov	dptr,#__str_15
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:420: case CMD_HORN:       return "HORN!!   ";
	ret
L022015?:
	mov	dptr,#__str_16
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:421: default:             return "???      ";
	ret
L022016?:
	mov	dptr,#__str_17
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:422: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Direction_Label'
;------------------------------------------------------------
;dir                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:426: const char *Direction_Label(unsigned char dir)
;	-----------------------------------------
;	 function Direction_Label
;	-----------------------------------------
_Direction_Label:
;	C:\Vincent\source\tramsitterStopwatch.c:428: switch (dir) {
	mov	a,dpl
	mov	r2,a
	add	a,#0xff - 0x03
	jc	L023005?
	mov	a,r2
	add	a,r2
	add	a,r2
	mov	dptr,#L023011?
	jmp	@a+dptr
L023011?:
	ljmp	L023001?
	ljmp	L023002?
	ljmp	L023003?
	ljmp	L023004?
;	C:\Vincent\source\tramsitterStopwatch.c:429: case 0: return "FORWARD ";
L023001?:
	mov	dptr,#__str_18
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:430: case 1: return "LEFT    ";
	ret
L023002?:
	mov	dptr,#__str_19
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:431: case 2: return "RIGHT   ";
	ret
L023003?:
	mov	dptr,#__str_20
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:432: case 3: return "STOP    ";
	ret
L023004?:
	mov	dptr,#__str_2
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:433: default: return "???     ";
	ret
L023005?:
	mov	dptr,#__str_21
	mov	b,#0x80
;	C:\Vincent\source\tramsitterStopwatch.c:434: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Show_Command'
;------------------------------------------------------------
;cmd                       Allocated to registers 
;raw_adc                   Allocated to registers 
;pin_mv                    Allocated to registers 
;battery_mv                Allocated to registers 
;percent                   Allocated to registers r5 
;label                     Allocated to registers r2 r3 r4 
;i                         Allocated to registers r6 
;line                      Allocated with name '_Show_Command_line_1_120'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:437: void Show_Command(unsigned char cmd)
;	-----------------------------------------
;	 function Show_Command
;	-----------------------------------------
_Show_Command:
;	C:\Vincent\source\tramsitterStopwatch.c:442: const char *label = Cmd_Label(cmd);
	lcall	_Cmd_Label
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Vincent\source\tramsitterStopwatch.c:446: raw_adc = ADC_at_Pin(BATT_CH);
	mov	dpl,#0x0C
	push	ar2
	push	ar3
	push	ar4
	lcall	_ADC_at_Pin
;	C:\Vincent\source\tramsitterStopwatch.c:447: percent = Get_Battery_Percent();
	lcall	_Get_Battery_Percent
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:454: for(i=0; i<16; i++) line[i] = ' ';
	mov	r6,#0x00
L024004?:
	cjne	r6,#0x10,L024023?
L024023?:
	jnc	L024007?
	mov	a,r6
	add	a,#_Show_Command_line_1_120
	mov	dpl,a
	clr	a
	addc	a,#(_Show_Command_line_1_120 >> 8)
	mov	dph,a
	mov	a,#0x20
	movx	@dptr,a
	inc	r6
	sjmp	L024004?
L024007?:
;	C:\Vincent\source\tramsitterStopwatch.c:455: line[16] = 0;
	mov	dptr,#(_Show_Command_line_1_120 + 0x0010)
	clr	a
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:458: for(i=0; i<8 && label[i] != 0; i++) {
	mov	r6,#0x00
L024009?:
	cjne	r6,#0x08,L024025?
L024025?:
	jnc	L024012?
	mov	a,r6
	add	a,r2
	mov	r7,a
	clr	a
	addc	a,r3
	mov	r0,a
	mov	ar1,r4
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	jz	L024012?
;	C:\Vincent\source\tramsitterStopwatch.c:459: line[i] = label[i];
	mov	a,r6
	add	a,#_Show_Command_line_1_120
	mov	dpl,a
	clr	a
	addc	a,#(_Show_Command_line_1_120 >> 8)
	mov	dph,a
	mov	a,r7
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:458: for(i=0; i<8 && label[i] != 0; i++) {
	inc	r6
	sjmp	L024009?
L024012?:
;	C:\Vincent\source\tramsitterStopwatch.c:463: line[11] = 'B';
	mov	dptr,#(_Show_Command_line_1_120 + 0x000b)
	mov	a,#0x42
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:464: line[12] = ':';
	mov	dptr,#(_Show_Command_line_1_120 + 0x000c)
	mov	a,#0x3A
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:465: if (percent >= 100) {
	cjne	r5,#0x64,L024028?
L024028?:
	jc	L024002?
;	C:\Vincent\source\tramsitterStopwatch.c:466: line[13] = '1'; line[14] = '0'; line[15] = '0';
	mov	dptr,#(_Show_Command_line_1_120 + 0x000d)
	mov	a,#0x31
	movx	@dptr,a
	mov	dptr,#(_Show_Command_line_1_120 + 0x000e)
	mov	a,#0x30
	movx	@dptr,a
	mov	dptr,#(_Show_Command_line_1_120 + 0x000f)
	mov	a,#0x30
	movx	@dptr,a
	sjmp	L024003?
L024002?:
;	C:\Vincent\source\tramsitterStopwatch.c:468: line[13] = ' ';
	mov	dptr,#(_Show_Command_line_1_120 + 0x000d)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:469: line[14] = (percent / 10) + '0';
	mov	b,#0x0A
	mov	a,r5
	div	ab
	add	a,#0x30
	mov	dptr,#(_Show_Command_line_1_120 + 0x000e)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:470: line[15] = (percent % 10) + '0';
	mov	b,#0x0A
	mov	a,r5
	div	ab
	mov	a,b
	add	a,#0x30
	mov	r2,a
	mov	dptr,#(_Show_Command_line_1_120 + 0x000f)
	movx	@dptr,a
L024003?:
;	C:\Vincent\source\tramsitterStopwatch.c:472: LCDprint(line, 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#_Show_Command_line_1_120
	mov	b,#0x00
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'Send_Joystick_Proportional'
;------------------------------------------------------------
;urx                       Allocated to registers r2 r3 
;ury                       Allocated to registers r4 r5 
;base                      Allocated to registers r6 r7 
;turn                      Allocated to registers r4 r5 
;lv                        Allocated to registers r2 r3 
;rv                        Allocated to registers r4 r5 
;lb                        Allocated with name '_Send_Joystick_Proportional_lb_1_125'
;rb                        Allocated to registers r1 
;chk                       Allocated to registers r7 
;percent                   Allocated with name '_Send_Joystick_Proportional_percent_1_125'
;sloc0                     Allocated with name '_Send_Joystick_Proportional_sloc0_1_0'
;disp                      Allocated with name '_Send_Joystick_Proportional_disp_1_125'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:477: void Send_Joystick_Proportional(void)
;	-----------------------------------------
;	 function Send_Joystick_Proportional
;	-----------------------------------------
_Send_Joystick_Proportional:
;	C:\Vincent\source\tramsitterStopwatch.c:485: urx = ADC_at_Pin(JOY_URX_CH);
	mov	dpl,#0x0E
	lcall	_ADC_at_Pin
	mov	r2,dpl
	mov	r3,dph
;	C:\Vincent\source\tramsitterStopwatch.c:486: ury = ADC_at_Pin(JOY_URY_CH);
	mov	dpl,#0x0F
	push	ar2
	push	ar3
	lcall	_ADC_at_Pin
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:489: if (ury > (JOY_MID + JOY_DEAD)) {
	clr	c
	mov	a,#0xC2
	subb	a,r4
	mov	a,#0x15
	subb	a,r5
	jnc	L025009?
;	C:\Vincent\source\tramsitterStopwatch.c:490: base = (int)((long)(ury - JOY_MID - JOY_DEAD) * 100L / (long)FWD_RANGE);
	mov	a,r4
	add	a,#0x3e
	mov	r6,a
	mov	a,r5
	addc	a,#0xea
	mov	r7,a
	mov	__mullong_PARM_2,r6
	mov	(__mullong_PARM_2 + 1),r7
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
	mov	dptr,#(0x64&0x00ff)
	clr	a
	mov	b,a
	push	ar2
	push	ar3
	lcall	__mullong
	mov	__divslong_PARM_2,#0x2E
	mov	(__divslong_PARM_2 + 1),#0x0E
	mov	(__divslong_PARM_2 + 2),#0x00
	mov	(__divslong_PARM_2 + 3),#0x00
	lcall	__divslong
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:491: if (base > 100) base = 100;
	clr	c
	mov	a,#0x64
	subb	a,r6
	clr	a
	xrl	a,#0x80
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
	jnc	L025010?
	mov	r6,#0x64
	mov	r7,#0x00
	sjmp	L025010?
L025009?:
;	C:\Vincent\source\tramsitterStopwatch.c:492: } else if (ury < (JOY_MID - JOY_DEAD)) {
	clr	c
	mov	a,r4
	subb	a,#0xDA
	mov	a,r5
	subb	a,#0x11
	jnc	L025006?
;	C:\Vincent\source\tramsitterStopwatch.c:493: base = -(int)((long)(JOY_MID - JOY_DEAD - ury) * 100L / (long)BWD_RANGE);
	mov	a,#0xDA
	clr	c
	subb	a,r4
	mov	r4,a
	mov	a,#0x11
	subb	a,r5
	mov	r5,a
	mov	__mullong_PARM_2,r4
	mov	(__mullong_PARM_2 + 1),r5
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
	mov	dptr,#(0x64&0x00ff)
	clr	a
	mov	b,a
	push	ar2
	push	ar3
	lcall	__mullong
	mov	__divslong_PARM_2,#0x56
	mov	(__divslong_PARM_2 + 1),#0x0E
	mov	(__divslong_PARM_2 + 2),#0x00
	mov	(__divslong_PARM_2 + 3),#0x00
	lcall	__divslong
	mov	r4,dpl
	mov	r5,dph
	mov	r0,b
	mov	r1,a
	pop	ar3
	pop	ar2
	clr	c
	clr	a
	subb	a,r4
	mov	r6,a
	clr	a
	subb	a,r5
	mov	r7,a
;	C:\Vincent\source\tramsitterStopwatch.c:494: if (base < -100) base = -100;
	clr	c
	mov	a,r6
	subb	a,#0x9C
	mov	a,r7
	xrl	a,#0x80
	subb	a,#0x7f
	jnc	L025010?
	mov	r6,#0x9C
	mov	r7,#0xFF
	sjmp	L025010?
L025006?:
;	C:\Vincent\source\tramsitterStopwatch.c:496: base = 0;
	mov	r6,#0x00
	mov	r7,#0x00
L025010?:
;	C:\Vincent\source\tramsitterStopwatch.c:499: if (urx > (JOY_MID + JOY_DEAD)) {
	clr	c
	mov	a,#0xC2
	subb	a,r2
	mov	a,#0x15
	subb	a,r3
	jnc	L025019?
;	C:\Vincent\source\tramsitterStopwatch.c:500: turn = (int)((long)(urx - JOY_MID - JOY_DEAD) * 50L / (long)TURN_MAX);
	mov	a,r2
	add	a,#0x3e
	mov	r4,a
	mov	a,r3
	addc	a,#0xea
	mov	r5,a
	mov	__mullong_PARM_2,r4
	mov	(__mullong_PARM_2 + 1),r5
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
	mov	dptr,#(0x32&0x00ff)
	clr	a
	mov	b,a
	push	ar6
	push	ar7
	lcall	__mullong
	mov	__divslong_PARM_2,#0x2E
	mov	(__divslong_PARM_2 + 1),#0x0E
	mov	(__divslong_PARM_2 + 2),#0x00
	mov	(__divslong_PARM_2 + 3),#0x00
	lcall	__divslong
	mov	r4,dpl
	mov	r5,dph
	mov	r0,b
	mov	r1,a
	pop	ar7
	pop	ar6
;	C:\Vincent\source\tramsitterStopwatch.c:501: if (turn > 50) turn = 50;
	clr	c
	mov	a,#0x32
	subb	a,r4
	clr	a
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc	L025020?
	mov	r4,#0x32
	mov	r5,#0x00
	sjmp	L025020?
L025019?:
;	C:\Vincent\source\tramsitterStopwatch.c:502: } else if (urx < (JOY_MID - JOY_DEAD)) {
	clr	c
	mov	a,r2
	subb	a,#0xDA
	mov	a,r3
	subb	a,#0x11
	jnc	L025016?
;	C:\Vincent\source\tramsitterStopwatch.c:503: turn = -(int)((long)(JOY_MID - JOY_DEAD - urx) * 50L / (long)TURN_MAX);
	mov	a,#0xDA
	clr	c
	subb	a,r2
	mov	r2,a
	mov	a,#0x11
	subb	a,r3
	mov	r3,a
	mov	__mullong_PARM_2,r2
	mov	(__mullong_PARM_2 + 1),r3
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
	mov	dptr,#(0x32&0x00ff)
	clr	a
	mov	b,a
	push	ar6
	push	ar7
	lcall	__mullong
	mov	__divslong_PARM_2,#0x2E
	mov	(__divslong_PARM_2 + 1),#0x0E
	mov	(__divslong_PARM_2 + 2),#0x00
	mov	(__divslong_PARM_2 + 3),#0x00
	lcall	__divslong
	mov	r2,dpl
	mov	r3,dph
	mov	r0,b
	mov	r1,a
	pop	ar7
	pop	ar6
	clr	c
	clr	a
	subb	a,r2
	mov	r4,a
	clr	a
	subb	a,r3
	mov	r5,a
;	C:\Vincent\source\tramsitterStopwatch.c:504: if (turn < -50) turn = -50;
	clr	c
	mov	a,r4
	subb	a,#0xCE
	mov	a,r5
	xrl	a,#0x80
	subb	a,#0x7f
	jnc	L025020?
	mov	r4,#0xCE
	mov	r5,#0xFF
	sjmp	L025020?
L025016?:
;	C:\Vincent\source\tramsitterStopwatch.c:506: turn = 0;
	mov	r4,#0x00
	mov	r5,#0x00
L025020?:
;	C:\Vincent\source\tramsitterStopwatch.c:509: if (base == 0 && turn == 0) {
	mov	a,r6
	orl	a,r7
	jnz	L025022?
	mov	a,r4
	orl	a,r5
	jnz	L025022?
;	C:\Vincent\source\tramsitterStopwatch.c:510: IR_LoopbackPacket(CMD_STOP);
	mov	dpl,#0x01
	lcall	_IR_LoopbackPacket
;	C:\Vincent\source\tramsitterStopwatch.c:511: Show_Command(CMD_STOP);
	mov	dpl,#0x01
;	C:\Vincent\source\tramsitterStopwatch.c:512: return;
	ljmp	_Show_Command
L025022?:
;	C:\Vincent\source\tramsitterStopwatch.c:515: lv = base + turn;
	mov	a,r4
	add	a,r6
	mov	r2,a
	mov	a,r5
	addc	a,r7
	mov	r3,a
;	C:\Vincent\source\tramsitterStopwatch.c:516: rv = base - turn;
	mov	a,r6
	clr	c
	subb	a,r4
	mov	r4,a
	mov	a,r7
	subb	a,r5
	mov	r5,a
;	C:\Vincent\source\tramsitterStopwatch.c:517: if (lv >  100) lv =  100;
	clr	c
	mov	a,#0x64
	subb	a,r2
	clr	a
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	jnc	L025025?
	mov	r2,#0x64
	mov	r3,#0x00
L025025?:
;	C:\Vincent\source\tramsitterStopwatch.c:518: if (lv < -100) lv = -100;
	clr	c
	mov	a,r2
	subb	a,#0x9C
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x7f
	jnc	L025027?
	mov	r2,#0x9C
	mov	r3,#0xFF
L025027?:
;	C:\Vincent\source\tramsitterStopwatch.c:519: if (rv >  100) rv =  100;
	clr	c
	mov	a,#0x64
	subb	a,r4
	clr	a
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc	L025029?
	mov	r4,#0x64
	mov	r5,#0x00
L025029?:
;	C:\Vincent\source\tramsitterStopwatch.c:520: if (rv < -100) rv = -100;
	clr	c
	mov	a,r4
	subb	a,#0x9C
	mov	a,r5
	xrl	a,#0x80
	subb	a,#0x7f
	jnc	L025031?
	mov	r4,#0x9C
	mov	r5,#0xFF
L025031?:
;	C:\Vincent\source\tramsitterStopwatch.c:522: lb = (lv >= 0) ? (0x80 | (unsigned char) lv)  : (unsigned char)(-lv);
	mov	a,r3
	rlc	a
	clr	a
	rlc	a
	mov	r6,a
	cjne	a,#0x01,L025090?
L025090?:
	clr	a
	rlc	a
	mov	r7,a
	jz	L025037?
	mov	ar7,r2
	orl	ar7,#0x80
	sjmp	L025038?
L025037?:
	mov	ar0,r2
	clr	c
	clr	a
	subb	a,r0
	mov	r7,a
L025038?:
	mov	_Send_Joystick_Proportional_lb_1_125,r7
;	C:\Vincent\source\tramsitterStopwatch.c:523: rb = (rv >= 0) ? (0x80 | (unsigned char) rv)   : (unsigned char)(-rv);
	mov	a,r5
	rlc	a
	clr	a
	rlc	a
	mov	r0,a
	cjne	a,#0x01,L025092?
L025092?:
	clr	a
	rlc	a
	mov	r1,a
	jz	L025039?
	mov	ar1,r4
	orl	ar1,#0x80
	sjmp	L025040?
L025039?:
	mov	ar7,r4
	clr	c
	clr	a
	subb	a,r7
	mov	r1,a
L025040?:
;	C:\Vincent\source\tramsitterStopwatch.c:524: chk = (unsigned char)(0xFF - CMD_JOYSTICK - lb - rb);
	mov	a,#0xAF
	clr	c
	subb	a,_Send_Joystick_Proportional_lb_1_125
	clr	c
	subb	a,r1
	mov	r7,a
;	C:\Vincent\source\tramsitterStopwatch.c:526: IR_LoopbackByte(CMD_JOYSTICK);
	mov	dpl,#0x50
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_IR_LoopbackByte
;	C:\Vincent\source\tramsitterStopwatch.c:527: IR_LoopbackByte(lb);
	mov	dpl,_Send_Joystick_Proportional_lb_1_125
	lcall	_IR_LoopbackByte
	pop	ar1
;	C:\Vincent\source\tramsitterStopwatch.c:528: IR_LoopbackByte(rb);
	mov	dpl,r1
	lcall	_IR_LoopbackByte
	pop	ar0
	pop	ar7
;	C:\Vincent\source\tramsitterStopwatch.c:529: IR_LoopbackByte(chk);
	mov	dpl,r7
	push	ar0
	lcall	_IR_LoopbackByte
;	C:\Vincent\source\tramsitterStopwatch.c:530: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:532: percent = Get_Battery_Percent();
	lcall	_Get_Battery_Percent
	mov	_Send_Joystick_Proportional_percent_1_125,dpl
	pop	ar0
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:536: disp[0]='L';
	mov	dptr,#_Send_Joystick_Proportional_disp_1_125
	mov	a,#0x4C
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:537: disp[1]='0'+((lv<0?-lv:lv)/100%10);
	mov	a,r6
	jz	L025041?
	clr	c
	clr	a
	subb	a,r2
	mov	_Send_Joystick_Proportional_sloc0_1_0,a
	clr	a
	subb	a,r3
	mov	(_Send_Joystick_Proportional_sloc0_1_0 + 1),a
	sjmp	L025042?
L025041?:
	mov	_Send_Joystick_Proportional_sloc0_1_0,r2
	mov	(_Send_Joystick_Proportional_sloc0_1_0 + 1),r3
L025042?:
	mov	__divsint_PARM_2,#0x64
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Send_Joystick_Proportional_sloc0_1_0
	mov	dph,(_Send_Joystick_Proportional_sloc0_1_0 + 1)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar0
	lcall	__divsint
	mov	r1,dpl
	mov	r7,dph
	mov	__modsint_PARM_2,#0x0A
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r1
	mov	dph,r7
	lcall	__modsint
	mov	r7,dpl
	mov	r1,dph
	pop	ar0
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,#0x30
	add	a,r7
	mov	r7,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0001)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:538: disp[2]='0'+((lv<0?-lv:lv)/10%10);
	mov	a,r6
	jz	L025043?
	clr	c
	clr	a
	subb	a,r2
	mov	r7,a
	clr	a
	subb	a,r3
	mov	r1,a
	sjmp	L025044?
L025043?:
	mov	ar7,r2
	mov	ar1,r3
L025044?:
	mov	__divsint_PARM_2,#0x0A
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,r7
	mov	dph,r1
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar0
	lcall	__divsint
	mov	r7,dpl
	mov	r1,dph
	mov	__modsint_PARM_2,#0x0A
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r7
	mov	dph,r1
	lcall	__modsint
	mov	r7,dpl
	mov	r1,dph
	pop	ar0
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,#0x30
	add	a,r7
	mov	r7,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0002)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:539: disp[3]='0'+((lv<0?-lv:lv)%10);
	mov	a,r6
	jz	L025045?
	clr	c
	clr	a
	subb	a,r2
	mov	r6,a
	clr	a
	subb	a,r3
	mov	r7,a
	sjmp	L025046?
L025045?:
	mov	ar6,r2
	mov	ar7,r3
L025046?:
	mov	__modsint_PARM_2,#0x0A
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r6
	mov	dph,r7
	push	ar4
	push	ar5
	push	ar0
	lcall	__modsint
	mov	r2,dpl
	mov	r3,dph
	pop	ar0
	pop	ar5
	pop	ar4
	mov	a,#0x30
	add	a,r2
	mov	r2,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0003)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:540: disp[4]=' ';
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0004)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:541: disp[5]='R';
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0005)
	mov	a,#0x52
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:542: disp[6]='0'+((rv<0?-rv:rv)/100%10);
	mov	a,r0
	jz	L025047?
	clr	c
	clr	a
	subb	a,r4
	mov	r2,a
	clr	a
	subb	a,r5
	mov	r3,a
	sjmp	L025048?
L025047?:
	mov	ar2,r4
	mov	ar3,r5
L025048?:
	mov	__divsint_PARM_2,#0x64
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	push	ar4
	push	ar5
	push	ar0
	lcall	__divsint
	mov	r2,dpl
	mov	r3,dph
	mov	__modsint_PARM_2,#0x0A
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__modsint
	mov	r2,dpl
	mov	r3,dph
	pop	ar0
	pop	ar5
	pop	ar4
	mov	a,#0x30
	add	a,r2
	mov	r2,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0006)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:543: disp[7]='0'+((rv<0?-rv:rv)/10%10);
	mov	a,r0
	jz	L025049?
	clr	c
	clr	a
	subb	a,r4
	mov	r2,a
	clr	a
	subb	a,r5
	mov	r3,a
	sjmp	L025050?
L025049?:
	mov	ar2,r4
	mov	ar3,r5
L025050?:
	mov	__divsint_PARM_2,#0x0A
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	push	ar4
	push	ar5
	push	ar0
	lcall	__divsint
	mov	r2,dpl
	mov	r3,dph
	mov	__modsint_PARM_2,#0x0A
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__modsint
	mov	r2,dpl
	mov	r3,dph
	pop	ar0
	pop	ar5
	pop	ar4
	mov	a,#0x30
	add	a,r2
	mov	r2,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0007)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:544: disp[8]='0'+((rv<0?-rv:rv)%10);
	mov	a,r0
	jz	L025051?
	clr	c
	clr	a
	subb	a,r4
	mov	r2,a
	clr	a
	subb	a,r5
	mov	r3,a
	sjmp	L025052?
L025051?:
	mov	ar2,r4
	mov	ar3,r5
L025052?:
	mov	__modsint_PARM_2,#0x0A
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__modsint
	mov	r2,dpl
	mov	r3,dph
	mov	a,#0x30
	add	a,r2
	mov	r2,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0008)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:545: disp[9]=' ';
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0009)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:546: disp[10]='B';
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000a)
	mov	a,#0x42
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:547: disp[11]=':';
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000b)
	mov	a,#0x3A
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:548: if(percent >= 100) {
	mov	a,#0x100 - 0x64
	add	a,_Send_Joystick_Proportional_percent_1_125
	jnc	L025033?
;	C:\Vincent\source\tramsitterStopwatch.c:549: disp[12]='1'; disp[13]='0'; disp[14]='0';
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000c)
	mov	a,#0x31
	movx	@dptr,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000d)
	mov	a,#0x30
	movx	@dptr,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000e)
	mov	a,#0x30
	movx	@dptr,a
	sjmp	L025034?
L025033?:
;	C:\Vincent\source\tramsitterStopwatch.c:551: disp[12]=' '; // Space
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000c)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:552: disp[13]='0'+(percent/10);
	mov	b,#0x0A
	mov	a,_Send_Joystick_Proportional_percent_1_125
	div	ab
	add	a,#0x30
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000d)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:553: disp[14]='0'+(percent%10);
	mov	b,#0x0A
	mov	a,_Send_Joystick_Proportional_percent_1_125
	div	ab
	mov	a,b
	add	a,#0x30
	mov	r2,a
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000e)
	movx	@dptr,a
L025034?:
;	C:\Vincent\source\tramsitterStopwatch.c:555: disp[15]='%';
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x000f)
	mov	a,#0x25
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:556: disp[16]=0;
	mov	dptr,#(_Send_Joystick_Proportional_disp_1_125 + 0x0010)
	clr	a
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:557: LCDprint(disp, 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#_Send_Joystick_Proportional_disp_1_125
	mov	b,#0x00
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'Password4BitToString'
;------------------------------------------------------------
;str                       Allocated with name '_Password4BitToString_PARM_2'
;val                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:565: void Password4BitToString(unsigned char val, char *str)
;	-----------------------------------------
;	 function Password4BitToString
;	-----------------------------------------
_Password4BitToString:
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:567: str[0] = (val & 0x08) ? '1' : '0';
	mov	r3,_Password4BitToString_PARM_2
	mov	r4,(_Password4BitToString_PARM_2 + 1)
	mov	r5,(_Password4BitToString_PARM_2 + 2)
	mov	a,r2
	jnb	acc.3,L026003?
	mov	r6,#0x31
	sjmp	L026004?
L026003?:
	mov	r6,#0x30
L026004?:
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	mov	a,r6
	lcall	__gptrput
;	C:\Vincent\source\tramsitterStopwatch.c:568: str[1] = (val & 0x04) ? '1' : '0';
	mov	a,#0x01
	add	a,r3
	mov	r6,a
	clr	a
	addc	a,r4
	mov	r7,a
	mov	ar0,r5
	mov	a,r2
	jnb	acc.2,L026005?
	mov	r1,#0x31
	sjmp	L026006?
L026005?:
	mov	r1,#0x30
L026006?:
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	__gptrput
;	C:\Vincent\source\tramsitterStopwatch.c:569: str[2] = (val & 0x02) ? '1' : '0';
	mov	a,#0x02
	add	a,r3
	mov	r6,a
	clr	a
	addc	a,r4
	mov	r7,a
	mov	ar0,r5
	mov	a,r2
	jnb	acc.1,L026007?
	mov	r1,#0x31
	sjmp	L026008?
L026007?:
	mov	r1,#0x30
L026008?:
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	__gptrput
;	C:\Vincent\source\tramsitterStopwatch.c:570: str[3] = (val & 0x01) ? '1' : '0';
	mov	a,#0x03
	add	a,r3
	mov	r6,a
	clr	a
	addc	a,r4
	mov	r7,a
	mov	ar0,r5
	mov	a,r2
	jnb	acc.0,L026009?
	mov	r2,#0x31
	sjmp	L026010?
L026009?:
	mov	r2,#0x30
L026010?:
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r2
	lcall	__gptrput
;	C:\Vincent\source\tramsitterStopwatch.c:571: str[4] = 0;
	mov	a,#0x04
	add	a,r3
	mov	r3,a
	clr	a
	addc	a,r4
	mov	r4,a
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	clr	a
	ljmp	__gptrput
;------------------------------------------------------------
;Allocation info for local variables in function 'Password_Entry_Screen'
;------------------------------------------------------------
;line1_msg                 Allocated to registers r2 r3 r4 
;pass                      Allocated to registers r5 
;pass_str                  Allocated with name '_Password_Entry_Screen_pass_str_1_138'
;line2                     Allocated with name '_Password_Entry_Screen_line2_1_138'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:576: unsigned char Password_Entry_Screen(char *line1_msg)
;	-----------------------------------------
;	 function Password_Entry_Screen
;	-----------------------------------------
_Password_Entry_Screen:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Vincent\source\tramsitterStopwatch.c:578: unsigned char pass = 0;  // 4-bit value (0000)
	mov	r5,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:582: while (1)
L027025?:
;	C:\Vincent\source\tramsitterStopwatch.c:585: Password4BitToString(pass, pass_str);
	mov	_Password4BitToString_PARM_2,#_Password_Entry_Screen_pass_str_1_138
	mov	(_Password4BitToString_PARM_2 + 1),#0x00
	mov	(_Password4BitToString_PARM_2 + 2),#0x40
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_Password4BitToString
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:586: line2[0] = 'P'; line2[1] = 'a'; line2[2] = 's'; line2[3] = 's';
	mov	dptr,#_Password_Entry_Screen_line2_1_138
	mov	a,#0x50
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0001)
	mov	a,#0x61
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0002)
	mov	a,#0x73
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0003)
	mov	a,#0x73
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:587: line2[4] = ':'; line2[5] = ' ';
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0004)
	mov	a,#0x3A
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0005)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:588: line2[6] = pass_str[0];
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0006)
	mov	a,_Password_Entry_Screen_pass_str_1_138
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:589: line2[7] = pass_str[1];
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0007)
	mov	a,(_Password_Entry_Screen_pass_str_1_138 + 0x0001)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:590: line2[8] = pass_str[2];
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0008)
	mov	a,(_Password_Entry_Screen_pass_str_1_138 + 0x0002)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:591: line2[9] = pass_str[3];
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0009)
	mov	a,(_Password_Entry_Screen_pass_str_1_138 + 0x0003)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:592: line2[10] = ' '; line2[11] = ' '; line2[12] = ' ';
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x000a)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x000b)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x000c)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:593: line2[13] = ' '; line2[14] = ' '; line2[15] = ' '; line2[16] = 0;
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x000d)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x000e)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x000f)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Password_Entry_Screen_line2_1_138 + 0x0010)
	clr	a
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:595: LCDprint(line1_msg, 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:596: LCDprint(line2, 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#_Password_Entry_Screen_line2_1_138
	mov	b,#0x00
	lcall	_LCDprint
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:599: if (BTN1 == 0)
	jb	_P2_5,L027022?
;	C:\Vincent\source\tramsitterStopwatch.c:601: waitms(20);  // Debounce
	mov	dptr,#0x0014
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:602: if (BTN1 == 0)
	jnb	_P2_5,L027042?
	ljmp	L027023?
L027042?:
;	C:\Vincent\source\tramsitterStopwatch.c:604: pass = (pass << 1) & 0x0F;  // Shift left, add 0, keep 4 bits
	mov	a,r5
	add	a,r5
	mov	r6,a
	mov	a,#0x0F
	anl	a,r6
	mov	r5,a
;	C:\Vincent\source\tramsitterStopwatch.c:605: while (BTN1 == 0);  // Wait for release
L027001?:
	jnb	_P2_5,L027001?
;	C:\Vincent\source\tramsitterStopwatch.c:606: waitms(50);
	mov	dptr,#0x0032
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp	L027023?
L027022?:
;	C:\Vincent\source\tramsitterStopwatch.c:611: else if (BTN2 == 0)
	jb	_P2_4,L027019?
;	C:\Vincent\source\tramsitterStopwatch.c:613: waitms(20);  // Debounce
	mov	dptr,#0x0014
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:614: if (BTN2 == 0)
	jb	_P2_4,L027023?
;	C:\Vincent\source\tramsitterStopwatch.c:616: pass = ((pass << 1) | 0x01) & 0x0F;  // Shift left, add 1, keep 4 bits
	mov	a,r5
	add	a,r5
	mov	r6,a
	mov	a,#0x01
	orl	a,r6
	anl	a,#0x0F
	mov	r5,a
;	C:\Vincent\source\tramsitterStopwatch.c:617: while (BTN2 == 0);  // Wait for release
L027006?:
	jnb	_P2_4,L027006?
;	C:\Vincent\source\tramsitterStopwatch.c:618: waitms(50);
	mov	dptr,#0x0032
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp	L027023?
L027019?:
;	C:\Vincent\source\tramsitterStopwatch.c:623: else if (BTN3 == 0)
	jb	_P2_6,L027023?
;	C:\Vincent\source\tramsitterStopwatch.c:625: waitms(20);  // Debounce
	mov	dptr,#0x0014
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:626: if (BTN3 == 0)
	jb	_P2_6,L027023?
;	C:\Vincent\source\tramsitterStopwatch.c:628: while (BTN3 == 0);  // Wait for release
L027011?:
	jnb	_P2_6,L027011?
;	C:\Vincent\source\tramsitterStopwatch.c:629: return pass;  // Return the entered password
	mov	dpl,r5
	ret
L027023?:
;	C:\Vincent\source\tramsitterStopwatch.c:633: waitms(50);
	mov	dptr,#0x0032
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	ljmp	L027025?
;------------------------------------------------------------
;Allocation info for local variables in function 'Init_Timer2_1Hz'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:640: void Init_Timer2_1Hz(void)
;	-----------------------------------------
;	 function Init_Timer2_1Hz
;	-----------------------------------------
_Init_Timer2_1Hz:
;	C:\Vincent\source\tramsitterStopwatch.c:648: TMR2CN0 = 0x00;     // Stop Timer2, clear overflow flag
	mov	_TMR2CN0,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:649: CKCON0 &= ~0x30;    // Timer2 uses SYSCLK/12 = 6 MHz
	anl	_CKCON0,#0xCF
;	C:\Vincent\source\tramsitterStopwatch.c:650: TMR2RL = 5536;    // Reload value for 100 Hz (10 ms)
	mov	_TMR2RL,#0xA0
	mov	(_TMR2RL >> 8),#0x15
;	C:\Vincent\source\tramsitterStopwatch.c:651: TMR2 = TMR2RL;      // Initialize Timer2
	mov	_TMR2,_TMR2RL
	mov	(_TMR2 >> 8),(_TMR2RL >> 8)
;	C:\Vincent\source\tramsitterStopwatch.c:652: ET2 = 1;            // Enable Timer2 interrupts
	setb	_ET2
;	C:\Vincent\source\tramsitterStopwatch.c:653: TR2 = 1;            // Start Timer2
	setb	_TR2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;tick_count                Allocated with name '_Timer2_ISR_tick_count_1_149'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:657: void Timer2_ISR(void) interrupt 5
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
	push	acc
	push	psw
	mov	psw,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:661: TF2H = 0;  // Clear Timer2 interrupt flag
	clr	_TF2H
;	C:\Vincent\source\tramsitterStopwatch.c:663: if (auto_mode && !stopwatch_paused) {
	jnb	_auto_mode,L029006?
	jb	_stopwatch_paused,L029006?
;	C:\Vincent\source\tramsitterStopwatch.c:664: tick_count++;
	inc	_Timer2_ISR_tick_count_1_149
;	C:\Vincent\source\tramsitterStopwatch.c:665: if (tick_count >= 100) {  // 100 * 10ms = 1 second
	mov	a,#0x100 - 0x64
	add	a,_Timer2_ISR_tick_count_1_149
	jnc	L029006?
;	C:\Vincent\source\tramsitterStopwatch.c:666: tick_count = 0;
	mov	_Timer2_ISR_tick_count_1_149,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:667: timer_tick = 1;  // Signal main loop to update stopwatch
	setb	_timer_tick
L029006?:
	pop	psw
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'Update_Stopwatch_Display'
;------------------------------------------------------------
;percent                   Allocated to registers r2 
;line                      Allocated with name '_Update_Stopwatch_Display_line_1_153'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:672: void Update_Stopwatch_Display(void)
;	-----------------------------------------
;	 function Update_Stopwatch_Display
;	-----------------------------------------
_Update_Stopwatch_Display:
;	C:\Vincent\source\tramsitterStopwatch.c:677: stopwatch_minutes = (unsigned char)(stopwatch_seconds / 60);
	mov	__divuint_PARM_2,#0x3C
	clr	a
	mov	(__divuint_PARM_2 + 1),a
	mov	dpl,_stopwatch_seconds
	mov	dph,(_stopwatch_seconds + 1)
	lcall	__divuint
	mov	r2,dpl
	mov	_stopwatch_minutes,r2
;	C:\Vincent\source\tramsitterStopwatch.c:678: stopwatch_secs = (unsigned char)(stopwatch_seconds % 60);
	mov	__moduint_PARM_2,#0x3C
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,_stopwatch_seconds
	mov	dph,(_stopwatch_seconds + 1)
	lcall	__moduint
	mov	r2,dpl
	mov	_stopwatch_secs,r2
;	C:\Vincent\source\tramsitterStopwatch.c:679: percent = Get_Battery_Percent();
	lcall	_Get_Battery_Percent
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:682: line[0] = 'T'; line[1] = 'i'; line[2] = 'm'; line[3] = 'e';
	mov	dptr,#_Update_Stopwatch_Display_line_1_153
	mov	a,#0x54
	movx	@dptr,a
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0001)
	mov	a,#0x69
	movx	@dptr,a
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0002)
	mov	a,#0x6D
	movx	@dptr,a
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0003)
	mov	a,#0x65
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:683: line[4] = ':';
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0004)
	mov	a,#0x3A
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:687: line[5] = (stopwatch_minutes >= 10) ? ('0' + (stopwatch_minutes / 10)) : ' ';
	clr	c
	mov	a,_stopwatch_minutes
	subb	a,#0x0A
	cpl	c
	clr	a
	rlc	a
	mov	r3,a
	jz	L030006?
	mov	b,#0x0A
	mov	a,_stopwatch_minutes
	div	ab
	add	a,#0x30
	mov	r3,a
	sjmp	L030007?
L030006?:
	mov	r3,#0x20
L030007?:
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0005)
	mov	a,r3
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:688: line[6] = '0' + (stopwatch_minutes % 10);
	mov	b,#0x0A
	mov	a,_stopwatch_minutes
	div	ab
	mov	a,b
	add	a,#0x30
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0006)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:689: line[7] = ':';
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0007)
	mov	a,#0x3A
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:690: line[8] = '0' + (stopwatch_secs / 10);
	mov	b,#0x0A
	mov	a,_stopwatch_secs
	div	ab
	add	a,#0x30
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0008)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:691: line[9] = '0' + (stopwatch_secs % 10);
	mov	b,#0x0A
	mov	a,_stopwatch_secs
	div	ab
	mov	a,b
	add	a,#0x30
	mov	r3,a
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0009)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:693: line[10] = ' '; // Spacer
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000a)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:694: line[11] = 'B';
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000b)
	mov	a,#0x42
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:695: line[12] = ':';
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000c)
	mov	a,#0x3A
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:698: if (percent >= 100) {
	cjne	r2,#0x64,L030015?
L030015?:
	jc	L030002?
;	C:\Vincent\source\tramsitterStopwatch.c:699: line[13] = '1';
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000d)
	mov	a,#0x31
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:700: line[14] = '0';
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000e)
	mov	a,#0x30
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:701: line[15] = '0';
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000f)
	mov	a,#0x30
	movx	@dptr,a
	sjmp	L030003?
L030002?:
;	C:\Vincent\source\tramsitterStopwatch.c:703: line[13] = ' '; // Leading space for alignment
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000d)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:704: line[14] = (percent >= 10) ? ('0' + (percent / 10)) : ' ';
	cjne	r2,#0x0A,L030017?
L030017?:
	cpl	c
	clr	a
	rlc	a
	mov	r3,a
	jz	L030008?
	mov	b,#0x0A
	mov	a,r2
	div	ab
	add	a,#0x30
	mov	r3,a
	sjmp	L030009?
L030008?:
	mov	r3,#0x20
L030009?:
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000e)
	mov	a,r3
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:705: line[15] = '0' + (percent % 10);
	mov	b,#0x0A
	mov	a,r2
	div	ab
	mov	a,b
	add	a,#0x30
	mov	r2,a
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x000f)
	movx	@dptr,a
L030003?:
;	C:\Vincent\source\tramsitterStopwatch.c:708: line[16] = '\0'; // Properly terminate at the end of the 16-char buffer
	mov	dptr,#(_Update_Stopwatch_Display_line_1_153 + 0x0010)
	clr	a
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:710: LCDprint(line, 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#_Update_Stopwatch_Display_line_1_153
	mov	b,#0x00
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'Program_Mode'
;------------------------------------------------------------
;current_option            Allocated to registers r2 
;btn3_held                 Allocated to registers r4 r5 
;i                         Allocated to registers r4 
;rx_ack                    Allocated to registers r3 
;line1                     Allocated with name '_Program_Mode_line1_1_157'
;line2                     Allocated with name '_Program_Mode_line2_1_157'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:716: void Program_Mode(void)
;	-----------------------------------------
;	 function Program_Mode
;	-----------------------------------------
_Program_Mode:
;	C:\Vincent\source\tramsitterStopwatch.c:718: unsigned char current_option = 3;  // Start with STOP (0=F, 1=L, 2=R, 3=S)
	mov	r2,#0x03
;	C:\Vincent\source\tramsitterStopwatch.c:725: program_step = 0;  // Reset step counter
	mov	_program_step,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:728: for (i = 0; i < 8; i++) {
	mov	r3,#0x00
L031045?:
	cjne	r3,#0x08,L031098?
L031098?:
	jnc	L031048?
;	C:\Vincent\source\tramsitterStopwatch.c:729: program_path[i] = 3;  // Default to STOP
	mov	a,r3
	add	a,#_program_path
	mov	dpl,a
	clr	a
	addc	a,#(_program_path >> 8)
	mov	dph,a
	mov	a,#0x03
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:728: for (i = 0; i < 8; i++) {
	inc	r3
	sjmp	L031045?
L031048?:
;	C:\Vincent\source\tramsitterStopwatch.c:733: rx_ack = IR_LoopbackPacket(CMD_PROG_START);
	mov	dpl,#0x60
	push	ar2
	lcall	_IR_LoopbackPacket
	mov	r3,dpl
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:736: if (rx_ack == CMD_PROG_START) {
	cjne	r3,#0x60,L031002?
;	C:\Vincent\source\tramsitterStopwatch.c:737: LCDprint("Program Mode:   ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_22
	mov	b,#0x80
	push	ar2
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:738: LCDprint("STM32 Ready!    ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_23
	mov	b,#0x80
	lcall	_LCDprint
	pop	ar2
	sjmp	L031003?
L031002?:
;	C:\Vincent\source\tramsitterStopwatch.c:740: LCDprint("Program Mode:   ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_22
	mov	b,#0x80
	push	ar2
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:741: LCDprint("Loading...      ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_24
	mov	b,#0x80
	lcall	_LCDprint
	pop	ar2
L031003?:
;	C:\Vincent\source\tramsitterStopwatch.c:743: waitms(800);
	mov	dptr,#0x0320
	push	ar2
	lcall	_waitms
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:745: while (program_step < 8)
L031039?:
	mov	a,#0x100 - 0x08
	add	a,_program_step
	jnc	L031102?
	ljmp	L031041?
L031102?:
;	C:\Vincent\source\tramsitterStopwatch.c:748: line1[0] = 'S'; line1[1] = 't'; line1[2] = 'e'; line1[3] = 'p';
	mov	dptr,#_Program_Mode_line1_1_157
	mov	a,#0x53
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0001)
	mov	a,#0x74
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0002)
	mov	a,#0x65
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0003)
	mov	a,#0x70
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:749: line1[4] = ' ';
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0004)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:750: line1[5] = '0' + (program_step + 1);  // Display as 1-8
	mov	a,#0x31
	add	a,_program_step
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0005)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:751: line1[6] = '/'; line1[7] = '8'; line1[8] = ':';
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0006)
	mov	a,#0x2F
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0007)
	mov	a,#0x38
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0008)
	mov	a,#0x3A
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:752: line1[9] = ' '; line1[10] = ' '; line1[11] = ' ';
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0009)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x000a)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x000b)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:753: line1[12] = ' '; line1[13] = ' '; line1[14] = ' ';
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x000c)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x000d)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x000e)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:754: line1[15] = ' '; line1[16] = 0;
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x000f)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_Program_Mode_line1_1_157 + 0x0010)
	clr	a
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:757: for (i = 0; i < 8; i++) {
	mov	r4,#0x00
L031049?:
	cjne	r4,#0x08,L031103?
L031103?:
	jnc	L031070?
;	C:\Vincent\source\tramsitterStopwatch.c:758: line2[i] = Direction_Label(current_option)[i];
	mov	a,r4
	add	a,#_Program_Mode_line2_1_157
	mov	r5,a
	clr	a
	addc	a,#(_Program_Mode_line2_1_157 >> 8)
	mov	r6,a
	mov	dpl,r2
	push	ar2
	push	ar4
	push	ar5
	push	ar6
	lcall	_Direction_Label
	mov	r7,dpl
	mov	r0,dph
	mov	r1,b
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar2
	mov	a,r4
	add	a,r7
	mov	r7,a
	clr	a
	addc	a,r0
	mov	r0,a
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	mov	dpl,r5
	mov	dph,r6
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:757: for (i = 0; i < 8; i++) {
	inc	r4
	sjmp	L031049?
L031070?:
L031053?:
;	C:\Vincent\source\tramsitterStopwatch.c:760: for (; i < 16; i++) line2[i] = ' ';
	cjne	r4,#0x10,L031105?
L031105?:
	jnc	L031056?
	mov	a,r4
	add	a,#_Program_Mode_line2_1_157
	mov	dpl,a
	clr	a
	addc	a,#(_Program_Mode_line2_1_157 >> 8)
	mov	dph,a
	mov	a,#0x20
	movx	@dptr,a
	inc	r4
	sjmp	L031053?
L031056?:
;	C:\Vincent\source\tramsitterStopwatch.c:761: line2[16] = 0;
	mov	dptr,#(_Program_Mode_line2_1_157 + 0x0010)
	clr	a
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:763: LCDprint(line1, 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#_Program_Mode_line1_1_157
	mov	b,#0x00
	push	ar2
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:764: LCDprint(line2, 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#_Program_Mode_line2_1_157
	mov	b,#0x00
	lcall	_LCDprint
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:767: if (BTN1 == 0)
	jb	_P2_5,L031037?
;	C:\Vincent\source\tramsitterStopwatch.c:769: waitms(20);  // Debounce
	mov	dptr,#0x0014
	push	ar2
	lcall	_waitms
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:770: if (BTN1 == 0)
	jnb	_P2_5,L031108?
	ljmp	L031038?
L031108?:
;	C:\Vincent\source\tramsitterStopwatch.c:772: current_option++;
	inc	r2
;	C:\Vincent\source\tramsitterStopwatch.c:773: if (current_option > 3) current_option = 0;
	mov	a,r2
	add	a,#0xff - 0x03
	jnc	L031006?
	mov	r2,#0x00
;	C:\Vincent\source\tramsitterStopwatch.c:775: while (BTN1 == 0);  // Wait for release
L031006?:
	jnb	_P2_5,L031006?
;	C:\Vincent\source\tramsitterStopwatch.c:776: waitms(100);
	mov	dptr,#0x0064
	push	ar2
	lcall	_waitms
	pop	ar2
	ljmp	L031038?
L031037?:
;	C:\Vincent\source\tramsitterStopwatch.c:781: else if (BTN2 == 0)
	jb	_P2_4,L031034?
;	C:\Vincent\source\tramsitterStopwatch.c:783: waitms(20);  // Debounce
	mov	dptr,#0x0014
	push	ar2
	lcall	_waitms
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:784: if (BTN2 == 0)
	jnb	_P2_4,L031112?
	ljmp	L031038?
L031112?:
;	C:\Vincent\source\tramsitterStopwatch.c:786: if (current_option == 0) current_option = 3;
	mov	a,r2
	jnz	L031012?
	mov	r2,#0x03
	sjmp	L031014?
L031012?:
;	C:\Vincent\source\tramsitterStopwatch.c:787: else current_option--;
	dec	r2
;	C:\Vincent\source\tramsitterStopwatch.c:789: while (BTN2 == 0);  // Wait for release
L031014?:
	jnb	_P2_4,L031014?
;	C:\Vincent\source\tramsitterStopwatch.c:790: waitms(100);
	mov	dptr,#0x0064
	push	ar2
	lcall	_waitms
	pop	ar2
	ljmp	L031038?
L031034?:
;	C:\Vincent\source\tramsitterStopwatch.c:795: else if (BTN3 == 0)
	jnb	_P2_6,L031115?
	ljmp	L031038?
L031115?:
;	C:\Vincent\source\tramsitterStopwatch.c:797: waitms(20);  // Debounce
	mov	dptr,#0x0014
	push	ar2
	lcall	_waitms
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:798: if (BTN3 == 0)
	jnb	_P2_6,L031116?
	ljmp	L031038?
L031116?:
;	C:\Vincent\source\tramsitterStopwatch.c:803: while (BTN3 == 0 && btn3_held < 1200)
	mov	r4,#0x00
	mov	r5,#0x00
L031020?:
	jb	_P2_6,L031022?
	clr	c
	mov	a,r4
	subb	a,#0xB0
	mov	a,r5
	subb	a,#0x04
	jnc	L031022?
;	C:\Vincent\source\tramsitterStopwatch.c:805: waitms(10);
	mov	dptr,#0x000A
	push	ar2
	push	ar4
	push	ar5
	lcall	_waitms
	pop	ar5
	pop	ar4
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:806: btn3_held += 10;
	mov	a,#0x0A
	add	a,r4
	mov	r4,a
	clr	a
	addc	a,r5
	mov	r5,a
	sjmp	L031020?
L031022?:
;	C:\Vincent\source\tramsitterStopwatch.c:809: if (btn3_held >= BTN3_LONG_MS)
	clr	c
	mov	a,r4
	subb	a,#0xE8
	mov	a,r5
	subb	a,#0x03
	jnc	L031119?
	ljmp	L031027?
L031119?:
;	C:\Vincent\source\tramsitterStopwatch.c:812: program_path[program_step] = current_option;
	mov	a,_program_step
	add	a,#_program_path
	mov	dpl,a
	clr	a
	addc	a,#(_program_path >> 8)
	mov	dph,a
	mov	a,r2
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:815: IR_LoopbackByte(CMD_PROG_STEP);
	mov	dpl,#0x61
	push	ar2
	lcall	_IR_LoopbackByte
;	C:\Vincent\source\tramsitterStopwatch.c:816: IR_LoopbackByte(program_step);
	mov	dpl,_program_step
	lcall	_IR_LoopbackByte
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:817: IR_LoopbackByte(current_option);
	mov	dpl,r2
	push	ar2
	lcall	_IR_LoopbackByte
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:818: IR_LoopbackByte((unsigned char)(0xFF - CMD_PROG_STEP - program_step - current_option));
	mov	a,#0x9E
	clr	c
	subb	a,_program_step
	clr	c
	subb	a,r2
	mov	dpl,a
	lcall	_IR_LoopbackByte
;	C:\Vincent\source\tramsitterStopwatch.c:819: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:820: waitms(100);  // INCREASED: Give STM32 time to beep
	mov	dptr,#0x0064
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:822: program_step++;
	inc	_program_step
;	C:\Vincent\source\tramsitterStopwatch.c:825: for (i = program_step; i < 8; i++)
	mov	r4,_program_step
L031057?:
	cjne	r4,#0x08,L031120?
L031120?:
	jc	L031121?
	ljmp	L031041?
L031121?:
;	C:\Vincent\source\tramsitterStopwatch.c:827: program_path[i] = 3;  // STOP
	mov	a,r4
	add	a,#_program_path
	mov	dpl,a
	clr	a
	addc	a,#(_program_path >> 8)
	mov	dph,a
	mov	a,#0x03
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:830: IR_LoopbackByte(CMD_PROG_STEP);
	mov	dpl,#0x61
	push	ar4
	lcall	_IR_LoopbackByte
	pop	ar4
;	C:\Vincent\source\tramsitterStopwatch.c:831: IR_LoopbackByte(i);
	mov	dpl,r4
	push	ar4
	lcall	_IR_LoopbackByte
;	C:\Vincent\source\tramsitterStopwatch.c:832: IR_LoopbackByte(3);  // STOP
	mov	dpl,#0x03
	lcall	_IR_LoopbackByte
	pop	ar4
;	C:\Vincent\source\tramsitterStopwatch.c:833: IR_LoopbackByte((unsigned char)(0xFF - CMD_PROG_STEP - i - 3));
	mov	a,#0x9B
	clr	c
	subb	a,r4
	mov	dpl,a
	push	ar4
	lcall	_IR_LoopbackByte
;	C:\Vincent\source\tramsitterStopwatch.c:834: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:835: waitms(100);  // INCREASED: Give STM32 time to beep
	mov	dptr,#0x0064
	lcall	_waitms
	pop	ar4
;	C:\Vincent\source\tramsitterStopwatch.c:825: for (i = program_step; i < 8; i++)
	inc	r4
;	C:\Vincent\source\tramsitterStopwatch.c:839: break;
	sjmp	L031057?
L031027?:
;	C:\Vincent\source\tramsitterStopwatch.c:844: program_path[program_step] = current_option;
	mov	a,_program_step
	add	a,#_program_path
	mov	dpl,a
	clr	a
	addc	a,#(_program_path >> 8)
	mov	dph,a
	mov	a,r2
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:847: IR_LoopbackByte(CMD_PROG_STEP);
	mov	dpl,#0x61
	push	ar2
	lcall	_IR_LoopbackByte
;	C:\Vincent\source\tramsitterStopwatch.c:848: IR_LoopbackByte(program_step);
	mov	dpl,_program_step
	lcall	_IR_LoopbackByte
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:849: IR_LoopbackByte(current_option);
	mov	dpl,r2
	push	ar2
	lcall	_IR_LoopbackByte
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:850: IR_LoopbackByte((unsigned char)(0xFF - CMD_PROG_STEP - program_step - current_option));
	mov	a,#0x9E
	clr	c
	subb	a,_program_step
	clr	c
	subb	a,r2
	mov	dpl,a
	lcall	_IR_LoopbackByte
;	C:\Vincent\source\tramsitterStopwatch.c:851: IR_TX = 0;
	clr	_P1_4
;	C:\Vincent\source\tramsitterStopwatch.c:852: waitms(100);  // INCREASED: Give STM32 time to beep
	mov	dptr,#0x0064
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:854: program_step++;
	inc	_program_step
;	C:\Vincent\source\tramsitterStopwatch.c:857: current_option = 3;
	mov	r2,#0x03
;	C:\Vincent\source\tramsitterStopwatch.c:859: while (BTN3 == 0);  // Wait for release
L031023?:
	jnb	_P2_6,L031023?
;	C:\Vincent\source\tramsitterStopwatch.c:860: waitms(100);
	mov	dptr,#0x0064
	push	ar2
	lcall	_waitms
	pop	ar2
L031038?:
;	C:\Vincent\source\tramsitterStopwatch.c:865: waitms(50);
	mov	dptr,#0x0032
	push	ar2
	lcall	_waitms
	pop	ar2
	ljmp	L031039?
L031041?:
;	C:\Vincent\source\tramsitterStopwatch.c:869: rx_ack = IR_LoopbackPacket(CMD_PROG_END);
	mov	dpl,#0x62
	lcall	_IR_LoopbackPacket
	mov	r3,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:870: waitms(100);  // Give STM32 time to beep 3 times
	mov	dptr,#0x0064
	push	ar3
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:873: LCDprint("Path 4 Saved!   ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_25
	mov	b,#0x80
	lcall	_LCDprint
	pop	ar3
;	C:\Vincent\source\tramsitterStopwatch.c:874: if (rx_ack == CMD_PROG_END) {
	cjne	r3,#0x62,L031043?
;	C:\Vincent\source\tramsitterStopwatch.c:875: LCDprint("Path Received    ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_26
	mov	b,#0x80
	lcall	_LCDprint
	sjmp	L031044?
L031043?:
;	C:\Vincent\source\tramsitterStopwatch.c:877: LCDprint("Loading...      ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_24
	mov	b,#0x80
	lcall	_LCDprint
L031044?:
;	C:\Vincent\source\tramsitterStopwatch.c:879: waitms(1500);
	mov	dptr,#0x05DC
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;cmd                       Allocated to registers r2 
;rx                        Allocated to registers 
;last_joystick             Allocated to registers 
;urx                       Allocated to registers r3 r4 
;ury                       Allocated to registers r5 r6 
;i                         Allocated with name '_main_i_1_176'
;btn1_held                 Allocated to registers r2 r3 
;btn2_held                 Allocated to registers r2 r3 
;btn3_held                 Allocated to registers r2 r3 
;entered_pass              Allocated to registers r2 
;battery_percent           Allocated to registers r2 
;battery_percent_carr      Allocated with name '_main_battery_percent_carr_1_176'
;carr_idx                  Allocated to registers r2 r3 
;line2                     Allocated with name '_main_line2_1_176'
;------------------------------------------------------------
;	C:\Vincent\source\tramsitterStopwatch.c:885: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Vincent\source\tramsitterStopwatch.c:897: InitPinADC(2, 1);  // Joystick X
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Vincent\source\tramsitterStopwatch.c:898: InitPinADC(2, 2);  // Joystick Y
	mov	_InitPinADC_PARM_2,#0x02
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Vincent\source\tramsitterStopwatch.c:899: InitPinADC(1, 6);  // Battery voltage
	mov	_InitPinADC_PARM_2,#0x06
	mov	dpl,#0x01
	lcall	_InitPinADC
;	C:\Vincent\source\tramsitterStopwatch.c:900: InitADC();
	lcall	_InitADC
;	C:\Vincent\source\tramsitterStopwatch.c:901: waitms(300);
	mov	dptr,#0x012C
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:902: LCD_4BIT();
	lcall	_LCD_4BIT
;	C:\Vincent\source\tramsitterStopwatch.c:905: Init_Timer2_1Hz();
	lcall	_Init_Timer2_1Hz
;	C:\Vincent\source\tramsitterStopwatch.c:906: EA = 1;  // Enable global interrupts
	setb	_EA
;	C:\Vincent\source\tramsitterStopwatch.c:911: LCDprint("Set Password:   ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_27
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:912: LCDprint("Pass: 0000      ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_28
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:913: waitms(1000);
	mov	dptr,#0x03E8
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:915: saved_password = Password_Entry_Screen("Set Password:   ");
	mov	dptr,#__str_27
	mov	b,#0x80
	lcall	_Password_Entry_Screen
	mov	_saved_password,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:916: password_set = 1;
	setb	_password_set
;	C:\Vincent\source\tramsitterStopwatch.c:919: LCDprint("Password Set!   ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_29
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:920: waitms(1000);
	mov	dptr,#0x03E8
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:925: for (i=0; i<30; i++) {
	mov	_main_i_1_176,#0x00
L032093?:
	mov	a,#0x100 - 0x1E
	add	a,_main_i_1_176
	jnc	L032169?
	ljmp	L032096?
L032169?:
;	C:\Vincent\source\tramsitterStopwatch.c:926: urx = ADC_at_Pin(JOY_URX_CH);
	mov	dpl,#0x0E
	lcall	_ADC_at_Pin
	mov	r3,dpl
	mov	r4,dph
;	C:\Vincent\source\tramsitterStopwatch.c:927: ury = ADC_at_Pin(JOY_URY_CH);
	mov	dpl,#0x0F
	push	ar3
	push	ar4
	lcall	_ADC_at_Pin
	mov	r5,dpl
	mov	r6,dph
	pop	ar4
	pop	ar3
;	C:\Vincent\source\tramsitterStopwatch.c:928: line2[0]='X'; line2[1]='=';
	mov	dptr,#_main_line2_1_176
	mov	a,#0x58
	movx	@dptr,a
	mov	dptr,#(_main_line2_1_176 + 0x0001)
	mov	a,#0x3D
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:929: line2[2]='0'+((urx/10000)%10);
	mov	__divuint_PARM_2,#0x10
	mov	(__divuint_PARM_2 + 1),#0x27
	mov	dpl,r3
	mov	dph,r4
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	__divuint
	mov	r7,dpl
	mov	r2,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r7
	mov	dph,r2
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x0002)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:930: line2[3]='0'+((urx/1000)%10);
	mov	__divuint_PARM_2,#0xE8
	mov	(__divuint_PARM_2 + 1),#0x03
	mov	dpl,r3
	mov	dph,r4
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	__divuint
	mov	r2,dpl
	mov	r7,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r7
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x0003)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:931: line2[4]='0'+((urx/100)%10);
	mov	__divuint_PARM_2,#0x64
	clr	a
	mov	(__divuint_PARM_2 + 1),a
	mov	dpl,r3
	mov	dph,r4
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	__divuint
	mov	r2,dpl
	mov	r7,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r7
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x0004)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:932: line2[5]='0'+((urx/10)%10);
	mov	__divuint_PARM_2,#0x0A
	clr	a
	mov	(__divuint_PARM_2 + 1),a
	mov	dpl,r3
	mov	dph,r4
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	__divuint
	mov	r2,dpl
	mov	r7,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r7
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x0005)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:933: line2[6]='0'+(urx%10);
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r3
	mov	dph,r4
	push	ar5
	push	ar6
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x0006)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:934: line2[7]=' ';
	mov	dptr,#(_main_line2_1_176 + 0x0007)
	mov	a,#0x20
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:935: line2[8]='Y'; line2[9]='=';
	mov	dptr,#(_main_line2_1_176 + 0x0008)
	mov	a,#0x59
	movx	@dptr,a
	mov	dptr,#(_main_line2_1_176 + 0x0009)
	mov	a,#0x3D
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:936: line2[10]='0'+((ury/10000)%10);
	mov	__divuint_PARM_2,#0x10
	mov	(__divuint_PARM_2 + 1),#0x27
	mov	dpl,r5
	mov	dph,r6
	push	ar5
	push	ar6
	lcall	__divuint
	mov	r2,dpl
	mov	r3,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x000a)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:937: line2[11]='0'+((ury/1000)%10);
	mov	__divuint_PARM_2,#0xE8
	mov	(__divuint_PARM_2 + 1),#0x03
	mov	dpl,r5
	mov	dph,r6
	push	ar5
	push	ar6
	lcall	__divuint
	mov	r2,dpl
	mov	r3,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x000b)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:938: line2[12]='0'+((ury/100)%10);
	mov	__divuint_PARM_2,#0x64
	clr	a
	mov	(__divuint_PARM_2 + 1),a
	mov	dpl,r5
	mov	dph,r6
	push	ar5
	push	ar6
	lcall	__divuint
	mov	r2,dpl
	mov	r3,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x000c)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:939: line2[13]='0'+((ury/10)%10);
	mov	__divuint_PARM_2,#0x0A
	clr	a
	mov	(__divuint_PARM_2 + 1),a
	mov	dpl,r5
	mov	dph,r6
	push	ar5
	push	ar6
	lcall	__divuint
	mov	r2,dpl
	mov	r3,dph
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__moduint
	mov	r2,dpl
	pop	ar6
	pop	ar5
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x000d)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:940: line2[14]='0'+(ury%10);
	mov	__moduint_PARM_2,#0x0A
	clr	a
	mov	(__moduint_PARM_2 + 1),a
	mov	dpl,r5
	mov	dph,r6
	lcall	__moduint
	mov	r2,dpl
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_main_line2_1_176 + 0x000e)
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:941: line2[15]=' '; line2[16]=0;
	mov	dptr,#(_main_line2_1_176 + 0x000f)
	mov	a,#0x20
	movx	@dptr,a
	mov	dptr,#(_main_line2_1_176 + 0x0010)
	clr	a
	movx	@dptr,a
;	C:\Vincent\source\tramsitterStopwatch.c:942: LCDprint("ADC OK-MOVE JOY ", 1, 0);
	mov	_LCDprint_PARM_2,#0x01
	clr	_LCDprint_PARM_3
	mov	dptr,#__str_30
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:943: LCDprint(line2, 2, 0);
	mov	_LCDprint_PARM_2,#0x02
	clr	_LCDprint_PARM_3
	mov	dptr,#_main_line2_1_176
	mov	b,#0x00
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:944: waitms(100);
	mov	dptr,#0x0064
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:925: for (i=0; i<30; i++) {
	inc	_main_i_1_176
	ljmp	L032093?
L032096?:
;	C:\Vincent\source\tramsitterStopwatch.c:947: last_joystick = Read_Joystick();
	lcall	_Read_Joystick
;	C:\Vincent\source\tramsitterStopwatch.c:948: LCDprint(">STOP          < ", 1, 0);
	mov	_LCDprint_PARM_2,#0x01
	clr	_LCDprint_PARM_3
	mov	dptr,#__str_31
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:949: Update_Status_Line();
	lcall	_Update_Status_Line
;	C:\Vincent\source\tramsitterStopwatch.c:950: waitms(300);
	mov	dptr,#0x012C
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:955: while (1)
L032091?:
;	C:\Vincent\source\tramsitterStopwatch.c:960: if (auto_mode && timer_tick) {
	jnb	_auto_mode,L032002?
;	C:\Vincent\source\tramsitterStopwatch.c:961: timer_tick = 0;
	jbc	_timer_tick,L032171?
	sjmp	L032002?
L032171?:
;	C:\Vincent\source\tramsitterStopwatch.c:962: stopwatch_seconds++;
	inc	_stopwatch_seconds
	clr	a
	cjne	a,_stopwatch_seconds,L032172?
	inc	(_stopwatch_seconds + 1)
L032172?:
;	C:\Vincent\source\tramsitterStopwatch.c:963: Update_Stopwatch_Display();
	lcall	_Update_Stopwatch_Display
L032002?:
;	C:\Vincent\source\tramsitterStopwatch.c:969: if (is_locked)
	jnb	_is_locked,L032008?
;	C:\Vincent\source\tramsitterStopwatch.c:971: entered_pass = Password_Entry_Screen("LOCKED          ");
	mov	dptr,#__str_32
	mov	b,#0x80
	lcall	_Password_Entry_Screen
;	C:\Vincent\source\tramsitterStopwatch.c:974: if (entered_pass == saved_password)
	mov	a,dpl
	mov	r2,a
	cjne	a,_saved_password,L032005?
;	C:\Vincent\source\tramsitterStopwatch.c:977: is_locked = 0;
	clr	_is_locked
;	C:\Vincent\source\tramsitterStopwatch.c:978: LCDprint("Unlocked        ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_33
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:979: LCDprint("Returning...    ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_34
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:980: waitms(1000);
	mov	dptr,#0x03E8
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:981: LCDprint("STOP            ", 1, 0);
	mov	_LCDprint_PARM_2,#0x01
	clr	_LCDprint_PARM_3
	mov	dptr,#__str_35
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:982: Update_Status_Line();
	lcall	_Update_Status_Line
	sjmp	L032091?
L032005?:
;	C:\Vincent\source\tramsitterStopwatch.c:987: LCDprint("Wrong Password  ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_36
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:988: LCDprint("Try Again       ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_37
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:989: waitms(1000);
	mov	dptr,#0x03E8
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:992: continue;  // Skip rest of main loop
	ljmp	L032091?
L032008?:
;	C:\Vincent\source\tramsitterStopwatch.c:1000: if (auto_mode == 1)
	jnb	_auto_mode,L032028?
;	C:\Vincent\source\tramsitterStopwatch.c:1003: if (BTN3 == 0)
	jnb	_P2_6,L032177?
	ljmp	L032029?
L032177?:
;	C:\Vincent\source\tramsitterStopwatch.c:1005: IR_LoopbackPacket(CMD_PAUSE);
	mov	dpl,#0x40
	lcall	_IR_LoopbackPacket
;	C:\Vincent\source\tramsitterStopwatch.c:1006: Show_Command(CMD_PAUSE);
	mov	dpl,#0x40
	lcall	_Show_Command
;	C:\Vincent\source\tramsitterStopwatch.c:1008: while (BTN3 == 0) {
L032009?:
	jb	_P2_6,L032011?
;	C:\Vincent\source\tramsitterStopwatch.c:1009: waitms(20); 
	mov	dptr,#0x0014
	lcall	_waitms
	sjmp	L032009?
L032011?:
;	C:\Vincent\source\tramsitterStopwatch.c:1012: IR_LoopbackPacket(CMD_RESUME);
	mov	dpl,#0x41
	lcall	_IR_LoopbackPacket
;	C:\Vincent\source\tramsitterStopwatch.c:1013: Show_Command(CMD_RESUME);
	mov	dpl,#0x41
	lcall	_Show_Command
;	C:\Vincent\source\tramsitterStopwatch.c:1014: waitms(200);
	mov	dptr,#0x00C8
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:1015: Update_Status_Line();
	lcall	_Update_Status_Line
	sjmp	L032029?
L032028?:
;	C:\Vincent\source\tramsitterStopwatch.c:1021: if (BTN3 == 0)
	jb	_P2_6,L032029?
;	C:\Vincent\source\tramsitterStopwatch.c:1023: waitms(20);  // Debounce
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:1024: if (BTN3 == 0)
	jb	_P2_6,L032029?
;	C:\Vincent\source\tramsitterStopwatch.c:1027: while (BTN3 == 0 && btn3_held < 1200)
	mov	r2,#0x00
	mov	r3,#0x00
L032015?:
	jb	_P2_6,L032017?
	clr	c
	mov	a,r2
	subb	a,#0xB0
	mov	a,r3
	subb	a,#0x04
	jnc	L032017?
;	C:\Vincent\source\tramsitterStopwatch.c:1029: waitms(10);
	mov	dptr,#0x000A
	push	ar2
	push	ar3
	lcall	_waitms
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:1030: btn3_held += 10;
	mov	a,#0x0A
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	sjmp	L032015?
L032017?:
;	C:\Vincent\source\tramsitterStopwatch.c:1033: if (btn3_held >= BTN3_LONG_MS)
	clr	c
	mov	a,r2
	subb	a,#0xE8
	mov	a,r3
	subb	a,#0x03
	jc	L032020?
;	C:\Vincent\source\tramsitterStopwatch.c:1036: is_locked = 1;
	setb	_is_locked
;	C:\Vincent\source\tramsitterStopwatch.c:1037: LCDprint("Locking...      ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_38
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:1038: waitms(500);
	mov	dptr,#0x01F4
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:1040: continue;
	ljmp	L032091?
;	C:\Vincent\source\tramsitterStopwatch.c:1043: while (BTN3 == 0);  // Wait for release
L032020?:
	jnb	_P2_6,L032020?
L032029?:
;	C:\Vincent\source\tramsitterStopwatch.c:1051: if (BTN1 == 0)
	jnb	_P2_5,L032185?
	ljmp	L032088?
L032185?:
;	C:\Vincent\source\tramsitterStopwatch.c:1053: waitms(20);  // Debounce
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:1054: if (BTN1 == 0)
	jnb	_P2_5,L032186?
	ljmp	L032089?
L032186?:
;	C:\Vincent\source\tramsitterStopwatch.c:1057: if (auto_mode == 0)
	jb	_auto_mode,L032047?
;	C:\Vincent\source\tramsitterStopwatch.c:1060: while (BTN1 == 0 && btn1_held < 1000)
	mov	r2,#0x00
	mov	r3,#0x00
L032031?:
	jb	_P2_5,L032033?
	clr	c
	mov	a,r2
	subb	a,#0xE8
	mov	a,r3
	subb	a,#0x03
	jnc	L032033?
;	C:\Vincent\source\tramsitterStopwatch.c:1062: waitms(10);
	mov	dptr,#0x000A
	push	ar2
	push	ar3
	lcall	_waitms
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:1063: btn1_held += 10;
	mov	a,#0x0A
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	sjmp	L032031?
L032033?:
;	C:\Vincent\source\tramsitterStopwatch.c:1066: if (btn1_held >= BTN1_LONG_MS)
	clr	c
	mov	a,r2
	subb	a,#0x20
	mov	a,r3
	subb	a,#0x03
	jc	L032041?
;	C:\Vincent\source\tramsitterStopwatch.c:1069: while (BTN1 == 0);  // Wait for release
L032034?:
	jnb	_P2_5,L032034?
;	C:\Vincent\source\tramsitterStopwatch.c:1070: Program_Mode();
	lcall	_Program_Mode
;	C:\Vincent\source\tramsitterStopwatch.c:1073: LCDprint("STOP            ", 1, 0);
	mov	_LCDprint_PARM_2,#0x01
	clr	_LCDprint_PARM_3
	mov	dptr,#__str_35
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Vincent\source\tramsitterStopwatch.c:1074: Update_Status_Line();
	lcall	_Update_Status_Line
;	C:\Vincent\source\tramsitterStopwatch.c:1075: waitms(100);
	mov	dptr,#0x0064
	lcall	_waitms
	ljmp	L032089?
L032041?:
;	C:\Vincent\source\tramsitterStopwatch.c:1080: rx = IR_LoopbackPacket(CMD_HORN);
	mov	dpl,#0x20
	lcall	_IR_LoopbackPacket
;	C:\Vincent\source\tramsitterStopwatch.c:1081: Show_Command(CMD_HORN);
	mov	dpl,#0x20
	lcall	_Show_Command
;	C:\Vincent\source\tramsitterStopwatch.c:1082: while (BTN1 == 0);  // Wait for release
L032037?:
	jnb	_P2_5,L032037?
;	C:\Vincent\source\tramsitterStopwatch.c:1083: waitms(200);
	mov	dptr,#0x00C8
	lcall	_waitms
	ljmp	L032089?
L032047?:
;	C:\Vincent\source\tramsitterStopwatch.c:1089: rx = IR_LoopbackPacket(CMD_HORN);
	mov	dpl,#0x20
	lcall	_IR_LoopbackPacket
;	C:\Vincent\source\tramsitterStopwatch.c:1090: Show_Command(CMD_HORN);
	mov	dpl,#0x20
	lcall	_Show_Command
;	C:\Vincent\source\tramsitterStopwatch.c:1091: while (BTN1 == 0);  // Wait for release
L032043?:
	jnb	_P2_5,L032043?
;	C:\Vincent\source\tramsitterStopwatch.c:1092: waitms(200);
	mov	dptr,#0x00C8
	lcall	_waitms
	ljmp	L032089?
L032088?:
;	C:\Vincent\source\tramsitterStopwatch.c:1101: else if (BTN2 == 0)
	jnb	_P2_4,L032194?
	ljmp	L032085?
L032194?:
;	C:\Vincent\source\tramsitterStopwatch.c:1103: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:1104: if (BTN2 == 0)
	jnb	_P2_4,L032195?
	ljmp	L032089?
L032195?:
;	C:\Vincent\source\tramsitterStopwatch.c:1107: while (BTN2 == 0 && btn2_held < 600) {
	mov	r2,#0x00
	mov	r3,#0x00
L032052?:
	jb	_P2_4,L032054?
	clr	c
	mov	a,r2
	subb	a,#0x58
	mov	a,r3
	subb	a,#0x02
	jnc	L032054?
;	C:\Vincent\source\tramsitterStopwatch.c:1108: waitms(10);
	mov	dptr,#0x000A
	push	ar2
	push	ar3
	lcall	_waitms
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:1109: btn2_held += 10;
	mov	a,#0x0A
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	sjmp	L032052?
L032054?:
;	C:\Vincent\source\tramsitterStopwatch.c:1112: if (btn2_held >= BTN2_LONG_MS)
	clr	c
	mov	a,r2
	subb	a,#0xF4
	mov	a,r3
	subb	a,#0x01
	jc	L032066?
;	C:\Vincent\source\tramsitterStopwatch.c:1115: auto_mode = !auto_mode;
	cpl	_auto_mode
;	C:\Vincent\source\tramsitterStopwatch.c:1116: cmd = auto_mode ? CMD_AUTO_START : CMD_AUTO_STOP;
	jnb	_auto_mode,L032103?
	mov	r2,#0x30
	sjmp	L032104?
L032103?:
	mov	r2,#0x31
L032104?:
;	C:\Vincent\source\tramsitterStopwatch.c:1117: rx = IR_LoopbackPacket(cmd);
	mov	dpl,r2
	push	ar2
	lcall	_IR_LoopbackPacket
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:1118: Show_Command(cmd);
	mov	dpl,r2
	lcall	_Show_Command
;	C:\Vincent\source\tramsitterStopwatch.c:1120: if (auto_mode) {
	jnb	_auto_mode,L032067?
;	C:\Vincent\source\tramsitterStopwatch.c:1122: stopwatch_seconds = 0;
	clr	a
	mov	_stopwatch_seconds,a
	mov	(_stopwatch_seconds + 1),a
;	C:\Vincent\source\tramsitterStopwatch.c:1123: stopwatch_paused = 0;
	clr	_stopwatch_paused
;	C:\Vincent\source\tramsitterStopwatch.c:1124: Update_Stopwatch_Display();
	lcall	_Update_Stopwatch_Display
;	C:\Vincent\source\tramsitterStopwatch.c:1125: waitms(100);
	mov	dptr,#0x0064
	lcall	_waitms
	sjmp	L032067?
L032066?:
;	C:\Vincent\source\tramsitterStopwatch.c:1131: if (auto_mode == 1) {
	jnb	_auto_mode,L032063?
;	C:\Vincent\source\tramsitterStopwatch.c:1133: stopwatch_paused = !stopwatch_paused;
	cpl	_stopwatch_paused
;	C:\Vincent\source\tramsitterStopwatch.c:1134: if (stopwatch_paused) {
	jnb	_stopwatch_paused,L032058?
;	C:\Vincent\source\tramsitterStopwatch.c:1135: LCDprint("Time: PAUSED    ", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_39
	mov	b,#0x80
	lcall	_LCDprint
	sjmp	L032059?
L032058?:
;	C:\Vincent\source\tramsitterStopwatch.c:1137: Update_Stopwatch_Display();
	lcall	_Update_Stopwatch_Display
L032059?:
;	C:\Vincent\source\tramsitterStopwatch.c:1139: waitms(200);
	mov	dptr,#0x00C8
	lcall	_waitms
	sjmp	L032067?
L032063?:
;	C:\Vincent\source\tramsitterStopwatch.c:1143: current_path++;
	inc	_current_path
;	C:\Vincent\source\tramsitterStopwatch.c:1144: if (current_path > 4) current_path = 1;  // NOW cycles 1-4
	mov	a,_current_path
	add	a,#0xff - 0x04
	jnc	L032061?
	mov	_current_path,#0x01
L032061?:
;	C:\Vincent\source\tramsitterStopwatch.c:1146: cmd = (current_path == 1) ? CMD_PATH_1 :
	mov	a,#0x01
	cjne	a,_current_path,L032105?
	mov	r3,#0x10
	sjmp	L032106?
L032105?:
;	C:\Vincent\source\tramsitterStopwatch.c:1147: (current_path == 2) ? CMD_PATH_2 :
	mov	a,#0x02
	cjne	a,_current_path,L032107?
	mov	r4,#0x11
	sjmp	L032108?
L032107?:
;	C:\Vincent\source\tramsitterStopwatch.c:1148: (current_path == 3) ? CMD_PATH_3 : CMD_PATH_4;
	mov	a,#0x03
	cjne	a,_current_path,L032109?
	mov	r5,#0x12
	sjmp	L032110?
L032109?:
	mov	r5,#0x13
L032110?:
	mov	ar4,r5
L032108?:
	mov	ar3,r4
L032106?:
	mov	ar2,r3
;	C:\Vincent\source\tramsitterStopwatch.c:1150: rx = IR_LoopbackPacket(cmd);
	mov	dpl,r2
	push	ar2
	lcall	_IR_LoopbackPacket
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:1151: Show_Command(cmd);
	mov	dpl,r2
	lcall	_Show_Command
L032067?:
;	C:\Vincent\source\tramsitterStopwatch.c:1155: Update_Status_Line();
	lcall	_Update_Status_Line
;	C:\Vincent\source\tramsitterStopwatch.c:1156: while (BTN2 == 0);
L032068?:
	jnb	_P2_4,L032068?
	sjmp	L032089?
L032085?:
;	C:\Vincent\source\tramsitterStopwatch.c:1163: else if (JOY_SW == 0)
	jb	_P2_3,L032082?
;	C:\Vincent\source\tramsitterStopwatch.c:1165: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:1166: if (JOY_SW == 0)
	jb	_P2_3,L032089?
;	C:\Vincent\source\tramsitterStopwatch.c:1168: rx = IR_LoopbackPacket(CMD_ROTATE_180);
	mov	dpl,#0x06
	lcall	_IR_LoopbackPacket
;	C:\Vincent\source\tramsitterStopwatch.c:1169: Show_Command(CMD_ROTATE_180);
	mov	dpl,#0x06
	lcall	_Show_Command
;	C:\Vincent\source\tramsitterStopwatch.c:1170: waitms(200);
	mov	dptr,#0x00C8
	lcall	_waitms
;	C:\Vincent\source\tramsitterStopwatch.c:1171: while (JOY_SW == 0);
L032073?:
	jnb	_P2_3,L032073?
	sjmp	L032089?
L032082?:
;	C:\Vincent\source\tramsitterStopwatch.c:1180: if (auto_mode) {
	jb	_auto_mode,L032089?
;	C:\Vincent\source\tramsitterStopwatch.c:1185: Send_Joystick_Proportional();
	lcall	_Send_Joystick_Proportional
L032089?:
;	C:\Vincent\source\tramsitterStopwatch.c:1191: battery_percent = Get_Battery_Percent();
	lcall	_Get_Battery_Percent
	mov	r2,dpl
;	C:\Vincent\source\tramsitterStopwatch.c:1192: battery_percent_carr[0] = '0' + (battery_percent / 100) % 10;
	mov	b,#0x64
	mov	a,r2
	div	ab
	mov	b,#0x0A
	div	ab
	mov	a,b
	add	a,#0x30
	mov	_main_battery_percent_carr_1_176,a
;	C:\Vincent\source\tramsitterStopwatch.c:1193: battery_percent_carr[1] = '0' + (battery_percent / 10) % 10;
	mov	b,#0x0A
	mov	a,r2
	div	ab
	mov	b,#0x0A
	div	ab
	mov	a,b
	add	a,#0x30
	mov	(_main_battery_percent_carr_1_176 + 0x0001),a
;	C:\Vincent\source\tramsitterStopwatch.c:1194: battery_percent_carr[2] = '0' + battery_percent % 10;
	mov	b,#0x0A
	mov	a,r2
	div	ab
	mov	a,b
	add	a,#0x30
	mov	(_main_battery_percent_carr_1_176 + 0x0002),a
;	C:\Vincent\source\tramsitterStopwatch.c:1195: for (carr_idx = 0; carr_idx < sizeof(battery_percent_carr) / sizeof(char); carr_idx++)
	mov	r2,#0x00
	mov	r3,#0x00
L032097?:
	clr	c
	mov	a,r2
	subb	a,#0x03
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L032100?
;	C:\Vincent\source\tramsitterStopwatch.c:1197: putchar(battery_percent_carr[carr_idx]);
	mov	a,r2
	add	a,#_main_battery_percent_carr_1_176
	mov	r0,a
	mov	dpl,@r0
	push	ar2
	push	ar3
	lcall	_putchar
	pop	ar3
	pop	ar2
;	C:\Vincent\source\tramsitterStopwatch.c:1195: for (carr_idx = 0; carr_idx < sizeof(battery_percent_carr) / sizeof(char); carr_idx++)
	inc	r2
	cjne	r2,#0x00,L032097?
	inc	r3
	sjmp	L032097?
L032100?:
;	C:\Vincent\source\tramsitterStopwatch.c:1200: putchar(' ');
	mov	dpl,#0x20
	lcall	_putchar
;	C:\Vincent\source\tramsitterStopwatch.c:1201: putchar(auto_mode + '0');
	mov	c,_auto_mode
	clr	a
	rlc	a
	add	a,#0x30
	mov	dpl,a
	lcall	_putchar
;	C:\Vincent\source\tramsitterStopwatch.c:1203: putchar(' ');
	mov	dpl,#0x20
	lcall	_putchar
;	C:\Vincent\source\tramsitterStopwatch.c:1204: putchar(current_path + '0');
	mov	a,#0x30
	add	a,_current_path
	mov	dpl,a
	lcall	_putchar
;	C:\Vincent\source\tramsitterStopwatch.c:1206: putchar('\n');
	mov	dpl,#0x0A
	lcall	_putchar
;	C:\Vincent\source\tramsitterStopwatch.c:1208: waitms(80);
	mov	dptr,#0x0050
	lcall	_waitms
	ljmp	L032091?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 'AUTO   || '
	db 0x00
__str_1:
	db 'MANUAL || '
	db 0x00
__str_2:
	db 'STOP    '
	db 0x00
__str_3:
	db 'FORWARD  '
	db 0x00
__str_4:
	db 'BACKWARD '
	db 0x00
__str_5:
	db 'LEFT     '
	db 0x00
__str_6:
	db 'RIGHT    '
	db 0x00
__str_7:
	db 'ROT 180  '
	db 0x00
__str_8:
	db 'PATH  1  '
	db 0x00
__str_9:
	db 'PATH  2  '
	db 0x00
__str_10:
	db 'PATH  3  '
	db 0x00
__str_11:
	db 'PATH  4  '
	db 0x00
__str_12:
	db 'AUTO  ON '
	db 0x00
__str_13:
	db 'AUTO OFF '
	db 0x00
__str_14:
	db 'PAUSED   '
	db 0x00
__str_15:
	db 'RESUMING '
	db 0x00
__str_16:
	db 'HORN!!   '
	db 0x00
__str_17:
	db '???      '
	db 0x00
__str_18:
	db 'FORWARD '
	db 0x00
__str_19:
	db 'LEFT    '
	db 0x00
__str_20:
	db 'RIGHT   '
	db 0x00
__str_21:
	db '???     '
	db 0x00
__str_22:
	db 'Program Mode:   '
	db 0x00
__str_23:
	db 'STM32 Ready!    '
	db 0x00
__str_24:
	db 'Loading...      '
	db 0x00
__str_25:
	db 'Path 4 Saved!   '
	db 0x00
__str_26:
	db 'Path Received    '
	db 0x00
__str_27:
	db 'Set Password:   '
	db 0x00
__str_28:
	db 'Pass: 0000      '
	db 0x00
__str_29:
	db 'Password Set!   '
	db 0x00
__str_30:
	db 'ADC OK-MOVE JOY '
	db 0x00
__str_31:
	db '>STOP          < '
	db 0x00
__str_32:
	db 'LOCKED          '
	db 0x00
__str_33:
	db 'Unlocked        '
	db 0x00
__str_34:
	db 'Returning...    '
	db 0x00
__str_35:
	db 'STOP            '
	db 0x00
__str_36:
	db 'Wrong Password  '
	db 0x00
__str_37:
	db 'Try Again       '
	db 0x00
__str_38:
	db 'Locking...      '
	db 0x00
__str_39:
	db 'Time: PAUSED    '
	db 0x00

	CSEG

end
