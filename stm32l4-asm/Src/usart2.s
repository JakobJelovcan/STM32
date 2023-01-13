	.syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb


	.equ RCC_BASE,			0x40021000
	.equ RCC_APB1ENR1, 		0x58
	.equ RCC_AHB2ENR, 		0x4C

	.equ GPIOD_BASE,		0x48000C00
	.equ GPIOx_MODER,		0x00
	.equ GPIOx_AFRL,		0x20
	.equ GPIOx_MODER_CLEAR,	0xFFFFC3FF
	.equ GPIOx_MODER_SET,	0x00002800
	.equ GPIOx_AFRL_CLEAR,	0xF00FFFFF
	.equ GPIOx_AFRL_SET,	0x07700000

	.equ USART2_BASE,		0x40004400
	.equ USARTx_BRR,		0x0C
	.equ USARTx_BRR_VALUE,	0x22
	.equ USARTx_CR1,		0x00
	.equ USARTx_CR1_VALUE,	0x0B
	.equ USARTx_ISR,		0x1C
	.equ USARTx_RDR,		0x24
	.equ USARTx_TDR,		0x28

	.type 	init_usart2 %function
	.global	init_usart2

init_usart2:
	push { r4, r5, lr }

	//Enable usart2
	ldr r4, =RCC_BASE
	ldr r5, [r4, #RCC_APB1ENR1]
	orr r5, #(1<<17)
	str r5, [r4, #RCC_APB1ENR1]

	//Enable GPIOD
	ldr r5, [r4, #RCC_AHB2ENR]
	orr r5, #(1<<3)
	str r5, [r4, #RCC_AHB2ENR]

	//Set pins D5 and D6 to alternate mode
	ldr r4, =GPIOD_BASE
	ldr r5, [r4, #GPIOx_MODER]
	and r5, #GPIOx_MODER_CLEAR
	orr r5, #GPIOx_MODER_SET
	str r5, [r4, #GPIOx_MODER]

	//Set alternate mode on pins D5 and D6 to A7
	ldr r5, [r4, #GPIOx_AFRL]
	and r5, #GPIOx_AFRL_CLEAR
	orr r5, #GPIOx_AFRL_SET
	str r5, [r4, #GPIOx_AFRL]


	ldr r4, =USART2_BASE

	//Clear CR1
	mov r5, #0
	str r5, [r4, #USARTx_CR1]

	//Set baud rate
	ldr r5, =USARTx_BRR_VALUE
	str r5, [r4, #USARTx_BRR]

	//Set CR1
	ldr r5, =USARTx_CR1_VALUE
	str r5, [r4, #USARTx_CR1]

	pop { r4, r5, pc }

rcv_char_usart2:
	push { r4, r5, lr }

	ldr r4, =USART2_BASE
rcv_char_loop:
	ldr r5, [r4, #USARTx_ISR]
	tst r5, #(1<<5)
	beq rcv_char_loop
	ldr r0, [r4, #USARTx_RDR]

	pop { r4, r5, pc }

snd_char_usart2:
	push { r4, r5, lr }

 	ldr r4, =USART2_BASE
snd_char_loop:
	ldr r5, [r4, #USARTx_ISR]
	tst r5, #(1<<7)
	beq snd_char_loop
	str r0, [r4, #USARTx_TDR]

	pop { r4, r5, pc }

	.type	rcv_string_usart2 %function
	.global	rcv_string_usart2

rcv_string_usart2:
	push { r4, lr }

	mov r4, r0
rcv_string_loop:
	bl rcv_char_usart2
	strb r0, [r4], #1
	cmp r0, #0
	bne rcv_string_loop

	pop { r4, pc }

	.type	snd_string_usart2 %function
	.global	snd_string_usart2

snd_string_usart2:
	push { r4, lr }

	mov r4, r0
snd_string_loop:
	ldrb r0, [r4], #1
	bl snd_char_usart2
	cmp r0, #0
	bne snd_string_loop

	pop { r4, pc }
