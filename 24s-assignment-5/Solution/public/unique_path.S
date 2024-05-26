.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global uniquePaths
.global main
        //%r221->x9
        //%r216->x11
        //%r215->x11
        //%r214->x11
        //%r207->x12
        //%r206->x9
        //%r204->x9
        //%r203->x11
        //%r202->x10
        //%r201->x12
        //%r199->x13
        //%r198->x9
        //%r197->x14
        //%r196->x9
        //%r195->x9
        //%r193->x9
        //%r192->x9
        //%r191->[sp,#8]
        //%r153->x10
        //%r194->x9
        //%r135->x12
        //%r164->[sp,#0]
        //%r189->x9
        //%r130->x12
        //%r257->x9
        //%r188->x9
        //%r208->x9
        //%r149->x9
        //%r120->x11
        //%r247->x10
        //%r123->x12
        //%r250->x9
        //%r205->x12
        //%r146->x9
        //%r175->x9
        //%r190->x10
        //%r131->x11
        //%r258->x9
        //%r220->x9
        //%r102->x9
        //%r229->x11
        //%r219->x11
        //%r160->x9
        //%r118->x11
        //%r245->x9
        //%r176->x9
        //%r213->x11
        //%r154->x9
        //%r183->x9
        //%r200->x9
        //%r141->x9
        //%r170->x9
        //%r218->x11
        //%r100->x10
        //%r227->x11
        //%r217->x11
        //%r158->x9
        //%r187->x9
        //%r222->x9
        //%r163->x9
        //%r166->x9
        //%r167->x9
        //%r168->x10
        //%r184->x9
        //%r185->x9
        //%r186->x9
        //%r223->x9
        //%r224->x11
        //%r225->x11
        //%r226->x12
        //%r228->x11
        //%r230->x9
        //%r231->x11
        //%r232->x11
        //%r233->x12
        //%r234->x11
        //%r235->x11
        //%r236->x11
        //%r237->x9
        //%r238->x9
        //%r239->x9
        //%r240->x9
        //%r241->x9
        //%r242->x9
        //%r243->x10
        //%r244->x9
        //%r246->x9
        //%r248->x9
        //%r249->x9
        //%r251->x9
        //%r252->x11
        //%r253->x11
        //%r254->x10
        //%r255->x9
        //%r256->x10
uniquePaths:

        //108:x29,#-72

        //bb19:

bb19:

        //  %r183 = add i32 0, 0

        mov     x16, #96
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, x1
        mov     x11, #0
        //  %r184 = add i32 0, 0

        mov     x11, #0
        //  %r185 = add i32 0, 0

        mov     x11, #0
        //  %r186 = add i32 0, 0

        mov     x11, #0
        //  %r187 = add i32 0, 0

        mov     x11, #0
        //  %r108 = alloca [ 9 x i32 ]

        //  %r188 = add i32 0, 0

        mov     x11, #0
        //  %r190 = add i32 %r100, 0

        mov     x10, x10
        //  %r189 = add i32 0, 0

        mov     x11, #0
        //  %r191 = add i32 %r102, 0

        mov     x16, x9
        mov     x17, #8
        str     x16, [sp,x17]
        //  %r105 = icmp eq i32 %r190, 1

        mov     x9, #1
        cmp     x10, x9
        //  br i1 %r105, label %bb2, label %bb5


        b.eq     bb2
        b     bb5
        //bb5:

bb5:

        //  %r107 = icmp eq i32 %r191, 1

        mov     x9, #1
        mov     x16, #8
        ldr     x19, [sp,x16]
        cmp     x19, x9
        //  br i1 %r107, label %bb2, label %bb3


        b.eq     bb2
        b     bb3
        //bb2:

bb2:

        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //bb3:

bb3:

        //  %r192 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb6


        //bb6:  %r193 = phi i32 [ %r192, %bb3 ], [ %r208, %bb7 ]

        mov     x9, x9
        b     bb6
        //bb6:

bb6:

        //  %r193 = phi i32 [ %r192, %bb3 ], [ %r208, %bb7 ]

        //  %r116 = icmp slt i32 %r193, %r190

        cmp     x9, x10
        //  br i1 %r116, label %bb7, label %bb8


        b.lt     bb7
        b     bb8
        //bb7:

bb7:

        //  %r118 = mul i32 %r193, 3

        mov     x11, #3
        mul     x11, x9, x11
        //  %r120 = add i32 %r118, %r191

        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x11, x11, x19
        //  %r207 = sub i32 %r120, 1

        sub     x12, x11, #1
        //  %r123 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0 , i32 %r207

        mov     x11, #8
        mul     x12, x12, x11
        mov     x11, #-72
        add     x11, x29, x11
        add     x12, x11, x12
        //  store i32 1, i32* %r123

        mov     x11, #1
        str     x11, [x12]
        //  %r208 = add i32 %r193, 1

        add     x9, x9, #1
        //  br label %bb6


        //bb6:  %r193 = phi i32 [ %r192, %bb3 ], [ %r208, %bb7 ]

        mov     x9, x9
        b     bb6
        //bb8:

bb8:

        //  %r194 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb9


        //bb9:  %r195 = phi i32 [ %r194, %bb8 ], [ %r206, %bb10 ]

        mov     x9, x9
        b     bb9
        //bb9:

