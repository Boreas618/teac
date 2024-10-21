.section .data
.global    n
.global    m
.global    to
.global    next
.global    head
.global    cnt
.global    que
.global    h
.global    tail
.global    inq
n:
        .quad   0
m:
        .quad   0
to:
        .zero   40040
next:
        .zero   40040
head:
        .zero   8040
cnt:
        .quad   0
que:
        .zero   8040
h:
        .quad   0
tail:
        .quad   0
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
        mov     w9, #0
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w10, #0
        mov     w10, #0
        mov     w10, w10
        mov     w10, w10
        mov     w12, w11
        b     bb2
bb2:

        mov     w11, #48
        cmp     w12, w11
        b.lt     bb3
        b     bb5
bb5:

        mov     w11, #57
        cmp     w12, w11
        b.gt     bb3
        b     bb4
bb3:

        mov     w11, #45
        cmp     w12, w11
        b.eq     bb6
        b     bb7
bb6:

        mov     w10, #1
        mov     w10, w10
        mov     w10, w10
        b     bb8
bb7:

        mov     w10, w10
        b     bb8
bb8:

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0
        mov     w10, w10
        mov     w12, w11
        b     bb2
bb4:

        mov     w9, w9
        mov     w12, w12
        b     bb9
bb9:

        mov     w11, #48
        cmp     w12, w11
        b.ge     bb12
        b     bb11
bb12:

        mov     w11, #57
        cmp     w12, w11
        b.le     bb10
        b     bb11
bb10:

        mov     w11, #10
        mul     w9, w9, w11
        add     w9, w9, w12
        sub     w9, w9, #48
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0
        mov     w9, w9
        mov     w12, w11
        b     bb9
bb11:

        mov     w11, #0
        cmp     w10, w11
        b.ne     bb13
        b     bb14
bb13:

        mov     w10, #0
        sub     w9, w10, w9
        mov     w0, w9
        mov     sp, x29
        ret
bb14:

        mov     w0, w9
        mov     sp, x29
        ret
addedge:

bb52:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w11, w1
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     w9, w11
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w12, [x11]
        mov     x11, #8
        mul     x12, x12, x11
        adrp     x11, to
        add     x11, x11, #:lo12:to
        add     x11, x11, x12
        str     w9, [x11]
        mov     x11, #8
        mul     x12, x10, x11
        adrp     x11, head
        add     x11, x11, #:lo12:head
        add     x11, x11, x12
        ldr     w11, [x11]
        adrp     x12, cnt
        add     x12, x12, #:lo12:cnt
        ldr     w13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adrp     x12, next
        add     x12, x12, #:lo12:next
        add     x12, x12, x13
        str     w11, [x12]
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w13, [x11]
        mov     x11, #8
        mul     x12, x10, x11
        adrp     x11, head
        add     x11, x11, #:lo12:head
        add     x11, x11, x12
        str     w13, [x11]
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w11, [x11]
        add     w12, w11, #1
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        str     w12, [x11]
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w12, [x11]
        mov     x11, #8
        mul     x12, x12, x11
        adrp     x11, to
        add     x11, x11, #:lo12:to
        add     x11, x11, x12
        str     w10, [x11]
        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, head
        add     x10, x10, #:lo12:head
        add     x10, x10, x11
        ldr     w10, [x10]
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w12, [x11]
        mov     x11, #8
        mul     x12, x12, x11
        adrp     x11, next
        add     x11, x11, #:lo12:next
        add     x11, x11, x12
        str     w10, [x11]
        adrp     x10, cnt
        add     x10, x10, #:lo12:cnt
        ldr     w11, [x10]
        mov     x10, #8
        mul     x10, x9, x10
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x10
        str     w11, [x9]
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w9, [x9]
        add     w10, w9, #1
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        str     w10, [x9]
        mov     sp, x29
        ret
init:

bb17:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb18
bb18:

        mov     w10, #1005
        cmp     w9, w10
        b.lt     bb19
        b     bb20
bb19:

        mov     w10, #0
        sub     w12, w10, #1
        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, head
        add     x10, x10, #:lo12:head
        add     x10, x10, x11
        str     w12, [x10]
        add     w9, w9, #1
        mov     w9, w9
        b     bb18
bb20:

        mov     sp, x29
        ret
inqueue:

bb53:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0
        mov     w9, w10
        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, inq
        add     x10, x10, #:lo12:inq
        add     x11, x10, x11
        mov     w10, #1
        str     w10, [x11]
        adrp     x10, tail
        add     x10, x10, #:lo12:tail
        ldr     w10, [x10]
        add     w11, w10, #1
        adrp     x10, tail
        add     x10, x10, #:lo12:tail
        str     w11, [x10]
        adrp     x10, tail
        add     x10, x10, #:lo12:tail
        ldr     w11, [x10]
        mov     x10, #8
        mul     x11, x11, x10
        adrp     x10, que
        add     x10, x10, #:lo12:que
        add     x10, x10, x11
        str     w9, [x10]
        mov     sp, x29
        ret
