/*
 * nvic.s
 *
 *  Created on: Mar 26, 2023
 *      Author: Jakob
 */
.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb


.equ    NVIC_RESET,             		0x00000004
.equ    NVIC_NMI,               		0x00000008
.equ    NVIC_HARD_FAULT,        		0x0000000C
.equ    NVIC_MEM_MANAGE,        		0x00000010
.equ    NVIC_BUS_FAULT,         		0x00000014
.equ    NVIC_USAGE_FAULT,       		0x00000018
.equ    NVIC_SV_CALL,           		0x0000002C
.equ    NVIC_DEBUG,             		0x00000030
.equ    NVIC_PEND_SV,           		0x00000038
.equ    NVIC_SYS_TICK,          		0x0000003C
.equ    NVIC_WWDG,              		0x00000040
.equ    NVIC_PVD_PVM,           		0x00000044
.equ    NVIC_RTC_TAMP_STAMP,    		0x00000048
.equ    NVIC_RTC_WKUP,                  0x0000004C
.equ    NVIC_FLASH,             		0x00000050
.equ    NVIC_RCC,               		0x00000054
.equ    NVIC_EXTI0,             		0x00000058
.equ    NVIC_EXTI1,             		0x0000005C
.equ    NVIC_EXTI2,             		0x00000060
.equ    NVIC_EXTI3,             		0x00000064
.equ    NVIC_EXTI4,             		0x00000068
.equ    NVIC_DMA_CH1,           		0x0000006C
.equ    NVIC_DMA_CH2,           		0x00000070
.equ    NVIC_DMA_CH3,           		0x00000074
.equ    NVIC_DMA_CH4,                   0x00000078
.equ    NVIC_DMA_CH5,           		0x0000007C
.equ    NVIC_DMA_CH6,           		0x00000080
.equ    NVIC_DMA_CH7,           		0x00000084
.equ    NVIC_ADC1_2,            		0x00000088
.equ    NVIC_CAN1_TX,           		0x0000008C
.equ    NVIC_CAN1_RX0,          		0x00000090
.equ    NVIC_CAN1_TX1,          		0x00000094
.equ    NVIC_CAN1_SCE,         	 		0x00000098
.equ    NVIC_EXTI_9_5,          		0x0000009C
.equ    NVIC_TIM1_BRK_TIM15,    		0x000000A0
.equ    NVIC_TIM1_UP_TIM16,     		0x000000A4
.equ    NVIC_TIM1_TRG_COM_TIM17,		0x000000A8
.equ    NVIC_TIM1_CC,               	0x000000AC
.equ    NVIC_TIM2,                  	0x000000B0
.equ    NVIC_TIM3,                  	0x000000B4
.equ    NVIC_TIM4,                  	0x000000B8
.equ    NVIC_I2C1_EV,               	0x000000BC
.equ    NVIC_I2C1_ER,               	0x000000C0
.equ    NVIC_I2C2_EV,               	0x000000C4
.equ    NVIC_I2C2_ER,               	0x000000C8
.equ    NVIC_SPI1,                  	0x000000CC
.equ    NVIC_SPI2,                  	0x000000D0
.equ    NVIC_USART1,                	0x000000D4
.equ    NVIC_USART2,                	0x000000D8
.equ    NVIC_USART3,                	0x000000DC
.equ    NVIC_EXTI_15_10,            	0x000000E0
.equ    NVIC_RTC_ALARM,             	0x000000E4
.equ    NVIC_DFSDM1_FLT3,           	0x000000E8
.equ    NVIC_TIM8_BRK,              	0x000000EC
.equ    NVIC_TIM8_UP,               	0x000000F0
.equ    NVIC_TIM8_TRG_COM,          	0x000000F4
.equ    NVIC_TIM8_OC,               	0x000000F8
.equ    NVIC_ADC3,                  	0x000000FC
.equ    NVIC_FMC,                   	0x00000100
.equ    NVIC_SDMMC1,                	0x00000104
.equ    NVIC_TIM5,                  	0x00000108
.equ    NVIC_SPI3,                  	0x0000010C
.equ    NVIC_UART4,                 	0x00000110
.equ    NVIC_UART5,                 	0x00000114
.equ    NVIC_TIM6_DACUNDER,         	0x00000118
.equ    NVIC_TIM7,                  	0x0000011C
.equ    NVIC_DMA2_CH1,              	0x00000120
.equ    NVIC_DMA2_CH2,              	0x00000124
.equ    NVIC_DMA2_CH3,              	0x00000128
.equ    NVIC_DMA2_CH4,              	0x0000012C
.equ    NVIC_DMA2_CH5,              	0x00000130
.equ    NVIC_DFSDM1_FLT0,           	0x00000134
.equ    NVIC_DFSDM1_FLT1,           	0x00000138
.equ    NVIC_DFSDM1_FLT2,           	0x0000013C
.equ    NVIC_COMP,                  	0x00000140
.equ    NVIC_LPTIM1,                	0x00000144
.equ    NVIC_LPTIM2,                	0x00000148
.equ    NVIC_OTG_FS,                	0x0000014C
.equ    NVIC_DMA2_CH6,              	0x00000150
.equ    NVIC_DMA2_CH7,              	0x00000154
.equ    NVIC_LPUART1,               	0x00000158
.equ    NVIC_QUADSP,                	0x0000015C
.equ    NVIC_I2C3_EV,               	0x00000160
.equ    NVIC_I2C3_ER,               	0x00000164
.equ    NVIC_SAI1,                  	0x00000168
.equ    NVIC_SAI2,                  	0x0000016C
.equ    NVIC_SWPMI1,                	0x00000170
.equ    NVIC_TSC,                   	0x00000174
.equ    NVIC_LCD,                   	0x00000178
.equ    NVIC_AES,                   	0x0000017C
.equ    NVIC_RNG_HASH,              	0x00000180
.equ    NVIC_FPU,                   	0x00000184
.equ    NVIC_HASH_CRS,              	0x00000188
.equ    NVIC_I2C4_EV,               	0x0000018C
.equ    NVIC_I2C4_ER,               	0x00000190
.equ    NVIC_DCIM,                  	0x00000194
.equ    NVIC_CAN2_TX,               	0x00000198
.equ    NVIC_CAN2_RX0,              	0x0000019C
.equ    NVIC_CAN2_RX1,              	0x000001A0
.equ    NVIC_CAN2_SCE,              	0x000001A4
.equ    NVIC_DMA2D,                 	0x000001A8

