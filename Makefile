CC      = arm-none-eabi-gcc
LD      = arm-none-eabi-gcc 
AR      = arm-none-eabi-ar
AS      = arm-none-eabi-as
CP      = arm-none-eabi-objcopy
OD      = arm-none-eabi-objdump

MCUFLAGS = -mcpu=cortex-m3 -mthumb 

CFLAGS  =  -I./ -c -fno-common -O0 -g $(MCUFLAGS) -mfix-cortex-m3-ldrd
AFLAGS  = -ahls $(MCUFLAGS) 
LFLAGS  = -Tsrc/stm32.ld -nostartfiles $(MCUFLAGS) -mfix-cortex-m3-ldrd

CPFLAGS = -Obinary
ODFLAGS = -S

all: main.bin

main.bin: main.elf
	@ echo "...copying"
	$(CP) $(CPFLAGS) main.elf main.bin
	$(OD) $(ODFLAGS) main.elf > main.lst

main.elf: src/stm32.ld main.o
	@ echo "..linking"
	$(LD) $(LFLAGS) -o main.elf main.o

main.o: src/main.c
	@ echo ".compiling"
	$(CC) $(CFLAGS) src/main.c


.PHONY: flash
flash: main.bin
	scripts/start_server.bsh
	scripts/do_flash.pl main.bin

.PHONY: clean 
clean:
	-rm -f main.o 
	-rm -f main.lst main.elf main.bin
