.section .data

n:

        .zero   8
.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global Merge
.global MergeSort
.global main
Merge:

bb29:

        mov     x16, #160
        sub     sp, sp, x16
        mov     x15, x0
        mov     x12, x1
        mov     x11, x2
        mov     x10, x3
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
        mov     x14, x12
        mov     x9, #0
        mov     x9, x9
        mov     x11, x11
        mov     x9, #0
        mov     x9, x9
        mov     x9, x10
        sub     x10, x11, x14
        add     x13, x10, #1
        sub     x12, x9, x11
        mov     x9, #0
        mov     x20, x9
        mov     x9, #0
        mov     x10, x9
        mov     x9, x20
        b     bb2
bb2:

        cmp     x9, x13
        b.lt     bb3
        b     bb4
bb3:

        add     x21, x9, x14
        mov     x20, #8
        mul     x20, x21, x20
        add     x20, x15, x20
        ldr     x22, [x20]
        mov     x20, #8
        mul     x21, x9, x20
        mov     x20, #-88
        add     x20, x29, x20
        add     x20, x20, x21
        str     x22, [x20]
        add     x9, x9, #1
        mov     x9, x9
        b     bb2
bb4:

        mov     x9, x10
        b     bb5
bb5:

        cmp     x9, x12
        b.lt     bb6
        b     bb7
bb6:

        add     x10, x9, x11
        add     x20, x10, #1
        mov     x10, #8
        mul     x10, x20, x10
        add     x10, x15, x10
        ldr     x21, [x10]
        mov     x10, #8
        mul     x20, x9, x10
        mov     x10, #-8
        add     x10, x29, x10
        add     x10, x10, x20
        str     x21, [x10]
        add     x9, x9, #1
        mov     x9, x9
        b     bb5
bb7:

        mov     x9, #0
        mov     x20, x9
        mov     x9, #0
        mov     x11, x9
        mov     x10, x14
        mov     x9, x20
        mov     x11, x11
        mov     x10, x10
        b     bb8
bb8:

        cmp     x9, x13
        b.ne     bb11
        b     bb10
bb11:

        cmp     x11, x12
        b.ne     bb9
        b     bb10
bb9:

        mov     x14, #8
        mul     x20, x9, x14
        mov     x14, #-88
        add     x14, x29, x14
        add     x14, x14, x20
        ldr     x21, [x14]
        mov     x14, #8
        mul     x20, x11, x14
        mov     x14, #-8
        add     x14, x29, x14
        add     x14, x14, x20
        ldr     x14, [x14]
        add     x14, x14, #1
        cmp     x21, x14
        b.lt     bb12
        b     bb13
bb12:

        mov     x14, #8
        mul     x20, x9, x14
        mov     x14, #-88
        add     x14, x29, x14
        add     x14, x14, x20
        ldr     x20, [x14]
        mov     x14, #8
        mul     x14, x10, x14
        add     x14, x15, x14
        str     x20, [x14]
        add     x10, x10, #1
        add     x9, x9, #1
        mov     x9, x9
        mov     x11, x11
        mov     x10, x10
        b     bb14
bb13:

        mov     x14, #8
        mul     x20, x11, x14
        mov     x14, #-8
        add     x14, x29, x14
        add     x14, x14, x20
        ldr     x20, [x14]
        mov     x14, #8
        mul     x14, x10, x14
        add     x14, x15, x14
        str     x20, [x14]
        add     x14, x10, #1
        add     x10, x11, #1
        mov     x9, x9
        mov     x11, x10
        mov     x10, x14
        b     bb14
bb14:

        mov     x9, x9
        mov     x11, x11
        mov     x10, x10
        b     bb8
bb10:

        mov     x9, x9
        mov     x20, x10
        b     bb15
bb15:

        cmp     x9, x13
        b.lt     bb16
        b     bb17
bb16:

        mov     x10, #8
        mul     x14, x9, x10
        mov     x10, #-88
        add     x10, x29, x10
        add     x10, x10, x14
        ldr     x14, [x10]
        mov     x10, #8
        mul     x10, x20, x10
        add     x10, x15, x10
        str     x14, [x10]
        add     x10, x20, #1
        add     x9, x9, #1
        mov     x9, x9
        mov     x20, x10
        b     bb15
bb17:

        mov     x13, x11
        mov     x11, x20
        b     bb18
bb18:

        cmp     x13, x12
        b.lt     bb19
        b     bb20
bb19:

        mov     x9, #8
        mul     x10, x13, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x10, [x9]
        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x15, x9
        str     x10, [x9]
        add     x10, x11, #1
        add     x9, x13, #1
        mov     x13, x9
        mov     x11, x10
        b     bb18
bb20:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
MergeSort:

bb30:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x11, x1
        mov     x10, x2
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x12, x11
        mov     x9, #0
        mov     x9, x9
        mov     x11, x10
        cmp     x12, x11
        b.lt     bb22
        b     bb23
bb22:

        add     x10, x12, x11
        mov     x9, #2
        sdiv     x10, x10, x9
        mov     x0, x13
        mov     x1, x12
        mov     x2, x10
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
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        add     x9, x10, #1
        mov     x0, x13
        mov     x1, x9
        mov     x2, x11
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
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x0, x13
        mov     x1, x12
        mov     x2, x10
        mov     x3, x11
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
        bl     Merge
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb24
bb23:

        b     bb24
bb24:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb25:

        mov     x16, #80
        sub     sp, sp, x16
        mov     x10, #10
        adr     x9, n
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #4
        str     x9, [x10]
        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #3
        str     x9, [x10]
        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #9
        str     x9, [x10]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #2
        str     x9, [x10]
        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #0
        str     x9, [x10]
        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #1
        str     x9, [x10]
        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #6
        str     x9, [x10]
        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #5
        str     x9, [x10]
        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #7
        str     x9, [x10]
        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #8
        str     x9, [x10]
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x11, x9
        mov     x9, #0
        mov     x9, x9
        adr     x9, n
        ldr     x9, [x9]
        sub     x10, x9, #1
        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x11
        mov     x2, x10
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
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        b     bb26
bb26:

        adr     x9, n
        ldr     x9, [x9]
        cmp     x11, x9
        b.lt     bb27
        b     bb28
bb27:

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x9, [x9]
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
        add     x9, x11, #1
        mov     x11, x9
        b     bb26
bb28:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
