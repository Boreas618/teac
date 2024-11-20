.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global move
.global hanoi
.global main

        #%r100->x11

        #%r139->x11

        #%r102->x10

        #%r154->x9

        #%r137->x9

        #%r138->x9

        #%r140->x10

        #%r153->x9

        #%r155->x9

        #%r156->x9

        #%r157->x9
move:


        #bb10:
bb10:


        #  %r137 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w11, w0
        mov     w10, w1
        mov     w9, #0

        #  %r139 = add i32 %r100, 0
        mov     w11, w11

        #  %r138 = add i32 0, 0
        mov     w9, #0

        #  %r140 = add i32 %r102, 0
        mov     w10, w10

        #  br label %bb1

        b     bb1

        #bb1:
bb1:


        #  call void @putint(i32 %r139)
        mov     w0, w11
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

        #  call void @putch(i32 32)
        mov     w9, #32
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

        #  call void @putint(i32 %r140)
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

        #  call void @putch(i32 44)
        mov     w9, #44
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

        #  call void @putch(i32 32)
        mov     w9, #32
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

        #  ret void
        mov     sp, x29
        ret

        #%r146->x10

        #%r144->x9

        #%r143->x9

        #%r142->x9

        #%r141->x9

        #%r112->x12

        #%r126->x11

        #%r110->x9

        #%r147->x9

        #%r108->x13

        #%r145->x11

        #%r119->x12

        #%r148->x13

        #%r106->x11

        #%r158->x10

        #%r159->x10

        #%r160->x13

        #%r161->x13

        #%r162->x12
hanoi:


        #bb11:
bb11:


        #  %r141 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w11, w0
        mov     w13, w1
        mov     w9, w2
        mov     w12, w3
        mov     w10, #0

        #  %r145 = add i32 %r106, 0
        mov     w11, w11

        #  %r142 = add i32 0, 0
        mov     w10, #0

        #  %r146 = add i32 %r108, 0
        mov     w10, w13

        #  %r143 = add i32 0, 0
        mov     w13, #0

        #  %r147 = add i32 %r110, 0
        mov     w9, w9

        #  %r144 = add i32 0, 0
        mov     w13, #0

        #  %r148 = add i32 %r112, 0
        mov     w13, w12

        #  br label %bb2

        b     bb2

        #bb2:
bb2:


        #  %r115 = icmp eq i32 %r145, 1
        mov     w12, #1
        cmp     w11, w12

        #  br i1 %r115, label %bb3, label %bb4

        b.eq     bb3
        b     bb4

        #bb3:
bb3:


        #  call void @move(i32 %r146, i32 %r148)
        mov     w0, w10
        mov     w1, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     move
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb5

        b     bb5

        #bb4:
bb4:


        #  %r119 = sub i32 %r145, 1
        sub     w12, w11, #1

        #  call void @hanoi(i32 %r119, i32 %r146, i32 %r148, i32 %r147)
        mov     w0, w12
        mov     w1, w10
        mov     w2, w13
        mov     w3, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     hanoi
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  call void @move(i32 %r146, i32 %r148)
        mov     w0, w10
        mov     w1, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     move
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r126 = sub i32 %r145, 1
        sub     w11, w11, #1

        #  call void @hanoi(i32 %r126, i32 %r147, i32 %r146, i32 %r148)
        mov     w0, w11
        mov     w1, w9
        mov     w2, w10
        mov     w3, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     hanoi
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb5

        b     bb5

        #bb5:
bb5:


        #  ret void
        mov     sp, x29
        ret

        #%r170->x9

        #%r169->x9

        #%r168->x9

        #%r167->x9

        #%r166->x9

        #%r165->x9

        #%r152->x9

        #%r164->x9

        #%r151->x10

        #%r163->x9

        #%r134->x9

        #%r150->x9

        #%r149->x9

        #%r171->x9
main:


        #bb6:
bb6:


        #  call void @_sysy_starttime(i32 21)
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #21
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

        #  %r149 = add i32 0, 0
        mov     w9, #0

        #  %r150 = call i32 @getint()
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

        #  br label %bb7


        #bb7:  %r151 = phi i32 [ %r150, %bb6 ], [ %r152, %bb8 ]
        mov     w10, w9
        b     bb7

        #bb7:
bb7:


        #  %r151 = phi i32 [ %r150, %bb6 ], [ %r152, %bb8 ]

        #  %r133 = icmp sgt i32 %r151, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r133, label %bb8, label %bb9

        b.gt     bb8
        b     bb9

        #bb8:
bb8:


        #  %r134 = call i32 @getint()
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

        #  call void @hanoi(i32 %r134, i32 1, i32 2, i32 3)
        mov     w0, w9
        mov     w9, #1
        mov     w1, w9
        mov     w9, #2
        mov     w2, w9
        mov     w9, #3
        mov     w3, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     hanoi
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  call void @putch(i32 10)
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

        #  %r152 = sub i32 %r151, 1
        sub     w9, w10, #1

        #  br label %bb7


        #bb7:  %r151 = phi i32 [ %r150, %bb6 ], [ %r152, %bb8 ]
        mov     w10, w9
        b     bb7

        #bb9:
bb9:


        #  call void @_sysy_stoptime(i32 28)
        mov     w9, #28
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
