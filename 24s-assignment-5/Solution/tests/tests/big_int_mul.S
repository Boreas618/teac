.section .data
.global    len
len:
        .quad   20
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

        mov     x16, #1064
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
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #2
        str     w9, [x10]
        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #3
        str     w9, [x10]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #4
        str     w9, [x10]
        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #5
        str     w9, [x10]
        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #6
        str     w9, [x10]
        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #7
        str     w9, [x10]
        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #8
        str     w9, [x10]
        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #9
        str     w9, [x10]
        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #0
        str     w9, [x10]
        mov     x10, #10
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #11
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #2
        str     w9, [x10]
        mov     x10, #12
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #3
        str     w9, [x10]
        mov     x10, #13
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #4
        str     w9, [x10]
        mov     x10, #14
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #5
        str     w9, [x10]
        mov     x10, #15
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #6
        str     w9, [x10]
        mov     x10, #16
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #7
        str     w9, [x10]
        mov     x10, #17
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #8
        str     w9, [x10]
        mov     x10, #18
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #9
        str     w9, [x10]
        mov     x10, #19
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #0
        str     w9, [x10]
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #2
        str     w9, [x10]
        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #3
        str     w9, [x10]
        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #4
        str     w9, [x10]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #2
        str     w9, [x10]
        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #5
        str     w9, [x10]
        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #7
        str     w9, [x10]
        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #9
        str     w9, [x10]
        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #9
        str     w9, [x10]
        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #0
        str     w9, [x10]
        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #10
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #9
        str     w9, [x10]
        mov     x10, #11
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #8
        str     w9, [x10]
        mov     x10, #12
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #7
        str     w9, [x10]
        mov     x10, #13
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #6
        str     w9, [x10]
        mov     x10, #14
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #4
        str     w9, [x10]
        mov     x10, #15
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #3
        str     w9, [x10]
        mov     x10, #16
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #2
        str     w9, [x10]
        mov     x10, #17
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #18
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #2
        str     w9, [x10]
        mov     x10, #19
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #2
        str     w9, [x10]
        mov     w9, #0
        adrp     x9, len
        add     x9, x9, #:lo12:len
        ldr     w16, [x9]
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w9, #0
        adrp     x9, len
        add     x9, x9, #:lo12:len
        ldr     w16, [x9]
        mov     x17, #8
        str     x16, [sp,x17]
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #0
        str     w9, [x10]
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb2
bb2:

        mov     x16, #0
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.lt     bb3
        b     bb4
bb3:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-160
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     w10, [x10]
        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-520
        add     x11, x29, x11
        add     x11, x11, x12
        str     w10, [x11]
        add     w9, w9, #1
        mov     w9, w9
        b     bb2
bb4:

        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb5
bb5:

        mov     x16, #8
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.lt     bb6
        b     bb7
bb6:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-320
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     w10, [x10]
        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-720
        add     x11, x29, x11
        add     x11, x11, x12
        str     w10, [x11]
        add     w9, w9, #1
        mov     w9, w9
        b     bb5
bb7:

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, #8
        ldr     x18, [sp,x16]
        add     w9, w19, w18
        sub     w10, w9, #1
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb8
bb8:

        cmp     w9, w10
        b.le     bb9
        b     bb10
bb9:

        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-1040
        add     x11, x29, x11
        add     x12, x11, x12
        mov     w11, #0
        str     w11, [x12]
        add     w9, w9, #1
        mov     w9, w9
        b     bb8
bb10:

        mov     w9, #0
        mov     x16, #8
        ldr     x19, [sp,x16]
        sub     w11, w19, #1
        mov     w9, w10
        mov     w16, w11
        mov     x17, #16
        str     x16, [sp,x17]
        b     bb11
bb11:

        mov     w10, #0
        sub     w10, w10, #1
        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     w19, w10
        b.gt     bb12
        b     bb13
bb12:

        mov     x10, #8
        mov     x16, #16
        ldr     x19, [sp,x16]
        mul     x11, x19, x10
        mov     x10, #-720
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     w15, [x10]
        mov     x16, #0
        ldr     x19, [sp,x16]
        sub     w10, w19, #1
        mov     w14, w9
        mov     w13, w10
        b     bb14
bb14:

        mov     w9, #0
        sub     w9, w9, #1
        cmp     w13, w9
        b.gt     bb15
        b     bb16
bb15:

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w11, [x9]
        mov     x9, #8
        mul     x10, x13, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w9, [x9]
        mul     w9, w15, w9
        add     w12, w11, w9
        mov     w9, #10
        cmp     w12, w9
        b.ge     bb17
        b     bb18
bb17:

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        str     w12, [x9]
        sub     w11, w14, #1
        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w10, [x9]
        mov     w9, #10
        sdiv     w9, w12, w9
        add     w12, w10, w9
        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        str     w12, [x9]
        b     bb19
bb18:

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        str     w12, [x9]
        b     bb19
bb19:

        sub     w10, w13, #1
        sub     w9, w14, #1
        mov     w14, w9
        mov     w13, w10
        b     bb14
bb16:

        mov     x16, #0
        ldr     x19, [sp,x16]
        add     w9, w14, w19
        sub     w9, w9, #1
        mov     x16, #16
        ldr     x19, [sp,x16]
        sub     w10, w19, #1
        mov     w9, w9
        mov     w16, w10
        mov     x17, #16
        str     x16, [sp,x17]
        b     bb11
bb13:

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w10, [x9]
        mov     w9, #0
        cmp     w10, w9
        b.ne     bb20
        b     bb21
bb20:

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
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
        b     bb22
bb21:

        b     bb22
bb22:

        mov     w9, #1
        mov     w9, w9
        mov     w9, w9
        b     bb23
bb23:

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, #8
        ldr     x18, [sp,x16]
        add     w10, w19, w18
        sub     w10, w10, #1
        cmp     w9, w10
        b.le     bb24
        b     bb25
bb24:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-1040
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
        b     bb23
bb25:

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
