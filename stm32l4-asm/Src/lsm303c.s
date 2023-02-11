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
.equ LSM303C_GPIO_A,        		0x48001000
.equ LSM303C_CS_PIN_A,      		(1 << 0)
.equ LSM303C_GPIO_M,        		0x48000800
.equ LSM303C_CS_PIN_M,      		(1 << 0)

.equ GPIO_MODE_OUTPUT_PP,   		0x01
.equ GPIO_NO_PULL,          		0x00
.equ GPIO_AF_5,             		0x05
.equ GPIO_SPEED_VERY_HIGH,  		0x03

.equ GPIOx_MODER,                   0x00
.equ GPIOx_OTYPER,          		0x04
.equ GPIOx_OSPEEDR,         		0x08
.equ GPIOx_PUPDR,           		0x0C
.equ GPIOx_IDR,             		0x10
.equ GPIOx_ODR,             		0x14
.equ GPIOx_BSRR,            		0x18
.equ GPIOx_LCKR,            		0x1C
.equ GPIOx_AFRL,            		0x20
.equ GPIOx_AFRH,            		0x24
.equ GPIOx_BRR,             		0x28

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

.equ LSM303C_HR_MASK_A,             (1 << 7)
.equ LSM303C_HR_ENABLE_A,           (1 << 7)
.equ LSM303C_HR_DISABLE_A,          0x00

.equ LSM303C_ODR_MASK_A,            (0b111 << 4)
.equ LSM303C_ODR_PD_A,              (0b000 << 4)
.equ LSM303C_ODR_10_A,              (0b001 << 4)
.equ LSM303C_ODR_50_A,              (0b010 << 4)
.equ LSM303C_ODR_100_A,             (0b011 << 4)
.equ LSM303C_ODR_200_A,             (0b100 << 4)
.equ LSM303C_ODR_400_A,             (0b101 << 4)
.equ LSM303C_ODR_800_A,             (0b110 << 4)
.equ LSM303C_ODR_NA_A,              (0b111 << 4)

.equ LSM303C_BDU_MASK_A,            (1 << 3)
.equ LSM303C_BDU_ON_READ_A,         (1 << 3)
.equ LSM303C_BDU_CONTINUOUS_A,      0x00

.equ LSM303C_XYZ_MASK_A,            (0b111 << 0)
.equ LSM303C_XYZ_ENABLE_A,          (0b111 << 0)
.equ LSM303C_XYZ_DISABLE_A,         0x00

.equ LSM303C_DFC_MASK_A,            (0b11 << 5)
.equ LSM303C_DFC_1_A,               (0b00 << 5)
.equ LSM303C_DFC_2_A,               (0b01 << 5)
.equ LSM303C_DFC_3_A,               (0b10 << 5)
.equ LSM303C_DFC_4_A,               (0b11 << 5)

.equ LSM303C_HPM_MASK_A,            (0b11 << 3)
.equ LSM303C_HPM_1_A,               (0b00 << 3)
.equ LSM303C_HPM_2_A,               (0b01 << 3)
.equ LSM303C_HPM_3_A,               (0b10 << 3)
.equ LSM303C_HPM_4_A,               (0b11 << 3)

.equ LSM303C_FDS_MASK_A,            (1 << 2)
.equ LSM303C_FDS_ENABLE_A,          (1 << 2)
.equ LSM303C_FDS_DISABLE_A,         0x00

.equ LSM303C_HPIS_MASK_A,           (0b11 << 0)
.equ LSM303C_HPIS_1_A,              (0b00 << 0)
.equ LSM303C_HPIS_2_A,              (0b01 << 0)
.equ LSM303C_HPIS_3_A,              (0b10 << 0)
.equ LSM303C_HPIS_4_A,              (0b11 << 0)

.equ LSM303C_BW_MASK_A,             (0b11 << 6)
.equ LSM303C_BW_400_A,              (0b00 << 6)
.equ LSM303C_BW_200_A,              (0b01 << 6)
.equ LSM303C_BW_100_A,              (0b10 << 6)
.equ LSM303C_BW_50_A,               (0b11 << 6)

