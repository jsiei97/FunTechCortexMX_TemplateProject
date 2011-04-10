#include "config.h"

/*Top of stack*/
extern char _stack_start; //linker provides
#define STACK_TOP ( &_stack_start + STACK_SIZE )

/* Handler declarations */
void nmi_handler(void);
void hardfault_handler(void);
int start(void);				/* CPU startup (the name is convention) */

#define CODE_START (start+1)

/* Define the vector table */
unsigned int * myvectors[4]
   __attribute__ ((section("vectors")))= {
   	(unsigned int *)	STACK_TOP,			// stack pointer
   	(unsigned int *) 	CODE_START,			// code entry point
   	(unsigned int *)	nmi_handler,		// NMI handler (not really)
   	(unsigned int *)	hardfault_handler	// hard fault handler (let's hope not)
};

