.section .data

n:

        .zero   8
.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global bubblesort
.global insertsort
.global QuickSort
.global getMid
.global getMost
.global revert
.global arrCopy
.global calSum
.global avgPooling
.global main
bubblesort:

bb1:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
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
        mov     x10, x9
        b     bb2
bb2:

        adr     x9, n
        ldr     x9, [x9]
        sub     x9, x9, #1
        cmp     x10, x9
        b.lt     bb3
        b     bb4
bb3:

        mov     x9, #0
        mov     x9, x9
        mov     x9, x9
        b     bb5
bb5:

        adr     x12, n
        ldr     x12, [x12]
        sub     x12, x12, x10
        sub     x12, x12, #1
        cmp     x9, x12
        b.lt     bb6
        b     bb7
bb6:

        add     x13, x9, #1
        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        ldr     x14, [x12]
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x11, x12
        ldr     x12, [x12]
        cmp     x14, x12
        b.gt     bb8
        b     bb9
bb8:

        add     x14, x9, #1
        mov     x12, #8
        mul     x12, x14, x12
        add     x12, x11, x12
        ldr     x13, [x12]
        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        ldr     x15, [x12]
        mov     x12, #8
        mul     x12, x14, x12
        add     x12, x11, x12
        str     x15, [x12]
        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        str     x13, [x12]
        b     bb10
bb9:

        b     bb10
bb10:

        add     x9, x9, #1
        mov     x9, x9
        b     bb5
bb7:

        add     x9, x10, #1
        mov     x10, x9
        b     bb2
bb4:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
insertsort:

bb11:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x12, x0
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
        mov     x11, x9
        b     bb12
bb12:

        adr     x9, n
        ldr     x9, [x9]
        cmp     x11, x9
        b.lt     bb13
        b     bb14
bb13:

        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x12, x9
        ldr     x10, [x9]
        sub     x9, x11, #1
        mov     x9, x9
        b     bb15
bb15:

        mov     x13, #0
        sub     x13, x13, #1
        cmp     x9, x13
        b.gt     bb18
        b     bb17
bb18:

        mov     x13, #8
        mul     x13, x9, x13
        add     x13, x12, x13
        ldr     x13, [x13]
        cmp     x10, x13
        b.lt     bb16
        b     bb17
bb16:

        add     x14, x9, #1
        mov     x13, #8
        mul     x13, x9, x13
        add     x13, x12, x13
        ldr     x15, [x13]
        mov     x13, #8
        mul     x13, x14, x13
        add     x13, x12, x13
        str     x15, [x13]
        sub     x9, x9, #1
        mov     x9, x9
        b     bb15
bb17:

        add     x13, x9, #1
        mov     x9, #8
        mul     x9, x13, x9
        add     x9, x12, x9
        str     x10, [x9]
        add     x9, x11, #1
        mov     x11, x9
        b     bb12
bb14:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
QuickSort:

bb104:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x14, x0
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
        mov     x13, x11
        mov     x9, #0
        mov     x9, x9
        mov     x12, x10
        cmp     x13, x12
        b.lt     bb20
        b     bb21
bb20:

        mov     x15, x13
        mov     x10, x12
        mov     x9, #8
        mul     x9, x13, x9
        add     x9, x14, x9
        ldr     x11, [x9]
        mov     x10, x10
        mov     x9, x15
        b     bb23
bb23:

        cmp     x9, x10
        b.lt     bb24
        b     bb25
bb24:

        mov     x10, x10
        b     bb26
bb26:

        cmp     x9, x10
        b.lt     bb29
        b     bb28
bb29:

        mov     x15, #8
        mul     x15, x10, x15
        add     x15, x14, x15
        ldr     x20, [x15]
        sub     x15, x11, #1
        cmp     x20, x15
        b.gt     bb27
        b     bb28
bb27:

        sub     x10, x10, #1
        mov     x10, x10
        b     bb26
bb28:

        cmp     x9, x10
        b.lt     bb30
        b     bb31
bb30:

        mov     x15, #8
        mul     x15, x10, x15
        add     x15, x14, x15
        ldr     x20, [x15]
        mov     x15, #8
        mul     x15, x9, x15
        add     x15, x14, x15
        str     x20, [x15]
        add     x9, x9, #1
        mov     x9, x9
        b     bb32
bb31:

        mov     x9, x9
        b     bb32
bb32:

        mov     x9, x9
        b     bb33
bb33:

        cmp     x9, x10
        b.lt     bb36
        b     bb35
