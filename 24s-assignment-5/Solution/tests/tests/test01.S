.section .data
.global    a
.global    b
.global    c
a:
        .zero   80
b:
        .quad   27
c:
        .quad   1
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global main
main:

bb1:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #4
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w9, #0
        mov     w10, w9
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w12, w10
        b     bb2
bb2:

        mov     w10, #10
        cmp     w12, w10
        b.lt     bb3
        b     bb4
bb3:

        mov     x10, #8
        mul     x11, x12, x10
        adrp     x10, a
        add     x10, x10, #:lo12:a
        add     x10, x10, x11
        str     w12, [x10]
        add     w10, w12, #1
        mov     w12, w10
        b     bb2
bb4:

        mov     w10, #0
        mov     w11, w10
        mov     w10, w9
        mov     w9, w11
        b     bb5
bb5:

        mov     w11, #10
        cmp     w9, w11
        b.lt     bb6
        b     bb7
bb6:

        mov     x11, #8
        mul     x12, x9, x11
        adrp     x11, a
        add     x11, x11, #:lo12:a
        add     x11, x11, x12
        ldr     w11, [x11]
        add     w10, w10, w11
        add     w9, w9, #1
        mov     w10, w10
        mov     w9, w9
        b     bb5
bb7:

        adrp     x9, b
        add     x9, x9, #:lo12:b
        ldr     w9, [x9]
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adrp     x9, c
        add     x9, x9, #:lo12:c
        ldr     w9, [x9]
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w0, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #19
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
