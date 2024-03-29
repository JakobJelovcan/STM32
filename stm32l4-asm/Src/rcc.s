.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.equ RCC_BASE,            0x40021000
.equ RCC_AHB2ENR,         0x4C
.equ RCC_APB1ENR1,        0x58
.equ RCC_APB2ENR,         0x60
.equ RCC_BDCR,            0x90

.text

.type   rcc_gpioa_clk_enable %function
.global rcc_gpioa_clk_enable
rcc_gpioa_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #(1 << 0)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpioa_clk_disable %function
.global rcc_gpioa_clk_disable
rcc_gpioa_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    bic r5, #(1 << 0)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpiob_clk_enable %function
.global rcc_gpiob_clk_enable
rcc_gpiob_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #(1 << 1)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpiob_clk_disable %function
.global rcc_gpiob_clk_disable
rcc_gpiob_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    bic r5, #(1 << 1)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpioc_clk_enable %function
.global rcc_gpioc_clk_enable
rcc_gpioc_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #(1 << 2)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpioc_clk_disable %function
.global rcc_gpioc_clk_disable
rcc_gpioc_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    bic r5, #(1 << 2)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpiod_clk_enable %function
.global rcc_gpiod_clk_enable
rcc_gpiod_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #(1 << 3)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpiod_clk_disable %function
.global rcc_gpiod_clk_disable
rcc_gpiod_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    bic r5, #(1 << 3)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpioe_clk_enable %function
.global rcc_gpioe_clk_enable
rcc_gpioe_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #(1 << 4)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpioe_clk_disable %function
.global rcc_gpioe_clk_disable
rcc_gpioe_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    bic r5, #(1 << 4)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpiof_clk_enable %function
.global rcc_gpiof_clk_enable
rcc_gpiof_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #(1 << 5)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpiof_clk_disable %function
.global rcc_gpiof_clk_disable
rcc_gpiof_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    bic r5, #(1 << 5)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpiog_clk_enable %function
.global rcc_gpiog_clk_enable
rcc_gpiog_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #(1 << 6)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpiog_clk_disable %function
.global rcc_gpiog_clk_disable
rcc_gpiog_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    bic r5, #(1 << 6)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpioh_clk_enable %function
.global rcc_gpioh_clk_enable
rcc_gpioh_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    orr r5, #(1 << 7)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_gpioh_clk_disable %function
.global rcc_gpioh_clk_disable
rcc_gpioh_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_AHB2ENR]
    bic r5, #(1 << 7)
    str r5, [r4, #RCC_AHB2ENR]

    pop { r4, r5, pc }

.type   rcc_lcd_clk_enable %function
.global rcc_lcd_clk_enable
rcc_lcd_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_APB1ENR1]
    orr r5, #(1 << 9)
    str r5, [r4, #RCC_APB1ENR1]

    pop { r4, r5, pc }

.type   rcc_lcd_clk_disable %function
.global rcc_lcd_clk_disable
rcc_lcd_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_APB1ENR1]
    bic r5, #(1 << 9)
    str r5, [r4, #RCC_APB1ENR1]

    pop { r4, r5, pc }

.type   rcc_pwr_clk_enable %function
.global rcc_pwr_clk_enable
rcc_pwr_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_APB1ENR1]
    orr r5, #(1 << 28)
    str r5, [r4, #RCC_APB1ENR1]

    pop { r4, r5, pc }

.type   rcc_pwr_clk_disable %function
.global rcc_pwr_clk_disable
rcc_pwr_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_APB1ENR1]
    bic r5, #(1 << 28)
    str r5, [r4, #RCC_APB1ENR1]

    pop { r4, r5, pc }

.type   rcc_spi2_clk_enable, %function
.global rcc_spi2_clk_enable
rcc_spi2_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_APB1ENR1]
    orr r5, #(1 << 14)
    str r5, [r4, #RCC_APB1ENR1]

    pop { r4, r5, pc }

.type   rcc_spi2_clk_disable, %function
.global rcc_spi2_clk_disable
rcc_spi2_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_APB1ENR1]
    bic r5, #(1 << 14)
    str r5, [r4, #RCC_APB1ENR1]

    pop { r4, r5, pc }

.type   rcc_syscfg_clk_enable, %function
.global rcc_syscfg_clk_enable
rcc_syscfg_clk_enable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_APB2ENR]
    orr r5, #(1 << 0)
    str r5, [r4, #RCC_APB2ENR]

    pop { r4, r5, pc }

.type   rcc_syscfg_clk_disable, %function
.global rcc_syscfg_clk_disable
rcc_syscfg_clk_disable:
    push { r4, r5, lr }

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_APB2ENR]
    bic r5, #(1 << 0)
    str r5, [r4, #RCC_APB2ENR]

    pop { r4, r5, pc }

.type   rcc_rtc_enable, %function
.global rcc_rtc_enable
rcc_rtc_enable:
    push { r4, r5, lr }

    bl pwr_disable_write_protection

    ldr r4, =RCC_BASE
    ldr r5, [r4, #RCC_BDCR]
    bic r5, #(0b11 << 8)    //Clear RTCSEL
    orr r5, #(0b10 << 8)    //Set RTCSEL
    orr r5, #(1 << 15)      //Enable RTC
    str r5, [r4, #RCC_BDCR]

    bl pwr_enable_write_protection

    pop { r4, r5, pc }
