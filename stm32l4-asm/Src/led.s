	.syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb


	.equ RCC_BASE,				0x40021000
	.equ RCC_AHB2ENR, 			0x4C

	.equ GPIOB_BASE, 			0x48000400
	.equ GPIOE_BASE,			0x48001000
	.equ GPIOx_MODER, 			0x00
	.equ GPIOB_MODER_CLEAR,		0xFFFFFFCF
	.equ GPIOE_MODER_CLEAR,		0xFFFCFFFF
	.equ GPIOB_MODER_SET,		0x00000010
	.equ GPIOE_MODER_SET,		0x00010000
	.equ GPIOx_ODR,				0x14
	.equ GPIOx_BSRR,			0x18

	.type	init_green_led %function
	.global	init_green_led

init_green_led:
	push { r4, r5, r6, lr }

	ldr r4, =RCC_BASE
	ldr r5, [r4, #RCC_AHB2ENR]
	orr r5, #(1 << 4)
	str r5, [r4, #RCC_AHB2ENR]

	ldr r4, =GPIOE_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =GPIOE_MODER_CLEAR
	and r5, r6
	ldr r6, =GPIOE_MODER_SET
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	pop { r4, r5, r6, pc }

	.type	init_red_led %function
	.global	init_red_led

init_red_led:
	push { r4, r5, r6, lr }

	ldr r4, =RCC_BASE
	ldr r5, [r4, #RCC_AHB2ENR]
	orr r5, #(1 << 1)
	str r5, [r4, #RCC_AHB2ENR]

	ldr r4, =GPIOB_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =GPIOB_MODER_CLEAR
	and r5, r6
	ldr r6, =GPIOB_MODER_SET
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	pop { r4, r5, r6, pc }


	.type	red_led_on %function
	.global	red_led_on

red_led_on:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOB_BASE
	ldr r5, =(1 << 2)
	str r5, [r4, #GPIOx_BSRR]

	pop { r4, r5, r6, pc }


	.type	red_led_off %function
	.global	red_led_off

red_led_off:
	push { r4, r5, lr }

	ldr r4, =GPIOB_BASE
	ldr r5, =(1 << 18)
	str r5, [r4, #GPIOx_BSRR]

	pop { r4, r5, pc }


	.type	green_led_on %function
	.global	green_led_on

green_led_on:
	push { r4, r5, lr }

	ldr r4, =GPIOE_BASE
	ldr r5, =(1 << 8)
	str r5, [r4, #GPIOx_BSRR]

	pop { r4, r5, pc }


	.type	green_led_off %function
	.global	green_led_off
green_led_off:
	push { r4, r5, lr }

	ldr r4, =GPIOE_BASE
	ldr r5, =(1 << 24)
	str r5, [r4, #GPIOx_BSRR]

	pop { r4, r5, pc }
