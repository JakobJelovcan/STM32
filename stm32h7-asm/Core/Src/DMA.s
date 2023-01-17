	.syntax unified
	.cpu cortex-m7
	.thumb

	.equ RCC_AHB1ENR,			0xD8
	.equ RCC_BASE, 				0x58024400

	.equ USART3_BASE, 			0x40004800
	.equ USART_ISR, 			0x1C
	.equ USART_RDR, 			0x24
	.equ USART_TDR, 			0x28
	.equ USART_CR1, 			0x00
	.equ USART_CR2, 			0x04
	.equ USART_CR3, 			0x08

	.equ DMAMUX1_BASE, 			0x40020800
	.equ DMAMUX1_C0CR, 			0x00
	.equ DMAMUX1_C1CR, 			0x04

	.equ DMA1_BASE, 			0x40020000
	.equ DMA2_BASE, 			0x40020400
	.equ DMA_USART3_TX_STREAM,	0
	.equ DMA_USART3_RX_STREAM, 	1

	.equ DMA_LISR, 				0x00
	.equ DMA_HISR, 				0x04
	.equ DMA_LIFCR, 			0x08
	.equ DMA_HIFCR, 			0x0C

	.equ DMA_SxCR_TX, 			0x10 + 0x18 * DMA_USART3_TX_STREAM
	.equ DMA_SxFCR_TX, 			0x24 + 0x18 * DMA_USART3_TX_STREAM
	.equ DMA_SxSNDTR_TX,		0x14 + 0x18 * DMA_USART3_TX_STREAM
	.equ DMA_SxPAR_TX,			0x18 + 0x18 * DMA_USART3_TX_STREAM
	.equ DMA_SxM0AR_TX,			0x1C + 0x18 * DMA_USART3_TX_STREAM
	.equ DMA_SxCR_RX,			0x10 + 0x18 * DMA_USART3_RX_STREAM
	.equ DMA_SxFCR_RX,			0x24 + 0x18 * DMA_USART3_RX_STREAM
	.equ DMA_SxSNDTR_RX,		0x14 + 0x18 * DMA_USART3_RX_STREAM
	.equ DMA_SxPAR_RX,			0x18 + 0x18 * DMA_USART3_RX_STREAM
	.equ DMA_SxM0AR_RX,			0x1C + 0x18 * DMA_USART3_RX_STREAM

.text

.type	init_dma %function
.global	init_dma

init_dma:
	push { r4, r5, lr }

	ldr r4, =RCC_BASE
	ldr r5, [r4, #RCC_AHB1ENR]
	orr r5, #1
	str r5, [r4, #RCC_AHB1ENR]

	ldr r4, =DMA1_BASE

//Transmit

	ldr r5, [r4, #DMA_SxCR_TX]
	bic r5, #1
	str r5, [r4, #DMA_SxCR_TX]

wait_EN0:
	ldr r5, [r4, #DMA_SxCR_TX]
	tst r5, #1
	bne wait_EN0

	orr r5, #(0b10001 << 6)
	str r5, [r4, #DMA_SxCR_TX]

	ldr r5, [r4, #DMA_SxFCR_TX]
	bic r5, #(1 << 2)
	str r5, [r4, #DMA_SxFCR_TX]

//Receive

	ldr r5, [r4, #DMA_SxCR_RX]
	bic r5, #1
	str r5, [r4, #DMA_SxCR_RX]

wait1_EN0:
	ldr r5, [r4, #DMA_SxCR_RX]
	tst r5, #1
	bne wait1_EN0

	orr r5, #(1 << 10)
	str r5, [r4, #DMA_SxCR_RX]

	ldr r5, [r4, #DMA_SxFCR_RX]
	bic r5, #(1 << 2)
	str r5, [r4, #DMA_SxFCR_RX]

	ldr r4, =DMAMUX1_BASE

	mov r5, #46
	str r5, [r4, DMAMUX1_C0CR]

	mov r5, #45
	str r5, [r4, DMAMUX1_C1CR]

	ldr r4, =USART3_BASE

	ldr r5, [r4, #USART_CR1]
	bic r5, #1
	str r5, [r4, #USART_CR1]

	ldr r5, [r4, #USART_CR3]
	orr r5, #(0b11 << 6)
	str r5, [r4, #USART_CR3]

	ldr r5, [r4, #USART_CR1]
	orr r5, #1
	str r5, [r4, #USART_CR1]

	pop { r4, r5, pc }


.type	rcv_dma %function
.global	rcv_dma

rcv_dma:
	push { r4, r5, lr }

	cmp r1, #0x01
	IT lo
	movlo r1, #0x1

	cmp r1, #0x50
	IT hi
	movhi r1, #0x50

	ldr r4, =DMA1_BASE

wait_rcv_EN0:
	ldr r5, [r4, #DMA_SxCR_RX]
	tst r5, #1
	bne wait_rcv_EN0

	ldr r5, =USART3_BASE + USART_RDR
	str r5, [r4, #DMA_SxPAR_RX]
	str r0, [r4, #DMA_SxM0AR_RX]
	str r1, [r4, #DMA_SxSNDTR_RX]

	mov r5, #(0b111101 << 6)
	str r5, [r4, #DMA_LIFCR]

	ldr r5, [r4, #DMA_SxCR_RX]
	orr r5, #1
	str r5, [r4, #DMA_SxCR_RX]

wait_rcv:
	ldr r5, [r4, #DMA_LISR]
	tst r5, #(1 << 11)
	beq wait_rcv

	pop { r4, r5, pc }

.type	snd_dma %function
.global	snd_dma

snd_dma:
	push { r4, r5, lr }

	cmp r1, #0x01
	IT lo
	movlo r1, #0x1

	cmp r1, #0x50
	IT hi
	movhi r1, #0x50

	ldr r4, =DMA1_BASE
wait_snd_EN0:
	ldr r5, [r4, DMA_SxCR_TX]
	tst r5, #1
	bne wait_snd_EN0

	ldr r5, =USART3_BASE + USART_TDR
	str r5, [r4, #DMA_SxPAR_TX]
	str r0, [r4, #DMA_SxM0AR_TX]
	str r1, [r4, #DMA_SxSNDTR_TX]

	mov r5, #0b111101
	str r5, [r4, #DMA_LIFCR]

	ldr r5, [r4, #DMA_SxCR_TX]
	orr r5, #1
	str r5, [r4, #DMA_SxCR_TX]

	ldr r4, =USART3_BASE
wait_snd:
	ldr r5, [r4, #USART_ISR]
	tst r5, #(1 << 6)
	beq wait_snd

	pop { r4, r5, pc }
