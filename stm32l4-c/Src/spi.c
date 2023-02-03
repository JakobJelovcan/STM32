/*
 * spi.c
 *
 *  Created on: 4. feb. 2023
 *      Author: Jakob
 */

#include "spi.h"

void spi2_init(SPI_InitTypeDef* init) {
	//GPIO initialization
	RCC_GPIOD_CLK_ENABLE();

	GPIO_InitTypeDef gp_init = {};
	gp_init.Pin = SPI2_GPIO_PINS;
	gp_init.Mode = GPIO_MODE_ALTERNATE_PP;
	gp_init.Pull = GPIO_NO_PULL;
	gp_init.Speed = GPIO_SPEED_VERY_HIGH;
	gp_init.Alternate = 5;
	gpio_init(SPI2_GPIO, &gp_init);
	RCC_SPI2_CLK_ENABLE();

	//SPI initialization
	SPI2_DISABLE();

	uint32_t temp;
	/*SPI_CR1*/
	temp = 0;
	if(init->TIMode == SPI_TIMODE_ENABLE) {	//IF TI mode is enabled set the clock polarity and phase to values requested by the standard
		init->ClockPhase = SPI_PHASE_RISING_EDGE;
		init->ClockPolarity = SPI_POLARITY_LOW;
	}
	else if(init->Mode != SPI_MODE_MASTER) {	//If mode is not master set the baud rate to /2
		init->BRP = SPI_BRP_2;
	}

	temp |= (init->Mode & (SPI_MSTR_MASK | SPI_SSI_MASK)) |
			(init->Direction & (SPI_RXONLY_MASK | SPI_BIDIMODE_MASK)) |
			(init->FirstBit & SPI_LSBFIRST_MASK) |
			(init->NSS & SPI_SSM_MASK) |
			(init->BRP & SPI_BR_MASK) |
			(init->ClockPolarity & SPI_CPOL_MASK) |
			(init->ClockPhase & SPI_CPHA_MASK);
	SPI2->CR1 = temp;

	/*SPI_CR2*/
	temp = 0;
	temp |= ((init->NSS >> 16) & SPI_SSOE_MASK) |
			(init->TIMode & SPI_FRF_MASK) |
			(init->NSSPMode & SPI_NSSP_MASK) |
			(init->DataSize & SPI_DS_MASK) |
			(init->DataSize > SPI_DATASIZE_8_BIT) ? (SPI_RXFIFO_THRESHOLD_HF & SPI_FRXTH_MASK) : (SPI_RXFIFO_THRESHOLD_QF & SPI_FRXTH_MASK);
	SPI2->CR2 = temp;
}

void spi2_write(uint8_t data) {
	SPI2_ENABLE();

	while(!(SPI2->SR & (1 << 1)));

	SPI2->SR = data;

	while(SPI2->SR & (1 << 7));

	SPI2_DISABLE();
}

uint8_t spi2_read() {
	SPI2_ENABLE();

	__DSB();
	__DSB();
	__DSB();
	__DSB();
	__DSB();
	__DSB();
	__DSB();
	__DSB();

	SPI2_DISABLE();

	while(!(SPI2->SR & (1 << 0)));

	uint8_t data = (uint8_t)(SPI2->DR >> 8);

	while(SPI2->SR & (1 << 7));

	return data;
}

uint8_t  spi2_write_read(uint8_t data) {
	SPI2_ENABLE();

	while(!(SPI2->SR & (1 << 1)));
	SPI2->DR = data;

	while(!(SPI2->SR & (1 << 0)));
	data = (uint8_t)(SPI2->DR >> 8);

	while(SPI2->SR & (0b11 << 11));
	while(SPI2->SR & (1 << 7));

	SPI2_DISABLE();

	return data;
}
