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
        //%r200->x9
        //%r199->x13
        //%r198->x13
        //%r195->x9
        //%r194->x9
        //%r193->x9
        //%r191->x10
        //%r190->x11
        //%r189->x10
        //%r188->x10
        //%r187->x9
        //%r186->x9
        //%r185->x9
        //%r182->x9
        //%r181->x9
        //%r179->x9
        //%r178->x9
        //%r177->x9
        //%r176->x11
        //%r175->x10
        //%r174->x10
        //%r173->x11
        //%r172->x9
        //%r171->x9
        //%r154->x9
        //%r184->x9
        //%r125->x13
        //%r153->x9
        //%r183->x9
        //%r124->x13
        //%r152->x9
        //%r146->x9
        //%r192->x10
        //%r133->x13
        //%r162->x9
        //%r197->x14
        //%r138->x13
        //%r196->x13
        //%r137->x13
        //%r167->x11
        //%r108->x10
        //%r166->x9
        //%r147->x9
        //%r180->x9
        //%r121->x13
        //%r164->x11
        //%r155->x9
        //%r156->x9
        //%r157->x9
        //%r158->x9
        //%r159->x9
        //%r160->x9
        //%r161->x9
        //%r163->x12
        //%r106->x12
        //%r165->x10
        //%r168->x10
        //%r169->x9
        //%r170->x9
        //%r201->x13
        //%r202->x14
        //%r203->x13
        //%r204->x13
        //%r205->x10
        //%r206->x10
        //%r207->x9
        //%r208->x9
        //%r209->x9
        //%r210->x9
        //%r211->x9
        //%r212->x9
main:

        //102:x29,#-80

        //bb1:

bb1:

        //  %r152 = add i32 0, 0

        mov     x16, #80
        sub     sp, sp, x16
        mov     x9, #0
        //  %r153 = add i32 0, 0

        mov     x9, #0
        //  %r154 = add i32 0, 0

        mov     x9, #0
        //  %r155 = add i32 0, 0

        mov     x9, #0
        //  %r156 = add i32 0, 0

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
        //  %r157 = add i32 0, 0

        mov     x9, #0
        //  %r158 = add i32 0, 0

        mov     x9, #0
        //  %r102 = alloca [ 10 x i32 ]

        //  %r159 = add i32 0, 0

        mov     x9, #0
        //  %r160 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r161 = phi i32 [ %r160, %bb1 ], [ %r177, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb2:

bb2:

        //  %r161 = phi i32 [ %r160, %bb1 ], [ %r177, %bb3 ]

        //  %r104 = icmp slt i32 %r161, 10

        mov     x10, #10
        cmp     x9, x10
        //  br i1 %r104, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r106 = add i32 %r161, 1

        add     x12, x9, #1
        //  %r108 = getelementptr [10 x i32 ], [10 x i32 ]* %r102, i32 0 , i32 %r161

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r106, i32* %r108

        str     x12, [x10]
        //  %r177 = add i32 %r161, 1

        add     x9, x9, #1
        //  br label %bb2


        //bb2:  %r161 = phi i32 [ %r160, %bb1 ], [ %r177, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb4:

bb4:

        //  %r162 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  %r163 = call i32 @getint()

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
        //  %r164 = sub i32 %r162, 1

        sub     x11, x9, #1
        //  %r165 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r121 = add i32 %r164, %r165

        add     x13, x11, x10
        //  %r166 = sdiv i32 %r121, 2

        mov     x9, #2
        sdiv     x9, x13, x9
        //  br label %bb5


        //bb5:  %r167 = phi i32 [ %r164, %bb4 ], [ %r173, %bb11 ]

        mov     x11, x11
        //bb5:  %r168 = phi i32 [ %r165, %bb4 ], [ %r174, %bb11 ]

        mov     x10, x10
        //bb5:  %r169 = phi i32 [ %r166, %bb4 ], [ %r172, %bb11 ]

        mov     x9, x9
        b     bb5
        //bb5:

