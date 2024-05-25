.section .data

n:

        .zero   8
m:

        .zero   8
to:

        .zero   40040
next:

        .zero   40040
head:

        .zero   8040
cnt:

        .zero   8
que:

        .zero   8040
h:

        .zero   8
tail:

        .zero   8
inq:

        .zero   8040
.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global quickread
.global addedge
.global init
.global inqueue
.global popqueue
.global same
.global main
quickread:

bb1:

        mov     x16, #32
        sub     sp, sp, x16
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
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-8
        add     x9, x29, x9
        str     x0, [x9]
        mov     x10, #0
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #-24
        add     x9, x29, x9
        str     x10, [x9]
        b     bb2
bb2:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #48
        cmp     x10, x9
        b.lt     bb3
        b     bb5
bb5:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #57
        cmp     x10, x9
        b.gt     bb3
        b     bb4
bb3:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #45
        cmp     x10, x9
        b.eq     bb6
        b     bb7
bb6:

        mov     x10, #1
        mov     x9, #-24
        add     x9, x29, x9
        str     x10, [x9]
        b     bb8
bb7:

        b     bb8
bb8:

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
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-8
        add     x9, x29, x9
        str     x0, [x9]
        b     bb2
bb4:

        b     bb9
bb9:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #48
        cmp     x10, x9
        b.ge     bb12
        b     bb11
bb12:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #57
        cmp     x10, x9
        b.le     bb10
        b     bb11
bb10:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #10
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x9, [x9]
        add     x9, x10, x9
        sub     x10, x9, #48
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
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
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-8
        add     x9, x29, x9
        str     x0, [x9]
        b     bb9
bb11:

        mov     x9, #-24
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #0
        cmp     x10, x9
        b.ne     bb13
        b     bb14
bb13:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #0
        sub     x9, x9, x10
        mov     x0, x9
        mov     sp, x29
        ret
bb50:

        b     bb15
bb14:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x9, [x9]
        mov     x0, x9
        mov     sp, x29
        ret
bb51:

        b     bb15
bb15:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
addedge:

bb52:

        mov     x16, #16
        sub     sp, sp, x16
        mov     x9, #-8
        add     x9, x29, x9
        str     x11, [x9]
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
        b     bb16
bb16:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x11, [x9]
        adr     x9, cnt
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, to
        add     x9, x9, x10
        str     x11, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, head
        add     x9, x9, x10
        ldr     x11, [x9]
        adr     x9, cnt
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, next
        add     x9, x9, x10
        str     x11, [x9]
        adr     x9, cnt
        ldr     x11, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, head
        add     x9, x9, x10
        str     x11, [x9]
        adr     x9, cnt
        ldr     x9, [x9]
        add     x10, x9, #1
        adr     x9, cnt
        str     x10, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x11, [x9]
        adr     x9, cnt
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, to
        add     x9, x9, x10
        str     x11, [x9]
        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, head
        add     x9, x9, x10
        ldr     x11, [x9]
        adr     x9, cnt
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, next
        add     x9, x9, x10
        str     x11, [x9]
        adr     x9, cnt
        ldr     x11, [x9]
        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, head
        add     x9, x9, x10
        str     x11, [x9]
        adr     x9, cnt
        ldr     x9, [x9]
        add     x10, x9, #1
        adr     x9, cnt
        str     x10, [x9]
        mov     sp, x29
        ret
init:

bb17:

        mov     x16, #16
        sub     sp, sp, x16
        mov     x10, #0
        mov     x9, #-8
        add     x9, x29, x9
        str     x10, [x9]
        b     bb18
bb18:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #1005
        cmp     x10, x9
        b.lt     bb19
        b     bb20
bb19:

        mov     x9, #0
        sub     x11, x9, #1
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, head
        add     x9, x9, x10
        str     x11, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x9, [x9]
        add     x10, x9, #1
        mov     x9, #-8
        add     x9, x29, x9
        str     x10, [x9]
        b     bb18
bb20:

        mov     sp, x29
        ret
inqueue:

bb53:

        mov     x16, #16
        sub     sp, sp, x16
        mov     x9, #-8
        add     x9, x29, x9
        str     x10, [x9]
        b     bb21
bb21:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, inq
        add     x10, x9, x10
        mov     x9, #1
        str     x9, [x10]
        adr     x9, tail
        ldr     x9, [x9]
        add     x10, x9, #1
        adr     x9, tail
        str     x10, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x11, [x9]
        adr     x9, tail
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, que
        add     x9, x9, x10
        str     x11, [x9]
        mov     sp, x29
        ret
popqueue:

bb22:

        mov     x16, #16
        sub     sp, sp, x16
        adr     x9, h
        ldr     x9, [x9]
        add     x10, x9, #1
        adr     x9, h
        str     x10, [x9]
        adr     x9, h
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, que
        add     x9, x9, x10
        ldr     x10, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        str     x10, [x9]
        adr     x9, h
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, que
        add     x9, x9, x10
        ldr     x9, [x9]
        mov     x0, x9
        mov     sp, x29
        ret
