.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ	GPIOA_BASE,	0x48000000
.equ	GPIOB_BASE,	0x48000400
.equ	GPIOC_BASE,	0x48000800
.equ	GPIOD_BASE,	0x48000C00
.equ	GPIOE_BASE, 0x48001000
.equ	GPIOF_BASE,	0x48001400
.equ	GPIOG_BASE, 0x48001800
.equ	GPIOH_BASE, 0x48001C00

.equ	GPIOx_MODER, 	0x00
.equ	GPIOx_OTYPER,	0x04
.equ	GPIOx_OSPEEDR,  0x08
.equ	GPIOx_PUPDR,	0x0C
.equ	GPIOx_IDR,		0x10
.equ	GPIOx_ODR,		0x14
.equ	GPIOx_BSSR,		0x18
.equ	GPIOx_LCKR,		0x1C
.equ	GPIOx_AFRL,		0x20
.equ	GPIOx_AFRH,		0x24
.equ	GPIOx_BRR,		0x28

.text

/**
 * @brief Initialize the GPIO pins required by the lcd
 * @param None
 * @return None
*/
.type	init_lcd_gpio %function
.global	init_lcd_gpio
init_lcd_gpio:
	push { lr }

	bl rcc_gpioa_clk_enable
	bl rcc_gpiob_clk_enable
	bl rcc_gpioc_clk_enable
	bl rcc_gpiod_clk_enable

	bl init_lcd_gpioa
	bl init_lcd_gpiob
	bl init_lcd_gpioc
	bl init_lcd_gpiod

	pop { pc }

/**
 * @brief Initialize the GPIOA pins required by the lcd
 * @param None
 * @return None
*/
.type	init_lcd_gpioa %function
init_lcd_gpioa:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOA_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0x3FC00FFF
	and r5, r6
	ldr r6, =0x802AA000
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_OSPEEDR]
	ldr r6, =0x3FC00FFF
	and r5, r6
	ldr r6, =0xC03FF000
	orr r5, r6
	str r5, [r4, #GPIOx_OSPEEDR]

	ldr r5, [r4, #GPIOx_OTYPER]
	ldr r6, =0xFFFF783F
	and r5, r6
	str r5, [r4, #GPIOx_OTYPER]

	ldr r5, [r4, #GPIOx_PUPDR]
	ldr r6, =0x3FC00FFF
	and r5, r6
	str r5, [r4, #GPIOx_PUPDR]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0x00FFFFFF
	and r5, r6
	ldr r6, =0xBB000000
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	ldr r5, [r4, #GPIOx_AFRH]
	ldr r6, =0x0FFFF000
	and r5, r6
	ldr r6, =0xB0000BBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRH]

	pop { r4, r5, r6, pc }

/**
 * @brief Initialize the GPIOB pins required by the lcd
 * @param None
 * @return None
*/
.type	init_lcd_gpiob %function
init_lcd_gpiob:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOB_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0x00F3F0F0
	and r5, r6
	ldr r6, =0xAA080A0A
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_OSPEEDR]
	ldr r6, =0x00F3F0F0
	and r5, r6
	ldr r6, =0xFF0C0F0F
	orr r5, r6
	str r5, [r4, #GPIOx_OSPEEDR]

	ldr r5, [r4, #GPIOx_OTYPER]
	ldr r6, =0xFFFF0DCC
	and r5, r6
	str r5, [r4, #GPIOx_OTYPER]

	ldr r5, [r4, #GPIOx_PUPDR]
	ldr r6, =0x00F3F0F0
	and r5, r6
	str r5, [r4, #GPIOx_PUPDR]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0xFF00FF00
	and r5, r6
	ldr r6, =0x00BB00BB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	ldr r5, [r4, #GPIOx_AFRH]
	ldr r6, =0x0000FF0F
	and r5, r6
	ldr r6, =0xBBBB00B0
	orr r5, r6
	str r5, [r4, #GPIOx_AFRH]

	pop { r4, r5, r6, pc }

/**
 * @brief Initialize the GPIOC pins required by the lcd
 * @param None
 * @return None
*/
.type	init_lcd_gpioc %function
init_lcd_gpioc:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOC_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0xFFFC003F
	and r5, r6
	ldr r6, =0x0002AA80
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_OSPEEDR]
	ldr r6, =0xFFFC003F
	and r5, r6
	ldr r6, =0x0003FFC0
	orr r5, r6
	str r5, [r4, #GPIOx_OSPEEDR]

	ldr r5, [r4, #GPIOx_OTYPER]
	ldr r6, =0xFFFFFE07
	and r5, r6
	str r5, [r4, #GPIOx_OTYPER]

	ldr r5, [r4, #GPIOx_PUPDR]
	ldr r6, =0xFFFC003F
	and r5, r6
	str r5, [r4, #GPIOx_PUPDR]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0x00000FFF
	and r5, r6
	ldr r6, =0xBBBBB000
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	ldr r5, [r4, #GPIOx_AFRH]
	ldr r6, =0xFFFFFFF0
	and r5, r6
	ldr r6, =0x0000000B
	orr r5, r6
	str r5, [r4, #GPIOx_AFRH]

	pop { r4, r5, r6, pc }

/**
 * @brief Initialize the GPIOC pins required by the lcd
 * @param None
 * @return None
*/
.type	init_lcd_gpiod %function
init_lcd_gpiod:
	push { r4, r5, r6, lr }

	ldr r4, =GPIOD_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0x0000FFFF
	and r5, r6
	ldr r6, =0xAAAA0000
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_OSPEEDR]
	ldr r6, =0x0000FFFF
	and r5, r6
	ldr r6, =0xFFFF0000
	orr r5, r6
	str r5, [r4, #GPIOx_OSPEEDR]

	ldr r5, [r4, #GPIOx_OTYPER]
	ldr r6, =0xFFFF00FF
	and r5, r6
	str r5, [r4, #GPIOx_OTYPER]

	ldr r5, [r4, #GPIOx_PUPDR]
	ldr r6, =0x0000FFFF
	and r5, r6
	str r5, [r4, #GPIOx_PUPDR]

	ldr r5, [r4, #GPIOx_AFRH]
	ldr r6, =0x00000000
	and r5, r6
	ldr r6, =0xBBBBBBBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRH]

	pop { r4, r5, r6, pc }
