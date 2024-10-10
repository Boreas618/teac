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
        mov     x14, x0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w12, w9
        b     bb2
bb2:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        sub     w9, w9, #1
        cmp     w12, w9
        b.lt     bb3
        b     bb4
bb3:

        mov     w9, #0
        mov     w9, w9
        mov     w11, w9
        b     bb5
bb5:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        sub     w9, w9, w12
        sub     w9, w9, #1
        cmp     w11, w9
        b.lt     bb6
        b     bb7
bb6:

        add     w9, w11, #1
        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x14, x10
        ldr     w10, [x10]
        mov     x13, #8
        mul     x9, x9, x13
        add     x9, x14, x9
        ldr     w9, [x9]
        cmp     w10, w9
        b.gt     bb8
        b     bb9
bb8:

        add     w10, w11, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        ldr     w9, [x9]
        mov     x13, #8
        mul     x13, x11, x13
        add     x13, x14, x13
        ldr     w13, [x13]
        mov     x15, #8
        mul     x10, x10, x15
        add     x10, x14, x10
        str     w13, [x10]
        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x14, x10
        str     w9, [x10]
        b     bb10
bb9:

        b     bb10
bb10:

        add     w9, w11, #1
        mov     w11, w9
        b     bb5
bb7:

        add     w9, w12, #1
        mov     w12, w9
        b     bb2
bb4:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
insertsort:

bb11:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x14, x0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #1
        mov     w9, w9
        mov     w12, w9
        b     bb12
bb12:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        cmp     w12, w9
        b.lt     bb13
        b     bb14
bb13:

        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x14, x9
        ldr     w11, [x9]
        sub     w9, w12, #1
        mov     w10, w9
        b     bb15
bb15:

        mov     w9, #0
        sub     w9, w9, #1
        cmp     w10, w9
        b.gt     bb18
        b     bb17
bb18:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        ldr     w9, [x9]
        cmp     w11, w9
        b.lt     bb16
        b     bb17
bb16:

        add     w9, w10, #1
        mov     x13, #8
        mul     x13, x10, x13
        add     x13, x14, x13
        ldr     w13, [x13]
        mov     x15, #8
        mul     x9, x9, x15
        add     x9, x14, x9
        str     w13, [x9]
        sub     w9, w10, #1
        mov     w10, w9
        b     bb15
bb17:

        add     w10, w10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        str     w11, [x9]
        add     w9, w12, #1
        mov     w12, w9
        b     bb12
bb14:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
QuickSort:

bb104:

        mov     x16, #8
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w10, w1
        mov     w9, w2
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w14, w10
        mov     w10, #0
        mov     w13, w9
        cmp     w14, w13
        b.lt     bb20
        b     bb21
bb20:

        mov     w10, w14
        mov     w9, w13
        mov     x11, #8
        mul     x11, x14, x11
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x11, x19, x11
        ldr     w12, [x11]
        mov     w9, w9
        mov     w10, w10
        b     bb23
bb23:

        cmp     w10, w9
        b.lt     bb24
        b     bb25
bb24:

        mov     w11, w9
        b     bb26
bb26:

        cmp     w10, w11
        b.lt     bb29
        b     bb28
bb29:

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w15, [x9]
        sub     w9, w12, #1
        cmp     w15, w9
        b.gt     bb27
        b     bb28
bb27:

        sub     w9, w11, #1
        mov     w11, w9
        b     bb26
bb28:

        cmp     w10, w11
        b.lt     bb30
        b     bb31
bb30:

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w15, [x9]
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w15, [x9]
        add     w9, w10, #1
        mov     w9, w9
        b     bb32
bb31:

        mov     w9, w10
        b     bb32
bb32:

        mov     w10, w9
        b     bb33
bb33:

        cmp     w10, w11
        b.lt     bb36
        b     bb35
bb36:

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w9, [x9]
        cmp     w9, w12
        b.lt     bb34
        b     bb35
bb34:

        add     w9, w10, #1
        mov     w10, w9
        b     bb33
bb35:

        cmp     w10, w11
        b.lt     bb37
        b     bb38
bb37:

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w15, [x9]
        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w15, [x9]
        sub     w9, w11, #1
        mov     w9, w9
        b     bb39
bb38:

        mov     w9, w11
        b     bb39
bb39:

        mov     w9, w9
        mov     w10, w10
        b     bb23
bb25:

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w12, [x9]
        sub     w9, w10, #1
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     w1, w14
        mov     w2, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     QuickSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        add     w9, w10, #1
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     w1, w9
        mov     w2, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     QuickSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb22
bb21:

        b     bb22
bb22:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
getMid:

bb40:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     w9, #0
        mov     w9, #0
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w11, [x9]
        mov     w9, #2
        sdiv     w11, w11, w9
        mov     w9, #2
        mul     w11, w11, w9
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        cmp     w11, w9
        b.eq     bb41
        b     bb42
