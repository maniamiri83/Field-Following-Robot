# Field-Following Robot with IR Remote Control

Dual-MCU embedded system: a wireless IR remote (EFM8 MCU) controls a car (STM32 MCU) that autonomously follows an AC-energized guide wire using inductive sensing. Custom IR protocol, proportional steering, obstacle avoidance, and a live Python telemetry GUI.

---

## Demo

https://m.youtube.com/watch?v=IZmT9Dlk98s&ra=m

---

## System Overview

Two independent battery-powered systems communicate over a custom IR link:

| Subsystem | MCU | Role |
|-----------|-----|------|
| Remote (Master) | EFM8LB12 | Joystick input → IR TX → LCD + UART telemetry |
| Car (Slave) | STM32L0 | IR RX → H-bridge motors + inductive auto-steering |

---

## Key Technical Features

### Custom IR Protocol (38 kHz, 2400 baud)
- Software-generated carrier using Timer 3 µs resolution (IR_HALF_US = 13 µs → 38.5 kHz)
- Two packet formats: 2-byte (standard commands) and 4-byte (joystick / path-programming), each with a 0xFF checksum for error detection
- Preamble of 32 toggled half-periods (~416 µs) for TSOP synchronization

### Joystick-to-Motor Mapping
- 12-bit SAR ADC double-samples each axis (first sample discarded for settling)
- Y-axis linearly scaled over 3630/3670 counts → signed base speed [-100, +100]
- X-axis scaled over 3630 counts → ±50 turning contribution; per-wheel speed clamped and packed into a single byte: `[7] direction | [6:0] speed magnitude`

### Inductive Track Following (Auto Mode)
- Three LC tank circuits tuned to the 17 kHz guide-wire frequency (left PB0, right PB1, center PA0)
- Proportional steering: `steer = |d1 - d2| × AUTO_STEER_MAX / AUTO_MAX_SIGNAL`, clamped to ±40
- Intersection detected when center coil exceeds threshold (1158 counts); car stops 200 ms, executes the path-table turn at AUTO_TURN_SPD = 50 for 1100 ms (~90°)
- Dead-band of 150 counts prevents jitter on straight sections

### H-Bridge Motor Drive
- PMOS/NMOS half-bridge topology (FU9024N / LU024N) — cross-conduction impossible by construction
- LTV846 quad optocoupler isolates MCU ground from motor supply, suppressing back-EMF transients
- PWM inversion handled in firmware to eliminate the need for a hardware inverter

### Obstacle Avoidance
- VL53L0X time-of-flight sensor over I2C; stop at 15 cm, resume at 18 cm (3 cm hysteresis to filter sensor noise)
- Sensor mounted low on the car for reliable detection of small obstacles

### Remote Features
- 3 pre-configured paths + 1 fully user-programmable path (stored as a turn sequence in `custom_path[]`, confirmed per step with a speaker beep)
- Password lock (binary entry via buttons 1/0), stopwatch for auto-run timing, real-time battery % on LCD
- UART serial stream → Python GUI (DearPyGui): battery bar, mode, selected path — polled 4×/second

---

## Hardware

| Component | Purpose |
|-----------|---------|
| STM32L0 | Car MCU — IR decode, PWM motor control, ADC inductive sensing |
| EFM8LB12 | Remote MCU — ADC joystick, IR TX, LCD, UART |
| TSOP33338 | 38 kHz IR demodulator (car) |
| SFH4546 | IR LED transmitter (remote) |
| LTV846 | Quad optocoupler — motor isolation |
| VL53L0X | I2C time-of-flight obstacle sensor |
| LM358 + MBR150 | Op-amp amplifier + peak detector for inductive coils |
| LU024N / FU9024N | NMOS / PMOS H-bridge transistors |
| 555 Timer | 17 kHz AC guide-wire current generator |

---

## Repository Structure

```
├── master/
│   └── ir_transmitter.c     # EFM8 remote — main loop, joystick ADC, IR TX, LCD, UART
├── slave/
│   ├── ir_receiver.c        # STM32 car — main loop, IR RX, command dispatch
│   ├── motor.c/h            # PWM ISR, proportional auto-steering, path table
│   ├── obstacle.c/h         # VL53L0X hysteresis filter, stop/resume logic
│   └── vl53l0x.h            # ToF sensor interface
├── gui/
│   └── rc_serial_reader_gui.py  # DearPyGui serial monitor
└── docs/                    # Circuit diagrams, block diagrams, report
```

> VL53L0X I2C driver (`vl53l0x.c`) adapted from [artfulbytes/vl6180x_vl53l0x_msp430](https://github.com/artfulbytes/vl6180x_vl53l0x_msp430) — not included here.

---

## Results

- Reliably tracked a figure-eight cardboard course at 76 mA RMS guide-wire current
- Obstacle detection responsive within one main loop iteration (~20 ms) after switching to continuous polling
- Non-angled inductor layout outperformed angled layout at intersections (no false turns on perpendicular wire)
- 180° turn calibrated to 2200 ms on cardboard surface
