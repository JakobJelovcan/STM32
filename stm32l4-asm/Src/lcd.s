.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ RCC_BASE,			0x40021000
.equ RCC_AHB2ENR, 		0x4C
.equ RCC_APB1ENR1,		0x58

.equ GPIOA_BASE, 		0x48000000
.equ GPIOB_BASE,		0x48000400
.equ GPIOC_BASE,		0x48000800
.equ GPIOD_BASE,		0x48000C00
.equ GPIOE_BASE,		0x48001000

.equ GPIOx_MODER,		0x00
.equ GPIOx_PUPDR,		0x0C
.equ GPIOx_AFRL,		0x20
.equ GPIOx_AFRH,		0x24

.equ LCD_BASE, 			0x40002400
.equ LCD_CR,			0x00
.equ LCD_FCR,			0x04
.equ LCD_SR,			0x08
.equ LCD_CLR,			0x0C
.equ LCD_RAM,			0x14


.type	init_lcd_gpio %function
.global	init_lcd_gpio
init_lcd_gpio:
	push { lr }

	bl init_lcd_a
	bl init_lcd_b
	bl init_lcd_c

	pop { pc }


.type	init_lcd %function
.global	init_lcd
init_lcd:
	push { r4, r5, r6, r7, lr }

	//Enable lcd clock
	ldr r4, =RCC_BASE
	ldr r5, =(1 << 9)
	str r5, [r4, #RCC_APB1ENR1]

	//Set GPIO A,B,C to AF11
	bl init_lcd_gpio

	bl lcd_off			//Turn off lcd
	bl lcd_wait_off		//Wait for lcd to be turned off
	bl lcd_clear_ram	//Clear ram

	ldr r4, =LCD_BASE
	ldr r5, =0x00001C00
	str r5, [r4, #LCD_FCR]

	ldr r5, =0x0000004C
	str r5, [r4, #LCD_CR]

	pop { r4, r5, r6, r7, pc }


.type	lcd_off %function
.global
lcd_off:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
	ldr r5, [r4, #LCD_CR]
	bic r5, #(1 << 0)
	str r5, [r4, #LCD_CR]

	pop { r4, r5, pc }


.type	lcd_on %function
.global
lcd_on:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
	ldr r5, [r4, #LCD_CR]
	orr r5, #(1 << 0)
	str r5, [r4, #LCD_CR]

	pop { r4, r5, pc }


.type	lcd_wait_off %function
lcd_wait_off:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
lcd_wait_off_loop:
	ldr r5, [r4, #LCD_SR]
	tst r5, #(1 << 0)
	bne lcd_wait_off_loop

	pop { r4, r5, pc }

.type	lcd_set_contrast %function
.global	lcd_set_contrast
lcd_set_contrast:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
	ldr r5, =0x00000007
	and r0, r5
	lsl r0, #10
	ldr r5, [r4, #LCD_FCR]
	orr r5, r0
	str r5, [r4, #LCD_FCR]

	pop { r4, r5, pc }

.type	lcd_display_bar %function
.global	lcd_display_bar
lcd_display_bar:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
wait_udr:
	ldr r5, [r4, #LCD_SR]
	tst r5, #(1 << 2)
	bne wait_udr

	ldr r5, =0x00FFFFFF
	str r5, [r4, #LCD_RAM]
	str r5, [r4, #LCD_RAM + 8]
	str r5, [r4, #LCD_RAM + 16]
	str r5, [r4, #LCD_RAM + 24]

	ldr r5, =(1 << 2)
	str r5, [r4, #LCD_SR]

	pop { r4, r5, pc }


.type	init_lcd_a %function
.global init_lcd_a
init_lcd_a:
	push { r4, r5, r6, lr }

	ldr r4, =RCC_BASE
	ldr r5, [r4, #RCC_AHB2ENR]
	orr r5, #(1 << 0)
	str r5, [r4, #RCC_AHB2ENR]

	//PA1, PA2, PA3, PA6, PA7, PA8, PA9, PA10, PA15
	ldr r4, =GPIOA_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0x3FC00F03
	and r5, r6
	ldr r6, =0x802AA0A8
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_PUPDR]
	ldr r6, =0x3FC00F03
	and r5, r6
	str r5, [r4, #GPIOx_PUPDR]

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

	ldr r4, =RCC_BASE
	ldr r5, [r4, #RCC_AHB2ENR]
	orr r5, #(1 << 1)
	str r5, [r4, #RCC_AHB2ENR]

	//PB0, PB1, PB3, PB4, PB5, PB7, PB8, PB9, PB10, PB11, PB12, PB13, PB14, PB15
	ldr r4, =GPIOB_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0x00003030
	and r5, r6
	ldr r6, =0xAAAA8A8A
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_PUPDR]
	ldr r6, =0x00003030
	and r5, r6
	str r5, [r4, #GPIOx_PUPDR]

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

	ldr r4, =RCC_BASE
	ldr r5, [r4, #RCC_AHB2ENR]
	orr r5, #(1 << 2)
	str r5, [r4, #RCC_AHB2ENR]

	//PC0, PC1, PC2, PC3, PC4, PC5
	ldr r4, =GPIOC_BASE
	ldr r5, [r4, #GPIOx_MODER]
	ldr r6, =0xFFFFF000
	and r5, r6
	ldr r6, =0x00000AAA
	orr r5, r6
	str r5, [r4, #GPIOx_MODER]

	ldr r5, [r4, #GPIOx_PUPDR]
	ldr r6, =0xFFFFF000
	and r5, r6
	str r5, [r4, #GPIOx_PUPDR]

	ldr r5, [r4, #GPIOx_AFRL]
	ldr r6, =0xFF000000
	and r5, r6
	ldr r6, =0x00BBBBBB
	orr r5, r6
	str r5, [r4, #GPIOx_AFRL]

	pop { r4, r5, r6, pc }

.type	lcd_clear_ram %function
lcd_clear_ram:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE + LCD_RAM
	ldr r5, =0x00
	ldr r6, =0x0F
clear_ram_loop:
	str r5, [r4], #4
	subs r7, #1
	bne clear_ram_loop

	pop { r4, r5, r6, pc }
