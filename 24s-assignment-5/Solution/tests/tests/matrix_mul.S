.section .data
.global    M
.global    L
.global    N
M:
        .quad   0
L:
        .quad   0
N:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global mul
.global main
mul:

bb1:

        mov     x16, #48
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x16, x1
        mov     x17, #8
        str     x16, [sp,x17]
        mov     x16, x2
        mov     x17, #16
        str     x16, [sp,x17]
        mov     x16, x3
        mov     x17, #24
        str     x16, [sp,x17]
        mov     x16, x4
        mov     x17, #32
        str     x16, [sp,x17]
        mov     x16, x5
        mov     x17, #40
        str     x16, [sp,x17]
        mov     x15, x6
        mov     x14, x7
        ldr     x9, [x29]
        mov     x13, x9
        mov     w9, #0
        mov     w9, #0
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w12, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w11, w12, w9
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x15, x9
        str     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w12, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w11, w12, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x15, x9
        str     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w12, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w11, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x15, x9
        str     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w12, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w11, w12, w9
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        str     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w12, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w11, w12, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        str     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w12, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w11, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        str     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w12, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w11, w12, w9
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        str     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w12, w12, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w11, w12, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        str     w11, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w12, w11, w9
        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mul     w9, w11, w9
        add     w10, w12, w9
        mov     x11, #2
        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        mov     x12, #2
        mov     x11, #8
        mul     x11, x12, x11
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x11, x19, x11
        ldr     w11, [x11]
        mul     w9, w9, w11
        add     w11, w10, w9
        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        str     w11, [x9]
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb2:

        mov     x16, #240
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #97
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
        mov     w10, #3
        adrp     x9, N
        add     x9, x9, #:lo12:N
        str     w10, [x9]
        mov     w10, #3
        adrp     x9, M
        add     x9, x9, #:lo12:M
        str     w10, [x9]
        mov     w10, #3
        adrp     x9, L
        add     x9, x9, #:lo12:L
        str     w10, [x9]
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb3
bb3:

        adrp     x10, M
        add     x10, x10, #:lo12:M
        ldr     w10, [x10]
        cmp     w9, w10
        b.lt     bb4
        b     bb5
bb4:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-24
        add     x10, x29, x10
        add     x10, x10, x11
        str     w9, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-48
        add     x10, x29, x10
        add     x10, x10, x11
        str     w9, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-72
        add     x10, x29, x10
        add     x10, x10, x11
        str     w9, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-96
        add     x10, x29, x10
        add     x10, x10, x11
        str     w9, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-120
        add     x10, x29, x10
        add     x10, x10, x11
        str     w9, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-144
        add     x10, x29, x10
        add     x10, x10, x11
        str     w9, [x10]
        add     w9, w9, #1
        mov     w9, w9
        b     bb3
bb5:

        mov     x9, #-24
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-48
        add     x9, x29, x9
        mov     x1, x9
        mov     x9, #-72
        add     x9, x29, x9
        mov     x2, x9
        mov     x9, #-96
        add     x9, x29, x9
        mov     x3, x9
        mov     x9, #-120
        add     x9, x29, x9
        mov     x4, x9
        mov     x9, #-144
        add     x9, x29, x9
        mov     x5, x9
        mov     x9, #-192
        add     x9, x29, x9
        mov     x6, x9
        mov     x9, #-216
        add     x9, x29, x9
        mov     x7, x9
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        mov     x9, #-240
        add     x9, x29, x9
        str     x9, [sp,#-80]
        sub     sp, sp, #80
        mov     x29, sp
        bl     mul
        add     sp, sp, #8
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w9, w9
        b     bb6
bb6:

        adrp     x10, N
        add     x10, x10, #:lo12:N
        ldr     w10, [x10]
        cmp     w9, w10
        b.lt     bb7
        b     bb8
bb7:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-192
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     w10, [x10]
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb6
bb8:

        mov     w9, #10
        mov     w10, w9
        mov     w9, #0
        mov     w9, w9
        mov     w0, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w9
        b     bb9
bb9:

        adrp     x10, N
        add     x10, x10, #:lo12:N
        ldr     w10, [x10]
        cmp     w9, w10
        b.lt     bb10
        b     bb11
bb10:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-216
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     w10, [x10]
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb9
bb11:

        mov     w9, #10
        mov     w10, w9
        mov     w9, #0
        mov     w9, w9
        mov     w0, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w9
        b     bb12
bb12:

        adrp     x10, N
        add     x10, x10, #:lo12:N
        ldr     w10, [x10]
        cmp     w9, w10
        b.lt     bb13
        b     bb14
bb13:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-240
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     w10, [x10]
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb12
bb14:

        mov     w9, #10
        mov     w9, w9
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #117
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
