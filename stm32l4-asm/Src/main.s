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
   	ldr r4, =0x2E
loop:
	bl lcd_clear

    ldr r0, =0x04
    mov r1, r4
    bl lcd_display_char
	bl lcd_enable_update_display_request
	add r4, #1
	ldr r0, =0x3E8
	bl systick_wait_ms

	b loop
__end: b __end
