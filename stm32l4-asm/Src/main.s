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

	ldr r4, =0x0F
loop:
	movs r0, r4, lsr #1
	ITE eq
	ldreq r4, =0x1F
	movne r4, r0

	bl lcd_clear_ram
	bl lcd_display_bar
	bl lcd_enable_update_display_request

	ldr r0, =1000
	bl systick_wait_ms


	b loop
__end: b __end
