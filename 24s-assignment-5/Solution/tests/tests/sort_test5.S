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
.global swap
.global heap_ajust
.global heap_sort
.global main
swap:

bb24:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     w11, w1
        mov     w10, w2
        mov     w9, #0
        mov     w9, #0
        mov     w11, w11
        mov     w9, #0
        mov     w10, w10
        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x13, x9
        ldr     w9, [x9]
        mov     x12, #8
        mul     x12, x10, x12
        add     x12, x13, x12
        ldr     w12, [x12]
        mov     x14, #8
        mul     x11, x11, x14
        add     x11, x13, x11
        str     w12, [x11]
        mov     x11, #8
        mul     x10, x10, x11
        add     x10, x13, x10
        str     w9, [x10]
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
heap_ajust:

bb25:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x14, x0
        mov     w11, w1
        mov     w9, w2
        mov     w10, #0
        mov     w10, #0
        mov     w10, #0
        mov     w10, #0
        mov     w11, w11
        mov     w10, #0
        mov     w12, w9
        mov     w10, w11
        mov     w9, #2
        mul     w9, w10, w9
        add     w9, w9, #1
        mov     w11, w10
        mov     w10, w9
        b     bb3
bb3:

        add     w9, w12, #1
        cmp     w10, w9
        b.lt     bb4
        b     bb5
bb4:

        add     w9, w10, #1
        cmp     w10, w12
        b.lt     bb9
        b     bb7
bb9:

        mov     x13, #8
        mul     x13, x10, x13
        add     x13, x14, x13
        ldr     w13, [x13]
        mov     x15, #8
        mul     x9, x9, x15
        add     x9, x14, x9
        ldr     w9, [x9]
        cmp     w13, w9
        b.lt     bb6
        b     bb7
bb6:

        add     w9, w10, #1
        mov     w9, w9
        b     bb8
bb7:

        mov     w9, w10
        b     bb8
bb8:

        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x14, x10
        ldr     w10, [x10]
        mov     x13, #8
        mul     x13, x9, x13
        add     x13, x14, x13
        ldr     w13, [x13]
        cmp     w10, w13
        b.gt     bb10
        b     bb11
bb10:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
bb11:

        mov     x0, x14
        mov     w1, w11
        mov     w2, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     swap
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w9
        mov     w9, #2
        mul     w9, w10, w9
        add     w9, w9, #1
        mov     w11, w10
        mov     w10, w9
        b     bb3
bb5:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
heap_sort:

bb27:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     w11, w1
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w11
        mov     w11, #2
        sdiv     w11, w9, w11
        sub     w11, w11, #1
        mov     w12, w11
        b     bb14
bb14:

        mov     w11, #0
        sub     w11, w11, #1
        cmp     w12, w11
        b.gt     bb15
        b     bb16
bb15:

        sub     w11, w9, #1
        mov     x0, x10
        mov     w1, w12
        mov     w2, w11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     heap_ajust
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        sub     w11, w12, #1
        mov     w12, w11
        b     bb14
bb16:

        sub     w9, w9, #1
        mov     w12, w9
        b     bb17
bb17:

        mov     w9, #0
        cmp     w12, w9
        b.gt     bb18
        b     bb19
bb18:

        mov     w9, #0
        mov     w11, w9
        mov     x0, x10
        mov     w1, w11
        mov     w2, w12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     swap
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        sub     w9, w12, #1
        mov     x0, x10
        mov     w1, w11
        mov     w2, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     heap_ajust
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        sub     w9, w12, #1
        mov     w12, w9
        b     bb17
bb19:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb20:

        mov     x16, #80
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #50
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
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w10, [x9]
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
        bl     heap_sort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w9, w9
        b     bb21
bb21:

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]
        cmp     w9, w10
        b.lt     bb22
        b     bb23
bb22:

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
        b     bb21
bb23:

        mov     w9, #66
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
