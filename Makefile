NAME=FunTechTestApp

PROJECT_ROOT=.

all: $(NAME).elf

#What target to build for
include target.mk

OBJ += main.o
main.o: src/main.c
	@ echo ".compiling"
	$(CC) $(CFLAGS) src/main.c

$(NAME).elf: $(LINKFILE) $(OBJ)
	$(CC) $(LFLAGS) -o $@ $(OBJ)

.PHONY: clean 
clean:
	-rm -f $(NAME)
	-rm -f *.o *.elf
	-rm -f *.bin *.lst *.size *.symboltable *.map
