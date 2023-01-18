.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.data
string: .asciz "Hello"
.align
.text

.type   main %function
.global main

main:
    bl init_lcd
    bl lcd_clear

    ldr r0, =string
    bl lcd_display_string

    ldr r0, =0x3E8
    bl systick_wait_ms

__end: b __end
