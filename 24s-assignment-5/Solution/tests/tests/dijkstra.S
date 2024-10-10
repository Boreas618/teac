.section .data
.global    INF
.global    e
.global    book
.global    dis
.global    n
.global    m
.global    v1
.global    v2
.global    w
INF:
        .quad   65535
e:
        .zero   2048
book:
        .zero   128
dis:
        .zero   128
n:
        .quad   0
m:
        .quad   0
v1:
        .quad   0
v2:
        .quad   0
w:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global Dijkstra
.global main
Dijkstra:

bb1:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #1
        mov     w9, w9
        mov     w9, w9
        b     bb2
bb2:

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]
        cmp     w9, w10
        b.le     bb3
        b     bb4
bb3:

        mov     x11, #1
        mov     x10, #128
        mul     x11, x11, x10
        adrp     x10, e
        add     x10, x10, #:lo12:e
        add     x11, x10, x11
        mov     x10, #0
        add     x11, x11, x10
        mov     x10, #8
        mul     x10, x9, x10
        add     x10, x11, x10
        ldr     w12, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, dis
        add     x10, x10, #:lo12:dis
        add     x10, x10, x11
        str     w12, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, book
        add     x10, x10, #:lo12:book
        add     x11, x10, x11
        mov     w10, #0
        str     w10, [x11]
        add     w9, w9, #1
        mov     w9, w9
        b     bb2
bb4:

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        adrp     x9, book
        add     x9, x9, #:lo12:book
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     w9, #1
        mov     w9, w9
        mov     w12, w9
        b     bb5
bb5:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        sub     w9, w9, #1
        cmp     w12, w9
        b.le     bb6
        b     bb7
bb6:

        adrp     x9, INF
        add     x9, x9, #:lo12:INF
        ldr     w9, [x9]
        mov     w10, #0
        mov     w13, w10
        mov     w10, #1
        mov     w10, w10
        mov     w11, w10
        mov     w10, w13
        mov     w9, w9
        b     bb8
bb8:

        adrp     x13, n
        add     x13, x13, #:lo12:n
        ldr     w13, [x13]
        cmp     w11, w13
        b.le     bb9
        b     bb10
bb9:

        mov     x13, #8
        mul     x14, x11, x13
        adrp     x13, dis
        add     x13, x13, #:lo12:dis
        add     x13, x13, x14
        ldr     w13, [x13]
        cmp     w9, w13
        b.gt     bb14
        b     bb12
bb14:

        mov     x13, #8
        mul     x14, x11, x13
        adrp     x13, book
        add     x13, x13, #:lo12:book
        add     x13, x13, x14
        ldr     w14, [x13]
        mov     w13, #0
        cmp     w14, w13
        b.eq     bb11
        b     bb12
bb11:

        mov     x9, #8
        mul     x10, x11, x9
        adrp     x9, dis
        add     x9, x9, #:lo12:dis
        add     x9, x9, x10
        ldr     w10, [x9]
        mov     w9, w11
        mov     w14, w9
        mov     w13, w10
        b     bb13
bb12:

        mov     w14, w10
        mov     w13, w9
        b     bb13
bb13:

        add     w9, w11, #1
        mov     w11, w9
        mov     w10, w14
        mov     w9, w13
        b     bb8
bb10:

        mov     x9, #8
        mul     x11, x10, x9
        adrp     x9, book
        add     x9, x9, #:lo12:book
        add     x11, x9, x11
        mov     w9, #1
        str     w9, [x11]
        mov     w9, #1
        mov     w9, w9
        mov     w9, w9
        b     bb15
bb15:

        adrp     x11, n
        add     x11, x11, #:lo12:n
        ldr     w11, [x11]
        cmp     w9, w11
        b.le     bb16
        b     bb17
bb16:

        mov     x11, #128
        mul     x13, x10, x11
        adrp     x11, e
        add     x11, x11, #:lo12:e
        add     x13, x11, x13
        mov     x11, #0
        add     x13, x13, x11
        mov     x11, #8
        mul     x11, x9, x11
        add     x11, x13, x11
        ldr     w13, [x11]
        adrp     x11, INF
        add     x11, x11, #:lo12:INF
        ldr     w11, [x11]
        cmp     w13, w11
        b.lt     bb18
        b     bb19