bb36:

        mov     x15, #8
        mul     x15, x9, x15
        add     x15, x14, x15
        ldr     x15, [x15]
        cmp     x15, x11
        b.lt     bb34
        b     bb35
bb34:

        add     x9, x9, #1
        mov     x9, x9
        b     bb33
bb35:

        cmp     x9, x10
        b.lt     bb37
        b     bb38
bb37:

        mov     x15, #8
        mul     x15, x9, x15
        add     x15, x14, x15
        ldr     x20, [x15]
        mov     x15, #8
        mul     x15, x10, x15
        add     x15, x14, x15
        str     x20, [x15]
        sub     x10, x10, #1
        mov     x10, x10
        b     bb39
bb38:

        mov     x10, x10
        b     bb39
bb39:

        mov     x10, x10
        mov     x9, x9
        b     bb23
bb25:

        mov     x10, #8
        mul     x10, x9, x10
        add     x10, x14, x10
        str     x11, [x10]
        sub     x10, x9, #1
        mov     x0, x14
        mov     x1, x13
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
        bl     QuickSort
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        add     x9, x9, #1
        mov     x0, x14
        mov     x1, x9
        mov     x2, x12
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
        bl     QuickSort
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb22
bb21:

        b     bb22
bb22:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
getMid:

bb40:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     x10, #0
        mov     x9, x10
        mov     x10, #0
        mov     x9, x10
        adr     x10, n
        ldr     x11, [x10]
        mov     x10, #2
        sdiv     x11, x11, x10
        mov     x10, #2
        mul     x11, x11, x10
        adr     x10, n
        ldr     x10, [x10]
        cmp     x11, x10
        b.eq     bb41
        b     bb42
bb41:

        adr     x10, n
        ldr     x11, [x10]
        mov     x10, #2
        sdiv     x12, x11, x10
        sub     x11, x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x9, x10
        ldr     x12, [x10]
        mov     x10, #8
        mul     x10, x11, x10
        add     x9, x9, x10
        ldr     x9, [x9]
        add     x10, x12, x9
        mov     x9, #2
        sdiv     x9, x10, x9
        mov     x0, x9
        mov     sp, x29
        ret
bb42:

        adr     x10, n
        ldr     x11, [x10]
        mov     x10, #2
        sdiv     x11, x11, x10
        mov     x10, #8
        mul     x10, x11, x10
        add     x9, x9, x10
        ldr     x9, [x9]
        mov     x0, x9
        mov     sp, x29
        ret
getMost:

bb44:

        mov     x16, #8000
        sub     sp, sp, x16
        mov     x13, x0
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x10, #0
        mov     x9, x10
        mov     x10, #0
        mov     x9, x10
        mov     x10, #0
        mov     x10, x10
        mov     x12, x10
        b     bb45
bb45:

        mov     x10, #1000
        cmp     x12, x10
        b.lt     bb46
        b     bb47
bb46:

        mov     x10, #8
        mul     x11, x12, x10
        mov     x10, #-8
        add     x10, x29, x10
        add     x11, x10, x11
        mov     x10, #0
        str     x10, [x11]
        add     x10, x12, #1
        mov     x12, x10
        b     bb45
bb47:

        mov     x10, #0
        mov     x11, x10
        mov     x10, #0
        mov     x10, x10
        mov     x12, x11
        mov     x11, x10
        mov     x10, x9
        b     bb48
bb48:

        adr     x9, n
        ldr     x9, [x9]
        cmp     x12, x9
        b.lt     bb49
        b     bb50
bb49:

        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x9, [x9]
        mov     x14, #8
        mul     x15, x9, x14
        mov     x14, #-8
        add     x14, x29, x14
        add     x14, x14, x15
        ldr     x14, [x14]
        add     x20, x14, #1
        mov     x14, #8
        mul     x15, x9, x14
        mov     x14, #-8
        add     x14, x29, x14
        add     x14, x14, x15
        str     x20, [x14]
        mov     x14, #8
        mul     x15, x9, x14
        mov     x14, #-8
        add     x14, x29, x14
        add     x14, x14, x15
        ldr     x14, [x14]
        cmp     x14, x11
        b.gt     bb51
        b     bb52
bb51:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-8
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     x10, [x10]
        mov     x9, x9
        mov     x11, x10
        mov     x10, x9
        b     bb53
bb52:

        mov     x11, x11
        mov     x10, x10
        b     bb53
bb53:

        add     x9, x12, #1
        mov     x12, x9
        mov     x11, x11
        mov     x10, x10
        b     bb48
