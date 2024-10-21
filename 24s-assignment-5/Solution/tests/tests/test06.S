.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global foo
.global main
foo:

bb1:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, #1
        mov     x9, #256
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #176
        add     x11, x10, x9
        mov     x10, #3
        mov     x9, #8
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     w9, #5
        str     w9, [x10]
        mov     sp, x29
        ret
main:

bb2:

        mov     x16, #2560
        sub     sp, sp, x16
        mov     w9, #18
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
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     w9, #1
        str     w9, [x10]
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8
        add     x10, x10, x9
        mov     w9, #2
        str     w9, [x10]
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #16
        add     x11, x10, x9
        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #0
        add     x10, x10, x9
        mov     w9, #3
        str     w9, [x10]
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #16
        add     x11, x10, x9
        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #8
        add     x10, x10, x9
        mov     w9, #4
        str     w9, [x10]
        mov     x9, #-2560
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     foo
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #0
        add     x9, x10, x9
        ldr     w9, [x9]
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
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #0
        add     x10, x10, x9
        mov     x9, #8
        add     x9, x10, x9
        ldr     w9, [x9]
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
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #16
        add     x11, x10, x9
        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #0
        add     x9, x10, x9
        ldr     w9, [x9]
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
        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #16
        add     x11, x10, x9
        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #8
        add     x9, x10, x9
        ldr     w9, [x9]
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
        mov     x10, #1
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        mov     x9, #176
        add     x11, x10, x9
        mov     x10, #3
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        ldr     w9, [x9]
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
        mov     w9, #30
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
