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
input:	.space 128
 		.align

// Start of text section
  		.text

  		.type  main, %function
  		.global main
   	   	.align
main:
	bl init_tc0_ms
	bl init_usart3
	bl init_red_led
	bl red_led_off
	bl init_green_led
	bl green_led_off
	bl init_button

	ldr r0, =input
	ldr r1, =0x80
	bl receive_string_usart3

	ldr r0, =input
	bl display_morse

	bl green_led_on

	bl wait_button

	ldr r0, =input
	bl send_string_usart3
	bl green_led_off


__end: 	b 	__end
