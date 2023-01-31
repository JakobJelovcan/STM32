/*
 * gpio.h
 *
 *  Created on: Jan 31, 2023
 *      Author: Jakob
 */

#ifndef GPIO_H_
#define GPIO_H_

#include "stm32l476g.h"

#define GPIO_PIN_0				(1 << 0)
#define GPIO_PIN_1				(1 << 1)
#define GPIO_PIN_2				(1 << 2)
#define GPIO_PIN_3				(1 << 3)
#define GPIO_PIN_4				(1 << 4)
#define GPIO_PIN_5				(1 << 5)
#define GPIO_PIN_6				(1 << 6)
#define GPIO_PIN_7				(1 << 7)
#define GPIO_PIN_8				(1 << 8)
#define GPIO_PIN_9				(1 << 9)
#define GPIO_PIN_10				(1 << 10)
#define GPIO_PIN_11				(1 << 11)
#define GPIO_PIN_12				(1 << 12)
#define GPIO_PIN_13				(1 << 13)
#define GPIO_PIN_14				(1 << 14)
#define GPIO_PIN_15				(1 << 15)

#define MODE_POSITION			0u
#define MODE_MASK				(0x3u << MODE_POSITION)
#define MODE_INPUT				(0x0u << MODE_POSITION)
#define MODE_OUTPUT				(0x1u << MODE_POSITION)
#define MODE_ALTERNATE			(0x2u << MODE_POSITION)
#define MODE_ANALOG				(0x3u << MODE_POSITION)

#define OUTPUT_POSITION	4u
#define OUTPUT_MASK				(0x1u << OUTPUT_POSITION)
#define OUTPUT_PP				(0x0u << OUTPUT_POSITION)
#define OUTPUT_OD				(0x1u << OUTPUT_POSITION)

#define GPIO_MODE_INPUT			MODE_INPUT
#define GPIO_MODE_OUTPUT_PP		(MODE_OUTPUT | OUTPUT_PP)
#define GPIO_MODE_OUTPUT_OD		(MODE_OUTPUT | OUTPUT_OD)
#define GPIO_MODE_ALTERNATE_PP	(MODE_ALTERNATE | OUTPUT_PP)
#define GPIO_MODE_ALTERNATE_OD	(MODE_ALTERNATE | OUTPUT_OD)
#define GPIO_MODE_ANALOG		MODE_ANALOG

#define GPIO_SPEED_MASK			0x3u
#define GPIO_SPEED_LOW			0x0u
#define GPIO_SPEED_MEDIUM		0x1u
#define GPIO_SPEED_HIGH			0x2u
#define GPIO_SPEED_VERY_HIGH	0x3u

#define GPIO_PULL_MASK			0x3u
#define GPIO_NO_PULL			0x0u
#define GPIO_PULL_UP			0x1u
#define GPIO_PULL_DOWN			0x2u

#define GPIO_ALTERNATE_MASK		0xFu

#define GPIO_TYPE_MASK			0x1u

typedef struct
{
	uint32_t Pin;
	uint32_t Mode;
	uint32_t Pull;
	uint32_t Speed;
	uint32_t Alternate;
} GPIO_InitTypeDef;

typedef enum {
	GPIO_PIN_LOW = 0u,
	GPIO_PIN_HIGH
} GPIO_PIN_STATE;

void gpio_init(GPIO_TypeDef* gpio, GPIO_InitTypeDef* gpio_init);

void gpio_write_pin(GPIO_TypeDef* gpio, uint16_t pin, GPIO_PIN_STATE state);
GPIO_PIN_STATE gpio_read_pin(GPIO_TypeDef* gpio, uint16_t pin);

#endif /* GPIO_H_ */
