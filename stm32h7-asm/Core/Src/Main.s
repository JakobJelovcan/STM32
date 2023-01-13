/*
 * Main.s
 *
 *  Created on: Aug 24, 2022
 *      Author: rozman
 */

		  .syntax unified
		  .cpu cortex-m7
		  .thumb


///////////////////////////////////////////////////////////////////////////////
// Definitions
///////////////////////////////////////////////////////////////////////////////
// Definitions section. Define all the registers and
// constants here for code readability.


// Start of data section
 		.data
MSECCNT:	.word 0
MSECMAX:	.word 500
LED_STATUS:	.word 0

 		.align

// Start of text section
  		.text

  		.type  main, %function
  		.global main
   	   	.align
main:
		bl init_red_led
		bl red_led_off
		bl init_tc0_psp

__end: 	b 	__end


.global 	SysTick_Handler
.section  	.text.SysTick_Handler,"ax",%progbits
.type  		SysTick_Handler, %function

SysTick_Handler:
	push { r4, r5, r6, lr }

	ldr r4, =MSECCNT
	ldr r5, [r4]
	add r5, #1
	str r5, [r4]

	ldr r4, =MSECMAX
	ldr r6, [r4]

	cmp r5, r6

	bne RET

	ldr r4, =MSECCNT
	ldr r5, =0x00
	str r5, [r4]

	ldr r4, =LED_STATUS
	ldr r5, [r4]
	ldr r6, =0x01
	cmp r5, r6

	IT eq
	bleq red_led_off

	cmp r5, r6
	IT ne
	blne red_led_on

	eor r5, r6
	str r5, [r4]

RET: pop { r4, r5, r6, pc }
