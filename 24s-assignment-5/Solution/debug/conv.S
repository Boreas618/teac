.section .data
.global    max
.global    a
.global    b
.global    kernelid
max:
        .quad   1073741824
a:
        .zero   40000000
b:
        .zero   40000000
kernelid:
        .zero   40000
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global checkrange
.global mod
.global reduce
.global getvalue
.global convn
.global memmove
.global main
checkrange:

bb94:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0
        mov     w9, w10
        mov     w10, w9
        b     bb2
bb2:

        adrp     x9, max
        add     x9, x9, #:lo12:max
        ldr     w9, [x9]
        cmp     w10, w9
        b.gt     bb3
        b     bb4
bb3:

        adrp     x9, max
        add     x9, x9, #:lo12:max
        ldr     w9, [x9]
        sub     w9, w10, w9
        mov     w10, w9
        b     bb2
bb4:

        mov     w10, w10
        b     bb5
bb5:

        mov     w9, #0
        cmp     w10, w9
        b.lt     bb6
        b     bb7
bb6:

        adrp     x9, max
        add     x9, x9, #:lo12:max
        ldr     w9, [x9]
        add     w9, w10, w9
        mov     w10, w9
        b     bb5
bb7:

        mov     w0, w10
        mov     sp, x29
        ret
mod:

bb95:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w11, w1
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     w9, w11
        sdiv     w11, w10, w9
        mul     w9, w11, w9
        sub     w9, w10, w9
        mov     w0, w9
        mov     sp, x29
        ret
reduce:

bb96:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, w0
        mov     w11, w1
        mov     w10, w2
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w12, #0
        mov     w9, w9
        mov     w12, #0
        mov     w12, w11
        mov     w11, #0
        mov     w11, w10
        mov     w10, #0
        cmp     w9, w10
        b.eq     bb10
        b     bb11
bb10:

        add     w9, w12, w11
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     checkrange
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w0, w9
        mov     sp, x29
        ret
bb11:

        mov     w10, #1
        cmp     w9, w10
        b.eq     bb13
        b     bb14
bb13:

        mov     w9, #0
        mov     w10, w9
        mov     w9, #1
        mov     w9, w9
        mov     w10, w10
        mov     w9, w9
        b     bb16
bb16:

        adrp     x13, max
        add     x13, x13, #:lo12:max
        ldr     w13, [x13]
        cmp     w9, w13
        b.lt     bb17
        b     bb18
bb17:

        sdiv     w13, w12, w9
        mov     w0, w13
        mov     w13, #2
        mov     w1, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w13, w0
        sdiv     w14, w11, w9
        mov     w0, w14
        mov     w14, #2
        mov     w1, w14
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w14, w0
        cmp     w13, w14
        b.eq     bb19
        b     bb20
bb19:

        mov     w13, #2
        mul     w10, w10, w13
        mov     w13, w10
        b     bb21
bb20:

        mov     w13, #2
        mul     w10, w10, w13
        add     w10, w10, #1
        mov     w13, w10
        b     bb21
bb21:

        mov     w10, #2
        mul     w9, w9, w10
        mov     w10, w13
        mov     w9, w9
        b     bb16
bb18:

        mov     w0, w10
        mov     sp, x29
        ret
bb14:

        mov     w10, #2
        cmp     w9, w10
        b.eq     bb22
        b     bb23
bb22:

        cmp     w12, w11
        b.gt     bb25
        b     bb26
bb25:

        mov     w0, w12
        mov     sp, x29
        ret
bb26:

        mov     w0, w11
        mov     sp, x29
        ret
bb23:

        mov     w10, #3
        cmp     w9, w10
        b.eq     bb28
        b     bb29
bb28:

        mov     w9, #0
        mov     w10, w9
        mov     w9, #1
        mov     w9, w9
        mov     w10, w10
        mov     w9, w9
        b     bb31
bb31:

        adrp     x13, max
        add     x13, x13, #:lo12:max
        ldr     w13, [x13]
        cmp     w9, w13
        b.lt     bb32
        b     bb33
bb32:

        sdiv     w13, w12, w9
        mov     w0, w13
        mov     w13, #2
        mov     w1, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w14, w0
        mov     w13, #1
        cmp     w14, w13
        b.eq     bb34
        b     bb37
bb37:

        sdiv     w13, w11, w9
        mov     w0, w13
        mov     w13, #2
        mov     w1, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w14, w0
        mov     w13, #1
        cmp     w14, w13
        b.eq     bb34
        b     bb35
bb34:

        mov     w13, #2
        mul     w10, w10, w13
        add     w10, w10, #1
        mov     w13, w10
        b     bb36
