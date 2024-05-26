.section .data

TAPE_LEN:

        .word   65536
BUFFER_LEN:

        .word   32768
tape:

        .zero   524288
program:

        .zero   262144
ptr:

        .zero   8
.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global read_program
.global interpret
.global main
read_program:

bb1:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x10, x9
        mov     x9, #0
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
        mov     x11, x10
        b     bb2
bb2:

        cmp     x11, x0
        b.lt     bb3
        b     bb4
bb3:

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
        bl     getch
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
        adr     x9, program
        add     x9, x9, x10
        str     x0, [x9]
        add     x9, x11, #1
        mov     x11, x9
        b     bb2
bb4:

        mov     x9, #8
        mul     x10, x11, x9
        adr     x9, program
        add     x10, x9, x10
        mov     x9, #0
        str     x9, [x10]
        mov     sp, x29
        ret
interpret:

bb5:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x9, #0
        mov     x9, x9
        mov     x10, x9
        b     bb6
bb6:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        ldr     x12, [x9]
        mov     x9, #0
        cmp     x12, x9
        b.ne     bb7
        b     bb8
bb7:

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        ldr     x9, [x9]
        mov     x12, #62
        cmp     x9, x12
        b.eq     bb9
        b     bb10
bb9:

        adr     x12, ptr
        ldr     x12, [x12]
        add     x13, x12, #1
        adr     x12, ptr
        str     x13, [x12]
        b     bb11
bb10:

        b     bb11
bb11:

        mov     x12, #60
        cmp     x9, x12
        b.eq     bb12
        b     bb13
bb12:

        adr     x12, ptr
        ldr     x12, [x12]
        sub     x13, x12, #1
        adr     x12, ptr
        str     x13, [x12]
        b     bb14
bb13:

        b     bb14
bb14:

        mov     x12, #43
        cmp     x9, x12
        b.eq     bb15
        b     bb16
bb15:

        adr     x12, ptr
        ldr     x13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adr     x12, tape
        add     x12, x12, x13
        ldr     x12, [x12]
        add     x14, x12, #1
        adr     x12, ptr
        ldr     x13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adr     x12, tape
        add     x12, x12, x13
        str     x14, [x12]
        b     bb17
bb16:

        b     bb17
bb17:

        mov     x12, #45
        cmp     x9, x12
        b.eq     bb18
        b     bb19
bb18:

        adr     x12, ptr
        ldr     x13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adr     x12, tape
        add     x12, x12, x13
        ldr     x12, [x12]
        sub     x14, x12, #1
        adr     x12, ptr
        ldr     x13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adr     x12, tape
        add     x12, x12, x13
        str     x14, [x12]
        b     bb20
bb19:

        b     bb20
bb20:

        mov     x12, #46
        cmp     x9, x12
        b.eq     bb21
        b     bb22
bb21:

        adr     x12, ptr
        ldr     x13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adr     x12, tape
        add     x12, x12, x13
        ldr     x12, [x12]
        mov     x0, x12
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
        b     bb23
bb22:

        b     bb23
bb23:

        mov     x12, #44
        cmp     x9, x12
        b.eq     bb24
        b     bb25
bb24:

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
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adr     x12, ptr
        ldr     x13, [x12]
        mov     x12, #8
        mul     x13, x13, x12
        adr     x12, tape
        add     x12, x12, x13
        str     x0, [x12]
        b     bb26
bb25:

        b     bb26
bb26:

        mov     x12, #93
        cmp     x9, x12
        b.eq     bb30
        b     bb28
bb30:

        adr     x9, ptr
        ldr     x12, [x9]
        mov     x9, #8
        mul     x12, x12, x9
        adr     x9, tape
        add     x9, x9, x12
        ldr     x12, [x9]
        mov     x9, #0
        cmp     x12, x9
        b.ne     bb27
        b     bb28
bb27:

        mov     x9, #1
        mov     x9, x9
        mov     x14, x9
        mov     x10, x10
        b     bb31
bb31:

        mov     x9, #0
        cmp     x14, x9
        b.gt     bb32
        b     bb33
bb32:

        sub     x13, x10, #1
        mov     x9, #8
        mul     x9, x13, x9
        add     x9, x11, x9
        ldr     x12, [x9]
        mov     x9, #91
        cmp     x12, x9
        b.eq     bb34
        b     bb35
bb34:

        sub     x9, x14, #1
        mov     x10, x9
        b     bb36
bb35:

        mov     x10, x14
        b     bb36
bb36:

        mov     x9, #93
        cmp     x12, x9
        b.eq     bb37
        b     bb38
bb37:

        add     x9, x10, #1
        mov     x9, x9
        b     bb39
bb38:

        mov     x9, x10
        b     bb39
bb39:

        mov     x14, x9
        mov     x10, x13
        b     bb31
bb33:

        mov     x9, x10
        b     bb29
bb28:

        mov     x9, x10
        b     bb29
bb29:

        add     x9, x9, #1
        mov     x10, x9
        b     bb6
bb8:

        mov     sp, x29
        ret
main:

bb40:

        mov     x16, #0
        sub     sp, sp, x16
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
        bl     read_program
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adr     x9, program
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
        bl     interpret
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