.equ LSM303C_FS_MASK_A,             (0b11 << 4)
.equ LSM303C_FS_2G_A,               (0b00 << 4)
.equ LSM303C_FS_4G_A,               (0b10 << 4)
.equ LSM303C_FS_8G_A,               (0b11 << 4)

.equ LSM303C_SENSITIVITY_2G_A,      1
.equ LSM303C_SENSITIVITY_4G_A,      2
.equ LSM303C_SENSITIVITY_8G_A,      4

.equ LSM303C_BW_SCALE_ODR_MASK_A,   (1 << 3)
.equ LSM303C_BW_SCALE_ODR_MANUAL_A, (1 << 3)
.equ LSM303C_BW_SCALE_ODR_AUTO_A,   0x00

.equ LSM303C_IF_ADD_INC_MASK_A,     (1 << 2)
.equ LSM303C_IF_ADD_INC_ENABLE_A,   (1 << 2)
.equ LSM303C_IF_ADD_INC_DISABLE_A,  0x00

.equ LSM303C_IC2_MASK_A,            (1 << 1)
.equ LSM303C_IC2_ENABLE_A,          (1 << 1)
.equ LSM303C_IC2_DISABLE_A,         0x00

.equ LSM303C_SIM_MASK_A,            (1 << 0)
.equ LSM303C_SIM_SPI_RW_A,          (1 << 0)
.equ LSM303C_SIM_SPI_W_A,           0x00

.equ LSM303C_XYZOR_MASK_A,          (1 << 7)
.equ LSM303C_ZOR_MASK_A,            (1 << 6)
.equ LSM303C_YOR_MASK_A,            (1 << 5)
.equ LSM303C_XOR_MASK_A,            (1 << 4)
.equ LSM303C_XYZDA_MASK_A,          (1 << 3)
.equ LSM303C_ZDA_MASK_A,            (1 << 2)
.equ LSM303C_YDA_MASK_A,            (1 << 1)
.equ LSM303C_XDA_MASK_A,            (1 << 0)

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

.equ LSM303C_TEMP_EN_MASK_M,        (1 << 7)
.equ LSM303C_TEMP_ENABLE_M,         (1 << 7)
.equ LSM303C_TEMP_DISABLE_M,        0x00

.equ LSM303C_OM_MASK_M,             (0b11 << 5)
.equ LSM303C_OM_LP_M,               (0b00 << 5)
.equ LSM303C_OM_MP_M,               (0b01 << 5)
.equ LSM303C_OM_HP_M,               (0b10 << 5)
.equ LSM303C_OM_UHP_M,              (0b11 << 5)

.equ LSM303C_ODR_MASK_M,            (0b111 << 2)
.equ LSM303C_ODR_0_625_M,           (0b000 << 2)
.equ LSM303C_ODR_1_25_M,            (0b001 << 2)
.equ LSM303C_ODR_2_5_M,             (0b010 << 2)
.equ LSM303C_ODR_5_M,               (0b011 << 2)
.equ LSM303C_ODR_10_M,              (0b100 << 2)
.equ LSM303C_ODR_20_M,              (0b101 << 2)
.equ LSM303C_ODR_40_M,              (0b110 << 2)
.equ LSM303C_ODR_80_M,              (0b111 << 2)

.equ LSM303C_FS_MASK_M,             (0b11 << 5)
.equ LSM303C_FS_16G_M,              (0b11 << 5)

.equ LSM303C_IC2_MASK_M,            (1 << 7)
.equ LSM303C_IC2_DISABLE_M,         (1 << 7)
.equ LSM303C_IC2_ENABLE_M,          0x00

.equ LSM303C_LP_MASK_M,             (1 << 5)
.equ LSM303C_LP_ENABLE_M,           (1 << 5)
.equ LSM303C_LP_DISABLE_M,          0x00

.equ LSM303C_SIM_MASK_M,            (1 << 2)
.equ LSM303C_SIM_SPI_RW_M,          (1 << 2)
.equ LSM303C_SIM_SPI_W_M,           0x00

.equ LSM303C_MD_MASK_M,             (0b11 << 0)
.equ LSM303C_MD_CONTINUOUS_M,       (0b00 << 0)
.equ LSM303C_MD_SINGLE_M,           (0b01 << 0)
.equ LSM303C_MD_POWERDOWN_M,        (0b10 << 0)

