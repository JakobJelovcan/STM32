	.syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

.data
struct:	.space 24
.align
.text

.type 	main %function
.global main

main:
	bl init_lcd

loop:
	bl lcd_display_bar
	b loop
__end: b __end
