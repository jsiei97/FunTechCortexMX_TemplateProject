
#include "config.h"

/* Define the root-stack (very elegant) */
unsigned char root_stack[STACK_SIZE]
   __attribute__ ((section("stack")));

