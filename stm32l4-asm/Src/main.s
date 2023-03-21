.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.data
display_str_buffer: .space 10
temp_out_string:    .asciz "%dC"
out_string_x:       .asciz "X:%-6.3f"
out_string_y:       .asciz "Y:%-6.3f"
out_string_z:       .asciz "Z:%-6.3f"

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
