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

        mov     x16, #0
        sub     sp, sp, x16
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
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x11, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x12, x9
        mov     x10, x0
        b     bb2
bb2:

        mov     x9, #48
        cmp     x10, x9
        b.lt     bb3
        b     bb5
bb5:

        mov     x9, #57
        cmp     x10, x9
        b.gt     bb3
        b     bb4
bb3:

        mov     x9, #45
        cmp     x10, x9
        b.eq     bb6
        b     bb7
bb6:

        mov     x9, #1
        mov     x9, x9
        mov     x9, x9
        b     bb8
bb7:

        mov     x9, x12
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
        mov     x12, x9
        mov     x10, x0
        b     bb2
bb4:

        mov     x11, x11
        mov     x10, x10
        b     bb9
bb9:

        mov     x9, #48
        cmp     x10, x9
        b.ge     bb12
        b     bb11
bb12:

        mov     x9, #57
        cmp     x10, x9
        b.le     bb10
        b     bb11
bb10:

        mov     x9, #10
        mul     x9, x11, x9
        add     x9, x9, x10
        sub     x9, x9, #48
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
        mov     x11, x9
        mov     x10, x0
        b     bb9
bb11:

        mov     x9, #0
        cmp     x12, x9
        b.ne     bb13
        b     bb14
bb13:

        mov     x9, #0
        sub     x9, x9, x11
        mov     x0, x9
        mov     sp, x29
        ret
bb14:

        mov     x0, x11
        mov     sp, x29
        ret
addedge:

bb52:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        mov     x9, x9
        mov     x10, x10
        mov     x9, #0
        mov     x9, x9
        mov     x9, x11
        adr     x11, cnt
        ldr     x12, [x11]
        mov     x11, #8
        mul     x12, x12, x11
        adr     x11, to
        add     x11, x11, x12
        str     x9, [x11]
        mov     x11, #8
        mul     x12, x10, x11
        adr     x11, head
        add     x11, x11, x12
        ldr     x13, [x11]
        adr     x11, cnt
        ldr     x12, [x11]
        mov     x11, #8
        mul     x12, x12, x11
        adr     x11, next
        add     x11, x11, x12
        str     x13, [x11]
        adr     x11, cnt
        ldr     x13, [x11]
        mov     x11, #8
        mul     x12, x10, x11
        adr     x11, head
        add     x11, x11, x12
        str     x13, [x11]
        adr     x11, cnt
        ldr     x11, [x11]
        add     x12, x11, #1
        adr     x11, cnt
        str     x12, [x11]
        adr     x11, cnt
        ldr     x12, [x11]
        mov     x11, #8
        mul     x12, x12, x11
        adr     x11, to
        add     x11, x11, x12
        str     x10, [x11]
        mov     x10, #8
        mul     x11, x9, x10
        adr     x10, head
        add     x10, x10, x11
        ldr     x12, [x10]
        adr     x10, cnt
        ldr     x11, [x10]
        mov     x10, #8
        mul     x11, x11, x10
        adr     x10, next
        add     x10, x10, x11
        str     x12, [x10]
        adr     x10, cnt
        ldr     x11, [x10]
        mov     x10, #8
        mul     x10, x9, x10
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

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x11, x9
        b     bb18
bb18:

        mov     x9, #1005
        cmp     x11, x9
        b.lt     bb19
        b     bb20
bb19:

        mov     x9, #0
        sub     x12, x9, #1
        mov     x9, #8
        mul     x10, x11, x9
        adr     x9, head
        add     x9, x9, x10
        str     x12, [x9]
        add     x9, x11, #1
        mov     x11, x9
        b     bb18
bb20:

        mov     sp, x29
        ret
inqueue:

bb53:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        mov     x9, x9
        mov     x11, x10
        mov     x9, #8
        mul     x10, x11, x9
        adr     x9, inq
        add     x10, x9, x10
        mov     x9, #1
        str     x9, [x10]
        adr     x9, tail
        ldr     x9, [x9]
        add     x10, x9, #1
        adr     x9, tail
        str     x10, [x9]
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

        mov     x16, #0
        sub     sp, sp, x16
        adr     x9, h
        ldr     x9, [x9]
        add     x10, x9, #1
        adr     x9, h
        str     x10, [x9]
        mov     x9, #0
        mov     x9, x9
        adr     x9, h
        ldr     x10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, que
        add     x9, x9, x10
        ldr     x9, [x9]
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

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
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
        mov     x12, x11
        mov     x9, #0
        mov     x9, x9
        mov     x11, x10
        mov     x10, #0
        adr     x9, h
        str     x10, [x9]
        mov     x10, #0
        adr     x9, tail
        str     x10, [x9]
        mov     x0, x12
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
        mov     x9, #0
        mov     x10, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, x10
        b     bb24
bb24:

        adr     x10, h
        ldr     x12, [x10]
        adr     x10, tail
        ldr     x10, [x10]
        cmp     x12, x10
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
        cmp     x0, x11
        b.eq     bb27
        b     bb28
bb27:

        mov     x9, #1
        mov     x9, x9
        mov     x10, x9
        b     bb29
bb28:

        mov     x10, x9
        b     bb29
bb29:

        mov     x9, #8
        mul     x12, x0, x9
        adr     x9, head
        add     x9, x9, x12
        ldr     x9, [x9]
        mov     x9, x9
        b     bb30
bb30:

        mov     x12, #0
        sub     x12, x12, #1
        cmp     x9, x12
        b.ne     bb31
        b     bb32
bb31:

        mov     x12, #8
        mul     x13, x9, x12
        adr     x12, to
        add     x12, x12, x13
        ldr     x13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adr     x12, inq
        add     x12, x12, x13
        ldr     x13, [x12]
        mov     x12, #0
        cmp     x13, x12
        b.eq     bb33
        b     bb34
bb33:

        mov     x12, #8
        mul     x13, x9, x12
        adr     x12, to
        add     x12, x12, x13
        ldr     x12, [x12]
        mov     x0, x12
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

        mov     x12, #8
        mul     x12, x9, x12
        adr     x9, next
        add     x9, x9, x12
        ldr     x9, [x9]
        mov     x9, x9
        b     bb30
bb32:

        mov     x9, x10
        b     bb24
bb26:

        mov     x10, #0
        mov     x10, x10
        mov     x12, x10
        b     bb36
bb36:

        adr     x10, tail
        ldr     x10, [x10]
        cmp     x12, x10
        b.le     bb37
        b     bb38
bb37:

        mov     x10, #8
        mul     x11, x12, x10
        adr     x10, que
        add     x10, x10, x11
        ldr     x11, [x10]
        mov     x10, #8
        mul     x11, x11, x10
        adr     x10, inq
        add     x11, x10, x11
        mov     x10, #0
        str     x10, [x11]
        add     x10, x12, #1
        mov     x12, x10
        b     bb36
bb38:

        mov     x0, x9
        mov     sp, x29
        ret
main:

bb39:

        mov     x16, #0
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
        mov     x9, #0
        mov     x9, x9
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
        mov     x10, x0
        b     bb43
bb43:

        mov     x9, #81
        cmp     x10, x9
        b.ne     bb46
        b     bb45
bb46:

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
        mov     x10, x0
        b     bb43
bb45:

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
        mov     x0, x0
        mov     x1, x0
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
        mov     x0, x0
        mov     x1, x0
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
