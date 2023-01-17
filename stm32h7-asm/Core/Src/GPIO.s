	.syntax unified
	.cpu cortex-m7
	.thumb

	.equ    RCC_AHB4ENR,   		0x580244E0
	.equ    GPIOI_BASE,   		0x58022000
	.equ 	GPIOJ_BASE,   		0x58022400
	.equ	GPIOC_BASE,			0x58020800
	.equ    GPIOx_MODER,   		0x00
	.equ	GPIOx_IDR,			0x10
	.equ    GPIOx_ODR, 	   		0x14
	.equ    GPIOx_BSSR, 		0x18
	.equ	GPIOx_PUPDR,		0x0C
	.equ    LED_RED_OFF,   		0x00002000
	.equ    LED_RED_ON,   		0x20000000
	.equ	LED_GREEN_OFF, 		0x00000004
	.equ	LED_GREEN_ON,		0x00040000
	.equ	GPIOx_PUPDR_CLEAR,	0xF3FFFFFF
	.equ	GPIOx_PUPDR_SET,	0x08000000


.text
.align

.type 	init_green_led %function
.global init_green_led

init_green_led:
	push { r0, r1, lr }
	ldr r0, =RCC_AHB4ENR
	ldr r1, [r0]
	orr r1, #(1 << 9)
	str r1, [r0]

	ldr r0, =GPIOJ_BASE
	ldr r1, [r0, #GPIOx_MODER]
	and r1, #0xFFFFFFCF
	orr r1, #0x00000010
	str r1, [r0, #GPIOx_MODER]

	pop { r0, r1, pc }

.type	init_red_led %function
.global	init_red_led

init_red_led:
	push { r0, r1, lr }
	ldr r0, =RCC_AHB4ENR
	ldr r1, [r0]
	orr r1, #(1 << 8)
	str r1, [r0]

	ldr r0, =GPIOI_BASE
	ldr r1, [r0, #GPIOx_MODER]
	and r1, #0xF3FFFFFF
	orr r1, #0x04000000
	str r1, [r0, #GPIOx_MODER]

	pop { r0, r1, pc }

.type	init_button %function
.global	init_button

init_button:
	push { r0, r1, r2, lr }
	ldr r0, =RCC_AHB4ENR
	ldr r1, [r0]
	orr r1, #0x00000004
	str r1, [r0]

	ldr r0, =GPIOC_BASE
	ldr r1, [r0, #GPIOx_MODER]
	and r1, #0xF3FFFFFF
	str r1, [r0, #GPIOx_MODER]

	ldr r1, [r0, #GPIOx_PUPDR]
	ldr r2, =GPIOx_PUPDR_CLEAR
	and r1, r2
	ldr r2, =GPIOx_PUPDR_SET
	orr r1, r2
	str r1, [r0, #GPIOx_PUPDR]

	pop { r0, r1, r2, pc }

.type	green_led_on %function
.global green_led_on

green_led_on:
	push { r0, r1, lr }

	ldr r0, =GPIOJ_BASE
	mov r1, #LED_GREEN_ON
	str r1, [r0, #GPIOx_BSSR]

	pop { r0, r1, pc }

.type 	green_led_off %function
.global green_led_off

green_led_off:
	push { r0, r1, lr }

	ldr r0, =GPIOJ_BASE
	mov r1, #LED_GREEN_OFF
	str r1, [r0, #GPIOx_BSSR]

	pop { r0, r1, pc }

.type	red_led_on %function
.global red_led_on

red_led_on:
	push { r0, r1, lr }

	ldr r0, =GPIOI_BASE
	mov r1, #LED_RED_ON
	str r1, [r0, #GPIOx_BSSR]

	pop { r0, r1, pc }

.type	red_led_off %function
.global	red_led_off

red_led_off:
	push { r0, r1, lr }

	ldr r0, =GPIOI_BASE
	mov r1, #LED_RED_OFF
	str r1, [r0, #GPIOx_BSSR]

	pop { r0, r1, pc }

.type	wait_button %function
.global	wait_button
wait_button:
	push { r0, r1, lr }

	ldr r0, =GPIOC_BASE
loop_button:
	ldr r1, [r0, #GPIOx_IDR]
	tst r1, #(1 << 13)
	beq loop_button

	pop { r0, r1, pc }

