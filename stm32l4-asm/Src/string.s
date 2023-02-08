.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.text

.type   strlen, %function
.global strlen
strlen:
    push { r4, r5, lr }

    mov r4, r0
    mov r0, #0
1:
    ldr r5, [r4], #1
    add r0, #1
    cmp r5, #0
    bne 1b

    sub r0, #1

    pop { r4, r5, pc }