.equ    NVIC_BASE,                  	0xE000E100
.equ    NVIC_ISER0,                 	0x00
.equ    NVIC_ICER0,                 	0x80
.equ    NVIC_ISPR0,                 	0x100
.equ    NVIC_ICPR0,                 	0x180
.equ    NVIC_IABR0,                 	0x200
.equ    NVIC_IPR0,                  	0x300
.equ    NVIC_STIR,                  	0xE00

.equ    NVIC_PRIO_BITS,             	0x03

.equ    SCB_BASE,                       0xE000ED00
.equ    SCB_CPUID,                      0x00
.equ    SCB_ICSR,                       0x04
.equ    SCB_VTOR,                       0x08
.equ    SCB_AIRCR,                      0x0C
.equ    SCB_SCR,                        0x10
.equ    SCB_CCR,                        0x14
.equ    SCB_SHPR1,                      0x18
.equ    SCB_SHPR2,                      0x1C
.equ    SCB_SHPR3,                      0x20
.equ    SCB_SHCSR,                      0x24
.equ    SCB_CFSR,                       0x28
.equ    SCB_MMSR,                       0x2C
.equ    SCB_BFSR,                       0x30
.equ    SCB_UFSR,                       0x34
.equ    SCB_HFSR,                       0x38
.equ    SCB_MMAR,                       0x3C
.equ    SCB_BFAR,                       0x40
.equ    SCB_AFSR,                       0x44
.equ    SCB_AIRCR_PRIGROUP_POSITION,	0x08
.equ    SCB_AIRCR_PRIGROUP_MASK,    	0x07 << SCB_AIRCR_PRIGROUP_POSITION

/**
 * @param Priority group
 * @param Preempt priority
 * @param Sub priority
*/
.type   nvic_encode_priority, %function
.local  nvic_encode_priority
nvic_encode_priority:
    push { r4, r5, r6, lr }

    and r0, #0x07

    rsb r6, r0, #0x07
    cmp r6, #NVIC_PRIO_BITS
    ITE hi
    movhi r4, #NVIC_PRIO_BITS
    movls r4, r6

    add r6, r0, #NVIC_PRIO_BITS
    cmp r6, #0x07
    ITE lo
    movlo r5, #0x00
    movhs r5, r6

    ldr r6, =0x01
    lsl r6, r4
    sub r6, #0x01
    and r1, r6
    lsl r1, r5

    ldr r6, =0x01
    lsl r6, r5
    sub r6, #0x01
    and r2, r6

    orr r0, r1, r2

    pop { r4, r5, r6, pc }
/**
 * @param IRQ number
 * @param Preempt priority
 * @param Sub priority
*/
.type   nvic_set_priority, %function
.local  nvic_set_priority
nvic_set_priority:
    push { r4, r5, r6, r7, lr }

    mov r4, r0      //IRQn

    bl scb_read_priority_group
    bl nvic_encode_priority

    ldr r5, =NVIC_PRIO_BITS
    rsb r5, #0x08
    lsl r0, r5
    and r0, #0xFF

    cmp r4, #0x00
    blt 2f
    ldr r5, =NVIC_BASE
    strb r0, [r5, r4]
    b 3f
2:
    ldr r5, =SCB_BASE
    and r4, #0x0F
    sub r4, #0x04
    strb r0, [r5, r4]
3:

    pop { r4, r5, r6, r7, pc }

.type   nvic_enable_irq, %function
.global nvic_enable_irq
nvic_enable_irq:
    push { r4, r5, r6, r7, lr }

    lsr r6, r0, #0x05
    and r6, #0x07
    ldr r4, =NVIC_BASE + NVIC_ISER0
    ldr r5, [r4, r6]
    and r0, #0x1F
    ldr r7, =0x01
    lsl r7, r0
    orr r5, r7
    str r5, [r4, r6]

    pop { r4, r5, r6, r7, pc }

.type   nvic_disable_irq, %function
.global nvic_disable_irq
nvic_disable_irq:
    push { r4, r5, r6, r7, lr }

    lsr r6, r0, #0x05
    and r6, #0x07
    ldr r4, =NVIC_BASE + NVIC_ISER0
    ldr r5, [r4, r6]
    and r0, #0x1F
    ldr r7, =0x01
    lsl r7, r0
    bic r5, r7
    str r5, [r4, r6]

    pop { r4, r5, r6, r7, pc }
