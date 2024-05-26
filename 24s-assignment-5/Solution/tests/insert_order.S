.section .data

N:

        .zero   8
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
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x10, x10
        mov     x9, #0
        mov     x9, x9
        mov     x9, x9
        b     bb2
bb2:

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        ldr     x12, [x12]
        cmp     x10, x12
        b.gt     bb5
        b     bb4
bb5:

        adr     x12, N
        ldr     x12, [x12]
        cmp     x9, x12
        b.lt     bb3
        b     bb4
bb3:

        add     x9, x9, #1
        mov     x9, x9
        b     bb2
bb4:

        adr     x12, N
        ldr     x12, [x12]
        mov     x14, x12
        b     bb6
bb6:

        cmp     x14, x9
        b.gt     bb7
        b     bb8
bb7:

        sub     x13, x14, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x11, x12
        ldr     x13, [x12]
        mov     x12, #8
        mul     x12, x14, x12
        add     x12, x11, x12
        str     x13, [x12]
        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        str     x10, [x12]
        sub     x12, x14, #1
        mov     x14, x12
        b     bb6
bb8:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb9:

        mov     x16, #96
        sub     sp, sp, x16
        mov     x10, #10
        adr     x9, N
        str     x10, [x9]
        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #1
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
        mov     x9, #4
        str     x9, [x10]
        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #7
        str     x9, [x10]
        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #8
        str     x9, [x10]
        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #11
        str     x9, [x10]
        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #13
        str     x9, [x10]
        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #18
        str     x9, [x10]
        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #56
        str     x9, [x10]
        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #78
        str     x9, [x10]
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x10, x9
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
        mov     x9, #-8
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x0
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
        bl     insert
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x10
        b     bb10
bb10:

        adr     x9, N
        ldr     x9, [x9]
        cmp     x11, x9
        b.lt     bb11
        b     bb12
bb11:

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
        b     bb10
bb12:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