popqueue:

bb22:

        mov     x16, #0
        sub     sp, sp, x16
        adrp     x9, h
        add     x9, x9, #:lo12:h
        ldr     w9, [x9]
        add     w10, w9, #1
        adrp     x9, h
        add     x9, x9, #:lo12:h
        str     w10, [x9]
        mov     w9, #0
        adrp     x9, h
        add     x9, x9, #:lo12:h
        ldr     w10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adrp     x9, que
        add     x9, x9, #:lo12:que
        add     x9, x9, x10
        adrp     x9, h
        add     x9, x9, #:lo12:h
        ldr     w10, [x9]
        mov     x9, #8
        mul     x10, x10, x9
        adrp     x9, que
        add     x9, x9, #:lo12:que
        add     x9, x9, x10
        ldr     w9, [x9]
        mov     w0, w9
        mov     sp, x29
        ret
same:

bb54:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w11, w0
        mov     w10, w1
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w11
        mov     w11, #0
        mov     w11, w10
        mov     w12, #0
        adrp     x10, h
        add     x10, x10, #:lo12:h
        str     w12, [x10]
        mov     w12, #0
        adrp     x10, tail
        add     x10, x10, #:lo12:tail
        str     w12, [x10]
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     inqueue
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w10, w9
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w10, w10
        b     bb24
bb24:

        adrp     x9, h
        add     x9, x9, #:lo12:h
        ldr     w12, [x9]
        adrp     x9, tail
        add     x9, x9, #:lo12:tail
        ldr     w9, [x9]
        cmp     w12, w9
        b.lt     bb25
        b     bb26
bb25:

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     popqueue
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        cmp     w12, w11
        b.eq     bb27
        b     bb28
bb27:

        mov     w9, #1
        mov     w9, w9
        mov     w10, w9
        b     bb29
bb28:

        mov     w10, w10
        b     bb29
bb29:

        mov     x9, #8
        mul     x12, x12, x9
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x12
        ldr     w9, [x9]
        mov     w9, w9
        b     bb30
bb30:

        mov     w12, #0
        sub     w12, w12, #1
        cmp     w9, w12
        b.ne     bb31
        b     bb32
bb31:

        mov     x12, #8
        mul     x13, x9, x12
        adrp     x12, to
        add     x12, x12, #:lo12:to
        add     x12, x12, x13
        ldr     w13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adrp     x12, inq
        add     x12, x12, #:lo12:inq
        add     x12, x12, x13
        ldr     w13, [x12]
        mov     w12, #0
        cmp     w13, w12
        b.eq     bb33
        b     bb34
bb33:

        mov     x12, #8
        mul     x13, x9, x12
        adrp     x12, to
        add     x12, x12, #:lo12:to
        add     x12, x12, x13
        ldr     w12, [x12]
        mov     w0, w12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     inqueue
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb35
bb34:

        b     bb35
bb35:

        mov     x12, #8
        mul     x12, x9, x12
        adrp     x9, next
        add     x9, x9, #:lo12:next
        add     x9, x9, x12
        ldr     w9, [x9]
        mov     w9, w9
        b     bb30
bb32:

        mov     w10, w10
        b     bb24
bb26:

        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb36
bb36:

        adrp     x11, tail
        add     x11, x11, #:lo12:tail
        ldr     w11, [x11]
        cmp     w9, w11
        b.le     bb37
        b     bb38
bb37:

        mov     x11, #8
        mul     x12, x9, x11
        adrp     x11, que
        add     x11, x11, #:lo12:que
        add     x11, x11, x12
        ldr     w12, [x11]
        mov     x11, #8
        mul     x12, x12, x11
        adrp     x11, inq
        add     x11, x11, #:lo12:inq
        add     x12, x11, x12
        mov     w11, #0
        str     w11, [x12]
        add     w9, w9, #1
        mov     w9, w9
        b     bb36
bb38:

        mov     w0, w10
        mov     sp, x29
        ret
main:

bb39:

        mov     x16, #0
        sub     sp, sp, x16
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
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
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     w10, [x9]
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
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     init
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
        mov     w9, #0
        b     bb40
bb40:

        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     w10, [x9]
        mov     w9, #0
        cmp     w10, w9
        b.ne     bb41
        b     bb42
bb41:

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w10, w9
        b     bb43
bb43:

        mov     w9, #81
        cmp     w10, w9
        b.ne     bb46
        b     bb45
bb46:

        mov     w9, #85
        cmp     w10, w9
        b.ne     bb44
        b     bb45
bb44:

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w10, w9
        b     bb43
bb45:

        mov     w9, #81
        cmp     w10, w9
        b.eq     bb47
        b     bb48
bb47:

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w0, w10
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     same
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
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
        b     bb49
bb48:

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w0, w10
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     addedge
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb49
bb49:

        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     w9, [x9]
        sub     w10, w9, #1
        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     w10, [x9]
        b     bb40
bb42:

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
