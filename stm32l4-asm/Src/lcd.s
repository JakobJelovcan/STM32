.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ    GPIOA_BASE, 0x48000000
.equ    GPIOB_BASE, 0x48000400
.equ    GPIOC_BASE, 0x48000800
.equ    GPIOD_BASE, 0x48000C00
.equ    GPIOE_BASE, 0x48001000
.equ    GPIOF_BASE, 0x48001400
.equ    GPIOG_BASE, 0x48001800
.equ    GPIOH_BASE, 0x48001C00

.equ LCD_BASE, 						0x40002400
.equ LCD_CR,						0x00
.equ LCD_FCR,						0x04
.equ LCD_SR,						0x08
.equ LCD_CLR,						0x0C
.equ LCD_RAM,						0x14

.equ LCD_SEG_0,						(1 << LCD_SEG_0_SHIFT)
.equ LCD_SEG_1,						(1 << LCD_SEG_1_SHIFT)
.equ LCD_SEG_2,						(1 << LCD_SEG_2_SHIFT)
.equ LCD_SEG_3,						(1 << LCD_SEG_3_SHIFT)
.equ LCD_SEG_4,						(1 << LCD_SEG_4_SHIFT)
.equ LCD_SEG_5,						(1 << LCD_SEG_5_SHIFT)
.equ LCD_SEG_6,						(1 << LCD_SEG_6_SHIFT)
.equ LCD_SEG_7,						(1 << LCD_SEG_7_SHIFT)
.equ LCD_SEG_8,						(1 << LCD_SEG_8_SHIFT)
.equ LCD_SEG_9,						(1 << LCD_SEG_9_SHIFT)
.equ LCD_SEG_10,					(1 << LCD_SEG_10_SHIFT)
.equ LCD_SEG_11,					(1 << LCD_SEG_11_SHIFT)
.equ LCD_SEG_12,					(1 << LCD_SEG_12_SHIFT)
.equ LCD_SEG_13,					(1 << LCD_SEG_13_SHIFT)
.equ LCD_SEG_14,					(1 << LCD_SEG_14_SHIFT)
.equ LCD_SEG_15,					(1 << LCD_SEG_15_SHIFT)
.equ LCD_SEG_16,					(1 << LCD_SEG_16_SHIFT)
.equ LCD_SEG_17,					(1 << LCD_SEG_17_SHIFT)
.equ LCD_SEG_18,					(1 << LCD_SEG_18_SHIFT)
.equ LCD_SEG_19,					(1 << LCD_SEG_19_SHIFT)
.equ LCD_SEG_20,					(1 << LCD_SEG_20_SHIFT)
.equ LCD_SEG_21,					(1 << LCD_SEG_21_SHIFT)
.equ LCD_SEG_22,					(1 << LCD_SEG_22_SHIFT)
.equ LCD_SEG_23,					(1 << LCD_SEG_23_SHIFT)

.equ LCD_SEG_0_SHIFT,               4
.equ LCD_SEG_1_SHIFT,               23
.equ LCD_SEG_2_SHIFT,               6
.equ LCD_SEG_3_SHIFT,               13
.equ LCD_SEG_4_SHIFT,               15
.equ LCD_SEG_5_SHIFT,               29
.equ LCD_SEG_6_SHIFT,               31
.equ LCD_SEG_7_SHIFT,               1
.equ LCD_SEG_8_SHIFT,               3
.equ LCD_SEG_9_SHIFT,               25
.equ LCD_SEG_10_SHIFT,              17
.equ LCD_SEG_11_SHIFT,              8
.equ LCD_SEG_12_SHIFT,              9
.equ LCD_SEG_13_SHIFT,              26
.equ LCD_SEG_14_SHIFT,              24
.equ LCD_SEG_15_SHIFT,              2
.equ LCD_SEG_16_SHIFT,              0
.equ LCD_SEG_17_SHIFT,              30
.equ LCD_SEG_18_SHIFT,              28
.equ LCD_SEG_19_SHIFT,              14
.equ LCD_SEG_20_SHIFT,              12
.equ LCD_SEG_21_SHIFT,              5
.equ LCD_SEG_22_SHIFT,              22
.equ LCD_SEG_23_SHIFT,              3

.equ LCD_COM_0,						0x00
.equ LCD_COM_0_1,					0x04
.equ LCD_COM_1,						0x08
.equ LCD_COM_1_1,					0x0C
.equ LCD_COM_2,						0x10
.equ LCD_COM_2_1,					0x14
.equ LCD_COM_3,						0x18
.equ LCD_COM_3_1,					0x1C

.equ LCD_DIGIT_1_COM_0,				LCD_COM_0
.equ LCD_DIGIT_1_COM_0_SEG_MASK,	~(LCD_SEG_0 | LCD_SEG_1 | LCD_SEG_22 | LCD_SEG_23)
.equ LCD_DIGIT_1_COM_1,				LCD_COM_1
.equ LCD_DIGIT_1_COM_1_SEG_MASK,	~(LCD_SEG_0 | LCD_SEG_1 | LCD_SEG_22 | LCD_SEG_23)
.equ LCD_DIGIT_1_COM_2,				LCD_COM_2
.equ LCD_DIGIT_1_COM_2_SEG_MASK,	~(LCD_SEG_0 | LCD_SEG_1 | LCD_SEG_22 | LCD_SEG_23)
.equ LCD_DIGIT_1_COM_3,				LCD_COM_3
.equ LCD_DIGIT_1_COM_3_SEG_MASK,	~(LCD_SEG_0 | LCD_SEG_1 | LCD_SEG_22 | LCD_SEG_23)