bb41:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w11, [x9]
        mov     w9, #2
        sdiv     w12, w11, w9
        sub     w9, w12, #1
        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x10, x11
        ldr     w12, [x11]
        mov     x11, #8
        mul     x9, x9, x11
        add     x9, x10, x9
        ldr     w9, [x9]
        add     w10, w12, w9
        mov     w9, #2
        sdiv     w9, w10, w9
        mov     w0, w9
        mov     sp, x29
        ret
bb42:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w11, [x9]
        mov     w9, #2
        sdiv     w11, w11, w9
        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x10, x9
        ldr     w9, [x9]
        mov     w0, w9
        mov     sp, x29
        ret
getMost:

bb44:

        mov     x16, #8008
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w9, #0
        mov     w10, w9
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb45
bb45:

        mov     w11, #1000
        cmp     w9, w11
        b.lt     bb46
        b     bb47
bb46:

        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-8000
        add     x11, x29, x11
        add     x12, x11, x12
        mov     w11, #0
        str     w11, [x12]
        add     w9, w9, #1
        mov     w9, w9
        b     bb45
bb47:

        mov     w9, #0
        mov     w11, w9
        mov     w9, #0
        mov     w9, w9
        mov     w14, w11
        mov     w13, w9
        mov     w12, w10
        b     bb48
bb48:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        cmp     w14, w9
        b.lt     bb49
        b     bb50
bb49:

        mov     x9, #8
        mul     x9, x14, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        mov     x9, #8
        mul     x9, x11, x9
        mov     x10, #-8000
        add     x10, x29, x10
        add     x9, x10, x9
        ldr     w9, [x9]
        add     w15, w9, #1
        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-8000
        add     x9, x29, x9
        add     x9, x9, x10
        str     w15, [x9]
        mov     x9, #8
        mul     x9, x11, x9
        mov     x10, #-8000
        add     x10, x29, x10
        add     x9, x10, x9
        ldr     w9, [x9]
        cmp     w9, w13
        b.gt     bb51
        b     bb52
bb51:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-8000
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w10, [x9]
        mov     w9, w11
        mov     w11, w10
        mov     w10, w9
        b     bb53
bb52:

        mov     w11, w13
        mov     w10, w12
        b     bb53
bb53:

        add     w9, w14, #1
        mov     w14, w9
        mov     w13, w11
        mov     w12, w10
        b     bb48
bb50:

        mov     w0, w12
        mov     sp, x29
        ret
revert:

bb54:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w10, w9
        mov     w9, #0
        mov     w9, w9
        mov     w11, w9
        mov     w10, w10
        b     bb55
bb55:

        cmp     w10, w11
        b.lt     bb56
        b     bb57
bb56:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        ldr     w9, [x9]
        mov     x12, #8
        mul     x12, x11, x12
        add     x12, x13, x12
        ldr     w12, [x12]
        mov     x14, #8
        mul     x14, x10, x14
        add     x14, x13, x14
        str     w12, [x14]
        mov     x12, #8
        mul     x12, x11, x12
        add     x12, x13, x12
        str     w9, [x12]
        add     w10, w10, #1
        sub     w9, w11, #1
        mov     w11, w9
        mov     w10, w10
        b     bb55
bb57:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
arrCopy:

bb58:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb59
bb59:

        adrp     x12, n
        add     x12, x12, #:lo12:n
        ldr     w12, [x12]
        cmp     w9, w12
        b.lt     bb60
        b     bb61
bb60:

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        ldr     w13, [x12]
        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x10, x12
        str     w13, [x12]
        add     w9, w9, #1
        mov     w9, w9
        b     bb59
bb61:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
calSum:

bb107:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x12, x0
        mov     w10, w1
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w11, w10
        mov     w9, #0
        mov     w13, w9
        mov     w9, #0
        mov     w10, w9
        mov     w9, w13
        mov     w10, w10
        b     bb63
bb63:

        adrp     x13, n
        add     x13, x13, #:lo12:n
        ldr     w13, [x13]
        cmp     w10, w13
        b.lt     bb64
        b     bb65
bb64:

        mov     x13, #8
        mul     x13, x10, x13
        add     x13, x12, x13
        ldr     w13, [x13]
        add     w9, w9, w13
        sdiv     w13, w10, w11
        mul     w13, w13, w11
        sub     w14, w10, w13
        sub     w13, w11, #1
        cmp     w14, w13
        b.ne     bb66
        b     bb67
bb66:

        mov     x13, #8
        mul     x13, x10, x13
        add     x14, x12, x13
        mov     w13, #0
        str     w13, [x14]
        mov     w9, w9
        b     bb68
bb67:

        mov     x13, #8
        mul     x13, x10, x13
        add     x13, x12, x13
        str     w9, [x13]
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb68
bb68:

        add     w10, w10, #1
        mov     w9, w9
        mov     w10, w10
        b     bb63
bb65:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
avgPooling:

bb108:

        mov     x16, #8
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w10, w1
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w14, w10
        mov     w10, #0
        mov     w11, w10
        mov     w10, #0
        mov     w10, w10
        mov     w9, w9
        mov     w13, w11
        mov     w12, w10
        b     bb70
