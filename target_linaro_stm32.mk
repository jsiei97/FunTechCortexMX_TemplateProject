
PATH_TARGET_STM32=$(PROJECT_ROOT)/target/stm32/

CC      = arm-none-eabi-gcc
LD      = arm-none-eabi-gcc
AR      = arm-none-eabi-ar
AS      = arm-none-eabi-as
CP      = arm-none-eabi-objcopy
OD      = arm-none-eabi-objdump
NM      = arm-none-eabi-nm
SIZE    = arm-none-eabi-size

MCUFLAGS = -march=armv7-m -mcpu=cortex-m3 -mthumb
DEBUGFLAGS = -O0 -g
#DEBUGFLAGS = -O2

CFLAGS  = -Wall -Wextra -I./ -c -fno-common $(DEBUGFLAGS) $(MCUFLAGS) -mfix-cortex-m3-ldrd -DUNITY_OUTPUT_PRINT_RING -DUNITY_IGNORE_ARGS -DTARGET_STM32F103RB
AFLAGS  = -ahls $(MCUFLAGS)
LINKFILE = $(PATH_TARGET_STM32)/stm32.ld
LFLAGS  = -T$(LINKFILE) -nostartfiles $(MCUFLAGS) -mfix-cortex-m3-ldrd -Xlinker -Map=main.map

CPFLAGS = -Obinary
ODFLAGS = -S

CFLAGS+=-I$(PATH_TARGET_STM32)/src

OBJ += syscalls.o 
syscalls.o: $(PATH_TARGET_STM32)/syscalls.c
	@ echo ".compiling"
	$(CC) $(CFLAGS) -o $@ $<

OBJ += low_level_init.o
low_level_init.o: $(PATH_TARGET_STM32)/low_level_init.c
	$(CC) $(CFLAGS) -o $@ $<


# Create a bin file that can be put onto the mcu
$(NAME).bin: $(NAME).elf
	@ echo "...copying"
	$(CP) $(CPFLAGS) $(NAME).elf $(NAME).bin
	$(OD) $(ODFLAGS) $(NAME).elf > $(NAME).lst
	$(NM) -n $(NAME).elf > $(NAME).symboltable
	$(SIZE) $(NAME).elf > $(NAME).size

# Flash using OpenOCDh
.PHONY: flash
flash: $(NAME).bin
	scripts/start_server.bsh
	scripts/do_flash.pl $(NAME).bin

