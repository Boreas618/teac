.section .data
.global    n
n:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global Merge
.global MergeSort
.global main
Merge:

bb29:

        mov     x16, #184
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w11, w1
        mov     w10, w2
        mov     w9, w3
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w14, w11
        mov     w11, #0
        mov     w13, w10
        mov     w10, #0
        mov     w9, w9
        sub     w10, w13, w14
        add     w16, w10, #1
        mov     x17, #16
        str     x16, [sp,x17]
        sub     w15, w9, w13
        mov     w9, #0
        mov     w9, w9
        mov     w10, #0
        mov     w12, w10
        mov     w11, w9
        b     bb2
bb2:

        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     w11, w19
        b.lt     bb3
        b     bb4
bb3:

        add     w10, w11, w14
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w16, [x9]
        mov     x17, #8
        str     x16, [sp,x17]
        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x9, x9, x10
        mov     x16, #8
        ldr     x19, [sp,x16]
        str     w19, [x9]
        add     w9, w11, #1
        mov     w11, w9
        b     bb2
bb4:

        mov     w11, w12
        b     bb5
bb5:

        cmp     w11, w15
        b.lt     bb6
        b     bb7
bb6:

        add     w9, w11, w13
        add     w10, w9, #1
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w12, [x9]
        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        str     w12, [x9]
        add     w9, w11, #1
        mov     w11, w9
        b     bb5
bb7:

        mov     w9, #0
        mov     w9, w9
        mov     w10, #0
        mov     w11, w10
        mov     w10, w14
        mov     w14, w11
        mov     w11, w10
        mov     w13, w9
        b     bb8
bb8:

        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     w13, w19
        b.ne     bb11
        b     bb10
bb11:

        cmp     w14, w15
        b.ne     bb9
        b     bb10
bb9:

        mov     x9, #8
        mul     x10, x13, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w12, [x9]
        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w9, [x9]
        add     w9, w9, #1
        cmp     w12, w9
        b.lt     bb12
        b     bb13
bb12:

        mov     x9, #8
        mul     x10, x13, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w10, [x9]
        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w10, [x9]
        add     w10, w11, #1
        add     w9, w13, #1
        mov     w11, w14
        mov     w10, w10
        mov     w9, w9
        b     bb14
bb13:

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w10, [x9]
        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w10, [x9]
        add     w9, w11, #1
        add     w10, w14, #1
        mov     w11, w10
        mov     w10, w9
        mov     w9, w13
        b     bb14
bb14:

        mov     w14, w11
        mov     w11, w10
        mov     w13, w9
        b     bb8
bb10:

        mov     w12, w11
        mov     w11, w13
        b     bb15
bb15:

        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     w11, w19
        b.lt     bb16
        b     bb17
bb16:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w10, [x9]
        mov     x9, #8
        mul     x9, x12, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w10, [x9]
        add     w10, w12, #1
        add     w9, w11, #1
        mov     w12, w10
        mov     w11, w9
        b     bb15
bb17:

        mov     w10, w14
        mov     w9, w12
        b     bb18
bb18:

        cmp     w10, w15
        b.lt     bb19
        b     bb20
bb19:

        mov     x11, #8
        mul     x12, x10, x11
        mov     x11, #-80
        add     x11, x29, x11
        add     x11, x11, x12
        ldr     w11, [x11]
        mov     x12, #8
        mul     x12, x9, x12
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x12, x19, x12
        str     w11, [x12]
        add     w11, w9, #1
        add     w9, w10, #1
        mov     w10, w9
        mov     w9, w11
        b     bb18
bb20:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
MergeSort:

bb30:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     w12, w1
        mov     w10, w2
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w12
        mov     w12, #0
        mov     w13, w10
        cmp     w9, w13
        b.lt     bb22
        b     bb23
bb22:

        add     w12, w9, w13
        mov     w10, #2
        sdiv     w12, w12, w10
        mov     x0, x11
        mov     w1, w9
        mov     w2, w12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        add     w10, w12, #1
        mov     x0, x11
        mov     w1, w10
        mov     w2, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x0, x11
        mov     w1, w9
        mov     w2, w12
        mov     w3, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     Merge
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb24
bb23:

        b     bb24
bb24:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb25:

        mov     x16, #80
        sub     sp, sp, x16
        mov     w9, #71
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
        mov     w10, #10
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     w10, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #4
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
        mov     w9, #2
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
        mov     w9, #6
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
        mov     w9, #0
        mov     w9, #0
        mov     w11, w9
        mov     w9, #0
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        sub     w10, w9, #1
        mov     x9, #-80
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w11
        mov     w2, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w9, w9
        b     bb26
bb26:

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]
        cmp     w9, w10
        b.lt     bb27
        b     bb28
bb27:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-80
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
        mov     w10, #10
        mov     w10, w10
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb26
bb28:

        mov     w9, #97
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