bb70:

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]
        cmp     w13, w10
        b.lt     bb71
        b     bb72
bb71:

        sub     w10, w14, #1
        cmp     w13, w10
        b.lt     bb73
        b     bb74
bb73:

        mov     x10, #8
        mul     x10, x13, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x10, x19, x10
        ldr     w10, [x10]
        add     w10, w12, w10
        mov     w9, w9
        mov     w11, w10
        b     bb75
bb74:

        sub     w10, w14, #1
        cmp     w13, w10
        b.eq     bb76
        b     bb77
bb76:

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w11, [x9]
        sdiv     w15, w12, w14
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w15, [x9]
        mov     w9, w11
        mov     w10, w12
        b     bb78
bb77:

        mov     x10, #8
        mul     x10, x13, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x10, x19, x10
        ldr     w10, [x10]
        add     w10, w12, w10
        sub     w12, w10, w9
        sub     w9, w13, w14
        add     w11, w9, #1
        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        ldr     w10, [x9]
        sdiv     w15, w12, w14
        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        str     w15, [x9]
        mov     w9, w10
        mov     w10, w12
        b     bb78
bb78:

        mov     w9, w9
        mov     w11, w10
        b     bb75
bb75:

        add     w10, w13, #1
        mov     w9, w9
        mov     w13, w10
        mov     w12, w11
        b     bb70
bb72:

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]
        sub     w9, w9, w14
        add     w9, w9, #1
        mov     w9, w9
        b     bb79
bb79:

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]
        cmp     w9, w10
        b.lt     bb80
        b     bb81
bb80:

        mov     x10, #8
        mul     x10, x9, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x11, x19, x10
        mov     w10, #0
        str     w10, [x11]
        add     w9, w9, #1
        mov     w9, w9
        b     bb79
bb81:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb82:

        mov     x16, #512
        sub     sp, sp, x16
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
        mov     w10, #32
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     w10, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #7
        str     w9, [x10]
        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #23
        str     w9, [x10]
        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #89
        str     w9, [x10]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #26
        str     w9, [x10]
        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #282
        str     w9, [x10]
        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #254
        str     w9, [x10]
        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #27
        str     w9, [x10]
        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #5
        str     w9, [x10]
        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #83
        str     w9, [x10]
        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #273
        str     w9, [x10]
        mov     x10, #10
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #574
        str     w9, [x10]
        mov     x10, #11
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #905
        str     w9, [x10]
        mov     x10, #12
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #354
        str     w9, [x10]
        mov     x10, #13
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #657
        str     w9, [x10]
        mov     x10, #14
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #935
        str     w9, [x10]
        mov     x10, #15
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #264
        str     w9, [x10]
        mov     x10, #16
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #639
        str     w9, [x10]
        mov     x10, #17
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #459
        str     w9, [x10]
        mov     x10, #18
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #29
        str     w9, [x10]
        mov     x10, #19
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #68
        str     w9, [x10]
        mov     x10, #20
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #929
        str     w9, [x10]
        mov     x10, #21
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #756
        str     w9, [x10]
        mov     x10, #22
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #452
        str     w9, [x10]
        mov     x10, #23
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #279
        str     w9, [x10]
        mov     x10, #24
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #58
        str     w9, [x10]
        mov     x10, #25
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #87
        str     w9, [x10]
        mov     x10, #26
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #96
        str     w9, [x10]
        mov     x10, #27
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #36
        str     w9, [x10]
        mov     x10, #28
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #39
        str     w9, [x10]
        mov     x10, #29
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #28
        str     w9, [x10]
        mov     x10, #30
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #31
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #290
        str     w9, [x10]
        mov     w9, #0
        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     revert
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb83
bb83:

        mov     w10, #32
        cmp     w9, w10
        b.lt     bb84
        b     bb85
bb84:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb83
bb85:

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     bubblesort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb86
bb86:

        mov     w10, #32
        cmp     w9, w10
        b.lt     bb87
        b     bb88
bb87:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb86
bb88:

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getMid
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
        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getMost
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
        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     bubblesort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb89
bb89:

        mov     w10, #32
        cmp     w9, w10
        b.lt     bb90
        b     bb91
bb90:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb89
bb91:

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     insertsort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb92
bb92:

        mov     w10, #32
        cmp     w9, w10
        b.lt     bb93
        b     bb94
bb93:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb92
bb94:

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w11, w9
        mov     w9, #31
        mov     w10, w9
        mov     x9, #-512
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
        bl     QuickSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w11
        b     bb95
bb95:

        mov     w10, #32
        cmp     w9, w10
        b.lt     bb96
        b     bb97
bb96:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb95
bb97:

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        mov     w9, #4
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     calSum
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb98
bb98:

        mov     w10, #32
        cmp     w9, w10
        b.lt     bb99
        b     bb100
bb99:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb98
bb100:

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        mov     w9, #3
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     avgPooling
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb101
bb101:

        mov     w10, #32
        cmp     w9, w10
        b.lt     bb102
        b     bb103
bb102:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb101
bb103:

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
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
