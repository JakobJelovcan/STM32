/*
 * pwr.s
 *
 *  Created on: Mar 26, 2023
 *      Author: Jakob
 */

.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb


.equ PWR_BASE,              0x40007000
.equ PWR_CR1,               0x00

.type   pwr_disable_write_protection, %function
.global pwr_disable_write_protection
pwr_disable_write_protection:
    push { r4, r5, lr }

    ldr r4, =PWR_BASE
    ldr r5, [r4, #PWR_CR1]
    orr r5, #(1 << 8)
    str r5, [r4, #PWR_CR1]

    pop { r4, r5, pc }

.type   pwr_enable_write_protection, %function
.global pwr_enable_write_protection
pwr_enable_write_protection:
    push { r4, r5, lr }

    ldr r4, =PWR_BASE
    ldr r5, [r4, #PWR_CR1]
    bic r5, #(1 << 8)
    str r5, [r4, #PWR_CR1]

    pop { r4, r5, pc }
