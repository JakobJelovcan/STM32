.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.data
string: .space 128
.align
.text

.type   main %function
.global main

main:
    bl lcd_init
    bl usart2_init

    ldr r0, =string
    ldr r1, =0x7F               //Maximum length
    bl usart2_receive_string

    bl lcd_clear

    ldr r0, =string
    bl lcd_display_long_string
__end: b __end