same:

bb54:

        mov     x16, #48
        sub     sp, sp, x16
        mov     x9, #-40
        add     x9, x29, x9
        str     x11, [x9]
        mov     x9, #-48
        add     x9, x29, x9
        str     x10, [x9]
        b     bb23
bb23:

        mov     x10, #0
        adr     x9, h
        str     x10, [x9]
        mov     x10, #0
        adr     x9, tail
        str     x10, [x9]
        mov     x9, #-40
        add     x9, x29, x9
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
        bl     inqueue
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        mov     x9, #-32
        add     x9, x29, x9
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #-24
        add     x9, x29, x9
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #-8
        add     x9, x29, x9
        str     x10, [x9]
        b     bb24
bb24:

        adr     x9, h
        ldr     x10, [x9]
        adr     x9, tail
        ldr     x9, [x9]
        cmp     x10, x9
        b.lt     bb25
        b     bb26
bb25:

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
        bl     popqueue
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-24
        add     x9, x29, x9
        str     x0, [x9]
        mov     x9, #-24
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #-48
        add     x9, x29, x9
        ldr     x9, [x9]
        cmp     x10, x9
        b.eq     bb27
        b     bb28
bb27:

        mov     x10, #1
        mov     x9, #-32
        add     x9, x29, x9
        str     x10, [x9]
        b     bb29
bb28:

        b     bb29
bb29:

        mov     x9, #-24
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, head
        add     x9, x9, x10
        ldr     x10, [x9]
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
        b     bb30
bb30:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #0
        sub     x9, x9, #1
        cmp     x10, x9
        b.ne     bb31
        b     bb32
bb31:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, to
        add     x9, x9, x10
        ldr     x10, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        str     x10, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, inq
        add     x9, x9, x10
        ldr     x10, [x9]
        mov     x9, #0
        cmp     x10, x9
        b.eq     bb33
        b     bb34
bb33:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, to
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
        bl     inqueue
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb35
bb34:

        b     bb35
bb35:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, next
        add     x9, x9, x10
        ldr     x10, [x9]
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
        b     bb30
bb32:

        b     bb24
bb26:

        mov     x10, #0
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
        b     bb36
bb36:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        adr     x9, tail
        ldr     x9, [x9]
        cmp     x10, x9
        b.le     bb37
        b     bb38
bb37:

        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, que
        add     x9, x9, x10
        ldr     x10, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        str     x10, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, inq
        add     x10, x9, x10
        mov     x9, #0
        str     x9, [x10]
        mov     x9, #-16
        add     x9, x29, x9
        ldr     x9, [x9]
        add     x10, x9, #1
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
        b     bb36
bb38:

        mov     x9, #-32
        add     x9, x29, x9
        ldr     x9, [x9]
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb39:

        mov     x16, #32
        sub     sp, sp, x16
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
        bl     quickread
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
        bl     quickread
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
        bl     init
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        mov     x9, #-8
        add     x9, x29, x9
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #-16
        add     x9, x29, x9
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #-24
        add     x9, x29, x9
        str     x10, [x9]
        b     bb40
bb40:

        adr     x9, m
        ldr     x10, [x9]
        mov     x9, #0
        cmp     x10, x9
        b.ne     bb41
        b     bb42
bb41:

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
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-8
        add     x9, x29, x9
        str     x0, [x9]
        b     bb43
bb43:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #81
        cmp     x10, x9
        b.ne     bb46
        b     bb45
bb46:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #85
        cmp     x10, x9
        b.ne     bb44
        b     bb45
bb44:

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
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-8
        add     x9, x29, x9
        str     x0, [x9]
        b     bb43
bb45:

        mov     x9, #-8
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #81
        cmp     x10, x9
        b.eq     bb47
        b     bb48
bb47:

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
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-16
        add     x9, x29, x9
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
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-24
        add     x9, x29, x9
        str     x0, [x9]
        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #-24
        add     x9, x29, x9
        ldr     x9, [x9]
        mov     x0, x10
        mov     x1, x9
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
        bl     same
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x0, x0
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
        b     bb49
bb48:

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
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-16
        add     x9, x29, x9
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
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-24
        add     x9, x29, x9
        str     x0, [x9]
        mov     x9, #-16
        add     x9, x29, x9
        ldr     x10, [x9]
        mov     x9, #-24
        add     x9, x29, x9
        ldr     x9, [x9]
        mov     x0, x10
        mov     x1, x9
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
        bl     addedge
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb49
bb49:

        adr     x9, m
        ldr     x9, [x9]
        sub     x10, x9, #1
        adr     x9, m
        str     x10, [x9]
        b     bb40
bb42:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
