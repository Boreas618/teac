.section .data

a0:

        .zero   8
a1:

        .zero   8
a2:

        .zero   8
a3:

        .zero   8
a4:

        .zero   8
a5:

        .zero   8
a6:

        .zero   8
a7:

        .zero   8
a8:

        .zero   8
a9:

        .zero   8
a10:

        .zero   8
a11:

        .zero   8
a12:

        .zero   8
a13:

        .zero   8
a14:

        .zero   8
a15:

        .zero   8
a16:

        .zero   8
a17:

        .zero   8
a18:

        .zero   8
a19:

        .zero   8
a20:

        .zero   8
a21:

        .zero   8
a22:

        .zero   8
a23:

        .zero   8
a24:

        .zero   8
a25:

        .zero   8
a26:

        .zero   8
a27:

        .zero   8
a28:

        .zero   8
a29:

        .zero   8
a30:

        .zero   8
a31:

        .zero   8
a32:

        .zero   8
a33:

        .zero   8
a34:

        .zero   8
a35:

        .zero   8
a36:

        .zero   8
a37:

        .zero   8
a38:

        .zero   8
a39:

        .zero   8
.section .text

.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global testParam8
.global testParam16
.global testParam32
.global main
testParam8:

bb5:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x12, x1
        mov     x11, x2
        mov     x21, x3
        mov     x9, x4
        mov     x20, x5
        mov     x15, x6
        mov     x14, x7
        mov     x10, #0
        mov     x9, x10
        mov     x13, x13
        mov     x10, #0
        mov     x9, x10
        mov     x12, x12
        mov     x10, #0
        mov     x9, x10
        mov     x11, x11
        mov     x10, #0
        mov     x9, x10
        mov     x10, x21
        mov     x21, #0
        mov     x9, x21
        mov     x9, x9
        mov     x21, #0
        mov     x9, x21
        mov     x21, x20
        mov     x20, #0
        mov     x9, x20
        mov     x20, x15
        mov     x15, #0
        mov     x9, x15
        mov     x14, x14
        add     x12, x13, x12
        add     x11, x12, x11
        add     x10, x11, x10
        add     x9, x10, x9
        add     x9, x9, x21
        add     x9, x9, x20
        add     x9, x9, x14
        mov     x0, x9
        mov     sp, x29
        ret
testParam16:

bb6:

        mov     x16, #8
        sub     sp, sp, x16
        mov     x28, x0
        mov     x27, x1
        mov     x26, x2
        mov     x25, x3
        mov     x24, x4
        mov     x23, x5
        mov     x22, x6
        mov     x21, x7
        mov     x20, x8
        mov     x15, x9
        mov     x14, x10
        mov     x13, x11
        mov     x12, x12
        mov     x11, x13
        mov     x10, x14
        mov     x16, x15
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x28, x28
        mov     x9, #0
        mov     x9, x9
        mov     x27, x27
        mov     x9, #0
        mov     x9, x9
        mov     x26, x26
        mov     x9, #0
        mov     x9, x9
        mov     x25, x25
        mov     x9, #0
        mov     x9, x9
        mov     x24, x24
        mov     x9, #0
        mov     x9, x9
        mov     x23, x23
        mov     x9, #0
        mov     x9, x9
        mov     x22, x22
        mov     x9, #0
        mov     x9, x9
        mov     x21, x21
        mov     x9, #0
        mov     x9, x9
        mov     x20, x20
        mov     x9, #0
        mov     x9, x9
        mov     x15, x15
        mov     x9, #0
        mov     x9, x9
        mov     x14, x14
        mov     x9, #0
        mov     x9, x9
        mov     x13, x13
        mov     x9, #0
        mov     x9, x9
        mov     x12, x12
        mov     x9, #0
        mov     x9, x9
        mov     x11, x11
        mov     x9, #0
        mov     x9, x9
        mov     x10, x10
        mov     x9, #0
        mov     x9, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x9, x19
        add     x27, x28, x27
        add     x26, x27, x26
        sub     x25, x26, x25
        sub     x24, x25, x24
        sub     x23, x24, x23
        sub     x22, x23, x22
        sub     x21, x22, x21
        add     x20, x21, x20
        add     x15, x20, x15
        add     x14, x15, x14
        add     x13, x14, x13
        add     x12, x13, x12
        add     x11, x12, x11
        add     x10, x11, x10
        add     x9, x10, x9
        mov     x0, x9
        mov     sp, x29
        ret
