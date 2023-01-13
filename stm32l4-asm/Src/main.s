	.syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

.data

center_message:	.asciz "Center\n\r"
left_message:	.asciz "Left\n\r"
right_message:	.asciz "Right\n\r"
up_message:		.asciz "Up\n\r"
down_message:	.asciz "Down\n\r"

		.align
.text

.type 	main %function
.global main

main:
	bl init_lcd
	b __end
	bl init_red_led
	bl init_green_led

	bl red_led_on
	bl green_led_on
	bl red_led_off
	bl green_led_off
//	bl init_usart2
//	bl init_joystick
//loop:
//	bl print_joystick_center
//	bl print_joystick_left
//	bl print_joystick_right
//	bl print_joystick_up
//	bl print_joystick_down
//	beq loop


__end: b __end

print_joystick_center:
	push { r0, lr }
	bl read_joystick_center
	tst r0, #1
	ldr r0, =center_message

	IT ne
	blne snd_string_usart2

	pop { r0, pc }


print_joystick_left:
	push { r0, lr }
	bl read_joystick_left
	tst r0, #1
	ldr r0, =left_message

	IT ne
	blne snd_string_usart2

	pop { r0, pc }

print_joystick_right:
	push { r0, lr }
	bl read_joystick_right
	tst r0, #1
	ldr r0, =right_message

	IT ne
	blne snd_string_usart2

	pop { r0, pc }

print_joystick_up:
	push { r0, lr }
	bl read_joystick_up
	tst r0, #1
	ldr r0, =up_message

	IT ne
	blne snd_string_usart2

	pop { r0, pc }

print_joystick_down:
	push { r0, lr }
	bl read_joystick_down
	tst r0, #1
	ldr r0, =down_message

	IT ne
	blne snd_string_usart2

	pop { r0, pc }