bb18:

        mov     x11, #8
        mul     x13, x9, x11
        adrp     x11, dis
        add     x11, x11, #:lo12:dis
        add     x11, x11, x13
        ldr     w14, [x11]
        mov     x11, #8
        mul     x13, x10, x11
        adrp     x11, dis
        add     x11, x11, #:lo12:dis
        add     x11, x11, x13
        ldr     w13, [x11]
        mov     x11, #128
        mul     x15, x10, x11
        adrp     x11, e
        add     x11, x11, #:lo12:e
        add     x15, x11, x15
        mov     x11, #0
        add     x11, x15, x11
        mov     x15, #8
        mul     x15, x9, x15
        add     x11, x11, x15
        ldr     w11, [x11]
        add     w11, w13, w11
        cmp     w14, w11
        b.gt     bb21
        b     bb22
bb21:

        mov     x11, #8
        mul     x13, x10, x11
        adrp     x11, dis
        add     x11, x11, #:lo12:dis
        add     x11, x11, x13
        ldr     w11, [x11]
        mov     x13, #128
        mul     x14, x10, x13
        adrp     x13, e
        add     x13, x13, #:lo12:e
        add     x14, x13, x14
        mov     x13, #0
        add     x14, x14, x13
        mov     x13, #8
        mul     x13, x9, x13
        add     x13, x14, x13
        ldr     w13, [x13]
        add     w11, w11, w13
        mov     x13, #8
        mul     x14, x9, x13
        adrp     x13, dis
        add     x13, x13, #:lo12:dis
        add     x13, x13, x14
        str     w11, [x13]
        b     bb23
bb22:

        b     bb23
bb23:

        b     bb20
bb19:

        b     bb20
bb20:

        add     w9, w9, #1
        mov     w9, w9
        b     bb15
bb17:

        add     w9, w12, #1
        mov     w12, w9
        b     bb5
bb7:

        mov     sp, x29
        ret
main:

bb24:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #53
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
        mov     w10, w0
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     w10, [x9]
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
        mov     w10, w0
        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     w10, [x9]
        mov     w9, #1
        mov     w9, w9
        mov     w10, w9
        b     bb25
bb25:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        cmp     w10, w9
        b.le     bb26
        b     bb27
bb26:

        mov     w9, #1
        mov     w9, w9
        mov     w9, w9
        b     bb28
bb28:

        adrp     x11, n
        add     x11, x11, #:lo12:n
        ldr     w11, [x11]
        cmp     w9, w11
        b.le     bb29
        b     bb30
bb29:

        cmp     w10, w9
        b.eq     bb31
        b     bb32
bb31:

        mov     x11, #128
        mul     x12, x10, x11
        adrp     x11, e
        add     x11, x11, #:lo12:e
        add     x12, x11, x12
        mov     x11, #0
        add     x12, x12, x11
        mov     x11, #8
        mul     x11, x9, x11
        add     x12, x12, x11
        mov     w11, #0
        str     w11, [x12]
        b     bb33
bb32:

        adrp     x11, INF
        add     x11, x11, #:lo12:INF
        ldr     w11, [x11]
        mov     x12, #128
        mul     x13, x10, x12
        adrp     x12, e
        add     x12, x12, #:lo12:e
        add     x13, x12, x13
        mov     x12, #0
        add     x13, x13, x12
        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x13, x12
        str     w11, [x12]
        b     bb33
bb33:

        add     w9, w9, #1
        mov     w9, w9
        b     bb28
bb30:

        add     w9, w10, #1
        mov     w10, w9
        b     bb25
bb27:

        mov     w9, #1
        mov     w9, w9
        mov     w10, w9
        b     bb34
bb34:

        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     w9, [x9]
        cmp     w10, w9
        b.le     bb35
        b     bb36
bb35:

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
        mov     w13, w0
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
        mov     w9, w0
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
        mov     w11, w0
        mov     x12, #128
        mul     x13, x13, x12
        adrp     x12, e
        add     x12, x12, #:lo12:e
        add     x13, x12, x13
        mov     x12, #0
        add     x13, x13, x12
        mov     x12, #8
        mul     x9, x9, x12
        add     x9, x13, x9
        str     w11, [x9]
        add     w9, w10, #1
        mov     w10, w9
        b     bb34
bb36:

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     Dijkstra
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #1
        mov     w9, w9
        mov     w9, w9
        b     bb37
bb37:

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]
        cmp     w9, w10
        b.le     bb38
        b     bb39
bb38:

        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, dis
        add     x10, x10, #:lo12:dis
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
        mov     w10, #32
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
        b     bb37
bb39:

        mov     w9, #10
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
        mov     w9, #91
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
