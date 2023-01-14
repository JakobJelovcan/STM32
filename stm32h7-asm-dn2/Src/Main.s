/*
 * Main.s
 *
 *  Created on: Aug 24, 2022
 *      Author: rozman
 */
.type	display_morse %function
.global display_morse

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
	bl change
	ldr r0, =input
	bl send_string_usart3
	bl green_led_off


__end: 	b 	__end

.type	change %function
change:
	push { r4, lr }

loop:
	ldrb r4, [r0]
	cmp r4, #0x41
	blo skip
	cmp r4, #0x7A
	bhi skip
	cmp r4, #0x5A
	bls switch
	cmp r4, #0x61
	bhs switch
	b skip

	switch:
	eor r4, #(1 << 5)

	skip:
	strb r4, [r0], #1
	cmp r4, #0
	bne loop

	pop { r4, pc }
