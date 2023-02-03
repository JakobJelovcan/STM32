/*
 * usart.h
 *
 *  Created on: 1. feb. 2023
 *      Author: Jakob
 */

#ifndef USART_H_
#define USART_H_

#include "stm32l476g.h"
#include "gpio.h"
#include "rcc.h"

#define USART2_GPIO				GPIOD
#define	USART2_TX_PIN			GPIO_PIN_5
#define USART2_RX_PIN			GPIO_PIN_6

#define USART2_ENABLE()			USART2->CR1 |= (1 << 0)
#define USART2_DISABLE()		USART2->CR1 &= ~(1 << 0)

#define USART_RE_MASK			(1 << 2)
#define USART_RE_ENABLE			(1 << 2)
#define USART_RE_DISABLE		0

#define USART_TE_MASK			(1 << 3)
#define USART_TE_ENABLE			(1 << 3)
#define USART_TE_DISABLE		0

#define USART_TCIE_MASK			(1 << 6)
#define USART_TCIE_ENABLE		(1 << 6)
#define USART_TCIE_DISABLE		0

typedef struct
{
	uint32_t BaudRate;
} USART_InitTypeDef;

void usart2_init(USART_InitTypeDef* init);
void usart2_send_char(char chr);
char usart2_receive_char();
void usart2_send_string(char* str);
void usart2_receive_string(char* str, uint32_t len);

#endif /* USART_H_ */
