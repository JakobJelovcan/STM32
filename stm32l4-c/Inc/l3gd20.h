/*
 * l3gd20.h
 *
 *	Created on: 5. feb. 2023
 *		Author: Jakob
 */

#ifndef L3GD20_H_
#define L3GD20_H_

#include "stm32l476g.h"
#include "gpio.h"
#include "rcc.h"
#include "spi.h"

#define L3GD20_GPIO					GPIOD
#define L3GD20_MOSI_PIN				GPIO_PIN_4
#define L3GD20_MISO_PIN				GPIO_PIN_3
#define L3GD20_SCK_PIN				GPIO_PIN_1
#define L3GD20_CS_PIN				GPIO_PIN_7
#define L3GD20_PINS					(L3GD20_SCK_PIN | L3GD20_MISO_PIN | L3GD20_MOSI_PIN | L3GD20_CS_PIN)

#define L3GD20_INT1_GPIO			GPIOD
#define L3GD20_INT1_PIN				GPIO_PIN_2

#define L3GD20_INT2_GPIO			GPIOB
#define L3GD20_INT2_PIN				GPIO_PIN_8

#define L3GD20_WHO_AM_I				0x0F
#define L3GD20_CTRL_REG1			0x20
#define L3GD20_CTRL_REG2			0x21
#define L3GD20_CTRL_REG3			0x22
#define L3GD20_CTRL_REG4			0x23
#define L3GD20_CTRL_REG5			0x24
#define L3GD20_REFERENCE			0x25
#define L3GD20_OUT_TEMP				0x26
#define L3GD20_STATUS_REG			0x27
#define L3GD20_OUT_X_L				0x28
#define L3GD20_OUT_X_H				0x29
#define L3GD20_OUT_Y_L				0x2A
#define L3GD20_OUT_Y_H				0x2B
#define L3GD20_OUT_Z_L				0x2C
#define L3GD20_OUT_Z_H				0x2D
#define L3GD20_FIFO_CTRL_REG		0x2E
#define L3GD20_FIFO_SRC_REG			0x2F
#define L3GD20_INT1_CFG				0x30
#define L3GD20_INT1_SRC				0x31
#define L3GD20_INT1_THS_XH			0x32
#define L3GD20_INT1_THS_XL			0x33
#define L3GD20_INT1_THS_YH			0x34
#define L3GD20_INT1_THS_YL			0x35
#define L3GD20_INT1_THS_ZH			0x36
#define L3GD20_INT1_THS_ZL			0x37
#define L3GD20_INT1_DURATION		0x38

#define L3GD20_MODE_MASK			(1 << 3)
#define L3GD20_MODE_POWERDOWN		0x00
#define L3GD20_MODE_ACTIVE			(1 << 3)

#define L3GD20_ODR_MASK			 	(0b11 << 4)
#define L3GD20_ODR_1				(0b00 << 4)
#define L3GD20_ODR_2				(0b01 << 4)
#define L3GD20_ODR_3				(0b10 << 4)

#define L3GD20_BW_MASK				(0b11 << 6)
#define L3GD20_BW_1					(0b00 << 6)
#define L3GD20_BW_2					(0b01 << 6)
#define L3GD20_BW_3					(0b10 << 6)
#define L3GD20_BW_4					(0b11 << 6)


#define L3GD20_X_MASK				(1 << 1)
#define L3GD20_X_ENABLE				(1 << 1)
#define L3GD20_Y_MASK				(1 << 0)
#define L3GD20_Y_ENABLE				(1 << 0)
#define L3GD20_Z_MASK				(1 << 2)
#define L3GD20_Z_ENABLE				(1 << 2)
#define L3GD20_XYZ_MASK				(0b111 << 0)
#define L3GD20_XYZ_ENABLE			(0b111 << 0)

#define L3GD20_HPM_MASK				(0b11 << 4)
#define L3GD20_HPM_1				(0b00 << 4)
#define L3GD20_HPM_2				(0b01 << 4)
#define L3GD20_HPM_3				(0b10 << 4)
#define L3GD20_HPM_4				(0b11 << 4)

#define L3GD20_HPCF_MASK			(0b111 << 0)
#define L3GD20_HPCF_1				(0b000 << 0)
#define L3GD20_HPCF_2				(0b001 << 0)
#define L3GD20_HPCF_3				(0b010 << 0)
#define L3GD20_HPCF_4				(0b011 << 0)
#define L3GD20_HPCF_5				(0b100 << 0)
#define L3GD20_HPCF_6				(0b101 << 0)
#define L3GD20_HPCF_7				(0b110 << 0)
#define L3GD20_HPCF_8				(0b111 << 0)

#define L3GD20_BDU_MASK				(1 << 7)
#define L3GD20_BDU_NOT_CONTINUOS	(1 << 7)
#define L3GD20_BDU_CONTINUOS		0x00

#define L3GD20_BLE_MASK				(1 << 7)
#define L3GD20_BLE_BIG				(1 << 7)
#define L3GD20_BLE_LITTLE			0x00

#define L3GD20_FS_MASK				(0b11 << 4)
#define L3GD20_FS_250				(0b00 << 4)
#define L3GD20_FS_500				(0b01 << 4)
#define L3GD20_FS_2000				(0b10 << 4)

#define L3GD20_SENSITIVITY_250		0.00875f
#define L3GD20_SENSITIVITY_500		0.01755f
#define L3GD20_SENSITIVITY_2000		0.07f

#define L3GD20_SIM_MASK				(1 << 0)
#define L3GD20_SIM_ENABLE			(1 << 0)
#define L3GD20_SIM_DISABLE			(0 << 0)

#define L3GD20_BOOT_MASK			(1 << 7)
#define L3GD20_BOOT_REBOOT			(1 << 7)

#define L3GD20_FIFO_ENABLE_MASK		(1 << 6)
#define L3GD20_FIFO_ENABLE			(1 << 6)

#define L3GD20_HP_ENABLE_MASK		(1 << 4)
#define L3GD20_HP_ENABLE			(1 << 4)

#define L3GD20_READ_COMMAND			(1 << 7)
#define L3GD20_MULTI_COMMAND		(1 << 6)

#define L3GD20_SPI_INIT				{ SPI_MODE_MASTER, SPI_DIRECTION_2_LINES, SPI_DS_8_BIT, SPI_POLARITY_LOW,\
									SPI_PHASE_RISING_EDGE, SPI_NSS_SOFTWARE, SPI_BRP_8, SPI_FIRSTBIT_MSB,\
									SPI_TIMODE_DISABLE, SPI_NSS_PULSE_DISABLE }

#define L3GD20_CS_LOW()				gpio_write_pin(L3GD20_GPIO, L3GD20_CS_PIN, GPIO_PIN_LOW)
#define L3GD20_CS_HIGH()			gpio_write_pin(L3GD20_GPIO, L3GD20_CS_PIN, GPIO_PIN_HIGH)

typedef struct
{
	uint8_t PD;
	uint8_t ODR;
	uint8_t Axes;
	uint8_t BW;
	uint8_t BDU;
	uint8_t BLE;
	uint8_t FS;
} L3GD20_InitTypeDef;


void l3gd20_init(L3GD20_InitTypeDef*);
void l3gd20_activate();
void l3gd20_powerdown();

uint8_t l3gd20_read_id();
void l3gd20_read_xyz(float*);
int8_t l3gd20_read_temp();


#endif /* L3GD20_H_ */
