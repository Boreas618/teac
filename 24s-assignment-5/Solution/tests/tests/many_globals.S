.section .data
.global    a0
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
.global    a33
.global    a34
.global    a35
.global    a36
.global    a37
.global    a38
.global    a39
a0:
        .quad   0
a1:
        .quad   0
a2:
        .quad   0
a3:
        .quad   0
a4:
        .quad   0
a5:
        .quad   0
a6:
        .quad   0
a7:
        .quad   0
a8:
        .quad   0
a9:
        .quad   0
a10:
        .quad   0
a11:
        .quad   0
a12:
        .quad   0
a13:
        .quad   0
a14:
        .quad   0
a15:
        .quad   0
a16:
        .quad   0
a17:
        .quad   0
a18:
        .quad   0
a19:
        .quad   0
a20:
        .quad   0
a21:
        .quad   0
a22:
        .quad   0
a23:
        .quad   0
a24:
        .quad   0
a25:
        .quad   0
a26:
        .quad   0
a27:
        .quad   0
a28:
        .quad   0
a29:
        .quad   0
a30:
        .quad   0
a31:
        .quad   0
a32:
        .quad   0
a33:
        .quad   0
a34:
        .quad   0
a35:
        .quad   0
a36:
        .quad   0
a37:
        .quad   0
a38:
        .quad   0
a39:
        .quad   0
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

        mov     x16, #24
        sub     sp, sp, x16
        mov     w16, w0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w15, w1
        mov     w14, w2
        mov     w13, w3
        mov     w12, w4
        mov     w11, w5
        mov     w10, w6
        mov     w16, w7
        mov     x17, #8
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #16
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w15, w15
        mov     w9, #0
        mov     w14, w14
        mov     w9, #0
        mov     w13, w13
        mov     w9, #0
        mov     w12, w12
        mov     w9, #0
        mov     w11, w11
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     w9, w19
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     w15, w19, w15
        add     w14, w15, w14
        add     w13, w14, w13
        add     w12, w13, w12
        add     w11, w12, w11
        add     w10, w11, w10
        add     w9, w10, w9
        mov     w0, w9
        mov     sp, x29
        ret
testParam16:

