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
    push { r4, r5, r6, fp, lr }
    vpush { s4 }

    mov fp, sp
    sub sp, #8
    mov r6, r0

    ldr r0, =LSM303C_CTRL_REG4_A
    bl lsm303c_read_a
    and r0, LSM303C_FS_MASK_A

    cmp r0, LSM303C_FS_2G_A
    bne 1f
    b 2f
1:
    cmp r0, LSM303C_FS_4G_A
    bne 1f
    vldr.f32 s5, =0x38ffda40
    b 2f
1:
    cmp r0, LSM303C_FS_8G_A
    bne 2f
    vldr.f32 s5, =0x397fda40
2:
    //Read data from the sensor
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
    ldr r5, =0x03
    //Multiply the data with the sensitivity factor
1:  ldrsh r0, [r4], #2
    vmov.s32 s4, r0
    vcvt.f32.s32 s4, s4
    vstr.f32 s4, [r6]
    add r6, #4

    subs r5, #1
    bne 1b

    mov sp, fp

    vpop { s4 }
    pop { r4, r5, r6, fp, pc }

.type   lsm303c_read_xyz_m, %function
.global lsm303c_read_xyz_m
lsm303c_read_xyz_m:
    push { r4, r5, r6, fp, lr }
    vpush { s4, s5 }

    mov fp, sp
    sub sp, #8
    mov r6, r0

    vldr.f32 s5, =0x3a180b24

    //Read data from the sensor
    ldr r0, =LSM303C_OUT_X_L_M
    bl lsm303c_read_m
    strb r0, [fp, #-8]

    ldr r0, =LSM303C_OUT_X_H_M
    bl lsm303c_read_m
    strb r0, [fp, #-7]

    ldr r0, =LSM303C_OUT_Y_L_M
    bl lsm303c_read_m
    strb r0, [fp, #-6]

    ldr r0, =LSM303C_OUT_Y_H_M
    bl lsm303c_read_m
    strb r0, [fp, #-5]

    ldr r0, =LSM303C_OUT_Z_L_M
    bl lsm303c_read_m
    strb r0, [fp, #-4]

    ldr r0, =LSM303C_OUT_Z_H_M
    bl lsm303c_read_m
    strb r0, [fp, #-3]

    sub r4, fp, #8
    ldr r5, =0x03

    //Multiply the data with the sensitivity factor
1:  ldrsh r0, [r4], #2
    vmov.s32 s4, r0
    vcvt.f32.s32 s4, s4
    vmul.f32 s4, s4, s5
    vstr.f32 s4, [r6]
    add r6, #4

    subs r5, #1
    bne 1b

    mov sp, fp

    vpop { s4, s5 }
    pop { r4, r5, r6, fp, pc }

.type   calibrate_m, %function
.global calibrate_m
calibrate_m:
    push { fp, lr }

    mov fp, sp
    sub sp, #12

    mov r0, sp
    bl lsm303c_read_xyz_m
    mov r0, sp
    ldr r1, =magneto_min_max

    bl record_min_max
    mov sp, fp

    pop { fp, pc }

/**
 * @summary The function calculates the angle of the magnetometer
 * @param magnetometer data
 * @param magnetometer min max data 
 * @param acceleromater data
 * @return angle in degrees
 */
.type   calculate_angle, %function
.global calculate_angle
calculate_angle:
    push { r4, r5, r6, fp, lr }
    vpush { s4 - s15 }

    mov fp, sp
    mov r4, r0  //Magnetometer data
    mov r5, r1  //Magnetometer min max data
    mov r6, r2  //Accelerometer data

    sub sp, #20 //Make room on the stack for variables
    /*
    Stack
    ------------
    Accel_norm_x (4B float)
    Accel_norm_y (4B float)
    Mag_norm_x   (4B float)
    Mag_norm_y   (4B float)
    Mag_norm_z   (4B float)
    ------------
     */

    //Normalize accelerometer data
    //Calculate the length of the acceleration vector
    vldr.f32 s4, [r6]
    vldr.f32 s5, [r6, #4]
    vldr.f32 s6, [r6, #8]
    vmul.f32 s7, s4, s4
    vmul.f32 s8, s5, s5
    vmul.f32 s9, s6, s6

    vadd.f32 s7, s7, s8
    vadd.f32 s7, s7, s9

    vsqrt.f32 s7, s7        

    //Divide x and y with the length of the acceleration vector
    vdiv.f32 s4, s4, s7 //x
    vdiv.f32 s5, s5, s7 //y
    vstr.f32 s4, [sp, #12]
    vstr.f32 s5, [sp, #16]

    //Normalize the magnetometer data using the min max data
    vldr.f32 s7, =0x40000000
    vldr.f32 s8, =0x3f800000

    //X
    vldr.f32 s4, [r4]       //Current x
    vldr.f32 s5, [r5]       //Min x
    vldr.f32 s6, [r5, #12]  //Max x

    vsub.f32 s4, s4, s5 //(mag_x - min_x)
    vsub.f32 s6, s6, s5 //(max_x - min_x)

    vdiv.f32 s4, s4, s6
    vmul.f32 s4, s4, s7
    vsub.f32 s4, s4, s8
    vstr.f32 s4, [sp]

    //Y
    vldr.f32 s4, [r4, #4]   //Current y
    vldr.f32 s5, [r5, #4]   //Min y
    vldr.f32 s6, [r5, #16]  //Max y

    vsub.f32 s4, s4, s5 //(mag_y - min_y)
    vsub.f32 s6, s6, s5 //(max_y - min_y)

    vdiv.f32 s4, s4, s6
    vmul.f32 s4, s4, s7
    vsub.f32 s4, s4, s8
    vstr.f32 s4, [sp, #4]

    //Z
    vldr.f32 s4, [r4, #8]   //Current z
    vldr.f32 s5, [r5, #8]   //Min z
    vldr.f32 s6, [r5, #20]  //Max z

    vsub.f32 s4, s4, s5 //(mag_z - min_z)
    vsub.f32 s6, s6, s5 //(max_z - min_z)

    vdiv.f32 s4, s4, s6
    vmul.f32 s4, s4, s7
    vsub.f32 s4, s4, s8
    vstr.f32 s4, [sp, #8]

    //Calculate pitch
    vldr.f32 s4, [sp, #12]
    vneg.f32 s4, s4
    bl asinf

    vmov.f32 s4, s0
    bl sinf
    vmov.f32 s9, s0 //sin(pitch)
    vmov.f32 s0, s4
    bl cosf
    vmov.f32 s10, s0 //cos(pitch)

    //Calculate roll
    vldr.f32 s4, [sp, #16]
    vdiv.f32 s0, s4, s10
    bl asinf

    vmov.f32 s4, s0
    bl sinf
    vmov.f32 s11, s0 //sin(roll)
    vmov.f32 s0, s4
    bl cosf
    vmov.f32 s12, s0 //cos(roll)

    //Calculate position
    //X
    vldr.f32 s4, [sp]       //Mag_x
    vldr.f32 s5, [sp, #8]   //Mag_z
    vmul.f32 s4, s4, s10
    vmul.f32 s5, s5, s9
    vadd.f32 s1, s4, s5     //Pos_x

    //Y
    vldr.f32 s4, [sp]       //Mag_x
    vldr.f32 s5, [sp, #4]   //Mag_y
    vldr.f32 s6, [sp, #8]   //Mag_z
    vmul.f32 s4, s4, s11
    vmul.f32 s5, s5, s12
    vmul.f32 s4, s4, s9
    vmul.f32 s6, s6, s11
    vadd.f32 s0, s4, s5
    vmul.f32 s6, s6, s10
    vsub.f32 s0, s0, s6     //Pos_y

    //Calculate heading
    bl atan2f
    vldr.f32 s5, =0x42652ee1    //180/PI
    vmul.f32 s4, s0, s5

    vldr.f32 s5, =0x43b40000    //360

    vcmp.f32 s4, #0.0
    vmrs apsr_nzcv, fpscr
    it lt
    vaddlt.f32 s4, s4, s5

    vldr.f32 s6, =0x438c0000
    vsub.f32 s4, s5, s4
    vsub.f32 s4, s4, s6

    vcmp.f32 s4, #0.0
    vmrs apsr_nzcv, fpscr
    it lt
    vaddlt.f32 s4, s4, s5

    vcvtr.s32.f32 s0, s4
    vmov.s32 r0, s0

    mov sp, fp  //Clear the variables from the stack

    vpop { s4 - s15 }
    pop { r4, r5, r6, fp, pc }