testParam32:

bb7:

        mov     x16, #384
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x16, x1
        mov     x17, #8
        str     x16, [sp,x17]
        mov     x16, x2
        mov     x17, #16
        str     x16, [sp,x17]
        mov     x16, x3
        mov     x17, #24
        str     x16, [sp,x17]
        mov     x16, x4
        mov     x17, #32
        str     x16, [sp,x17]
        mov     x16, x5
        mov     x17, #40
        str     x16, [sp,x17]
        mov     x16, x6
        mov     x17, #48
        str     x16, [sp,x17]
        mov     x16, x7
        mov     x17, #56
        str     x16, [sp,x17]
        mov     x16, x8
        mov     x17, #64
        str     x16, [sp,x17]
        mov     x16, x9
        mov     x17, #72
        str     x16, [sp,x17]
        mov     x16, x10
        mov     x17, #80
        str     x16, [sp,x17]
        mov     x16, x11
        mov     x17, #88
        str     x16, [sp,x17]
        mov     x16, x12
        mov     x17, #96
        str     x16, [sp,x17]
        mov     x16, x13
        mov     x17, #104
        str     x16, [sp,x17]
        mov     x16, x14
        mov     x17, #112
        str     x16, [sp,x17]
        mov     x16, x15
        mov     x17, #120
        str     x16, [sp,x17]
        mov     x28, x16
        mov     x27, x17
        mov     x26, x18
        mov     x25, x19
        mov     x24, x20
        mov     x23, x21
        mov     x22, x22
        mov     x21, x23
        mov     x20, x24
        mov     x15, x25
        mov     x14, x26
        mov     x13, x27
        mov     x12, x28
        mov     x11, x29
        mov     x10, x30
        mov     x16, x31
        mov     x17, #128
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #256
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #264
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #272
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #280
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #288
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #296
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #304
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #312
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #64
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #320
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #328
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #80
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #336
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #88
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #344
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #96
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #352
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #104
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #360
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #112
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #368
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x16, #120
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #376
        str     x16, [sp,x17]
        mov     x9, #0
        mov     x9, x9
        mov     x28, x28
        mov     x9, #0
        mov     x9, x9
        mov     x27, x27
        mov     x9, #0
        mov     x9, x9
        mov     x26, x26
        mov     x9, #0
        mov     x9, x9
        mov     x25, x25
        mov     x9, #0
        mov     x9, x9
        mov     x24, x24
        mov     x9, #0
        mov     x9, x9
        mov     x23, x23
        mov     x9, #0
        mov     x9, x9
        mov     x22, x22
        mov     x9, #0
        mov     x9, x9
        mov     x21, x21
        mov     x9, #0
        mov     x9, x9
        mov     x20, x20
        mov     x9, #0
        mov     x9, x9
        mov     x15, x15
        mov     x9, #0
        mov     x9, x9
        mov     x14, x14
        mov     x9, #0
        mov     x9, x9
        mov     x13, x13
        mov     x9, #0
        mov     x9, x9
        mov     x12, x12
        mov     x9, #0
        mov     x9, x9
        mov     x11, x11
        mov     x9, #0
        mov     x9, x9
        mov     x10, x10
        mov     x9, #0
        mov     x9, x9
        mov     x16, #128
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x16, #256
        ldr     x19, [sp,x16]
        mov     x16, #264
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #136
        str     x16, [sp,x17]
        mov     x16, #136
        ldr     x19, [sp,x16]
        mov     x16, #272
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #144
        str     x16, [sp,x17]
        mov     x16, #144
        ldr     x19, [sp,x16]
        mov     x16, #280
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #152
        str     x16, [sp,x17]
        mov     x16, #152
        ldr     x19, [sp,x16]
        mov     x16, #288
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #160
        str     x16, [sp,x17]
        mov     x16, #160
        ldr     x19, [sp,x16]
        mov     x16, #296
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #168
        str     x16, [sp,x17]
        mov     x16, #168
        ldr     x19, [sp,x16]
        mov     x16, #304
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #176
        str     x16, [sp,x17]
        mov     x16, #176
        ldr     x19, [sp,x16]
        mov     x16, #312
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #184
        str     x16, [sp,x17]
        mov     x16, #184
        ldr     x19, [sp,x16]
        mov     x16, #320
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #192
        str     x16, [sp,x17]
        mov     x16, #192
        ldr     x19, [sp,x16]
        mov     x16, #328
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #200
        str     x16, [sp,x17]
        mov     x16, #200
        ldr     x19, [sp,x16]
        mov     x16, #336
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #208
        str     x16, [sp,x17]
        mov     x16, #208
        ldr     x19, [sp,x16]
        mov     x16, #344
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #216
        str     x16, [sp,x17]
        mov     x16, #216
        ldr     x19, [sp,x16]
        mov     x16, #352
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #224
        str     x16, [sp,x17]
        mov     x16, #224
        ldr     x19, [sp,x16]
        mov     x16, #360
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #232
        str     x16, [sp,x17]
        mov     x16, #232
        ldr     x19, [sp,x16]
        mov     x16, #368
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #240
        str     x16, [sp,x17]
        mov     x16, #240
        ldr     x19, [sp,x16]
        mov     x16, #376
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #248
        str     x16, [sp,x17]
        mov     x16, #248
        ldr     x19, [sp,x16]
        add     x28, x19, x28
        add     x27, x28, x27
        sub     x26, x27, x26
        sub     x25, x26, x25
        sub     x24, x25, x24
        sub     x23, x24, x23
        sub     x22, x23, x22
        add     x21, x22, x21
        add     x20, x21, x20
        add     x15, x20, x15
        add     x14, x15, x14
        add     x13, x14, x13
        add     x12, x13, x12
        add     x11, x12, x11
        add     x10, x11, x10
        add     x9, x10, x9
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb4:

        mov     x16, #128
        sub     sp, sp, x16
        mov     x9, #97
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
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, #0
        adr     x9, a0
        str     x10, [x9]
        mov     x10, #1
        adr     x9, a1
        str     x10, [x9]
        mov     x10, #2
        adr     x9, a2
        str     x10, [x9]
        mov     x10, #3
        adr     x9, a3
        str     x10, [x9]
        mov     x10, #4
        adr     x9, a4
        str     x10, [x9]
        mov     x10, #5
        adr     x9, a5
        str     x10, [x9]
        mov     x10, #6
        adr     x9, a6
        str     x10, [x9]
        mov     x10, #7
        adr     x9, a7
        str     x10, [x9]
        mov     x10, #8
        adr     x9, a8
        str     x10, [x9]
        mov     x10, #9
        adr     x9, a9
        str     x10, [x9]
        mov     x10, #0
        adr     x9, a10
        str     x10, [x9]
        mov     x10, #1
        adr     x9, a11
        str     x10, [x9]
        mov     x10, #2
        adr     x9, a12
        str     x10, [x9]
        mov     x10, #3
        adr     x9, a13
        str     x10, [x9]
        mov     x10, #4
        adr     x9, a14
        str     x10, [x9]
        mov     x10, #5
        adr     x9, a15
        str     x10, [x9]
        mov     x10, #6
        adr     x9, a16
        str     x10, [x9]
        mov     x10, #7
        adr     x9, a17
        str     x10, [x9]
        mov     x10, #8
        adr     x9, a18
        str     x10, [x9]
        mov     x10, #9
        adr     x9, a19
        str     x10, [x9]
        mov     x10, #0
        adr     x9, a20
        str     x10, [x9]
        mov     x10, #1
        adr     x9, a21
        str     x10, [x9]
        mov     x10, #2
        adr     x9, a22
        str     x10, [x9]
        mov     x10, #3
        adr     x9, a23
        str     x10, [x9]
        mov     x10, #4
        adr     x9, a24
        str     x10, [x9]
        mov     x10, #5
        adr     x9, a25
        str     x10, [x9]
        mov     x10, #6
        adr     x9, a26
        str     x10, [x9]
        mov     x10, #7
        adr     x9, a27
        str     x10, [x9]
        mov     x10, #8
        adr     x9, a28
        str     x10, [x9]
        mov     x10, #9
        adr     x9, a29
        str     x10, [x9]
        mov     x10, #0
        adr     x9, a30
        str     x10, [x9]
        mov     x10, #1
        adr     x9, a31
        str     x10, [x9]
        mov     x10, #4
        adr     x9, a32
        str     x10, [x9]
        mov     x10, #5
        adr     x9, a33
        str     x10, [x9]
        mov     x10, #6
        adr     x9, a34
        str     x10, [x9]
        mov     x10, #7
        adr     x9, a35
        str     x10, [x9]
        mov     x10, #8
        adr     x9, a36
        str     x10, [x9]
        mov     x10, #9
        adr     x9, a37
        str     x10, [x9]
        mov     x10, #0
        adr     x9, a38
        str     x10, [x9]
        mov     x10, #1
        adr     x9, a39
        str     x10, [x9]
        adr     x9, a0
        ldr     x20, [x9]
        adr     x9, a1
        ldr     x15, [x9]
        adr     x9, a2
        ldr     x14, [x9]
        adr     x9, a3
        ldr     x13, [x9]
        adr     x9, a4
        ldr     x12, [x9]
        adr     x9, a5
        ldr     x11, [x9]
        adr     x9, a6
        ldr     x10, [x9]
        adr     x9, a7
        ldr     x9, [x9]
        mov     x0, x20
        mov     x1, x15
        mov     x2, x14
        mov     x3, x13
        mov     x4, x12
        mov     x5, x11
        mov     x6, x10
        mov     x7, x9
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
        bl     testParam8
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adr     x9, a0
        str     x0, [x9]
        adr     x9, a0
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
        adr     x9, a32
        ldr     x27, [x9]
        adr     x9, a33
        ldr     x26, [x9]
        adr     x9, a34
        ldr     x25, [x9]
        adr     x9, a35
        ldr     x24, [x9]
        adr     x9, a36
        ldr     x23, [x9]
        adr     x9, a37
        ldr     x22, [x9]
        adr     x9, a38
        ldr     x21, [x9]
        adr     x9, a39
        ldr     x20, [x9]
        adr     x9, a8
        ldr     x15, [x9]
        adr     x9, a9
        ldr     x14, [x9]
        adr     x9, a10
        ldr     x13, [x9]
        adr     x9, a11
        ldr     x12, [x9]
        adr     x9, a12
        ldr     x11, [x9]
        adr     x9, a13
        ldr     x10, [x9]
        adr     x9, a14
        ldr     x9, [x9]
        adr     x28, a15
        ldr     x28, [x28]
        mov     x0, x27
        mov     x1, x26
        mov     x2, x25
        mov     x3, x24
        mov     x4, x23
        mov     x5, x22
        mov     x6, x21
        mov     x7, x20
        mov     x9, x15
        mov     x9, x14
        mov     x9, x13
        mov     x9, x12
        mov     x9, x11
        mov     x9, x10
        mov     x9, x9
        mov     x9, x28
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
        bl     testParam16
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adr     x9, a0
        str     x0, [x9]
        adr     x9, a0
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
        adr     x9, a0
        ldr     x16, [x9]
        mov     x17, #0
        str     x16, [sp,x17]
        adr     x9, a1
        ldr     x16, [x9]
        mov     x17, #8
        str     x16, [sp,x17]
        adr     x9, a2
        ldr     x16, [x9]
        mov     x17, #16
        str     x16, [sp,x17]
        adr     x9, a3
        ldr     x16, [x9]
        mov     x17, #24
        str     x16, [sp,x17]
        adr     x9, a4
        ldr     x16, [x9]
        mov     x17, #32
        str     x16, [sp,x17]
        adr     x9, a5
        ldr     x16, [x9]
        mov     x17, #40
        str     x16, [sp,x17]
        adr     x9, a6
        ldr     x16, [x9]
        mov     x17, #48
        str     x16, [sp,x17]
        adr     x9, a7
        ldr     x16, [x9]
        mov     x17, #56
        str     x16, [sp,x17]
        adr     x9, a8
        ldr     x16, [x9]
        mov     x17, #64
        str     x16, [sp,x17]
        adr     x9, a9
        ldr     x16, [x9]
        mov     x17, #72
        str     x16, [sp,x17]
        adr     x9, a10
        ldr     x16, [x9]
        mov     x17, #80
        str     x16, [sp,x17]
        adr     x9, a11
        ldr     x16, [x9]
        mov     x17, #88
        str     x16, [sp,x17]
        adr     x9, a12
        ldr     x16, [x9]
        mov     x17, #96
        str     x16, [sp,x17]
        adr     x9, a13
        ldr     x16, [x9]
        mov     x17, #104
        str     x16, [sp,x17]
        adr     x9, a14
        ldr     x16, [x9]
        mov     x17, #112
        str     x16, [sp,x17]
        adr     x9, a15
        ldr     x16, [x9]
        mov     x17, #120
        str     x16, [sp,x17]
        adr     x9, a16
        ldr     x28, [x9]
        adr     x9, a17
        ldr     x27, [x9]
        adr     x9, a18
        ldr     x26, [x9]
        adr     x9, a19
        ldr     x25, [x9]
        adr     x9, a20
        ldr     x24, [x9]
        adr     x9, a21
        ldr     x23, [x9]
        adr     x9, a22
        ldr     x22, [x9]
        adr     x9, a23
        ldr     x21, [x9]
        adr     x9, a24
        ldr     x20, [x9]
        adr     x9, a25
        ldr     x15, [x9]
        adr     x9, a26
        ldr     x14, [x9]
        adr     x9, a27
        ldr     x13, [x9]
        adr     x9, a28
        ldr     x12, [x9]
        adr     x9, a29
        ldr     x11, [x9]
        adr     x9, a30
        ldr     x10, [x9]
        adr     x9, a31
        ldr     x9, [x9]
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     x1, x19
        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     x2, x19
        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x3, x19
        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     x4, x19
        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     x5, x19
        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     x6, x19
        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     x7, x19
        mov     x16, #64
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x16, #80
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x16, #88
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x16, #96
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x16, #104
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x16, #112
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x16, #120
        ldr     x19, [sp,x16]
        mov     x9, x19
        mov     x9, x28
        mov     x9, x27
        mov     x9, x26
        mov     x9, x25
        mov     x9, x24
        mov     x9, x23
        mov     x9, x22
        mov     x9, x21
        mov     x9, x20
        mov     x9, x15
        mov     x9, x14
        mov     x9, x13
        mov     x9, x12
        mov     x9, x11
        mov     x9, x10
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
        bl     testParam32
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        adr     x9, a0
        str     x0, [x9]
        adr     x9, a0
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
        mov     x9, #117
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
        bl     _sysy_stoptime
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
