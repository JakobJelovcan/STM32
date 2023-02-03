/*
 * l3gd20.c
 *
 *  Created on: 5. feb. 2023
 *      Author: Jakob
 */

#include "l3gd20.h"

void l3gd20_init() {
	RCC_GPIOD_CLK_ENABLE();

	GPIO_InitTypeDef init = { L3GD20_CS_PIN, GPIO_MODE_OUTPUT_PP, GPIO_NO_PULL, GPIO_SPEED_VERY_HIGH, 0 };
	gpio_init(L3GD20_GPIO, &init);

	L3GD20_CS_HIGH();
}

uint8_t l3gd20_read(uint8_t addr) {
	addr |= L3GD20_READ_COMMAND;
	return spi2_write_read(addr);
}

void l3gd20_write(uint8_t* addr, uint8_t data) {

}
