.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ GPIOD_BASE,                    0x48000C00

.equ GPIO_PIN_6,                    (1 << 6)
.equ GPIO_PIN_7,                    (1 << 7)

.equ READ_WRITE_COMMAND,            0x80
.equ MULTIPLE_BYTE_COMMAND,         0x40

.text

/*
 * Gyroscope (L3GD20) driver
*/

/**
 * @brief Initialize gyroscope (L3GD20)
 * @return None
*/
.type   gyro_init, %function
.global gyro_init
gyro_init:
    push { r4, r5, lr }

    bl rcc_gpiod_clk_enable

    ldr r0, =GPIOD_BASE
    ldr r1, =GPIO_PIN_7
    ldr r2, =0b01           //Mode
    ldr r3, =0b00           //Pull up/down
    ldr r4, =0b0000         //Alternate function
    str r4, [sp, #-4]!
    ldr r4, =0b11           //Output speed
    str r4, [sp, #-4]!

    bl init_gpio

    add sp, #8              //Remove arguments from the stack

    bl gyro_cs_high    //Deselect

    bl rcc_gpiob_clk_enable

    ldr r0, =GPIOB_BASE
    ldr r1, =GPIO_PIN_6
    ldr r2, =0b00           //Mode
    ldr r3, =0b00           //Pull up/down
    ldr r4, =0b0000         //Alternate function
    str r4, [sp, #-4]!
    ldr r4, =0b11           //Output speed
    str r4, [sp, #-4]!

    bl init_gpio

    ldr r1, =GPIO_PIN_7

    bl init_gpio

    add sp, #8              //Remove arguments from the stack

    pop { r4, r5, pc }

.type   gyro_cs_high, %function
.global gyro_cs_high
gyro_cs_high:
    push { r4, r5, lr }

    ldr r0, =GPIOD_BASE
    ldr r1, =0x07
    ldr r2, =0x01
    bl gpio_write_pin

    pop { r4, r5, pc }

.type   gyro_cs_low, %function
.global gyro_cs_low
gyro_cs_low:
    push { r4, r5, lr }

    ldr r0, =GPIOD_BASE
    ldr r1, =0x07
    ldr r2, =0x00
    bl gpio_write_pin

    pop { r4, r5, pc }

/**
 * @brief Read data from the gyroscope
 * @param Write buffer
 * @param Read address
 * @param Read length
 * @return None
*/
.type   gyro_io_read, %function
.global gyro_io_read
gyro_io_read:
    push { r4, r5, lr }

    cmp r2, #1
    IT gt
    orrgt r2, #MULTIPLE_BYTE_COMMAND
    orr r2, #READ_WRITE_COMMAND



    pop { r4, r5, pc }