.equ LCD_DIGIT_2_COM_0,				LCD_COM_0
.equ LCD_DIGIT_2_COM_0_SEG_MASK,	~(LCD_SEG_2 | LCD_SEG_3 | LCD_SEG_20 | LCD_SEG_21)
.equ LCD_DIGIT_2_COM_1,				LCD_COM_1
.equ LCD_DIGIT_2_COM_1_SEG_MASK,	~(LCD_SEG_2 | LCD_SEG_3 | LCD_SEG_20 | LCD_SEG_21)
.equ LCD_DIGIT_2_COM_2,				LCD_COM_2
.equ LCD_DIGIT_2_COM_2_SEG_MASK,	~(LCD_SEG_2 | LCD_SEG_3 | LCD_SEG_20 | LCD_SEG_21)
.equ LCD_DIGIT_2_COM_3,				LCD_COM_3
.equ LCD_DIGIT_2_COM_3_SEG_MASK,	~(LCD_SEG_2 | LCD_SEG_3 | LCD_SEG_20 | LCD_SEG_21)

.equ LCD_DIGIT_3_COM_0,				LCD_COM_0
.equ LCD_DIGIT_3_COM_0_SEG_MASK,	~(LCD_SEG_4 | LCD_SEG_5 | LCD_SEG_18 | LCD_SEG_19)
.equ LCD_DIGIT_3_COM_1,				LCD_COM_1
.equ LCD_DIGIT_3_COM_1_SEG_MASK,	~(LCD_SEG_4 | LCD_SEG_5 | LCD_SEG_18 | LCD_SEG_19)
.equ LCD_DIGIT_3_COM_2,				LCD_COM_2
.equ LCD_DIGIT_3_COM_2_SEG_MASK,	~(LCD_SEG_4 | LCD_SEG_5 | LCD_SEG_18 | LCD_SEG_19)
.equ LCD_DIGIT_3_COM_3,				LCD_COM_3
.equ LCD_DIGIT_3_COM_3_SEG_MASK,	~(LCD_SEG_4 | LCD_SEG_5 | LCD_SEG_18 | LCD_SEG_19)

.equ LCD_DIGIT_4_COM_0,				LCD_COM_0
.equ LCD_DIGIT_4_COM_0_SEG_MASK,    ~(LCD_SEG_6 | LCD_SEG_17)
.equ LCD_DIGIT_4_COM_0_1,			LCD_COM_0_1
.equ LCD_DIGIT_4_COM_0_1_SEG_MASK,	~(LCD_SEG_7 | LCD_SEG_16)
.equ LCD_DIGIT_4_COM_1,				LCD_COM_1
.equ LCD_DIGIT_4_COM_1_SEG_MASK,	~(LCD_SEG_6 | LCD_SEG_17)
.equ LCD_DIGIT_4_COM_1_1,			LCD_COM_1_1
.equ LCD_DIGIT_4_COM_1_1_SEG_MASK,	~(LCD_SEG_7 | LCD_SEG_16)
.equ LCD_DIGIT_4_COM_2,				LCD_COM_2
.equ LCD_DIGIT_4_COM_2_SEG_MASK,	~(LCD_SEG_6 | LCD_SEG_17)
.equ LCD_DIGIT_4_COM_2_1,			LCD_COM_2_1
.equ LCD_DIGIT_4_COM_2_1_SEG_MASK,	~(LCD_SEG_7 | LCD_SEG_16)
.equ LCD_DIGIT_4_COM_3,				LCD_COM_3
.equ LCD_DIGIT_4_COM_3_SEG_MASK,	~(LCD_SEG_6 | LCD_SEG_17)
.equ LCD_DIGIT_4_COM_3_1,			LCD_COM_3_1
.equ LCD_DIGIT_4_COM_3_1_SEG_MASK,	~(LCD_SEG_7 | LCD_SEG_16)

.equ LCD_DIGIT_5_COM_0,				LCD_COM_0
.equ LCD_DIGIT_5_COM_0_SEG_MASK,	~(LCD_SEG_9 | LCD_SEG_14)
.equ LCD_DIGIT_5_COM_0_1,			LCD_COM_0_1
.equ LCD_DIGIT_5_COM_0_1_SEG_MASK,	~(LCD_SEG_8 | LCD_SEG_15)
.equ LCD_DIGIT_5_COM_1,				LCD_COM_1
.equ LCD_DIGIT_5_COM_1_SEG_MASK,	~(LCD_SEG_9 | LCD_SEG_14)
.equ LCD_DIGIT_5_COM_1_1,			LCD_COM_1_1
.equ LCD_DIGIT_5_COM_1_1_SEG_MASK,	~(LCD_SEG_8 | LCD_SEG_15)
.equ LCD_DIGIT_5_COM_2,				LCD_COM_2
.equ LCD_DIGIT_5_COM_2_SEG_MASK,	~(LCD_SEG_9 | LCD_SEG_14)
.equ LCD_DIGIT_5_COM_2_1,			LCD_COM_2_1
.equ LCD_DIGIT_5_COM_2_1_SEG_MASK,	~(LCD_SEG_8 | LCD_SEG_15)
.equ LCD_DIGIT_5_COM_3,				LCD_COM_3
.equ LCD_DIGIT_5_COM_3_SEG_MASK,	~(LCD_SEG_9 | LCD_SEG_14)
.equ LCD_DIGIT_5_COM_3_1,			LCD_COM_3_1
.equ LCD_DIGIT_5_COM_3_1_SEG_MASK,	~(LCD_SEG_8 | LCD_SEG_15)

