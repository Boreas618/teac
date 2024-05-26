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
        mov     x10, x0
        mov     x9, #0
        mov     x9, x9
        mov     x10, x10
        mov     x9, #127
        cmp     x10, x9
        b.gt     bb2
        b     bb3
bb2:

        mov     x9, #127
        mov     x0, x9
        mov     sp, x29
        ret
bb3:

        mov     x9, #0
        cmp     x10, x9
        b.lt     bb5
        b     bb6
bb5:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
bb6:

        mov     x0, x10
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
        add     x12, x11, x9
        mov     x10, #0
        mov     x9, #40
        mul     x9, x10, x9
        add     x12, x12, x9
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        ldr     x10, [x9]
        mov     x9, #85
        mul     x9, x10, x9
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #23
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #82
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #103
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #123
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #64
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #120
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #50
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #59
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #1
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #47
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #111
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #67
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #106
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #75
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #2
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #102
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #34
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #39
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #65
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #47
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #3
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #113
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #110
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #47
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #0
        sub     x10, x10, #4
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #3
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #80
        mul     x10, x12, x10
        add     x9, x9, x10
        mov     x12, #4
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x11, x10
        mov     x12, #0
        mov     x10, #40
        mul     x10, x12, x10
        add     x13, x13, x10
        mov     x12, #4
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x13, x10
        ldr     x12, [x10]
        mov     x10, #46
        mul     x10, x12, x10
        add     x9, x9, x10
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
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #39
        mul     x10, x0, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #0
        sub     x9, x9, #106
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #126
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #18
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #31
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #8
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #47
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #4
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #67
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #94
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #121
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #7
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #21
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #60
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #43
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #105
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #42
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #87
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #29
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #106
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #31
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #110
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #100
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #22
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #75
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #125
        mul     x12, x13, x12
        add     x9, x9, x12
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
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #77
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #26
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #76
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #70
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #29
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #95
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #96
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #52
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #68
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #5
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #34
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #34
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #102
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #6
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #38
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #27
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #110
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #116
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #39
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #63
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #99
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #65
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #120
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #39
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #6
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #94
        mul     x12, x13, x12
        add     x9, x9, x12
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
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #127
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #0
        sub     x9, x9, #23
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #63
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #49
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #50
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #72
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #85
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #30
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #12
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #125
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #117
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #65
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #67
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #125
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #110
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #31
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #123
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #83
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #122
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #11
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #23
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #47
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #32
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #117
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #95
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #118
        mul     x12, x13, x12
        add     x9, x9, x12
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
        bl     relu_reg
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
        sub     x9, x9, #106
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #8
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #82
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #104
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #101
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #116
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #63
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #16
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #70
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #125
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #75
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #66
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #96
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #101
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #114
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #59
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #12
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #5
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #95
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #116
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #93
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #15
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #79
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #3
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #49
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #124
        mul     x12, x13, x12
        add     x9, x9, x12
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
        bl     relu_reg
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
        sub     x9, x9, #3
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #81
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #68
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #102
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #74
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #121
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #15
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #55
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #101
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #13
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #62
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #64
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #114
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #38
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #21
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #112
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #114
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #112
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #10
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #16
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #50
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #112
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #116
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #54
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #82
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #72
        mul     x12, x13, x12
        add     x9, x9, x12
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
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #32
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #15
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #77
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #66
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #90
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #6
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #30
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #8
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #81
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #2
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #110
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #95
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #59
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #52
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #15
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #55
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #33
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #14
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #58
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #67
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #86
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #79
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #48
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #13
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #15
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #66
        mul     x12, x13, x12
        add     x9, x9, x12
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
        bl     relu_reg
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
        sub     x9, x9, #95
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #33
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #82
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #67
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #30
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #2
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #65
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #120
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #13
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #18
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #5
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #104
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #119
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #7
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #71
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #107
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #24
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #82
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #96
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #104
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #121
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #65
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #97
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #83
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #46
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #84
        mul     x12, x13, x12
        add     x9, x9, x12
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
        bl     relu_reg
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
        sub     x9, x9, #50
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #0
        sub     x9, x9, #29
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #7
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #70
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #38
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #90
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #15
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #32
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #37
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #36
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #62
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #125
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #46
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #70
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #37
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #73
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #34
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #87
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #75
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #71
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #77
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #53
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #37
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #103
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #13
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #114
        mul     x12, x13, x12
        add     x9, x9, x12
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
        bl     relu_reg
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
        sub     x9, x9, #23
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x11, x9
        mov     x12, #0
        mov     x9, #40
        mul     x9, x12, x9
        add     x13, x13, x9
        mov     x12, #0
        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x13, x9
        ldr     x12, [x9]
        mov     x9, #67
        mul     x9, x12, x9
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #42
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #41
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #123
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #92
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #10
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #77
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #75
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #96
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #1
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #51
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #109
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #74
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #7
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #122
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #2
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #67
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #47
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #22
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #68
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #38
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #3
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #4
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #29
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #0
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #115
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #1
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #121
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #2
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #36
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x11, x12
        mov     x13, #0
        mov     x12, #40
        mul     x12, x13, x12
        add     x14, x14, x12
        mov     x13, #3
        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x14, x12
        ldr     x13, [x12]
        mov     x12, #0
        sub     x12, x12, #49
        mul     x12, x13, x12
        add     x9, x9, x12
        mov     x13, #4
        mov     x12, #40
        mul     x12, x13, x12
        add     x13, x11, x12
        mov     x12, #0
        mov     x11, #40
        mul     x11, x12, x11
        add     x13, x13, x11
        mov     x12, #4
        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x13, x11
        ldr     x12, [x11]
        mov     x11, #85
        mul     x11, x12, x11
        add     x9, x9, x11
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
        bl     relu_reg
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, #46
        mul     x9, x0, x9
        add     x10, x10, x9
        mov     x9, #0
        cmp     x10, x9
        b.gt     bb9
        b     bb10
