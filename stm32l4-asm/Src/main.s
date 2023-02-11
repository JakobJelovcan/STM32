.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.data
string: .space 128
.align
.text

.type   main, %function
.global main

main:
    bl fpu_enable

    bl spi2_init

    bl l3gd20_init
    bl lsm303c_init_accelerometer
    bl lsm303c_init_magnetometer

    bl lsm303c_read_id_a
    bl lsm303c_read_id_m

    bl l3gd20_read_id

    bl l3gd20_read_temp

    bl lsm303c_read_temp_m

    mov fp, sp

    sub sp, #12

    mov r0, sp

    bl l3gd20_read_xyz

    ldr r0, [sp]

__end: b __end
