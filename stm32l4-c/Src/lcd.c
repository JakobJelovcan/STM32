/*
 * lcd.c
 *
 *  Created on: 3. feb. 2023
 *      Author: Jakob
 */

#include "lcd.h"

const uint16_t letters[] = { 0xFE00, 0x6714, 0x1D00, 0x4714, 0x9D00, 0x9C00, 0x3F00, 0xFA00, 0x0014, \
        0x5300, 0x9841, 0x1900, 0x5A48, 0x5A09, 0x5F00, 0xFC00, 0x5F01, 0xFC01, \
        0xAF00, 0x0414, 0x5B00, 0x18C0, 0x5A81, 0x00C9, 0x0058, 0x05C0 };

const uint16_t digits[] = { 0x5F00, 0x4200, 0xF500, 0x6700, 0xEA00, 0xAF00, 0xBF00, 0x4600, 0xFF00, 0xEF00 };

void lcd_wait_off() {
	while(LCD->CR & 1);
}

void lcd_wait_fcr_sync() {
	while(!(LCD->SR & (1 << 5)));
}

void lcd_wait_update_display_request() {
	while(LCD->SR & (1 << 2));
}

void lcd_enable_update_display_request() {
	LCD->SR |= (1 << 2);
}

void lcd_clear_ram() {
	volatile uint32_t* base = &LCD->COM_0;
	for(uint8_t i = 0; i < 16; ++i) base[i] = 0;
}

uint16_t lcd_convert_char(char chr, uint32_t dot, uint32_t double_dot) {
	uint16_t chr_code;
	if(isdigit(chr)) chr_code = digits[chr - 48];
	else if(isalpha(chr)) chr_code = letters[toupper(chr) - 65];
	else chr_code = LCD_EMPTY;
	if(dot) chr_code |= LCD_DOT;
	if(double_dot) chr_code |= LCD_DOUBLE_DOT;
	return chr_code;
}

