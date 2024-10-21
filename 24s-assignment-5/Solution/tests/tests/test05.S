.section .data
.global    N
.global    newline
N:
        .quad   0
newline:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global factor
.global main
factor:

bb9:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     w11, w9
        mov     w9, #1
        mov     w9, w9
        mov     w9, w9
        mov     w11, w11
        b     bb2
bb2:

        add     w12, w10, #1
        cmp     w9, w12
        b.lt     bb3
        b     bb4
bb3:

        sdiv     w12, w10, w9
        mul     w12, w12, w9
        cmp     w12, w10
        b.eq     bb5
        b     bb6
bb5:

        add     w11, w11, w9
        mov     w11, w11
        b     bb7
bb6:

        mov     w11, w11
        b     bb7
bb7:

        add     w9, w9, #1
        mov     w9, w9
        mov     w11, w11
        b     bb2
bb4:

        mov     w0, w11
        mov     sp, x29
        ret
main:

bb8:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #24
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
        mov     w10, #4
        adrp     x9, N
        add     x9, x9, #:lo12:N
        str     w10, [x9]
        mov     w10, #10
        adrp     x9, newline
        add     x9, x9, #:lo12:newline
        str     w10, [x9]
        mov     w9, #0
        mov     w9, #0
        mov     w9, #1478
        mov     w10, w9
        mov     w9, #0
        mov     w9, #31
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
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     factor
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0
        mov     w0, w9
        mov     sp, x29
        ret
