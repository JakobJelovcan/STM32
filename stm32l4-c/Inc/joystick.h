/*
 * joystick.h
 *
 *  Created on: 31. jan. 2023
 *      Author: Jakob
 */

#ifndef JOYSTICK_H_
#define JOYSTICK_H_

#include "stm32l476g.h"
#include "gpio.h"
#include "rcc.h"

#define JOYSTICK_GPIO			GPIOA
#define JOYSTICK_UP_PIN 		GPIO_PIN_3
#define JOYSTICK_DOWN_PIN		GPIO_PIN_5
#define JOYSTICK_RIGHT_PIN		GPIO_PIN_2
#define JOYSTICK_LEFT_PIN		GPIO_PIN_1
#define JOYSTICK_CENTER_PIN		GPIO_PIN_0

void joystick_init();

GPIO_PIN_STATE	joystick_get_left_state();
GPIO_PIN_STATE	joystick_get_right_state();
GPIO_PIN_STATE	joystick_get_down_state();
GPIO_PIN_STATE	joystick_get_up_state();
GPIO_PIN_STATE	joystick_get_center_state();


#endif /* JOYSTICK_H_ */
