.section .data

max:

        .word   1073741824
a:

        .zero   80000000
b:

        .zero   80000000
kernelid:

        .zero   80000
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
        mov     x10, x0
        mov     x9, #0
        mov     x9, x9
        mov     x9, x10
        mov     x10, x9
        b     bb2
bb2:

        adr     x9, max
        ldr     x9, [x9]
        cmp     x10, x9
        b.gt     bb3
        b     bb4
bb3:

        adr     x9, max
        ldr     x9, [x9]
        sub     x9, x10, x9
        mov     x10, x9
        b     bb2
bb4:

        mov     x10, x10
        b     bb5
bb5:

        mov     x9, #0
        cmp     x10, x9
        b.lt     bb6
        b     bb7
bb6:

        adr     x9, max
        ldr     x9, [x9]
        add     x9, x10, x9
        mov     x10, x9
        b     bb5
bb7:

        mov     x0, x10
        mov     sp, x29
        ret
mod:

bb95:

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
        sdiv     x11, x10, x9
        mul     x9, x11, x9
        sub     x9, x10, x9
        mov     x0, x9
        mov     sp, x29
        ret
reduce:

bb96:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x12, x0
        mov     x11, x1
        mov     x10, x2
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
        mov     x9, #0
        mov     x9, x9
        mov     x12, x12
        mov     x9, #0
        mov     x9, x9
        mov     x11, x11
        mov     x9, #0
        mov     x9, x9
        mov     x10, x10
        mov     x9, #0
        cmp     x12, x9
        b.eq     bb10
        b     bb11
bb10:

        add     x9, x11, x10
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
        bl     checkrange
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
        mov     sp, x29
        ret
bb11:

        mov     x9, #1
        cmp     x12, x9
        b.eq     bb13
        b     bb14
bb13:

        mov     x9, #0
        mov     x12, x9
        mov     x9, #1
        mov     x9, x9
        mov     x13, x12
        mov     x9, x9
        b     bb16
bb16:

        adr     x12, max
        ldr     x12, [x12]
        cmp     x9, x12
        b.lt     bb17
        b     bb18
bb17:

        sdiv     x12, x11, x9
        mov     x0, x12
        mov     x12, #2
        mov     x1, x12
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
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        sdiv     x12, x10, x9
        mov     x0, x12
        mov     x12, #2
        mov     x1, x12
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
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        cmp     x0, x0
        b.eq     bb19
        b     bb20
bb19:

        mov     x12, #2
        mul     x12, x13, x12
        mov     x13, x12
        b     bb21
bb20:

        mov     x12, #2
        mul     x12, x13, x12
        add     x12, x12, #1
        mov     x13, x12
        b     bb21
bb21:

        mov     x12, #2
        mul     x9, x9, x12
        mov     x13, x13
        mov     x9, x9
        b     bb16
bb18:

        mov     x0, x13
        mov     sp, x29
        ret
bb14:

        mov     x9, #2
        cmp     x12, x9
        b.eq     bb22
        b     bb23
bb22:

        cmp     x11, x10
        b.gt     bb25
        b     bb26
bb25:

        mov     x0, x11
        mov     sp, x29
        ret
bb26:

        mov     x0, x10
        mov     sp, x29
        ret
bb23:

        mov     x9, #3
        cmp     x12, x9
        b.eq     bb28
        b     bb29
bb28:

        mov     x9, #0
        mov     x12, x9
        mov     x9, #1
        mov     x9, x9
        mov     x13, x12
        mov     x9, x9
        b     bb31
bb31:

        adr     x12, max
        ldr     x12, [x12]
        cmp     x9, x12
        b.lt     bb32
        b     bb33
bb32:

        sdiv     x12, x11, x9
        mov     x0, x12
        mov     x12, #2
        mov     x1, x12
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
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x12, #1
        cmp     x0, x12
        b.eq     bb34
        b     bb37
bb37:

        sdiv     x12, x10, x9
        mov     x0, x12
        mov     x12, #2
        mov     x1, x12
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
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x12, #1
        cmp     x0, x12
        b.eq     bb34
        b     bb35
