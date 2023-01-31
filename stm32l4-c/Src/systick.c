/*
 * systick.c
 *
 *  Created on: Jan 31, 2023
 *      Author: Jakob
 */

#include "systick.h"

void stk_init() {
	STK->CTRL = 0x04;
}

void stk_set_reset_value(uint32_t val) {
	STK->LOAD = val;
}
uint32_t stk_get_reset_value() {
	return STK->LOAD;
}

void stk_set_current_value(uint32_t val) {
	STK->VAL = val;
}
uint32_t stk_get_current_value() {
	return STK->VAL;
}

void stk_wait_ms(uint32_t ms) {
	STK->LOAD = STK_MILLISECOND;
	STK_ENABLE;
	while(ms--) {
		while(STK->CTRL & (1 << 16));
	}
	STK_DISABLE;
}
