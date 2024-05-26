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
.global swap
.global heap_ajust
.global heap_sort
.global main
swap:

bb24:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     x12, x1
        mov     x11, x2
        mov     x10, #0
        mov     x9, x10
        mov     x10, #0
        mov     x9, x10
        mov     x13, x12
        mov     x10, #0
        mov     x9, x10
        mov     x12, x11
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x9, x10
        ldr     x11, [x10]
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x9, x10
        ldr     x14, [x10]
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x9, x10
        str     x14, [x10]
        mov     x10, #8
        mul     x10, x12, x10
        add     x9, x9, x10
        str     x11, [x9]
        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
heap_ajust:

bb25:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x12, x1
        mov     x10, x2
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x12, x12
        mov     x9, #0
        mov     x9, x9
        mov     x10, x10
        mov     x12, x12
        mov     x9, #2
        mul     x9, x12, x9
        add     x9, x9, #1
        mov     x14, x9
        mov     x9, x12
        b     bb3
bb3:

        add     x12, x10, #1
        cmp     x14, x12
        b.lt     bb4
        b     bb5
bb4:

        add     x13, x14, #1
        cmp     x14, x10
        b.lt     bb9
        b     bb7
bb9:

        mov     x12, #8
        mul     x12, x14, x12
        add     x12, x11, x12
        ldr     x15, [x12]
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x11, x12
        ldr     x12, [x12]
        cmp     x15, x12
        b.lt     bb6
        b     bb7
bb6:

        add     x12, x14, #1
        mov     x13, x12
        b     bb8
bb7:

        mov     x13, x14
        b     bb8
bb8:

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        ldr     x14, [x12]
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x11, x12
        ldr     x12, [x12]
        cmp     x14, x12
        b.gt     bb10
        b     bb11
bb10:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
bb11:

        mov     x0, x11
        mov     x1, x9
        mov     x2, x13
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
        bl     swap
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x12, x13
        mov     x9, #2
        mul     x9, x12, x9
        add     x9, x9, #1
        mov     x14, x9
        mov     x9, x12
        b     bb3
bb5:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
heap_sort:

bb27:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     x11, x1
        mov     x10, #0
        mov     x9, x10
        mov     x10, #0
        mov     x9, x10
        mov     x10, #0
        mov     x9, x10
        mov     x10, #0
        mov     x9, x10
        mov     x12, x11
        mov     x10, #2
        sdiv     x10, x12, x10
        sub     x10, x10, #1
        mov     x11, x10
        b     bb14
bb14:

        mov     x10, #0
        sub     x10, x10, #1
        cmp     x11, x10
        b.gt     bb15
        b     bb16
bb15:

        sub     x10, x12, #1
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
        bl     heap_ajust
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        sub     x10, x11, #1
        mov     x11, x10
        b     bb14
bb16:

        sub     x10, x12, #1
        mov     x12, x10
        b     bb17
bb17:

        mov     x10, #0
        cmp     x12, x10
        b.gt     bb18
        b     bb19
bb18:

        mov     x10, #0
        mov     x11, x10
        mov     x0, x9
        mov     x1, x11
        mov     x2, x12
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
        bl     swap
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        sub     x10, x12, #1
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
        bl     heap_ajust
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        sub     x10, x12, #1
        mov     x12, x10
        b     bb17
bb19:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb20:

        mov     x16, #80
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
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
        mov     x9, x9
        adr     x9, n
        ldr     x10, [x9]
        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x10
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
        bl     heap_sort
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
        b     bb21
bb21:

        adr     x9, n
        ldr     x9, [x9]
        cmp     x11, x9
        b.lt     bb22
        b     bb23
bb22:

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
        b     bb21
bb23:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
