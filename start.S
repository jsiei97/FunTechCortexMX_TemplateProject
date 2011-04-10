# Startup code
# Some config declarations. Valid values for each is {0,1}

.equ EXTERNAL_PLL_SETUP, 1
# ---------------------------------------------------------------------------
 
# *** Startup Code (executed after Reset) ***
.code 16

# External declarations
# -- Secondary boot
.thumb_func
.type   board_main, %function

.if EXTERNAL_PLL_SETUP
# -- PLL/clock initialization (pre-board boot to speed things at this level up)
	.thumb_func
	.type   pll_setup, %function
.endif
# ----------------------------------------------------------------------------

# Starupt Code must be linked first at Address at which it expects to run
# (unless startvector says other).

.text
.thumb

/*.align 0, probably does nothing*/
.align  0
.global start
.code 16
.func   start
start:
  			bl		pll_setup
			bl		bss_clear
			bl		stack_CACA
			bl		statics_init

/*Call secondary boot*/
			ldr		r7, =board_main
			blx		r7
/*Should never return, but if we do, lets go somewhere safe*/
			bl		loop_forever

.size   start, . - start
.endfunc
# ----------------------------------------------------------------------------
# Local code

.if ( EXTERNAL_PLL_SETUP != 1 )
pll_setup:
/* 
 Empty placeholder for now, may contain cortex-m3 generic code later 
 (if possible)
*/
	mov 	pc,lr
.endif

bss_clear:
/*Clear bss memory*/
			mov		r0, #0
			ldr		r1, =__bss_start__
			ldr		r2, =__bss_end__
LoopZI:
			str		r0, [r1]
			add		r1, #4
			cmp		r1, r2
			blo		LoopZI
			mov		pc,lr

stack_CACA:
/*Dirtify root stack*/
			mov		r1, #0xCA
			mov		r0, r1
			lsl		r0, #8 
			add		r0, r1
			lsl		r0, #8 
			add		r0, r1
			lsl		r0, #8 
			add		r0, r1
			ldr		r1, =_stack_start
			ldr		r2, =_stack_end
LoopCACA:
			str		r0, [r1]
			add		r1, #4
			cmp		r1, r2
			blo		LoopCACA
			mov		pc,lr

statics_init:
/*Copy from ROM to RAM, initializating statics*/
			ldr		r1, =etext
			ldr		r2, =data
			ldr		r3, =edata
LoopRel:
			ldr		r0, [r1]
			str		r0, [r2]
			add		r1, #4
			add		r2, #4
			cmp		r2, r3  /* Have we reached end of _edata? */
			blo		LoopRel
			mov		pc,lr

loop_forever:
/*Stay here until WD grabs us*/
	bl		loop_forever

# --------------------------------------------------------------------------------------
	.end
