.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.data
.align
.text

.type 	main %function
.global main

main:
	bl init_lcd
loop:
	bl lcd_display_bar
	bl lcd_enable_update_display_request
	b loop
__end: b __end
