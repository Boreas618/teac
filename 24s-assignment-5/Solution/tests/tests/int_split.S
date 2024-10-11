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
.global mod
.global split
.global main
mod:

bb10:

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
split:

bb11:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     x11, x1
        mov     w9, #0
        mov     w9, #0
        mov     w10, w10
        adrp     x9, N
        add     x9, x9, #:lo12:N
        ldr     w9, [x9]
        sub     w9, w9, #1
        mov     w10, w10
        mov     w9, w9
        b     bb3
bb3:

        mov     w12, #0
        sub     w12, w12, #1
        cmp     w9, w12
        b.ne     bb4
        b     bb5
bb4:

        mov     w0, w10
        mov     w12, #10
        mov     w1, w12
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
        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        str     w13, [x12]
        mov     w12, #10
        sdiv     w10, w10, w12
        sub     w9, w9, #1
        mov     w10, w10
        mov     w9, w9
        b     bb3
bb5:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb6:

        mov     x16, #32
        sub     sp, sp, x16
        mov     w9, #26
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
        mov     w9, w9
        mov     w0, w9
        mov     x9, #-32
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     split
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #0
        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb7
bb7:

        mov     w10, #4
        cmp     w9, w10
        b.lt     bb8
        b     bb9
bb8:

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-32
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
        adrp     x10, newline
        add     x10, x10, #:lo12:newline
        ldr     w10, [x10]
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
        b     bb7
bb9:

        mov     w9, #42
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
