/*
 * stm32l476g_def.h
 *
 *  Created on: Jan 31, 2023
 *      Author: Jakob
 */

#ifndef STM32L476G_H_
#define STM32L476G_H_

/*GPIO definitions*/
#define GPIOA_BASE		0x48000000
#define GPIOB_BASE		0x48000400
#define GPIOC_BASE		0x48000800
#define GPIOD_BASE		0x48000C00
#define GPIOE_BASE		0x48001000
#define GPIOF_BASE		0x48001400
#define GPIOG_BASE		0x48001800
#define GPIOH_BASE		0x48001C00

#define GPIOA			((GPIO_TypeDef*) GPIOA_BASE)
#define GPIOB			((GPIO_TypeDef*) GPIOB_BASE)
#define GPIOC			((GPIO_TypeDef*) GPIOC_BASE)
#define GPIOD			((GPIO_TypeDef*) GPIOD_BASE)
#define GPIOE			((GPIO_TypeDef*) GPIOE_BASE)
#define GPIOF			((GPIO_TypeDef*) GPIOF_BASE)
#define GPIOG			((GPIO_TypeDef*) GPIOG_BASE)

typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

typedef struct
{
	volatile uint32_t MODER;
	volatile uint32_t OTYPER;
	volatile uint32_t OSPEEDR;
	volatile uint32_t PUPDR;
	volatile const uint32_t IDR;
	volatile uint32_t ODR;
	volatile uint32_t BSRR;
	volatile uint32_t LCKR;
	volatile uint32_t AFR[2];
	volatile uint32_t BRR;
	volatile uint32_t ASCR;
} GPIO_TypeDef;

/*RCC definitions*/

#define RCC_BASE		0x40021000
#define RCC				((RCC_TypeDef*) RCC_BASE)
typedef struct
{
	volatile uint32_t CR;
	volatile uint32_t ICSCR;
	volatile uint32_t CFGR;
	volatile uint32_t PLLCFGR;
	volatile uint32_t PLLSAI1CFGR;
	volatile uint32_t PLLSAI2CFGR;
	volatile uint32_t CIER;
	volatile uint32_t CIFR;
	volatile uint32_t CICR;
	volatile uint32_t AHB1RSTR;
	volatile uint32_t AHB2RSTR;
	volatile uint32_t AHB3RSTR;
	volatile uint32_t APB1RSTR1;
	volatile uint32_t APB1RSTR2;
	volatile uint32_t APB2RSTR;
	volatile uint32_t AHB1ENR;
	volatile uint32_t AHB2ENR;
	volatile uint32_t AHB3ENR;
	volatile uint32_t APB1ENR1;
	volatile uint32_t APB1ENR2;
	volatile uint32_t APB2ENR;
	volatile uint32_t AHB1SMENR;
	volatile uint32_t AHB2SMENR;
	volatile uint32_t AHB3SMENR;
	volatile uint32_t APB1SMENR1;
	volatile uint32_t APB1SMENR2;
	volatile uint32_t APB2SMENR;
	volatile uint32_t CCIPR;
	volatile uint32_t BDCR;
	volatile uint32_t CSR;
} RCC_TypeDef;


#endif /* STM32L476G_H_ */
