.syntax unified
.cpu cortex-m4
.fpu vfpv4
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

.equ GPIO_PIN_0,                    (1 << 0)
.equ GPIO_PIN_1,                    (1 << 1)
.equ GPIO_PIN_2,                    (1 << 2)
.equ GPIO_PIN_3,                    (1 << 3)
.equ GPIO_PIN_4,                    (1 << 4)
.equ GPIO_PIN_5,                    (1 << 5)
.equ GPIO_PIN_6,                    (1 << 6)
.equ GPIO_PIN_7,                    (1 << 7)
.equ GPIO_PIN_8,                    (1 << 8)
.equ GPIO_PIN_9,                    (1 << 9)
.equ GPIO_PIN_10,                   (1 << 10)
.equ GPIO_PIN_11,                   (1 << 11)
.equ GPIO_PIN_12,                   (1 << 12)
.equ GPIO_PIN_13,                   (1 << 13)
.equ GPIO_PIN_14,                   (1 << 14)
.equ GPIO_PIN_15,                   (1 << 15)

.equ GPIO_MODE_POSITION,            0x00
.equ GPIO_MODE_MASK,                0x03 << GPIO_MODE_POSITION
.equ GPIO_MODE_INPUT,               0x00 << GPIO_MODE_POSITION
.equ GPIO_MODE_OUTPUT,              0x01 << GPIO_MODE_POSITION
.equ GPIO_MODE_AF,                  0x02 << GPIO_MODE_POSITION
.equ GPIO_MODE_ANALOG,              0x03 << GPIO_MODE_POSITION

.equ GPIO_OUTPUT_TYPE_POSITION,     0x04
.equ GPIO_OUTPUT_TYPE_MASK,         0x01 << GPIO_OUTPUT_TYPE_POSITION
.equ GPIO_OUTPUT_TYPE_PP,           0x00 << GPIO_OUTPUT_TYPE_POSITION
.equ GPIO_OUTPUT_TYPE_OD,           0x01 << GPIO_OUTPUT_TYPE_POSITION

.equ GPIO_EXTI_MODE_POSITION,       0x10
.equ GPIO_EXTI_MODE_MASK,           0x03 << GPIO_EXTI_MODE_POSITION
.equ GPIO_EXTI_MODE_INTERUPT,       0x01 << GPIO_EXTI_MODE_POSITION
.equ GPIO_EXTI_MODE_EVENT,          0x02 << GPIO_EXTI_MODE_POSITION

.equ GPIO_TRIGGER_MODE_POSITION,    0x14
.equ GPIO_TRIGGER_MODE_MASK,        0x07 << GPIO_TRIGGER_MODE_POSITION
.equ GPIO_TRIGGER_MODE_RISING,      0x01 << GPIO_TRIGGER_MODE_POSITION
.equ GPIO_TRIGGER_MODE_FALLING,     0x02 << GPIO_TRIGGER_MODE_POSITION

.equ GPIO_MODE_IT_RISING,           (GPIO_MODE_INPUT | GPIO_EXTI_MODE_INTERUPT | GPIO_TRIGGER_MODE_RISING)
.equ GPIO_MODE_IT_FALLING,          (GPIO_MODE_INPUT | GPIO_EXTI_MODE_INTERUPT | GPIO_TRIGGER_MODE_FALLING)

.equ GPIO_MODE_EVT_RISING,          (GPIO_MODE_INPUT | GPIO_EXTI_MODE_EVENT | GPIO_TRIGGER_MODE_RISING)
.equ GPIO_MODE_EVT_FALLING,         (GPIO_MODE_INPUT | GPIO_EXTI_MODE_EVENT | GPIO_TRIGGER_MODE_FALLING)

.equ GPIO_SPEED_MASK,               0x03
.equ GPIO_SPEED_LOW,                0x00
.equ GPIO_SPEED_MEDIUM,             0x01
.equ GPIO_SPEED_HIGH,               0x02
.equ GPIO_SPEED_VERY_HIGH,          0x03

.equ GPIO_PULL_MASK,                0x03
.equ GPIO_PULL_NONE,                0x00
.equ GPIO_PULL_UP,                  0x01
.equ GPIO_PULL_DOWN,                0x02

.equ JOYSTICK_PINS,                 (GPIO_PIN_0 | GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_3 | GPIO_PIN_5)

.equ EXTI0_IRQn,                    6
.equ EXTI1_IRQn,                    7
.equ EXTI2_IRQn,                    8
.equ EXTI3_IRQn,                    9
.equ EXTI4_IRQn,                    10
.equ EXTI9_5_IRQn,                  23
.equ EXTI15_10_IRQn,                40

.type   joystick_init %function
.global joystick_init

joystick_init:
    push { r4, r5, fp, lr }

    mov fp, sp
    ldr r0, =GPIOA_BASE
    ldr r1, =JOYSTICK_PINS
    ldr r2, =GPIO_MODE_INPUT            //Mode
    ldr r3, =GPIO_PULL_DOWN             //Pullup/down
    ldr r4, =0x00                       //Alternate function
    str r4, [sp, #-4]!                  //Store on stack
    ldr r4, =GPIO_SPEED_LOW             //Output speed
    str r4, [sp, #-4]!                  //Store on stack

    bl gpio_init
    mov sp, fp

    pop { r4, r5, fp, lr }

.type   joystick_init_interupt, %function
.global joystick_init_interupt
joystick_init_interupt:
    push { r4, r5, fp, lr }

    mov fp, sp
    ldr r0, =GPIOA_BASE
    ldr r1, =JOYSTICK_PINS
    ldr r2, =GPIO_MODE_IT_RISING        //Mode
    ldr r3, =GPIO_PULL_DOWN             //Pullup/down
    ldr r4, =0x00                       //Alternate function
    str r4, [sp, #-4]!                  //Store on stack
    ldr r4, =GPIO_SPEED_LOW             //Output speed
    str r4, [sp, #-4]!                  //Store on stack

    bl gpio_init

    //Set EXTI0 IRQ
    ldr r0, =EXTI0_IRQn
    ldr r1, =0x00
    ldr r2, =0x00
    bl nvic_set_priority

    ldr r0, =EXTI0_IRQn
    bl nvic_enable_irq

    //Set EXTI1 IRQ
    ldr r0, =EXTI1_IRQn
    ldr r1, =0x00
    ldr r2, =0x00
    bl nvic_set_priority

    ldr r0, =EXTI1_IRQn
    bl nvic_enable_irq

    //Set EXTI2 IRQ
    ldr r0, =EXTI2_IRQn
    ldr r1, =0x00
    ldr r2, =0x00
    bl nvic_set_priority

    ldr r0, =EXTI2_IRQn
    bl nvic_enable_irq

    //Set EXTI3 IRQ
    ldr r0, =EXTI3_IRQn
    ldr r1, =0x00
    ldr r2, =0x00
    bl nvic_set_priority

    ldr r0, =EXTI3_IRQn
    bl nvic_enable_irq

    //Set EXTI9_5 IRQ
    ldr r0, =EXTI9_5_IRQn
    ldr r1, =0x00
    ldr r2, =0x00
    bl nvic_set_priority

    ldr r0, =EXTI9_5_IRQn
    bl nvic_enable_irq

    mov sp, fp

    pop { r4, r5, fp, lr }


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