bb34:

        mov     x12, #2
        mul     x12, x13, x12
        add     x12, x12, #1
        mov     x13, x12
        b     bb36
bb35:

        mov     x12, #2
        mul     x12, x13, x12
        mov     x13, x12
        b     bb36
bb36:

        mov     x12, #2
        mul     x9, x9, x12
        mov     x13, x13
        mov     x9, x9
        b     bb31
bb33:

        mov     x0, x13
        mov     sp, x29
        ret
bb29:

        mov     x9, #4
        cmp     x12, x9
        b.eq     bb38
        b     bb39
bb38:

        mov     x9, #0
        mov     x12, x9
        mov     x9, #1
        mov     x9, x9
        mov     x9, x9
        mov     x13, x12
        b     bb41
bb41:

        adr     x12, max
        ldr     x12, [x12]
        cmp     x9, x12
        b.lt     bb42
        b     bb43
bb42:

        sdiv     x12, x11, x9
        mov     x0, x12
        mov     x12, #2
        mov     x1, x12
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
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x12, #1
        cmp     x0, x12
        b.eq     bb47
        b     bb45
bb47:

        sdiv     x12, x10, x9
        mov     x0, x12
        mov     x12, #2
        mov     x1, x12
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
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x12, #1
        cmp     x0, x12
        b.eq     bb44
        b     bb45
bb44:

        mov     x12, #2
        mul     x12, x13, x12
        add     x12, x12, #1
        mov     x13, x12
        b     bb46
bb45:

        mov     x12, #2
        mul     x12, x13, x12
        mov     x13, x12
        b     bb46
bb46:

        mov     x12, #2
        mul     x9, x9, x12
        mov     x9, x9
        mov     x13, x13
        b     bb41
bb43:

        mov     x0, x13
        mov     sp, x29
        ret
bb39:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
getvalue:

bb103:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     x14, x1
        mov     x13, x2
        mov     x12, x3
        mov     x11, x4
        mov     x10, #0
        mov     x9, x10
        mov     x10, #0
        mov     x9, x10
        mov     x14, x14
        mov     x10, #0
        mov     x9, x10
        mov     x13, x13
        mov     x10, #0
        mov     x9, x10
        mov     x12, x12
        mov     x10, #0
        mov     x9, x10
        mov     x11, x11
        mov     x10, #0
        cmp     x12, x10
        b.lt     bb49
        b     bb54
bb54:

        mov     x10, #0
        cmp     x11, x10
        b.lt     bb49
        b     bb53
bb53:

        cmp     x12, x14
        b.ge     bb49
        b     bb52
bb52:

        cmp     x11, x13
        b.ge     bb49
        b     bb50
bb49:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
bb50:

        mul     x10, x12, x13
        add     x11, x10, x11
        mov     x10, #8
        mul     x10, x11, x10
        add     x9, x9, x10
        ldr     x9, [x9]
        mov     x0, x9
        mov     sp, x29
        ret
convn:

bb105:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x23, x1
        mov     x22, x2
        mov     x12, x3
        mov     x10, x4
        mov     x9, x5
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x21, x13
        mov     x11, #0
        mov     x9, x11
        mov     x20, x12
        mov     x11, #0
        mov     x9, x11
        mov     x15, x10
        mov     x10, #0
        mov     x9, x10
        mov     x14, x9
        mov     x9, #0
        mov     x10, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #1
        mov     x13, x9
        mov     x12, x10
        b     bb56
bb56:

        cmp     x13, x13
        b.eq     bb57
        b     bb58
bb57:

        mov     x9, #0
        mov     x9, x9
        mov     x11, x9
        b     bb59
bb59:

        cmp     x13, x13
        b.eq     bb60
        b     bb61
bb60:

        mov     x9, #0
        mov     x10, x9
        mov     x9, #2
        sdiv     x9, x14, x9
        sub     x9, x12, x9
        mov     x10, x10
        mov     x9, x9
        b     bb62
bb62:

        cmp     x13, x13
        b.eq     bb63
        mov     x24, x10
        b     bb64
bb63:

        mov     x24, #2
        sdiv     x24, x14, x24
        sub     x24, x11, x24
        mov     x24, x24
        mov     x10, x10
        b     bb65
