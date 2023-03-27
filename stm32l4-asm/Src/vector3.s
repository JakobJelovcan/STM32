/*
 * vector3.s
 *
 *  Created on: 26. mar. 2023
 *      Author: Jakob
 */

.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

/**
 * @summary The function takes two three (3) dimentional vectors of floats and computes a dot product
 * @param vector1
 * @param vector2
 * @return The dot product of vector1 and vector2
*/
.type   dot, %function
.global dot
dot:
    push { lr }
    vpush { s4, s5 }

    vldr.f32 s0, [r0]
    vldr.f32 s4, [r0, #4]
    vldr.f32 s5, [r0, #8]

    vmul.f32 s0, s0, s0
    vmul.f32 s4, s4, s4
    vmul.f32 s5, s5, s5

    vadd.f32 s0, s4
    vadd.f32 s0, s5

    vpop { s4, s5 }
    pop { pc }

/**
 * @summary The function takes two three (3) dimentional vectors and adds them component wise
 * @param Destination vector
 * @param Source vector1
 * @param Source vector2
 * @return The sum of vector1 and vector2
*/
.type   add, %function
.global add
add:
    push { lr }
    vpush { s4, s5, s6, s7, s8, s9 }

    vldr.f32 s4, [r1]
    vldr.f32 s5, [r2]
    vldr.f32 s6, [r1, #4]
    vldr.f32 s7, [r2, #4]
    vldr.f32 s8, [r1, #8]
    vldr.f32 s9, [r2, #8]

    vadd.f32 s4, s5
    vadd.f32 s6, s7
    vadd.f32 s8, s9
    vstr.f32 s4, [r0]
    vstr.f32 s5, [r0, #4]
    vstr.f32 s6, [r0, #8]

    vpop { s4, s5, s6, s7, s8, s9 }
    pop { pc }

/**
 * @summary The function takes two three (3) dimentional vectors and substracts them component wise
 * @param Destination vector
 * @param Source vector1
 * @param Source vector2
 * @return The difference between vector1 and vector2
*/
.type   sub, %function
.global sub
sub:
    push { lr }
    vpush { s4, s5, s6, s7, s8, s9 }

    vldr.f32 s4, [r1]
    vldr.f32 s5, [r2]
    vldr.f32 s6, [r1, #4]
    vldr.f32 s7, [r2, #4]
    vldr.f32 s8, [r1, #8]
    vldr.f32 s9, [r2, #8]

    vsub.f32 s4, s5
    vsub.f32 s6, s7
    vsub.f32 s8, s9
    vstr.f32 s4, [r0]
    vstr.f32 s5, [r0, #4]
    vstr.f32 s6, [r0, #8]

    vpop { s4, s5, s6, s7, s8, s9 }
    pop { pc }

/**
 * @summary The function takes one three (3) dimentional vectors and multiplies it with a constant
 * @param Source float constant
 * @param Destination vector
 * @param Source vector
 * @return Source vector multiplied by the constant
*/
.type   mul, %function
.global mul
mul:
    push { lr }
    vpush { s4, s5, s6 }

    vldr.f32 s4, [r1]
    vldr.f32 s5, [r1, #4]
    vldr.f32 s6, [r1, #8]

    vmul.f32 s4, s0
    vmul.f32 s5, s0
    vmul.f32 s6, s0

    vstr.f32 s4, [r0]
    vstr.f32 s5, [r0, #4]
    vstr.f32 s6, [r0, #8]

    vpop { s4, s5, s6 }
    pop { pc }

/**
 * @summary The function takes two three (3) dimentional vectors and computes a projection of vector1 onto vector2
 * @param Destination vector
 * @param Source vector1
 * @param Source vector2
 * @return The projection of vector1 onto vector2
*/
.type   project, %function
.global project
project:
    push { r4, r5, r6, lr }
    vpush { s4 }

    mov r4, r0
    mov r5, r1
    mov r6, r2

    mov r0, r5
    mov r1, r6
    bl dot      //Dot product between vector1 and vector2
    vmov.f32 s4, s0

    mov r0, r6
    mov r1, r6
    bl dot      //Dot product between vector2 and vector2

    vdiv.f32 s0, s4, s0

    mov r0, r4
    mov r1, r6
    bl mul

    vpop { s4 }
    pop { r4, r5, r6, pc }

/**
 * @summary The function takes one three (3) dimentional vector and normalizes it
 * @param Destination vector
 * @param Source vector
 * @return Normalized vector
*/
.type   normalize, %function
.global normalize
normalize:
    push { lr }
    vpush { s4, s5, s6 }

    bl length

    vldr.f32 s4, [r1]
    vldr.f32 s5, [r1, #4]
    vldr.f32 s6, [r1, #8]

    vdiv.f32 s4, s4, s0
    vdiv.f32 s5, s5, s0
    vdiv.f32 s6, s6, s0

    vstr.f32 s4, [r0]
    vstr.f32 s5, [r0, #4]
    vstr.f32 s6, [r0, #8]

    vpop { s4, s5, s6 }
    pop { pc }

/**
 * @summary The function takes one three (3) dimentional vector and computes it's length
 * @param vector
 * @return the length of the vector
*/
.type   length, %function
.global length
length:
    push { lr }
    vpush { s4, s5 }

    vldr.f32 s0, [r0]
    vldr.f32 s4, [r0, #4]
    vldr.f32 s5, [r0, #8]

    vmul.f32 s0, s0, s0
    vmul.f32 s4, s4, s4
    vmul.f32 s5, s5, s5

    vadd.f32 s0, s4
    vadd.f32 s0, s5
    vsqrt.f32 s0, s0

    vpop { s4, s5 }
    pop { pc }
