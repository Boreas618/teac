.section .data

.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global uniquePaths
.global main
uniquePaths:

bb19:

        mov     x16, #80
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
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
        mov     x9, x10
        mov     x10, #0
        mov     x9, x10
        mov     x12, x11
        mov     x10, #1
        cmp     x9, x10
        b.eq     bb2
        b     bb5
bb5:

        mov     x10, #1
        cmp     x12, x10
        b.eq     bb2
        b     bb3
bb2:

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
bb3:

        mov     x10, #0
        mov     x10, x10
        mov     x13, x10
        b     bb6
bb6:

        cmp     x13, x9
        b.lt     bb7
        b     bb8
bb7:

        mov     x10, #3
        mul     x10, x13, x10
        add     x10, x10, x12
        sub     x11, x10, #1
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-8
        add     x10, x29, x10
        add     x11, x10, x11
        mov     x10, #1
        str     x10, [x11]
        add     x10, x13, #1
        mov     x13, x10
        b     bb6
bb8:

        mov     x10, #0
        mov     x10, x10
        mov     x13, x10
        b     bb9
bb9:

        cmp     x13, x12
        b.lt     bb10
        b     bb11
bb10:

        sub     x11, x9, #1
        mov     x10, #3
        mul     x10, x11, x10
        add     x11, x10, x13
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-8
        add     x10, x29, x10
        add     x11, x10, x11
        mov     x10, #1
        str     x10, [x11]
        add     x10, x13, #1
        mov     x13, x10
        b     bb9
bb11:

        sub     x9, x9, #2
        mov     x11, x9
        b     bb12
bb12:

        mov     x9, #0
        sub     x9, x9, #1
        cmp     x11, x9
        b.gt     bb13
        b     bb14
bb13:

        sub     x9, x12, #2
        mov     x10, x9
        b     bb15
bb15:

        mov     x9, #0
        sub     x9, x9, #1
        cmp     x10, x9
        b.gt     bb16
        b     bb17
bb16:

        mov     x9, #3
        mul     x9, x11, x9
        add     x9, x9, x10
        add     x14, x11, #1
        mov     x13, #3
        mul     x13, x14, x13
        add     x14, x13, x10
        mov     x13, #3
        mul     x13, x11, x13
        add     x13, x13, x10
        add     x15, x13, #1
        mov     x13, #8
        mul     x14, x14, x13
        mov     x13, #-8
        add     x13, x29, x13
        add     x13, x13, x14
        ldr     x20, [x13]
        mov     x13, #8
        mul     x14, x15, x13
        mov     x13, #-8
        add     x13, x29, x13
        add     x13, x13, x14
        ldr     x13, [x13]
        add     x14, x20, x13
        mov     x13, #8
        mul     x13, x9, x13
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x13
        str     x14, [x9]
        sub     x9, x10, #1
        mov     x10, x9
        b     bb15
bb17:

        sub     x9, x11, #1
        mov     x11, x9
        b     bb12
bb14:

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x9, [x9]
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb18:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #3
        mov     x9, x9
        mov     x0, x9
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
        bl     uniquePaths
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x0, x0
        mov     sp, x29
        ret
