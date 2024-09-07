.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global main
        //%r195->x9
        //%r194->x9
        //%r193->x9
        //%r192->x9
        //%r191->x9
        //%r188->x10
        //%r187->x11
        //%r186->x10
        //%r185->x10
        //%r184->x9
        //%r183->x9
        //%r182->x9
        //%r181->x9
        //%r179->x9
        //%r178->x9
        //%r177->x9
        //%r176->x9
        //%r175->x9
        //%r174->x9
        //%r173->x9
        //%r172->x9
        //%r171->x9
        //%r170->x10
        //%r169->x9
        //%r168->x13
        //%r166->x9
        //%r149->x9
        //%r148->x9
        //%r146->x9
        //%r142->x9
        //%r144->x9
        //%r190->x9
        //%r131->x13
        //%r160->x10
        //%r143->x9
        //%r189->x10
        //%r130->x13
        //%r159->x13
        //%r147->x9
        //%r180->x9
        //%r121->x10
        //%r150->x9
        //%r167->x10
        //%r108->x10
        //%r145->x9
        //%r164->x9
        //%r151->x9
        //%r152->x9
        //%r153->x9
        //%r154->x9
        //%r155->x12
        //%r156->x10
        //%r157->x9
        //%r158->x9
        //%r161->x9
        //%r162->x11
        //%r163->x10
        //%r106->x12
        //%r165->x9
        //%r196->x13
        //%r197->x13
        //%r198->x13
        //%r199->x14
        //%r200->x13
        //%r201->x13
        //%r202->x9
        //%r203->x11
        //%r204->x9
        //%r205->x9
        //%r206->x9
        //%r207->x9
main:

        //102:x29,#-80

        //bb1:

bb1:

        //  %r142 = add i32 0, 0

        mov     x16, #80
        sub     sp, sp, x16
        mov     x9, #0
        //  %r143 = add i32 0, 0

        mov     x9, #0
        //  %r144 = add i32 0, 0

        mov     x9, #0
        //  %r145 = add i32 0, 0

        mov     x9, #0
        //  %r146 = add i32 0, 0

        mov     x9, #0
        //  %r147 = add i32 0, 0

        mov     x9, #0
        //  %r148 = add i32 0, 0

        mov     x9, #0
        //  call void @_sysy_starttime(i32 3)

        mov     x9, #3
        mov     x0, x9
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
        //  %r149 = add i32 0, 0

        mov     x9, #0
        //  %r150 = add i32 0, 0

        mov     x9, #0
        //  %r102 = alloca [ 10 x i32 ]

        //  %r151 = add i32 0, 0

        mov     x9, #0
        //  %r152 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r153 = phi i32 [ %r152, %bb1 ], [ %r172, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb2:

bb2:

        //  %r153 = phi i32 [ %r152, %bb1 ], [ %r172, %bb3 ]

        //  %r104 = icmp slt i32 %r153, 10

        mov     x10, #10
        cmp     x9, x10
        //  br i1 %r104, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r106 = add i32 %r153, 1

        add     x12, x9, #1
        //  %r108 = getelementptr [10 x i32 ], [10 x i32 ]* %r102, i32 0 , i32 %r153

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r106, i32* %r108

        str     x12, [x10]
        //  %r172 = add i32 %r153, 1

        add     x9, x9, #1
        //  br label %bb2


        //bb2:  %r153 = phi i32 [ %r152, %bb1 ], [ %r172, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb4:

bb4:

        //  %r154 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  %r155 = call i32 @getint()

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
        mov     x12, x0
        //  %r156 = sub i32 %r154, 1

        sub     x10, x9, #1
        //  %r157 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  %r121 = add i32 %r156, %r157

        add     x10, x10, x9
        //  %r158 = sdiv i32 %r121, 2

        mov     x9, #2
        //  %r159 = add i32 0, 0

        mov     x9, #0
        mov     x13, x9
        //  %r160 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r161 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb5


        //bb5:  %r162 = phi i32 [ %r160, %bb4 ], [ %r169, %bb11 ]

        mov     x11, x10
        //bb5:  %r163 = phi i32 [ %r159, %bb4 ], [ %r167, %bb11 ]

        mov     x10, x13
        //bb5:  %r164 = phi i32 [ %r161, %bb4 ], [ %r168, %bb11 ]

        mov     x9, x9
        b     bb5
        //bb5:

