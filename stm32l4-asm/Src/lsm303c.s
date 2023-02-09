/*
 * lsm303c.s
 *
 *  Created on: 9. feb. 2023
 *      Author: Jakob
 */


.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

//GPIO
.equ LSM303C_GPIO_A,                0x48001000
.equ LSM303C_CS_PIN_A,              (1 << 0)
.equ LSM303C_GPIO_M,                0x48000800
.equ LSM303C_CS_PIN_M,              (1 << 0)

.equ GPIO_MODE_OUTPUT_PP,   0x01
.equ GPIO_NO_PULL,          0x00
.equ GPIO_AF_5,             0x05
.equ GPIO_SPEED_VERY_HIGH,  0x03

.equ GPIOx_MODER,           0x00
.equ GPIOx_OTYPER,          0x04
.equ GPIOx_OSPEEDR,         0x08
.equ GPIOx_PUPDR,           0x0C
.equ GPIOx_IDR,             0x10
.equ GPIOx_ODR,             0x14
.equ GPIOx_BSRR,            0x18
.equ GPIOx_LCKR,            0x1C
.equ GPIOx_AFRL,            0x20
.equ GPIOx_AFRH,            0x24
.equ GPIOx_BRR,             0x28

//Accelerometer
.equ LSM303C_WHO_AM_I_A,            0x0F
.equ LSM303C_ACT_THS_A,             0x1E
.equ LSM303C_ACT_DUR_A,             0x1F
.equ LSM303C_CTRL_REG1_A,           0x20
.equ LSM303C_CTRL_REG2_A,           0x21
.equ LSM303C_CTRL_REG3_A,           0x22
.equ LSM303C_CTRL_REG4_A,           0x23
.equ LSM303C_CTRL_REG5_A,           0x24
.equ LSM303C_CTRL_REG6_A,           0x25
.equ LSM303C_CTRL_REG7_A,           0x26
.equ LSM303C_STATUS_REG_A,          0x27
.equ LSM303C_OUT_X_L_A,             0x28
.equ LSM303C_OUT_X_H_A,             0x29
.equ LSM303C_OUT_Y_L_A,             0x2A
.equ LSM303C_OUT_Y_H_A,             0x2B
.equ LSM303C_OUT_Z_L_A,             0x2C
.equ LSM303C_OUT_Z_H_A,             0x2D
.equ LSM303C_FIFO_CTRL,             0x2E
.equ LSM303C_FIFO_SRC,              0x2F
.equ LSM303C_IG_CFG1_A,             0x30
.equ LSM303C_IG_SRC1_A,             0x31
.equ LSM303C_THS_X1_A,              0x32
.equ LSM303C_THS_Y1_A,              0x33
.equ LSM303C_THS_Z1_A,              0x34
.equ LSM303C_IG_DUR2_A,             0x35

.equ LSM303C_IG_CFG2_A,             0x36
.equ LSM303C_IG_SRC2_A,             0x37
.equ LSM303C_IG_THS2_A,             0x38
.equ LSM303C_IG_DUR2_A,             0x39
.equ LSM303C_XL_REFERENCE,          0x3A
.equ LSM303C_XH_REFERENCE,          0x3B
.equ LSM303C_YL_REFERENCE,          0x3C
.equ LSM303C_YH_REFERENCE,          0x3D
.equ LSM303C_ZL_REFERENCE,          0x3E
.equ LSM303C_ZH_REFERENCE,          0x3F

//Magnetometer
.equ LSM303C_WHO_AM_I_M,            0x0F
.equ LSM303C_CTRL_REG1_M,           0x20
.equ LSM303C_CTRL_REG2_M,           0x21
.equ LSM303C_CTRL_REG3_M,           0x22
.equ LSM303C_CTRL_REG4_M,           0x23
.equ LSM303C_CTRL_REG5_M,           0x24
.equ LSM303C_STATUS_REG_M,          0x27
.equ LSM303C_OUT_X_L_M,             0x28
.equ LSM303C_OUT_X_H_M,             0x29
.equ LSM303C_OUT_Y_L_M,             0x2A
.equ LSM303C_OUT_Y_H_M,             0x2B
.equ LSM303C_OUT_Z_L_M,             0x2C
.equ LSM303C_OUT_Z_H_M,             0x2D
.equ LSM303C_TEMP_L_M,              0x2E
.equ LSM303C_TEMP_H_M,              0x2F
.equ LSM303C_INT_CFG_M,             0x30
.equ LSM303C_INT_SRC_M,             0x31
.equ LSM303C_INT_THS_L_M,           0x32
.equ LSM303C_INT_THS_H_M,           0x33

