.section .data

INF:

        .word   65535
e:

        .zero   2048
book:

        .zero   128
dis:

        .zero   128
n:

        .zero   8
m:

        .zero   8
v1:

        .zero   8
v2:

        .zero   8
w:

        .zero   8
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
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #1
        mov     x9, x9
        mov     x9, x9
        b     bb2
bb2:

        adr     x10, n
        ldr     x10, [x10]
        cmp     x9, x10
        b.le     bb3
        b     bb4
bb3:

        mov     x11, #1
        mov     x10, #128
        mul     x11, x11, x10
        adr     x10, e
        add     x12, x10, x11
        mov     x11, #0
        mov     x10, #128
        mul     x10, x11, x10
        add     x11, x12, x10
        mov     x10, #8
        mul     x10, x9, x10
        add     x10, x11, x10
        ldr     x12, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        adr     x10, dis
        add     x10, x10, x11
        str     x12, [x10]
        mov     x10, #8
        mul     x11, x9, x10
        adr     x10, book
        add     x11, x10, x11
        mov     x10, #0
        str     x10, [x11]
        add     x9, x9, #1
        mov     x9, x9
        b     bb2
bb4:

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, book
        add     x10, x9, x10
        mov     x9, #1
        str     x9, [x10]
        mov     x9, #1
        mov     x9, x9
        mov     x12, x9
        b     bb5
bb5:

        adr     x9, n
        ldr     x9, [x9]
        sub     x9, x9, #1
        cmp     x12, x9
        b.le     bb6
        b     bb7
bb6:

        adr     x9, INF
        ldr     x13, [x9]
        mov     x9, #0
        mov     x10, x9
        mov     x9, #1
        mov     x9, x9
        mov     x11, x9
        mov     x10, x10
        mov     x9, x13
        b     bb8
bb8:

        adr     x13, n
        ldr     x13, [x13]
        cmp     x11, x13
        b.le     bb9
        b     bb10
bb9:

        mov     x13, #8
        mul     x14, x11, x13
        adr     x13, dis
        add     x13, x13, x14
        ldr     x13, [x13]
        cmp     x9, x13
        b.gt     bb14
        b     bb12
bb14:

        mov     x13, #8
        mul     x14, x11, x13
        adr     x13, book
        add     x13, x13, x14
        ldr     x14, [x13]
        mov     x13, #0
        cmp     x14, x13
        b.eq     bb11
        b     bb12
bb11:

        mov     x9, #8
        mul     x10, x11, x9
        adr     x9, dis
        add     x9, x9, x10
        ldr     x10, [x9]
        mov     x9, x11
        mov     x14, x9
        mov     x13, x10
        b     bb13
bb12:

        mov     x14, x10
        mov     x13, x9
        b     bb13
bb13:

        add     x9, x11, #1
        mov     x11, x9
        mov     x10, x14
        mov     x9, x13
        b     bb8
bb10:

        mov     x9, #8
        mul     x11, x10, x9
        adr     x9, book
        add     x11, x9, x11
        mov     x9, #1
        str     x9, [x11]
        mov     x9, #1
        mov     x9, x9
        mov     x9, x9
        b     bb15
bb15:

        adr     x11, n
        ldr     x11, [x11]
        cmp     x9, x11
        b.le     bb16
        b     bb17
bb16:

        mov     x11, #128
        mul     x13, x10, x11
        adr     x11, e
        add     x14, x11, x13
        mov     x13, #0
        mov     x11, #128
        mul     x11, x13, x11
        add     x13, x14, x11
        mov     x11, #8
        mul     x11, x9, x11
        add     x11, x13, x11
        ldr     x13, [x11]
        adr     x11, INF
        ldr     x11, [x11]
        cmp     x13, x11
        b.lt     bb18
        b     bb19
bb18:

        mov     x11, #8
        mul     x13, x9, x11
        adr     x11, dis
        add     x11, x11, x13
        ldr     x13, [x11]
        mov     x11, #8
        mul     x14, x10, x11
        adr     x11, dis
        add     x11, x11, x14
        ldr     x11, [x11]
        mov     x14, #128
        mul     x15, x10, x14
        adr     x14, e
        add     x20, x14, x15
        mov     x15, #0
        mov     x14, #128
        mul     x14, x15, x14
        add     x15, x20, x14
        mov     x14, #8
        mul     x14, x9, x14
        add     x14, x15, x14
        ldr     x14, [x14]
        add     x11, x11, x14
        cmp     x13, x11
        b.gt     bb21
        b     bb22
