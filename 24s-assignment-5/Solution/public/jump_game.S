.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global canJump
.global main
        //%r217->x10
        //%r215->x10
        //%r214->x10
        //%r211->x10
        //%r210->x9
        //%r209->x9
        //%r208->x9
        //%r207->x9
        //%r205->x9
        //%r204->x9
        //%r203->x9
        //%r201->x9
        //%r200->x9
        //%r195->x9
        //%r193->x9
        //%r190->x10
        //%r189->x9
        //%r188->x11
        //%r194->x9
        //%r135->x9
        //%r106->x10
        //%r233->x9
        //%r192->x14
        //%r133->x10
        //%r162->x9
        //%r187->x9
        //%r128->x9
        //%r216->x9
        //%r157->x14
        //%r186->x10
        //%r196->x9
        //%r137->x9
        //%r108->x9
        //%r235->x14
        //%r212->x11
        //%r153->x9
        //%r182->x9
        //%r117->x11
        //%r191->x9
        //%r132->x9
        //%r105->x9
        //%r232->x9
        //%r163->x9
        //%r114->x10
        //%r241->x9
        //%r202->x9
        //%r143->x9
        //%r219->x9
        //%r101->x10
        //%r228->x9
        //%r218->x9
        //%r100->x13
        //%r227->x9
        //%r140->x9
        //%r206->x10
        //%r147->x9
        //%r213->x10
        //%r154->x14
        //%r124->x10
        //%r183->x12
        //%r179->x9
        //%r180->x9
        //%r181->x9
        //%r184->x9
        //%r185->x9
        //%r220->x9
        //%r221->x9
        //%r222->x9
        //%r223->x9
        //%r224->x9
        //%r225->x9
        //%r226->x9
        //%r229->x14
        //%r230->x14
        //%r231->x9
        //%r234->x14
        //%r236->x9
        //%r237->x10
        //%r238->x9
        //%r239->x10
        //%r240->x9
canJump:

        //110:x29,#-80

        //bb24:

bb24:

        //  %r179 = add i32 0, 0

        mov     x16, #80
        sub     sp, sp, x16
        mov     x13, x0
        mov     x10, x1
        mov     x9, #0
        //  %r180 = add i32 0, 0

        mov     x9, #0
        //  %r181 = add i32 0, 0

        mov     x9, #0
        //  %r110 = alloca [ 10 x i32 ]

        //  %r182 = add i32 0, 0

        mov     x9, #0
        //  %r183 = add i32 %r101, 0

        mov     x12, x10
        //  %r104 = icmp eq i32 %r183, 1

        mov     x9, #1
        cmp     x12, x9
        //  br i1 %r104, label %bb2, label %bb3


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

        //  %r105 = getelementptr i32, i32* %r100, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        //  %r106 = load i32, i32* %r105

        ldr     x10, [x9]
        //  %r108 = sub i32 %r183, 2

        sub     x9, x12, #2
        //  %r109 = icmp sgt i32 %r106, %r108

        cmp     x10, x9
        //  br i1 %r109, label %bb5, label %bb6


        b.gt     bb5
        b     bb6
        //bb5:

bb5:

        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //bb6:

bb6:

        //  %r184 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb8


        //bb8:  %r185 = phi i32 [ %r184, %bb6 ], [ %r196, %bb9 ]

        mov     x9, x9
        b     bb8
        //bb8:

bb8:

        //  %r185 = phi i32 [ %r184, %bb6 ], [ %r196, %bb9 ]

        //  %r114 = sub i32 %r183, 1

        sub     x10, x12, #1
        //  %r115 = icmp slt i32 %r185, %r114

        cmp     x9, x10
        //  br i1 %r115, label %bb9, label %bb10


        b.lt     bb9
        b     bb10
        //bb9:

bb9:

        //  %r117 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0 , i32 %r185

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x11, x10, x11
        //  store i32 0, i32* %r117

        mov     x10, #0
        str     x10, [x11]
        //  %r196 = add i32 %r185, 1

        add     x9, x9, #1
        //  br label %bb8


        //bb8:  %r185 = phi i32 [ %r184, %bb6 ], [ %r196, %bb9 ]

        mov     x9, x9
        b     bb8
        //bb10:

