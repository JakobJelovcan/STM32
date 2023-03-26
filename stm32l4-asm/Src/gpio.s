.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.equ    SYSCFG_BASE,    0x40010000
.equ    SYSCFG_EXTICR1, 0x08

.equ    EXTI_BASE,      0x40010400
.equ    EXTI_IMR1,      0x00
.equ    EXTI_EMR1,      0x04
.equ    EXTI_RTSR1,     0x08
.equ    EXTI_FTSR1,     0x0C

.equ    GPIOA_BASE,     0x48000000
.equ    GPIOB_BASE,     0x48000400
.equ    GPIOC_BASE,     0x48000800
.equ    GPIOD_BASE,     0x48000C00
.equ    GPIOE_BASE,     0x48001000
.equ    GPIOF_BASE,     0x48001400
.equ    GPIOG_BASE,     0x48001800
.equ    GPIOH_BASE,     0x48001C00

.equ    GPIOx_MODER,    0x00
.equ    GPIOx_OTYPER,   0x04
.equ    GPIOx_OSPEEDR,  0x08
.equ    GPIOx_PUPDR,    0x0C
.equ    GPIOx_IDR,      0x10
.equ    GPIOx_ODR,      0x14
.equ    GPIOx_BSRR,     0x18
.equ    GPIOx_LCKR,     0x1C
.equ    GPIOx_AFRL,     0x20
.equ    GPIOx_AFRH,     0x24
.equ    GPIOx_BRR,      0x28

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

.text

.type   gpio_index, %function
.local  gpio_index
gpio_index:
    push { r4, r5, lr }

    lsr r0, #10
    and r0, #0xF

    pop { r4, r5, pc }


/**
 * @brief Initialize GPIO pins
 * @param GPIO base address
 * @param Pins
 * @param Mode
 * @param Pullup/down
 * @param Output speed
 * @param Alternate function
 * @return None
*/
.type   gpio_init, %function
.global gpio_init
gpio_init:
    push { r4, r5, r6, r7, r8, r9, lr }

    ldr r4, [sp, #28]  //On stack
    ldr r5, [sp, #32]  //On stack

    ldr r6, =(GPIO_MODE_MASK | GPIO_OUTPUT_TYPE_MASK | GPIO_EXTI_MODE_MASK | GPIO_TRIGGER_MODE_MASK)
    and r2, r6
    and r3, GPIO_PULL_MASK     //Mask pull 2b
    and r4, GPIO_SPEED_MASK     //Mask speed 2b
    and r5, #0b00001111     //Mask alternate 4b
    ldr r6, =0x00

    //r0: GPIOx_BASE
    //r1: pins
    //r2: mode
    //r3: pull
    //r4: speed
    //r5: alternate
    //r6: position
    //r7: temp
    //r8: temp
    //r9: temp

    tst r2, GPIO_EXTI_MODE_MASK
    beq 1f
    bl rcc_syscfg_clk_enable

    //Loop and set every selected pin
1:
    tst r1, #(1 << 0)
    beq 3f                  //The pin is not selected

    eors r7, r2, r2, lsr #1
    beq 2f                  //Mode is not output or alternate

    //Set output speed
    ldr r7, =GPIO_SPEED_MASK
    ldr r9, [r0, #GPIOx_OSPEEDR]
    lsl r8, r6, #1          //Position * 2
    lsl r7, r8              //Mask for the selected pin
    bic r9, r7
    lsl r7, r4, r8          //Shift mode to the correct position
    orr r9, r7
    str r9, [r0, #GPIOx_OSPEEDR]

    //Set output type
    ldr r7, =0b01
    ldr r9, [r0, #GPIOx_OTYPER]
    lsl r7, r6
    bic r9, r7
    and r7, r2, #(1 << 4)
    lsr r7, #4
    lsl r7, r6
    orr r9, r7
    str r9, [r0, #GPIOx_OTYPER]

2:
    cmp r2, #0b11
    beq 2f                  //Mode is analog

    //Set pullup, pulldown
    ldr r7, =GPIO_PULL_MASK
    ldr r9, [r0, #GPIOx_PUPDR]
    lsl r8, r6, #1          //Position * 2
    lsl r7, r8
    bic r9, r7
    lsl r7, r3, r8
    orr r9, r7
    str r9, [r0, #GPIOx_PUPDR]

2:
    cmp r2, #0b10
    bne 2f                  //Mode is not alternate

    //Set alternate function
    ldr r7, =0b1111
    mov r8, r6
    cmp r6, #0x08
    ITEE lo
    ldrlo r9, [r0, #GPIOx_AFRL]
    ldrhs r9, [r0, #GPIOx_AFRH]
    subhs r8, #0x08
    lsl r8, #2              //Position * 4
    lsl r7, r8
    bic r9, r7
    lsl r7, r5, r8
    orr r9, r7

    cmp r6, #0x08
    ITE lo
    strlo r9, [r0, #GPIOx_AFRL]
    strhs r9, [r0, #GPIOx_AFRH]

2:
    //Set mode
    ldr r7, =GPIO_MODE_MASK
    ldr r9, [r0, #GPIOx_MODER]
    lsl r8, r6, #1          //Position * 2
    lsl r7, r8
    bic r9, r7
    and r7, r2, #0b11
    lsl r7, r8
    orr r9, r7
    str r9, [r0, #GPIOx_MODER]

    //Configure interupts
    tst r2, GPIO_EXTI_MODE_MASK
    beq 3f

    bic r8, r6, #0b11
    ldr r9, =SYSCFG_BASE + SYSCFG_EXTICR1
    ldr r7, [r9, r8]

    and r8, r6, #0x3
    lsl r8, #0x2
    ldr r9, =0xF
    lsl r9, r8
    bic r7, r9

    lsr r9, r0, #0xA
    and r9, #0xF
    lsl r9, r8
    orr r7, r9

    bic r8, r6, #0b11
    ldr r9, =SYSCFG_EXTICR1
    str r7, [r9, r8]

    ldr r9, =0x01
    lsl r9, r6
    ldr r8, =EXTI_BASE

    ldr r7, [r8, #EXTI_RTSR1]
    bic r7, r9
    tst r2, #GPIO_TRIGGER_MODE_RISING
    IT ne
    orrne r7, r9
    str r7, [r8, #EXTI_RTSR1]

    ldr r7, [r8, #EXTI_FTSR1]
    bic r7, r9
    tst r2, #GPIO_TRIGGER_MODE_FALLING
    IT ne
    orrne r7, r9
    str r7, [r8, #EXTI_FTSR1]

    ldr r7, [r8, #EXTI_EMR1]
    bic r7, r9
    tst r2, #GPIO_EXTI_MODE_EVENT
    IT ne
    orrne r7, r9
    str r7, [r8, #EXTI_EMR1]

    ldr r7, [r8, #EXTI_IMR1]
    bic r7, r9
    tst r2, #GPIO_EXTI_MODE_INTERUPT
    IT ne
    orrne r7, r9
    str r7, [r8, #EXTI_IMR1]

3:
    add r6, #1
    lsrs r1, #1
    bne 1b

    pop { r4, r5, r6, r7, r8, r9, pc }

/**
 * @brief Set or reset GPIO pin
 * @param GPIO base address
 * @param Pin
 * @param Value
 * @return None
*/
.type   gpio_write_pin, %function
.global gpio_write_pin
gpio_write_pin:
    push { lr }

    tst r2, #1
    ITEE ne
    strne r1, [r0, #GPIOx_BSRR]
    lsleq r1, #15
    streq r1, [r0, #GPIOx_BSRR]

    pop { pc }