bb5:

        //  %r167 = phi i32 [ %r164, %bb4 ], [ %r173, %bb11 ]

        //  %r168 = phi i32 [ %r165, %bb4 ], [ %r174, %bb11 ]

        //  %r169 = phi i32 [ %r166, %bb4 ], [ %r172, %bb11 ]

        //  %r124 = getelementptr [10 x i32 ], [10 x i32 ]* %r102, i32 0 , i32 %r169

        mov     x13, #8
        mul     x14, x9, x13
        mov     x13, #-80
        add     x13, x29, x13
        add     x13, x13, x14
        //  %r125 = load i32, i32* %r124

        ldr     x13, [x13]
        //  %r127 = icmp ne i32 %r125, %r163

        cmp     x13, x12
        //  br i1 %r127, label %bb8, label %bb7


        b.ne     bb8
        b     bb7
        //bb8:

bb8:

        //  %r130 = icmp slt i32 %r168, %r167

        cmp     x10, x11
        //  br i1 %r130, label %bb6, label %bb7


        b.lt     bb6
        b     bb7
        //bb6:

bb6:

        //  %r133 = add i32 %r167, %r168

        add     x13, x11, x10
        //  %r172 = sdiv i32 %r133, 2

        mov     x9, #2
        sdiv     x9, x13, x9
        //  %r137 = getelementptr [10 x i32 ], [10 x i32 ]* %r102, i32 0 , i32 %r172

        mov     x13, #8
        mul     x14, x9, x13
        mov     x13, #-80
        add     x13, x29, x13
        add     x13, x13, x14
        //  %r138 = load i32, i32* %r137

        ldr     x13, [x13]
        //  %r139 = icmp slt i32 %r163, %r138

        cmp     x12, x13
        //  br i1 %r139, label %bb9, label %bb10


        b.lt     bb9
        b     bb10
        //bb9:

bb9:

        //  %r176 = sub i32 %r172, 1

        sub     x11, x9, #1
        //  br label %bb11


        //bb11:  %r173 = phi i32 [ %r176, %bb9 ], [ %r167, %bb10 ]

        mov     x11, x11
        //bb11:  %r174 = phi i32 [ %r168, %bb9 ], [ %r175, %bb10 ]

        mov     x10, x10
        b     bb11
        //bb10:

bb10:

        //  %r175 = add i32 %r172, 1

        add     x10, x9, #1
        //  br label %bb11


        //bb11:  %r173 = phi i32 [ %r176, %bb9 ], [ %r167, %bb10 ]

        mov     x11, x11
        //bb11:  %r174 = phi i32 [ %r168, %bb9 ], [ %r175, %bb10 ]

        mov     x10, x10
        b     bb11
        //bb11:

bb11:

        //  %r173 = phi i32 [ %r176, %bb9 ], [ %r167, %bb10 ]

        //  %r174 = phi i32 [ %r168, %bb9 ], [ %r175, %bb10 ]

        //  br label %bb5


        //bb5:  %r167 = phi i32 [ %r164, %bb4 ], [ %r173, %bb11 ]

        mov     x11, x11
        //bb5:  %r168 = phi i32 [ %r165, %bb4 ], [ %r174, %bb11 ]

        mov     x10, x10
        //bb5:  %r169 = phi i32 [ %r166, %bb4 ], [ %r172, %bb11 ]

        mov     x9, x9
        b     bb5
        //bb7:

bb7:

        //  %r146 = getelementptr [10 x i32 ], [10 x i32 ]* %r102, i32 0 , i32 %r169

        mov     x10, #8
        mul     x10, x9, x10
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r147 = load i32, i32* %r146

        ldr     x9, [x9]
        //  %r148 = icmp eq i32 %r163, %r147

        cmp     x12, x9
        //  br i1 %r148, label %bb12, label %bb13


        b.eq     bb12
        b     bb13
        //bb12:

bb12:

        //  call void @putint(i32 %r163)

        mov     x0, x12
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

        //  %r171 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  call void @putint(i32 %r171)

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

        //  %r170 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  call void @putch(i32 %r170)

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
        //  call void @_sysy_stoptime(i32 49)

        mov     x9, #49
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
