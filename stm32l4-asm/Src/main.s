.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.data
selected_item:      .byte 0
item_count:         .byte 12
selected_subitem:   .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
subitem_max_count:  .byte 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0
subitem_min_count:  .byte 0, -1, -1, -1, 0, 0, 0, -1, -1, -1, 0, 0

gyro_title:         .asciz "Gyro"
magneto_title:      .asciz "Compas"
accelero_title:     .asciz "Accelerometer"
calibration_title:  .asciz "Calibrate"
temperature_title:  .asciz "Temp"

.align
gyro_data:          .space 12
magneto_data:       .space 12
accelero_data:      .space 12
display_str_buffer: .space 32

.type   gyro_min_max, %object
.global gyro_min_max
gyro_min_max:       .word 0x7f800000, 0x7f800000, 0x7f800000, 0xff800000, 0xff800000, 0xff800000   //min_x ... max_z

.type   magneto_min_max, %object
.global magneto_min_max
magneto_min_max:    .word 0x7f800000, 0x7f800000, 0x7f800000, 0xff800000, 0xff800000, 0xff800000   //min_x ... max_z

.type   accelero_min_max, %object
.global accelero_min_max
accelero_min_max:   .word 0x7f800000, 0x7f800000, 0x7f800000, 0xff800000, 0xff800000, 0xff800000   //min_x ... max_z

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
    ldrb r5, [r4]
    ldr r4, =selected_subitem
    ldrsb r6, [r4, r5]

    //Read data from the sensors
    ldr r0, =gyro_data
    bl l3gd20_read_xyz
    ldr r0, =gyro_data
    ldr r1, =gyro_min_max
    bl record_min_max

    ldr r0, =accelero_data
    bl lsm303c_read_xyz_a
    ldr r0, =accelero_data
    ldr r1, =accelero_min_max
    bl record_min_max

    ldr r0, =magneto_data
    bl lsm303c_read_xyz_m

    cmp r5, #0
    bne 2f

    ldr r0, =gyro_title
    bl lcd_display_string
    b 3f
