/**
 ******************************************************************************
 * @file           : main.c
 * @author         : Auto-generated by STM32CubeIDE
 * @brief          : Main program body
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2023 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "stm32l476g.h"
#include "systick.h"
#include "joystick.h"
#include "led.h"
#include "usart.h"
#include "lcd.h"
#include "spi.h"
#include "gyro.h"

char* out_str_x = "X:%-6.3f";
char display_str_buffer[10];
float gyro_data[3];

int main(void)
{
	stm32l476g_init();
	gyro_data[0] = 1.0f;

	sprintf(display_str_buffer, out_str_x, gyro_data[0]);
	SPI_InitTypeDef spi_init = L3GD20_SPI_INIT;
	spi2_init(&spi_init);

	LCD_InitTypeDef init = {};
	init.Prescaler = LCD_PS_16;
	init.ClockDivider = LCD_DIV_17;
	init.BlinkMode = LCD_BLINK_0;
	init.BlinkFrequency = LCD_BLINKF_8;
	init.Contrast = LCD_CC_3;
	init.DeadTime = LCD_DEAD_0;
	init.PulseOnDuration = LCD_PON_0;

	lcd_init(&init);
	LCD_ENABLE();

	USART_InitTypeDef usart_init = { 34 };
	usart2_init(&usart_init);
	USART2_ENABLE();

	joystick_init();

	gyro_init();

	uint8_t display_state = 0;
	uint8_t c = 0;

	float xyz[3];		//Array for storing angular data
	int temp = 0;		//Temperature

	char str_display[10];
	for(;;) {
		if(c == 0)
		{
			l3gd20_read_xyz(xyz);
			temp = l3gd20_read_temp();
			c = 0;
		}
		c = (c + 1) % 6;

		if(joystick_get_up_state())
		{
			display_state = (display_state + 3) % 4;
		}
		else if(joystick_get_down_state())
		{
			display_state = (display_state + 5) % 4;
		}

		switch(display_state)
		{
			case 0:
			{
				sprintf(str_display, "%dc", temp);
				lcd_display_string(str_display);
				break;
			}
			case 1:
			{
				sprintf(str_display, "X:%-6.3f", xyz[0]);
				lcd_display_string(str_display);
				break;
			}
			case 2:
			{
				sprintf(str_display, "Y:%-6.3f", xyz[1]);
				lcd_display_string(str_display);
				break;
			}
			case 3:
			{
				sprintf(str_display, "Z:%-6.3f", xyz[2]);
				lcd_display_string(str_display);
				break;
			}
		}
		stk_wait_ms(15);
	}
}
