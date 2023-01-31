/*
 * systick.h
 *
 *  Created on: Jan 31, 2023
 *      Author: Jakob
 */

#ifndef SYSTICK_H_
#define SYSTICK_H_

#include "stm32l476g.h"

#define STK_MILLISECOND			0x0F9F

#define STK_ENABLE				STK->CTRL |= (1 << 0)
#define STK_DISABLE				STK->CTRL &= ~(1 << 0)

#define STK_INT_ENABLE			STK->CTRL |= (1 << 1)
#define STK_INT_DISABLE			STK->CTRL &= ~(1 << 1)

void stk_init();

void stk_set_reset_value(uint32_t val);
uint32_t stk_get_reset_value();

void stk_set_current_value(uint32_t val);
uint32_t stk_get_current_value();

void stk_wait_ms(uint32_t ms);


#endif /* SYSTICK_H_ */
