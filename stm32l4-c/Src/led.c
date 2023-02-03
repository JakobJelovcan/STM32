/*
 * led.c
 *
 *  Created on: 1. feb. 2023
 *      Author: Jakob
 */

#include "led.h"

void led_red_init() {
	RCC_GPIOB_CLK_ENABLE();

	GPIO_InitTypeDef init = {};
	init.Mode = GPIO_MODE_OUTPUT_PP;
	init.Pin = LED_RED_PIN;
	init.Pull = GPIO_NO_PULL;
	init.Speed = GPIO_SPEED_LOW;
	init.Alternate = 0;

	gpio_init(LED_RED_GPIO, &init);
}

void led_red_on() {
	gpio_write_pin(LED_RED_GPIO, LED_RED_PIN, GPIO_PIN_HIGH);
}

void led_red_off() {
	gpio_write_pin(LED_RED_GPIO, LED_RED_PIN, GPIO_PIN_LOW);
}

void led_green_init() {
	RCC_GPIOE_CLK_ENABLE();

	GPIO_InitTypeDef init = {};
	init.Mode = GPIO_MODE_OUTPUT_PP;
	init.Pin = LED_GREEN_PIN;
	init.Pull = GPIO_NO_PULL;
	init.Speed = GPIO_SPEED_LOW;
	init.Alternate = 0;

	gpio_init(LED_GREEN_GPIO, &init);
}

void led_green_on() {
	gpio_write_pin(LED_GREEN_GPIO, LED_GREEN_PIN, GPIO_PIN_HIGH);
}

void led_green_off() {
	gpio_write_pin(LED_GREEN_GPIO, LED_GREEN_PIN, GPIO_PIN_LOW);
}
