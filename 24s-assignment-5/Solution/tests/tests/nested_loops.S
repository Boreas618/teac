.section .data
.global    arr1
.global    arr2
arr1:
        .zero   537600
arr2:
        .zero   537600
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global loop1
.global loop2
.global loop3
.global main
loop1:

bb90:

        mov     x16, #40
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, w1
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w16, w10
        mov     x17, #8
        str     x16, [sp,x17]
        mov     w10, #0
        mov     w16, w9
        mov     x17, #16
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w9, w9
        mov     w16, w9
        mov     x17, #24
        str     x16, [sp,x17]
        b     bb2
bb2:

        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x16, #8
        ldr     x18, [sp,x16]
        cmp     w19, w18
        b.lt     bb5
        b     bb4
bb5:

        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x16, #16
        ldr     x18, [sp,x16]
        cmp     w19, w18
        b.lt     bb3
        b     bb4
bb3:

        mov     w9, #0
        mov     w9, w9
        mov     w16, w9
        mov     x17, #32
        str     x16, [sp,x17]
        b     bb6
bb6:

        mov     w9, #2
        mov     x16, #32
        ldr     x19, [sp,x16]
        cmp     w19, w9
        b.lt     bb7
        b     bb8
bb7:

        mov     w9, #0
        mov     w9, w9
        mov     w15, w9
        b     bb9
bb9:

        mov     w9, #3
        cmp     w15, w9
        b.lt     bb10
        b     bb11
bb10:

        mov     w9, #0
        mov     w9, w9
        mov     w14, w9
        b     bb12
bb12:

        mov     w9, #4
        cmp     w14, w9
        b.lt     bb13
        b     bb14
bb13:

        mov     w9, #0
        mov     w9, w9
        mov     w13, w9
        b     bb15
bb15:

        mov     w9, #5
        cmp     w13, w9
        b.lt     bb16
        b     bb17
bb16:

        mov     w9, #0
        mov     w9, w9
        mov     w12, w9
        b     bb18
bb18:

        mov     w9, #6
        cmp     w12, w9
        b.lt     bb19
        b     bb20
bb19:

        mov     w9, #0
        mov     w9, w9
        mov     w11, w9
        b     bb21
bb21:

        mov     w9, #2
        cmp     w11, w9
        b.lt     bb22
        b     bb23
bb22:

        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x16, #32
        ldr     x18, [sp,x16]
        add     w9, w19, w18
        add     w9, w9, w15
        add     w9, w9, w14
        add     w9, w9, w13
        add     w9, w9, w12
        add     w9, w9, w11
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     w16, w9, w19
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x9, #53760
        mov     x16, #24
        ldr     x19, [sp,x16]
        mul     x10, x19, x9
        adrp     x9, arr1
        add     x9, x9, #:lo12:arr1
        add     x10, x9, x10
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #26880
        mov     x16, #32
        ldr     x19, [sp,x16]
        mul     x9, x19, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8960
        mul     x9, x15, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #2240
        mul     x9, x14, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #448
        mul     x9, x13, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #56
        mul     x9, x12, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        str     w19, [x9]
        add     w9, w11, #1
        mov     w11, w9
        b     bb21
bb23:

        add     w9, w12, #1
        mov     w12, w9
        b     bb18
bb20:

        add     w9, w13, #1
        mov     w13, w9
        b     bb15
bb17:

        add     w9, w14, #1
        mov     w14, w9
        b     bb12
bb14:

        add     w9, w15, #1
        mov     w15, w9
        b     bb9
bb11:

        mov     x16, #32
        ldr     x19, [sp,x16]
        add     w9, w19, #1
        mov     w16, w9
        mov     x17, #32
        str     x16, [sp,x17]
        b     bb6
bb8:

        mov     x16, #24
        ldr     x19, [sp,x16]
        add     w9, w19, #1
        mov     w16, w9
        mov     x17, #24
        str     x16, [sp,x17]
        b     bb2
bb4:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
loop2:

bb24:

        mov     x16, #24
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w16, w9
        mov     x17, #8
        str     x16, [sp,x17]
        b     bb25
bb25:

        mov     w9, #10
        mov     x16, #8
        ldr     x19, [sp,x16]
        cmp     w19, w9
        b.lt     bb26
        b     bb27
bb26:

        mov     w9, #0
        mov     w9, w9
        mov     w16, w9
        mov     x17, #16
        str     x16, [sp,x17]
        b     bb28
bb28:

        mov     w9, #2
        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     w19, w9
        b.lt     bb29
        b     bb30
bb29:

        mov     w9, #0
        mov     w9, w9
        mov     w15, w9
        b     bb31
bb31:

        mov     w9, #3
        cmp     w15, w9
        b.lt     bb32
        b     bb33
