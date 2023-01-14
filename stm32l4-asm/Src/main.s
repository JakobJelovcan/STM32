	.syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

.data
struct:	.space 24
.align
.text

.type 	main %function
.global main

main:
	bl c_function1
	bl asm_function2
	bl c_function3
	bl asm_function4
__end: b __end

.type	asm_function1 %function
.global	asm_function1

asm_function1:
	push { r4, r5, lr }

	ldr r4, [sp, #12]
	ldr r5, [sp, #16]

	pop { r4, r5, pc }


.type	asm_function2 %function
.global	asm_function2

asm_function2:
	push { r4, lr }
	ldr r0, =1
	ldr r1, =2
	ldr r2, =3
	ldr r3, =4

	ldr r4, =6
	str r4, [sp, #-4]!
	ldr r4, =5
	str r4, [sp, #-4]!

	bl c_function2

	add sp, #8

	pop { r4, pc }

.type	asm_function3 %function
.global	asm_function3

asm_function3:
	push { r4, lr }

	ldr r4, =1
	str r4, [r0]
	ldr r4, =2
	str r4, [r0, #4]
	ldr r4, =3
	str r4, [r0, #8]
	ldr r4, =4
	str r4, [r0, #12]
	ldr r4, =5
	str r4, [r0, #16]
	ldr r4, =6
	str r4, [r0, #20]

	pop { r4, pc }

.type	asm_function4 %function
.global	asm_function4

asm_function4:
	push { r4, r5, r6, lr }

	sub sp, #24
	mov r0, sp

	bl c_function4

	ldr r1, [r0]
	ldr r2, [r0, #4]
	ldr r3, [r0, #8]
	ldr r4, [r0, #12]
	ldr r5, [r0, #16]
	ldr r6, [r0, #20]

	add sp, #24

	pop { r4, r5, r6, pc }