.equ LCD_DIGIT_6_COM_0,				LCD_COM_0
.equ LCD_DIGIT_6_COM_0_SEG_MASK,	~(LCD_SEG_10 | LCD_SEG_11 | LCD_SEG_12 | LCD_SEG_13)
.equ LCD_DIGIT_6_COM_1,				LCD_COM_1
.equ LCD_DIGIT_6_COM_1_SEG_MASK,	~(LCD_SEG_10 | LCD_SEG_11 | LCD_SEG_12 | LCD_SEG_13)
.equ LCD_DIGIT_6_COM_2,				LCD_COM_2
.equ LCD_DIGIT_6_COM_2_SEG_MASK,	~(LCD_SEG_10 | LCD_SEG_11 | LCD_SEG_12 | LCD_SEG_13)
.equ LCD_DIGIT_6_COM_3,				LCD_COM_3
.equ LCD_DIGIT_6_COM_3_SEG_MASK,	~(LCD_SEG_10 | LCD_SEG_11 | LCD_SEG_12 | LCD_SEG_13)

.equ LCD_BAR_0_2_COM,				LCD_COM_3
.equ LCD_BAR_1_3_COM,				LCD_COM_2
.equ LCD_BAR_0_SEG,					LCD_SEG_11
.equ LCD_BAR_1_SEG,					LCD_SEG_11
.equ LCD_BAR_2_SEG,					LCD_SEG_9
.equ LCD_BAR_3_SEG,					LCD_SEG_9
.equ LCD_BAR_0_2_SEG_MASK,			~(LCD_BAR_0_SEG | LCD_BAR_1_SEG)
.equ LCD_BAR_1_3_SEG_MASK,			~(LCD_BAR_1_SEG | LCD_BAR_3_SEG)

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

.equ GPIOA_PINS,                    (GPIO_PIN_6 | GPIO_PIN_7 | GPIO_PIN_8 | GPIO_PIN_9 | GPIO_PIN_10 | GPIO_PIN_15)
.equ GPIOB_PINS,                    (GPIO_PIN_0 | GPIO_PIN_1 | GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_9 | GPIO_PIN_12 | \
                                    GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15)
.equ GPIOC_PINS,                    (GPIO_PIN_3 | GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_6 | GPIO_PIN_7 | GPIO_PIN_8)
.equ GPIOD_PINS,                    (GPIO_PIN_8 | GPIO_PIN_9 | GPIO_PIN_10 | GPIO_PIN_11 | GPIO_PIN_12 | GPIO_PIN_13 | \
                                    GPIO_PIN_14 | GPIO_PIN_15)

/**
================================================================================
                              GLASS LCD MAPPING
================================================================================
LCD allows to display informations on six 14-segment digits and 4 bars:

  1       2       3       4       5       6
-----   -----   -----   -----   -----   -----
|\|/| o |\|/| o |\|/| o |\|/| o |\|/|   |\|/|   BAR3
-- --   -- --   -- --   -- --   -- --   -- --   BAR2
|/|\| o |/|\| o |/|\| o |/|\| o |/|\|   |/|\|   BAR1
----- * ----- * ----- * ----- * -----   -----   BAR0

LCD segment mapping:
--------------------
  -----A-----        _
  |\   |   /|   COL |_|
  F H  J  K B
  |  \ | /  |        _
  --G-- --M--   COL |_|
  |  / | \  |
  E Q  P  N C
  |/   |   \|        _
  -----D-----   DP  |_|

 An LCD character coding is based on the following matrix:
COM           0   1   2     3
SEG(n)      { E , D , P ,   N   }
SEG(n+1)    { M , C , COL , DP  }
SEG(23-n-1) { B , A , K ,   J   }
SEG(23-n)   { G , F , Q ,   H   }
with n positive odd number.

 The character 'A' for example is:
  -------------------------------
LSB   { 1 , 0 , 0 , 0   }
      { 1 , 1 , 0 , 0   }
      { 1 , 1 , 0 , 0   }
MSB   { 1 , 1 , 0 , 0   }
      -------------------
  'A' =  F    E   0   0 hexa

*/
.data
.type	capital_letters, %object
capital_letters:    .hword 0xFE00, 0x6714, 0x1D00, 0x4714, 0x9D00, 0x9C00, 0x3F00, 0xFA00, 0x0014, \
                           0x5300, 0x9841, 0x1900, 0x5A48, 0x5A09, 0x5F00, 0xFC00, 0x5F01, 0xFC01, \
                           0xAF00, 0x0414, 0x5B00, 0x18C0, 0x5A81, 0x00C9, 0x0058, 0x05C0
.align

.type   numbers, %object
numbers:            .hword 0x5F00, 0x4200, 0xF500, 0x6700, 0xEA00, 0xAF00, 0xBF00, 0x4600, 0xFF00, 0xEF00

