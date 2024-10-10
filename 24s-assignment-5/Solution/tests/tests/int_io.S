.section .data
.global    ascii_0
ascii_0:
        .quad   48
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global my_getint
.global mod
.global my_putint
.global main
my_getint:

bb1:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w11, w9
        b     bb2
bb2:

        mov     w10, #1
        mov     w9, #0
        cmp     w10, w9
        b.gt     bb3
        mov     w9, w11
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
        mov     w10, w0
        adrp     x9, ascii_0
        add     x9, x9, #:lo12:ascii_0
        ldr     w9, [x9]
        sub     w10, w10, w9
        mov     w9, #0
        cmp     w10, w9
        b.lt     bb5
        b     bb8
bb8:

        mov     w9, #9
        cmp     w10, w9
        b.gt     bb5
        b     bb6
bb5:

        mov     w11, w10
        b     bb2
bb6:

        mov     w9, w10
        b     bb4
bb4:

        mov     w9, w9
        mov     w9, w9
        b     bb9
bb9:

        mov     w11, #1
        mov     w10, #0
        cmp     w11, w10
        b.gt     bb10
        b     bb11
bb10:

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
        adrp     x10, ascii_0
        add     x10, x10, #:lo12:ascii_0
        ldr     w10, [x10]
        sub     w11, w11, w10
        mov     w10, #0
        cmp     w11, w10
        b.ge     bb15
        b     bb13
bb15:

        mov     w10, #9
        cmp     w11, w10
        b.le     bb12
        b     bb13
bb12:

        mov     w10, #10
        mul     w9, w9, w10
        add     w9, w9, w11
        mov     w9, w9
        b     bb9
bb13:

        b     bb11
bb11:

        mov     w0, w9
        mov     sp, x29
        ret
mod:

bb31:

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
my_putint:

bb32:

        mov     x16, #128
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     w9, w9
        mov     w10, w10
        mov     w9, w9
        b     bb18
bb18:

        mov     w11, #0
        cmp     w10, w11
        b.gt     bb19
        b     bb20
bb19:

        mov     w0, w10
        mov     w11, #10
        mov     w1, w11
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
        mov     w12, w0
        adrp     x11, ascii_0
        add     x11, x11, #:lo12:ascii_0
        ldr     w11, [x11]
        add     w11, w12, w11
        mov     x12, #8
        mul     x13, x9, x12
        mov     x12, #-128
        add     x12, x29, x12
        add     x12, x12, x13
        str     w11, [x12]
        mov     w11, #10
        sdiv     w10, w10, w11
        add     w9, w9, #1
        mov     w10, w10
        mov     w9, w9
        b     bb18
bb20:

        mov     w10, w9
        b     bb21
bb21:

        mov     w9, #0
        cmp     w10, w9
        b.gt     bb22
        b     bb23
bb22:

        sub     w11, w10, #1
        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w9, [x9]
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
        mov     w10, w11
        b     bb21
bb23:

        mov     sp, x29
        ret
main:

bb24:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #51
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
        bl     my_getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w10, w9
        b     bb25
bb25:

        mov     w9, #0
        cmp     w10, w9
        b.gt     bb26
        b     bb27
bb26:

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     my_getint
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
        bl     my_putint
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
        sub     w9, w10, #1
        mov     w10, w9
        b     bb25
bb27:

        mov     w9, #58
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
