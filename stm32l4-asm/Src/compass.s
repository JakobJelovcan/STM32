/*
 * compass.s
 *
 *  Created on: 27. mar. 2023
 *      Author: Jakob
 */

.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.type   to_degrees, %function
.global to_degrees
to_degrees:
    push { r4, r5, r6, fp, lr }
    vpush { s1 }

    mov fp, sp
    sub sp, #24     //Make space on the stack for two vectors

    mov r4, r0
    mov r5, r1

    mov r1, r4
    mov r2, r5
    sub r0, fp, #12

    bl project

    mov r0, sp
    mov r1, r4
    sub r2, fp, #12

    bl sub

    vldr.f32 s0, [sp]
    vldr.f32 s1, [sp, #4]

    bl atan2f

    vldr.f32 s1, =0x42652ee1    //180 / PI
    vmul.f32 s0, s1

    mov sp, fp

    vpop { s1 }
    pop { r4, r5, r6, fp, pc }
