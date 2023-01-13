.syntax unified
.cpu cortex-m7
.thumb

.equ RCC_AHB4ENR, 0x580244E0
.equ RCC_APB1LENR, 0xE8
.equ RCC_BASE, 0x58024400

.equ GPIOB_BASE, 0x58020400
.equ GPIOx_MODER, 0x0
.equ GPIOx_AFRH, 0x24
.equ GPIO_MODER_CLEAR, 0xFF0FFFFF
.equ GPIO_MODER_VALUE, 0x00A00000
.equ GPIO_AFRH_CLEAR, 0xFFFF00FF
.equ GPIO_AFRH_VALUE, 0x00007700

.equ USART3_BASE, 0x40004800
.equ USART_CR1, 0x00
.equ USART_CR1_VAL, 0b1101

.equ USART_CR2, 0x04
.equ USART_CR3, 0x08
.equ USART_BRR, 0x0C
.equ USART_BRR_VAL, 556

.equ USART_ISR, 0x1C
.equ USART_RDR, 0x24
.equ USART_TDR, 0x28

.type 	init_usart3 %function
.global init_usart3

init_usart3:
	push { r0, r1, r2, lr }
	ldr r0, =RCC_BASE
	ldr r1, [r0, #RCC_APB1LENR]
	orr r1, r1, #(1 << 18)
	str r1, [r0, #RCC_APB1LENR]

	ldr r0, =RCC_AHB4ENR
	ldr r1, [r0]
	orr r1, r1, #0b10
	str r1, [r0]

	ldr r0, =GPIOB_BASE
	ldr r1, [r0, #GPIOx_MODER]
	ldr r2, =GPIO_MODER_CLEAR
	and r1, r1, r2
	ldr r2, =GPIO_MODER_VALUE
	orr r1, r1, r2
	str r1, [r0, #GPIOx_MODER]

	ldr r1, [r0, #GPIOx_AFRH]
	ldr r2, =GPIO_AFRH_CLEAR
	and r1, r1, r2
	ldr r2, =GPIO_AFRH_VALUE
	orr r1, r2, r2
	str r1, [r0, #GPIOx_AFRH]

	ldr r0, =USART3_BASE

	mov r1, #0
	str r1, [r0, #USART_CR1]

	ldr r1, =USART_BRR_VAL
	str r1, [r0, #USART_BRR]

	ldr r1, =USART_CR1_VAL
	str r1, [r0, #USART_CR1]

	pop { r0, r1, r2, pc }

.type	receive_char_usart3 %function
.global	receive_char_usart3

receive_char_usart3:
	push { r1, r2, lr }
	ldr r1, =USART3_BASE
receive_loop:
	ldr r2, [r1, #USART_ISR]
	tst r2, #(1 << 5)
	beq receive_loop
	ldr r0, [r1, #USART_RDR]
	pop { r1, r2, pc }


.type	receive_string_usart3 %function
.global receive_string_usart3

receive_string_usart3:
	push { r4, lr }

	mov r4, r0
receive_string_loop:
	bl receive_char_usart3
	str r0, [r4], #1

	subs r1, #1
	IT ne
	cmpne r0, #0x0D
	bne receive_string_loop

	mov r0, #0
	str r0, [r4, #-1]

	pop { r4, pc }

.type	send_char_usart3 %function
.global	send_char_usart3

send_char_usart3:
	push { r1, r2, lr }
	ldr r1, =USART3_BASE
send_loop:
	ldr r2, [r1, #USART_ISR]
	tst r2, #(1 << 7)
	beq send_loop
	str r0, [r1, #USART_TDR]
	pop { r1, r2, pc }

.type	send_string_usart3 %function
.global send_string_usart3

send_string_usart3:
	push { r1, lr }
	mov r1, r0
send_string_loop:
	ldr r0, [r1], #1
	bl send_char_usart3
	cmp r0, #0
	bne send_string_loop
	pop { r1, pc }
