/*
 * lcd.h
 *
 *  Created on: 3. feb. 2023
 *      Author: Jakob
 */

/*
 * Default settings
 * 	LCD_InitTypeDef init = {};
	init.Prescaler = LCD_PS_16;
	init.ClockDivider = LCD_DIV_17;
	init.BlinkMode = LCD_BLINK_0;
	init.BlinkFrequency = LCD_BLINKF_8;
	init.Contrast = LCD_CC_3;
	init.DeadTime = LCD_DEAD_0;
	init.PulseOnDuration = LCD_PON_0;
 * */

#ifndef LCD_H_
#define LCD_H_

#include <ctype.h>
#include <string.h>
#include "stm32l476g.h"
#include "rcc.h"
#include "systick.h"
#include "gpio.h"

#define LCD_SEGMENT_0_SHIFT					4
#define LCD_SEGMENT_1_SHIFT					23
#define LCD_SEGMENT_2_SHIFT					6
#define LCD_SEGMENT_3_SHIFT					13
#define LCD_SEGMENT_4_SHIFT					15
#define LCD_SEGMENT_5_SHIFT					29
#define LCD_SEGMENT_6_SHIFT					31
#define LCD_SEGMENT_7_SHIFT					1
#define LCD_SEGMENT_8_SHIFT					3
#define LCD_SEGMENT_9_SHIFT					25
#define LCD_SEGMENT_10_SHIFT				17
#define LCD_SEGMENT_11_SHIFT				8
#define LCD_SEGMENT_12_SHIFT				9
#define LCD_SEGMENT_13_SHIFT				26
#define LCD_SEGMENT_14_SHIFT				24
#define LCD_SEGMENT_15_SHIFT				2
#define LCD_SEGMENT_16_SHIFT				0
#define LCD_SEGMENT_17_SHIFT				30
#define LCD_SEGMENT_18_SHIFT				28
#define LCD_SEGMENT_19_SHIFT				14
#define LCD_SEGMENT_20_SHIFT				12
#define LCD_SEGMENT_21_SHIFT				5
#define LCD_SEGMENT_22_SHIFT				22
#define LCD_SEGMENT_23_SHIFT				3

#define LCD_SEGMENT_0						(1 << LCD_SEGMENT_0_SHIFT)
#define LCD_SEGMENT_1						(1 << LCD_SEGMENT_1_SHIFT)
#define LCD_SEGMENT_2						(1 << LCD_SEGMENT_2_SHIFT)
#define LCD_SEGMENT_3						(1 << LCD_SEGMENT_3_SHIFT)
#define LCD_SEGMENT_4						(1 << LCD_SEGMENT_4_SHIFT)
#define LCD_SEGMENT_5						(1 << LCD_SEGMENT_5_SHIFT)
#define LCD_SEGMENT_6						(1 << LCD_SEGMENT_6_SHIFT)
#define LCD_SEGMENT_7						(1 << LCD_SEGMENT_7_SHIFT)
#define LCD_SEGMENT_8						(1 << LCD_SEGMENT_8_SHIFT)
#define LCD_SEGMENT_9						(1 << LCD_SEGMENT_9_SHIFT)
#define LCD_SEGMENT_10						(1 << LCD_SEGMENT_10_SHIFT)
#define LCD_SEGMENT_11						(1 << LCD_SEGMENT_11_SHIFT)
#define LCD_SEGMENT_12						(1 << LCD_SEGMENT_12_SHIFT)
#define LCD_SEGMENT_13						(1 << LCD_SEGMENT_13_SHIFT)
#define LCD_SEGMENT_14						(1 << LCD_SEGMENT_14_SHIFT)
#define LCD_SEGMENT_15						(1 << LCD_SEGMENT_15_SHIFT)
#define LCD_SEGMENT_16						(1 << LCD_SEGMENT_16_SHIFT)
#define LCD_SEGMENT_17						(1 << LCD_SEGMENT_17_SHIFT)
#define LCD_SEGMENT_18						(1 << LCD_SEGMENT_18_SHIFT)
#define LCD_SEGMENT_19						(1 << LCD_SEGMENT_19_SHIFT)
#define LCD_SEGMENT_20						(1 << LCD_SEGMENT_20_SHIFT)
#define LCD_SEGMENT_21						(1 << LCD_SEGMENT_21_SHIFT)
#define LCD_SEGMENT_22						(1 << LCD_SEGMENT_22_SHIFT)
#define LCD_SEGMENT_23						(1 << LCD_SEGMENT_23_SHIFT)