void lcd_write_char(uint32_t pos, char chr, uint32_t dot, uint32_t double_dot) {
	uint16_t chr_code = lcd_convert_char(chr, dot, double_dot);
	uint32_t temp;
	switch(pos) {
		case 1:
			{
				temp = LCD->COM_0 & ~LCD_DIGIT_1_COM_0_SEGMENT_MASK;
				temp |= ((((chr_code >> 12) & 1) << LCD_SEGMENT_0_SHIFT) |
						(((chr_code >> 13) & 1) << LCD_SEGMENT_1_SHIFT) |
						(((chr_code >> 14) & 1) << LCD_SEGMENT_22_SHIFT) |
						(((chr_code >> 15) & 1) << LCD_SEGMENT_23_SHIFT));
				LCD->COM_0 = temp;

				temp = LCD->COM_1 & ~LCD_DIGIT_1_COM_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 8) & 1) << LCD_SEGMENT_0_SHIFT) |
						(((chr_code >> 9) & 1) << LCD_SEGMENT_1_SHIFT) |
						(((chr_code >> 10) & 1) << LCD_SEGMENT_22_SHIFT) |
						(((chr_code >> 11) & 1) << LCD_SEGMENT_23_SHIFT));
				LCD->COM_1 = temp;

				temp = LCD->COM_2 & ~LCD_DIGIT_1_COM_2_SEGMENT_MASK;
				temp |= ((((chr_code >> 4) & 1) << LCD_SEGMENT_0_SHIFT) |
						(((chr_code >> 5) & 1) << LCD_SEGMENT_1_SHIFT) |
						(((chr_code >> 6) & 1) << LCD_SEGMENT_22_SHIFT) |
						(((chr_code >> 7) & 1) << LCD_SEGMENT_23_SHIFT));
				LCD->COM_2 = temp;

				temp = LCD->COM_3 & ~LCD_DIGIT_1_COM_3_SEGMENT_MASK;
				temp |= ((((chr_code >> 0) & 1) << LCD_SEGMENT_0_SHIFT) |
						(((chr_code >> 1) & 1) << LCD_SEGMENT_1_SHIFT) |
						(((chr_code >> 2) & 1) << LCD_SEGMENT_22_SHIFT) |
						(((chr_code >> 3) & 1) << LCD_SEGMENT_23_SHIFT));
				LCD->COM_3 = temp;
				break;
			}
		case 2:
			{
				temp = LCD->COM_0 & ~LCD_DIGIT_2_COM_0_SEGMENT_MASK;
				temp |= ((((chr_code >> 12) & 1) << LCD_SEGMENT_2_SHIFT) |
						(((chr_code >> 13) & 1) << LCD_SEGMENT_3_SHIFT) |
						(((chr_code >> 14) & 1) << LCD_SEGMENT_20_SHIFT) |
						(((chr_code >> 15) & 1) << LCD_SEGMENT_21_SHIFT));
				LCD->COM_0 = temp;

				temp = LCD->COM_1 & ~LCD_DIGIT_2_COM_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 8) & 1) << LCD_SEGMENT_2_SHIFT) |
						(((chr_code >> 9) & 1) << LCD_SEGMENT_3_SHIFT) |
						(((chr_code >> 10) & 1) << LCD_SEGMENT_20_SHIFT) |
						(((chr_code >> 11) & 1) << LCD_SEGMENT_21_SHIFT));
				LCD->COM_1 = temp;

				temp = LCD->COM_2 & ~LCD_DIGIT_2_COM_2_SEGMENT_MASK;
				temp |= ((((chr_code >> 4) & 1) << LCD_SEGMENT_2_SHIFT) |
						(((chr_code >> 5) & 1) << LCD_SEGMENT_3_SHIFT) |
						(((chr_code >> 6) & 1) << LCD_SEGMENT_20_SHIFT) |
						(((chr_code >> 7) & 1) << LCD_SEGMENT_21_SHIFT));
				LCD->COM_2 = temp;

				temp = LCD->COM_3 & ~LCD_DIGIT_2_COM_3_SEGMENT_MASK;
				temp |= ((((chr_code >> 0) & 1) << LCD_SEGMENT_2_SHIFT) |
						(((chr_code >> 1) & 1) << LCD_SEGMENT_3_SHIFT) |
						(((chr_code >> 2) & 1) << LCD_SEGMENT_20_SHIFT) |
						(((chr_code >> 3) & 1) << LCD_SEGMENT_21_SHIFT));
				LCD->COM_3 = temp;
				break;
			}
		case 3:
			{
				temp = LCD->COM_0 & ~LCD_DIGIT_3_COM_0_SEGMENT_MASK;
				temp |= ((((chr_code >> 12) & 1) << LCD_SEGMENT_4_SHIFT) |
						(((chr_code >> 13) & 1) << LCD_SEGMENT_5_SHIFT) |
						(((chr_code >> 14) & 1) << LCD_SEGMENT_18_SHIFT) |
						(((chr_code >> 15) & 1) << LCD_SEGMENT_19_SHIFT));
				LCD->COM_0 = temp;

				temp = LCD->COM_1 & ~LCD_DIGIT_3_COM_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 8) & 1) << LCD_SEGMENT_4_SHIFT) |
						(((chr_code >> 9) & 1) << LCD_SEGMENT_5_SHIFT) |
						(((chr_code >> 10) & 1) << LCD_SEGMENT_18_SHIFT) |
						(((chr_code >> 11) & 1) << LCD_SEGMENT_19_SHIFT));
				LCD->COM_1 = temp;

				temp = LCD->COM_2 & ~LCD_DIGIT_3_COM_2_SEGMENT_MASK;
				temp |= ((((chr_code >> 4) & 1) << LCD_SEGMENT_4_SHIFT) |
						(((chr_code >> 5) & 1) << LCD_SEGMENT_5_SHIFT) |
						(((chr_code >> 6) & 1) << LCD_SEGMENT_18_SHIFT) |
						(((chr_code >> 7) & 1) << LCD_SEGMENT_19_SHIFT));
				LCD->COM_2 = temp;

				temp = LCD->COM_3 & ~LCD_DIGIT_3_COM_3_SEGMENT_MASK;
				temp |= ((((chr_code >> 0) & 1) << LCD_SEGMENT_4_SHIFT) |
						(((chr_code >> 1) & 1) << LCD_SEGMENT_5_SHIFT) |
						(((chr_code >> 2) & 1) << LCD_SEGMENT_18_SHIFT) |
						(((chr_code >> 3) & 1) << LCD_SEGMENT_19_SHIFT));
				LCD->COM_3 = temp;
				break;
			}
		case 4:
			{
				temp = LCD->COM_0 & ~LCD_DIGIT_4_COM_0_SEGMENT_MASK;
				temp |= ((((chr_code >> 12) & 1) << LCD_SEGMENT_6_SHIFT) |
						(((chr_code >> 15) & 1) << LCD_SEGMENT_17_SHIFT));
				LCD->COM_0 = temp;

				temp = LCD->COM_0_1 & ~LCD_DIGIT_4_COM_0_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 13) & 1) << LCD_SEGMENT_7_SHIFT) |
						(((chr_code >> 14) & 1) << LCD_SEGMENT_16_SHIFT));
				LCD->COM_0_1 = temp;

				temp = LCD->COM_1 & ~LCD_DIGIT_4_COM_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 8) & 1) << LCD_SEGMENT_6_SHIFT) |
						(((chr_code >> 11) & 1) << LCD_SEGMENT_17_SHIFT));
				LCD->COM_1 = temp;

				temp = LCD->COM_1_1 & ~LCD_DIGIT_4_COM_1_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 9) & 1) << LCD_SEGMENT_7_SHIFT) |
						(((chr_code >> 10) & 1) << LCD_SEGMENT_16_SHIFT));
				LCD->COM_1_1 = temp;

				temp = LCD->COM_2 & ~LCD_DIGIT_4_COM_2_SEGMENT_MASK;
				temp |= ((((chr_code >> 4) & 1) << LCD_SEGMENT_6_SHIFT) |
						(((chr_code >> 7) & 1) << LCD_SEGMENT_17_SHIFT));
				LCD->COM_2 = temp;

				temp = LCD->COM_2_1 & ~LCD_DIGIT_4_COM_2_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 5) & 1) << LCD_SEGMENT_7_SHIFT) |
						(((chr_code >> 6) & 1) << LCD_SEGMENT_16_SHIFT));
				LCD->COM_2_1 = temp;

				temp = LCD->COM_3 & ~LCD_DIGIT_4_COM_3_SEGMENT_MASK;
				temp |= ((((chr_code >> 0) & 1) << LCD_SEGMENT_6_SHIFT) |
						(((chr_code >> 3) & 1) << LCD_SEGMENT_17_SHIFT));
				LCD->COM_3 = temp;

				temp = LCD->COM_3_1 & ~LCD_DIGIT_4_COM_3_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 1) & 1) << LCD_SEGMENT_7_SHIFT) |
						(((chr_code >> 2) & 1) << LCD_SEGMENT_16_SHIFT));
				LCD->COM_3_1 = temp;
				break;
			}
		case 5:
			{
				temp = LCD->COM_0 & ~LCD_DIGIT_5_COM_0_SEGMENT_MASK;
				temp |= ((((chr_code >> 13) & 1) << LCD_SEGMENT_9_SHIFT) |
						(((chr_code >> 14) & 1) << LCD_SEGMENT_14_SHIFT));
				LCD->COM_0 = temp;

				temp = LCD->COM_0_1 & ~LCD_DIGIT_5_COM_0_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 12) & 1) << LCD_SEGMENT_8_SHIFT) |
						(((chr_code >> 15) & 1) << LCD_SEGMENT_15_SHIFT));
				LCD->COM_0_1 = temp;

				temp = LCD->COM_1 & ~LCD_DIGIT_5_COM_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 9) & 1) << LCD_SEGMENT_9_SHIFT) |
						(((chr_code >> 10) & 1) << LCD_SEGMENT_14_SHIFT));
				LCD->COM_1 = temp;

				temp = LCD->COM_1_1 & ~LCD_DIGIT_5_COM_1_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 8) & 1) << LCD_SEGMENT_8_SHIFT) |
						(((chr_code >> 11) & 1) << LCD_SEGMENT_15_SHIFT));
				LCD->COM_1_1 = temp;

				temp = LCD->COM_2 & ~LCD_DIGIT_5_COM_2_SEGMENT_MASK;
				temp |= ((((chr_code >> 5) & 1) << LCD_SEGMENT_9_SHIFT) |
						(((chr_code >> 6) & 1) << LCD_SEGMENT_14_SHIFT));
				LCD->COM_2 = temp;

				temp = LCD->COM_2_1 & ~LCD_DIGIT_5_COM_2_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 4) & 1) << LCD_SEGMENT_8_SHIFT) |
						(((chr_code >> 7) & 1) << LCD_SEGMENT_15_SHIFT));
				LCD->COM_2_1 = temp;

				temp = LCD->COM_3 & ~LCD_DIGIT_5_COM_3_SEGMENT_MASK;
				temp |= ((((chr_code >> 1) & 1) << LCD_SEGMENT_9_SHIFT) |
						(((chr_code >> 2) & 1) << LCD_SEGMENT_14_SHIFT));
				LCD->COM_3 = temp;

				temp = LCD->COM_3_1 & ~LCD_DIGIT_5_COM_3_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 0) & 1) << LCD_SEGMENT_8_SHIFT) |
						(((chr_code >> 3) & 1) << LCD_SEGMENT_15_SHIFT));
				LCD->COM_3_1 = temp;
				break;
			}
		case 6:
			{
				temp = LCD->COM_0 & ~LCD_DIGIT_6_COM_0_SEGMENT_MASK;
				temp |= ((((chr_code >> 12) & 1) << LCD_SEGMENT_10_SHIFT) |
						(((chr_code >> 13) & 1) << LCD_SEGMENT_11_SHIFT) |
						(((chr_code >> 14) & 1) << LCD_SEGMENT_12_SHIFT) |
						(((chr_code >> 15) & 1) << LCD_SEGMENT_13_SHIFT));
				LCD->COM_0 = temp;

				temp = LCD->COM_1 & ~LCD_DIGIT_6_COM_1_SEGMENT_MASK;
				temp |= ((((chr_code >> 8) & 1) << LCD_SEGMENT_10_SHIFT) |
						(((chr_code >> 9) & 1) << LCD_SEGMENT_11_SHIFT) |
						(((chr_code >> 10) & 1) << LCD_SEGMENT_12_SHIFT) |
						(((chr_code >> 11) & 1) << LCD_SEGMENT_13_SHIFT));
				LCD->COM_1 = temp;

				temp = LCD->COM_2 & ~LCD_DIGIT_6_COM_2_SEGMENT_MASK;
				temp |= ((((chr_code >> 4) & 1) << LCD_SEGMENT_10_SHIFT) |
						(((chr_code >> 5) & 1) << LCD_SEGMENT_11_SHIFT) |
						(((chr_code >> 6) & 1) << LCD_SEGMENT_12_SHIFT) |
						(((chr_code >> 7) & 1) << LCD_SEGMENT_13_SHIFT));
				LCD->COM_2 = temp;

				temp = LCD->COM_3 & ~LCD_DIGIT_6_COM_3_SEGMENT_MASK;
				temp |= ((((chr_code >> 0) & 1) << LCD_SEGMENT_10_SHIFT) |
						(((chr_code >> 1) & 1) << LCD_SEGMENT_11_SHIFT) |
						(((chr_code >> 2) & 1) << LCD_SEGMENT_12_SHIFT) |
						(((chr_code >> 3) & 1) << LCD_SEGMENT_13_SHIFT));
				LCD->COM_3 = temp;
				break;
			}
	}
}