.align
.text
/**
 * @brief Initialize the lcd
 * @param None
 * @return None
*/
.type	init_lcd, %function
.global	init_lcd
init_lcd:
	push { r4, r5, r6, lr }

	//Enable lcd gpio pins
    bl rcc_gpioa_clk_enable
    bl rcc_gpiob_clk_enable
    bl rcc_gpioc_clk_enable
    bl rcc_gpiod_clk_enable

    ldr r2, =0b10           //Mode
    ldr r3, =0b00           //Pullup/down
    ldr r4, =0b1011         //Alternate function
    str r4, [sp, #-4]!      //Store on stack
    ldr r4, =0b11           //Output speed
    str r4, [sp, #-4]!      //Store on stack

    //Initialize GPIO A
    ldr r0, =GPIOA_BASE
    ldr r1, =GPIOA_PINS
    bl init_gpio

    //Initialize GPIO B
    ldr r0, =GPIOB_BASE
    ldr r1, =GPIOB_PINS
    bl init_gpio

    //Initialize GPIO C
    ldr r0, =GPIOC_BASE
    ldr r1, =GPIOC_PINS
    bl init_gpio

    //Initialize GPIO D
    ldr r0, =GPIOD_BASE
    ldr r1, =GPIOD_PINS
    bl init_gpio

    add sp, #8              //Remove alternate function and output speed from the stack

	//Wait for the external capacitor (Cext) on LCDV to charge (2 ms)
	ldr r0, =0x02
	bl systick_wait_ms

	//Enable lcd clock
	bl rcc_lcd_clk_enable

	//Disable lcd
	bl lcd_disable

	//Clear lcd ram
	bl lcd_clear

	//Enable display update
	bl lcd_enable_update_display_request

	ldr r4, =LCD_BASE

	/*
		Prescaler: 4
		Clock divider: 1
		Blink mode: 0
		Blink frequency: 0
		Contrast control: 3
		Dead time duration: 0
		Pulse on duration: 0
		Update display done interrupt enable: 0
		Start of frame interrupt enable: 0
		High drive enable: 0
	*/
	ldr r5, =0x01040C00
	str r5, [r4, #LCD_FCR]

	//Wait for FCR changes to synchronize
	bl lcd_wait_fcr_sync

	/*
		Voltage output buffer enable: 0
		Mux segment enable: 0
		Bias: 2 (1/3)
		Duty: 3 (1/4)
		Voltage selector: 0 (internal)
		LCD enable: 0
	*/
	ldr r5, =0x0000004C
	str r5, [r4, #LCD_CR]

	bl lcd_enable

	pop { r4, r5, r6, pc }

/**
 * @brief Turn the lcd off
 * @param None
 * @return None
*/
.type	lcd_disable, %function
.global lcd_disable
lcd_disable:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
	ldr r5, [r4, #LCD_CR]
	bic r5, #(1 << 0)
	str r5, [r4, #LCD_CR]

	pop { r4, r5, pc }

/**
 * @brief Turn the lcd on
 * @param None
 * @return None
*/
.type	lcd_enable, %function
.global lcd_enable
lcd_enable:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
	ldr r5, [r4, #LCD_CR]
	orr r5, #(1 << 0)
	str r5, [r4, #LCD_CR]

	pop { r4, r5, pc }

/**
 * @brief Wait for the ENS bit in the LCD_SR to be 0 indicating that the lcd is off
 * @param None
 * @return None
*/
.type	lcd_wait_off, %function
.local  lcd_wait_off
lcd_wait_off:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
1:
	ldr r5, [r4, #LCD_SR]
	tst r5, #(1 << 0)
	bne 1b

	pop { r4, r5, pc }

/**
 * @brief Wait for the FCRSF bit in the LCD_SR to be 1 indicating that the LCD_FCR register has been synchronized
 * @param None
 * @return None
*/
.type	lcd_wait_fcr_sync, %function
.local  lcd_wait_fcr_sync
lcd_wait_fcr_sync:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
1:
	ldr r5, [r4, #LCD_SR]
	tst r5, #(1 << 5)
	beq 1b

	pop { r4, r5, pc }

/**
 * @brief Clear the lcd ram
 * @param None
 * @return None
*/
.type	lcd_clear, %function
.global	lcd_clear
lcd_clear:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE + LCD_RAM
	ldr r5, =0x00
	ldr r6, =0x08
1:
	str r5, [r4], #4
	subs r6, #1
	bne 1b

	pop { r4, r5, r6, pc }

/**
 * @brief Change the contrast of the lcd
 * @param Contrast
 * @return None
*/
.type	lcd_set_contrast, %function
.global	lcd_set_contrast
lcd_set_contrast:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE
	ldr r6, =0x00000007
	and r0, r6
	lsl r0, #10
	ldr r5, [r4, #LCD_FCR]
	ldr r6, =0xFFFFE3FF
	and r5, r6
	orr r5, r0
	str r5, [r4, #LCD_FCR]
	bl lcd_wait_fcr_sync

	pop { r4, r5, r6, pc }

/**
 * @brief Change the blink mode of the lcd
 * @param BlinkMode
 * @return None
*/
.type	lcd_set_blink_mode, %function
.global	lcd_set_blink_mode
lcd_set_blink_mode:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE
	ldr r6, =0x00000003
	and r0, r6
	lsl r0, #16
	ldr r5, [r4, #LCD_FCR]
	ldr r6, =0xFFFCFFFF
	and r5, r6
	orr r5, r0
	str r5, [r4, #LCD_FCR]
	bl lcd_wait_fcr_sync

	pop { r4, r5, r6, pc }

/**
 * @brief Change the blink frequency of the lcd
 * @param BlinkFrequency
 * @return None
*/
.type	lcd_set_blink_frequency, %function
.global	lcd_set_blink_frequency
lcd_set_blink_frequency:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE
	ldr r6, =0x00000007
	and r0, r6
	lsl r0, #13
	ldr r5, [r4, #LCD_FCR]
	ldr r6, =0xFFFF1FFF
	and r5, r6
	orr r5, r0
	str r5, [r4, #LCD_FCR]
	bl lcd_wait_fcr_sync

	pop { r4, r5, r6, pc }

/**
 * @brief Change the pulse duration of the lcd
 * @param PulseDuration
 * @return None
*/
.type	lcd_set_pulse_on_duration, %function
.global	lcd_set_pulse_on_duration
lcd_set_pulse_on_duration:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE
	ldr r6, =0x00000007
	and r0, r6
	lsl r0, #4
	ldr r5, [r4, #LCD_FCR]
	ldr r6, =0xFFFFFF8F
	and r5, r6
	orr r5, r0
	str r5, [r4, #LCD_FCR]
	bl lcd_wait_fcr_sync

	pop { r4, r5, r6, pc }

/**
 * @brief Change the length of dead time between frames
 * @param DeadTime
 * @return None
*/
.type	lcd_set_dead_time_duration, %function
.global	lcd_set_dead_time_duration
lcd_set_dead_time_duration:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE
	ldr r6, =0x00000007
	and r0, r6
	lsl r0, #7
	ldr r5, [r4, #LCD_FCR]
	ldr r6, =0xFFFFFC7F
	and r5, r6
	orr r5, r0
	str r5, [r4, #LCD_FCR]
	bl lcd_wait_fcr_sync

	pop { r4, r5, r6, pc }

/**
 * @brief Set high drive
 * @param HighDrive
 * @return None
*/
.type	lcd_set_high_drive, %function
.global	lcd_set_high_drive
lcd_set_high_drive:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE
	ldr r6, =0x00000001
	and r0, r6
	lsl r0, #0
	ldr r5, [r4, #LCD_FCR]
	ldr r6, =0xFFFFFFFE
	and r5, r6
	orr r5, r0
	str r5, [r4, #LCD_FCR]
	bl lcd_wait_fcr_sync

	pop { r4, r5, r6, pc }

/**
 * @brief Set prescaler
 * @param Prescaler
 * @return None
*/
.type	lcd_set_prescaler, %function
.global	lcd_set_prescaler
lcd_set_prescaler:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE
	ldr r6, =0x0000000F
	and r0, r6
	lsl r0, #22
	ldr r5, [r4, #LCD_FCR]
	ldr r6, =0xFC3FFFFF
	and r5, r6
	orr r5, r0
	str r5, [r4, #LCD_FCR]
	bl lcd_wait_fcr_sync

	pop { r4, r5, r6, pc }

/**
 * @brief Set clock divider
 * @param ClockDivider
 * @return None
*/
.type	lcd_set_clock_divider, %function
.global	lcd_set_clock_divider
lcd_set_clock_divider:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE
	ldr r6, =0x0000000F
	and r0, r6
	lsl r0, #18
	ldr r5, [r4, #LCD_FCR]
	ldr r6, =0xFFC3FFFF
	and r5, r6
	orr r5, r0
	str r5, [r4, #LCD_FCR]
	bl lcd_wait_fcr_sync

	pop { r4, r5, r6, pc }

/**
 * @brief Display a bar on the lcd
 * @param Bars
 * @return None
*/
.type	lcd_display_bar, %function
.global	lcd_display_bar
lcd_display_bar:
	push { r4, r5, r6, lr }

	bl lcd_wait_update_display_request

	and r0, #0x0F					//Mask the first 4 bits
	ldr r4, =LCD_BASE + LCD_RAM		//Base address for LCD_RAM

	//BAR 0
	tst r0, #(1 << 0)
	beq 1f
	ldr r5, [r4, #LCD_BAR_0_2_COM]
	orr r5, #LCD_BAR_0_SEG
	str r5, [r4, #LCD_BAR_0_2_COM]
1:

	//BAR 1
	tst r0, #(1 << 1)
	beq 1f
	ldr r5, [r4, #LCD_BAR_1_3_COM]
	orr r5, #LCD_BAR_1_SEG
	str r5, [r4, #LCD_BAR_1_3_COM]
1:

	//BAR 2
	tst r0, #(1 << 2)
	beq 1f
	ldr r5, [r4, #LCD_BAR_0_2_COM]
	orr r5, #LCD_BAR_2_SEG
	str r5, [r4, #LCD_BAR_0_2_COM]
1:

	//BAR 3
	tst r0, #(1 << 3)
	beq 1f
	ldr r5, [r4, #LCD_BAR_1_3_COM]
	orr r5, #LCD_BAR_3_SEG
	str r5, [r4, #LCD_BAR_1_3_COM]
1:

	pop { r4, r5, r6, pc }

/**
 * @brief Clear a bar on the lcd
 * @param Bars
 * @return None
*/
.type   lcd_clear_bar, %function
.global lcd_clear_bar
lcd_clear_bar:
    push { r4, r5, r6, lr }

    bl lcd_wait_update_display_request

    and r0, #0x0F                   //Mask the first 4 bits
    ldr r4, =LCD_BASE + LCD_RAM     //Base address for LCD_RAM

    //BAR 0
    tst r0, #(1 << 0)
    beq 1f
    ldr r5, [r4, #LCD_BAR_0_2_COM]
    bic r5, #LCD_BAR_0_SEG
    str r5, [r4, #LCD_BAR_0_2_COM]
1:

    //BAR 1
    tst r0, #(1 << 1)
    beq 1f
    ldr r5, [r4, #LCD_BAR_1_3_COM]
    bic r5, #LCD_BAR_1_SEG
    str r5, [r4, #LCD_BAR_1_3_COM]
1:

    //BAR 2
    tst r0, #(1 << 2)
    beq 1f
    ldr r5, [r4, #LCD_BAR_0_2_COM]
    bic r5, #LCD_BAR_2_SEG
    str r5, [r4, #LCD_BAR_0_2_COM]
1:

    //BAR 3
    tst r0, #(1 << 3)
    beq 1f
    ldr r5, [r4, #LCD_BAR_1_3_COM]
    bic r5, #LCD_BAR_3_SEG
    str r5, [r4, #LCD_BAR_1_3_COM]
1:

    pop { r4, r5, r6, pc }

/**
 * @brief Display character on the lcd
 * @param Position
 * @param Character
 * @return None
*/
.type   lcd_display_char, %function
.global lcd_display_char
lcd_display_char:
    push { lr }

    bl lcd_write_char
    bl lcd_enable_update_display_request

    pop { pc }

/**
 * @brief Wait for update display request to finish
 * @param None
 * @return None
*/
.type	lcd_wait_update_display_request, %function
.global	lcd_wait_update_display_request
lcd_wait_update_display_request:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
1:
	ldr r5, [r4, #LCD_SR]
	tst r5, #(1 << 2)
	bne 1b

	pop { r4, r5, pc }

/**
 * @brief Request display update
 * @param None
 * @return None
*/
.type	lcd_enable_update_display_request, %function
.global	lcd_enable_update_display_request
lcd_enable_update_display_request:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
	ldr r5, =(1 << 2)
	str r5, [r4, #LCD_SR]

	pop { r4, r5, pc }



/**
 * @brief Write character to the LCD ram
 * @param Position
 * @param Character
 * @return None
*/
.type   lcd_write_char, %function
.local  lcd_write_char
lcd_write_char:
    push { r4, r5, r6, r7, lr }

    mov r6, r0
    mov r7, r1

    mov r0, r7
    bl is_alpha
    cmp r0, #1
    bne 2f          //Character is not alpha
    mov r0, r7
    bl to_upper
    sub r0, #0x41
    ldr r4, =capital_letters
    ldrh r7, [r4, r0, lsl #1]
    b 1f

2:
    mov r0, r7
    bl is_digit
    cmp r0, #1
    bne 2f          //Character is neither alpha nor digit
    sub r0, r7, #0x30
    ldr r4, =numbers
    ldrh r7, [r4, r0, lsl #1]

1:
    ldr r4, =LCD_BASE + LCD_RAM

    //Position 1
    cmp r6, #1
    bne 1f

    //LCD_COM_0
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_1_COM_0]

    //LCD_SEG_0
    and r0, r7, #(1 << 12)
    orr r1, r1, r0, lsr #8

    //LCD_SEG_1
    and r0, r7, #(1 << 13)
    orr r1, r1, r0, lsl #10

    //LCD_SEG_22
    and r0, r7, #(1 << 14)
    orr r1, r1, r0, lsl #8

    //LCD_SEG_23
    and r0, r7, #(1 << 15)
    orr r1, r1, r0, lsr #12

    ldr r2, =LCD_DIGIT_1_COM_0_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_1_COM_0]

    //LCD_COM_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_1_COM_1]

    //LCD_SEG_0
    and r0, r7, #(1 << 8)
    orr r1, r1, r0, lsr #4

    //LCD_SEG_1
    and r0, r7, #(1 << 9)
    orr r1, r1, r0, lsl #14

    //LCD_SEG_22
    and r0, r7, #(1 << 10)
    orr r1, r1, r0, lsl #12

    //LCD_SEG_23
    and r0, r7, #(1 << 11)
    orr r1, r1, r0, lsr #8

    ldr r2, =LCD_DIGIT_1_COM_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_1_COM_1]

    //LCD_COM_2
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_1_COM_2]

    //LCD_SEG_0
    and r0, r7, #(1 << 4)
    orr r1, r1, r0

    //LCD_SEG_1
    and r0, r7, #(1 << 5)
    orr r1, r1, r0, lsl #18

    //LCD_SEG_22
    and r0, r7, #(1 << 6)
    orr r1, r1, r0, lsl #16

    //LCD_SEG_23
    and r0, r7, #(1 << 7)
    orr r1, r1, r0, lsr #4

    ldr r2, =LCD_DIGIT_1_COM_2_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_1_COM_2]

    //LCD_COM_3
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_1_COM_3]

    //LCD_SEG_0
    and r0, r7, #(1 << 0)
    orr r1, r1, r0, lsl #4

    //LCD_SEG_1
    and r0, r7, #(1 << 1)
    orr r1, r1, r0, lsl #22

    //LCD_SEG_22
    and r0, r7, #(1 << 2)
    orr r1, r1, r0, lsl #20

    //LCD_SEG_23
    and r0, r7, #(1 << 3)
    orr r1, r1, r0

    ldr r2, =LCD_DIGIT_1_COM_3_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_1_COM_3]

    b 2f
1:
    //Position 2
    cmp r6, #2
    bne 1f

    //LCD_COM_0
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_2_COM_0]

    //LCD_SEG_2
    and r0, r7, #(1 << 12)
    orr r1, r1, r0, lsr #6

    //LCD_SEG_3
    and r0, r7, #(1 << 13)
    orr r1, r1, r0

    //LCD_SEG_20
    and r0, r7, #(1 << 14)
    orr r1, r1, r0, lsr #2

    //LCD_SEG_21
    and r0, r7, #(1 << 15)
    orr r1, r1, r0, lsr #10

    ldr r2, =LCD_DIGIT_2_COM_0_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_2_COM_0]

    //LCD_COM_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_2_COM_1]

    //LCD_SEG_2
    and r0, r7, #(1 << 8)
    orr r1, r1, r0, lsr #2

    //LCD_SEG_3
    and r0, r7, #(1 << 9)
    orr r1, r1, r0, lsl #4

    //LCD_SEG_20
    and r0, r7, #(1 << 10)
    orr r1, r1, r0, lsl #2

    //LCD_SEG_21
    and r0, r7, #(1 << 11)
    orr r1, r1, r0, lsr #6

    ldr r2, =LCD_DIGIT_2_COM_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_2_COM_1]

    //LCD_COM_2
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_2_COM_2]

    //LCD_SEG_2
    and r0, r7, #(1 << 4)
    orr r1, r1, r0, lsl #2

    //LCD_SEG_3
    and r0, r7, #(1 << 5)
    orr r1, r1, r0, lsl #8

    //LCD_SEG_20
    and r0, r7, #(1 << 6)
    orr r1, r1, r0, lsl #6

    //LCD_SEG_21
    and r0, r7, #(1 << 7)
    orr r1, r1, r0, lsr #2

    ldr r2, =LCD_DIGIT_2_COM_2_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_2_COM_2]

    //LCD_COM_3
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_2_COM_3]

    //LCD_SEG_2
    and r0, r7, #(1 << 0)
    orr r1, r1, r0, lsl #6

    //LCD_SEG_3
    and r0, r7, #(1 << 1)
    orr r1, r1, r0, lsl #12

    //LCD_SEG_20
    and r0, r7, #(1 << 2)
    orr r1, r1, r0, lsl #10

    //LCD_SEG_21
    and r0, r7, #(1 << 3)
    orr r1, r1, r0, lsl #2

    ldr r2, =LCD_DIGIT_2_COM_3_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_2_COM_3]

    b 2f
1:
    //Position 3
    cmp r6, #3
    bne 1f

    //LCD_COM_0
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_3_COM_0]

    //LCD_SEG_4
    and r0, r7, #(1 << 12)
    orr r1, r1, r0, lsl #3

    //LCD_SEG_5
    and r0, r7, #(1 << 13)
    orr r1, r1, r0, lsl #16

    //LCD_SEG_18
    and r0, r7, #(1 << 14)
    orr r1, r1, r0, lsl #14

    //LCD_SEG_19
    and r0, r7, #(1 << 15)
    orr r1, r1, r0, lsr #1

    ldr r2, =LCD_DIGIT_3_COM_0_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_3_COM_0]

    //LCD_COM_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_3_COM_1]

    //LCD_SEG_4
    and r0, r7, #(1 << 8)
    orr r1, r1, r0, lsl #7

    //LCD_SEG_5
    and r0, r7, #(1 << 9)
    orr r1, r1, r0, lsl #20

    //LCD_SEG_18
    and r0, r7, #(1 << 10)
    orr r1, r1, r0, lsl #18

    //LCD_SEG_19
    and r0, r7, #(1 << 11)
    orr r1, r1, r0, lsl #3

    ldr r2, =LCD_DIGIT_3_COM_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_3_COM_1]

    //LCD_COM_2
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_3_COM_2]

    //LCD_SEG_4
    and r0, r7, #(1 << 4)
    orr r1, r1, r0, lsl #11

    //LCD_SEG_5
    and r0, r7, #(1 << 5)
    orr r1, r1, r0, lsl #24

    //LCD_SEG_18
    and r0, r7, #(1 << 6)
    orr r1, r1, r0, lsl #22

    //LCD_SEG_19
    and r0, r7, #(1 << 7)
    orr r1, r1, r0, lsl #7

    ldr r2, =LCD_DIGIT_3_COM_2_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_3_COM_2]

    //LCD_COM_3
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_3_COM_3]

    //LCD_SEG_4
    and r0, r7, #(1 << 0)
    orr r1, r1, r0, lsl #15

    //LCD_SEG_5
    and r0, r7, #(1 << 1)
    orr r1, r1, r0, lsl #28

    //LCD_SEG_18
    and r0, r7, #(1 << 2)
    orr r1, r1, r0, lsl #26

    //LCD_SEG_19
    and r0, r7, #(1 << 3)
    orr r1, r1, r0, lsl #11

    ldr r2, =LCD_DIGIT_3_COM_3_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_3_COM_3]

    b 2f
1:
    //Position 4
    cmp r6, #4
    bne 1f

    //LCD_COM_0
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_4_COM_0]

    //LCD_SEG_6
    and r0, r7, #(1 << 12)
    orr r1, r1, r0, lsl #19

    //LCD_SEG_17
    and r0, r7, #(1 << 15)
    orr r1, r1, r0, lsl #15

    ldr r2, =LCD_DIGIT_4_COM_0_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_4_COM_0]

    //LCD_COM_0_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_4_COM_0_1]

    //LCD_SEG_7
    and r0, r7, #(1 << 13)
    orr r1, r1, r0, lsr #12

    //LCD_SEG_16
    and r0, r7, #(1 << 14)
    orr r1, r1, r0, lsr #14

    ldr r2, =LCD_DIGIT_4_COM_0_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_4_COM_0_1]

    //LCD_COM_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_4_COM_1]

    //LCD_SEG_6
    and r0, r7, #(1 << 8)
    orr r1, r1, r0, lsl #23

    //LCD_SEG_17
    and r0, r7, #(1 << 11)
    orr r1, r1, r0, lsl #19

    ldr r2, =LCD_DIGIT_4_COM_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_4_COM_1]

    //LCD_COM_1_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_4_COM_1_1]

    //LCD_SEG_7
    and r0, r7, #(1 << 9)
    orr r1, r1, r0, lsr #8

    //LCD_SEG_16
    and r0, r7, #(1 << 10)
    orr r1, r1, r0, lsr #10

    ldr r2, =LCD_DIGIT_4_COM_1_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_4_COM_1_1]

    //LCD_COM_2
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_4_COM_2]

    //LCD_SEG_6
    and r0, r7, #(1 << 4)
    orr r1, r1, r0, lsl #27

    //LCD_SEG_17
    and r0, r7, #(1 << 7)
    orr r1, r1, r0, lsl #23

    ldr r2, =LCD_DIGIT_4_COM_2_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_4_COM_2]

    //LCD_COM_2_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_4_COM_2_1]

    //LCD_SEG_7
    and r0, r7, #(1 << 5)
    orr r1, r1, r0, lsr #4

    //LCD_SEG_16
    and r0, r7, #(1 << 6)
    orr r1, r1, r0, lsr #6

    ldr r2, =LCD_DIGIT_4_COM_2_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_4_COM_2_1]

    //LCD_COM_3
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_4_COM_3]

    //LCD_SEG_6
    and r0, r7, #(1 << 0)
    orr r1, r1, r0, lsl #31

    //LCD_SEG_17
    and r0, r7, #(1 << 3)
    orr r1, r1, r0, lsl #27

    ldr r2, =LCD_DIGIT_4_COM_3_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_4_COM_3]

    //LCD_COM_3_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_4_COM_3_1]

    //LCD_SEG_7
    and r0, r7, #(1 << 1)
    orr r1, r1, r0

    //LCD_SEG_16
    and r0, r7, #(1 << 2)
    orr r1, r1, r0, lsr #2

    ldr r2, =LCD_DIGIT_4_COM_3_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_4_COM_3_1]

    b 2f
1:
    //Position 5
    cmp r6, #5
    bne 1f

    //LCD_COM_0
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_5_COM_0]

    //LCD_SEG_9
    and r0, r7, #(1 << 13)
    orr r1, r1, r0, lsl #12

    //LCD_SEG_14
    and r0, r7, #(1 << 14)
    orr r1, r1, r0, lsl #10

    ldr r2, =LCD_DIGIT_5_COM_0_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_5_COM_0]

    //LCD_COM_0_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_5_COM_0_1]

    //LCD_SEG_8
    and r0, r7, #(1 << 12)
    orr r1, r1, r0, lsr #9

    //LCD_SEG_15
    and r0, r7, #(1 << 15)
    orr r1, r1, r0, lsr #13

    ldr r2, =LCD_DIGIT_5_COM_0_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_5_COM_0_1]

    //LCD_COM_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_5_COM_1]

    //LCD_SEG_9
    and r0, r7, #(1 << 9)
    orr r1, r1, r0, lsl #16

    //LCD_SEG_14
    and r0, r7, #(1 << 10)
    orr r1, r1, r0, lsl #14

    ldr r2, =LCD_DIGIT_5_COM_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_5_COM_1]

    //LCD_COM_1_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_5_COM_1_1]

    //LCD_SEG_8
    and r0, r7, #(1 << 8)
    orr r1, r1, r0, lsr #5

    //LCD_SEG_15
    and r0, r7, #(1 << 11)
    orr r1, r1, r0, lsr #9

    ldr r2, =LCD_DIGIT_5_COM_1_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_5_COM_1_1]

    //LCD_COM_2
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_5_COM_2]

    //LCD_SEG_9
    and r0, r7, #(1 << 5)
    orr r1, r1, r0, lsl #20

    //LCD_SEG_14
    and r0, r7, #(1 << 6)
    orr r1, r1, r0, lsl #18

    ldr r2, =LCD_DIGIT_5_COM_2_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_5_COM_2]

    //LCD_COM_2_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_5_COM_2_1]

    //LCD_SEG_8
    and r0, r7, #(1 << 4)
    orr r1, r1, r0, lsr #1

    //LCD_SEG_15
    and r0, r7, #(1 << 7)
    orr r1, r1, r0, lsr #5

    ldr r2, =LCD_DIGIT_5_COM_2_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_5_COM_2_1]

    //LCD_COM_3
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_5_COM_3]

    //LCD_SEG_9
    and r0, r7, #(1 << 1)
    orr r1, r1, r0, lsl #24

    //LCD_SEG_14
    and r0, r7, #(1 << 2)
    orr r1, r1, r0, lsl #22

    ldr r2, =LCD_DIGIT_5_COM_3_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_5_COM_3]

    //LCD_COM_3_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_5_COM_3_1]

    //LCD_SEG_8
    and r0, r7, #(1 << 0)
    orr r1, r1, r0, lsl #3

    //LCD_SEG_15
    and r0, r7, #(1 << 3)
    orr r1, r1, r0, lsr #1

    ldr r2, =LCD_DIGIT_5_COM_3_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_5_COM_3_1]

    b 2f
1:
    //Position 6
    cmp r6, #6
    bne 2f

    //LCD_COM_0
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_6_COM_0]

    //LCD_SEG_10
    and r0, r7, #(1 << 12)
    orr r1, r1, r0, lsl #5

    //LCD_SEG_11
    and r0, r7, #(1 << 13)
    orr r1, r1, r0, lsr #5

    //LCD_SEG_12
    and r0, r7, #(1 << 14)
    orr r1, r1, r0, lsr #5

    //LCD_SEG_13
    and r0, r7, #(1 << 15)
    orr r1, r1, r0, lsl #11

    ldr r2, =LCD_DIGIT_6_COM_0_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_6_COM_0]

    //LCD_COM_1
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_6_COM_1]

    //LCD_SEG_10
    and r0, r7, #(1 << 8)
    orr r1, r1, r0, lsl #9

    //LCD_SEG_11
    and r0, r7, #(1 << 9)
    orr r1, r1, r0, lsr #1

    //LCD_SEG_12
    and r0, r7, #(1 << 10)
    orr r1, r1, r0, lsr #1

    //LCD_SEG_13
    and r0, r7, #(1 << 11)
    orr r1, r1, r0, lsl #15

    ldr r2, =LCD_DIGIT_6_COM_1_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_6_COM_1]

    //LCD_COM_2
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_6_COM_2]

    //LCD_SEG_10
    and r0, r7, #(1 << 4)
    orr r1, r1, r0, lsl #13

    //LCD_SEG_11
    and r0, r7, #(1 << 5)
    orr r1, r1, r0, lsl #3

    //LCD_SEG_12
    and r0, r7, #(1 << 6)
    orr r1, r1, r0, lsl #3

    //LCD_SEG_13
    and r0, r7, #(1 << 7)
    orr r1, r1, r0, lsl #19

    ldr r2, =LCD_DIGIT_6_COM_2_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_6_COM_2]

    //LCD_COM_3
    ldr r1, =0x00
    ldr r5, [r4, #LCD_DIGIT_6_COM_3]

    //LCD_SEG_10
    and r0, r7, #(1 << 0)
    orr r1, r1, r0, lsl #17

    //LCD_SEG_11
    and r0, r7, #(1 << 1)
    orr r1, r1, r0, lsl #7

    //LCD_SEG_12
    and r0, r7, #(1 << 2)
    orr r1, r1, r0, lsl #7

    //LCD_SEG_13
    and r0, r7, #(1 << 3)
    orr r1, r1, r0, lsl #23

    ldr r2, =LCD_DIGIT_6_COM_3_SEG_MASK
    and r5, r2
    orr r5, r1
    str r5, [r4, #LCD_DIGIT_6_COM_3]

2:
    pop { r4, r5, r6, r7, pc }