bb9:

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
bb10:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
main:

bb12:

        mov     x16, #208
        sub     sp, sp, x16
        mov     x9, #0
        mov     x9, x9
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
        mov     x10, x0
        b     bb13
bb13:

        mov     x9, #0
        cmp     x10, x9
        b.gt     bb14
        b     bb15
bb14:

        mov     x9, #0
        mov     x9, x9
        mov     x9, x9
        b     bb16
bb16:

        mov     x11, #5
        cmp     x9, x11
        b.lt     bb17
        b     bb18
bb17:

        mov     x11, #0
        mov     x11, x11
        mov     x13, x11
        b     bb19
bb19:

        mov     x11, #5
        cmp     x13, x11
        b.lt     bb20
        b     bb21
bb20:

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
        mov     x11, #40
        mul     x12, x9, x11
        mov     x11, #-8
        add     x11, x29, x11
        add     x14, x11, x12
        mov     x12, #0
        mov     x11, #40
        mul     x11, x12, x11
        add     x12, x14, x11
        mov     x11, #8
        mul     x11, x13, x11
        add     x11, x12, x11
        str     x0, [x11]
        add     x11, x13, #1
        mov     x13, x11
        b     bb19
bb21:

        add     x9, x9, #1
        mov     x9, x9
        b     bb16
bb18:

        mov     x9, #-8
        add     x9, x29, x9
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
        bl     model
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
        cmp     x0, x9
        b.ne     bb22
        b     bb23
bb22:

        mov     x9, #99
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
        mov     x9, #116
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
        b     bb24
bb23:

        mov     x9, #100
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
        mov     x9, #111
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
        mov     x9, #103
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
        b     bb24
bb24:

        sub     x9, x10, #1
        mov     x10, x9
        b     bb13
bb15:

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
