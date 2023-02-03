/*
 * fpu.c
 *
 *  Created on: 3. feb. 2023
 *      Author: Jakob
 */

#include "fpu.h"

void fpu_enable() {
	FPU->CPACR |= (0b1111 << 20);
	__DSB();
	__ISB();
}

void fpu_disable() {
	FPU->CPACR &= ~(0b1111 << 20);
	__DSB();
	__ISB();
}
