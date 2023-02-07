/*
 * l3gd20.c
 *
 *  Created on: 5. feb. 2023
 *      Author: Jakob
 */

#include "l3gd20.h"

void l3gd20_read(uint8_t, uint8_t*, uint16_t);
void l3gd20_write(uint8_t, uint8_t*, uint16_t);

void l3gd20_init(L3GD20_InitTypeDef* init) {
	RCC_GPIOD_CLK_ENABLE();

	GPIO_InitTypeDef gp_init = { L3GD20_CS_PIN, GPIO_MODE_OUTPUT_PP, GPIO_NO_PULL, GPIO_SPEED_VERY_HIGH, 0 };
	gpio_init(L3GD20_GPIO, &gp_init);

	uint8_t control = 0;

	control = (init->PD | init->ODR | init->Axes | init->BW);
	l3gd20_write(L3GD20_CTRL_REG1, &control, 1);

	control = (init->BDU | init->BLE | init->FS);
	l3gd20_write(L3GD20_CTRL_REG4, &control, 1);

	L3GD20_CS_HIGH();
}

void l3gd20_read(uint8_t address, uint8_t* buffer, uint16_t size) {
	if(size > 1) address |= L3GD20_MULTI_COMMAND;
	address |= L3GD20_READ_COMMAND;

	L3GD20_CS_LOW();

	spi2_transmit_receive(address);

	while(size) {
		*buffer = spi2_transmit_receive(0x00);
		++buffer;
		--size;
	}

	L3GD20_CS_HIGH();
}

void l3gd20_write(uint8_t address, uint8_t* data, uint16_t size) {
	if(size > 1) address |= L3GD20_MULTI_COMMAND;

	L3GD20_CS_LOW();

	spi2_transmit_receive(address);

	while(size) {
		spi2_transmit_receive(*data);
		++data;
		--size;
	}

	L3GD20_CS_HIGH();
}

void l3gd20_activate() {
	uint8_t control;
	l3gd20_read(L3GD20_CTRL_REG1, &control, 1);
	control |= L3GD20_MODE_ACTIVE;
	l3gd20_write(L3GD20_CTRL_REG1, &control, 1);
}

void l3gd20_powerdown() {
	uint8_t control;
	l3gd20_read(L3GD20_CTRL_REG1, &control, 1);
	control = control & ~L3GD20_MODE_MASK;
	l3gd20_write(L3GD20_CTRL_REG1, &control, 1);
}

uint8_t l3gd20_read_id() {
	uint8_t id;
	l3gd20_read(L3GD20_WHO_AM_I, &id, 1);
	return id;
}

void l3gd20_read_xyz(float* xyz) {
	uint8_t ctrl_reg4;
	uint8_t raw_data[6];

	l3gd20_read(L3GD20_CTRL_REG4, &ctrl_reg4, 1);
	l3gd20_read(L3GD20_OUT_X_L, raw_data, 6);

	float sensitivity;
	switch(ctrl_reg4 & L3GD20_FS_MASK) {
		case L3GD20_FS_250: {
			sensitivity = L3GD20_SENSITIVITY_250;
			break;
		}
		case L3GD20_FS_500: {
			sensitivity = L3GD20_SENSITIVITY_500;
			break;
		}
		case L3GD20_FS_2000: {
			sensitivity = L3GD20_SENSITIVITY_2000;
			break;
		}
	}
	for(int i = 0; i < 3; ++i) {
		xyz[i] = ((int16_t*)raw_data)[i] / sensitivity;
	}
}

int8_t l3gd20_read_temp() {
	uint8_t temp;
	l3gd20_read(L3GD20_OUT_TEMP, &temp, 1);
	return (int8_t)temp;
}
