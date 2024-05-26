.section .data

.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global main
main:

bb1:

        mov     x16, #80
        sub     sp, sp, x16
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
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x11, x9
        b     bb2
bb2:

        mov     x9, #10
        cmp     x11, x9
        b.lt     bb3
        b     bb4
bb3:

        add     x12, x11, #1
        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        str     x12, [x9]
        add     x9, x11, #1
        mov     x11, x9
        b     bb2
bb4:

        mov     x9, #10
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
        sub     x10, x9, #1
        mov     x9, #0
        mov     x12, x9
        add     x11, x10, x12
        mov     x9, #2
        sdiv     x11, x11, x9
        mov     x10, x10
        mov     x9, x12
        mov     x13, x11
        b     bb5
bb5:

        mov     x11, #8
        mul     x12, x13, x11
        mov     x11, #-8
        add     x11, x29, x11
        add     x11, x11, x12
        ldr     x11, [x11]
        cmp     x11, x0
        b.ne     bb8
        b     bb7
bb8:

        cmp     x9, x10
        b.lt     bb6
        b     bb7
bb6:

        add     x12, x10, x9
        mov     x11, #2
        sdiv     x13, x12, x11
        mov     x11, #8
        mul     x12, x13, x11
        mov     x11, #-8
        add     x11, x29, x11
        add     x11, x11, x12
        ldr     x11, [x11]
        cmp     x0, x11
        b.lt     bb9
        b     bb10
bb9:

        sub     x10, x13, #1
        mov     x10, x10
        mov     x9, x9
        b     bb11
bb10:

        add     x9, x13, #1
        mov     x10, x10
        mov     x9, x9
        b     bb11
bb11:

        mov     x10, x10
        mov     x9, x9
        mov     x13, x13
        b     bb5
bb7:

        mov     x9, #8
        mul     x10, x13, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x9, [x9]
        cmp     x0, x9
        b.eq     bb12
        b     bb13
bb12:

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
        b     bb14
bb13:

        mov     x9, #0
        mov     x9, x9
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
        b     bb14
bb14:

        mov     x9, #10
        mov     x9, x9
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
        bl     putch
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
