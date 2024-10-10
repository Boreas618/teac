.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global canJump
.global main
canJump:

bb24:

        mov     x16, #80
        sub     sp, sp, x16
        mov     x12, x0
        mov     w10, w1
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w11, w10
        mov     w9, #1
        cmp     w11, w9
        b.eq     bb2
        b     bb3
bb2:

        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret
bb3:

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        ldr     w10, [x9]
        sub     w9, w11, #2
        cmp     w10, w9
        b.gt     bb5
        b     bb6
bb5:

        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret
bb6:

        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb8
bb8:

        sub     w10, w11, #1
        cmp     w9, w10
        b.lt     bb9
        b     bb10
bb9:

        mov     x10, #8
        mul     x13, x9, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x13, x10, x13
        mov     w10, #0
        str     w10, [x13]
        add     w9, w9, #1
        mov     w9, w9
        b     bb8
bb10:

        sub     w10, w11, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        sub     w9, w11, #2
        mov     w10, w9
        b     bb11
bb11:

        mov     w9, #0
        sub     w9, w9, #1
        cmp     w10, w9
        b.gt     bb12
        b     bb13
bb12:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        ldr     w13, [x9]
        sub     w9, w11, #1
        sub     w9, w9, w10
        cmp     w13, w9
        b.lt     bb14
        b     bb15
bb14:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        ldr     w9, [x9]
        mov     w9, w9
        b     bb16
bb15:

        sub     w9, w11, #1
        sub     w9, w9, w10
        mov     w9, w9
        b     bb16
bb16:

        mov     w9, w9
        b     bb17
bb17:

        mov     w13, #0
        sub     w13, w13, #1
        cmp     w9, w13
        b.gt     bb18
        b     bb19
bb18:

        add     w14, w10, w9
        mov     x13, #8
        mul     x14, x14, x13
        mov     x13, #-80
        add     x13, x29, x13
        add     x13, x13, x14
        ldr     w14, [x13]
        mov     w13, #0
        cmp     w14, w13
        b.ne     bb20
        b     bb21
bb20:

        mov     x13, #8
        mul     x14, x10, x13
        mov     x13, #-80
        add     x13, x29, x13
        add     x14, x13, x14
        mov     w13, #1
        str     w13, [x14]
        b     bb22
bb21:

        b     bb22
bb22:

        sub     w9, w9, #1
        mov     w9, w9
        b     bb17
bb19:

        sub     w9, w10, #1
        mov     w10, w9
        b     bb11
bb13:

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w9, [x9]
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb23:

        mov     x16, #80
        sub     sp, sp, x16
        mov     w9, #42
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
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #3
        str     w9, [x10]
        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #3
        str     w9, [x10]
        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #9
        str     w9, [x10]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #0
        str     w9, [x10]
        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #0
        str     w9, [x10]
        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #5
        str     w9, [x10]
        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #7
        str     w9, [x10]
        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #8
        str     w9, [x10]
        mov     w9, #10
        mov     w10, w9
        mov     x9, #-80
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     canJump
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
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
        mov     w0, w10
        mov     sp, x29
        ret
