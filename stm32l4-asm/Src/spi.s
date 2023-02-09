/*
 * spi.s
 *
 *  Created on: 8. feb. 2023
 *      Author: Jakob
 */
.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.equ SPI2_BASE,                 0x40003800
.equ SPIx_CR1,                  0x00
.equ SPIx_CR2,                  0x04
.equ SPIx_SR,                   0x08
.equ SPIx_DR,                   0x0C
.equ SPIx_CRCPR,                0x10
.equ SPIx_RXCRCR,               0x14
.equ SPIx_TXCRCR,               0x18

//SPIx_CR1
.equ SPIx_BIDIMODE_MASK,        (1 << 15)
.equ SPIx_BIDIOE_MASK,          (1 << 14)
.equ SPIx_CRCEN_MASK,           (1 << 13)
.equ SPIx_CRCNEXT_MASK,         (1 << 12)
.equ SPIx_CRCL_MASK,            (1 << 11)
.equ SPIx_RXONLY_MASK,          (1 << 10)
.equ SPIx_SSM_MASK,             (1 << 9)
.equ SPIx_SSI_MASK,             (1 << 8)
.equ SPIx_LSBFIRST_MASK,        (1 << 7)
.equ SPIx_SPE_MASK,             (1 << 6)
.equ SPIx_BR_MASK,              (0b111 << 3)
.equ SPIx_MSTR_MASK,            (1 << 2)
.equ SPIx_CPOL_MASK,            (1 << 1)
.equ SPIx_CPHA_MASK,            (1 << 0)

//SPIx_CR2
.equ SPIx_LDMA_TX_MASK,         (1 << 14)
.equ SPIx_LDMA_RX_MASK,         (1 << 13)
.equ SPIx_FRXTH_MASK,           (1 << 12)
.equ SPIx_DS_MASK,              (0b1111 << 8)
.equ SPIx_TXEIE_MASK,           (1 << 7)
.equ SPIx_RXNEIE_MASK,          (1 << 6)
.equ SPIx_ERRIE_MASK,           (1 << 5)
.equ SPIx_FRF_MASK,             (1 << 4)
.equ SPIx_NSSP_MASK,            (1 << 3)
.equ SPIx_SSOE_MASK,            (1 << 2)
.equ SPIx_TXDMAEN_MASK,         (1 << 1)
.equ SPIx_RXDMAEN_MASK,         (1 << 0)

//BR
.equ SPIx_BR_2,                 (0b000 << 3)
.equ SPIx_BR_4,                 (0b001 << 3)
.equ SPIx_BR_8,                 (0b010 << 3)
.equ SPIx_BR_16,                (0b011 << 3)
.equ SPIx_BR_32,                (0b100 << 3)
.equ SPIx_BR_64,                (0b101 << 3)
.equ SPIx_BR_128,               (0b110 << 3)
.equ SPIx_BR_256,               (0b111 << 3)

//DS
.equ SPIx_DS_4BIT,              (0b0011 << 8)
.equ SPIx_DS_5BIT,              (0b0100 << 8)
.equ SPIx_DS_6BIT,              (0b0101 << 8)
.equ SPIx_DS_7BIT,              (0b0110 << 8)
.equ SPIx_DS_8BIT,              (0b0111 << 8)
.equ SPIx_DS_9BIT,              (0b1000 << 8)
.equ SPIx_DS_10BIT,             (0b1001 << 8)
.equ SPIx_DS_11BIT,             (0b1010 << 8)
.equ SPIx_DS_12BIT,             (0b1011 << 8)
.equ SPIx_DS_13BIT,             (0b1100 << 8)
.equ SPIx_DS_14BIT,             (0b1101 << 8)
.equ SPIx_DS_15BIT,             (0b1110 << 8)
.equ SPIx_DS_16BIT,             (0b1111 << 8)

//SPIx_SR
.equ SPIx_FTLVL_MASK,           (0b11 << 11)
.equ SPIx_FRLVL_MASK,           (0b11 << 9)
.equ SPIx_FRE_MASK,             (1 << 8)
.equ SPIx_BSY_MASK,             (1 << 7)
.equ SPIx_OVR_MASK,             (1 << 8)
.equ SPIx_MODF_MASK,            (1 << 5)
.equ SPIx_CRCERR_MASK,          (1 << 4)
.equ SPIx_TXE_MASK,             (1 << 1)
.equ SPIx_RXNE_MASK,            (1 << 0)

.equ SPI2_GPIO,                 0x48000C00
.equ SPI2_SCK_PIN,              (1 << 1)
.equ SPI2_MISO_PIN,             (1 << 3)
.equ SPI2_MOSI_PIN,             (1 << 4)

.equ GPIO_ALTERNATE_MODE_PP,    0x02
.equ GPIO_NO_PULL,              0x00
.equ GPIO_AF_5,                 0x05
.equ GPIO_SPEED_VERY_HIGH,      0x03

.text

