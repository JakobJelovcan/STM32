.syntax unified
.cpu cortex-m4
.fpu vfpv4
.thumb

.equ    FPU_BASE,   0xE000ED88
.equ    CPACR,      0x00
.equ    FPCCR,      0x04
.equ    FPCAR,      0x08
.equ    FPDSCR,     0x0C

.text

.type   fpu_enable, %function
.global fpu_enable
fpu_enable:
    push { r4, r5, lr }

    ldr r4, =FPU_BASE

    ldr r5, [r4, #CPACR]
    orr r5, #(0b1111 << 20)
    str r5, [r4, #CPACR]

    dsb
    isb

    pop { r4, r5, pc }

.type   fpu_disable, %function
.global fpu_disable
fpu_disable:
    push { r4, r5, lr }

    ldr r4, =FPU_BASE
    ldr r5, [r4, #CPACR]
    bic r5, #(0b1111 << 20)
    str r5, [r4, #CPACR]

    dsb
    isb

    pop { r4, r5, pc }
