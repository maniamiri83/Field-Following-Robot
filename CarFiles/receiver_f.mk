SHELL=cmd
CC=arm-none-eabi-gcc
AS=arm-none-eabi-as

# Use gcc as the linker instead of bare ld.
LD=arm-none-eabi-gcc

CCFLAGS=-mcpu=cortex-m0plus -mthumb -g
ASFLAGS=-mcpu=cortex-m0plus -mthumb -g

LDFLAGS=-mcpu=cortex-m0plus -mthumb \
        -T ../Common/LDscripts/stm32l051xx_simple.ld \
        -Wl,-Map,main.map -Wl,--cref \
        -nostartfiles \
        --specs=nosys.specs \
        -lc -lgcc

# ADDED vl53l0x.o and obstacle.o here
OBJS= startup.o main.o lcd.o motor.o vl53l0x.o obstacle.o

main.elf: $(OBJS)
	$(LD) $(OBJS) $(LDFLAGS) -o main.elf
	arm-none-eabi-objcopy -O ihex main.elf main.hex
	@echo Success!

main.o: receiver_f.c
	$(CC) -c $(CCFLAGS) receiver_f.c -o main.o

lcd.o: lcd.c
	$(CC) -c $(CCFLAGS) lcd.c -o lcd.o
	
motor.o: motor_f.c
	$(CC) -c $(CCFLAGS) motor_f.c -o motor.o

# NEW: Compilation rule for the ToF sensor
vl53l0x.o: vl53l0x.c
	$(CC) -c $(CCFLAGS) vl53l0x.c -o vl53l0x.o

# NEW: Compilation rule for obstacle detection
obstacle.o: obstacle.c
	$(CC) -c $(CCFLAGS) obstacle.c -o obstacle.o

serial.o: serial.c
	$(CC) -c $(CCFLAGS) serial.c -o serial.o

startup.o: startup.c
	$(CC) -c $(CCFLAGS) startup.c -o startup.o

clean:
	del $(OBJS)
	del main.elf main.hex main.map
	del *.lst

Flash_Load:
	@taskkill /f /im putty.exe /t /fi "status eq running" > NUL
	@echo C:\Vincent\source\STM32L051\stm32flash\stm32flash -w main.hex -v -g 0x0 ^^>loadf.bat
	@C:\Vincent\source\STM32L051\stm32flash\BO230\BO230 -b >>loadf.bat
	@loadf

explorer:
	@explorer .