.type   spi2_init, %function
.global spi2_init
spi2_init:
    push { r4, r5, lr }

    mov fp, sp
    sub sp, #8

    //Enable SPI2 GPIO
    bl rcc_gpiod_clk_enable

    ldr r0, =SPI2_GPIO
    ldr r1, =(SPI2_SCK_PIN | SPI2_MISO_PIN | SPI2_MOSI_PIN)
    ldr r2, =GPIO_ALTERNATE_MODE_PP
    ldr r3, =GPIO_NO_PULL
    ldr r4, =GPIO_AF_5
    str r4, [fp, #-4]
    ldr r4, =GPIO_SPEED_VERY_HIGH
    str r4, [fp, #-8]

    bl gpio_init

    //Enable SPI2 clk
    bl rcc_spi2_clk_enable

    //Disable SPI2
    bl spi2_disable

    //Configure spi2
    ldr r4, =SPI2_BASE
    //Set SPI2_CR1
    /*
     *SSM: Software slave managment (0b1)
     *SSI: Internal slave select (0b1)
     *BR: Baud rate prescaler (0b10)
     *MSTR: Master selection (0b1)
     *Direction: 2 line full duplex
    */
    ldr r5, =(SPIx_SSM_MASK | SPIx_SSI_MASK | SPIx_BR_8 | SPIx_MSTR_MASK)
    str r5, [r4, #SPIx_CR1]

    //Set SPI2_CR2
    /*
     *FRXTH: FIFO reception threshold (0b1)
     *DS: data size (0b0111 8-bit)
    */
    ldr r5, =(SPIx_FRXTH_MASK | SPIx_DS_8BIT)
    str r5, [r4, #SPIx_CR2]

    mov sp, fp

    pop { r4, r5, pc }


.type   spi2_enable, %function
.global spi2_enable
spi2_enable:
    push { r4, r5, lr }

    ldr r4, =SPI2_BASE
    ldr r5, [r4, #SPIx_CR1]
    orr r5, #SPIx_SPE_MASK
    str r5, [r4, #SPIx_CR1]

    pop { r4, r5, pc }

.type   spi2_disable, %function
.global spi2_disable
spi2_disable:
    push { r4, r5, lr }

    ldr r4, =SPI2_BASE
    ldr r5, [r4, #SPIx_CR1]
    bic r5, #SPIx_SPE_MASK
    str r5, [r4, #SPIx_CR1]

    pop { r4, r5, pc }

.type   spi2_direction_1_line_rx, %function
.global spi2_direction_1_line_rx
spi2_direction_1_line_rx:
    push { r4, r5, r6, lr }

    ldr r4, =SPI2_BASE
    ldr r5, [r4, #SPIx_CR1]
    ldr r6, =(SPIx_RXONLY_MASK | SPIx_BIDIOE_MASK)
    bic r5, r6
    ldr r6, =SPIx_BIDIMODE_MASK
    orr r5, r6
    str r5, [r4, #SPIx_CR1]

    pop { r4, r5, r6, pc }

.type   spi2_direction_1_line_tx, %function
.global spi2_direction_1_line_tx
spi2_direction_1_line_tx:
    push { r4, r5, r6, lr }

    ldr r4, =SPI2_BASE
    ldr r5, [r4, #SPIx_CR1]
    ldr r6, =SPIx_RXONLY_MASK
    bic r5, r6
    ldr r6, =(SPIx_BIDIMODE_MASK | SPIx_BIDIOE_MASK)
    orr r5, r6
    str r5, [r4, #SPIx_CR1]

    pop { r4, r5, r6, pc }

.type   spi2_direction_2_lines, %function
.global spi2_direction_2_lines
spi2_direction_2_lines:
    push { r4, r5, r6, lr }

    ldr r4, =SPI2_BASE
    ldr r5, [r4, #SPIx_CR1]
    ldr r6, =(SPIx_BIDIMODE_MASK | SPIx_BIDIOE_MASK | SPIx_RXONLY_MASK)
    bic r5, r6
    str r5, [r4, #SPIx_CR1]

    pop { r4, r5, r6, pc }

.type   spi2_direction_2_lines_rx, %function
.global spi2_direction_2_lines_rx
spi2_direction_2_lines_rx:
    push { r4, r5, r6, lr }

    ldr r4, =SPI2_BASE
    ldr r5, [r4, #SPIx_CR1]
    ldr r6, =(SPIx_BIDIMODE_MASK | SPIx_BIDIOE_MASK)
    bic r5, r6
    ldr r6, =SPIx_RXONLY_MASK
    orr r5, r6
    str r5, [r4, #SPIx_CR1]

    pop { r4, r5, r6, pc }

.type   spi2_transmit_receive, %function
.global spi2_transmit_receive
spi2_transmit_receive:
    push { r4, r5, lr }

    bl spi2_enable

    ldr r4, =SPI2_BASE

    //Wait for TXE flag in SPI2_SR to be 1
1:  ldr r5, [r4, #SPIx_SR]
    tst r5, SPIx_TXE_MASK
    beq 1b

    strb r0, [r4, #SPIx_DR]

    //Wait for RXNE flag in SPI2_SR to be 1
1:  ldr r5, [r4, #SPIx_SR]
    tst r5, SPIx_RXNE_MASK
    beq 1b

    ldrb r0, [r4, #SPIx_DR]

    //Wait for transmit FIFO level to be 0
1:  ldr r5, [r4, #SPIx_SR]
    ands r5, SPIx_FTLVL_MASK
    bne 1b

    //Wait for BSY flag in SPI2_SR to be 0
1:  ldr r5, [r4, #SPIx_SR]
    tst r5, SPIx_BSY_MASK
    bne 1b

    bl spi2_disable

    pop { r4, r5, pc }
