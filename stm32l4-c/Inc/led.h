/*
 * led.h
 *
 *  Created on: 1. feb. 2023
 *      Author: Jakob
 */

#ifndef LED_H_
#define LED_H_

#include "stm32l476g.h"
#include "gpio.h"
#include "rcc.h"

#define LED_RED_GPIO			GPIOB
#define LED_GREEN_GPIO			GPIOE

#define LED_RED_PIN				GPIO_PIN_2
#define LED_GREEN_PIN			GPIO_PIN_8

void led_red_init();
void led_red_on();
void led_red_off();

void led_green_init();
void led_green_on();
void led_green_off();

#endif /* LED_H_ */
