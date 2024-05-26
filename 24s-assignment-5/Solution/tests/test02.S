.section .data

a:

        .word   1
b:

        .zero   80
c:

        .zero   16
d:

        .zero   160
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

        mov     x16, #64
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
        mov     x9, #1
        mov     x9, x9
        mov     x11, #0
        mov     x10, #16
        mul     x11, x11, x10
        mov     x10, #-8
        add     x10, x29, x10
        add     x11, x10, x11
        mov     x10, #1
        str     x10, [x11]
        mov     x11, #1
        mov     x10, #16
        mul     x11, x11, x10
        mov     x10, #-8
        add     x10, x29, x10
        add     x11, x10, x11
        mov     x10, #1
        str     x10, [x11]
        mov     x11, #1
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-24
        add     x10, x29, x10
        add     x10, x10, x11
        str     x9, [x10]
        mov     x11, #0
        mov     x10, #16
        mul     x11, x11, x10
        mov     x10, #-8
        add     x10, x29, x10
        add     x10, x10, x11
        ldr     x12, [x10]
        mov     x11, #2
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-24
        add     x10, x29, x10
        add     x10, x10, x11
        str     x12, [x10]
        mov     x11, #3
        mov     x10, #16
        mul     x11, x11, x10
        mov     x10, #-40
        add     x10, x29, x10
        add     x12, x10, x11
        mov     x11, #0
        mov     x10, #16
        mul     x10, x11, x10
        add     x10, x12, x10
        str     x9, [x10]
        adr     x10, a
        str     x9, [x10]
        mov     x10, #0
        mov     x9, #16
        mul     x10, x10, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        ldr     x11, [x9]
        mov     x10, #8
        adr     x9, c
        add     x9, x9, x10
        str     x11, [x9]
        mov     x10, #10
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, b
        add     x10, x9, x10
        mov     x9, #1
        str     x9, [x10]
        mov     x10, #8
        adr     x9, c
        add     x9, x9, x10
        ldr     x11, [x9]
        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        adr     x9, b
        add     x9, x9, x10
        str     x11, [x9]
        mov     x10, #3
        mov     x9, #16
        mul     x10, x10, x9
        adr     x9, d
        add     x11, x9, x10
        mov     x10, #0
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #1
        str     x9, [x10]
        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
