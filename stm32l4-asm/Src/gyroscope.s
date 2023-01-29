.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ GPIOD_BASE,                    0x48000C00

.equ GPIO_PIN_7,                    (1 << 7)

.text

.type   gyroscope_init, %function
.global gyroscope_init
gyroscope_init:
    push { r4, r5, lr }

    bl rcc_gpiod_clk_enable

    ldr r0, =GPIOD_BASE
    ldr r1, =GPIO_PIN_7
    ldr r2, =0b01
    ldr r3, =0b00
    ldr r4, =0b0000
    str r4, [sp, #-4]!
    ldr r4, =0b11
    str r4, [sp, #-4]!

    bl init_gpio

    add sp, #8              //Remove arguments from the stack

    bl gyroscope_cs_high    //Deselect

    pop { r4, r5, pc }

.type   gyroscope_cs_high, %function
.global gyroscope_cs_high
gyroscope_cs_high:
    push { r4, r5, lr }

    ldr r0, =GPIOD_BASE
    ldr r1, =0x07
    ldr r2, =0x01
    bl gpio_write_pin

    pop { r4, r5, pc }

.type   gyroscope_cs_low, %function
.global gyroscope_cs_low
gyroscope_cs_low:
    push { r4, r5, lr }

    ldr r0, =GPIOD_BASE
    ldr r1, =0x07
    ldr r2, =0x00
    bl gpio_write_pin

    pop { r4, r5, pc }
