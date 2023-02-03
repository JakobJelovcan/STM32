/*
 * spi.h
 *
 *  Created on: 4. feb. 2023
 *      Author: Jakob
 */

#ifndef SPI_H_
#define SPI_H_

#include "stm32l476g.h"
#include "gpio.h"
#include "rcc.h"

/*SPI_CR1*/
#define SPI_BIDIMODE_MASK				(1 << 15)
#define SPI_DIDIOE_MASK					(1 << 14)
#define SPI_CRCEN_MASK					(1 << 13)
#define SPI_CRCNEXT_MASK				(1 << 12)
#define SPI_CRCL_MASK					(1 << 11)
#define SPI_RXONLY_MASK					(1 << 10)
#define SPI_SSM_MASK					(1 << 9)
#define SPI_SSI_MASK					(1 << 8)
#define SPI_LSBFIRST_MASK				(1 << 7)
#define SPI_SPE_MASK					(1 << 6)
#define SPI_BR_MASK						(0b111  << 3)
#define SPI_MSTR_MASK					(1 << 2)
#define SPI_CPOL_MASK					(1 << 1)
#define SPI_CPHA_MASK					(1 << 0)

/*SPI_CR2*/
#define SPI_LDMA_TX_MASK				(1 << 14)
#define SPI_LDMA_RX_MASK				(1 << 13)
#define SPI_FRXTH_MASK					(1 << 12)
#define SPI_DS_MASK						(0b1111 << 8)
#define SPI_TXEIE_MASK					(1 << 7)
#define SPI_RXNEIE_MASK					(1 << 6)
#define SPI_ERRIE_MASK					(1 << 5)
#define SPI_FRF_MASK					(1 << 4)
#define SPI_NSSP_MASK					(1 << 3)
#define SPI_SSOE_MASK					(1 << 2)
#define SPI_TXDMAEN_MASK				(1 << 1)
#define SPI_RXDMAEN_MASK				(1 << 0)


#define SPI_MODE_SLAVE					0x00
#define SPI_MODE_MASTER					(SPI_SSI_MASK | SPI_MSTR_MASK)

#define SPI_DIRECTION_2_LINES			0x00
#define SPI_DIRECTION_2_LINES_RXONLY	SPI_RXONLY_MASK
#define SPI_DIRECTION_1_LINE			SPI_BIDIMODE

#define SPI_DATASIZE_4_BIT				(0b0011 << 8)
#define SPI_DATASIZE_5_BIT				(0b0100 << 8)
#define SPI_DATASIZE_6_BIT				(0b0101 << 8)
#define SPI_DATASIZE_7_BIT				(0b0110 << 8)
#define SPI_DATASIZE_8_BIT				(0b0111 << 8)
#define SPI_DATASIZE_9_BIT				(0b1000 << 8)
#define SPI_DATASIZE_10_BIT				(0b1001 << 8)
#define SPI_DATASIZE_11_BIT				(0b1010 << 8)
#define SPI_DATASIZE_12_BIT				(0b1011 << 8)
#define SPI_DATASIZE_13_BIT				(0b1100 << 8)
#define SPI_DATASIZE_14_BIT				(0b1101 << 8)
#define SPI_DATASIZE_15_BIT				(0b1110 << 8)
#define SPI_DATASIZE_16_BIT				(0b1111 << 8)

#define SPI_POLARITY_LOW				0x00
#define SPI_POLARITY_HIGH				SPI_CPOL_MASK

#define SPI_PHASE_RISING_EDGE			0x00
#define SPI_PHASE_FALLING_EDGE			SPI_CPHA_MASK

#define SPI_NSS_SOFTWARE				SPI_SSM_MASK
#define SPI_NSS_HARDWARE_INPUT			0x00
#define SPI_NSS_HARDWARE_OUTPUT			(SPI_SSOE_MASK << 16)

#define SPI_NSS_PULSE_ENABLE			SPI_NSSP_MASK
#define SPI_NSS_PULSE_DISABLE			0x00

#define SPI_BRP_2						(0b000 << 3)
#define SPI_BRP_4						(0b001 << 3)
#define SPI_BRP_8						(0b010 << 3)
#define SPI_BRP_16						(0b011 << 3)
#define SPI_BRP_32						(0b100 << 3)
#define SPI_BRP_64						(0b101 << 3)
#define SPI_BRP_128						(0b110 << 3)
#define SPI_BRP_256						(0b111 << 3)

#define SPI_FIRSTBIT_MSB				0x00
#define SPI_FIRSTBIT_LSB				SPI_LSBFIRST_MASK

#define SPI_TIMODE_DISABLE				0x00
#define SPI_TIMODE_ENABLE				SPI_FRF_MASK

#define SPI_CRCCALCULATION_DISABLE		0x00
#define SPI_CRCCALCULATION_ENABLE		SPI_CRCEN_MASK

#define SPI_CRCL_DATASIZE				0x00
#define SPI_CRCL_8_BIT					0x01
#define SPI_CRCL_16_BIT					0x02

#define SPI_RXFIFO_THRESHOLD_QF			SPI_FRXTH_MASK
#define SPI_RXFIFO_THRESHOLD_HF			0x00

#define SPI_IT_TXE						SPI_TXEIE_MASK
#define SPI_IT_RXNE						SPI_RXNEIE_MASK
#define SPI_IT_ERR						SPI_ERRIE_MASK

#define SPI2_ENABLE()					SPI2->CR1 |= (1 << 6)
#define SPI2_DISABLE()					SPI2->CR1 &= ~(1 << 6)

#define SPI2_GPIO						GPIOD
#define SPI2_GPIO_PINS					(GPIO_PIN_1 | GPIO_PIN_3 | GPIO_PIN_4)

typedef struct
{
	uint32_t Mode;
	uint32_t Direction;
	uint32_t DataSize;
	uint32_t ClockPolarity;
	uint32_t ClockPhase;
	uint32_t NSS;
	uint32_t BRP;
	uint32_t FirstBit;
	uint32_t TIMode;
	uint32_t NSSPMode;
} SPI_InitTypeDef;

void spi2_init(SPI_InitTypeDef*);
void spi2_write(uint8_t);
uint8_t spi2_read();
uint8_t  spi2_write_read(uint8_t);

#endif /* SPI_H_ */
