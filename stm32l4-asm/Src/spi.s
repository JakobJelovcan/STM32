.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ    SPI2_BASE,                  0x40003800
.equ    SPIx_CR1,                   0x00
.equ    SPIx_CR2,                   0x04
.equ    SPIx_SR,                    0x08
.equ    SPIx_DR,                    0x0C
.equ    SPIx_CRCPR,                 0x10
.equ    SPIx_RXCRCR,                0x14
.equ    SPIx_TXCRCR,                0x18

.equ GPIOA_BASE,                    0x48000000
.equ GPIOB_BASE,                    0x48000400
.equ GPIOC_BASE,                    0x48000800
.equ GPIOD_BASE,                    0x48000C00
.equ GPIOE_BASE,                    0x48001000
.equ GPIOF_BASE,                    0x48001400
.equ GPIOG_BASE,                    0x48001800
.equ GPIOH_BASE,                    0x48001C00

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

.equ SPI_GPIO_PINS, (GPIO_PIN_1 | GPIO_PIN_3 | GPIO_PIN_4)

.text


.type   spi2_init, %function
.global spi2_init
spi2_init:
    push { r4, r5, r6, lr }

    bl rcc_spi2_clk_enable
    bl rcc_gpiod_clk_enable

    ldr r0, =GPIOD_BASE
    ldr r1, =SPI_GPIO_PINS
    ldr r2, =0b10
    ldr r3, =0b00
    ldr r4, =0b0101
    str r4, [sp, #-4]!
    ldr r4, =0b10
    str r4, [sp, #-4]!

    bl init_gpio

    add sp, #8              //Remove aguments from the stack

    bl spi2_disable



    ldr r4, =SPI2_BASE

    /*
     * Mode: master (MSTR = 1, SSI = 1)
     * Direction: 2-line unidirectional (RXONLY = 0, BIDIMODE = 0)
     * Clock polarity: low (CPOL = 0)
     * Clock phase: first (rising) edge (CPHA = 0)
     * Software slave managment: enable (SSM = 1)
     * Baud rate prescaler: /2 (BR = 0)
     * First bit: msb (LSBFIRST = 0)
     * CRC calculation: disable (CRCEN = 0)
     * SPI enable: disable (SPE = 0)
    */
    ldr r5, [r4, #SPIx_CR1]
    ldr r6, =0x5800
    and r5, r6
    ldr r6, =0x0304
    orr r5, r6
    str r5, [r4, #SPIx_CR1]

    /*
     * SS output enable: disable (SSOE = 0)
     * Frame format: Motorola mode (FRF = 0)
     * NSS pulse managment: no NSS pulse (NSSP = 0)
     * Data size: 8bit (DS = 0111)
     * FIFO reception threshold: >= 1/4 (FRXTH = 1)
    */
    ldr r5, [r4, #SPIx_CR2]
    ldr r6, =0xE0E3
    and r5, r6
    ldr r6, =0x1700
    orr r5, r6
    str r5, [r4, #SPIx_CR2]

    pop { r4, r5, r6, pc }


.type   spi2_enable, %function
.global spi2_enable
spi2_enable:
    push { r4, r5, r6, lr }

    ldr r4, =SPI2_BASE
    ldr r5, [r4, #SPIx_CR1]
    orr r5, #(1 << 6)
    str r5, [r4, #SPIx_CR1]

    pop { r4, r5, r6, pc }

.type   spi2_disable, %function
.global spi2_disable
spi2_disable:
    push { r4, r5, r6, lr }

    ldr r4, =SPI2_BASE

1:  ldr r5, [r4, #SPIx_SR]
    tst r5, #(0b11 << 11)
    bne 1b

1:  ldr r5, [r4, #SPIx_SR]
    tst r5, #(1 << 7)
    bne 1b

    ldr r5, [r4, #SPIx_CR1]
    bic r5, #(1 << 6)
    str r5, [r4, #SPIx_CR1]

1:  ldr r5, [r4, #SPIx_SR]
    tst r5, #(0b11 << 9)
    bne 1b

    pop { r4, r5, r6, pc }