bb35:

        mov     w13, #2
        mul     w10, w10, w13
        mov     w13, w10
        b     bb36
bb36:

        mov     w10, #2
        mul     w9, w9, w10
        mov     w10, w13
        mov     w9, w9
        b     bb31
bb33:

        mov     w0, w10
        mov     sp, x29
        ret
bb29:

        mov     w10, #4
        cmp     w9, w10
        b.eq     bb38
        b     bb39
bb38:

        mov     w9, #0
        mov     w13, w9
        mov     w9, #1
        mov     w9, w9
        mov     w10, w9
        mov     w9, w13
        b     bb41
bb41:

        adrp     x13, max
        add     x13, x13, #:lo12:max
        ldr     w13, [x13]
        cmp     w10, w13
        b.lt     bb42
        b     bb43
bb42:

        sdiv     w13, w12, w10
        mov     w0, w13
        mov     w13, #2
        mov     w1, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w14, w0
        mov     w13, #1
        cmp     w14, w13
        b.eq     bb47
        b     bb45
bb47:

        sdiv     w13, w11, w10
        mov     w0, w13
        mov     w13, #2
        mov     w1, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w14, w0
        mov     w13, #1
        cmp     w14, w13
        b.eq     bb44
        b     bb45
bb44:

        mov     w13, #2
        mul     w9, w9, w13
        add     w9, w9, #1
        mov     w13, w9
        b     bb46
bb45:

        mov     w13, #2
        mul     w9, w9, w13
        mov     w13, w9
        b     bb46
bb46:

        mov     w9, #2
        mul     w9, w10, w9
        mov     w10, w9
        mov     w9, w13
        b     bb41
bb43:

        mov     w0, w9
        mov     sp, x29
        ret
bb39:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
getvalue:

bb103:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     w14, w1
        mov     w11, w2
        mov     w10, w3
        mov     w9, w4
        mov     w12, #0
        mov     w12, #0
        mov     w12, w14
        mov     w14, #0
        mov     w11, w11
        mov     w14, #0
        mov     w10, w10
        mov     w14, #0
        mov     w9, w9
        mov     w14, #0
        cmp     w10, w14
        b.lt     bb49
        b     bb54
bb54:

        mov     w14, #0
        cmp     w9, w14
        b.lt     bb49
        b     bb53
bb53:

        cmp     w10, w12
        b.ge     bb49
        b     bb52
bb52:

        cmp     w9, w11
        b.ge     bb49
        b     bb50
bb49:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
bb50:

        mul     w10, w10, w11
        add     w10, w10, w9
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x13, x9
        ldr     w9, [x9]
        mov     w0, w9
        mov     sp, x29
        ret
convn:

bb105:

        mov     x16, #48
        sub     sp, sp, x16
        mov     w12, w0
        mov     x16, x1
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x16, x2
        mov     x17, #8
        str     x16, [sp,x17]
        mov     w11, w3
        mov     w10, w4
        mov     w9, w5
        mov     w13, #0
        mov     w13, #0
        mov     w13, #0
        mov     w13, #0
        mov     w13, #0
        mov     w13, #0
        mov     w13, #0
        mov     w13, #0
        mov     w16, w12
        mov     x17, #16
        str     x16, [sp,x17]
        mov     w12, #0
        mov     w16, w11
        mov     x17, #24
        str     x16, [sp,x17]
        mov     w11, #0
        mov     w16, w10
        mov     x17, #32
        str     x16, [sp,x17]
        mov     w10, #0
        mov     w16, w9
        mov     x17, #40
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w10, w9
        mov     w9, #0
        mov     w9, #1
        mov     w15, w9
        mov     w14, w10
        b     bb56
bb56:

        cmp     w15, w15
        b.eq     bb57
        b     bb58
bb57:

        mov     w9, #0
        mov     w9, w9
        mov     w13, w9
        b     bb59
bb59:

        cmp     w15, w15
        b.eq     bb60
        b     bb61
bb60:

        mov     w9, #0
        mov     w10, w9
        mov     w9, #2
        mov     x16, #40
        ldr     x19, [sp,x16]
        sdiv     w9, w19, w9
        sub     w9, w14, w9
        mov     w11, w10
        mov     w12, w9
        b     bb62
bb62:

        cmp     w15, w15
        b.eq     bb63
        mov     w11, w11
        b     bb64
bb63:

        mov     w9, #2
        mov     x16, #40
        ldr     x19, [sp,x16]
        sdiv     w9, w19, w9
        sub     w9, w13, w9
        mov     w11, w11
        mov     w9, w9
        b     bb65