bb6:

        mov     x16, #216
        sub     sp, sp, x16
        mov     w16, w0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w16, w1
        mov     x17, #8
        str     x16, [sp,x17]
        mov     w16, w2
        mov     x17, #16
        str     x16, [sp,x17]
        mov     w16, w3
        mov     x17, #24
        str     x16, [sp,x17]
        mov     w16, w4
        mov     x17, #32
        str     x16, [sp,x17]
        mov     w16, w5
        mov     x17, #40
        str     x16, [sp,x17]
        mov     w16, w6
        mov     x17, #48
        str     x16, [sp,x17]
        mov     w16, w7
        mov     x17, #56
        str     x16, [sp,x17]
        ldr     w9, [x29]
        mov     w16, w9
        mov     x17, #64
        str     x16, [sp,x17]
        ldr     w9, [x29,#8]
        mov     w15, w9
        ldr     w9, [x29,#16]
        mov     w14, w9
        ldr     w9, [x29,#24]
        mov     w13, w9
        ldr     w9, [x29,#32]
        mov     w12, w9
        ldr     w9, [x29,#40]
        mov     w11, w9
        ldr     w9, [x29,#48]
        mov     w10, w9
        ldr     w9, [x29,#56]
        mov     w16, w9
        mov     x17, #72
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #144
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #152
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #160
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #168
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #176
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #184
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #192
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #200
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #64
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #208
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w15, w15
        mov     w9, #0
        mov     w14, w14
        mov     w9, #0
        mov     w13, w13
        mov     w9, #0
        mov     w12, w12
        mov     w9, #0
        mov     w11, w11
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     w9, w19
        mov     x16, #144
        ldr     x19, [sp,x16]
        mov     x16, #152
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #80
        str     x16, [sp,x17]
        mov     x16, #80
        ldr     x19, [sp,x16]
        mov     x16, #160
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #88
        str     x16, [sp,x17]
        mov     x16, #88
        ldr     x19, [sp,x16]
        mov     x16, #168
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #96
        str     x16, [sp,x17]
        mov     x16, #96
        ldr     x19, [sp,x16]
        mov     x16, #176
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #104
        str     x16, [sp,x17]
        mov     x16, #104
        ldr     x19, [sp,x16]
        mov     x16, #184
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #112
        str     x16, [sp,x17]
        mov     x16, #112
        ldr     x19, [sp,x16]
        mov     x16, #192
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #120
        str     x16, [sp,x17]
        mov     x16, #120
        ldr     x19, [sp,x16]
        mov     x16, #200
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #128
        str     x16, [sp,x17]
        mov     x16, #128
        ldr     x19, [sp,x16]
        mov     x16, #208
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #136
        str     x16, [sp,x17]
        mov     x16, #136
        ldr     x19, [sp,x16]
        add     w15, w19, w15
        add     w14, w15, w14
        add     w13, w14, w13
        add     w12, w13, w12
        add     w11, w12, w11
        add     w10, w11, w10
        add     w9, w10, w9
        mov     w0, w9
        mov     sp, x29
        ret
testParam32:

bb7:

        mov     x16, #600
        sub     sp, sp, x16
        mov     w16, w0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w16, w1
        mov     x17, #8
        str     x16, [sp,x17]
        mov     w16, w2
        mov     x17, #16
        str     x16, [sp,x17]
        mov     w16, w3
        mov     x17, #24
        str     x16, [sp,x17]
        mov     w16, w4
        mov     x17, #32
        str     x16, [sp,x17]
        mov     w16, w5
        mov     x17, #40
        str     x16, [sp,x17]
        mov     w16, w6
        mov     x17, #48
        str     x16, [sp,x17]
        mov     w16, w7
        mov     x17, #56
        str     x16, [sp,x17]
        ldr     w9, [x29]
        mov     w16, w9
        mov     x17, #64
        str     x16, [sp,x17]
        ldr     w9, [x29,#8]
        mov     w16, w9
        mov     x17, #72
        str     x16, [sp,x17]
        ldr     w9, [x29,#16]
        mov     w16, w9
        mov     x17, #80
        str     x16, [sp,x17]
        ldr     w9, [x29,#24]
        mov     w16, w9
        mov     x17, #88
        str     x16, [sp,x17]
        ldr     w9, [x29,#32]
        mov     w16, w9
        mov     x17, #96
        str     x16, [sp,x17]
        ldr     w9, [x29,#40]
        mov     w16, w9
        mov     x17, #104
        str     x16, [sp,x17]
        ldr     w9, [x29,#48]
        mov     w16, w9
        mov     x17, #112
        str     x16, [sp,x17]
        ldr     w9, [x29,#56]
        mov     w16, w9
        mov     x17, #120
        str     x16, [sp,x17]
        ldr     w9, [x29,#64]
        mov     w16, w9
        mov     x17, #128
        str     x16, [sp,x17]
        ldr     w9, [x29,#72]
        mov     w16, w9
        mov     x17, #136
        str     x16, [sp,x17]
        ldr     w9, [x29,#80]
        mov     w16, w9
        mov     x17, #144
        str     x16, [sp,x17]
        ldr     w9, [x29,#88]
        mov     w16, w9
        mov     x17, #152
        str     x16, [sp,x17]
        ldr     w9, [x29,#96]
        mov     w16, w9
        mov     x17, #160
        str     x16, [sp,x17]
        ldr     w9, [x29,#104]
        mov     w16, w9
        mov     x17, #168
        str     x16, [sp,x17]
        ldr     w9, [x29,#112]
        mov     w16, w9
        mov     x17, #176
        str     x16, [sp,x17]
        ldr     w9, [x29,#120]
        mov     w16, w9
        mov     x17, #184
        str     x16, [sp,x17]
        ldr     w9, [x29,#128]
        mov     w16, w9
        mov     x17, #192
        str     x16, [sp,x17]
        ldr     w9, [x29,#136]
        mov     w15, w9
        ldr     w9, [x29,#144]
        mov     w14, w9
        ldr     w9, [x29,#152]
        mov     w13, w9
        ldr     w9, [x29,#160]
        mov     w12, w9
        ldr     w9, [x29,#168]
        mov     w11, w9
        ldr     w9, [x29,#176]
        mov     w10, w9
        ldr     w9, [x29,#184]
        mov     w16, w9
        mov     x17, #200
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #400
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #408
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #416
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #424
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #432
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #440
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #448
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #456
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #64
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #464
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #472
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #80
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #480
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #88
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #488
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #96
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #496
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #104
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #504
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #112
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #512
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #120
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #520
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #128
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #528
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #136
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #536
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #144
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #544
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #152
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #552
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #160
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #560
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #168
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #568
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #176
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #576
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #184
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #584
        str     x16, [sp,x17]
        mov     w9, #0
        mov     x16, #192
        ldr     x19, [sp,x16]
        mov     w16, w19
        mov     x17, #592
        str     x16, [sp,x17]
        mov     w9, #0
        mov     w15, w15
        mov     w9, #0
        mov     w14, w14
        mov     w9, #0
        mov     w13, w13
        mov     w9, #0
        mov     w12, w12
        mov     w9, #0
        mov     w11, w11
        mov     w9, #0
        mov     w10, w10
        mov     w9, #0
        mov     x16, #200
        ldr     x19, [sp,x16]
        mov     w9, w19
        mov     x16, #400
        ldr     x19, [sp,x16]
        mov     x16, #408
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #208
        str     x16, [sp,x17]
        mov     x16, #208
        ldr     x19, [sp,x16]
        mov     x16, #416
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #216
        str     x16, [sp,x17]
        mov     x16, #216
        ldr     x19, [sp,x16]
        mov     x16, #424
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #224
        str     x16, [sp,x17]
        mov     x16, #224
        ldr     x19, [sp,x16]
        mov     x16, #432
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #232
        str     x16, [sp,x17]
        mov     x16, #232
        ldr     x19, [sp,x16]
        mov     x16, #440
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #240
        str     x16, [sp,x17]
        mov     x16, #240
        ldr     x19, [sp,x16]
        mov     x16, #448
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #248
        str     x16, [sp,x17]
        mov     x16, #248
        ldr     x19, [sp,x16]
        mov     x16, #456
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #256
        str     x16, [sp,x17]
        mov     x16, #256
        ldr     x19, [sp,x16]
        mov     x16, #464
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #264
        str     x16, [sp,x17]
        mov     x16, #264
        ldr     x19, [sp,x16]
        mov     x16, #472
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #272
        str     x16, [sp,x17]
        mov     x16, #272
        ldr     x19, [sp,x16]
        mov     x16, #480
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #280
        str     x16, [sp,x17]
        mov     x16, #280
        ldr     x19, [sp,x16]
        mov     x16, #488
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #288
        str     x16, [sp,x17]
        mov     x16, #288
        ldr     x19, [sp,x16]
        mov     x16, #496
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #296
        str     x16, [sp,x17]
        mov     x16, #296
        ldr     x19, [sp,x16]
        mov     x16, #504
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #304
        str     x16, [sp,x17]
        mov     x16, #304
        ldr     x19, [sp,x16]
        mov     x16, #512
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #312
        str     x16, [sp,x17]
        mov     x16, #312
        ldr     x19, [sp,x16]
        mov     x16, #520
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #320
        str     x16, [sp,x17]
        mov     x16, #320
        ldr     x19, [sp,x16]
        mov     x16, #528
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #328
        str     x16, [sp,x17]
        mov     x16, #328
        ldr     x19, [sp,x16]
        mov     x16, #536
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #336
        str     x16, [sp,x17]
        mov     x16, #336
        ldr     x19, [sp,x16]
        mov     x16, #544
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #344
        str     x16, [sp,x17]
        mov     x16, #344
        ldr     x19, [sp,x16]
        mov     x16, #552
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #352
        str     x16, [sp,x17]
        mov     x16, #352
        ldr     x19, [sp,x16]
        mov     x16, #560
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #360
        str     x16, [sp,x17]
        mov     x16, #360
        ldr     x19, [sp,x16]
        mov     x16, #568
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #368
        str     x16, [sp,x17]
        mov     x16, #368
        ldr     x19, [sp,x16]
        mov     x16, #576
        ldr     x18, [sp,x16]
        sub     w16, w19, w18
        mov     x17, #376
        str     x16, [sp,x17]
        mov     x16, #376
        ldr     x19, [sp,x16]
        mov     x16, #584
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #384
        str     x16, [sp,x17]
        mov     x16, #384
        ldr     x19, [sp,x16]
        mov     x16, #592
        ldr     x18, [sp,x16]
        add     w16, w19, w18
        mov     x17, #392
        str     x16, [sp,x17]
        mov     x16, #392
        ldr     x19, [sp,x16]
        add     w15, w19, w15
        add     w14, w15, w14
        add     w13, w14, w13
        add     w12, w13, w12
        add     w11, w12, w11
        add     w10, w11, w10
        add     w9, w10, w9
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb4:

        mov     x16, #280
        sub     sp, sp, x16
        mov     w9, #97
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
        mov     w10, #0
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        str     w10, [x9]
        mov     w10, #1
        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        str     w10, [x9]
        mov     w10, #2
        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        str     w10, [x9]
        mov     w10, #3
        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        str     w10, [x9]
        mov     w10, #4
        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        str     w10, [x9]
        mov     w10, #5
        adrp     x9, a5
        add     x9, x9, #:lo12:a5
        str     w10, [x9]
        mov     w10, #6
        adrp     x9, a6
        add     x9, x9, #:lo12:a6
        str     w10, [x9]
        mov     w10, #7
        adrp     x9, a7
        add     x9, x9, #:lo12:a7
        str     w10, [x9]
        mov     w10, #8
        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        str     w10, [x9]
        mov     w10, #9
        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        str     w10, [x9]
        mov     w10, #0
        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        str     w10, [x9]
        mov     w10, #1
        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        str     w10, [x9]
        mov     w10, #2
        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        str     w10, [x9]
        mov     w10, #3
        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        str     w10, [x9]
        mov     w10, #4
        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        str     w10, [x9]
        mov     w10, #5
        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        str     w10, [x9]
        mov     w10, #6
        adrp     x9, a16
        add     x9, x9, #:lo12:a16
        str     w10, [x9]
        mov     w10, #7
        adrp     x9, a17
        add     x9, x9, #:lo12:a17
        str     w10, [x9]
        mov     w10, #8
        adrp     x9, a18
        add     x9, x9, #:lo12:a18
        str     w10, [x9]
        mov     w10, #9
        adrp     x9, a19
        add     x9, x9, #:lo12:a19
        str     w10, [x9]
        mov     w10, #0
        adrp     x9, a20
        add     x9, x9, #:lo12:a20
        str     w10, [x9]
        mov     w10, #1
        adrp     x9, a21
        add     x9, x9, #:lo12:a21
        str     w10, [x9]
        mov     w10, #2
        adrp     x9, a22
        add     x9, x9, #:lo12:a22
        str     w10, [x9]
        mov     w10, #3
        adrp     x9, a23
        add     x9, x9, #:lo12:a23
        str     w10, [x9]
        mov     w10, #4
        adrp     x9, a24
        add     x9, x9, #:lo12:a24
        str     w10, [x9]
        mov     w10, #5
        adrp     x9, a25
        add     x9, x9, #:lo12:a25
        str     w10, [x9]
        mov     w10, #6
        adrp     x9, a26
        add     x9, x9, #:lo12:a26
        str     w10, [x9]
        mov     w10, #7
        adrp     x9, a27
        add     x9, x9, #:lo12:a27
        str     w10, [x9]
        mov     w10, #8
        adrp     x9, a28
        add     x9, x9, #:lo12:a28
        str     w10, [x9]
        mov     w10, #9
        adrp     x9, a29
        add     x9, x9, #:lo12:a29
        str     w10, [x9]
        mov     w10, #0
        adrp     x9, a30
        add     x9, x9, #:lo12:a30
        str     w10, [x9]
        mov     w10, #1
        adrp     x9, a31
        add     x9, x9, #:lo12:a31
        str     w10, [x9]
        mov     w10, #4
        adrp     x9, a32
        add     x9, x9, #:lo12:a32
        str     w10, [x9]
        mov     w10, #5
        adrp     x9, a33
        add     x9, x9, #:lo12:a33
        str     w10, [x9]
        mov     w10, #6
        adrp     x9, a34
        add     x9, x9, #:lo12:a34
        str     w10, [x9]
        mov     w10, #7
        adrp     x9, a35
        add     x9, x9, #:lo12:a35
        str     w10, [x9]
        mov     w10, #8
        adrp     x9, a36
        add     x9, x9, #:lo12:a36
        str     w10, [x9]
        mov     w10, #9
        adrp     x9, a37
        add     x9, x9, #:lo12:a37
        str     w10, [x9]
        mov     w10, #0
        adrp     x9, a38
        add     x9, x9, #:lo12:a38
        str     w10, [x9]
        mov     w10, #1
        adrp     x9, a39
        add     x9, x9, #:lo12:a39
        str     w10, [x9]
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        ldr     w16, [x9]
        mov     x17, #0
        str     x16, [sp,x17]
        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        ldr     w15, [x9]
        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        ldr     w14, [x9]
        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        ldr     w13, [x9]
        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        ldr     w12, [x9]
        adrp     x9, a5
        add     x9, x9, #:lo12:a5
        ldr     w11, [x9]
        adrp     x9, a6
        add     x9, x9, #:lo12:a6
        ldr     w10, [x9]
        adrp     x9, a7
        add     x9, x9, #:lo12:a7
        ldr     w9, [x9]
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     w0, w19
        mov     w1, w15
        mov     w2, w14
        mov     w3, w13
        mov     w4, w12
        mov     w5, w11
        mov     w6, w10
        mov     w7, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     testParam8
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        str     w10, [x9]
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
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
        adrp     x9, a32
        add     x9, x9, #:lo12:a32
        ldr     w16, [x9]
        mov     x17, #8
        str     x16, [sp,x17]
        adrp     x9, a33
        add     x9, x9, #:lo12:a33
        ldr     w16, [x9]
        mov     x17, #16
        str     x16, [sp,x17]
        adrp     x9, a34
        add     x9, x9, #:lo12:a34
        ldr     w16, [x9]
        mov     x17, #24
        str     x16, [sp,x17]
        adrp     x9, a35
        add     x9, x9, #:lo12:a35
        ldr     w16, [x9]
        mov     x17, #32
        str     x16, [sp,x17]
        adrp     x9, a36
        add     x9, x9, #:lo12:a36
        ldr     w16, [x9]
        mov     x17, #40
        str     x16, [sp,x17]
        adrp     x9, a37
        add     x9, x9, #:lo12:a37
        ldr     w16, [x9]
        mov     x17, #48
        str     x16, [sp,x17]
        adrp     x9, a38
        add     x9, x9, #:lo12:a38
        ldr     w16, [x9]
        mov     x17, #56
        str     x16, [sp,x17]
        adrp     x9, a39
        add     x9, x9, #:lo12:a39
        ldr     w16, [x9]
        mov     x17, #64
        str     x16, [sp,x17]
        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        ldr     w16, [x9]
        mov     x17, #72
        str     x16, [sp,x17]
        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        ldr     w15, [x9]
        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        ldr     w14, [x9]
        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        ldr     w13, [x9]
        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        ldr     w12, [x9]
        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        ldr     w11, [x9]
        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        ldr     w10, [x9]
        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        ldr     w9, [x9]
        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     w0, w19
        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     w1, w19
        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     w2, w19
        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     w3, w19
        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     w4, w19
        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     w5, w19
        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     w6, w19
        mov     x16, #64
        ldr     x19, [sp,x16]
        mov     w7, w19
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        str     w9, [sp,#-80]
        str     w10, [sp,#-88]
        str     w11, [sp,#-96]
        str     w12, [sp,#-104]
        str     w13, [sp,#-112]
        str     w14, [sp,#-120]
        str     w15, [sp,#-128]
        mov     x16, #72
        ldr     x19, [sp,x16]
        str     w19, [sp,#-136]
        sub     sp, sp, #136
        mov     x29, sp
        bl     testParam16
        add     sp, sp, #64
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        str     w10, [x9]
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
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
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        ldr     w16, [x9]
        mov     x17, #80
        str     x16, [sp,x17]
        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        ldr     w16, [x9]
        mov     x17, #88
        str     x16, [sp,x17]
        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        ldr     w16, [x9]
        mov     x17, #96
        str     x16, [sp,x17]
        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        ldr     w16, [x9]
        mov     x17, #104
        str     x16, [sp,x17]
        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        ldr     w16, [x9]
        mov     x17, #112
        str     x16, [sp,x17]
        adrp     x9, a5
        add     x9, x9, #:lo12:a5
        ldr     w16, [x9]
        mov     x17, #120
        str     x16, [sp,x17]
        adrp     x9, a6
        add     x9, x9, #:lo12:a6
        ldr     w16, [x9]
        mov     x17, #128
        str     x16, [sp,x17]
        adrp     x9, a7
        add     x9, x9, #:lo12:a7
        ldr     w16, [x9]
        mov     x17, #136
        str     x16, [sp,x17]
        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        ldr     w16, [x9]
        mov     x17, #144
        str     x16, [sp,x17]
        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        ldr     w16, [x9]
        mov     x17, #152
        str     x16, [sp,x17]
        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        ldr     w16, [x9]
        mov     x17, #160
        str     x16, [sp,x17]
        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        ldr     w16, [x9]
        mov     x17, #168
        str     x16, [sp,x17]
        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        ldr     w16, [x9]
        mov     x17, #176
        str     x16, [sp,x17]
        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        ldr     w16, [x9]
        mov     x17, #184
        str     x16, [sp,x17]
        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        ldr     w16, [x9]
        mov     x17, #192
        str     x16, [sp,x17]
        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        ldr     w16, [x9]
        mov     x17, #200
        str     x16, [sp,x17]
        adrp     x9, a16
        add     x9, x9, #:lo12:a16
        ldr     w16, [x9]
        mov     x17, #208
        str     x16, [sp,x17]
        adrp     x9, a17
        add     x9, x9, #:lo12:a17
        ldr     w16, [x9]
        mov     x17, #216
        str     x16, [sp,x17]
        adrp     x9, a18
        add     x9, x9, #:lo12:a18
        ldr     w16, [x9]
        mov     x17, #224
        str     x16, [sp,x17]
        adrp     x9, a19
        add     x9, x9, #:lo12:a19
        ldr     w16, [x9]
        mov     x17, #232
        str     x16, [sp,x17]
        adrp     x9, a20
        add     x9, x9, #:lo12:a20
        ldr     w16, [x9]
        mov     x17, #240
        str     x16, [sp,x17]
        adrp     x9, a21
        add     x9, x9, #:lo12:a21
        ldr     w16, [x9]
        mov     x17, #248
        str     x16, [sp,x17]
        adrp     x9, a22
        add     x9, x9, #:lo12:a22
        ldr     w16, [x9]
        mov     x17, #256
        str     x16, [sp,x17]
        adrp     x9, a23
        add     x9, x9, #:lo12:a23
        ldr     w16, [x9]
        mov     x17, #264
        str     x16, [sp,x17]
        adrp     x9, a24
        add     x9, x9, #:lo12:a24
        ldr     w16, [x9]
        mov     x17, #272
        str     x16, [sp,x17]
        adrp     x9, a25
        add     x9, x9, #:lo12:a25
        ldr     w15, [x9]
        adrp     x9, a26
        add     x9, x9, #:lo12:a26
        ldr     w14, [x9]
        adrp     x9, a27
        add     x9, x9, #:lo12:a27
        ldr     w13, [x9]
        adrp     x9, a28
        add     x9, x9, #:lo12:a28
        ldr     w12, [x9]
        adrp     x9, a29
        add     x9, x9, #:lo12:a29
        ldr     w11, [x9]
        adrp     x9, a30
        add     x9, x9, #:lo12:a30
        ldr     w10, [x9]
        adrp     x9, a31
        add     x9, x9, #:lo12:a31
        ldr     w9, [x9]
        mov     x16, #80
        ldr     x19, [sp,x16]
        mov     w0, w19
        mov     x16, #88
        ldr     x19, [sp,x16]
        mov     w1, w19
        mov     x16, #96
        ldr     x19, [sp,x16]
        mov     w2, w19
        mov     x16, #104
        ldr     x19, [sp,x16]
        mov     w3, w19
        mov     x16, #112
        ldr     x19, [sp,x16]
        mov     w4, w19
        mov     x16, #120
        ldr     x19, [sp,x16]
        mov     w5, w19
        mov     x16, #128
        ldr     x19, [sp,x16]
        mov     w6, w19
        mov     x16, #136
        ldr     x19, [sp,x16]
        mov     w7, w19
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        str     w9, [sp,#-80]
        str     w10, [sp,#-88]
        str     w11, [sp,#-96]
        str     w12, [sp,#-104]
        str     w13, [sp,#-112]
        str     w14, [sp,#-120]
        str     w15, [sp,#-128]
        mov     x16, #272
        ldr     x19, [sp,x16]
        str     w19, [sp,#-136]
        mov     x16, #264
        ldr     x19, [sp,x16]
        str     w19, [sp,#-144]
        mov     x16, #256
        ldr     x19, [sp,x16]
        str     w19, [sp,#-152]
        mov     x16, #248
        ldr     x19, [sp,x16]
        str     w19, [sp,#-160]
        mov     x16, #240
        ldr     x19, [sp,x16]
        str     w19, [sp,#-168]
        mov     x16, #232
        ldr     x19, [sp,x16]
        str     w19, [sp,#-176]
        mov     x16, #224
        ldr     x19, [sp,x16]
        str     w19, [sp,#-184]
        mov     x16, #216
        ldr     x19, [sp,x16]
        str     w19, [sp,#-192]
        mov     x16, #208
        ldr     x19, [sp,x16]
        str     w19, [sp,#-200]
        mov     x16, #200
        ldr     x19, [sp,x16]
        str     w19, [sp,#-208]
        mov     x16, #192
        ldr     x19, [sp,x16]
        str     w19, [sp,#-216]
        mov     x16, #184
        ldr     x19, [sp,x16]
        str     w19, [sp,#-224]
        mov     x16, #176
        ldr     x19, [sp,x16]
        str     w19, [sp,#-232]
        mov     x16, #168
        ldr     x19, [sp,x16]
        str     w19, [sp,#-240]
        mov     x16, #160
        ldr     x19, [sp,x16]
        str     w19, [sp,#-248]
        mov     x16, #152
        ldr     x19, [sp,x16]
        str     w19, [sp,#-256]
        mov     x27, #-264
        mov     x16, #144
        ldr     x19, [sp,x16]
        str     w19, [sp,x27]
        sub     sp, sp, #264
        mov     x29, sp
        bl     testParam32
        add     sp, sp, #192
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        str     w10, [x9]
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
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
        mov     w9, #117
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
