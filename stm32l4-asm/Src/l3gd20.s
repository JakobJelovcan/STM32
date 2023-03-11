/*
 * l3gd20.s
 *
 *  Created on: 8. feb. 2023
 *      Author: Jakob
 */

.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.equ L3GD20_GPIO,           0x48000C00
.equ L3GD20_CS_PIN,         (1 << 7)

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

.equ L3GD20_WHO_AM_I,       0x0F
.equ L3GD20_CTRL_REG1,      0x20
.equ L3GD20_CTRL_REG2,      0x21
.equ L3GD20_CTRL_REG3,      0x22
.equ L3GD20_CTRL_REG4,      0x23
.equ L3GD20_CTRL_REG5,      0x24
.equ L3GD20_REFERENCE,      0x25
.equ L3GD20_OUT_TEMP,       0x26
.equ L3GD20_STATUS_REG,     0x27
.equ L3GD20_OUT_X_L,        0x28
.equ L3GD20_OUT_X_H,        0x29
.equ L3GD20_OUT_Y_L,        0x2A
.equ L3GD20_OUT_Y_H,        0x2B
.equ L3GD20_OUT_Z_L,        0x2C
.equ L3GD20_OUT_Z_H,        0x2D
.equ L3GD20_FIFO_CTRL_REG,  0x2E
.equ L3GD20_FIFO_SRC_REG,   0x2F
.equ L3GD20_INT1_CFG,       0x30
.equ L3GD20_INT1_SRC,       0x31
.equ L3GD20_INT1_THS_XH,    0x32
.equ L3GD20_INT1_THS_XL,    0x33
.equ L3GD20_INT1_THS_YH,    0x34
.equ L3GD20_INT1_THS_YL,    0x35
.equ L3GD20_INT1_THS_ZH,    0x36
.equ L3GD20_INT1_THS_ZL,    0x37
.equ L3GD20_INT1_DURATION,  0x38

.equ L3GD20_DR_MASK,        (0b11 << 6)
.equ L3GD20_DR_1,           (0b00 << 6)
.equ L3GD20_DR_2,           (0b01 << 6)
.equ L3GD20_DR_3,           (0b10 << 6)
.equ L3GD20_DR_4,           (0b11 << 6)

.equ L3GD20_BW_MASK,        (0b11 << 4)
.equ L3GD20_BW_1,           (0b00 << 4)
.equ L3GD20_BW_2,           (0b01 << 4)
.equ L3GD20_BW_3,           (0b10 << 4)
.equ L3GD20_BW_4,           (0b11 << 4)

.equ L3GD20_PD_MASK,        (1 << 3)
.equ L3GD20_PD_ACTIVE,      (1 << 3)
.equ L3GD20_PD_POWERDOWN,   0x00

.equ L3GD20_XYZ_MASK,       (0b111 << 0)
.equ L3GD20_XYZ_ENABLE,     (0b111 << 0)
.equ L3GD20_XYZ_DISABLE,    0x00

.equ L3GD20_HPM_MASK,       (0b11 << 4)
.equ L3GD20_HPM_1,          (0b00 << 4)
.equ L3GD20_HPM_2,          (0b01 << 4)
.equ L3GD20_HPM_3,          (0b10 << 4)
.equ L3GD20_HPM_4,          (0b11 << 4)

.equ L3GD20_HPCF_MASK,      (0b1111 << 0)
.equ L3GD20_HPCF_1,         (0b0000 << 0)
.equ L3GD20_HPCF_2,         (0b0001 << 0)
.equ L3GD20_HPCF_3,         (0b0010 << 0)
.equ L3GD20_HPCF_4,         (0b0011 << 0)
.equ L3GD20_HPCF_5,         (0b0100 << 0)
.equ L3GD20_HPCF_6,         (0b0101 << 0)
.equ L3GD20_HPCF_7,         (0b0110 << 0)
.equ L3GD20_HPCF_8,         (0b0111 << 0)
.equ L3GD20_HPCF_9,         (0b1000 << 0)
.equ L3GD20_HPCF_10,        (0b1001 << 0)
.equ L3GD20_HPCF_11,        (0b1010 << 0)
.equ L3GD20_HPCF_12,        (0b1011 << 0)
.equ L3GD20_HPCF_13,        (0b1100 << 0)
.equ L3GD20_HPCF_14,        (0b1101 << 0)
.equ L3GD20_HPCF_15,        (0b1110 << 0)
.equ L3GD20_HPCF_16,        (0b1111 << 0)