//Gyroscope
2:
    //Gyro x
    cmp r5, #1
    bne 2f

    //Gyro x max
    cmp r6, #1
    bne 4f
    ldr r4, =gyro_min_max
    vldr.f32 s0, [r4, #12]
    b 5f
4:
    //Gyro x min
    cmp r6, #-1
    bne 4f
    ldr r4, =gyro_min_max
    vldr.f32 s0, [r4]
    b 5f

4:
    //Gyro x current
    ldr r4, =gyro_data
    vldr.f32 s0, [r4]
5:
    ldr r0, =display_str_buffer
    bl print_x
    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    //Gyro y
    cmp r5, #2
    bne 2f

    //Gyro y max
    cmp r6, #1
    bne 4f
    ldr r4, =gyro_min_max
    vldr.f32 s0, [r4, 16]
    b 5f
4:
    //Gyro y min
    cmp r6, #-1
    bne 4f
    ldr r4, =gyro_min_max
    vldr.f32 s0, [r4, #4]
    b 5f

4:
    //Gyro y current
    ldr r4, =gyro_data
    vldr.f32 s0, [r4, #4]
5:
    ldr r0, =display_str_buffer
    bl print_y
    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    //Gyro z
    cmp r5, #3
    bne 2f

    //Gyro z max
    cmp r6, #1
    bne 4f
    ldr r4, =gyro_min_max
    vldr.f32 s0, [r4, #20]
    b 5f
4:
    //Gyro z min
    cmp r6, #-1
    bne 4f
    ldr r4, =gyro_min_max
    vldr.f32 s0, [r4, #8]
    b 5f

4:
    //Gyro z current
    ldr r4, =gyro_data
    vldr.f32 s0, [r4, #8]
5:
    ldr r0, =display_str_buffer
    bl print_z
    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

//Magnetometer
2:
    cmp r5, #4
    bne 2f

    ldr r4, =selected_subitem

    //Calibration loop
4:  ldrsb r6, [r4, #4]
    cmp r6, #1
    bne 5f
    ldr r0, =calibration_title
    bl lcd_display_string
    bl calibrate_m

    //Wait for 10ms
    mov r0, #0xA
    bl systick_wait_ms
    b 4b
5:
    cmp r6, #0
    bne 2f

    ldr r0, =magneto_title
    bl lcd_display_string
    b 3f
2:
    cmp r5, #5
    bne 2f

    ldr r0, =magneto_data
    ldr r1, =magneto_min_max
    ldr r2, =accelero_data
    bl calculate_angle
    mov r1, r0

    ldr r0, =display_str_buffer

    bl print

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

//Accelerometer
2:
    cmp r5, #6
    bne 2f

    ldr r0, =accelero_title
    bl lcd_display_string
    b 3f
2:
    //Accelero x
    cmp r5, #7
    bne 2f

    //Accelero x max
    cmp r6, #1
    bne 4f
    ldr r4, =accelero_min_max
    vldr.f32 s0, [r4, #12]
    b 5f
4:
    //Accelero x min
    cmp r6, #-1
    bne 4f
    ldr r4, =accelero_min_max
    vldr.f32 s0, [r4]
    b 5f

4:
    //Accelero x current
    ldr r4, =accelero_data
    vldr.f32 s0, [r4]
5:
    ldr r0, =display_str_buffer
    bl print_x
    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    //Accelero y
    cmp r5, #8
    bne 2f

    //Accelero y max
    cmp r6, #1
    bne 4f
    ldr r4, =accelero_min_max
    vldr.f32 s0, [r4, #16]
    b 5f
4:
    //Accelero y min
    cmp r6, #-1
    bne 4f
    ldr r4, =accelero_min_max
    vldr.f32 s0, [r4, #4]
    b 5f

4:
    //Accelero y current
    ldr r4, =accelero_data
    vldr.f32 s0, [r4, #4]
5:
    ldr r0, =display_str_buffer
    bl print_y
    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

2:
    //Accelero z
    cmp r5, #9
    bne 2f

    //Accelero z max
    cmp r6, #1
    bne 4f
    ldr r4, =accelero_min_max
    vldr.f32 s0, [r4, #20]
    b 5f
4:
    //Accelero z min
    cmp r6, #-1
    bne 4f
    ldr r4, =accelero_min_max
    vldr.f32 s0, [r4, #8]
    b 5f

4:
    //Accelero z current
    ldr r4, =accelero_data
    vldr.f32 s0, [r4, #8]
5:
    ldr r0, =display_str_buffer
    bl print_z
    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

//Temperature
2:
    cmp r5, #10
    bne 2f
    ldr r0, =temperature_title
    bl lcd_display_string
    b 3f

2:
    cmp r5, #11
    bne 3f

    bl l3gd20_read_temp
    mov r1, r0
    ldr r0, =display_str_buffer
    bl print

    ldr r0, =display_str_buffer
    bl lcd_display_string
    b 3f

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
    push { r4, r5, r6, r7, r8, lr }

    ldr r0, =(1 << 1)
    bl exti_clear_interupt

    ldr r4, =selected_item
    ldr r5, =selected_subitem
    ldr r6, =subitem_min_count
    ldrb r4, [r4]       //Selected item
    ldrsb r7, [r5, r4]   //Selected subitem
    ldrsb r8, [r6, r4]   //Max subitem

    cmp r7, r8
    IT gt
    subgt r7, #1

    strb r7, [r5, r4]

    pop { r4, r5, r6, r7, r8, pc }

//Joystick right
.type   EXTI2_IRQHandler, %function
.global EXTI2_IRQHandler
EXTI2_IRQHandler:
    push { r4, r5, r6, r7, r8, lr }

    ldr r0, =(1 << 2)
    bl exti_clear_interupt

    ldr r4, =selected_item
    ldr r5, =selected_subitem
    ldr r6, =subitem_max_count
    ldrb r4, [r4]       //Selected item
    ldrsb r7, [r5, r4]   //Selected subitem
    ldrsb r8, [r6, r4]   //Max subitem

    cmp r7, r8
    IT lt
    addlt r7, #1

    strb r7, [r5, r4]

    pop { r4, r5, r6, r7, r8, pc }

//Joystick up
.type   EXTI3_IRQHandler, %function
.global EXTI3_IRQHandler
EXTI3_IRQHandler:
    push { r4, r5, r6, r7, lr }

    ldr r0, =(1 << 3)
    bl exti_clear_interupt

    ldr r6, =item_count
    ldrb r4, [r6]

    ldr r6, =selected_item
    ldrb r5, [r6]

    ldr r7, =selected_subitem
    ldrsb r7, [r7, r5]
    cmp r7, #0
    bne 2f

    cmp r5, #0
    IT eq
    moveq r5, r4

    sub r5, #1

    strb r5, [r6]
2:
    pop { r4, r5, r6, r7, pc }

//Joystick down (pin 5)
.type   EXTI9_5_IRQHandler, %function
.global EXTI9_5_IRQHandler
EXTI9_5_IRQHandler:
    push { r4, r5, r6, r7, lr }

    ldr r0, =(1 << 5)
    bl exti_clear_interupt

    //Increment selected item
    ldr r6, =item_count
    ldrb r4, [r6]

    ldr r6, =selected_item
    ldrb r5, [r6]

    ldr r7, =selected_subitem
    ldrsb r7, [r7, r5]
    cmp r7, #0
    bne 2f

    add r5, #1
    cmp r5, r4
    IT eq
    moveq r5, #0

    strb r5, [r6]
2:
    pop { r4, r5, r6, r7, pc }