#define LCD_DIGIT_1_COM_0_SEGMENT_MASK		(LCD_SEGMENT_0 | LCD_SEGMENT_1 | LCD_SEGMENT_22 | LCD_SEGMENT_23)
#define LCD_DIGIT_1_COM_1_SEGMENT_MASK		(LCD_SEGMENT_0 | LCD_SEGMENT_1 | LCD_SEGMENT_22 | LCD_SEGMENT_23)
#define LCD_DIGIT_1_COM_2_SEGMENT_MASK		(LCD_SEGMENT_0 | LCD_SEGMENT_1 | LCD_SEGMENT_22 | LCD_SEGMENT_23)
#define LCD_DIGIT_1_COM_3_SEGMENT_MASK		(LCD_SEGMENT_0 | LCD_SEGMENT_1 | LCD_SEGMENT_22 | LCD_SEGMENT_23)

#define LCD_DIGIT_2_COM_0_SEGMENT_MASK		(LCD_SEGMENT_2 | LCD_SEGMENT_3 | LCD_SEGMENT_20 | LCD_SEGMENT_21)
#define LCD_DIGIT_2_COM_1_SEGMENT_MASK		(LCD_SEGMENT_2 | LCD_SEGMENT_3 | LCD_SEGMENT_20 | LCD_SEGMENT_21)
#define LCD_DIGIT_2_COM_2_SEGMENT_MASK		(LCD_SEGMENT_2 | LCD_SEGMENT_3 | LCD_SEGMENT_20 | LCD_SEGMENT_21)
#define LCD_DIGIT_2_COM_3_SEGMENT_MASK		(LCD_SEGMENT_2 | LCD_SEGMENT_3 | LCD_SEGMENT_20 | LCD_SEGMENT_21)

#define LCD_DIGIT_3_COM_0_SEGMENT_MASK		(LCD_SEGMENT_4 | LCD_SEGMENT_5 | LCD_SEGMENT_18 | LCD_SEGMENT_19)
#define LCD_DIGIT_3_COM_1_SEGMENT_MASK		(LCD_SEGMENT_4 | LCD_SEGMENT_5 | LCD_SEGMENT_18 | LCD_SEGMENT_19)
#define LCD_DIGIT_3_COM_2_SEGMENT_MASK		(LCD_SEGMENT_4 | LCD_SEGMENT_5 | LCD_SEGMENT_18 | LCD_SEGMENT_19)
#define LCD_DIGIT_3_COM_3_SEGMENT_MASK		(LCD_SEGMENT_4 | LCD_SEGMENT_5 | LCD_SEGMENT_18 | LCD_SEGMENT_19)

#define LCD_DIGIT_4_COM_0_SEGMENT_MASK		(LCD_SEGMENT_6 | LCD_SEGMENT_17)
#define LCD_DIGIT_4_COM_0_1_SEGMENT_MASK	(LCD_SEGMENT_7 | LCD_SEGMENT_16)
#define LCD_DIGIT_4_COM_1_SEGMENT_MASK		(LCD_SEGMENT_6 | LCD_SEGMENT_17)
#define LCD_DIGIT_4_COM_1_1_SEGMENT_MASK	(LCD_SEGMENT_7 | LCD_SEGMENT_16)
#define LCD_DIGIT_4_COM_2_SEGMENT_MASK		(LCD_SEGMENT_6 | LCD_SEGMENT_17)
#define LCD_DIGIT_4_COM_2_1_SEGMENT_MASK	(LCD_SEGMENT_7 | LCD_SEGMENT_16)
#define LCD_DIGIT_4_COM_3_SEGMENT_MASK		(LCD_SEGMENT_6 | LCD_SEGMENT_17)
#define LCD_DIGIT_4_COM_3_1_SEGMENT_MASK	(LCD_SEGMENT_7 | LCD_SEGMENT_16)

#define LCD_DIGIT_5_COM_0_SEGMENT_MASK		(LCD_SEGMENT_9 | LCD_SEGMENT_14)
#define LCD_DIGIT_5_COM_0_1_SEGMENT_MASK	(LCD_SEGMENT_8 | LCD_SEGMENT_15)
#define LCD_DIGIT_5_COM_1_SEGMENT_MASK		(LCD_SEGMENT_9 | LCD_SEGMENT_14)
#define LCD_DIGIT_5_COM_1_1_SEGMENT_MASK	(LCD_SEGMENT_8 | LCD_SEGMENT_15)
#define LCD_DIGIT_5_COM_2_SEGMENT_MASK		(LCD_SEGMENT_9 | LCD_SEGMENT_14)
#define LCD_DIGIT_5_COM_2_1_SEGMENT_MASK	(LCD_SEGMENT_8 | LCD_SEGMENT_15)
#define LCD_DIGIT_5_COM_3_SEGMENT_MASK		(LCD_SEGMENT_9 | LCD_SEGMENT_14)
#define LCD_DIGIT_5_COM_3_1_SEGMENT_MASK	(LCD_SEGMENT_8 | LCD_SEGMENT_15)

