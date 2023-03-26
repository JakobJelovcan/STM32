/*
 * exti.s
 *
 *  Created on: 26. mar. 2023
 *      Author: Jakob
 */

.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.equ EXTI_BASE,                 0x40010400
.equ EXTI_IMR1,                 0x00
.equ EXTI_EMR1,                 0x04
.equ EXTI_RTSR1,                0x08
.equ EXTI_FTSR1,                0x0C
.equ EXTI_SWIER1,               0x10
.equ EXTI_PR1,                  0x14
.equ EXTI_IMR2,                 0x18
.equ EXTI_EMR2,                 0x1C
.equ EXTI_RTSR2,                0x20
.equ EXTI_FTSR2,                0x24
.equ EXTI_SWIER2,               0x28
.equ EXTI_PR2,                  0x2C

.type   exti_clear_interupt, %function
.global exti_clear_interupt
exti_clear_interupt:
    push { r4, lr }

    ldr r4, =EXTI_BASE
    str r0, [r4, #EXTI_PR1]

    pop { r4, pc }