.equ L3GD20_BDU_MASK,       (1 << 7)
.equ L3GD20_BDU_CONTINUOUS, 0x00
.equ L3GD20_BDU_ON_READ,    (1 << 7)

.equ L3GD20_BLE_MASK,       (1 << 6)
.equ L3GD20_BLE_LITTLE,     0x00
.equ L3GD20_BLE_BIG,        (1 << 6)

.equ L3GD20_FS_MASK,        (0b11 << 4)
.equ L3GD20_FS_250,         (0b00 << 4)
.equ L3GD20_FS_500,         (0b00 << 4)
.equ L3GD20_FS_2000,        (0b00 << 4)

.equ L3GD20_SIM_MASK,       (1 << 0)
.equ L3GD20_SIM_4_WIRE,     0x00
.equ L3GD20_SIM_3_WIRE,     (1 << 0)

.equ L3GD20_READ_COMMAND,   (1 << 7)
.equ L3GD20_MULTI_COMMAND,  (1 << 6)

.text


.type   l3gd20_write, %function
.local  l3gd20_write
l3gd20_write:
    push { r4, r5, r6, lr }

    mov r4, r0
    mov r5, r1
    mov r6, r2

    //If count is greater than 1 add multiple command to address in r4
    cmp r6, #1
    IT gt
    orrgt r4, L3GD20_MULTI_COMMAND

    bl l3gd20_cs_low    //Select L3GD20
    bl spi2_direction_2_lines

    //Transmit write address to L3GD20
    mov r0, r4
    bl spi2_transmit_receive

    //Transmit data to write to L3GD20
1:  ldrb r0, [r5], #1
    bl spi2_transmit_receive
    subs r6, #1
    bne 1b

    bl l3gd20_cs_high   //De-select L3GD20

    pop { r4, r5, r6, pc }

.type   l3gd20_read, %function
.local  l3gd20_read
l3gd20_read:
    push { r4, r5, r6, lr }


    mov r4, r0
    mov r5, r1
    mov r6, r2

    orr r4, L3GD20_READ_COMMAND

    //If count is greater than 1 add multiple command to address in r4
    cmp r6, #1
    IT gt
    orrgt r4, L3GD20_MULTI_COMMAND

    bl l3gd20_cs_low    //Select L3GD20
    bl spi2_direction_2_lines

    //Transmit read address from L3GD20
    mov r0, r4
    bl spi2_transmit_receive

    //Read data from L3GD20
1:  ldrb r0, =0x00
    bl spi2_transmit_receive
    strb r0, [r5], #1
    subs r6, #1
    bne 1b

    bl l3gd20_cs_high   //De-select L3GD20

    pop { r4, r5, r6, pc }