void lcd_init(LCD_InitTypeDef* init) {
	RCC_GPIOA_CLK_ENABLE();
	RCC_GPIOB_CLK_ENABLE();
	RCC_GPIOC_CLK_ENABLE();
	RCC_GPIOD_CLK_ENABLE();

	GPIO_InitTypeDef gp_init = {};
	gp_init.Mode = GPIO_MODE_ALTERNATE_PP;
	gp_init.Pull = GPIO_NO_PULL;
	gp_init.Speed = GPIO_SPEED_VERY_HIGH;
	gp_init.Alternate = 11;

	gp_init.Pin = LCD_GPIOA_PINS;
	gpio_init(GPIOA, &gp_init);

	gp_init.Pin = LCD_GPIOB_PINS;
	gpio_init(GPIOB, &gp_init);

	gp_init.Pin = LCD_GPIOC_PINS;
	gpio_init(GPIOC, &gp_init);

	gp_init.Pin = LCD_GPIOD_PINS;
	gpio_init(GPIOD, &gp_init);

	stk_wait_ms(2);

	RCC_LCD_CLK_ENABLE();

	LCD_DISABLE();

	lcd_clear_ram();

	lcd_enable_update_display_request();

	uint32_t temp;
	/*LCD_FCR*/
	temp = 0;
	temp |= ((init->Prescaler & LCD_PS_MASK) |
			(init->ClockDivider & LCD_DIV_MASK) |
			(init->BlinkMode & LCD_BLINK_MASK) |
			(init->BlinkFrequency & LCD_BLINKF_MASK) |
			(init->Contrast & LCD_CC_MASK) |
			(init->DeadTime & LCD_DEAD_MASK));
	LCD->FCR = temp;

	lcd_wait_fcr_sync();

	/*LCD_CR*/
	temp = 0;
	temp |= LCD_BIAS_1_3 | LCD_DUTY_1_4;
	LCD->CR = temp;

	LCD_ENABLE();
}