bb65:

        cmp     x13, x13
        b.eq     bb66
        mov     x10, x10
        b     bb67
bb66:

        mov     x0, x23
        mov     x1, x20
        mov     x2, x15
        mov     x3, x9
        mov     x4, x24
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
        bl     getvalue
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x0, x21
        mov     x1, x10
        mov     x2, x0
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
        bl     reduce
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        add     x24, x24, #1
        mov     x10, #2
        sdiv     x10, x14, x10
        add     x10, x11, x10
        cmp     x24, x10
        b.ge     bb68
        b     bb69
bb68:

        mov     x10, x0
        b     bb67
bb69:

        mov     x24, x24
        mov     x10, x0
        b     bb65
bb67:

        add     x24, x9, #1
        mov     x9, #2
        sdiv     x9, x14, x9
        add     x9, x12, x9
        cmp     x24, x9
        b.ge     bb71
        b     bb72
bb71:

        mov     x24, x10
        b     bb64
bb72:

        mov     x10, x10
        mov     x9, x24
        b     bb62
bb64:

        mul     x9, x12, x15
        add     x10, x9, x11
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x22, x9
        str     x24, [x9]
        add     x9, x11, #1
        cmp     x9, x15
        b.ge     bb74
        b     bb75
bb74:

        b     bb61
bb75:

        mov     x11, x9
        b     bb59
bb61:

        add     x9, x12, #1
        cmp     x9, x20
        b.ge     bb77
        b     bb78
bb77:

        b     bb58
bb78:

        mov     x12, x9
        b     bb56
bb58:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
memmove:

bb110:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, x1
        mov     x12, x2
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x13, x12
        mov     x11, #0
        mov     x11, x11
        mov     x12, x11
        b     bb81
bb81:

        cmp     x12, x13
        b.lt     bb82
        b     bb83
bb82:

        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x9, x11
        ldr     x14, [x11]
        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x10, x11
        str     x14, [x11]
        add     x11, x12, #1
        mov     x12, x11
        b     bb81
bb83:

        mov     sp, x29
        ret
main:

bb84:

        mov     x16, #0
        sub     sp, sp, x16
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
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x11, x9
        b     bb85
bb85:

        cmp     x11, x0
        b.lt     bb86
        b     bb87
bb86:

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
        mov     x9, #8
        mul     x10, x11, x9
        adr     x9, a
        add     x9, x9, x10
        str     x0, [x9]
        add     x9, x11, #1
        mov     x11, x9
        b     bb85
bb87:

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
        mov     x9, #0
        mov     x9, x9
        mov     x11, x9
        b     bb88
bb88:

        cmp     x11, x0
        b.lt     bb89
        b     bb90
bb89:

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
        mov     x9, #8
        mul     x10, x11, x9
        adr     x9, kernelid
        add     x9, x9, x10
        str     x0, [x9]
        add     x9, x11, #1
        mov     x11, x9
        b     bb88
bb90:

        mov     x12, x0
        mov     x9, #209
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
        bl     _sysy_starttime
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
        mov     x11, x9
        b     bb91
bb91:

        cmp     x11, x12
        b.lt     bb92
        b     bb93
bb92:

        mov     x9, #8
        mul     x10, x11, x9
        adr     x9, kernelid
        add     x9, x9, x10
        ldr     x9, [x9]
        mov     x0, x9
        adr     x9, a
        ldr     x9, [x9]
        mov     x1, x9
        adr     x9, b
        ldr     x9, [x9]
        mov     x2, x9
        mov     x3, x0
        mov     x4, x0
        mov     x5, x0
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
        bl     convn
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mul     x10, x0, x0
        adr     x9, a
        ldr     x9, [x9]
        mov     x0, x9
        adr     x9, b
        ldr     x9, [x9]
        mov     x1, x9
        mov     x2, x10
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
        bl     memmove
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
        b     bb91
bb93:

        mov     x9, #312
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
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mul     x9, x0, x0
        mov     x0, x9
        adr     x9, a
        ldr     x9, [x9]
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
        bl     putarray
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