bb5:

        //  %r162 = phi i32 [ %r160, %bb4 ], [ %r169, %bb11 ]

        //  %r163 = phi i32 [ %r159, %bb4 ], [ %r167, %bb11 ]

        //  %r164 = phi i32 [ %r161, %bb4 ], [ %r168, %bb11 ]

        //  %r126 = icmp slt i32 %r162, 10

        mov     x13, #10
        cmp     x11, x13
        //  br i1 %r126, label %bb8, label %bb7


        b.lt     bb8
        b     bb7
        //bb8:

bb8:

        //  %r128 = icmp eq i32 %r163, 0

        mov     x13, #0
        cmp     x10, x13
        //  br i1 %r128, label %bb6, label %bb7


        b.eq     bb6
        b     bb7
        //bb6:

bb6:

        //  %r130 = getelementptr [10 x i32 ], [10 x i32 ]* %r102, i32 0 , i32 %r162

        mov     x13, #8
        mul     x14, x11, x13
        mov     x13, #-80
        add     x13, x29, x13
        add     x13, x13, x14
        //  %r131 = load i32, i32* %r130

        ldr     x13, [x13]
        //  %r133 = icmp eq i32 %r131, %r155

        cmp     x13, x12
        //  br i1 %r133, label %bb9, label %bb10


        b.eq     bb9
        b     bb10
        //bb9:

bb9:

        //  %r170 = add i32 1, 0

        mov     x9, #1
        mov     x10, x9
        //  %r171 = add i32 %r162, 0

        mov     x9, x11
        //  br label %bb11


        //bb11:  %r167 = phi i32 [ %r170, %bb9 ], [ %r163, %bb10 ]

        mov     x10, x10
        //bb11:  %r168 = phi i32 [ %r171, %bb9 ], [ %r164, %bb10 ]

        mov     x13, x9
        b     bb11
        //bb10:

bb10:

        //  br label %bb11


        //bb11:  %r167 = phi i32 [ %r170, %bb9 ], [ %r163, %bb10 ]

        mov     x10, x10
        //bb11:  %r168 = phi i32 [ %r171, %bb9 ], [ %r164, %bb10 ]

        mov     x13, x9
        b     bb11
        //bb11:

bb11:

        //  %r167 = phi i32 [ %r170, %bb9 ], [ %r163, %bb10 ]

        //  %r168 = phi i32 [ %r171, %bb9 ], [ %r164, %bb10 ]

        //  %r169 = add i32 %r162, 1

        add     x9, x11, #1
        //  br label %bb5


        //bb5:  %r162 = phi i32 [ %r160, %bb4 ], [ %r169, %bb11 ]

        mov     x11, x9
        //bb5:  %r163 = phi i32 [ %r159, %bb4 ], [ %r167, %bb11 ]

        mov     x10, x10
        //bb5:  %r164 = phi i32 [ %r161, %bb4 ], [ %r168, %bb11 ]

        mov     x9, x13
        b     bb5
        //bb7:

bb7:

        //  %r138 = icmp eq i32 %r163, 1

        mov     x11, #1
        cmp     x10, x11
        //  br i1 %r138, label %bb12, label %bb13


        b.eq     bb12
        b     bb13
        //bb12:

bb12:

        //  call void @putint(i32 %r164)

        mov     x0, x9
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
        //  br label %bb14


        b     bb14
        //bb13:

bb13:

        //  %r166 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  call void @putint(i32 %r166)

        mov     x0, x9
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
        //  br label %bb14


        b     bb14
        //bb14:

bb14:

        //  %r165 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  call void @putch(i32 %r165)

        mov     x0, x9
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
        //  call void @_sysy_stoptime(i32 53)

        mov     x9, #53
        mov     x0, x9
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
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