#define LCD_DIGIT_6_COM_0_SEGMENT_MASK		(LCD_SEGMENT_10 | LCD_SEGMENT_11 | LCD_SEGMENT_12 | LCD_SEGMENT_13)
#define LCD_DIGIT_6_COM_1_SEGMENT_MASK		(LCD_SEGMENT_10 | LCD_SEGMENT_11 | LCD_SEGMENT_12 | LCD_SEGMENT_13)
#define LCD_DIGIT_6_COM_2_SEGMENT_MASK		(LCD_SEGMENT_10 | LCD_SEGMENT_11 | LCD_SEGMENT_12 | LCD_SEGMENT_13)
#define LCD_DIGIT_6_COM_3_SEGMENT_MASK		(LCD_SEGMENT_10 | LCD_SEGMENT_11 | LCD_SEGMENT_12 | LCD_SEGMENT_13)

#define LCD_GPIOA_PINS						(GPIO_PIN_6 | GPIO_PIN_7 | GPIO_PIN_8 | GPIO_PIN_9 | GPIO_PIN_10 | GPIO_PIN_15)
#define LCD_GPIOB_PINS						(GPIO_PIN_0 | GPIO_PIN_1 | GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_9 | GPIO_PIN_12 | GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15)
#define LCD_GPIOC_PINS						(GPIO_PIN_3 | GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_6 | GPIO_PIN_7 | GPIO_PIN_8)
#define LCD_GPIOD_PINS						(GPIO_PIN_8 | GPIO_PIN_9 | GPIO_PIN_10 | GPIO_PIN_11 | GPIO_PIN_12 | GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15)

#define LCD_BAR_0_SEGMENT 					LCD_SEGMENT_11
#define LCD_BAR_1_SEGMENT					LCD_SEGMENT_11
#define LCD_BAR_2_SEGMENT					LCD_SEGMENT_9
#define LCD_BAR_3_SEGMENT					LCD_SEGMENT_9

/*LCD_FCR*/
#define LCD_PS_MASK							(0b1111 << 22)
#define LCD_DIV_MASK						(0b1111 << 18)
#define LCD_BLINK_MASK						(0b11 << 16)
#define LCD_BLINKF_MASK						(0b111 << 13)
#define LCD_CC_MASK							(0b111 << 10)
#define LCD_DEAD_MASK						(0b111 << 7)
#define LCD_PON_MASK						(0b111 << 4)
#define LCD_UDDIE_MASK						(1 << 3)
#define LCD_SOFIE_MASK						(1 << 1)
#define LCD_HD_MASK							(1 << 0)

/*LCD_CR*/
#define LCD_BUFEN_MASK						(1 << 8)
#define LCD_MUX_SEG_MASK					(1 << 7)
#define LCD_BIAS_MASK						(0b11 << 5)
#define LCD_DUTY_MASK						(0b111 << 2)
#define LCD_VSEL_MASK						(1 << 1)
#define LCD_LCDEN_MASK						(1 << 0)

#define LCD_BIAS_1_4						(0b00 << 5)
#define LCD_BIAS_1_2						(0b01 << 5)
#define LCD_BIAS_1_3						(0b10 << 5)

#define LCD_DUTY_1_2						(0b001 << 2)
#define LCD_DUTY_1_3						(0b010 << 2)
#define LCD_DUTY_1_4						(0b011 << 2)
#define LCD_DUTY_1_8						(0b100 << 2)

#define LCD_PS_1							(0b0000 << 22)
#define LCD_PS_2							(0b0001 << 22)
#define LCD_PS_4							(0b0010 << 22)
#define LCD_PS_8							(0b0011 << 22)
#define LCD_PS_16							(0b0100 << 22)
#define LCD_PS_32							(0b0101 << 22)
#define LCD_PS_64							(0b0110 << 22)
#define LCD_PS_128							(0b0111 << 22)
#define LCD_PS_256							(0b1000 << 22)
#define LCD_PS_512							(0b1001 << 22)
#define LCD_PS_1024							(0b1010 << 22)
#define LCD_PS_2048							(0b1011 << 22)
#define LCD_PS_4096							(0b1100 << 22)
#define LCD_PS_8192							(0b1101 << 22)
#define LCD_PS_16384						(0b1110 << 22)
#define LCD_PS_32768						(0b1111 << 22)

