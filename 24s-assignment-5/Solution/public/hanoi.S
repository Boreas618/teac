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
        //%r100->x11
        //%r139->x11
        //%r102->x10
        //%r154->x9
        //%r137->x9
        //%r138->x9
        //%r140->x10
        //%r153->x9
        //%r155->x9
        //%r156->x9
        //%r157->x9
move:

        //bb10:

bb10:

        //  %r137 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        //  %r139 = add i32 %r100, 0

        mov     x11, x11
        //  %r138 = add i32 0, 0

        mov     x9, #0
        //  %r140 = add i32 %r102, 0

        mov     x10, x10
        //  call void @putint(i32 %r139)

        mov     x0, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 32)

        mov     x9, #32
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putint(i32 %r140)

        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 44)

        mov     x9, #44
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 32)

        mov     x9, #32
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  ret void

        mov     sp, x29
        ret
        //%r146->x11
        //%r144->x9
        //%r143->x9
        //%r142->x9
        //%r141->x9
        //%r112->x9
        //%r126->x12
        //%r110->x10
        //%r147->x10
        //%r108->x11
        //%r145->x12
        //%r119->x13
        //%r148->x9
        //%r106->x13
        //%r158->x12
        //%r159->x13
        //%r160->x13
        //%r161->x13
        //%r162->x13
hanoi:

        //bb11:

bb11:

        //  %r141 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x11, x1
        mov     x10, x2
        mov     x9, x3
        mov     x12, #0
        //  %r145 = add i32 %r106, 0

        mov     x12, x13
        //  %r142 = add i32 0, 0

        mov     x13, #0
        //  %r146 = add i32 %r108, 0

        mov     x11, x11
        //  %r143 = add i32 0, 0

        mov     x13, #0
        //  %r147 = add i32 %r110, 0

        mov     x10, x10
        //  %r144 = add i32 0, 0

        mov     x13, #0
        //  %r148 = add i32 %r112, 0

        mov     x9, x9
        //  %r115 = icmp eq i32 %r145, 1

        mov     x13, #1
        cmp     x12, x13
        //  br i1 %r115, label %bb3, label %bb4


        b.eq     bb3
        b     bb4
        //bb3:

bb3:

        //  call void @move(i32 %r146, i32 %r148)

        mov     x0, x11
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     move
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb5


        b     bb5
        //bb4:

bb4:

        //  %r119 = sub i32 %r145, 1

        sub     x13, x12, #1
        //  call void @hanoi(i32 %r119, i32 %r146, i32 %r148, i32 %r147)

        mov     x0, x13
        mov     x1, x11
        mov     x2, x9
        mov     x3, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     hanoi
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @move(i32 %r146, i32 %r148)

        mov     x0, x11
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     move
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r126 = sub i32 %r145, 1

        sub     x12, x12, #1
        //  call void @hanoi(i32 %r126, i32 %r147, i32 %r146, i32 %r148)

        mov     x0, x12
        mov     x1, x10
        mov     x2, x11
        mov     x3, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     hanoi
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb5


        b     bb5
        //bb5:

bb5:

        //  ret void

        mov     sp, x29
        ret
        //%r170->x9
        //%r169->x10
        //%r168->x10
        //%r167->x10
        //%r166->x10
        //%r165->x10
        //%r152->x9
        //%r164->x9
        //%r151->x9
        //%r163->x9
        //%r134->x10
        //%r150->x9
        //%r149->x9
        //%r171->x9
main:

        //bb6:

bb6:

        //  call void @_sysy_starttime(i32 21)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #21
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r149 = add i32 0, 0

        mov     x9, #0
        //  %r150 = call i32 @getint()

        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb7


        //bb7:  %r151 = phi i32 [ %r150, %bb6 ], [ %r152, %bb8 ]

        mov     x9, x9
        b     bb7
        //bb7:

bb7:

        //  %r151 = phi i32 [ %r150, %bb6 ], [ %r152, %bb8 ]

        //  %r133 = icmp sgt i32 %r151, 0

        mov     x10, #0
        cmp     x9, x10
        //  br i1 %r133, label %bb8, label %bb9


        b.gt     bb8
        b     bb9
        //bb8:

bb8:

        //  %r134 = call i32 @getint()

        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  call void @hanoi(i32 %r134, i32 1, i32 2, i32 3)

        mov     x0, x10
        mov     x10, #1
        mov     x1, x10
        mov     x10, #2
        mov     x2, x10
        mov     x10, #3
        mov     x3, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     hanoi
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 10)

        mov     x10, #10
        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r152 = sub i32 %r151, 1

        sub     x9, x9, #1
        //  br label %bb7


        //bb7:  %r151 = phi i32 [ %r150, %bb6 ], [ %r152, %bb8 ]

        mov     x9, x9
        b     bb7
        //bb9:

bb9:

        //  call void @_sysy_stoptime(i32 28)

        mov     x9, #28
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
