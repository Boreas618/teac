.section .data

.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global mod
.global palindrome
.global main
mod:

bb14:

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
palindrome:

bb15:

        mov     x16, #32
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x10, x10
        mov     x9, #0
        mov     x9, x9
        mov     x12, x10
        mov     x11, x9
        b     bb3
bb3:

        mov     x9, #4
        cmp     x11, x9
        b.lt     bb4
        b     bb5
bb4:

        mov     x0, x12
        mov     x9, #10
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
        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        str     x0, [x9]
        mov     x9, #10
        sdiv     x10, x12, x9
        add     x9, x11, #1
        mov     x12, x10
        mov     x11, x9
        b     bb3
bb5:

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x11, [x9]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x9, [x9]
        cmp     x11, x9
        b.eq     bb9
        b     bb7
bb9:

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x11, [x9]
        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x9, [x9]
        cmp     x11, x9
        b.eq     bb6
        b     bb7
bb6:

        mov     x9, #1
        mov     x9, x9
        mov     x9, x9
        b     bb8
bb7:

        mov     x9, #0
        mov     x9, x9
        mov     x9, x9
        b     bb8
bb8:

        mov     x0, x9
        mov     sp, x29
        ret
main:

bb10:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
        mov     x9, #1221
        mov     x10, x9
        mov     x9, #0
        mov     x9, x9
        mov     x0, x10
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
        bl     palindrome
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #1
        cmp     x0, x9
        b.eq     bb11
        b     bb12
bb11:

        mov     x0, x10
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
        b     bb13
bb12:

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
        b     bb13
bb13:

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
