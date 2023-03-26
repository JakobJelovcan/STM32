/*
 * scb.s
 *
 *  Created on: Mar 26, 2023
 *      Author: Jakob
 */
 .syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb


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
.equ    SCB_AIRCR_PRIGROUP_POSITION,    0x08
.equ    SCB_AIRCR_PRIGROUP_MASK,        0x07 << SCB_AIRCR_PRIGROUP_POSITION

.type   scb_read_priority_group, %function
.global scb_read_priority_group
scb_read_priority_group:
    push { r4, lr }

    ldr r4, =SCB_BASE
    ldr r0, [r4, #SCB_AIRCR]
    and r0, #SCB_AIRCR_PRIGROUP_MASK
    lsr r0, #SCB_AIRCR_PRIGROUP_POSITION

    pop { r4, pc }
