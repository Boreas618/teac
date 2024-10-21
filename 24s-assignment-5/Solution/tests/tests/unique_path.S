.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global uniquePaths
.global main
uniquePaths:

bb19:

        mov     x16, #80
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, w1
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w10, w10
        mov     w11, #0
        mov     w14, w9
        mov     w9, #1
        cmp     w10, w9
        b.eq     bb2
        b     bb5
bb5:

        mov     w9, #1
        cmp     w14, w9
        b.eq     bb2
        b     bb3
bb2:

        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret
bb3:

        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb6
bb6:

        cmp     w9, w10
        b.lt     bb7
        b     bb8
bb7:

        mov     w11, #3
        mul     w11, w9, w11
        add     w11, w11, w14
        sub     w12, w11, #1
        mov     x11, #8
        mul     x12, x12, x11
        mov     x11, #-72
        add     x11, x29, x11
        add     x12, x11, x12
        mov     w11, #1
        str     w11, [x12]
        add     w9, w9, #1
        mov     w9, w9
        b     bb6
bb8:

        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb9
bb9:

        cmp     w9, w14
        b.lt     bb10
        b     bb11
bb10:

        sub     w12, w10, #1
        mov     w11, #3
        mul     w11, w12, w11
        add     w12, w11, w9
        mov     x11, #8
        mul     x12, x12, x11
        mov     x11, #-72
        add     x11, x29, x11
        add     x12, x11, x12
        mov     w11, #1
        str     w11, [x12]
        add     w9, w9, #1
        mov     w9, w9
        b     bb9
bb11:

        sub     w9, w10, #2
        mov     w13, w9
        b     bb12
bb12:

        mov     w9, #0
        sub     w9, w9, #1
        cmp     w13, w9
        b.gt     bb13
        b     bb14
bb13:

        sub     w9, w14, #2
        mov     w12, w9
        b     bb15
bb15:

        mov     w9, #0
        sub     w9, w9, #1
        cmp     w12, w9
        b.gt     bb16
        b     bb17
bb16:

        mov     w9, #3
        mul     w9, w13, w9
        add     w11, w9, w12
        add     w10, w13, #1
        mov     w9, #3
        mul     w9, w10, w9
        add     w9, w9, w12
        mov     w10, #3
        mul     w10, w13, w10
        add     w10, w10, w12
        add     w10, w10, #1
        mov     x15, #8
        mul     x9, x9, x15
        mov     x15, #-72
        add     x15, x29, x15
        add     x9, x15, x9
        ldr     w15, [x9]
        mov     x9, #8
        mul     x9, x10, x9
        mov     x10, #-72
        add     x10, x29, x10
        add     x9, x10, x9
        ldr     w9, [x9]
        add     w9, w15, w9
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-72
        add     x10, x29, x10
        add     x10, x10, x11
        str     w9, [x10]
        sub     w9, w12, #1
        mov     w12, w9
        b     bb15
bb17:

        sub     w9, w13, #1
        mov     w13, w9
        b     bb12
bb14:

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-72
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w9, [x9]
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb18:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #40
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
        mov     w9, #3
        mov     w9, w9
        mov     w0, w9
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     uniquePaths
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        mov     w9, #45
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
        mov     w0, w10
        mov     sp, x29
        ret
