/*
 * joystick.c
 *
 *  Created on: 31. jan. 2023
 *      Author: Jakob
 */

#include "joystick.h"

void joystick_init() {
	RCC_GPIOA_CLK_ENABLE();

	GPIO_InitTypeDef init = {};
	init.Pin = JOYSTICK_UP_PIN | JOYSTICK_DOWN_PIN | JOYSTICK_LEFT_PIN | JOYSTICK_RIGHT_PIN | JOYSTICK_CENTER_PIN;
	init.Mode = GPIO_MODE_INPUT;
	init.Pull = GPIO_PULL_DOWN;
	init.Speed = GPIO_SPEED_LOW;
	init.Alternate = 0;

	gpio_init(JOYSTICK_GPIO, &init);
}

GPIO_PIN_STATE	joystick_get_left_state() {
	return gpio_read_pin(JOYSTICK_GPIO, JOYSTICK_LEFT_PIN);
}

GPIO_PIN_STATE	joystick_get_right_state() {
	return gpio_read_pin(JOYSTICK_GPIO, JOYSTICK_RIGHT_PIN);
}

GPIO_PIN_STATE	joystick_get_down_state() {
	return gpio_read_pin(JOYSTICK_GPIO, JOYSTICK_DOWN_PIN);
}

GPIO_PIN_STATE	joystick_get_up_state() {
	return gpio_read_pin(JOYSTICK_GPIO, JOYSTICK_UP_PIN);
}

GPIO_PIN_STATE	joystick_get_center_state() {
	return gpio_read_pin(JOYSTICK_GPIO, JOYSTICK_CENTER_PIN);
}
