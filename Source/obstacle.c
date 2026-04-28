#include "obstacle.h"
#include "vl53l0x.h"

#define OBSTACLE_STOP_MM        150
#define OBSTACLE_CLEAR_MM       180
#define REQUIRED_HITS           3
#define REQUIRED_CLEAR_HITS     3

static uint16_t filtered_mm = 0;
static uint8_t initialized  = 0;
static uint8_t close_count  = 0;
static uint8_t clear_count  = 0;
static bool blocked = false;

void obstacle_reset(void)
{
    filtered_mm = 0;
    initialized = 0;
    close_count = 0;
    clear_count = 0;
    blocked = false;
}

uint16_t obstacle_get_filtered_mm(void)
{
    return filtered_mm;
}

bool obstacle_detected(uint16_t raw_range_mm)
{
    if (raw_range_mm == 0 || raw_range_mm == VL53L0X_OUT_OF_RANGE)
    {
        return blocked;
    }

    if (!initialized)
    {
        filtered_mm = raw_range_mm;
        initialized = 1;
    }
    else filtered_mm = (uint16_t)((3U * filtered_mm + raw_range_mm) / 4U);

    if (!blocked)
    {
        if (filtered_mm <= OBSTACLE_STOP_MM)
        {
            close_count++;
            if (close_count >= REQUIRED_HITS)
            {
                blocked = true;
                close_count = 0;
                clear_count = 0;
            }
        }
        else close_count = 0;

    }
    else
    {
        if (filtered_mm >= OBSTACLE_CLEAR_MM)
        {
            clear_count++;
            if (clear_count >= REQUIRED_CLEAR_HITS)
            {
                blocked = false;
                clear_count = 0;
                close_count = 0;
            }
        }
        else clear_count = 0;
    }
    return blocked;
}