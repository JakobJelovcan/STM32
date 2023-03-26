/*
 * nvic.s
 *
 *  Created on: Mar 26, 2023
 *      Author: Jakob
 */
.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.equ    NVIC_BASE,                  	0xE000E100
.equ    NVIC_ISER0,                 	0x00
.equ    NVIC_ICER0,                 	0x80
.equ    NVIC_ISPR0,                 	0x100
.equ    NVIC_ICPR0,                 	0x180
.equ    NVIC_IABR0,                 	0x200
.equ    NVIC_IPR0,                  	0x300
.equ    NVIC_STIR,                  	0xE00

.equ    NVIC_PRIO_BITS,             	0x03

.equ    SCB_BASE,                       0xE000ED00
.equ    SCB_CPUID,                      0x00
.equ    SCB_ICSR,                       0x04
.equ    SCB_VTOR,                       0x08
.equ    SCB_AIRCR,                      0x0C
.equ    SCB_SCR,                        0x10
.equ    SCB_CCR,                        0x14
.equ    SCB_SHPR1,                      0x18
.equ    SCB_SHPR2,                      0x1C
.equ    SCB_SHPR3,                      0x20
.equ    SCB_SHCSR,                      0x24
.equ    SCB_CFSR,                       0x28
.equ    SCB_MMSR,                       0x2C
.equ    SCB_BFSR,                       0x30
.equ    SCB_UFSR,                       0x34
.equ    SCB_HFSR,                       0x38
.equ    SCB_MMAR,                       0x3C
.equ    SCB_BFAR,                       0x40
.equ    SCB_AFSR,                       0x44
.equ    SCB_AIRCR_PRIGROUP_POSITION,	0x08
.equ    SCB_AIRCR_PRIGROUP_MASK,    	0x07 << SCB_AIRCR_PRIGROUP_POSITION

/**
 * @param Priority group
 * @param Preempt priority
 * @param Sub priority
*/
.type   nvic_encode_priority, %function
.local  nvic_encode_priority
nvic_encode_priority:
    push { r4, r5, r6, lr }

    and r0, #0x07

    rsb r6, r0, #0x07
    cmp r6, #NVIC_PRIO_BITS
    ITE hi
    movhi r4, #NVIC_PRIO_BITS
    movls r4, r6

    add r6, r0, #NVIC_PRIO_BITS
    cmp r6, #0x07
    ITE lo
    movlo r5, #0x00
    movhs r5, r6

    ldr r6, =0x01
    lsl r6, r4
    sub r6, #0x01
    and r1, r6
    lsl r1, r5

    ldr r6, =0x01
    lsl r6, r5
    sub r6, #0x01
    and r2, r6

    orr r0, r1, r2

    pop { r4, r5, r6, pc }
/**
 * @param IRQ number
 * @param Preempt priority
 * @param Sub priority
*/
.type   nvic_set_priority, %function
.global nvic_set_priority
nvic_set_priority:
    push { r4, r5, r6, r7, lr }

    mov r4, r0      //IRQn

    bl scb_read_priority_group
    bl nvic_encode_priority

    ldr r5, =NVIC_PRIO_BITS
    rsb r5, #0x08
    lsl r0, r5
    and r0, #0xFF

    cmp r4, #0x00
    blt 2f
    ldr r5, =NVIC_BASE
    strb r0, [r5, r4]
    b 3f
2:
    ldr r5, =SCB_BASE
    and r4, #0x0F
    sub r4, #0x04
    strb r0, [r5, r4]
3:

    pop { r4, r5, r6, r7, pc }

.type   nvic_enable_irq, %function
.global nvic_enable_irq
nvic_enable_irq:
    push { r4, r5, r6, r7, lr }

    lsr r6, r0, #0x05
    and r6, #0x07
    ldr r4, =NVIC_BASE + NVIC_ISER0
    ldr r5, [r4, r6]
    and r0, #0x1F
    ldr r7, =0x01
    lsl r7, r0
    orr r5, r7
    str r5, [r4, r6]

    pop { r4, r5, r6, r7, pc }

.type   nvic_disable_irq, %function
.global nvic_disable_irq
nvic_disable_irq:
    push { r4, r5, r6, r7, lr }

    lsr r6, r0, #0x05
    and r6, #0x07
    ldr r4, =NVIC_BASE + NVIC_ISER0
    ldr r5, [r4, r6]
    and r0, #0x1F
    ldr r7, =0x01
    lsl r7, r0
    bic r5, r7
    str r5, [r4, r6]

    pop { r4, r5, r6, r7, pc }
