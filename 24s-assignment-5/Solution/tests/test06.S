.section .data

.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global foo
.global main
foo:

bb1:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, #1
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #2
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #3
        mov     x9, #8
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #5
        str     x9, [x10]
        mov     sp, x29
        ret
main:

bb2:

        mov     x16, #2560
        sub     sp, sp, x16
        mov     x9, #18
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #0
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #0
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #1
        str     x9, [x10]
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #0
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #1
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #2
        str     x9, [x10]
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #1
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #0
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #3
        str     x9, [x10]
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #1
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #1
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #4
        str     x9, [x10]
        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     foo
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #0
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #0
        mov     x9, #16
        mul     x9, x10, x9
        add     x9, x11, x9
        ldr     x9, [x9]
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #0
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #1
        mov     x9, #16
        mul     x9, x10, x9
        add     x9, x11, x9
        ldr     x9, [x9]
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #1
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #0
        mov     x9, #16
        mul     x9, x10, x9
        add     x9, x11, x9
        ldr     x9, [x9]
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #1
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #1
        mov     x9, #16
        mul     x9, x10, x9
        add     x9, x11, x9
        ldr     x9, [x9]
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #1
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x11, x9, x10
        mov     x10, #2
        mov     x9, #256
        mul     x9, x10, x9
        add     x11, x11, x9
        mov     x10, #3
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        ldr     x9, [x9]
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #30
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