.type   l3gd20_cs_low, %function
.local  l3gd20_cs_low
l3gd20_cs_low:
    push { r4, r5, lr }

    ldr r4, =L3GD20_GPIO
    ldr r5, [r4, #GPIOx_BRR]
    orr r5, #L3GD20_CS_PIN
    str r5, [r4, #GPIOx_BRR]

    pop { r4, r5, pc }

.type   l3gd20_cs_high, %function
.local  l3gd20_cs_high
l3gd20_cs_high:
    push { r4, r5, lr }

    ldr r4, =L3GD20_GPIO
    ldr r5, [r4, #GPIOx_BSRR]
    orr r5, #L3GD20_CS_PIN
    str r5, [r4, #GPIOx_BSRR]

    pop { r4, r5, pc }

.type   l3gd20_init, %function
.global l3gd20_init
l3gd20_init:
    push { r4, r5, fp, lr }

    mov fp, sp
    sub sp, #8
    //Initialize L3GD20 GPIO
    bl rcc_gpiod_clk_enable

    ldr r0, =L3GD20_GPIO
    ldr r1, =L3GD20_CS_PIN
    ldr r2, =GPIO_MODE_OUTPUT_PP
    ldr r3, =GPIO_NO_PULL
    ldr r4, =0
    str r4, [fp, #-4]
    ldr r4, =GPIO_SPEED_VERY_HIGH
    str r4, [fp, #-8]

    bl gpio_init


    //Write to register L3GD20_CTRL_REG1
    ldr r4, =(L3GD20_DR_1 | L3GD20_BW_4 | L3GD20_PD_ACTIVE | L3GD20_XYZ_ENABLE)
    strb r4, [fp, #-4]

    ldr r0, =L3GD20_CTRL_REG1
    sub r1, fp, #4
    ldr r2, =0x01
    bl l3gd20_write


    //Write to register L3GD20_CTRL_REG4
    ldr r4, =(L3GD20_BDU_CONTINUOUS | L3GD20_BLE_LITTLE | L3GD20_FS_500)
    str r4, [fp, #-4]
    ldr r0, =L3GD20_CTRL_REG4
    sub r1, fp, #4
    ldr r2, =0x01
    bl l3gd20_write

    mov sp, fp

    pop { r4, r5, fp, pc }

.type   l3gd20_read_id, %function
.global l3gd20_read_id
l3gd20_read_id:
    push { fp, lr }

    mov fp, sp
    sub sp, #4  //Make room on the stack for variables

    ldr r0, =L3GD20_WHO_AM_I    //Address for L3GD20
    sub r1, fp, #4              //Data ptr
    ldr r2, =0x01               //Size

    bl l3gd20_read

    ldrb r0, [fp, #-4]
    mov sp, fp

    pop { fp, pc }

.type   l3gd20_read_temp, %function
.global l3gd20_read_temp
l3gd20_read_temp:
    push { fp, lr }

    mov fp, sp
    sub sp, #4  //Make room on the stack for variables

    ldr r0, =L3GD20_OUT_TEMP    //Address for L3GD20
    sub r1, fp, #4              //Data ptr
    ldr r2, =0x01               //Size

    bl l3gd20_read

    ldrsb r0, [fp, #-4]
    rsb r0, #47                 //Calibration
    mov sp, fp

    pop { fp, pc }

.type   l3gd20_read_xyz, %function
.global l3gd20_read_xyz
l3gd20_read_xyz:
    push { r4, r5, r6, r7, fp, lr }

    mov r7, r0
    mov fp, sp
    sub sp, #8              //Make room on the stack for variables

    ldr r0, =L3GD20_CTRL_REG1   //Address for L3GD20
    sub r1, fp, #4              //Data ptr
    ldr r2, =0x01               //Size

    ldrb r4, [fp, #-4]
    and r4, L3GD20_FS_MASK

    //Load constant in to s1 based on the value of FS in L3GD20_CTRL_REG4
    teq r4, L3GD20_FS_250
    bne 1f

    vldr.f32 s1, =0x3c0f5c29    //0.00875f
    b 2f
1:
    teq r4, L3GD20_FS_500
    bne 1f

    vldr.f32 s1, =0x3c8fc505    //0.01755f
    b 2f
1:
    teq r4, L3GD20_FS_2000
    bne 2f

    vldr.f32 s1, =0x3d8f5c29    //0.07f
2:

    //Load raw data from the sensor
    ldr r0, =L3GD20_OUT_X_L //Address for L3GD20
    sub r1, fp, #6          //Data ptr
    ldr r2, =0x06           //Size
    bl l3gd20_read

    sub r5, fp, #6
    ldr r4, =3

1:  ldrsh r6, [r5], #2
    vmov.s32 s0, r6
    vcvt.f32.s32 s0, s0
    vmul.f32 s0, s0, s1
    vstr.f32 s0, [r7]
    add r7, #4

    subs r4, #1
    bne 1b

    mov sp, fp

    pop { r4, r5, r6, r7, fp, pc }

.type   l3gd20_activate, %function
.global l3gd20_activate
l3gd20_activate:
    push { r4, fp, lr }

    mov fp, sp
    sub sp, #4

    ldr r0, =L3GD20_CTRL_REG1
    sub r1, fp, #4
    ldr r2, =0x01
    bl l3gd20_read

    ldrb r4, [fp, #-4]
    orr r4, L3GD20_PD_ACTIVE
    strb r4, [fp, #-4]

    ldr r0, =L3GD20_CTRL_REG1
    sub r1, fp, #4
    ldr r2, =0x01
    bl l3gd20_write

    mov sp, fp

    pop { r4, fp, pc }

.type   l3gd20_powerdown, %function
.global l3gd20_powerdown
l3gd20_powerdown:
    push { r4, fp, lr }

    mov fp, sp
    sub sp, #4

    ldr r0, =L3GD20_CTRL_REG1
    sub r1, fp, #4
    ldr r2, =0x01
    bl l3gd20_read

    ldrb r4, [fp, #-4]
    bic r4, L3GD20_PD_ACTIVE
    strb r4, [fp, #-4]

    ldr r0, =L3GD20_CTRL_REG1
    sub r1, fp, #4
    ldr r2, =0x01
    bl l3gd20_write

    mov sp, fp

    pop { r4, fp, pc }