void lcd_clear() {
	lcd_wait_update_display_request();
	lcd_clear_ram();
	lcd_enable_update_display_request();
}

void lcd_set_contrast(uint8_t cc) {
	LCD->FCR = (LCD->FCR & ~LCD_CC_MASK) | ((cc << 10) & LCD_CC_MASK);
}

uint8_t lcd_get_contrast() {
	return (LCD->FCR & LCD_CC_MASK) >> 10;
}

void lcd_set_blink_mode(uint8_t blink) {
	LCD->FCR = (LCD->FCR & ~LCD_BLINK_MASK) | ((blink << 16) & LCD_BLINK_MASK);
}

uint8_t lcd_get_blink_mode() {
	return (LCD->FCR & LCD_BLINK_MASK) >> 16;
}

void lcd_set_blink_frequency(uint8_t blinkf) {
	LCD->FCR = (LCD->FCR & ~LCD_BLINKF_MASK) | ((blinkf << 13) & LCD_BLINKF_MASK);
}

uint8_t lcd_get_blink_frequency() {
	return (LCD->FCR & LCD_BLINKF_MASK) >> 13;
}

void lcd_set_pulse_on_duration(uint8_t pon) {
	LCD->FCR = (LCD->FCR & ~LCD_PON_MASK) | ((pon << 4) & LCD_PON_MASK);
}

