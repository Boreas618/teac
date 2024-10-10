.section .data
.global    TAPE_LEN
.global    BUFFER_LEN
.global    tape
.global    program
.global    ptr
TAPE_LEN:
        .quad   65536
BUFFER_LEN:
        .quad   32768
tape:
        .zero   524288
program:
        .zero   262144
ptr:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global read_program
.global interpret
.global main
read_program:

bb1:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
        mov     w11, w9
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
        mov     w9, w11
        b     bb2
bb2:

        cmp     w9, w10
        b.lt     bb3
        b     bb4
bb3:

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
        mov     w13, w0
        mov     x11, #8
        mul     x12, x9, x11
        adrp     x11, program
        add     x11, x11, #:lo12:program
        add     x11, x11, x12
        str     w13, [x11]
        add     w9, w9, #1
        mov     w9, w9
        b     bb2
bb4:

        mov     x10, #8
        mul     x10, x9, x10
        adrp     x9, program
        add     x9, x9, #:lo12:program
        add     x10, x9, x10
        mov     w9, #0
        str     w9, [x10]
        mov     sp, x29
        ret
interpret:

bb5:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x12, x0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w10, w9
        b     bb6
bb6:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        ldr     w11, [x9]
        mov     w9, #0
        cmp     w11, w9
        b.ne     bb7
        b     bb8
bb7:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        ldr     w9, [x9]
        mov     w11, #62
        cmp     w9, w11
        b.eq     bb9
        b     bb10
bb9:

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     w11, [x11]
        add     w13, w11, #1
        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        str     w13, [x11]
        b     bb11
bb10:

        b     bb11
bb11:

        mov     w11, #60
        cmp     w9, w11
        b.eq     bb12
        b     bb13
bb12:

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     w11, [x11]
        sub     w13, w11, #1
        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        str     w13, [x11]
        b     bb14
bb13:

        b     bb14
bb14:

        mov     w11, #43
        cmp     w9, w11
        b.eq     bb15
        b     bb16
bb15:

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     w13, [x11]
        mov     x11, #8
        mul     x13, x13, x11
        adrp     x11, tape
        add     x11, x11, #:lo12:tape
        add     x11, x11, x13
        ldr     w11, [x11]
        add     w11, w11, #1
        adrp     x13, ptr
        add     x13, x13, #:lo12:ptr
        ldr     w14, [x13]
        mov     x13, #8
        mul     x14, x14, x13
        adrp     x13, tape
        add     x13, x13, #:lo12:tape
        add     x13, x13, x14
        str     w11, [x13]
        b     bb17
bb16:

        b     bb17
bb17:

        mov     w11, #45
        cmp     w9, w11
        b.eq     bb18
        b     bb19
bb18:

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     w13, [x11]
        mov     x11, #8
        mul     x13, x13, x11
        adrp     x11, tape
        add     x11, x11, #:lo12:tape
        add     x11, x11, x13
        ldr     w11, [x11]
        sub     w11, w11, #1
        adrp     x13, ptr
        add     x13, x13, #:lo12:ptr
        ldr     w14, [x13]
        mov     x13, #8
        mul     x14, x14, x13
        adrp     x13, tape
        add     x13, x13, #:lo12:tape
        add     x13, x13, x14
        str     w11, [x13]
        b     bb20
bb19:

        b     bb20
bb20:

        mov     w11, #46
        cmp     w9, w11
        b.eq     bb21
        b     bb22
bb21:

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     w13, [x11]
        mov     x11, #8
        mul     x13, x13, x11
        adrp     x11, tape
        add     x11, x11, #:lo12:tape
        add     x11, x11, x13
        ldr     w11, [x11]
        mov     w0, w11
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
        b     bb23
bb22:

        b     bb23
bb23:

        mov     w11, #44
        cmp     w9, w11
        b.eq     bb24
        b     bb25
bb24:

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
        adrp     x13, ptr
        add     x13, x13, #:lo12:ptr
        ldr     w14, [x13]
        mov     x13, #8
        mul     x14, x14, x13
        adrp     x13, tape
        add     x13, x13, #:lo12:tape
        add     x13, x13, x14
        str     w11, [x13]
        b     bb26
bb25:

        b     bb26
bb26:

        mov     w11, #93
        cmp     w9, w11
        b.eq     bb30
        b     bb28
bb30:

        adrp     x9, ptr
        add     x9, x9, #:lo12:ptr
        ldr     w11, [x9]
        mov     x9, #8
        mul     x11, x11, x9
        adrp     x9, tape
        add     x9, x9, #:lo12:tape
        add     x9, x9, x11
        ldr     w11, [x9]
        mov     w9, #0
        cmp     w11, w9
        b.ne     bb27
        b     bb28
bb27:

        mov     w9, #1
        mov     w9, w9
        mov     w11, w9
        mov     w10, w10
        b     bb31
bb31:

        mov     w9, #0
        cmp     w11, w9
        b.gt     bb32
        b     bb33
bb32:

        sub     w10, w10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        ldr     w9, [x9]
        mov     w13, #91
        cmp     w9, w13
        b.eq     bb34
        b     bb35
bb34:

        sub     w11, w11, #1
        mov     w13, w11
        b     bb36
bb35:

        mov     w13, w11
        b     bb36
bb36:

        mov     w11, #93
        cmp     w9, w11
        b.eq     bb37
        b     bb38
bb37:

        add     w9, w13, #1
        mov     w9, w9
        b     bb39
bb38:

        mov     w9, w13
        b     bb39
bb39:

        mov     w11, w9
        mov     w10, w10
        b     bb31
bb33:

        mov     w9, w10
        b     bb29
bb28:

        mov     w9, w10
        b     bb29
bb29:

        add     w9, w9, #1
        mov     w10, w9
        b     bb6
bb8:

        mov     sp, x29
        ret
main:

bb40:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #76
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
        bl     read_program
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adrp     x9, program
        add     x9, x9, #:lo12:program
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     interpret
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
        mov     w9, #80
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
