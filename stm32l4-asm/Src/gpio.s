.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ	GPIOA_BASE,	0x48000000
.equ	GPIOB_BASE,	0x48000400
.equ	GPIOC_BASE,	0x48000800
.equ	GPIOD_BASE,	0x48000C00
.equ	GPIOE_BASE, 0x48001000
.equ	GPIOF_BASE,	0x48001400
.equ	GPIOG_BASE, 0x48001800
.equ	GPIOH_BASE, 0x48001C00

.equ	GPIOx_MODER, 	0x00
.equ	GPIOx_OTYPER,	0x04
.equ	GPIOx_OSPEEDR,  0x08
.equ	GPIOx_PUPDR,	0x0C
.equ	GPIOx_IDR,		0x10
.equ	GPIOx_ODR,		0x14
.equ	GPIOx_BSSR,		0x18
.equ	GPIOx_LCKR,		0x1C
.equ	GPIOx_AFRL,		0x20
.equ	GPIOx_AFRH,		0x24
.equ	GPIOx_BRR,		0x28

.text

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
.type   init_gpio, %function
.global init_gpio
init_gpio:
    push { r4, r5, r6, r7, r8, r9, lr }

    ldr r4, [sp, #28]  //On stack
    ldr r5, [sp, #32]  //On stack

    and r2, #0b0011     //Mask mode 2b
    and r3, #0b0011     //Mask pull 2b
    and r4, #0b0011     //Mask speed 2b
    and r5, #0b1111     //Mask alternate 4b

    //r0: GPIOx_BASE
    //r1: pins
    //r2: mode
    //r3: pull
    //r4: speed
    //r5: alternate
    //r6: position
    //r7: temp

    //Loop and set every selected pin
1:
    tst r1, #(1 << 0)
    beq 3f                  //The pin is not selected

    eors r7, r2, r2, lsr #1
    beq 2f                  //Mode is not output or alternate

    //Set output speed
    ldr r7, =0b11
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
    and r7, r2, #0b01
    lsl r7, r6
    orr r9, r7
    str r9, [r0, #GPIOx_OTYPER]

2:
    cmp r2, #0b11
    beq 2f                  //Mode is analog

    //Set pullup, pulldown
    ldr r7, =0b11
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
    ldr r7, =0b11
    ldr r9, [r0, #GPIOx_MODER]
    lsl r8, r6, #1          //Position * 2
    lsl r7, r8
    bic r9, r7
    lsl r7, r2, r8
    orr r9, r7
    str r9, [r0, #GPIOx_MODER]

3:
    add r6, #1
    lsrs r1, #1
    bne 1b

    pop { r4, r5, r6, r7, r8, r9, pc }
