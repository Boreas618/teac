.section .data
.global    a1
.global    a2
.global    a3
.global    a4
.global    a5
.global    a6
.global    a7
.global    a8
.global    a9
.global    a10
.global    a11
.global    a12
.global    a13
.global    a14
.global    a15
.global    a16
.global    a17
.global    a18
.global    a19
.global    a20
.global    a21
.global    a22
.global    a23
.global    a24
.global    a25
.global    a26
.global    a27
.global    a28
.global    a29
.global    a30
.global    a31
.global    a32
a1:
        .quad   1
a2:
        .quad   2
a3:
        .quad   3
a4:
        .quad   4
a5:
        .quad   5
a6:
        .quad   6
a7:
        .quad   7
a8:
        .quad   8
a9:
        .quad   9
a10:
        .quad   10
a11:
        .quad   11
a12:
        .quad   12
a13:
        .quad   13
a14:
        .quad   14
a15:
        .quad   15
a16:
        .quad   16
a17:
        .quad   1
a18:
        .quad   2
a19:
        .quad   3
a20:
        .quad   4
a21:
        .quad   5
a22:
        .quad   6
a23:
        .quad   7
a24:
        .quad   8
a25:
        .quad   9
a26:
        .quad   10
a27:
        .quad   11
a28:
        .quad   12
a29:
        .quad   13
a30:
        .quad   14
a31:
        .quad   15