.equ LSM303C_READ_COMMAND,          (1 << 7)
.equ LSM303C_MULTI_COMMAND,         (1 << 6)

.text

.type   lsm303c_a_write, %function
.local  lsm303c_a_write
lsm303c_a_write:
    push { r4, r5, r6, lr }

    mov r4, r0
    mov r5, r1
    mov r6, r2

    cmp r4, #1
    IT gt
    orrgt r4, LSM303C_MULTI_COMMAND

    bl lsm303c_a_cs_low
    bl spi2_direction_1_line_tx

    mov r0, r4
    bl spi2_transmit

1:  ldrb r0, [r5], #1
    bl spi2_transmit
    subs r6, #1
    bne 1b

    bl lsm303c_a_cs_high

    pop { r4, r5, r6, pc }

.type   lsm303c_a_read, %function
.local  lsm303c_a_read
lsm303c_a_read:
    push { r4, r5, r6, lr }

    mov r4, r0
    mov r5, r1
    mov r6, r2

    orr r4, LSM303C_READ_COMMAND
    cmp r4, #1
    IT gt
    orrgt r4, LSM303C_MULTI_COMMAND

    bl lsm303c_a_cs_low
    bl spi2_direction_1_line_tx

    mov r0, r4
    spi2_transmit

    bl spi2_direction_1_line_rx

1:  bl spi2_receive
    strb r0, [r5] #1
    subs r6, #1
    b 1b

    bl lsm303c_a_high

    pop { r4, r5, r6, pc }


.type   lsm303c_a_cs_low, %function
.local  lsm303c_a_cs_low
lsm303c_a_cs_low:
    push { r4, r5, lr }

    ldr r4, =LSM303C_GPIO_A
    ldr r5, [r4, #GPIOx_BRR]
    orr r5, LSM303C_A_CS_PIN
    str r5, [r4, #GPIOx_BRR]

    pop { r4, r5, pc }

.type   lsm303c_a_cs_high, %function
.local  lsm303c_a_cs_high
lsm303c_a_cs_high:
    push { r4, r5, lr }

    ldr r4, =LSM303C_GPIO_A
    ldr r5, [r4, #GPIOx_BSRR]
    orr r5, LSM303C_A_CS_PIN
    str r5, [r4, #GPIOx_BSRR]

    pop { r4, r5, pc }

.type   lsm303c_m_cs_low, %function
.local  lsm303c_m_cs_low
lsm303c_m_cs_low:
    push { r4, r5, lr }

    ldr r4, =LSM303C_GPIO_M
    ldr r5, [r4, #GPIOx_BRR]
    orr r5, LSM303C_M_CS_PIN
    str r5, [r4, #GPIOx_BRR]

    pop { r4, r5, pc }

.type   lsm303c_m_cs_high, %function
.local  lsm303c_m_cs_high
lsm303c_m_cs_high:
    push { r4, r5, lr }

    ldr r4, =LSM303C_GPIO_M
    ldr r5, [r4, #GPIOx_BSRR]
    orr r5, LSM303C_M_CS_PIN
    str r5, [r4, #GPIOx_BSRR]

    pop { r4, r5, pc }

.type   lsm303c_accelero_init, %function
.global lsm303c_accelero_init
lsm303c_accelero_init:
    push { r4, r5, fp, lr }

    mov fp, sp
    sub sp, #8

    bl rcc_gpioe_clk_enable

    //Init LSM303C_A GPIO
    ldr r0, =LSM303C_GPIO_A
    ldr r1, =LSM303C_CS_PIN
    ldr r2, =GPIO_MODE_OUTPUT_PP
    ldr r3, =GPIO_NO_PULL
    ldr r4, =0x00
    str r4, [fp, #-4]
    ldr r4, =GPIO_SPEED_VERY_HIGH
    str r4, [fp, #-8]
    bl gpio_init



    mov sp, fp

    pop { r4, r5, fp, pc }