#define LCD_DIV_16							(0b0000 << 18)
#define LCD_DIV_17							(0b0001 << 18)
#define LCD_DIV_18							(0b0010 << 18)
#define LCD_DIV_19							(0b0011 << 18)
#define LCD_DIV_20							(0b0100 << 18)
#define LCD_DIV_21							(0b0101 << 18)
#define LCD_DIV_22							(0b0110 << 18)
#define LCD_DIV_23							(0b0111 << 18)
#define LCD_DIV_24							(0b1000 << 18)
#define LCD_DIV_25							(0b1001 << 18)
#define LCD_DIV_26							(0b1010 << 18)
#define LCD_DIV_27							(0b1011 << 18)
#define LCD_DIV_28							(0b1100 << 18)
#define LCD_DIV_29							(0b1101 << 18)
#define LCD_DIV_30							(0b1110 << 18)
#define LCD_DIV_31							(0b1111 << 18)

#define LCD_BLINK_0							(0b00 << 16)
#define LCD_BLINK_1							(0b01 << 16)
#define LCD_BLINK_2							(0b10 << 16)
#define LCD_BLINK_3							(0b11 << 16)

#define LCD_BLINKF_8						(0b000 << 13)
#define LCD_BLINKF_16						(0b001 << 13)
#define LCD_BLINKF_32						(0b010 << 13)
#define LCD_BLINKF_64						(0b011 << 13)
#define LCD_BLINKF_128						(0b100 << 13)
#define LCD_BLINKF_256						(0b101 << 13)
#define LCD_BLINKF_512						(0b110 << 13)
#define LCD_BLINKF_1024						(0b111 << 13)

#define LCD_CC_0							(0b000 << 10)
#define LCD_CC_1							(0b001 << 10)
#define LCD_CC_2							(0b010 << 10)
#define LCD_CC_3							(0b011 << 10)
#define LCD_CC_4							(0b100 << 10)
#define LCD_CC_5							(0b101 << 10)
#define LCD_CC_6							(0b110 << 10)
#define LCD_CC_7							(0b111 << 10)

#define LCD_DEAD_0							(0b000 << 7)
#define LCD_DEAD_1							(0b001 << 7)
#define LCD_DEAD_2							(0b010 << 7)
#define LCD_DEAD_3							(0b011 << 7)
#define LCD_DEAD_4							(0b100 << 7)
#define LCD_DEAD_5							(0b101 << 7)
#define LCD_DEAD_6							(0b110 << 7)
#define LCD_DEAD_7							(0b111 << 7)

#define LCD_PON_0							(0b000 << 4)
#define LCD_PON_1							(0b001 << 4)
#define LCD_PON_2							(0b010 << 4)
#define LCD_PON_3							(0b011 << 4)
#define LCD_PON_4							(0b100 << 4)
#define LCD_PON_5							(0b101 << 4)
#define LCD_PON_6							(0b110 << 4)
#define LCD_PON_7							(0b111 << 4)

#define LCD_DOT								0x02
#define LCD_DOUBLE_DOT						0x20
#define LCD_EMPTY							0x00

#define LCD_ENABLE()						LCD->CR |= 1
#define LCD_DISABLE()						LCD->CR &= ~1

typedef	struct
{
	uint32_t Prescaler;
	uint32_t ClockDivider;
	uint32_t BlinkMode;
	uint32_t BlinkFrequency;
	uint32_t Contrast;
	uint32_t DeadTime;
	uint32_t PulseOnDuration;
} LCD_InitTypeDef;

void lcd_init(LCD_InitTypeDef*);
void lcd_clear();

void lcd_set_contrast(uint8_t);
uint8_t lcd_get_contrast();

void lcd_set_blink_mode(uint8_t);
uint8_t lcd_get_blink_mode();

void lcd_set_blink_frequency(uint8_t);
uint8_t lcd_get_blink_frequency();

void lcd_set_pulse_on_duration(uint8_t);
uint8_t lcd_get_pulse_on_duration();

void lcd_set_dead_time_duration(uint8_t);
uint8_t lcd_get_dead_time_duration();

void lcd_set_high_drive(uint8_t);
uint8_t lcd_get_high_drive();

void lcd_set_prescaler(uint8_t);
uint8_t lcd_get_prescaler();

void lcd_set_clock_divider(uint8_t);
uint8_t lcd_get_clock_divider();

void lcd_display_bar(uint8_t);
void lcd_clear_bar(uint8_t);
void lcd_display_string(char*);
void lcd_display_long_string(char*);
void lcd_display_char(uint32_t, char, uint32_t, uint32_t);

#endif /* LCD_H_ */