bb10:

        //  %r186 = sub i32 %r183, 1

        sub     x10, x12, #1
        //  %r124 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0 , i32 %r186

        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r124

        mov     x9, #1
        str     x9, [x10]
        //  %r187 = sub i32 %r183, 2

        sub     x9, x12, #2
        //  br label %bb11


        //bb11:  %r188 = phi i32 [ %r187, %bb10 ], [ %r191, %bb19 ]

        mov     x11, x9
        b     bb11
        //bb11:

bb11:

        //  %r188 = phi i32 [ %r187, %bb10 ], [ %r191, %bb19 ]

        //  %r128 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  %r129 = icmp sgt i32 %r188, %r128

        cmp     x11, x9
        //  br i1 %r129, label %bb12, label %bb13


        b.gt     bb12
        b     bb13
        //bb12:

bb12:

        //  %r132 = getelementptr i32, i32* %r100, i32 %r188

        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x13, x9
        //  %r133 = load i32, i32* %r132

        ldr     x10, [x9]
        //  %r135 = sub i32 %r183, 1

        sub     x9, x12, #1
        //  %r137 = sub i32 %r135, %r188

        sub     x9, x9, x11
        //  %r138 = icmp slt i32 %r133, %r137

        cmp     x10, x9
        //  br i1 %r138, label %bb14, label %bb15


        b.lt     bb14
        b     bb15
        //bb14:

bb14:

        //  %r140 = getelementptr i32, i32* %r100, i32 %r188

        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x13, x9
        //  %r195 = load i32, i32* %r140

        ldr     x9, [x9]
        //  br label %bb16


        //bb16:  %r189 = phi i32 [ %r195, %bb14 ], [ %r194, %bb15 ]

        mov     x9, x9
        b     bb16
        //bb15:

bb15:

        //  %r143 = sub i32 %r183, 1

        sub     x9, x12, #1
        //  %r194 = sub i32 %r143, %r188

        sub     x9, x9, x11
        //  br label %bb16


        //bb16:  %r189 = phi i32 [ %r195, %bb14 ], [ %r194, %bb15 ]

        mov     x9, x9
        b     bb16
        //bb16:

bb16:

        //  %r189 = phi i32 [ %r195, %bb14 ], [ %r194, %bb15 ]

        //  br label %bb17


        //bb17:  %r190 = phi i32 [ %r189, %bb16 ], [ %r193, %bb22 ]

        mov     x10, x9
        b     bb17
        //bb17:

bb17:

        //  %r190 = phi i32 [ %r189, %bb16 ], [ %r193, %bb22 ]

        //  %r147 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  %r148 = icmp sgt i32 %r190, %r147

        cmp     x10, x9
        //  br i1 %r148, label %bb18, label %bb19


        b.gt     bb18
        b     bb19
        //bb18:

bb18:

        //  %r192 = add i32 %r188, %r190

        add     x14, x11, x10
        //  %r153 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0 , i32 %r192

        mov     x9, #8
        mul     x9, x14, x9
        mov     x14, #-80
        add     x14, x29, x14
        add     x9, x14, x9
        //  %r154 = load i32, i32* %r153

        ldr     x14, [x9]
        //  %r155 = icmp ne i32 %r154, 0

        mov     x9, #0
        cmp     x14, x9
        //  br i1 %r155, label %bb20, label %bb21


        b.ne     bb20
        b     bb21
        //bb20:

bb20:

        //  %r157 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0 , i32 %r188

        mov     x9, #8
        mul     x9, x11, x9
        mov     x14, #-80
        add     x14, x29, x14
        add     x14, x14, x9
        //  store i32 1, i32* %r157

        mov     x9, #1
        str     x9, [x14]
        //  br label %bb22


        b     bb22
        //bb21:

bb21:

        //  br label %bb22


        b     bb22
        //bb22:

bb22:

        //  %r193 = sub i32 %r190, 1

        sub     x9, x10, #1
        //  br label %bb17


        //bb17:  %r190 = phi i32 [ %r189, %bb16 ], [ %r193, %bb22 ]

        mov     x10, x9
        b     bb17
        //bb19:

