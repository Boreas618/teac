.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global relu_reg
.global model
.global main
relu_reg:

bb25:

        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0
        mov     w10, w10
        mov     w9, #127
        cmp     w10, w9
        b.gt     bb2
        b     bb3
bb2:

        mov     w9, #127
        mov     w0, w9
        mov     sp, x29
        ret
bb3:

        mov     w9, #0
        cmp     w10, w9
        b.lt     bb5
        b     bb6
bb5:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
bb6:

        mov     w0, w10
        mov     sp, x29
        ret
model:

bb8:

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, #0
        mov     x9, #40
        mul     x9, x10, x9
        add     x10, x11, x9
        mov     x9, #0
        add     x12, x10, x9
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        ldr     w10, [x9]
        mov     w9, #85
        mul     w9, w10, w9
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #23
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #82
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #103
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #123
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #64
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #120
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #50
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #59
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #47
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #111
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #67
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #106
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #75
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #102
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #34
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #39
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #65
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #47
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #113
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #110
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #47
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #0
        sub     w10, w10, #4
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #80
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x12, x11, x10
        mov     x10, #0
        add     x13, x12, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     w12, [x10]
        mov     w10, #46
        mul     w10, w12, w10
        add     w9, w9, w10
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        mov     w9, #39
        mul     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #0
        sub     w9, w9, #106
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #126
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #18
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #31
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #8
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #47
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #4
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #67
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #94
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #121
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #7
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #21
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #60
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #43
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #105
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #42
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #87
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #29
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #106
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #31
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #110
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #100
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #22
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #75
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #125
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        mov     w9, #77
        mul     w9, w12, w9
        add     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #26
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #76
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #70
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #29
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #95
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #96
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #52
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #68
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #5
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #34
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #34
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #102
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #6
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #38
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #27
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #110
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #116
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #39
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #63
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #99
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #65
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #120
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #39
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #6
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #94
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        mov     w9, #127
        mul     w9, w12, w9
        add     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #0
        sub     w9, w9, #23
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #63
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #49
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #50
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #72
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #85
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #30
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #12
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #125
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #117
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #65
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #67
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #125
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #110
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #31
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #123
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #83
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #122
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #11
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #23
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #47
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #32
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #117
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #95
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #118
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        mov     w9, #0
        sub     w9, w9, #106
        mul     w9, w12, w9
        add     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #8
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #82
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #104
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #101
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #116
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #63
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #16
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #70
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #125
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #75
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #66
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #96
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #101
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #114
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #59
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #12
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #5
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #95
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #116
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #93
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #15
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #79
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #3
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #49
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #124
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        mov     w9, #0
        sub     w9, w9, #3
        mul     w9, w12, w9
        add     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #81
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #68
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #102
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #74
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #121
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #15
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #55
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #101
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #13
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #62
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #64
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #114
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #38
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #21
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #112
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #114
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #112
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #10
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #16
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #50
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #112
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #116
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #54
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #82
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #72
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        mov     w9, #32
        mul     w9, w12, w9
        add     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #15
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #77
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #66
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #90
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #6
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #30
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #8
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #81
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #2
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #110
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #95
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #59
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #52
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #15
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #55
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #33
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #14
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #58
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #67
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #86
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #79
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #48
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #13
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #15
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #66
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        mov     w9, #0
        sub     w9, w9, #95
        mul     w9, w12, w9
        add     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #33
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #82
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #67
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #30
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #2
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #65
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #120
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #13
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #18
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #5
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #104
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #119
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #7
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #71
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #107
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #24
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #82
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #96
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #104
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #121
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #65
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #97
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #83
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #46
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #84
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        mov     w9, #0
        sub     w9, w9, #50
        mul     w9, w12, w9
        add     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #0
        sub     w9, w9, #29
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #7
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #70
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #38
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #90
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #15
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #32
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #37
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #36
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #62
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #125
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #46
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #70
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #37
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #73
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #34
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #87
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #75
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #71
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #77
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #53
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #37
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #103
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #13
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #114
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0
        mov     w9, #0
        sub     w9, w9, #23
        mul     w9, w12, w9
        add     w10, w10, w9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x12, x11, x9
        mov     x9, #0
        add     x13, x12, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     w12, [x9]
        mov     w9, #67
        mul     w9, w12, w9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #42
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #41
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #123
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #92
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #10
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #77
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #75
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #96
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #51
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #109
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #74
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #7
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #122
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #67
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #47
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #22
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #68
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #38
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #29
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #115
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #121
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #36
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        add     x14, x13, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     w13, [x12]
        mov     w12, #0
        sub     w12, w12, #49
        mul     w12, w13, w12
        add     w9, w9, w12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x12, x11, x12
        mov     x11, #0
        add     x13, x12, x11
        mov     x12, #4
        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x13, x11
        ldr     w12, [x11]
        mov     w11, #85
        mul     w11, w12, w11
        add     w9, w9, w11
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0
        mov     w9, #46
        mul     w9, w11, w9
        add     w10, w10, w9
        mov     w9, #0
        cmp     w10, w9
        b.gt     bb9
        b     bb10
bb9:

        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret
bb10:

        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
main:

bb12:

        mov     x16, #208
        sub     sp, sp, x16
        mov     w9, #0
        mov     w9, #0
        mov     w9, #37
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
        mov     w9, w0
        mov     w11, w9
        b     bb13
bb13:

        mov     w9, #0
        cmp     w11, w9
        b.gt     bb14
        b     bb15
bb14:

        mov     w9, #0
        mov     w9, w9
        mov     w10, w9
        b     bb16
bb16:

        mov     w9, #5
        cmp     w10, w9
        b.lt     bb17
        b     bb18
bb17:

        mov     w9, #0
        mov     w9, w9
        mov     w9, w9
        b     bb19
bb19:

        mov     w12, #5
        cmp     w9, w12
        b.lt     bb20
        b     bb21
bb20:

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
        mov     w12, w0
        mov     x13, #40
        mul     x14, x10, x13
        mov     x13, #-200
        add     x13, x29, x13
        add     x14, x13, x14
        mov     x13, #0
        add     x14, x14, x13
        mov     x13, #8
        mul     x13, x9, x13
        add     x13, x14, x13
        str     w12, [x13]
        add     w9, w9, #1
        mov     w9, w9
        b     bb19
bb21:

        add     w9, w10, #1
        mov     w10, w9
        b     bb16
bb18:

        mov     x9, #-200
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     model
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0
        mov     w9, #0
        cmp     w10, w9
        b.ne     bb22
        b     bb23
bb22:

        mov     w9, #99
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #97
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #116
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #10
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb24
bb23:

        mov     w9, #100
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #111
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #103
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, #10
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        b     bb24
bb24:

        sub     w9, w11, #1
        mov     w11, w9
        b     bb13
bb15:

        mov     w9, #58
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