bb21:

        mov     x11, #8
        mul     x13, x10, x11
        adr     x11, dis
        add     x11, x11, x13
        ldr     x15, [x11]
        mov     x11, #128
        mul     x13, x10, x11
        adr     x11, e
        add     x14, x11, x13
        mov     x13, #0
        mov     x11, #128
        mul     x11, x13, x11
        add     x13, x14, x11
        mov     x11, #8
        mul     x11, x9, x11
        add     x11, x13, x11
        ldr     x11, [x11]
        add     x14, x15, x11
        mov     x11, #8
        mul     x13, x9, x11
        adr     x11, dis
        add     x11, x11, x13
        str     x14, [x11]
        b     bb23
bb22:

        b     bb23
bb23:

        b     bb20
bb19:

        b     bb20
bb20:

        add     x9, x9, #1
        mov     x9, x9
        b     bb15
bb17:

        add     x9, x12, #1
        mov     x12, x9
        b     bb5
bb7:

        mov     sp, x29
        ret
main:

bb24:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
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
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adr     x9, n
        str     x0, [x9]
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
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adr     x9, m
        str     x0, [x9]
        mov     x9, #1
        mov     x9, x9
        mov     x10, x9
        b     bb25
bb25:

        adr     x9, n
        ldr     x9, [x9]
        cmp     x10, x9
        b.le     bb26
        b     bb27
bb26:

        mov     x9, #1
        mov     x9, x9
        mov     x9, x9
        b     bb28
bb28:

        adr     x11, n
        ldr     x11, [x11]
        cmp     x9, x11
        b.le     bb29
        b     bb30
bb29:

        cmp     x10, x9
        b.eq     bb31
        b     bb32
bb31:

        mov     x11, #128
        mul     x12, x10, x11
        adr     x11, e
        add     x13, x11, x12
        mov     x12, #0
        mov     x11, #128
        mul     x11, x12, x11
        add     x12, x13, x11
        mov     x11, #8
        mul     x11, x9, x11
        add     x12, x12, x11
        mov     x11, #0
        str     x11, [x12]
        b     bb33
bb32:

        adr     x11, INF
        ldr     x14, [x11]
        mov     x11, #128
        mul     x12, x10, x11
        adr     x11, e
        add     x13, x11, x12
        mov     x12, #0
        mov     x11, #128
        mul     x11, x12, x11
        add     x12, x13, x11
        mov     x11, #8
        mul     x11, x9, x11
        add     x11, x12, x11
        str     x14, [x11]
        b     bb33
bb33:

        add     x9, x9, #1
        mov     x9, x9
        b     bb28
bb30:

        add     x9, x10, #1
        mov     x10, x9
        b     bb25
bb27:

        mov     x9, #1
        mov     x9, x9
        mov     x11, x9
        b     bb34
bb34:

        adr     x9, m
        ldr     x9, [x9]
        cmp     x11, x9
        b.le     bb35
        b     bb36
bb35:

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
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
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
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
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
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #128
        mul     x10, x0, x9
        adr     x9, e
        add     x12, x9, x10
        mov     x10, #0
        mov     x9, #128
        mul     x9, x10, x9
        add     x10, x12, x9
        mov     x9, #8
        mul     x9, x0, x9
        add     x9, x10, x9
        str     x0, [x9]
        add     x9, x11, #1
        mov     x11, x9
        b     bb34
bb36:

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
        bl     Dijkstra
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #1
        mov     x9, x9
        mov     x11, x9
        b     bb37
bb37:

        adr     x9, n
        ldr     x9, [x9]
        cmp     x11, x9
        b.le     bb38
        b     bb39
bb38:

        mov     x9, #8
        mul     x10, x11, x9
        adr     x9, dis
        add     x9, x9, x10
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
        mov     x9, #32
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
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        add     x9, x11, #1
        mov     x11, x9
        b     bb37
bb39:

        mov     x9, #10
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
        bl     putch
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