bb50:

        mov     x0, x10
        mov     sp, x29
        ret
revert:

bb54:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x12, x9
        mov     x9, #0
        mov     x9, x9
        mov     x10, x9
        mov     x9, x12
        b     bb55
bb55:

        cmp     x9, x10
        b.lt     bb56
        b     bb57
bb56:

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        ldr     x13, [x12]
        mov     x12, #8
        mul     x12, x10, x12
        add     x12, x11, x12
        ldr     x14, [x12]
        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        str     x14, [x12]
        mov     x12, #8
        mul     x12, x10, x12
        add     x12, x11, x12
        str     x13, [x12]
        add     x12, x9, #1
        sub     x9, x10, #1
        mov     x10, x9
        mov     x9, x12
        b     bb55
bb57:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
arrCopy:

bb58:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x12, x1
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x10, x9
        b     bb59
bb59:

        adr     x9, n
        ldr     x9, [x9]
        cmp     x10, x9
        b.lt     bb60
        b     bb61
bb60:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        ldr     x11, [x9]
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        str     x11, [x9]
        add     x9, x10, #1
        mov     x10, x9
        b     bb59
bb61:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
calSum:

bb107:

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
        mov     x10, x10
        mov     x9, #0
        mov     x12, x9
        mov     x9, #0
        mov     x9, x9
        mov     x13, x12
        mov     x9, x9
        b     bb63
bb63:

        adr     x12, n
        ldr     x12, [x12]
        cmp     x9, x12
        b.lt     bb64
        b     bb65
bb64:

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        ldr     x12, [x12]
        add     x13, x13, x12
        sdiv     x12, x9, x10
        mul     x12, x12, x10
        sub     x14, x9, x12
        sub     x12, x10, #1
        cmp     x14, x12
        b.ne     bb66
        b     bb67
bb66:

        mov     x12, #8
        mul     x12, x9, x12
        add     x14, x11, x12
        mov     x12, #0
        str     x12, [x14]
        mov     x12, x13
        b     bb68
bb67:

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        str     x13, [x12]
        mov     x12, #0
        mov     x12, x12
        mov     x12, x12
        b     bb68
bb68:

        add     x9, x9, #1
        mov     x13, x12
        mov     x9, x9
        b     bb63
bb65:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
avgPooling:

bb108:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x11, x1
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x10, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x12, x11
        mov     x9, #0
        mov     x14, x9
        mov     x9, #0
        mov     x9, x9
        mov     x11, x9
        mov     x10, x10
        mov     x9, x14
        b     bb70
bb70:

        adr     x14, n
        ldr     x14, [x14]
        cmp     x9, x14
        b.lt     bb71
        b     bb72
bb71:

        sub     x14, x12, #1
        cmp     x9, x14
        b.lt     bb73
        b     bb74
bb73:

        mov     x14, #8
        mul     x14, x9, x14
        add     x14, x13, x14
        ldr     x14, [x14]
        add     x11, x11, x14
        mov     x11, x11
        mov     x10, x10
        b     bb75
bb74:

        sub     x14, x12, #1
        cmp     x9, x14
        b.eq     bb76
        b     bb77
bb76:

        mov     x14, #0
        mov     x10, #8
        mul     x10, x14, x10
        add     x10, x13, x10
        ldr     x15, [x10]
        sdiv     x20, x11, x12
        mov     x14, #0
        mov     x10, #8
        mul     x10, x14, x10
        add     x10, x13, x10
        str     x20, [x10]
        mov     x14, x11
        mov     x10, x15
        b     bb78
bb77:

        mov     x14, #8
        mul     x14, x9, x14
        add     x14, x13, x14
        ldr     x14, [x14]
        add     x11, x11, x14
        sub     x15, x11, x10
        sub     x10, x9, x12
        add     x14, x10, #1
        mov     x10, #8
        mul     x10, x14, x10
        add     x10, x13, x10
        ldr     x11, [x10]
        sdiv     x20, x15, x12
        mov     x10, #8
        mul     x10, x14, x10
        add     x10, x13, x10
        str     x20, [x10]
        mov     x14, x15
        mov     x10, x11
        b     bb78
bb78:

        mov     x11, x14
        mov     x10, x10
        b     bb75
bb75:

        add     x9, x9, #1
        mov     x11, x11
        mov     x10, x10
        mov     x9, x9
        b     bb70
bb72:

        adr     x9, n
        ldr     x9, [x9]
        sub     x9, x9, x12
        add     x9, x9, #1
        mov     x10, x9
        b     bb79
