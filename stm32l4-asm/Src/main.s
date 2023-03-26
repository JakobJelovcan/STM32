.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.data
selected_item:      .word 0
.align
item_count:         .word 12
.align
gyro_title:         .asciz "Gyro"
.align
magneto_title:      .asciz "Compas"
.align
accelero_title:     .asciz "Accelerometer"
.align
gyro_data:          .space 12
.align
magneto_data:       .space 12
.align
accelero_data:      .space 12
.align
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
    bl joystick_init_interupt

1:
    ldr r4, =selected_item
    ldr r5, [r4]

    cmp r5, #0
    bne 2f

    ldr r0, =gyro_title
    bl lcd_display_string
    b 3f

2:
    cmp r5, #1
    bne 2f

    ldr r0, =gyro_data
    bl l3gd20_read_xyz

    ldr r0, =display_str_buffer
    ldr r4, =gyro_data
    vldr.f32 s0, [r4]
    bl print_x

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    cmp r5, #2
    bne 2f

    ldr r0, =gyro_data
    bl l3gd20_read_xyz

    ldr r0, =display_str_buffer
    ldr r4, =gyro_data
    vldr.f32 s0, [r4, #4]
    bl print_y

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    cmp r5, #3
    bne 2f

    ldr r0, =gyro_data
    bl l3gd20_read_xyz

    ldr r0, =display_str_buffer
    ldr r4, =gyro_data
    vldr.f32 s0, [r4, #8]
    bl print_z

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    cmp r5, #4
    bne 2f

    ldr r0, =magneto_title
    bl lcd_display_string
    b 3f

2:
    cmp r5, #5
    bne 2f

    ldr r0, =magneto_data
    bl lsm303c_read_xyz_m

    ldr r0, =display_str_buffer
    ldr r4, =magneto_data
    vldr.f32 s0, [r4]
    bl print_x

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    cmp r5, #6
    bne 2f

    ldr r0, =magneto_data
    bl lsm303c_read_xyz_m

    ldr r0, =display_str_buffer
    ldr r4, =magneto_data
    vldr.f32 s0, [r4, #4]
    bl print_y

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    cmp r5, #7
    bne 2f

    ldr r0, =magneto_data
    bl lsm303c_read_xyz_m

    ldr r0, =display_str_buffer
    ldr r4, =magneto_data
    vldr.f32 s0, [r4, #8]
    bl print_z

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    cmp r5, #8
    bne 2f

    ldr r0, =accelero_title
    bl lcd_display_string
    b 3f

2:
    cmp r5, #9
    bne 2f

    ldr r0, =accelero_data
    bl lsm303c_read_xyz_a

    ldr r0, =display_str_buffer
    ldr r4, =accelero_data
    vldr.f32 s0, [r4]
    bl print_x

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f
2:
    cmp r5, #10
    bne 2f

    ldr r0, =accelero_data
    bl lsm303c_read_xyz_a

    ldr r0, =display_str_buffer
    ldr r4, =accelero_data
    vldr.f32 s0, [r4, #4]
    bl print_y

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f
2:
    cmp r5, #11
    bne 3f

    ldr r0, =accelero_data
    bl lsm303c_read_xyz_a

    ldr r0, =display_str_buffer
    ldr r4, =accelero_data
    vldr.f32 s0, [r4, #8]
    bl print_z

    ldr r0, =display_str_buffer
    bl lcd_display_string
    //Read and display data from the sensor
    /*ldr r0, =accelero_data
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
*/
3:
    //Wait 500ms
    mov r0, #0x1F4
    bl systick_wait_ms

    b 1b

__end: b __end

//Joystick center
.type   EXTI0_IRQHandler, %function
.global EXTI0_IRQHandler
EXTI0_IRQHandler:
    push { r4, r5, lr }

    ldr r0, =(1 << 0)
    bl exti_clear_interupt

    pop { r4, r5, pc }

//Joystick left
.type   EXTI1_IRQHandler, %function
.global EXTI1_IRQHandler
EXTI1_IRQHandler:
    push { r4, r5, lr }

    ldr r0, =(1 << 1)
    bl exti_clear_interupt

    pop { r4, r5, pc }

//Joystick right
.type   EXTI2_IRQHandler, %function
.global EXTI2_IRQHandler
EXTI2_IRQHandler:
    push { r4, r5, lr }

    ldr r0, =(1 << 2)
    bl exti_clear_interupt

    pop { r4, r5, pc }

//Joystick up
.type   EXTI3_IRQHandler, %function
.global EXTI3_IRQHandler
EXTI3_IRQHandler:
    push { r4, r5, r6, lr }

    ldr r0, =(1 << 3)
    bl exti_clear_interupt

    ldr r6, =item_count
    ldr r4, [r6]

    ldr r6, =selected_item
    ldr r5, [r6]

    cmp r5, #0
    IT eq
    moveq r5, r4

    sub r5, #1

    str r5, [r6]

    pop { r4, r5, r6, pc }

//Joystick down (pin 5)
.type   EXTI9_5_IRQHandler, %function
.global EXTI9_5_IRQHandler
EXTI9_5_IRQHandler:
    push { r4, r5, r6, lr }

    ldr r0, =(1 << 5)
    bl exti_clear_interupt

    //Increment selected item
    ldr r6, =item_count
    ldr r4, [r6]

    ldr r6, =selected_item
    ldr r5, [r6]

    add r5, #1
    cmp r5, r4
    IT eq
    moveq r5, #0

    str r5, [r6]

    pop { r4, r5, r6, pc }
