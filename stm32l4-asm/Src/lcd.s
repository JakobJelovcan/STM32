.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ LCD_BASE, 			0x40002400
.equ LCD_CR,			0x00
.equ LCD_FCR,			0x04
.equ LCD_SR,			0x08
.equ LCD_CLR,			0x0C
.equ LCD_RAM,			0x14


.equ LCD_BAR_0_2_COM,	0x18 //COM3
.equ LCD_BAR_1_3_COM,	0x10 //COM2
.equ LCD_BAR_0_SEG,		(1 << 8)
.equ LCD_BAR_1_SEG,		(1 << 8)
.equ LCD_BAR_2_SEG,		(1 << 25)
.equ LCD_BAR_3_SEG,		(1 << 25)

/**
 * @brief Initialize the lcd
 * @param None
 * @return None
*/
.type	init_lcd %function
.global	init_lcd
init_lcd:
	push { r4, r5, r6, lr }

	//Enable lcd gpio pins
	bl init_lcd_gpio

	//Wait for the capacitor on LCDV to charge (2 ms)
	ldr r0, =0x02
	bl systick_wait_ms

	//Enable lcd clock
	bl rcc_lcd_clk_enable

	//Disable lcd
	bl lcd_disable

	//Clear lcd ram
	bl lcd_clear_ram

	//Enable display update
	bl lcd_enable_update_display_request

	ldr r4, =LCD_BASE

	/*
		Prescaler: 4
		Clock divider: 1
		Blink mode: 0
		Blink frequency: 0
		Contrast control: 7
		Dead time duration: 0
		Pulse on duration: 0
		Update display done interrupt enable: 0
		Start of frame interrupt enable: 0
		High drive enable: 0
	*/
	ldr r5, =0x01041C00
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
.type	lcd_disable %function
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
.type	lcd_enable %function
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
.type	lcd_wait_off %function
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
.type	lcd_wait_fcr_sync %function
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
.type	lcd_clear_ram %function
.global	lcd_clear_ram
lcd_clear_ram:
	push { r4, r5, r6, lr }

	ldr r4, =LCD_BASE + LCD_RAM
	ldr r5, =0x00
	ldr r6, =0x0F
1:
	str r5, [r4], #4
	subs r6, #1
	bne 1b

	pop { r4, r5, r6, pc }

/**
 * @brief Change the contrast of the lcd
 * @param int
 * @return None
*/
.type	lcd_set_contrast %function
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
 * @param int
 * @return None
*/
.type	lcd_set_blink_mode %function
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
 * @param int
 * @return None
*/
.type	lcd_set_blink_frequency %function
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
 * @brief Change the blink frequency of the lcd
 * @param int
 * @return None
*/
.type	lcd_set_pulse_on_duration %function
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
 * @param int
 * @return None
*/
.type	lcd_set_dead_time_duration %function
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
 * @param int
 * @return None
*/
.type	lcd_set_high_drive %function
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
 * @param int
 * @return None
*/
.type	lcd_set_prescaler %function
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
 * @param int
 * @return None
*/
.type	lcd_set_clock_divider %function
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
 * @param int
 * @return None
*/
.type	lcd_display_bar %function
.global	lcd_display_bar
lcd_display_bar:
	push { r4, r5, r6, lr }

	bl lcd_wait_update_display_request

	and r0, #0x0F					//Mask the first 4 bits
	ldr r4, =LCD_BASE + LCD_RAM		//Base address for LCD_RAM

	//BAR 0
	tst r0, #(1 << 0)
	ITTT ne
	ldrne r5, [r4, #LCD_BAR_0_2_COM]
	orrne r5, #LCD_BAR_0_SEG
	strne r5, [r4, #LCD_BAR_0_2_COM]

	//BAR 1
	tst r0, #(1 << 1)
	ITTT ne
	ldrne r5, [r4, #LCD_BAR_1_3_COM]
	orrne r5, #LCD_BAR_1_SEG
	strne r5, [r4, #LCD_BAR_1_3_COM]

	//BAR 2
	tst r0, #(1 << 2)
	ITTT ne
	ldrne r5, [r4, #LCD_BAR_0_2_COM]
	orrne r5, #LCD_BAR_2_SEG
	strne r5, [r4, #LCD_BAR_0_2_COM]

	//BAR 3
	tst r0, #(1 << 3)
	ITTT ne
	ldrne r5, [r4, #LCD_BAR_1_3_COM]
	orrne r5, #LCD_BAR_3_SEG
	strne r5, [r4, #LCD_BAR_1_3_COM]

	pop { r4, r5, r6, pc }

/**
 * @brief Wait for update display request to finish
 * @param None
 * @return None
*/
.type	lcd_wait_update_display_request %function
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
.type	lcd_enable_update_display_request %function
.global	lcd_enable_update_display_request
lcd_enable_update_display_request:
	push { r4, r5, lr }

	ldr r4, =LCD_BASE
	ldr r5, =(1 << 2)
	str r5, [r4, #LCD_SR]

	pop { r4, r5, pc }
