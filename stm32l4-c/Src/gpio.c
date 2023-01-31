/*
 * gpio.c
 *
 *  Created on: Jan 31, 2023
 *      Author: Jakob
 */


#include "gpio.h"

void gpio_init(GPIO_TypeDef* gpio, GPIO_InitTypeDef* init) {
	uint32_t pos;
	uint32_t temp;

	while(init->Pin >> pos) {
		if(init->Pin & (1 << pos)) {
			if((init->Mode & MODE_MASK) == MODE_OUTPUT || (init->Mode & MODE_MASK) == MODE_ALTERNATE) {
				temp = gpio->OSPEEDR;
				temp &= ~(GPIO_SPEED_MASK << (pos << 1));
				temp |= (init->Speed << (pos << 1));
				gpio->OSPEEDR = temp;

				temp = gpio->OTYPER;
				temp &= ~(GPIO_TYPE_MASK << pos);
				temp |= (((init->Mode & OUTPUT_MASK) >> OUTPUT_POSITION) << pos);
				gpio->OTYPER = temp;
			}

			if((init->Mode & MODE_MASK) != MODE_ANALOG) {
				temp = gpio->PUPDR;
				temp &= ~(GPIO_PULL_MASK << (pos << 1));
				temp |= ((init->Pull << (pos << 1)));
				gpio->PUPDR = temp;
			}

			temp = gpio->MODER;
			temp &= ~(MODE_MASK << (pos << 1));
			temp |= ((init->Mode << (pos << 1)));
			gpio->MODER = temp;
		}
		++pos;
	}
}

void gpio_write_pin(GPIO_TypeDef* gpio, uint16_t pin, GPIO_PIN_STATE state) {
	if(state) gpio->BSRR = pin;
	else gpio->BRR = pin;
}

GPIO_PIN_STATE gpio_read_pin(GPIO_TypeDef* gpio, uint16_t pin) {
	return (gpio->IDR & pin) ? GPIO_PIN_HIGH : GPIO_PIN_LOW;
}
