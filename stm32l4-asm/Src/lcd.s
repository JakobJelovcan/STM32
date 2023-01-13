	.syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

	.equ RCC_BASE,			0x40021000
	.equ RCC_AHB2ENR, 		0x4C

	.equ GPIOA_BASE, 		0x48000000
	.equ GPIOB_BASE,		0x48000400
	.equ GPIOC_BASE,		0x48000800
	.equ GPIOD_BASE,		0x48000C00
	.equ GPIOE_BASE,		0x48001000
	.equ GPIOx_MODER,		0x00
	.equ GPIOx_MODER_VALUE, 0xFFFFF300
	.equ GPIOx_AFRL,		0x20
	.equ GPIOx_AFRH,		0x24

	.equ LCD_BASE, 			0x40002400
	.equ LCD_CR,			0x00
	.equ LCD_FCR,			0x04
	.equ LCD_SR,			0x08
	.equ LCD_CLR,			0x0C
	.equ LCD_RAM,			0x14


	.type	init_lcd %function
	.global	init_lcd

init_lcd:
	push { r4, r5, lr }

	ldr r4, =RCC_BASE

	ldr r5, [r4, #RCC_AHB2ENR]
	orr r5, #0x1F
	str r5, [r4, #RCC_AHB2ENR]

	bl init_lcd_a
	bl init_lcd_b
	bl init_lcd_c
	bl init_lcd_d
	bl init_lcd_e

	pop { r4, r5, pc }


	.type	refresh_lcd %function
	.global	refresh_lcd

refresh_lcd:
	push { r4, r5, r6, lr }



	pop { r4, r5, r6, pc }


	.type	init_lcd_a %function
	.global init_lcd_a
init_lcd_a:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOA_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0x3FC00F03
	and r5, r6
	ldr r6, =0x802AA0A8
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0x00FF000F
	and r5, r6
	ldr r6, =0xBB00BBB0
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	ldr r5, [r4, #GPIOx_AFRH]
	ldr r6, =0x0FFFF000
	and r5, r6
	ldr r6, =0xB0000BBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRH]

	pop { r4, r5, r6, pc }


	.type	init_lcd_b %function
	.global	init_lcd_b
init_lcd_b:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOB_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0x00003030
	and r5, r6
	ldr r6, =0xAAAA8A8A
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0x0F000F00
	and r5, r6
	ldr r6, =0xB0BBB0BB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	ldr r5, [r4, #GPIOx_AFRH]
	ldr r6, =0x00000000
	and r5, r6
	ldr r6, =0xBBBBBBBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRH]

	pop { r4, r5, r6, pc }


	.type	init_lcd_c %function
	.global init_lcd_c
init_lcd_c:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOC_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0xFC000000
	and r5, r6
	ldr r6, =0x02AAAAAA
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0x00000000
	and r5, r6
	ldr r6, =0xBBBBBBBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	ldr r5, [r4, #GPIOx_AFRH]
	ldr r6, =0xFFF00000
	and r5, r6
	ldr r6, =0x000BBBBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRH]

	pop { r4, r5, r6, pc }


	.type	init_lcd_d %function
	.global init_lcd_d
init_lcd_d:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOD_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0x0000FFCF
	and r5, r6
	ldr r6, =0xAAAA0020
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0xFFFFF0FF
	and r5, r6
	ldr r6, =0x00000B00
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	ldr r5, [r4, #GPIOx_AFRH]
	ldr r6, =0x00000000
	and r5, r6
	ldr r6, =0xBBBBBBBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRH]

	pop { r4, r5, r6, pc }


	.type	init_lcd_e %function
	.global	init_lcd_e
init_lcd_e:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOE_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0xFFFFFF00
	and r5, r6
	ldr r6, =0x000000AA
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0xFFFF0000
	and r5, r6
	ldr r6, =0x0000BBBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	pop { r4, r5, r6, pc }
