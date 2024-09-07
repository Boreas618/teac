.section .data
.global    ascii_0
ascii_0:
        .quad   48
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global my_getint
.global mod
.global my_putint
.global main
        //%r174->x11
        //%r203->x9
        //%r173->x9
        //%r202->x9
        //%r171->x9
        //%r113->x10
        //%r200->x10
        //%r170->x11
        //%r112->x11
        //%r199->x9
        //%r167->x9
        //%r172->x9
        //%r201->x9
        //%r120->x9
        //%r207->x10
        //%r169->x9
        //%r198->x9
        //%r104->x9
        //%r168->x9
        //%r197->x9
        //%r103->x10
        //%r175->x9
        //%r204->x9
        //%r176->x10
        //%r205->x11
        //%r206->x10
        //%r208->x10
        //%r209->x10
        //%r210->x10
my_getint:

        //bb1:

bb1:

        //  %r167 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r169 = add i32 0, 0

        mov     x9, #0
        //  %r168 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r170 = phi i32 [ %r168, %bb1 ], [ %r176, %bb5 ]

        mov     x11, x9
        b     bb2
        //bb2:

bb2:

        //  %r170 = phi i32 [ %r168, %bb1 ], [ %r176, %bb5 ]

        //  %r102 = icmp sgt i32 1, 0

        mov     x10, #1
        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r102, label %bb3, label %bb4


        b.gt     bb3
        //bb4:  %r171 = phi i32 [ %r170, %bb2 ], [ %r176, %bb6 ]

        mov     x9, x11
        b     bb4
        //bb3:

bb3:

        //  %r103 = call i32 @getch()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r104 = load i32, i32* @ascii_0

        adrp     x9, ascii_0
        add     x9, x9, #:lo12:ascii_0
        ldr     x9, [x9]
        //  %r176 = sub i32 %r103, %r104

        sub     x10, x10, x9
        //  %r107 = icmp slt i32 %r176, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r107, label %bb5, label %bb8


        b.lt     bb5
        b     bb8
        //bb8:

bb8:

        //  %r109 = icmp sgt i32 %r176, 9

        mov     x9, #9
        cmp     x10, x9
        //  br i1 %r109, label %bb5, label %bb6


        b.gt     bb5
        b     bb6
        //bb5:

bb5:

        //  br label %bb2


        //bb2:  %r170 = phi i32 [ %r168, %bb1 ], [ %r176, %bb5 ]

        mov     x11, x10
        b     bb2
        //bb6:

bb6:

        //  br label %bb4


        //bb4:  %r171 = phi i32 [ %r170, %bb2 ], [ %r176, %bb6 ]

        mov     x9, x10
        b     bb4
        //bb4:

bb4:

        //  %r171 = phi i32 [ %r170, %bb2 ], [ %r176, %bb6 ]

        //  %r172 = add i32 %r171, 0

        mov     x9, x9
        //  br label %bb9


        //bb9:  %r173 = phi i32 [ %r172, %bb4 ], [ %r175, %bb12 ]

        mov     x9, x9
        b     bb9
        //bb9:

bb9:

        //  %r173 = phi i32 [ %r172, %bb4 ], [ %r175, %bb12 ]

        //  %r111 = icmp sgt i32 1, 0

        mov     x11, #1
        mov     x10, #0
        cmp     x11, x10
        //  br i1 %r111, label %bb10, label %bb11


        b.gt     bb10
        b     bb11
        //bb10:

bb10:

        //  %r112 = call i32 @getch()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r113 = load i32, i32* @ascii_0

        adrp     x10, ascii_0
        add     x10, x10, #:lo12:ascii_0
        ldr     x10, [x10]
        //  %r174 = sub i32 %r112, %r113

        sub     x11, x11, x10
        //  %r116 = icmp sge i32 %r174, 0

        mov     x10, #0
        cmp     x11, x10
        //  br i1 %r116, label %bb15, label %bb13


        b.ge     bb15
        b     bb13
        //bb15:

bb15:

        //  %r118 = icmp sle i32 %r174, 9

        mov     x10, #9
        cmp     x11, x10
        //  br i1 %r118, label %bb12, label %bb13


        b.le     bb12
        b     bb13
        //bb12:

bb12:

        //  %r120 = mul i32 %r173, 10

        mov     x10, #10
        mul     x9, x9, x10
        //  %r175 = add i32 %r120, %r174

        add     x9, x9, x11
        //  br label %bb9


        //bb9:  %r173 = phi i32 [ %r172, %bb4 ], [ %r175, %bb12 ]

        mov     x9, x9
        b     bb9
        //bb13:

bb13:

        //  br label %bb11


        b     bb11
        //bb11:

bb11:

        //  ret i32 %r173

        mov     x0, x9
        mov     sp, x29
        ret
        //%r124->x10
        //%r126->x11
        //%r178->x9
        //%r131->x11
        //%r133->x9
        //%r211->x9
        //%r134->x9
        //%r212->x9
        //%r177->x9
        //%r179->x10
        //%r180->x9
mod:

        //bb31:

