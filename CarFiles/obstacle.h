#ifndef OBSTACLE_H
#define OBSTACLE_H

#include <stdint.h>
#include <stdbool.h>

void obstacle_reset(void);
bool obstacle_detected(uint16_t raw_range_mm);
uint16_t obstacle_get_filtered_mm(void);

#endif