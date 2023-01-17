.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.equ	STK_BASE,	0xE000E010
.equ	STK_CTRL,	0x00
.equ	STK_LOAD,	0x04
.equ	STK_VAL,	0x08
.equ	STK_CALIB,	0x0C


/**
 * @brief Initialize SysTick
 * @param None
 * @return None
*/
.type	init_systick %function
.global	init_systick
init_systick:
	push { r4, r5, lr }

	ldr r5, =(1 << 2)			//Set clock source to AHB
	str r5, [r4, #STK_CTRL]

	pop { r4, r5, pc }

/**
 * @brief Get SysTick count flag
 * @param None
 * @return None
*/
.type	get_systick_countflag %function
.global	get_systick_countflag
get_systick_countflag:
	push { r4, r5, lr }

	ldr r0, [r4, #STK_CTRL]
	ldr r5, =(1 << 16)
	and r0, r5
	lsr r0, #16

	pop { r4, r5, pc }

/**
 * @brief Enable SysTick
 * @param None
 * @return None
*/
.type	systick_enable %function
.global	systick_enable
systick_enable:
	push { r4, r5, lr }

	ldr r4, =STK_BASE
	ldr r5, [r4, #STK_CTRL]
	orr r5, #(1 << 0)
	str r5, [r4, #STK_CTRL]

	pop { r4, r5, pc }

/**
 * @brief Disable SysTick
 * @param None
 * @return None
*/
.type	systick_disable %function
.global	systick_disable
systick_disable:
	push { r4, r5, lr }

	ldr r4, =STK_BASE
	ldr r5, [r4, #STK_CTRL]
	bic r5, #(1 << 0)
	ldr r5, [r4, #STK_CTRL]

	pop { r4, r5, pc }

/**
 * @brief Set SysTick reload value
 * @param int
 * @return None
*/
.type	systick_set_reload_value %function
.global	systick_set_reload_value
systick_set_reload_value:
	push { r4, lr }

	ldr r4, =STK_BASE
	str r0, [r4, #STK_LOAD]

	pop { r4, pc }

/**
 * @brief Set SysTick current value
 * @param int
 * @return None
*/
.type	systick_set_current_value %function
.global	systick_set_current_value
systick_set_current_value:
	push { r4, lr }

	ldr r4, =STK_BASE
	str r0, [r4, #STK_VAL]

	pop { r4, pc }

/**
 * @brief Clear SysTick current value
 * @param None
 * @return None
*/
.type	systick_clear_current_value %function
.global	systick_clear_current_value
systick_clear_current_value:
	push { r4, r5, lr }

	ldr r4, =STK_BASE
	ldr r5, =0x00
	str r5, [r4, #STK_VAL]

	pop { r4, r5, pc }

/**
 * @brief Wait for x milliseconds
 * @param int
 * @return None
*/
.type	systick_wait_ms %function
.global	systick_wait_ms
systick_wait_ms:
	push { r4, r5, lr }

	mov r5, r0
	ldr r0, =0x0F9F
	ldr r4, =STK_BASE
	bl systick_set_reload_value
	bl systick_clear_current_value
	bl init_systick
	bl systick_enable
1:
	ldr r0, [r4, #STK_CTRL]
	tst r0, #(1 << 16)
	beq 1b
	subs r5, #1
	bne 1b

	bl systick_disable
	pop { r4, r5, pc }
