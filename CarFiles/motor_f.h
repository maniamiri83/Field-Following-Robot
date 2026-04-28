#ifndef MOTOR_F_H
#define MOTOR_F_H

#include "../Common/Include/stm32l051xx.h"
#include <stdint.h>

// ----------------------------------------------------------------
// Globals updated by receiver.c
// ----------------------------------------------------------------
extern volatile unsigned char auto_running;
extern unsigned char          auto_intersection_cnt;
extern unsigned char          auto_in_intersection;
extern volatile int left_speed;
extern volatile int right_speed;
extern volatile int left_dir;
extern volatile int right_dir;

// ----------------------------------------------------------------
// Motor control functions
// ----------------------------------------------------------------
void motor_init(void);
void motor_stop(void);
void left_wheel_forward(void);
void left_wheel_backward(void);
void right_wheel_forward(void);
void right_wheel_backward(void);
void left_wheel_stop(void);
void right_wheel_stop(void);
void motor_rotate_180(void);

// ----------------------------------------------------------------
// Field following calibration constants
// Measured from physical hardware – update if inductors are moved.
// ----------------------------------------------------------------
#define AUTO_FIELD_L_CH      8u      // PB0  left inductor ADC channel
#define AUTO_FIELD_R_CH      9u      // PB1  right inductor ADC channel
#define AUTO_FIELD_C_CH      0u      // PA0  centre/intersection inductor
#define AUTO_D2_OFFSET     100u      // d2 natural hardware offset (subtract before comparing)
#define AUTO_THRESHOLD    1158u      // below this = no wire detected
#define AUTO_DEAD_BAND     150u      // |diff| must exceed this to steer

// Driving constants – tune on physical robot
#define AUTO_BASE_SPEED     60       // forward speed when centred (0-100)
#define AUTO_STEER_MAX      40       // max speed differential when steering
#define AUTO_MAX_SIGNAL   2230u      // max expected d1/d2 reading (on-wire peak)

// ----------------------------------------------------------------
// Auto mode functions
// ----------------------------------------------------------------
void auto_reset(void);
void auto_step(unsigned char robot_path, uint16_t d1, uint16_t d2, uint16_t d3);
void auto_stop(void);
void auto_hold_stop(void);

// ----------------------------------------------------------------
// NEW: Custom path 4 programming
// ----------------------------------------------------------------
void set_custom_path(const unsigned char *new_path);

#endif