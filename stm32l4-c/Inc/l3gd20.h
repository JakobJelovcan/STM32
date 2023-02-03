/*
 * l3gd20.h
 *
 *  Created on: 5. feb. 2023
 *      Author: Jakob
 */

#ifndef L3GD20_H_
#define L3GD20_H_

#include "stm32l476g.h"
#include "gpio.h"
#include "rcc.h"

#define L3GD20_GPIO				GPIOD
#define L3GD20_MOSI_PIN			GPIO_PIN_4
#define L3GD20_MISO_PIN			GPIO_PIN_3
#define L3GD20_SCK_PIN			GPIO_PIN_1
#define L3GD20_CS_PIN			GPIO_PIN_7
#define L3GD20_PINS				(L3GD20_SCK_PIN | L3GD20_MISO_PIN | L3GD20_MOSI_PIN | L3GD20_CS_PIN)

#define L3GD20_INT1_GPIO		GPIOD
#define L3GD20_INT1_PIN			GPIO_PIN_2

#define L3GD20_INT2_GPIO		GPIOB
#define L3GD20_INT2_PIN			GPIO_PIN_8

#define L3GD20_WHO_AM_I			0x0F
#define L3GD20_CTRL_REG1		0x20
#define L3GD20_CTRL_REG2		0x21
#define L3GD20_CTRL_REG3		0x22
#define L3GD20_CTRL_REG4		0x23
#define L3GD20_CTRL_REG5		0x24
#define L3GD20_REFERENCE		0x25
#define L3GD20_OUT_TEMP			0x26
#define L3GD20_STATUS_REG		0x27
#define L3GD20_OUT_X_L			0x28
#define L3GD20_OUT_X_H			0x29
#define L3GD20_OUT_Y_L			0x2A
#define L3GD20_OUT_Y_H			0x2B
#define L3GD20_OUT_Z_L			0x2C
#define L3GD20_OUT_Z_H			0x2D
#define L3GD20_FIFO_CTRL_REG	0x2E
#define L3GD20_FIFO_SRC_REG		0x2F
#define L3GD20_INT1_CFG			0x30
#define L3GD20_INT1_SRC			0x31
#define L3GD20_INT1_THS_XH		0x32
#define L3GD20_INT1_THS_XL		0x33
#define L3GD20_INT1_THS_YH		0x34
#define L3GD20_INT1_THS_YL		0x35
#define L3GD20_INT1_THS_ZH		0x36
#define L3GD20_INT1_THS_ZL		0x37
#define L3GD20_INT1_DURATION	0x38

#define L3GD20_READ_COMMAND		(1 << 7)
#define L3GD20_MULTI_COMMAND	(1 << 6)

#define L3GD20_SPI_INIT			{ SPI_MODE_MASTER, SPI_DIRECTION_2_LINES, SPI_DATASIZE_8_BIT, SPI_POLARITY_LOW,\
								SPI_PHASE_RISING_EDGE, SPI_NSS_SOFTWARE, SPI_BRP_4, SPI_FIRSTBIT_MSB,\
								SPI_TIMODE_DISABLE, SPI_NSS_PULSE_DISABLE }

#define L3GD20_CS_LOW()			gpio_write_pin(L3GD20_GPIO, L3GD20_CS_PIN, GPIO_PIN_LOW)
#define L3GD20_CS_HIGH()		gpio_write_pin(L3GD20_GPIO, L3GD20_CS_PIN, GPIO_PIN_HIGH)


void l3gd20_init();
uint8_t l3gd20_read(uint8_t);
void l3dg20_write(uint8_t, uint8_t);



#endif /* L3GD20_H_ */