bb65:

        cmp     w15, w15
        b.eq     bb66
        mov     w11, w11
        b     bb67
bb66:

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     w1, w19
        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     w2, w19
        mov     w3, w12
        mov     w4, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getvalue
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     w0, w19
        mov     w1, w11
        mov     w2, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     reduce
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0
        add     w10, w9, #1
        mov     w9, #2
        mov     x16, #40
        ldr     x19, [sp,x16]
        sdiv     w9, w19, w9
        add     w9, w13, w9
        cmp     w10, w9
        b.ge     bb68
        b     bb69
bb68:

        mov     w11, w11
        b     bb67
bb69:

        mov     w11, w11
        mov     w9, w10
        b     bb65
bb67:

        add     w10, w12, #1
        mov     w9, #2
        mov     x16, #40
        ldr     x19, [sp,x16]
        sdiv     w9, w19, w9
        add     w9, w14, w9
        cmp     w10, w9
        b.ge     bb71
        b     bb72
bb71:

        mov     w11, w11
        b     bb64
bb72:

        mov     w11, w11
        mov     w12, w10
        b     bb62
bb64:

        mov     x16, #32
        ldr     x19, [sp,x16]
        mul     w9, w14, w19
        add     w10, w9, w13
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w11, [x9]
        add     w9, w13, #1
        mov     x16, #32
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb74
        b     bb75
bb74:

        b     bb61
bb75:

        mov     w13, w9
        b     bb59
bb61:

        add     w9, w14, #1
        mov     x16, #24
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb77
        b     bb78
bb77:

        b     bb58
bb78:

        mov     w14, w9
        b     bb56
bb58:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
memmove:

bb110:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x12, x1
        mov     w10, w2
        mov     w9, #0
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb81
bb81:

        cmp     w9, w10
        b.lt     bb82
        b     bb83
bb82:

        mov     x11, #4
        mul     x11, x9, x11
        add     x11, x12, x11
        ldr     w11, [x11]
        mov     x14, #4
        mul     x14, x9, x14
        add     x14, x13, x14
        str     w11, [x14]
        add     w9, w9, #1
        mov     w9, w9
        b     bb81
bb83:

        mov     sp, x29
        ret
main:

bb84:

        mov     x16, #16
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
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
        mov     w15, w0
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
        mov     w14, w0
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
        mov     w13, w0
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
        mov     w12, w0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w11, w9
        b     bb85
bb85:

        cmp     w11, w12
        b.lt     bb86
        b     bb87
bb86:

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
        mov     w16, w0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x9, #4
        mul     x10, x11, x9
        adrp     x9, a
        add     x9, x9, #:lo12:a
        add     x9, x9, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        str     w19, [x9]
        add     w9, w11, #1
        mov     w11, w9
        b     bb85
bb87:

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
        mov     w12, w0
        mov     w9, #0
        mov     w9, w9
        mov     w11, w9
        b     bb88
bb88:

        cmp     w11, w12
        b.lt     bb89
        b     bb90
bb89:

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
        mov     w16, w0
        mov     x17, #8
        str     x16, [sp,x17]
        mov     x9, #4
        mul     x10, x11, x9
        adrp     x9, kernelid
        add     x9, x9, #:lo12:kernelid
        add     x9, x9, x10
        mov     x16, #8
        ldr     x19, [sp,x16]
        str     w19, [x9]
        add     w9, w11, #1
        mov     w11, w9
        b     bb88
bb90:

        mov     w10, w12
        mov     w9, #209
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
        mov     w9, w9
        mov     w9, w9
        b     bb91
bb91:

        cmp     w9, w10
        b.lt     bb92
        b     bb93
bb92:

        mov     x11, #4
        mul     x12, x9, x11
        adrp     x11, kernelid
        add     x11, x11, #:lo12:kernelid
        add     x11, x11, x12
        ldr     w11, [x11]
        mov     w0, w11
        adrp     x11, a
        add     x11, x11, #:lo12:a
        mov     x1, x11
        adrp     x11, b
        add     x11, x11, #:lo12:b
        mov     x2, x11
        mov     w3, w14
        mov     w4, w13
        mov     w5, w15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     convn
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mul     w11, w14, w13
        adrp     x12, a
        add     x12, x12, #:lo12:a
        mov     x0, x12
        adrp     x12, b
        add     x12, x12, #:lo12:b
        mov     x1, x12
        mov     w2, w11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     memmove
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        add     w9, w9, #1
        mov     w9, w9
        b     bb91
bb93:

        mov     w9, #312
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
        mul     w9, w14, w13
        mov     w0, w9
        adrp     x9, a
        add     x9, x9, #:lo12:a
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putarray
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