a32:
        .quad   16
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

        mov     x16, #504
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, w1
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w11, #0
        mov     w16, w10
        mov     x17, #72
        str     x16, [sp,x17]
        mov     w10, #0
        mov     w16, w9
        mov     x17, #80
        str     x16, [sp,x17]
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w16, w0
        mov     x17, #88
        str     x16, [sp,x17]
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w16, w0
        mov     x17, #96
        str     x16, [sp,x17]
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w16, w0
        mov     x17, #104
        str     x16, [sp,x17]
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w16, w0
        mov     x17, #112
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #88
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #120
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #96
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #128
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #104
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #136
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #112
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #144
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #120
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a5
        add     x9, x9, #:lo12:a5
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #152
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #128
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a6
        add     x9, x9, #:lo12:a6
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #160
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #136
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a7
        add     x9, x9, #:lo12:a7
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #168
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #144
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #176
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #152
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #184
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #160
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #192
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #168
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #200
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #176
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #208
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #184
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #216
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #192
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #224
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #200
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #232
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #208
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a16
        add     x9, x9, #:lo12:a16
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #240
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #216
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a17
        add     x9, x9, #:lo12:a17
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #248
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #224
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a18
        add     x9, x9, #:lo12:a18
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #256
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #232
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a19
        add     x9, x9, #:lo12:a19
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #264
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #240
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a20
        add     x9, x9, #:lo12:a20
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #272
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #248
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a21
        add     x9, x9, #:lo12:a21
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #280
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #256
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a22
        add     x9, x9, #:lo12:a22
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #288
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #264
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a23
        add     x9, x9, #:lo12:a23
        ldr     w9, [x9]
        add     w15, w10, w9
        mov     w9, #4
        mov     x16, #272
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a24
        add     x9, x9, #:lo12:a24
        ldr     w9, [x9]
        add     w14, w10, w9
        mov     w9, #1
        mov     x16, #280
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a25
        add     x9, x9, #:lo12:a25
        ldr     w9, [x9]
        add     w13, w10, w9
        mov     w9, #2
        mov     x16, #288
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a26
        add     x9, x9, #:lo12:a26
        ldr     w9, [x9]
        add     w12, w10, w9
        mov     w9, #3
        add     w10, w9, w15
        adrp     x9, a27
        add     x9, x9, #:lo12:a27
        ldr     w9, [x9]
        add     w11, w10, w9
        mov     w9, #4
        add     w10, w9, w14
        adrp     x9, a28
        add     x9, x9, #:lo12:a28
        ldr     w9, [x9]
        add     w10, w10, w9
        mov     w9, #1
        add     w16, w9, w13
        mov     x17, #0
        str     x16, [sp,x17]
        adrp     x9, a29
        add     x9, x9, #:lo12:a29
        ldr     w9, [x9]
        mov     w9, #2
        add     w16, w9, w12
        mov     x17, #8
        str     x16, [sp,x17]
        adrp     x9, a30
        add     x9, x9, #:lo12:a30
        ldr     w9, [x9]
        mov     w9, #3
        add     w16, w9, w11
        mov     x17, #16
        str     x16, [sp,x17]
        adrp     x9, a31
        add     x9, x9, #:lo12:a31
        ldr     w9, [x9]
        mov     w9, #4
        add     w16, w9, w10
        mov     x17, #24
        str     x16, [sp,x17]
        adrp     x9, a32
        add     x9, x9, #:lo12:a32
        ldr     w9, [x9]
        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     x16, #80
        ldr     x18, [sp,x16]
        sub     w9, w19, w18
        add     w16, w9, #10
        mov     x17, #296
        str     x16, [sp,x17]
        mov     w9, #1
        add     w13, w9, w13
        adrp     x9, a29
        add     x9, x9, #:lo12:a29
        ldr     w9, [x9]
        add     w16, w13, w9
        mov     x17, #304
        str     x16, [sp,x17]
        mov     w9, #2
        add     w12, w9, w12
        adrp     x9, a30
        add     x9, x9, #:lo12:a30
        ldr     w9, [x9]
        add     w16, w12, w9
        mov     x17, #312
        str     x16, [sp,x17]
        mov     w9, #3
        add     w11, w9, w11
        adrp     x9, a31
        add     x9, x9, #:lo12:a31
        ldr     w9, [x9]
        add     w16, w11, w9
        mov     x17, #320
        str     x16, [sp,x17]
        mov     w9, #4
        add     w10, w9, w10
        adrp     x9, a32
        add     x9, x9, #:lo12:a32
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #328
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #280
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a25
        add     x9, x9, #:lo12:a25
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #336
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #288
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a26
        add     x9, x9, #:lo12:a26
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #344
        str     x16, [sp,x17]
        mov     w9, #3
        add     w10, w9, w15
        adrp     x9, a27
        add     x9, x9, #:lo12:a27
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #352
        str     x16, [sp,x17]
        mov     w9, #4
        add     w10, w9, w14
        adrp     x9, a28
        add     x9, x9, #:lo12:a28
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #360
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #248
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a21
        add     x9, x9, #:lo12:a21
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #368
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #256
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a22
        add     x9, x9, #:lo12:a22
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #376
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #264
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a23
        add     x9, x9, #:lo12:a23
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #384
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #272
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a24
        add     x9, x9, #:lo12:a24
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #392
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #216
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a17
        add     x9, x9, #:lo12:a17
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #400
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #224
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a18
        add     x9, x9, #:lo12:a18
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #408
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #232
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a19
        add     x9, x9, #:lo12:a19
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #416
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #240
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a20
        add     x9, x9, #:lo12:a20
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #424
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #184
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #432
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #192
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #440
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #200
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #448
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #208
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a16
        add     x9, x9, #:lo12:a16
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #456
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #152
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #464
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #160
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #472
        str     x16, [sp,x17]
        mov     w9, #3
        mov     x16, #168
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #480
        str     x16, [sp,x17]
        mov     w9, #4
        mov     x16, #176
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #488
        str     x16, [sp,x17]
        mov     w9, #1
        mov     x16, #120
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a5
        add     x9, x9, #:lo12:a5
        ldr     w9, [x9]
        add     w16, w10, w9
        mov     x17, #496
        str     x16, [sp,x17]
        mov     w9, #2
        mov     x16, #128
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a6
        add     x9, x9, #:lo12:a6
        ldr     w9, [x9]
        add     w15, w10, w9
        mov     w9, #3
        mov     x16, #136
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a7
        add     x9, x9, #:lo12:a7
        ldr     w9, [x9]
        add     w14, w10, w9
        mov     w9, #4
        mov     x16, #144
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        ldr     w9, [x9]
        add     w13, w10, w9
        mov     w9, #1
        mov     x16, #88
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        ldr     w9, [x9]
        mov     w9, #2
        mov     x16, #96
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        ldr     w9, [x9]
        mov     w9, #3
        mov     x16, #104
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        ldr     w9, [x9]
        mov     w9, #4
        mov     x16, #112
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        ldr     w9, [x9]
        mov     w9, #1
        mov     x16, #88
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        ldr     w9, [x9]
        add     w12, w10, w9
        mov     w9, #2
        mov     x16, #96
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        ldr     w9, [x9]
        add     w11, w10, w9
        mov     w9, #3
        mov     x16, #104
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        ldr     w9, [x9]
        add     w10, w10, w9
        mov     w9, #4
        mov     x16, #112
        ldr     x19, [sp,x16]
        add     w16, w9, w19
        mov     x17, #32
        str     x16, [sp,x17]
        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        ldr     w9, [x9]
        mov     x16, #32
        ldr     x19, [sp,x16]
        add     w9, w19, w9
        mov     x16, #296
        ldr     x19, [sp,x16]
        mov     x16, #88
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #40
        str     x16, [sp,x17]
        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     x16, #96
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #48
        str     x16, [sp,x17]
        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     x16, #104
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #56
        str     x16, [sp,x17]
        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     x16, #112
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #64
        str     x16, [sp,x17]
        mov     x16, #64
        ldr     x19, [sp,x16]
        sub     w12, w19, w12
        sub     w11, w12, w11
        sub     w10, w11, w10
        sub     w9, w10, w9
        mov     x16, #496
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        add     w9, w9, w15
        add     w9, w9, w14
        add     w9, w9, w13
        mov     x16, #464
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #472
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #480
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #488
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #432
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #440
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #448
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #456
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #400
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #408
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #416
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #424
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #368
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #376
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #384
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #392
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #336
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #344
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #352
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #360
        ldr     x19, [sp,x16]
        sub     w9, w9, w19
        mov     x16, #304
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #312
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #320
        ldr     x19, [sp,x16]
        add     w9, w9, w19
        mov     x16, #328
        ldr     x19, [sp,x16]
        add     w10, w9, w19
        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a5
        add     x9, x9, #:lo12:a5
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a6
        add     x9, x9, #:lo12:a6
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a7
        add     x9, x9, #:lo12:a7
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a16
        add     x9, x9, #:lo12:a16
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a17
        add     x9, x9, #:lo12:a17
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a18
        add     x9, x9, #:lo12:a18
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a19
        add     x9, x9, #:lo12:a19
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a20
        add     x9, x9, #:lo12:a20
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a21
        add     x9, x9, #:lo12:a21
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a22
        add     x9, x9, #:lo12:a22
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a23
        add     x9, x9, #:lo12:a23
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a24
        add     x9, x9, #:lo12:a24
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a25
        add     x9, x9, #:lo12:a25
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a26
        add     x9, x9, #:lo12:a26
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a27
        add     x9, x9, #:lo12:a27
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a28
        add     x9, x9, #:lo12:a28
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a29
        add     x9, x9, #:lo12:a29
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a30
        add     x9, x9, #:lo12:a30
        ldr     w9, [x9]
        sub     w10, w10, w9
        adrp     x9, a31
        add     x9, x9, #:lo12:a31
        ldr     w9, [x9]
        add     w10, w10, w9
        adrp     x9, a32
        add     x9, x9, #:lo12:a32
        ldr     w9, [x9]
        sub     w9, w10, w9
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb2:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #87
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
        mov     w9, #0
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0
        mov     w10, #2
        mov     w9, #9
        mul     w9, w10, w9
        add     w9, w11, w9
        mov     w0, w11
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        mov     w0, w10
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
        mov     w9, #93
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
        mov     w0, w10
        mov     sp, x29
        ret
