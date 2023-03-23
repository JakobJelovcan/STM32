.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.data
gyro_data:          .space 12
magneto_data:       .space 12
accelero_data:      .space 12
display_str_buffer: .space 32

.align
.text

.type   main, %function
.global main

main:
    //Initialize devices
    bl fpu_enable
    bl spi2_init
    bl l3gd20_init
    bl lsm303c_init_accelerometer
    bl lsm303c_init_magnetometer
    bl lcd_init

1:
    //Read and display data from the sensor
    ldr r0, =accelero_data
    bl lsm303c_read_xyz_a

    bl lsm303c_read_id_m

    ldr r0, =gyro_data
    //bl l3gd20_read_xyz

    ldr r0, =magneto_data
  //  bl lsm303c_read_xyz_m


    ldr r0, =display_str_buffer
    ldr r4, =accelero_data
    vldr.f32 s0, [r4, #4]
    bl print_x

    ldr r0, =display_str_buffer
    bl lcd_display_string

    //Wait 500ms
    mov r0, #0x1F4
    bl systick_wait_ms

    b 1b


    /*
    ldr r0, =magneto_data
    bl lsm303c_read_xyz_m

    ldr r0, =accelero_data
    bl lsm303c_read_xyz_a
    */

__end: b __end
