.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.text

/**
 * @brief Converts upper case letters to lower case
 * @param Character
 * @return Character
*/
.type   to_lower, %function
.global to_lower
to_lower:
    push { lr }

    cmp r0, #0x41
    blo 1f
    cmp r0, #0x5A
    bhi 1f
    orr r0, #(1 << 5)
1:
    pop { pc }

/**
 * @brief Converts lower case letters to upper case
 * @param Character
 * @return Character
*/
.type   to_upper, %function
.global to_upper
to_upper:
    push { lr }

    cmp r0, #0x61
    blo 1f
    cmp r0, #0x7A
    bhi 1f
    bic r0, #(1 << 5)
1:
    pop { pc }

/**
 * @brief Checks if the character is upper case
 * @param Character
 * @return 0 if false else 1
*/
.type   is_upper, %function
.global is_upper
is_upper:
    push { lr }

    cmp r0, #0x41
    blo 1f
    cmp r0, #0x5A
    bhi 1f
    ldr r0, =0x01
    b 2f
1:
    ldr r0, =0x00
2:
    pop { pc }

/**
 * @brief Checks if the character is lower case
 * @param Character
 * @return 0 if false else 1
*/
.type   is_lower, %function
.global is_lower
is_lower:
    push { lr }

    cmp r0, #0x61
    blo 1f
    cmp r0, #0x7A
    bhi 1f
    ldr r0, =0x01
    b 2f
1:
    ldr r0, =0x00
2:
    pop { pc }

/**
 * @brief Checks if the character is digit
 * @param Character
 * @return 0 if false else 1
*/
.type   is_digit, %function
.global is_digit
is_digit:
    push { lr }

    cmp r0, #0x30
    blo 1f
    cmp r0, #0x39
    bhi 1f
    ldr r0, =0x01
    b 2f
1:
    ldr r0, =0x00
2:

    pop { pc }

/**
 * @brief Checks if the character is upper case, lower case or digit
 * @param Character
 * @return 0 if false else 1
*/
.type   is_alnum, %function
.global is_alnum
is_alnum:
    push { lr }

    cmp r0, #0x30
    blo 1f
    cmp r0, #0x39
    bls 2f

    cmp r0, #0x41
    blo 1f
    cmp r0, #0x5A
    bls 2f

    cmp r0, #0x61
    blo 1f
    cmp r0, #0x7A
    bls 2f
1:
    ldr r0, =0x00
    b 3f
2:
    ldr r0, =0x01
3:
    pop { pc }

/**
 * @brief Checks if the character is upper case, lower case
 * @param Character
 * @return 0 if false else 1
*/
.type   is_alpha, %function
.global is_alpha
is_alpha:
    push { lr }

    cmp r0, #0x41
    blo 1f
    cmp r0, #0x5A
    bls 2f

    cmp r0, #0x61
    blo 1f
    cmp r0, #0x7A
    bls 2f
1:
    ldr r0, =0x00
    b 3f
2:
    ldr r0, =0x01
3:
    pop { pc }