bb19:

        //  %r191 = sub i32 %r188, 1

        sub     x9, x11, #1
        //  br label %bb11


        //bb11:  %r188 = phi i32 [ %r187, %bb10 ], [ %r191, %bb19 ]

        mov     x11, x9
        b     bb11
        //bb13:

bb13:

        //  %r162 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r163 = load i32, i32* %r162

        ldr     x9, [x9]
        //  ret i32 %r163

        mov     x0, x9
        mov     sp, x29
        ret
        //%r283->x9
        //%r282->x10
        //%r281->x9
        //%r280->x10
        //%r279->x9
        //%r278->x9
        //%r277->x9
        //%r276->x10
        //%r275->x9
        //%r274->x10
        //%r273->x9
        //%r272->x9
        //%r271->x9
        //%r270->x10
        //%r269->x9
        //%r268->x10
        //%r267->x9
        //%r266->x9
        //%r265->x9
        //%r264->x10
        //%r263->x9
        //%r262->x10
        //%r261->x9
        //%r260->x9
        //%r259->x9
        //%r175->x10
        //%r302->x9
        //%r174->x10
        //%r301->x9
        //%r258->x10
        //%r199->x10
        //%r170->x10
        //%r297->x9
        //%r173->x10
        //%r300->x10
        //%r257->x9
        //%r198->x10
        //%r287->x9
        //%r169->x10
        //%r296->x9
        //%r172->x10
        //%r299->x9
        //%r256->x10
        //%r197->x9
        //%r286->x10
        //%r168->x10
        //%r295->x9
        //%r255->x9
        //%r171->x10
        //%r298->x10
        //%r285->x9
        //%r167->x10
        //%r294->x10
        //%r254->x9
        //%r284->x9
        //%r166->x10
        //%r293->x9
        //%r253->x9
        //%r242->x9
        //%r243->x9
        //%r244->x10
        //%r245->x9
        //%r246->x10
        //%r247->x9
        //%r248->x9
        //%r249->x9
        //%r250->x10
        //%r251->x9
        //%r252->x10
        //%r288->x10
        //%r289->x9
        //%r290->x9
        //%r291->x9
        //%r292->x10
        //%r303->x9
        //%r304->x9
        //%r305->x9
        //%r306->x9
        //%r307->x9
main:

        //165:x29,#-80

        //bb23:

bb23:

        //  call void @_sysy_starttime(i32 42)

        mov     x16, #80
        sub     sp, sp, x16
        mov     x9, #42
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
        //  %r197 = add i32 0, 0

        mov     x9, #0
        //  %r165 = alloca [ 10 x i32 ]

        //  %r166 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r166

        mov     x9, #3
        str     x9, [x10]
        //  %r167 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r167

        mov     x9, #3
        str     x9, [x10]
        //  %r168 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 9, i32* %r168

        mov     x9, #9
        str     x9, [x10]
        //  %r169 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r169

        mov     x9, #0
        str     x9, [x10]
        //  %r170 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r170

        mov     x9, #0
        str     x9, [x10]
        //  %r171 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 5

        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r171

        mov     x9, #1
        str     x9, [x10]
        //  %r172 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 6

        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r172

        mov     x9, #1
        str     x9, [x10]
        //  %r173 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 5, i32* %r173

        mov     x9, #5
        str     x9, [x10]
        //  %r174 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 8

        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r174

        mov     x9, #7
        str     x9, [x10]
        //  %r175 = getelementptr [10 x i32 ], [10 x i32 ]* %r165, i32 0 , i32 9

        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 8, i32* %r175

        mov     x9, #8
        str     x9, [x10]
        //  %r198 = add i32 10, 0

        mov     x9, #10
        mov     x10, x9
        //  %r199 = call i32 @canJump(i32* %r165, i32 %r198)

        mov     x9, #-80
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x10
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
        bl     canJump
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  call void @_sysy_stoptime(i32 49)

        mov     x9, #49
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
        //  ret i32 %r199

        mov     x0, x10
        mov     sp, x29
        ret
