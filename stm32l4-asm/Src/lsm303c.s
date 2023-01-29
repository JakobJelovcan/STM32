.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ GPIOC_BASE,                    0x48000800
.equ GPIOE_BASE,                    0x48001000

.equ GPIO_PIN_0,                    (1 << 0)

.text
/*
 * Magnetometer and accelerometer (LSM303C) driver
*/

.type   magneto_init, %function
.global magneto_init
magneto_init:
    push { r4, r5, lr }

    bl rcc_gpioc_clk_enable

    ldr r0, =GPIOC_BASE
    ldr r1, =GPIO_PIN_0
    ldr r2, =0b01           //Mode
    ldr r3, =0b00           //Pull up/down
    ldr r4, =0b0000         //Alternate function
    str r4, [sp, #-4]!
    ldr r4, =0b11           //Output speed
    str r4, [sp, #-4]!

    bl init_gpio

    add sp, #8              //Remove arguments from the stack

    bl magneto_cs_high    //Deselect

    pop { r4, r5, pc }

.type   magneto_cs_high, %function
.global magneto_cs_high
magneto_cs_high:
    push { r4, r5, lr }

    ldr r0, =GPIOC_BASE
    ldr r1, =0x00
    ldr r2, =0x01
    bl gpio_write_pin

    pop { r4, r5, pc }

.type   magneto_cs_low, %function
.global magneto_cs_low
magneto_cs_low:
    push { r4, r5, lr }

    ldr r0, =GPIOC_BASE
    ldr r1, =0x00
    ldr r2, =0x00
    bl gpio_write_pin

    pop { r4, r5, pc }

.type   accelero_init, %function
.global accelero_init
accelero_init:
    push { r4, r5, lr }

    bl rcc_gpioe_clk_enable

    ldr r0, =GPIOE_BASE
    ldr r1, =GPIO_PIN_0
    ldr r2, =0b01           //Mode
    ldr r3, =0b00           //Pull up/down
    ldr r4, =0b0000         //Alternate function
    str r4, [sp, #-4]!
    ldr r4, =0b11           //Output speed
    str r4, [sp, #-4]!

    bl init_gpio

    add sp, #8              //Remove arguments from the stack

    bl accelero_cs_high    //Deselect

    pop { r4, r5, pc }

.type   accelero_cs_high, %function
.global accelero_cs_high
accelero_cs_high:
    push { r4, r5, lr }

    ldr r0, =GPIOE_BASE
    ldr r1, =0x00
    ldr r2, =0x01
    bl gpio_write_pin

    pop { r4, r5, pc }

.type   accelero_cs_low, %function
.global accelero_cs_low
accelero_cs_low:
    push { r4, r5, lr }

    ldr r0, =GPIOE_BASE
    ldr r1, =0x00
    ldr r2, =0x00
    bl gpio_write_pin

    pop { r4, r5, pc }

