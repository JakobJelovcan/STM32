.syntax unified
.cpu cortex-m7
.thumb

.equ SCS_BASE, 				0xe000e000
.equ SCS_SYST_CSR, 			0x10
.equ SCS_SYST_RVR, 			0x14
.equ SCS_SYST_CVR, 			0x18
.equ RCC_APB1LENR, 			0xE8
.equ RCC_BASE, 				0x58024400
.equ SYSTICK_RELOAD_1MS,	0x0000F9FF

.text

.type	init_tc0_ms %function
.global	init_tc0_ms

init_tc0_ms:
	push { r0, lr }

	ldr r0, =SYSTICK_RELOAD_1MS
	bl	init_tc0

	pop { r0, pc }

.type 	init_tc0 %function
.global init_tc0

init_tc0:
	push { r0, r1, lr }
	ldr r1, =SCS_BASE
	ldr r0, =SYSTICK_RELOAD_1MS
	str r0, [r1, #SCS_SYST_RVR]

	mov r0, #0
	str r0, [r0, #SCS_SYST_CVR]

	mov r0, #0x05
	str r0, [r1, #SCS_SYST_CSR]

	pop { r0, r1, pc }


.type 	init_tc0_psp %function
.global init_tc0_psp

init_tc0_psp:
	push { r4, r5, lr }
	ldr r4, =SCS_BASE
	ldr r5, =SYSTICK_RELOAD_1MS
	str r5, [r4, #SCS_SYST_RVR]

	mov r5, #0
	str r5, [r5, #SCS_SYST_CVR]

	mov r5, #0b111
	str r5, [r4, #SCS_SYST_CSR]

	pop { r4, r5, pc }


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
