.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ RCC_BASE,          0x40021000
.equ RCC_AHB2ENR,       0x4C

.equ GPIOA_BASE,        0x48000000
.equ GPIOx_MODER,       0x00
.equ GPIOx_MODER_VALUE, 0xFFFFF300
.equ GPIOx_IDR,         0x10
.equ GPIOx_PUPDR,       0x0C
.equ GPIOx_PUPDR_CLEAR, 0xFFFFF300
.equ GPIOx_PUPDR_SET,   0x000008AA

.type   init_joystick %function
.global init_joystick

init_joystick:
    push { r4, r5, r6, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #1
    str r5, [r4, #RCC_AHB2ENR]

    ldr r4, =GPIOA_BASE
    ldr r5, [r4, #GPIOx_MODER]
    ldr r6, =GPIOx_MODER_VALUE
    and r5, r6
    str r5, [r4, #GPIOx_MODER]

    ldr r5, [r4, #GPIOx_PUPDR]
    ldr r6, =GPIOx_PUPDR_CLEAR
    and r5, r6
    ldr r6, =GPIOx_PUPDR_SET
    orr r5, r6
    str r5, [r4, #GPIOx_PUPDR]

    pop { r4, r5, r6, pc }


.type   read_joystick_status %function
.global read_joystick_status

/*
* Returns the status of the joystick
* Bit 0: Center
* Bit 1: Left
* Bit 2: Right
* Bit 3: Up
* Bit 4: Down
*/
read_joystick_status:
    push { r5, r6, lr }

    ldr r5, =GPIOA_BASE
    ldr r4, [r5, #GPIOx_IDR]
    mov r6, r4
    and r4, #0x0000000F
    and r6, #(1<<5)
    orr r4, r4, r5, lsr #1

    pop { r5, r6, pc }

.type   read_joystick_center %function
.global read_joystick_center

read_joystick_center:
    push { r5, lr }

    ldr r5, =GPIOA_BASE
    ldr r4, [r5, #GPIOx_IDR]
    and r4, #1

    pop { r5, pc }


.type   read_joystick_left %function
.global read_joystick_left

read_joystick_left:
    push { r5, lr }

    ldr r5, =GPIOA_BASE
    ldr r4, [r5, #GPIOx_IDR]
    and r4, #(1 << 1)
    lsr r4, #1

    pop { r5, pc }


.type   read_joystick_right %function
.global read_joystick_right

read_joystick_right:
    push { r5, lr }

    ldr r5, =GPIOA_BASE
    ldr r4, [r5, #GPIOx_IDR]
    and r4, #(1 << 2)
    lsr r4, #2

    pop { r5, pc }


.type   read_joystick_up %function
.global read_joystick_up

read_joystick_up:
    push { r5, lr }

    ldr r5, =GPIOA_BASE
    ldr r4, [r5, #GPIOx_IDR]
    and r4, #(1 << 3)
    lsr r4, #3

    pop { r5, pc }


.type   read_joystick_down %function
.global read_joystick_down

read_joystick_down:
    push { r5, lr }

    ldr r5, =GPIOA_BASE
    ldr r4, [r5, #GPIOx_IDR]
    and r4, #(1 << 5)
    lsr r4, #5

    pop { r5, pc }