bb31:

        //  %r177 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r179 = add i32 %r124, 0

        mov     x10, x10
        //  %r178 = add i32 0, 0

        mov     x9, #0
        //  %r180 = add i32 %r126, 0

        mov     x9, x11
        //  %r131 = sdiv i32 %r179, %r180

        sdiv     x11, x10, x9
        //  %r133 = mul i32 %r131, %r180

        mul     x9, x11, x9
        //  %r134 = sub i32 %r179, %r133

        sub     x9, x10, x9
        //  ret i32 %r134

        mov     x0, x9
        mov     sp, x29
        ret
        //%r224->x9
        //%r223->x11
        //%r221->x12
        //%r220->x13
        //%r219->x12
        //%r190->x9
        //%r218->x11
        //%r189->x10
        //%r217->x11
        //%r188->x11
        //%r216->x11
        //%r157->x9
        //%r187->x10
        //%r222->x12
        //%r135->x10
        //%r142->x12
        //%r181->x9
        //%r143->x11
        //%r182->x9
        //%r144->x11
        //%r183->x10
        //%r146->x12
        //%r214->x9
        //%r156->x9
        //%r215->x9
        //%r185->x10
        //%r213->x9
        //%r184->x9
        //%r186->x9
        //%r225->x9
        //%r226->x10
        //%r227->x9
        //%r228->x9
my_putint:

        //137:x29,#-128

        //bb32:

bb32:

        //  %r181 = add i32 0, 0

        mov     x16, #128
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r137 = alloca [ 16 x i32 ]

        //  %r182 = add i32 0, 0

        mov     x9, #0
        //  %r183 = add i32 %r135, 0

        mov     x10, x10
        //  %r184 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb18


        //bb18:  %r185 = phi i32 [ %r183, %bb32 ], [ %r189, %bb19 ]

        mov     x10, x10
        //bb18:  %r186 = phi i32 [ %r184, %bb32 ], [ %r190, %bb19 ]

        mov     x9, x9
        b     bb18
        //bb18:

bb18:

        //  %r185 = phi i32 [ %r183, %bb32 ], [ %r189, %bb19 ]

        //  %r186 = phi i32 [ %r184, %bb32 ], [ %r190, %bb19 ]

        //  %r140 = icmp sgt i32 %r185, 0

        mov     x11, #0
        cmp     x10, x11
        //  br i1 %r140, label %bb19, label %bb20


        b.gt     bb19
        b     bb20
        //bb19:

bb19:

        //  %r142 = call i32 @mod(i32 %r185, i32 10)

        mov     x0, x10
        mov     x11, #10
        mov     x1, x11
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
        mov     x12, x0
        //  %r143 = load i32, i32* @ascii_0

        adrp     x11, ascii_0
        add     x11, x11, #:lo12:ascii_0
        ldr     x11, [x11]
        //  %r144 = add i32 %r142, %r143

        add     x11, x12, x11
        //  %r146 = getelementptr [16 x i32 ], [16 x i32 ]* %r137, i32 0 , i32 %r186

        mov     x12, #8
        mul     x13, x9, x12
        mov     x12, #-128
        add     x12, x29, x12
        add     x12, x12, x13
        //  store i32 %r144, i32* %r146

        str     x11, [x12]
        //  %r189 = sdiv i32 %r185, 10

        mov     x11, #10
        sdiv     x10, x10, x11
        //  %r190 = add i32 %r186, 1

        add     x9, x9, #1
        //  br label %bb18


        //bb18:  %r185 = phi i32 [ %r183, %bb32 ], [ %r189, %bb19 ]

        mov     x10, x10
        //bb18:  %r186 = phi i32 [ %r184, %bb32 ], [ %r190, %bb19 ]

        mov     x9, x9
        b     bb18
        //bb20:

bb20:

        //  br label %bb21


        //bb21:  %r187 = phi i32 [ %r186, %bb20 ], [ %r188, %bb22 ]

        mov     x10, x9
        b     bb21
        //bb21:

bb21:

        //  %r187 = phi i32 [ %r186, %bb20 ], [ %r188, %bb22 ]

        //  %r152 = icmp sgt i32 %r187, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r152, label %bb22, label %bb23


        b.gt     bb22
        b     bb23
        //bb22:

bb22:

        //  %r188 = sub i32 %r187, 1

        sub     x11, x10, #1
        //  %r156 = getelementptr [16 x i32 ], [16 x i32 ]* %r137, i32 0 , i32 %r188

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r157 = load i32, i32* %r156

        ldr     x9, [x9]
        //  call void @putch(i32 %r157)

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
        //  br label %bb21


        //bb21:  %r187 = phi i32 [ %r186, %bb20 ], [ %r188, %bb22 ]

        mov     x10, x11
        b     bb21
        //bb23:

bb23:

        //  ret void

        mov     sp, x29
        ret
        //%r191->x9
        //%r230->x9
        //%r192->x9
        //%r231->x9
        //%r193->x9
        //%r232->x9
        //%r194->x10
        //%r233->x9
        //%r195->x9
        //%r234->x9
        //%r196->x9
        //%r235->x9
        //%r229->x9
main:

        //bb24:

bb24:

        //  %r191 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  call void @_sysy_starttime(i32 51)

        mov     x9, #51
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
        //  %r192 = add i32 0, 0

        mov     x9, #0
        //  %r193 = call i32 @my_getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     my_getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb25


        //bb25:  %r194 = phi i32 [ %r193, %bb24 ], [ %r196, %bb26 ]

        mov     x10, x9
        b     bb25
        //bb25:

bb25:

        //  %r194 = phi i32 [ %r193, %bb24 ], [ %r196, %bb26 ]

        //  %r161 = icmp sgt i32 %r194, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r161, label %bb26, label %bb27


        b.gt     bb26
        b     bb27
        //bb26:

bb26:

        //  %r195 = call i32 @my_getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     my_getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  call void @my_putint(i32 %r195)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     my_putint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 10)

        mov     x9, #10
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
        //  %r196 = sub i32 %r194, 1

        sub     x9, x10, #1
        //  br label %bb25


        //bb25:  %r194 = phi i32 [ %r193, %bb24 ], [ %r196, %bb26 ]

        mov     x10, x9
        b     bb25
        //bb27:

bb27:

        //  call void @_sysy_stoptime(i32 58)

        mov     x9, #58
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