.equ LSM303C_OMZ_MASK_M,            (0b11 << 2)
.equ LSM303C_OMZ_LP_M,              (0b00 << 2)
.equ LSM303C_OMZ_MP_M,              (0b01 << 2)
.equ LSM303C_OMZ_HP_M,              (0b10 << 2)
.equ LSM303C_OMZ_UHP_M,             (0b11 << 2)

.equ LSM303C_BLE_MASK_M,            (1 << 1)
.equ LSM303C_BLE_BIG_M,             (1 << 1)
.equ LSM303C_BLE_LITTLE_M,          0x00

.equ LSM303C_BDU_MASK_M,            (1 << 6)
.equ LSM303C_BDU_ON_READ_M,         (1 << 6)
.equ LSM303C_BDU_CONTINUOUS_M,       0x00

.equ LSM303C_REBOOT_MASK_M,         (1 << 3)
.equ LSM303C_REBOOT_MEMORY_M,       (1 << 3)
.equ LSM303C_REBOOT_NORMAL_M,       0x00

.equ LSM303C_SOFT_RESET_MASK_M,     (1 << 2)
.equ LSM303C_SOFT_RESET_ENABLE_M,   (1 << 2)
.equ LSM303C_SOFT_RESET_DEFAULT_M,  0x00

//Commands
.equ LSM303C_READ_COMMAND,          (1 << 7)
.equ LSM303C_MULTI_COMMAND,         (1 << 6)

.text

.type   lsm303c_write_a, %function
.local  lsm303c_write_a
lsm303c_write_a:
    push { r4, r5, lr }

    mov r4, r0
    mov r5, r1

    bl lsm303c_cs_low_a
    bl spi2_direction_1_line_tx

    mov r0, r4
    bl spi2_transmit

    mov r0, r5
    bl spi2_transmit

    bl lsm303c_cs_high_a

    pop { r4, r5, pc }

.type   lsm303c_read_a, %function
.local  lsm303c_read_a
lsm303c_read_a:
    push { r4, lr }

    mov r4, r0
    orr r4, LSM303C_READ_COMMAND

    bl lsm303c_cs_low_a
    bl spi2_direction_1_line_tx

    mov r0, r4
    bl spi2_transmit

    bl spi2_direction_1_line_rx

    bl spi2_receive

    bl lsm303c_cs_high_a

    pop { r4, pc }

.type   lsm303c_write_m, %function
.global lsm303c_write_m
lsm303c_write_m:
    push { r4, r5, r6, lr }

    mov r4, r0
    mov r5, r1

    bl lsm303c_cs_low_m
    bl spi2_direction_1_line_tx

    mov r0, r4
    bl spi2_transmit

    mov r0, r5
    bl spi2_transmit

    bl lsm303c_cs_high_m

    pop { r4, r5, r6, pc }

.type   lsm303c_read_m, %function
.global lsm303c_read_m
lsm303c_read_m:
    push { r4, r5, r6, lr }

    mov r4, r0
    orr r4, LSM303C_READ_COMMAND

    bl lsm303c_cs_low_m
    bl spi2_direction_1_line_tx

    mov r0, r4
    bl spi2_transmit

    bl spi2_direction_1_line_rx

    bl spi2_receive

    bl lsm303c_cs_high_m

    pop { r4, r5, r6, pc }


