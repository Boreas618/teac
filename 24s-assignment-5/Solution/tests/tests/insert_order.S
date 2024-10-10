.section .data
.global    N
N:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global insert
.global main
insert:

bb13:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     w10, w1
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w11, w10
        mov     w9, #0
        mov     w9, w9
        mov     w10, w9
        b     bb2
bb2:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        ldr     w9, [x9]
        cmp     w11, w9
        b.gt     bb5
        b     bb4
bb5:

        adrp     x9, N
        add     x9, x9, #:lo12:N
        ldr     w9, [x9]
        cmp     w10, w9
        b.lt     bb3
        b     bb4
bb3:

        add     w9, w10, #1
        mov     w10, w9
        b     bb2
bb4:

        adrp     x9, N
        add     x9, x9, #:lo12:N
        ldr     w9, [x9]
        mov     w9, w9
        b     bb6
bb6:

        cmp     w9, w10
        b.gt     bb7
        b     bb8
bb7:

        sub     w14, w9, #1
        mov     x12, #8
        mul     x12, x14, x12
        add     x12, x13, x12
        ldr     w12, [x12]
        mov     x14, #8
        mul     x14, x9, x14
        add     x14, x13, x14
        str     w12, [x14]
        mov     x12, #8
        mul     x12, x10, x12
        add     x12, x13, x12
        str     w11, [x12]
        sub     w9, w9, #1
        mov     w9, w9
        b     bb6
bb8:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb9:

        mov     x16, #96
        sub     sp, sp, x16
        mov     w9, #27
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
        mov     w10, #10
        adrp     x9, N
        add     x9, x9, #:lo12:N
        str     w10, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #3
        str     w9, [x10]
        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #4
        str     w9, [x10]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #7
        str     w9, [x10]
        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #8
        str     w9, [x10]
        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #11
        str     w9, [x10]
        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #13
        str     w9, [x10]
        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #18
        str     w9, [x10]
        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #56
        str     w9, [x10]
        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        mov     w9, #78
        str     w9, [x10]
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w11, w9
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
        mov     x9, #-88
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     insert
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w11
        b     bb10
bb10:

        adrp     x10, N
        add     x10, x10, #:lo12:N
        ldr     w10, [x10]
        cmp     w9, w10
        b.lt     bb11
        b     bb12
bb11:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-88
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
        mov     w10, #10
        mov     w10, w10
        mov     w0, w10
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
        add     w9, w9, #1
        mov     w9, w9
        b     bb10
bb12:

        mov     w9, #54
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
