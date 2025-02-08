.section .data
.global    N
.global    newline
N:
        .quad   0
newline:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global mod
.global split
.global main

        #%r100->x10

        #%r102->x11

        #%r107->x11

        #%r109->x9

        #%r110->x9

        #%r142->x9

        #%r143->x9

        #%r144->x10

        #%r145->x9

        #%r163->x9

        #%r164->x9
mod:


        #bb10:
bb10:


        #  %r142 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w11, w1
        mov     w9, #0

        #  %r144 = add i32 %r100, 0
        mov     w10, w10

        #  %r143 = add i32 0, 0
        mov     w9, #0

        #  %r145 = add i32 %r102, 0
        mov     w9, w11

        #  br label %bb1

        b     bb1

        #bb1:
bb1:


        #  %r107 = sdiv i32 %r144, %r145
        sdiv     w11, w10, w9

        #  %r109 = mul i32 %r107, %r145
        mul     w9, w11, w9

        #  %r110 = sub i32 %r144, %r109
        sub     w9, w10, w9

        #  ret i32 %r110
        mov     w0, w9
        mov     sp, x29
        ret

        #%r153->x9

        #%r151->x9

        #%r122->x12

        #%r149->x9

        #%r120->x13

        #%r147->x9

        #%r148->x10

        #%r146->x9

        #%r115->x9

        #%r173->x9

        #%r152->x10

        #%r113->x11

        #%r171->x12

        #%r150->x10

        #%r111->x10

        #%r169->x12

        #%r165->x9

        #%r166->x9

        #%r167->x9

        #%r168->x12

        #%r170->x12

        #%r172->x12
split:


        #bb11:
bb11:


        #  %r146 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     x11, x1
        mov     w9, #0

        #  %r147 = add i32 0, 0
        mov     w9, #0

        #  %r148 = add i32 %r111, 0
        mov     w10, w10

        #  br label %bb2

        b     bb2

        #bb2:
bb2:


        #  %r115 = load i32, i32* @N
        adrp     x9, N
        add     x9, x9, #:lo12:N
        ldr     w9, [x9]

        #  %r149 = sub i32 %r115, 1
        sub     w9, w9, #1

        #  br label %bb3


        #bb3:  %r150 = phi i32 [ %r148, %bb2 ], [ %r152, %bb4 ]
        mov     w10, w10

        #bb3:  %r151 = phi i32 [ %r149, %bb2 ], [ %r153, %bb4 ]
        mov     w9, w9
        b     bb3

        #bb3:
bb3:


        #  %r150 = phi i32 [ %r148, %bb2 ], [ %r152, %bb4 ]

        #  %r151 = phi i32 [ %r149, %bb2 ], [ %r153, %bb4 ]

        #  %r118 = icmp ne i32 %r151, -1
        mov     w12, #-1
        cmp     w9, w12

        #  br i1 %r118, label %bb4, label %bb5

        b.ne     bb4
        b     bb5

        #bb4:
bb4:


        #  %r120 = call i32 @mod(i32 %r150, i32 10)
        mov     w0, w10
        mov     w12, #10
        mov     w1, w12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w13, w0

        #  %r122 = getelementptr i32, i32* %r113, i32 %r151
        mov     x12, #4
        mul     x12, x9, x12
        add     x12, x11, x12

        #  store i32 %r120, i32* %r122
        str     w13, [x12]

        #  %r152 = sdiv i32 %r150, 10
        mov     w12, #10
        sdiv     w10, w10, w12

        #  %r153 = sub i32 %r151, 1
        sub     w9, w9, #1

        #  br label %bb3


        #bb3:  %r150 = phi i32 [ %r148, %bb2 ], [ %r152, %bb4 ]
        mov     w10, w10

        #bb3:  %r151 = phi i32 [ %r149, %bb2 ], [ %r153, %bb4 ]
        mov     w9, w9
        b     bb3

        #bb5:
bb5:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r182->x9

        #%r181->x9

        #%r180->x9

        #%r179->x9

        #%r178->x9

        #%r177->x10

        #%r176->x9

        #%r136->x10

        #%r191->x10

        #%r162->x9

        #%r175->x10

        #%r139->x10

        #%r183->x9

        #%r154->x9

        #%r184->x9

        #%r155->x9

        #%r185->x9

        #%r156->x9

        #%r186->x10

        #%r157->x9

        #%r187->x10

        #%r158->x9

        #%r188->x11

        #%r159->x9

        #%r189->x10

        #%r160->x9

        #%r190->x10

        #%r161->x10

        #%r174->x9

        #%r192->x9

        #%r193->x9
main:


        #129:x29,#-16

        #bb6:
bb6:


        #  call void @_sysy_starttime(i32 26)
        mov     x16, #16
        sub     sp, sp, x16
        mov     w9, #26
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

        #  store i32 4, i32* @N
        mov     w10, #4
        adrp     x9, N
        add     x9, x9, #:lo12:N
        str     w10, [x9]

        #  store i32 10, i32* @newline
        mov     w10, #10
        adrp     x9, newline
        add     x9, x9, #:lo12:newline
        str     w10, [x9]

        #  %r154 = add i32 0, 0
        mov     w9, #0

        #  %r155 = add i32 0, 0
        mov     w9, #0

        #  %r129 = alloca [ 4 x i32 ]

        #  %r157 = add i32 1478, 0
        mov     w9, #1478
        mov     w9, w9

        #  %r158 = call i32 @split(i32 %r157, i32* %r129)
        mov     w0, w9
        mov     x9, #-16
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     split
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r156 = add i32 0, 0
        mov     w9, #0

        #  %r159 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb7


        #bb7:  %r160 = phi i32 [ %r159, %bb6 ], [ %r162, %bb8 ]
        mov     w9, w9
        b     bb7

        #bb7:
bb7:


        #  %r160 = phi i32 [ %r159, %bb6 ], [ %r162, %bb8 ]

        #  %r134 = icmp slt i32 %r160, 4
        mov     w10, #4
        cmp     w9, w10

        #  br i1 %r134, label %bb8, label %bb9

        b.lt     bb8
        b     bb9

        #bb8:
bb8:


        #  %r136 = getelementptr [4 x i32 ], [4 x i32 ]* %r129, i32 0, i32 %r160
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-16
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r161 = load i32, i32* %r136
        ldr     w10, [x10]

        #  call void @putint(i32 %r161)
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

        #  %r139 = load i32, i32* @newline
        adrp     x10, newline
        add     x10, x10, #:lo12:newline
        ldr     w10, [x10]

        #  call void @putch(i32 %r139)
        mov     w0, w10
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

        #  %r162 = add i32 %r160, 1
        add     w9, w9, #1

        #  br label %bb7


        #bb7:  %r160 = phi i32 [ %r159, %bb6 ], [ %r162, %bb8 ]
        mov     w9, w9
        b     bb7

        #bb9:
bb9:


        #  call void @_sysy_stoptime(i32 42)
        mov     w9, #42
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

        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