bb32:

        mov     w9, #0
        mov     w9, w9
        mov     w14, w9
        b     bb34
bb34:

        mov     w9, #2
        cmp     w14, w9
        b.lt     bb35
        b     bb36
bb35:

        mov     w9, #0
        mov     w9, w9
        mov     w13, w9
        b     bb37
bb37:

        mov     w9, #4
        cmp     w13, w9
        b.lt     bb38
        b     bb39
bb38:

        mov     w9, #0
        mov     w9, w9
        mov     w12, w9
        b     bb40
bb40:

        mov     w9, #8
        cmp     w12, w9
        b.lt     bb41
        b     bb42
bb41:

        mov     w9, #0
        mov     w9, w9
        mov     w11, w9
        b     bb43
bb43:

        mov     w9, #7
        cmp     w11, w9
        b.lt     bb44
        b     bb45
bb44:

        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     x16, #16
        ldr     x18, [sp,x16]
        add     w9, w19, w18
        add     w9, w9, w14
        add     w16, w9, w11
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x9, #53760
        mov     x16, #8
        ldr     x19, [sp,x16]
        mul     x10, x19, x9
        adrp     x9, arr2
        add     x9, x9, #:lo12:arr2
        add     x10, x9, x10
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #26880
        mov     x16, #16
        ldr     x19, [sp,x16]
        mul     x9, x19, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8960
        mul     x9, x15, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #2240
        mul     x9, x14, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #448
        mul     x9, x13, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #56
        mul     x9, x12, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        str     w19, [x9]
        add     w9, w11, #1
        mov     w11, w9
        b     bb43
bb45:

        add     w9, w12, #1
        mov     w12, w9
        b     bb40
bb42:

        add     w9, w13, #1
        mov     w13, w9
        b     bb37
bb39:

        add     w9, w14, #1
        mov     w14, w9
        b     bb34
bb36:

        add     w9, w15, #1
        mov     w15, w9
        b     bb31
bb33:

        mov     x16, #16
        ldr     x19, [sp,x16]
        add     w9, w19, #1
        mov     w16, w9
        mov     x17, #16
        str     x16, [sp,x17]
        b     bb28
bb30:

        mov     x16, #8
        ldr     x19, [sp,x16]
        add     w9, w19, #1
        mov     w16, w9
        mov     x17, #8
        str     x16, [sp,x17]
        b     bb25
bb27:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
loop3:

bb91:

        mov     x16, #104
        sub     sp, sp, x16
        mov     w16, w0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w15, w1
        mov     w14, w2
        mov     w13, w3
        mov     w12, w4
        mov     w11, w5
        mov     w10, w6
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #32
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w16, w15
        mov     x17, #40
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w16, w14
        mov     x17, #48
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w16, w13
        mov     x17, #56
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w16, w12
        mov     x17, #64
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w16, w11
        mov     x17, #72
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w16, w10
        mov     x17, #80
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w10, w9
        mov     w9, #0
        mov     w9, w9
        mov     w16, w9
        mov     x17, #88
        str     x16, [sp,x17]
        mov     w10, w10
        b     bb47
bb47:

        mov     w9, #10
        mov     x16, #88
        ldr     x19, [sp,x16]
        cmp     w19, w9
        b.lt     bb48
        mov     w9, w10
        b     bb49
bb48:

        mov     w9, #0
        mov     w9, w9
        mov     w16, w9
        mov     x17, #96
        str     x16, [sp,x17]
        mov     w10, w10
        b     bb50
bb50:

        mov     w9, #100
        mov     x16, #96
        ldr     x19, [sp,x16]
        cmp     w19, w9
        b.lt     bb51
        mov     w10, w10
        b     bb52
bb51:

        mov     w9, #0
        mov     w9, w9
        mov     w10, w10
        mov     w15, w9
        b     bb53
bb53:

        mov     w9, #1000
        cmp     w15, w9
        b.lt     bb54
        mov     w10, w10
        b     bb55
bb54:

        mov     w9, #0
        mov     w9, w9
        mov     w10, w10
        mov     w14, w9
        b     bb56
bb56:

        mov     w9, #10000
        cmp     w14, w9
        b.lt     bb57
        mov     w10, w10
        b     bb58
bb57:

        mov     w9, #0
        mov     w9, w9
        mov     w10, w10
        mov     w13, w9
        b     bb59
bb59:

        movz     w9, #1, LSL #16
        movk     w9, #34464, LSL #0
        cmp     w13, w9
        b.lt     bb60
        mov     w10, w10
        b     bb61
bb60:

        mov     w9, #0
        mov     w9, w9
        mov     w10, w10
        mov     w12, w9
        b     bb62
