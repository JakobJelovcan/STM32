/*
 * stm32l476g_def.h
 *
 *  Created on: Jan 31, 2023
 *      Author: Jakob
 */

#ifndef STM32L476G_H_
#define STM32L476G_H_

#include <stdint.h>

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
	uint32_t _PADDING1;
	volatile uint32_t AHB1RSTR;
	volatile uint32_t AHB2RSTR;
	volatile uint32_t AHB3RSTR;
	uint32_t _PADDING2;
	volatile uint32_t APB1RSTR1;
	volatile uint32_t APB1RSTR2;
	volatile uint32_t APB2RSTR;
	uint32_t _PADDING3;
	volatile uint32_t AHB1ENR;
	volatile uint32_t AHB2ENR;
	volatile uint32_t AHB3ENR;
	uint32_t _PADDING4;
	volatile uint32_t APB1ENR1;
	volatile uint32_t APB1ENR2;
	volatile uint32_t APB2ENR;
	uint32_t _PADDING5;
	volatile uint32_t AHB1SMENR;
	volatile uint32_t AHB2SMENR;
	volatile uint32_t AHB3SMENR;
	uint32_t _PADDING6;
	volatile uint32_t APB1SMENR1;
	volatile uint32_t APB1SMENR2;
	volatile uint32_t APB2SMENR;
	uint32_t _PADDING7;
	volatile uint32_t CCIPR;
	volatile uint32_t BDCR;
	volatile uint32_t CSR;
} RCC_TypeDef;

/*FPU definitions*/

#define FPU_BASE		0xE000ED88
#define FPU				((FPU_TypeDef*) FPU_BASE)

typedef struct
{
	volatile uint32_t CPACR;
	volatile uint32_t FPCCR;
	volatile uint32_t FPCAR;
	volatile uint32_t FPDSCR;
	volatile uint32_t FPSCR;
} FPU_TypeDef;

#define FPU_ENABLE		FPU->CPACR |= 0x00F00000
#define FPU_DISABLE		FPU->CPACR &= ~0x00F00000

/*SysTick definitions*/

#define STK_BASE		0xE000E010
#define STK				((STK_TypeDef*)STK_BASE)

typedef struct
{
	volatile uint32_t CTRL;
	volatile uint32_t LOAD;
	volatile uint32_t VAL;
	volatile const uint32_t CALIB;
} STK_TypeDef;

/*USART definitions*/
#define USART2_BASE		0x40004400
#define USART2			((USART_TypeDef*) USART2_BASE)

typedef struct
{
	volatile uint32_t CR1;
	volatile uint32_t CR2;
	volatile uint32_t CR3;
	volatile uint32_t BRR;
	volatile uint32_t GTPR;
	volatile uint32_t RTOR;
	volatile uint32_t RQR;
	volatile uint32_t ISR;
	volatile uint32_t ICR;
	volatile uint32_t RDR;
	volatile uint32_t TDR;
} USART_TypeDef;


void stm32l476g_init();

#endif /* STM32L476G_H_ */
