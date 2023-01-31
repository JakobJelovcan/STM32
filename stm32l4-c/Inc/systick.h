/*
 * systick.h
 *
 *  Created on: Jan 31, 2023
 *      Author: Jakob
 */

#ifndef SYSTICK_H_
#define SYSTICK_H_

typedef struct
{
	uint32_t CTLR;
	uint32_t LOAD;
	uint32_t VAL;
	uint32_t CALIB;

} SysTick_TypeDef;

#endif /* SYSTICK_H_ */