bb62:

        movz     w9, #15, LSL #16
        movk     w9, #16960, LSL #0
        cmp     w12, w9
        b.lt     bb63
        mov     w10, w10
        b     bb64
bb63:

        mov     w9, #0
        mov     w9, w9
        mov     w10, w10
        mov     w11, w9
        b     bb65
bb65:

        movz     w9, #152, LSL #16
        movk     w9, #38528, LSL #0
        cmp     w11, w9
        b.lt     bb66
        mov     w10, w10
        b     bb67
bb66:

        mov     w9, #817
        sdiv     w16, w10, w9
        mov     x17, #8
        str     x16, [sp,x17]
        mov     w9, #817
        mov     x16, #8
        ldr     x19, [sp,x16]
        mul     w9, w19, w9
        sub     w16, w10, w9
        mov     x17, #16
        str     x16, [sp,x17]
        mov     x9, #53760
        mov     x16, #88
        ldr     x19, [sp,x16]
        mul     x10, x19, x9
        adrp     x9, arr1
        add     x9, x9, #:lo12:arr1
        add     x10, x9, x10
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #26880
        mov     x16, #96
        ldr     x19, [sp,x16]
        mul     x9, x19, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8960
        mul     x9, x15, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #2240
        mul     x9, x14, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #448
        mul     x9, x13, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #56
        mul     x9, x12, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x10, x9
        ldr     w9, [x9]
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     w16, w19, w9
        mov     x17, #24
        str     x16, [sp,x17]
        mov     x9, #53760
        mov     x16, #88
        ldr     x19, [sp,x16]
        mul     x10, x19, x9
        adrp     x9, arr2
        add     x9, x9, #:lo12:arr2
        add     x10, x9, x10
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #26880
        mov     x16, #96
        ldr     x19, [sp,x16]
        mul     x9, x19, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8960
        mul     x9, x15, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #2240
        mul     x9, x14, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #448
        mul     x9, x13, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #56
        mul     x9, x12, x9
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x10, x9
        ldr     w9, [x9]
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     w10, w19, w9
        add     w9, w11, #1
        mov     x16, #80
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb68
        b     bb69
bb68:

        mov     w10, w10
        b     bb67
bb69:

        mov     w10, w10
        mov     w11, w9
        b     bb65
bb67:

        add     w9, w12, #1
        mov     x16, #72
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb71
        b     bb72
bb71:

        mov     w10, w10
        b     bb64
bb72:

        mov     w10, w10
        mov     w12, w9
        b     bb62
bb64:

        add     w9, w13, #1
        mov     x16, #64
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb74
        b     bb75
bb74:

        mov     w10, w10
        b     bb61
bb75:

        mov     w10, w10
        mov     w13, w9
        b     bb59
bb61:

        add     w9, w14, #1
        mov     x16, #56
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb77
        b     bb78
bb77:

        mov     w10, w10
        b     bb58
bb78:

        mov     w10, w10
        mov     w14, w9
        b     bb56
bb58:

        add     w9, w15, #1
        mov     x16, #48
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb80
        b     bb81
bb80:

        mov     w10, w10
        b     bb55
bb81:

        mov     w10, w10
        mov     w15, w9
        b     bb53
bb55:

        mov     x16, #96
        ldr     x19, [sp,x16]
        add     w9, w19, #1
        mov     x16, #40
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb83
        b     bb84
bb83:

        mov     w10, w10
        b     bb52
bb84:

        mov     w16, w9
        mov     x17, #96
        str     x16, [sp,x17]
        mov     w10, w10
        b     bb50
bb52:

        mov     x16, #88
        ldr     x19, [sp,x16]
        add     w9, w19, #1
        mov     x16, #32
        ldr     x19, [sp,x16]
        cmp     w9, w19
        b.ge     bb86
        b     bb87
bb86:

        mov     w9, w10
        b     bb49
bb87:

        mov     w16, w9
        mov     x17, #88
        str     x16, [sp,x17]
        mov     w10, w10
        b     bb47
bb49:

        mov     w0, w9
        mov     sp, x29
        ret
main:

bb89:

        mov     x16, #16
        sub     sp, sp, x16
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
        mov     w16, w0
        mov     x17, #0
        str     x16, [sp,x17]
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
        mov     w16, w0
        mov     x17, #8
        str     x16, [sp,x17]
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
        mov     w9, w0
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     w0, w19
        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     w1, w19
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     loop1
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
        bl     loop2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w0, w15
        mov     w1, w14
        mov     w2, w13
        mov     w3, w12
        mov     w4, w11
        mov     w5, w10
        mov     w6, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     loop3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
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
        mov     w0, w10
        mov     sp, x29
        ret
