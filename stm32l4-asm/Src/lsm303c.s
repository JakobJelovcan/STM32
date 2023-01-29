.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ GPIOC_BASE,                    0x48000800
.equ GPIOE_BASE,                    0x48001000

.equ GPIO_PIN_0,                    (1 << 0)

.text

.type   magnetometer_init, %function
.global magnetometer_init
magnetometer_init:
    push { r4, r5, lr }

    bl rcc_gpioc_clk_enable

    ldr r0, =GPIOC_BASE
    ldr r1, =GPIO_PIN_0
    ldr r2, =0b01
    ldr r3, =0b00
    ldr r4, =0b0000
    str r4, [sp, #-4]!
    ldr r4, =0b11
    str r4, [sp, #-4]!

    bl init_gpio

    add sp, #8              //Remove arguments from the stack

    bl magnetometer_cs_high    //Deselect

    pop { r4, r5, pc }

.type   magnetometer_cs_high, %function
.global magnetometer_cs_high
magnetometer_cs_high:
    push { r4, r5, lr }

    ldr r0, =GPIOC_BASE
    ldr r1, =0x00
    ldr r2, =0x01
    bl gpio_write_pin

    pop { r4, r5, pc }

.type   magnetometer_cs_low, %function
.global magnetometer_cs_low
magnetometer_cs_low:
    push { r4, r5, lr }

    ldr r0, =GPIOC_BASE
    ldr r1, =0x00
    ldr r2, =0x00
    bl gpio_write_pin

    pop { r4, r5, pc }

.type   accelerometer_init, %function
.global accelerometer_init
accelerometer_init:
    push { r4, r5, lr }

    bl rcc_gpioe_clk_enable

    ldr r0, =GPIOE_BASE
    ldr r1, =GPIO_PIN_0
    ldr r2, =0b01
    ldr r3, =0b00
    ldr r4, =0b0000
    str r4, [sp, #-4]!
    ldr r4, =0b11
    str r4, [sp, #-4]!

    bl init_gpio

    add sp, #8              //Remove arguments from the stack

    bl accelerometer_cs_high    //Deselect

    pop { r4, r5, pc }

.type   accelerometer_cs_high, %function
.global accelerometer_cs_high
accelerometer_cs_high:
    push { r4, r5, lr }

    ldr r0, =GPIOE_BASE
    ldr r1, =0x00
    ldr r2, =0x01
    bl gpio_write_pin

    pop { r4, r5, pc }

.type   accelerometer_cs_low, %function
.global accelerometer_cs_low
accelerometer_cs_low:
    push { r4, r5, lr }

    ldr r0, =GPIOE_BASE
    ldr r1, =0x00
    ldr r2, =0x00
    bl gpio_write_pin

    pop { r4, r5, pc }