bb79:

        adr     x9, n
        ldr     x9, [x9]
        cmp     x10, x9
        b.lt     bb80
        b     bb81
bb80:

        mov     x9, #8
        mul     x9, x10, x9
        add     x11, x13, x9
        mov     x9, #0
        str     x9, [x11]
        add     x9, x10, #1
        mov     x10, x9
        b     bb79
bb81:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb82:

        mov     x16, #512
        sub     sp, sp, x16
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
        mov     x10, #32
        adr     x9, n
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #7
        str     x9, [x10]
        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #23
        str     x9, [x10]
        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #89
        str     x9, [x10]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #26
        str     x9, [x10]
        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #282
        str     x9, [x10]
        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #254
        str     x9, [x10]
        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #27
        str     x9, [x10]
        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #5
        str     x9, [x10]
        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #83
        str     x9, [x10]
        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #273
        str     x9, [x10]
        mov     x10, #10
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #574
        str     x9, [x10]
        mov     x10, #11
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #905
        str     x9, [x10]
        mov     x10, #12
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #354
        str     x9, [x10]
        mov     x10, #13
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #657
        str     x9, [x10]
        mov     x10, #14
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #935
        str     x9, [x10]
        mov     x10, #15
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #264
        str     x9, [x10]
        mov     x10, #16
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #639
        str     x9, [x10]
        mov     x10, #17
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #459
        str     x9, [x10]
        mov     x10, #18
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #29
        str     x9, [x10]
        mov     x10, #19
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #68
        str     x9, [x10]
        mov     x10, #20
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #929
        str     x9, [x10]
        mov     x10, #21
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #756
        str     x9, [x10]
        mov     x10, #22
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #452
        str     x9, [x10]
        mov     x10, #23
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #279
        str     x9, [x10]
        mov     x10, #24
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #58
        str     x9, [x10]
        mov     x10, #25
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #87
        str     x9, [x10]
        mov     x10, #26
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #96
        str     x9, [x10]
        mov     x10, #27
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #36
        str     x9, [x10]
        mov     x10, #28
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #39
        str     x9, [x10]
        mov     x10, #29
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #28
        str     x9, [x10]
        mov     x10, #30
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #1
        str     x9, [x10]
        mov     x10, #31
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #290
        str     x9, [x10]
        mov     x9, #0
        mov     x9, x9
        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     revert
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
        b     bb83
bb83:

        mov     x9, #32
        cmp     x11, x9
        b.lt     bb84
        b     bb85
bb84:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        add     x9, x11, #1
        mov     x11, x9
        b     bb83
bb85:

        mov     x9, #-264
        add     x9, x29, x9
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
        bl     bubblesort
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
        b     bb86
bb86:

        mov     x9, #32
        cmp     x11, x9
        b.lt     bb87
        b     bb88
bb87:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        add     x9, x11, #1
        mov     x11, x9
        b     bb86
bb88:

        mov     x9, #-264
        add     x9, x29, x9
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
        bl     getMid
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
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     getMost
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
        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     bubblesort
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
        b     bb89
bb89:

        mov     x9, #32
        cmp     x11, x9
        b.lt     bb90
        b     bb91
bb90:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        add     x9, x11, #1
        mov     x11, x9
        b     bb89
bb91:

        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     insertsort
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
        b     bb92
bb92:

        mov     x9, #32
        cmp     x11, x9
        b.lt     bb93
        b     bb94
bb93:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        add     x9, x11, #1
        mov     x11, x9
        b     bb92
bb94:

        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     arrCopy
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
        mov     x11, x9
        mov     x9, #31
        mov     x10, x9
        mov     x9, #-264
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x11
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
        bl     QuickSort
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x11
        b     bb95
bb95:

        mov     x9, #32
        cmp     x11, x9
        b.lt     bb96
        b     bb97
bb96:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        add     x9, x11, #1
        mov     x11, x9
        b     bb95
bb97:

        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-264
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #4
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
        bl     calSum
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
        b     bb98
bb98:

        mov     x9, #32
        cmp     x11, x9
        b.lt     bb99
        b     bb100
bb99:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        add     x9, x11, #1
        mov     x11, x9
        b     bb98
bb100:

        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-264
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #3
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
        bl     avgPooling
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
        b     bb101
bb101:

        mov     x9, #32
        cmp     x11, x9
        b.lt     bb102
        b     bb103
bb102:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-264
        add     x9, x29, x9
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
        add     x9, x11, #1
        mov     x11, x9
        b     bb101
bb103:

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
        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
