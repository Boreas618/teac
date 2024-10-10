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
palindrome:

bb15:

        mov     x16, #32
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0
        mov     w9, #0
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     w9, w9
        mov     w10, w10
        mov     w9, w9
        b     bb3
bb3:

        mov     w11, #4
        cmp     w9, w11
        b.lt     bb4
        b     bb5
bb4:

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
        mov     w11, w0
        mov     x12, #8
        mul     x13, x9, x12
        mov     x12, #-32
        add     x12, x29, x12
        add     x12, x12, x13
        str     w11, [x12]
        mov     w11, #10
        sdiv     w10, w10, w11
        add     w9, w9, #1
        mov     w10, w10
        mov     w9, w9
        b     bb3
bb5:

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-32
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w9, [x9]
        mov     x11, #3
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-32
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     w10, [x10]
        cmp     w9, w10
        b.eq     bb9
        b     bb7
bb9:

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-32
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     w9, [x9]
        mov     x11, #2
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-32
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     w10, [x10]
        cmp     w9, w10
        b.eq     bb6
        b     bb7
bb6:

        mov     w9, #1
        mov     w9, w9
        mov     w9, w9
        b     bb8
bb7:

        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb8
bb8:

        mov     w0, w9
        mov     sp, x29
        ret
main:

bb10:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #30
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
        mov     w9, #1221
        mov     w11, w9
        mov     w9, #0
        mov     w0, w11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     palindrome
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        mov     w9, #1
        cmp     w10, w9
        b.eq     bb11
        b     bb12
bb11:

        mov     w0, w11
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
        b     bb13
bb12:

        mov     w9, #0
        mov     w9, w9
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
        b     bb13
bb13:

        mov     w9, #10
        mov     w9, w9
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
        mov     w9, #47
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