.type   lsm303c_cs_low_a, %function
.local  lsm303c_cs_low_a
lsm303c_cs_low_a:
    push { r4, r5, lr }

    ldr r4, =LSM303C_GPIO_A
    ldr r5, [r4, #GPIOx_BRR]
    orr r5, LSM303C_CS_PIN_A
    str r5, [r4, #GPIOx_BRR]

    pop { r4, r5, pc }

.type   lsm303c_cs_high_a, %function
.local  lsm303c_cs_high_a
lsm303c_cs_high_a:
    push { r4, r5, lr }

    ldr r4, =LSM303C_GPIO_A
    ldr r5, [r4, #GPIOx_BSRR]
    orr r5, LSM303C_CS_PIN_A
    str r5, [r4, #GPIOx_BSRR]

    pop { r4, r5, pc }

.type   lsm303c_cs_low_m, %function
.local  lsm303c_cs_low_m
lsm303c_cs_low_m:
    push { r4, r5, lr }

    ldr r4, =LSM303C_GPIO_M
    ldr r5, [r4, #GPIOx_BRR]
    orr r5, LSM303C_CS_PIN_M
    str r5, [r4, #GPIOx_BRR]

    pop { r4, r5, pc }

.type   lsm303c_cs_high_m, %function
.local  lsm303c_cs_high_m
lsm303c_cs_high_m:
    push { r4, r5, lr }

    ldr r4, =LSM303C_GPIO_M
    ldr r5, [r4, #GPIOx_BSRR]
    orr r5, LSM303C_CS_PIN_M
    str r5, [r4, #GPIOx_BSRR]

    pop { r4, r5, pc }

.type   lsm303c_init_accelerometer, %function
.global lsm303c_init_accelerometer
lsm303c_init_accelerometer:
    push { r4, r5, fp, lr }

    mov fp, sp
    sub sp, #8

    bl rcc_gpioe_clk_enable

    //Init LSM303C_A GPIO
    ldr r0, =LSM303C_GPIO_A
    ldr r1, =LSM303C_CS_PIN_A
    ldr r2, =GPIO_MODE_OUTPUT_PP
    ldr r3, =GPIO_NO_PULL
    ldr r4, =0x00
    str r4, [fp, #-4]
    ldr r4, =GPIO_SPEED_VERY_HIGH
    str r4, [fp, #-8]
    bl gpio_init

    //CTRL_REG1
    ldr r0, =LSM303C_CTRL_REG1_A
    ldr r1, =(LSM303C_HR_DISABLE_A | LSM303C_ODR_50_A | LSM303C_XYZ_ENABLE_A | LSM303C_BDU_CONTINUOUS_A)
    bl lsm303c_write_a

    //CTRL_REG4
    ldr r0, =LSM303C_CTRL_REG4_A
    ldr r1, =(LSM303C_FS_2G_A | LSM303C_IC2_DISABLE_A | LSM303C_SIM_SPI_RW_A)
    bl lsm303c_write_a

    mov sp, fp

    pop { r4, r5, fp, pc }


.type   lsm303c_init_magnetometer, %function
.global lsm303c_init_magnetometer
lsm303c_init_magnetometer:
    push { r4, r5, fp, lr }

    mov fp, sp
    sub sp, #8

    bl rcc_gpioc_clk_enable

    ldr r0, =LSM303C_GPIO_M
    ldr r1, =LSM303C_CS_PIN_M
    ldr r2, =GPIO_MODE_OUTPUT_PP
    ldr r3, =GPIO_NO_PULL
    ldr r4, =0x00
    str r4, [fp, #-4]
    ldr r4, =GPIO_SPEED_VERY_HIGH
    str r4, [fp, #-8]
    bl gpio_init

    //CTRL_REG1
    ldr r0, =LSM303C_CTRL_REG1_M
    ldr r1, =(LSM303C_TEMP_ENABLE_M | LSM303C_OM_UHP_M | LSM303C_ODR_40_M)
    bl lsm303c_write_m

    //CTRL_REG2
    ldr r0, =LSM303C_CTRL_REG2_M
    ldr r1, =(LSM303C_FS_16G_M | LSM303C_REBOOT_NORMAL_M | LSM303C_SOFT_RESET_DEFAULT_M)
    bl lsm303c_write_m

    //CTRL_REG3
    ldr r0, =LSM303C_CTRL_REG3_M
    ldr r1, =(LSM303C_IC2_DISABLE_M | LSM303C_SIM_SPI_RW_M | LSM303C_LP_DISABLE_M | LSM303C_MD_CONTINUOUS_M)
    bl lsm303c_write_m

    //CTRL_REG4
    ldr r0, =LSM303C_CTRL_REG4_M
    ldr r1, =(LSM303C_OMZ_UHP_M | LSM303C_BLE_LITTLE_M)
    bl lsm303c_write_m

    //CTRL_REG5
    ldr r0, =LSM303C_CTRL_REG5_M
    ldr r1, =LSM303C_BDU_CONTINUOUS_M;
    bl lsm303c_write_m

    mov sp, fp

    pop { r4, r5, fp, pc }

.type   lsm303c_read_id_a, %function
.global lsm303c_read_id_a
lsm303c_read_id_a:
    push { r4, r5, lr }

    ldr r0, =LSM303C_WHO_AM_I_A
    bl lsm303c_read_a

    pop { r4, r5, pc }


.type   lsm303c_read_id_m, %function
.global lsm303c_read_id_m
lsm303c_read_id_m:
    push { r4, r5, lr }

    ldr r0, =LSM303C_WHO_AM_I_M
    bl lsm303c_read_m

    pop { r4, r5, pc }

.type   lsm303c_read_temp_m, %function
.global lsm303c_read_temp_m
lsm303c_read_temp_m:
    push { fp, lr }

    mov fp, sp
    sub sp, #4

    ldr r0, =LSM303C_TEMP_L_M
    bl lsm303c_read_m
    strb r0, [sp, #-4]

    ldr r0, =LSM303C_TEMP_H_M
    bl lsm303c_read_m
    strb r0, [sp, #-3]

    ldrsh r0, [fp, #-4]

    mov sp, fp

    pop { fp, pc }

.type   lsm303c_read_xyz_a, %function
.global lsm303c_read_xyz_a
lsm303c_read_xyz_a:
    push { r4, r5, r6, r7, fp, lr }

    mov sp, fp
    sub sp, #8
    mov r7, r0

    ldr r0, =LSM303C_CTRL_REG4_A
    bl lsm303c_read_a
    and r0, LSM303C_FS_MASK_A

    cmp r0, LSM303C_FS_2G_A
    bne 1f
    ldr r5, =LSM303C_SENSITIVITY_2G_A
    b 2f
1:
    cmp r0, LSM303C_FS_4G_A
    bne 1f
    ldr r5, =LSM303C_SENSITIVITY_4G_A
    b 2f
1:
    cmp r0, LSM303C_FS_8G_A
    bne 2f
    ldr r5, =LSM303C_SENSITIVITY_8G_A
2:

    ldr r0, =LSM303C_OUT_X_L_A
    bl lsm303c_read_a
    strb r0, [fp, #-8]

    ldr r0, =LSM303C_OUT_X_H_A
    bl lsm303c_read_a
    strb r0, [fp, #-7]

    ldr r0, =LSM303C_OUT_Y_L_A
    bl lsm303c_read_a
    strb r0, [fp, #-6]

    ldr r0, =LSM303C_OUT_Y_H_A
    bl lsm303c_read_a
    strb r0, [fp, #-5]

    ldr r0, =LSM303C_OUT_Z_L_A
    bl lsm303c_read_a
    strb r0, [fp, #-4]

    ldr r0, =LSM303C_OUT_Z_H_A
    bl lsm303c_read_a
    strb r0, [fp, #-3]

    sub r4, fp, #8
    ldr r6, =0x03
1:  ldrsh r0, [r4], #1
    mul r0, r0, r5
    str r0, [r4], #4

    mov sp, fp

    pop { r4, r5, r6, r7, fp, pc }

.type   lsm303c_read_xyz_m, %function
.global lsm303c_read_xyz_m
lsm303c_read_xyz_m:
    push { r4, lr }

    mov r4, r0

    ldr r0, =LSM303C_OUT_X_L_M
    bl lsm303c_read_m
    strb r0, [r4], #1

    ldr r0, =LSM303C_OUT_X_H_M
    bl lsm303c_read_m
    strb r0, [r4], #1

    ldr r0, =LSM303C_OUT_Y_L_M
    bl lsm303c_read_m
    strb r0, [r4], #1

    ldr r0, =LSM303C_OUT_Y_H_M
    bl lsm303c_read_m
    strb r0, [r4], #1

    ldr r0, =LSM303C_OUT_Z_L_M
    bl lsm303c_read_m
    strb r0, [r4], #1

    ldr r0, =LSM303C_OUT_Z_H_M
    bl lsm303c_read_m
    strb r0, [r4], #1

    pop { r4, pc }