uint8_t lcd_get_pulse_on_duration() {
	return (LCD->FCR & LCD_PON_MASK) >> 4;
}

void lcd_set_dead_time_duration(uint8_t dead) {
	LCD->FCR = (LCD->FCR & ~LCD_DEAD_MASK) | ((dead << 7) & LCD_DEAD_MASK);
}

uint8_t lcd_get_dead_time_duration() {
	return (LCD->FCR & LCD_DEAD_MASK) >> 7;
}

void lcd_set_high_drive(uint8_t hd) {
	LCD->FCR = (LCD->FCR & ~LCD_HD_MASK) | ((hd << 0) & LCD_HD_MASK);
}

uint8_t lcd_get_high_drive() {
	return (LCD->FCR & LCD_HD_MASK) >> 0;
}

void lcd_set_prescaler(uint8_t ps) {
	LCD->FCR = (LCD->FCR & ~LCD_PS_MASK) | ((ps << 22) & LCD_PS_MASK);
}

uint8_t lcd_get_prescaler() {
	return (LCD->FCR & LCD_PS_MASK) >> 22;
}

void lcd_set_clock_divider(uint8_t div) {
	LCD->FCR = (LCD->FCR & ~LCD_DIV_MASK) | ((div << 18) & LCD_DIV_MASK);
}

uint8_t lcd_get_clock_divider() {
	return (LCD->FCR & LCD_DIV_MASK) >> 18;
}

void lcd_display_bar(uint8_t bars) {
	lcd_wait_update_display_request();
	if(bars & (1 << 0)) LCD->COM_3 |= LCD_BAR_0_SEGMENT;
	if(bars & (1 << 1)) LCD->COM_2 |= LCD_BAR_1_SEGMENT;
	if(bars & (1 << 2)) LCD->COM_3 |= LCD_BAR_2_SEGMENT;
	if(bars & (1 << 3)) LCD->COM_2 |= LCD_BAR_3_SEGMENT;
	lcd_enable_update_display_request();
}

void lcd_clear_bar(uint8_t bars) {
	lcd_wait_update_display_request();
	if(bars & (1 << 0)) LCD->COM_3 &= ~LCD_BAR_0_SEGMENT;
	if(bars & (1 << 1)) LCD->COM_2 &= ~LCD_BAR_1_SEGMENT;
	if(bars & (1 << 2)) LCD->COM_3 &= ~LCD_BAR_2_SEGMENT;
	if(bars & (1 << 3)) LCD->COM_2 &= ~LCD_BAR_3_SEGMENT;
	lcd_enable_update_display_request();
}

void lcd_display_string(char* str) {
	lcd_wait_update_display_request();
	for(uint8_t i = 1; i <= 6; ++i) {
		if(*str) lcd_write_char(i, *str, 0, 0);
		else break;
		++str;
	}
	lcd_enable_update_display_request();
}

void lcd_display_long_string(char* str) {
	uint32_t len = strlen(str);
	while(len--) lcd_display_string(str++);
}

void lcd_display_char(uint32_t pos, char chr, uint32_t dot, uint32_t double_dot) {
	lcd_wait_update_display_request();
	lcd_write_char(pos, chr, dot, double_dot);
	lcd_enable_update_display_request();
}
