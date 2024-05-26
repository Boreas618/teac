.section .data

a1:

        .word   1
a2:

        .word   2
a3:

        .word   3
a4:

        .word   4
a5:

        .word   5
a6:

        .word   6
a7:

        .word   7
a8:

        .word   8
a9:

        .word   9
a10:

        .word   10
a11:

        .word   11
a12:

        .word   12
a13:

        .word   13
a14:

        .word   14
a15:

        .word   15
a16:

        .word   16
a17:

        .word   1
a18:

        .word   2
a19:

        .word   3
a20:

        .word   4
a21:

        .word   5
a22:

        .word   6
a23:

        .word   7
a24:

        .word   8
a25:

        .word   9
a26:

        .word   10
a27:

        .word   11
a28:

        .word   12
a29:

        .word   13
a30:

        .word   14
a31:

        .word   15
a32:

        .word   16
.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global func
.global main
func:

bb3:

        mov     x16, #328
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, x1
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x11, #0
        mov     x9, x11
        mov     x16, x10
        mov     x17, #72
        str     x16, [sp,x17]
        mov     x10, #0
        mov     x9, x10
        mov     x16, x9
        mov     x17, #80
        str     x16, [sp,x17]
        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     x16, #80
        ldr     x18, [sp,x16]
        add     x9, x19, x18
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
        mov     x9, #1
        add     x10, x9, x0
        adr     x9, a1
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #88
        str     x16, [sp,x17]
        mov     x9, #2
        add     x10, x9, x0
        adr     x9, a2
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #96
        str     x16, [sp,x17]
        mov     x9, #3
        add     x10, x9, x0
        adr     x9, a3
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #104
        str     x16, [sp,x17]
        mov     x9, #4
        add     x10, x9, x0
        adr     x9, a4
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #112
        str     x16, [sp,x17]
        mov     x9, #1
        mov     x16, #88
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a5
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #120
        str     x16, [sp,x17]
        mov     x9, #2
        mov     x16, #96
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a6
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #128
        str     x16, [sp,x17]
        mov     x9, #3
        mov     x16, #104
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a7
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #136
        str     x16, [sp,x17]
        mov     x9, #4
        mov     x16, #112
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a8
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #144
        str     x16, [sp,x17]
        mov     x9, #1
        mov     x16, #120
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a9
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #152
        str     x16, [sp,x17]
        mov     x9, #2
        mov     x16, #128
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a10
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #160
        str     x16, [sp,x17]
        mov     x9, #3
        mov     x16, #136
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a11
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #168
        str     x16, [sp,x17]
        mov     x9, #4
        mov     x16, #144
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a12
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #176
        str     x16, [sp,x17]
        mov     x9, #1
        mov     x16, #152
        ldr     x19, [sp,x16]
        add     x9, x9, x19
        adr     x10, a13
        ldr     x10, [x10]
        add     x16, x9, x10
        mov     x17, #184
        str     x16, [sp,x17]
        mov     x9, #2
        mov     x16, #160
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a14
        ldr     x9, [x9]
        add     x28, x10, x9
        mov     x9, #3
        mov     x16, #168
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a15
        ldr     x9, [x9]
        add     x27, x10, x9
        mov     x9, #4
        mov     x16, #176
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a16
        ldr     x9, [x9]
        add     x26, x10, x9
        mov     x9, #1
        mov     x16, #184
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a17
        ldr     x9, [x9]
        add     x25, x10, x9
        mov     x9, #2
        add     x10, x9, x28
        adr     x9, a18
        ldr     x9, [x9]
        add     x24, x10, x9
        mov     x9, #3
        add     x10, x9, x27
        adr     x9, a19
        ldr     x9, [x9]
        add     x23, x10, x9
        mov     x9, #4
        add     x10, x9, x26
        adr     x9, a20
        ldr     x9, [x9]
        add     x22, x10, x9
        mov     x9, #1
        add     x10, x9, x25
        adr     x9, a21
        ldr     x9, [x9]
        add     x21, x10, x9
        mov     x9, #2
        add     x10, x9, x24
        adr     x9, a22
        ldr     x9, [x9]
        add     x20, x10, x9
        mov     x9, #3
        add     x10, x9, x23
        adr     x9, a23
        ldr     x9, [x9]
        add     x15, x10, x9
        mov     x9, #4
        add     x10, x9, x22
        adr     x9, a24
        ldr     x9, [x9]
        add     x14, x10, x9
        mov     x9, #1
        add     x10, x9, x21
        adr     x9, a25
        ldr     x9, [x9]
        add     x13, x10, x9
        mov     x9, #2
        add     x10, x9, x20
        adr     x9, a26
        ldr     x9, [x9]
        add     x12, x10, x9
        mov     x9, #3
        add     x10, x9, x15
        adr     x9, a27
        ldr     x9, [x9]
        add     x11, x10, x9
        mov     x9, #4
        add     x10, x9, x14
        adr     x9, a28
        ldr     x9, [x9]
        add     x10, x10, x9
        mov     x9, #1
        add     x16, x9, x13
        mov     x17, #0
        str     x16, [sp,x17]
        adr     x9, a29
        ldr     x9, [x9]
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        mov     x9, #2
        add     x16, x9, x12
        mov     x17, #8
        str     x16, [sp,x17]
        adr     x9, a30
        ldr     x9, [x9]
        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        mov     x9, #3
        add     x16, x9, x11
        mov     x17, #16
        str     x16, [sp,x17]
        adr     x9, a31
        ldr     x9, [x9]
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        mov     x9, #4
        add     x16, x9, x10
        mov     x17, #24
        str     x16, [sp,x17]
        adr     x9, a32
        ldr     x9, [x9]
        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     x16, #80
        ldr     x18, [sp,x16]
        sub     x9, x19, x18
        add     x16, x9, #10
        mov     x17, #192
        str     x16, [sp,x17]
        mov     x9, #1
        add     x13, x9, x13
        adr     x9, a29
        ldr     x9, [x9]
        add     x16, x13, x9
        mov     x17, #200
        str     x16, [sp,x17]
        mov     x9, #2
        add     x12, x9, x12
        adr     x9, a30
        ldr     x9, [x9]
        add     x16, x12, x9
        mov     x17, #208
        str     x16, [sp,x17]
        mov     x9, #3
        add     x11, x9, x11
        adr     x9, a31
        ldr     x9, [x9]
        add     x16, x11, x9
        mov     x17, #216
        str     x16, [sp,x17]
        mov     x9, #4
        add     x10, x9, x10
        adr     x9, a32
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #224
        str     x16, [sp,x17]
        mov     x9, #1
        add     x10, x9, x21
        adr     x9, a25
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #232
        str     x16, [sp,x17]
        mov     x9, #2
        add     x10, x9, x20
        adr     x9, a26
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #240
        str     x16, [sp,x17]
        mov     x9, #3
        add     x10, x9, x15
        adr     x9, a27
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #248
        str     x16, [sp,x17]
        mov     x9, #4
        add     x10, x9, x14
        adr     x9, a28
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #256
        str     x16, [sp,x17]
        mov     x9, #1
        add     x10, x9, x25
        adr     x9, a21
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #264
        str     x16, [sp,x17]
        mov     x9, #2
        add     x10, x9, x24
        adr     x9, a22
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #272
        str     x16, [sp,x17]
        mov     x9, #3
        add     x10, x9, x23
        adr     x9, a23
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #280
        str     x16, [sp,x17]
        mov     x9, #4
        add     x10, x9, x22
        adr     x9, a24
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #288
        str     x16, [sp,x17]
        mov     x9, #1
        mov     x16, #184
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a17
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #296
        str     x16, [sp,x17]
        mov     x9, #2
        add     x10, x9, x28
        adr     x9, a18
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #304
        str     x16, [sp,x17]
        mov     x9, #3
        add     x10, x9, x27
        adr     x9, a19
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #312
        str     x16, [sp,x17]
        mov     x9, #4
        add     x10, x9, x26
        adr     x9, a20
        ldr     x9, [x9]
        add     x16, x10, x9
        mov     x17, #320
        str     x16, [sp,x17]
        mov     x9, #1
        mov     x16, #152
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a13
        ldr     x9, [x9]
        add     x28, x10, x9
        mov     x9, #2
        mov     x16, #160
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a14
        ldr     x9, [x9]
        add     x27, x10, x9
        mov     x9, #3
        mov     x16, #168
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a15
        ldr     x9, [x9]
        add     x26, x10, x9
        mov     x9, #4
        mov     x16, #176
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a16
        ldr     x9, [x9]
        add     x25, x10, x9
        mov     x9, #1
        mov     x16, #120
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a9
        ldr     x9, [x9]
        add     x24, x10, x9
        mov     x9, #2
        mov     x16, #128
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a10
        ldr     x9, [x9]
        add     x23, x10, x9
        mov     x9, #3
        mov     x16, #136
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a11
        ldr     x9, [x9]
        add     x22, x10, x9
        mov     x9, #4
        mov     x16, #144
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a12
        ldr     x9, [x9]
        add     x21, x10, x9
        mov     x9, #1
        mov     x16, #88
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a5
        ldr     x9, [x9]
        add     x20, x10, x9
        mov     x9, #2
        mov     x16, #96
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a6
        ldr     x9, [x9]
        add     x15, x10, x9
        mov     x9, #3
        mov     x16, #104
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a7
        ldr     x9, [x9]
        add     x14, x10, x9
        mov     x9, #4
        mov     x16, #112
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a8
        ldr     x9, [x9]
        add     x13, x10, x9
        mov     x9, #1
        add     x10, x9, x0
        adr     x9, a1
        ldr     x9, [x9]
        add     x9, x10, x9
        mov     x9, #2
        add     x10, x9, x0
        adr     x9, a2
        ldr     x9, [x9]
        add     x9, x10, x9
        mov     x9, #3
        add     x10, x9, x0
        adr     x9, a3
        ldr     x9, [x9]
        add     x9, x10, x9
        mov     x9, #4
        add     x10, x9, x0
        adr     x9, a4
        ldr     x9, [x9]
        add     x9, x10, x9
        mov     x9, #1
        add     x10, x9, x0
        adr     x9, a1
        ldr     x9, [x9]
        add     x12, x10, x9
        mov     x9, #2
        add     x10, x9, x0
        adr     x9, a2
        ldr     x9, [x9]
        add     x11, x10, x9
        mov     x9, #3
        add     x10, x9, x0
        adr     x9, a3
        ldr     x9, [x9]
        add     x10, x10, x9
        mov     x9, #4
        add     x16, x9, x0
        mov     x17, #32
        str     x16, [sp,x17]
        adr     x9, a4
        ldr     x9, [x9]
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        mov     x16, #192
        ldr     x19, [sp,x16]
        add     x16, x19, x0
        mov     x17, #40
        str     x16, [sp,x17]
        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x16, x19, x0
        mov     x17, #48
        str     x16, [sp,x17]
        mov     x16, #48
        ldr     x19, [sp,x16]
        add     x16, x19, x0
        mov     x17, #56
        str     x16, [sp,x17]
        mov     x16, #56
        ldr     x19, [sp,x16]
        add     x16, x19, x0
        mov     x17, #64
        str     x16, [sp,x17]
        mov     x16, #64
        ldr     x19, [sp,x16]
        sub     x12, x19, x12
        sub     x11, x12, x11
        sub     x10, x11, x10
        sub     x9, x10, x9
        add     x9, x9, x20
        add     x9, x9, x15
        add     x9, x9, x14
        add     x9, x9, x13
        sub     x9, x9, x24
        sub     x9, x9, x23
        sub     x9, x9, x22
        sub     x9, x9, x21
        add     x9, x9, x28
        add     x9, x9, x27
        add     x9, x9, x26
        add     x9, x9, x25
        mov     x16, #296
        ldr     x19, [sp,x16]
        sub     x9, x9, x19
        mov     x16, #304
        ldr     x19, [sp,x16]
        sub     x9, x9, x19
        mov     x16, #312
        ldr     x19, [sp,x16]
        sub     x9, x9, x19
        mov     x16, #320
        ldr     x19, [sp,x16]
        sub     x9, x9, x19
        mov     x16, #264
        ldr     x19, [sp,x16]
        add     x9, x9, x19
        mov     x16, #272
        ldr     x19, [sp,x16]
        add     x9, x9, x19
        mov     x16, #280
        ldr     x19, [sp,x16]
        add     x9, x9, x19
        mov     x16, #288
        ldr     x19, [sp,x16]
        add     x9, x9, x19
        mov     x16, #232
        ldr     x19, [sp,x16]
        sub     x9, x9, x19
        mov     x16, #240
        ldr     x19, [sp,x16]
        sub     x9, x9, x19
        mov     x16, #248
        ldr     x19, [sp,x16]
        sub     x9, x9, x19
        mov     x16, #256
        ldr     x19, [sp,x16]
        sub     x9, x9, x19
        mov     x16, #200
        ldr     x19, [sp,x16]
        add     x9, x9, x19
        mov     x16, #208
        ldr     x19, [sp,x16]
        add     x9, x9, x19
        mov     x16, #216
        ldr     x19, [sp,x16]
        add     x9, x9, x19
        mov     x16, #224
        ldr     x19, [sp,x16]
        add     x10, x9, x19
        adr     x9, a1
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a2
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a3
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a4
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a5
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a6
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a7
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a8
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a9
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a10
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a11
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a12
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a13
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a14
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a15
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a16
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a17
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a18
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a19
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a20
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a21
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a22
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a23
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a24
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a25
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a26
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a27
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a28
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a29
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a30
        ldr     x9, [x9]
        sub     x10, x10, x9
        adr     x9, a31
        ldr     x9, [x9]
        add     x10, x10, x9
        adr     x9, a32
        ldr     x9, [x9]
        sub     x9, x10, x9
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb2:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
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
        mov     x10, #2
        mov     x9, #9
        mul     x9, x10, x9
        add     x9, x0, x9
        mov     x0, x0
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
        bl     func
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
        mov     x0, x0
        mov     sp, x29
        ret
