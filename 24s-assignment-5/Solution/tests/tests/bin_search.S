.section .data
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

        mov     x16, #80
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #3
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
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb2
bb2:

        mov     w10, #10
        cmp     w9, w10
        b.lt     bb3
        b     bb4
bb3:

        add     w12, w9, #1
        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11
        str     w12, [x10]
        add     w9, w9, #1
        mov     w9, w9
        b     bb2
bb4:

        mov     w9, #10
        mov     w9, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        sub     w11, w9, #1
        mov     w9, #0
        mov     w10, w9
        add     w13, w11, w10
        mov     w9, #2
        sdiv     w9, w13, w9
        mov     w11, w11
        mov     w10, w10
        mov     w9, w9
        b     bb5
bb5:

        mov     x13, #8
        mul     x14, x9, x13
        mov     x13, #-80
        add     x13, x29, x13
        add     x13, x13, x14
        ldr     w13, [x13]
        cmp     w13, w12
        b.ne     bb8
        b     bb7
bb8:

        cmp     w10, w11
        b.lt     bb6
        b     bb7
bb6:

        add     w13, w11, w10
        mov     w9, #2
        sdiv     w9, w13, w9
        mov     x13, #8
        mul     x14, x9, x13
        mov     x13, #-80
        add     x13, x29, x13
        add     x13, x13, x14
        ldr     w13, [x13]
        cmp     w12, w13
        b.lt     bb9
        b     bb10
bb9:

        sub     w11, w9, #1
        mov     w11, w11
        mov     w10, w10
        b     bb11
bb10:

        add     w10, w9, #1
        mov     w11, w11
        mov     w10, w10
        b     bb11
bb11:

        mov     w11, w11
        mov     w10, w10
        mov     w9, w9
        b     bb5
bb7:

        mov     x10, #8
        mul     x10, x9, x10
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w9, [x9]
        cmp     w12, w9
        b.eq     bb12
        b     bb13
bb12:

        mov     w0, w12
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
        b     bb14
bb13:

        mov     w9, #0
        mov     w9, w9
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
        b     bb14
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
        mov     w9, #49
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