bb9:

        //  %r195 = phi i32 [ %r194, %bb8 ], [ %r206, %bb10 ]

        //  %r128 = icmp slt i32 %r195, %r191

        mov     x16, #8
        ldr     x19, [sp,x16]
        cmp     x9, x19
        //  br i1 %r128, label %bb10, label %bb11


        b.lt     bb10
        b     bb11
        //bb10:

bb10:

        //  %r130 = sub i32 %r190, 1

        sub     x12, x10, #1
        //  %r131 = mul i32 %r130, 3

        mov     x11, #3
        mul     x11, x12, x11
        //  %r205 = add i32 %r131, %r195

        add     x12, x11, x9
        //  %r135 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0 , i32 %r205

        mov     x11, #8
        mul     x12, x12, x11
        mov     x11, #-72
        add     x11, x29, x11
        add     x12, x11, x12
        //  store i32 1, i32* %r135

        mov     x11, #1
        str     x11, [x12]
        //  %r206 = add i32 %r195, 1

        add     x9, x9, #1
        //  br label %bb9


        //bb9:  %r195 = phi i32 [ %r194, %bb8 ], [ %r206, %bb10 ]

        mov     x9, x9
        b     bb9
        //bb11:

bb11:

        //  %r196 = sub i32 %r190, 2

        sub     x9, x10, #2
        //  br label %bb12


        //bb12:  %r197 = phi i32 [ %r196, %bb11 ], [ %r200, %bb17 ]

        mov     x14, x9
        b     bb12
        //bb12:

bb12:

        //  %r197 = phi i32 [ %r196, %bb11 ], [ %r200, %bb17 ]

        //  %r141 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  %r142 = icmp sgt i32 %r197, %r141

        cmp     x14, x9
        //  br i1 %r142, label %bb13, label %bb14


        b.gt     bb13
        b     bb14
        //bb13:

bb13:

        //  %r198 = sub i32 %r191, 2

        mov     x16, #8
        ldr     x19, [sp,x16]
        sub     x9, x19, #2
        //  br label %bb15


        //bb15:  %r199 = phi i32 [ %r198, %bb13 ], [ %r204, %bb16 ]

        mov     x13, x9
        b     bb15
        //bb15:

bb15:

        //  %r199 = phi i32 [ %r198, %bb13 ], [ %r204, %bb16 ]

        //  %r146 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  %r147 = icmp sgt i32 %r199, %r146

        cmp     x13, x9
        //  br i1 %r147, label %bb16, label %bb17


        b.gt     bb16
        b     bb17
        //bb16:

bb16:

        //  %r149 = mul i32 %r197, 3

        mov     x9, #3
        mul     x9, x14, x9
        //  %r201 = add i32 %r149, %r199

        add     x12, x9, x13
        //  %r153 = add i32 %r197, 1

        add     x10, x14, #1
        //  %r154 = mul i32 %r153, 3

        mov     x9, #3
        mul     x9, x10, x9
        //  %r202 = add i32 %r154, %r199

        add     x10, x9, x13
        //  %r158 = mul i32 %r197, 3

        mov     x9, #3
        mul     x9, x14, x9
        //  %r160 = add i32 %r158, %r199

        add     x9, x9, x13
        //  %r203 = add i32 %r160, 1

        add     x11, x9, #1
        //  %r163 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0 , i32 %r202

        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-72
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r164 = load i32, i32* %r163

        ldr     x16, [x9]
        mov     x17, #0
        str     x16, [sp,x17]
        //  %r166 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0 , i32 %r203

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-72
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r167 = load i32, i32* %r166

        ldr     x9, [x9]
        //  %r168 = add i32 %r164, %r167

        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x10, x19, x9
        //  %r170 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0 , i32 %r201

        mov     x9, #8
        mul     x9, x12, x9
        mov     x11, #-72
        add     x11, x29, x11
        add     x9, x11, x9
        //  store i32 %r168, i32* %r170

        str     x10, [x9]
        //  %r204 = sub i32 %r199, 1

        sub     x9, x13, #1
        //  br label %bb15


        //bb15:  %r199 = phi i32 [ %r198, %bb13 ], [ %r204, %bb16 ]

        mov     x13, x9
        b     bb15
        //bb17:

bb17:

        //  %r200 = sub i32 %r197, 1

        sub     x9, x14, #1
        //  br label %bb12


        //bb12:  %r197 = phi i32 [ %r196, %bb11 ], [ %r200, %bb17 ]

        mov     x14, x9
        b     bb12
        //bb14:

bb14:

        //  %r175 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-72
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r176 = load i32, i32* %r175

        ldr     x9, [x9]
        //  ret i32 %r176

        mov     x0, x9
        mov     sp, x29
        ret
        //%r209->x9
        //%r261->x9
        //%r210->x9
        //%r262->x9
        //%r211->x9
        //%r263->x9
        //%r212->x10
        //%r259->x9
        //%r260->x9
main:

        //bb18:

bb18:

        //  call void @_sysy_starttime(i32 40)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #40
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
        //  %r209 = add i32 0, 0

        mov     x9, #0
        //  %r210 = add i32 0, 0

        mov     x9, #0
        //  %r211 = add i32 3, 0

        mov     x9, #3
        mov     x9, x9
        //  %r212 = call i32 @uniquePaths(i32 %r211, i32 %r211)

        mov     x0, x9
        mov     x1, x9
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
        bl     uniquePaths
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  call void @_sysy_stoptime(i32 45)

        mov     x9, #45
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
        //  ret i32 %r212

        mov     x0, x10
        mov     sp, x29
        ret
