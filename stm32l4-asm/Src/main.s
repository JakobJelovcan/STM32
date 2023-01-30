.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.data
string: .space 128
.align
.text

.type   main %function
.global main

main:
    bl fpu_enable

    vmov s0, #1.75
    vmov s1, #1.5

    vadd.f32 s0, s1

    vcvt.u32.f32 s2, s0


    vmov r0, s2
__end: b __end
