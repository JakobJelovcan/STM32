/*
 * usart.c
 *
 *  Created on: 1. feb. 2023
 *      Author: Jakob
 */

#include "usart.h"

void usart2_init(USART_InitTypeDef* init) {
	RCC_GPIOD_CLK_ENABLE();
	RCC_USART2_CLK_ENABLE();

	GPIO_InitTypeDef ioinit = {};
	ioinit.Pin = (USART2_TX_PIN | USART2_RX_PIN);
	ioinit.Mode = GPIO_MODE_ALTERNATE_PP;
	ioinit.Pull = GPIO_NO_PULL;
	ioinit.Speed = GPIO_SPEED_LOW;
	ioinit.Alternate = 0x07;

	gpio_init(USART2_GPIO, &ioinit);

	USART2->BRR = init->BaudRate;
	uint32_t temp = USART2->CR1;
	temp &= ~(USART_TE_MASK | USART_RE_MASK);
	temp |= (USART_TE_ENABLE | USART_RE_ENABLE);
	USART2->CR1 = temp;
}

void usart2_send_char(char chr) {
	while(!(USART2->ISR & (1 << 7)));
	USART2->TDR = chr;
}

char usart2_receive_char() {
	while(!(USART2->ISR & (1 << 5)));
	return (char)USART2->RDR;
}

void usart2_send_string(char* str) {
	do {
		usart2_send_char(*str);
	} while(*str++);
}

void usart2_receive_string(char* str, uint32_t len) {
	while(len--) {
		*str = usart2_receive_char();
		if(!(*str++)) break;
	}
}
