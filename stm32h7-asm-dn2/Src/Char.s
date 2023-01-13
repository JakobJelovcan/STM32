.syntax unified
.cpu cortex-m7
.thumb

.type	to_upper %function
.global to_upper

to_upper:
	push { lr }

	cmp r0, #0x61
	blo endUpper
	cmp r0, #0x7A
	bhi endUpper
	bic r0, #(1 << 5)
endUpper:

	pop { pc }

.type	to_lower %function
.global	to_lower

to_lower:
	push { lr }

	cmp r0, #0x41
	blo endLower
	cmp r0, #0x5A
	bhi endLower
	orr r0, #(1 << 5)
endLower:

	pop { pc }