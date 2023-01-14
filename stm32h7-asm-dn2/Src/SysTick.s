.syntax unified
.cpu cortex-m7
.thumb

.equ SCS_BASE, 0xe000e000
.equ SCS_SYST_CSR, 0x10
.equ SCS_SYST_RVR, 0x14
.equ SCS_SYST_CVR, 0x18
.equ RCC_APB1LENR, 0xE8
.equ RCC_BASE, 0x58024400

.text
.align

.type	init_tc0_ms %function
.global	init_tc0_ms

init_tc0_ms:
	push { r0, lr }

	ldr r0, =0x0000F9FF
	bl	init_tc0

	pop { r0, pc }

.type 	init_tc0 %function
.global init_tc0

init_tc0:
	push { r1, lr }
	ldr r1, =SCS_BASE
	str r0, [r1, #SCS_SYST_RVR]

	mov r0, #0
	str r0, [r0, #SCS_SYST_CVR]

	mov r0, #0b101
	str r0, [r1, #SCS_SYST_CSR]

	pop { r1, pc }

.type 	delay_tc %function
.global delay_tc

delay_tc:
	push { r1, r2, lr }
	ldr r1, =SCS_BASE
delay_loop:
	ldr r2, [r1, #SCS_SYST_CSR]
	tst r2, #0x10000
	beq delay_loop
	subs r0, #1
	bne delay_loop
	pop { r1, r2, pc }
