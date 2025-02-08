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

        #%r217->x9

        #%r216->x9

        #%r215->x10

        #%r213->x10

        #%r212->x10

        #%r209->x10

        #%r208->x9

        #%r207->x9

        #%r206->x9

        #%r205->x9

        #%r204->x10

        #%r203->x9

        #%r202->x9

        #%r200->x9

        #%r199->x9

        #%r194->x9

        #%r192->x9

        #%r189->x9

        #%r188->x9

        #%r187->x9

        #%r136->x9

        #%r182->x9

        #%r117->x13

        #%r193->x9

        #%r134->x9

        #%r105->x9

        #%r232->x13

        #%r108->x9

        #%r235->x10

        #%r191->x9

        #%r132->x13

        #%r161->x9

        #%r106->x10

        #%r233->x13

        #%r190->x14

        #%r131->x9

        #%r114->x10

        #%r219->x9

        #%r160->x9

        #%r101->x10

        #%r228->x13

        #%r198->x9

        #%r139->x9

        #%r218->x9

        #%r100->x12

        #%r227->x13

        #%r201->x9

        #%r142->x9

        #%r210->x13

        #%r151->x13

        #%r180->x9

        #%r211->x10

        #%r152->x14

        #%r181->x11

        #%r214->x9

        #%r155->x14

        #%r184->x10

        #%r177->x9

        #%r178->x9

        #%r179->x9

        #%r124->x10

        #%r183->x9

        #%r185->x9

        #%r186->x10

        #%r220->x9

        #%r221->x9

        #%r222->x9

        #%r223->x9

        #%r224->x13

        #%r225->x13

        #%r226->x14

        #%r229->x13

        #%r230->x13

        #%r231->x14

        #%r234->x13

        #%r236->x9

        #%r237->x10

        #%r238->x9

        #%r239->x9
canJump:


        #110:x29,#-40

        #bb24:
bb24:


        #  %r177 = add i32 0, 0
        mov     x16, #48
        sub     sp, sp, x16
        mov     x12, x0
        mov     w10, w1
        mov     w9, #0

        #  %r178 = add i32 0, 0
        mov     w9, #0

        #  %r179 = add i32 0, 0
        mov     w9, #0

        #  %r110 = alloca [ 10 x i32 ]

        #  %r180 = add i32 0, 0
        mov     w9, #0

        #  %r181 = add i32 %r101, 0
        mov     w11, w10

        #  br label %bb1

        b     bb1

        #bb1:
bb1:


        #  %r104 = icmp eq i32 %r181, 1
        mov     w9, #1
        cmp     w11, w9

        #  br i1 %r104, label %bb2, label %bb3

        b.eq     bb2
        b     bb3

        #bb2:
bb2:


        #  ret i32 1
        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret

        #bb3:
bb3:


        #  br label %bb4

        b     bb4

        #bb4:
bb4:


        #  %r105 = getelementptr i32, i32* %r100, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x12, x9

        #  %r106 = load i32, i32* %r105
        ldr     w10, [x9]

        #  %r108 = sub i32 %r181, 2
        sub     w9, w11, #2

        #  %r109 = icmp sgt i32 %r106, %r108
        cmp     w10, w9

        #  br i1 %r109, label %bb5, label %bb6

        b.gt     bb5
        b     bb6

        #bb5:
bb5:


        #  ret i32 1
        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret

        #bb6:
bb6:


        #  br label %bb7

        b     bb7

        #bb7:
bb7:


        #  %r182 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb8


        #bb8:  %r183 = phi i32 [ %r182, %bb7 ], [ %r194, %bb9 ]
        mov     w9, w9
        b     bb8

        #bb8:
bb8:


        #  %r183 = phi i32 [ %r182, %bb7 ], [ %r194, %bb9 ]

        #  %r114 = sub i32 %r181, 1
        sub     w10, w11, #1

        #  %r115 = icmp slt i32 %r183, %r114
        cmp     w9, w10

        #  br i1 %r115, label %bb9, label %bb10

        b.lt     bb9
        b     bb10

        #bb9:
bb9:


        #  %r117 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 %r183
        mov     x10, #4
        mul     x13, x9, x10
        mov     x10, #-40
        add     x10, x29, x10
        add     x13, x10, x13

        #  store i32 0, i32* %r117
        mov     w10, #0
        str     w10, [x13]

        #  %r194 = add i32 %r183, 1
        add     w9, w9, #1

        #  br label %bb8


        #bb8:  %r183 = phi i32 [ %r182, %bb7 ], [ %r194, %bb9 ]
        mov     w9, w9
        b     bb8

        #bb10:
bb10:


        #  %r184 = sub i32 %r181, 1
        sub     w10, w11, #1

        #  %r124 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 %r184
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r124
        mov     w9, #1
        str     w9, [x10]

        #  %r185 = sub i32 %r181, 2
        sub     w9, w11, #2

        #  br label %bb11


        #bb11:  %r186 = phi i32 [ %r185, %bb10 ], [ %r189, %bb19 ]
        mov     w10, w9
        b     bb11

        #bb11:
bb11:


        #  %r186 = phi i32 [ %r185, %bb10 ], [ %r189, %bb19 ]

        #  %r128 = icmp sgt i32 %r186, -1
        mov     w9, #-1
        cmp     w10, w9

        #  br i1 %r128, label %bb12, label %bb13

        b.gt     bb12
        b     bb13

        #bb12:
bb12:


        #  %r131 = getelementptr i32, i32* %r100, i32 %r186
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x12, x9

        #  %r132 = load i32, i32* %r131
        ldr     w13, [x9]

        #  %r134 = sub i32 %r181, 1
        sub     w9, w11, #1

        #  %r136 = sub i32 %r134, %r186
        sub     w9, w9, w10

        #  %r137 = icmp slt i32 %r132, %r136
        cmp     w13, w9

        #  br i1 %r137, label %bb14, label %bb15

        b.lt     bb14
        b     bb15

        #bb14:
bb14:


        #  %r139 = getelementptr i32, i32* %r100, i32 %r186
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x12, x9

        #  %r193 = load i32, i32* %r139
        ldr     w9, [x9]

        #  br label %bb16


        #bb16:  %r187 = phi i32 [ %r193, %bb14 ], [ %r192, %bb15 ]
        mov     w9, w9
        b     bb16

        #bb15:
bb15:


        #  %r142 = sub i32 %r181, 1
        sub     w9, w11, #1

        #  %r192 = sub i32 %r142, %r186
        sub     w9, w9, w10

        #  br label %bb16


        #bb16:  %r187 = phi i32 [ %r193, %bb14 ], [ %r192, %bb15 ]
        mov     w9, w9
        b     bb16

        #bb16:
bb16:


        #  %r187 = phi i32 [ %r193, %bb14 ], [ %r192, %bb15 ]

        #  br label %bb17


        #bb17:  %r188 = phi i32 [ %r187, %bb16 ], [ %r191, %bb22 ]
        mov     w9, w9
        b     bb17

        #bb17:
bb17:


        #  %r188 = phi i32 [ %r187, %bb16 ], [ %r191, %bb22 ]

        #  %r146 = icmp sgt i32 %r188, -1
        mov     w13, #-1
        cmp     w9, w13

        #  br i1 %r146, label %bb18, label %bb19

        b.gt     bb18
        b     bb19

        #bb18:
bb18:


        #  %r190 = add i32 %r186, %r188
        add     w14, w10, w9

        #  %r151 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 %r190
        mov     x13, #4
        mul     x14, x14, x13
        mov     x13, #-40
        add     x13, x29, x13
        add     x13, x13, x14

        #  %r152 = load i32, i32* %r151
        ldr     w14, [x13]

        #  %r153 = icmp ne i32 %r152, 0
        mov     w13, #0
        cmp     w14, w13

        #  br i1 %r153, label %bb20, label %bb21

        b.ne     bb20
        b     bb21

        #bb20:
bb20:


        #  %r155 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 %r186
        mov     x13, #4
        mul     x14, x10, x13
        mov     x13, #-40
        add     x13, x29, x13
        add     x14, x13, x14

        #  store i32 1, i32* %r155
        mov     w13, #1
        str     w13, [x14]

        #  br label %bb22

        b     bb22

        #bb21:
bb21:


        #  br label %bb22

        b     bb22

        #bb22:
bb22:


        #  %r191 = sub i32 %r188, 1
        sub     w9, w9, #1

        #  br label %bb17


        #bb17:  %r188 = phi i32 [ %r187, %bb16 ], [ %r191, %bb22 ]
        mov     w9, w9
        b     bb17

        #bb19:
bb19:


        #  %r189 = sub i32 %r186, 1
        sub     w9, w10, #1

        #  br label %bb11


        #bb11:  %r186 = phi i32 [ %r185, %bb10 ], [ %r189, %bb19 ]
        mov     w10, w9
        b     bb11

        #bb13:
bb13:


        #  %r160 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r161 = load i32, i32* %r160
        ldr     w9, [x9]

        #  ret i32 %r161
        mov     w0, w9
        mov     sp, x29
        ret

        #%r281->x9

        #%r280->x10

        #%r279->x9

        #%r278->x10

        #%r277->x9

        #%r276->x9

        #%r275->x9

        #%r274->x10

        #%r273->x9

        #%r272->x10

        #%r271->x9

        #%r270->x9

        #%r269->x9

        #%r268->x10

        #%r267->x9

        #%r266->x10

        #%r265->x9

        #%r264->x9

        #%r263->x9

        #%r262->x10

        #%r261->x9

        #%r260->x10

        #%r259->x9

        #%r258->x9

        #%r257->x9

        #%r173->x10

        #%r300->x9

        #%r172->x10

        #%r299->x9

        #%r256->x10

        #%r197->x10

        #%r168->x10

        #%r295->x9

        #%r171->x10

        #%r298->x10

        #%r255->x9

        #%r196->x10

        #%r285->x9

        #%r167->x10

        #%r294->x9

        #%r170->x10

        #%r297->x9

        #%r254->x10

        #%r195->x9

        #%r284->x10

        #%r166->x10

        #%r293->x9

        #%r253->x9

        #%r169->x10

        #%r296->x10

        #%r283->x9

        #%r165->x10

        #%r292->x10

        #%r252->x9

        #%r282->x9

        #%r164->x10

        #%r291->x9

        #%r251->x9

        #%r240->x9

        #%r241->x9

        #%r242->x10

        #%r243->x9

        #%r244->x10

        #%r245->x9

        #%r246->x9

        #%r247->x9

        #%r248->x10

        #%r249->x9

        #%r250->x10

        #%r286->x10

        #%r287->x9

        #%r288->x9

        #%r289->x9

        #%r290->x10

        #%r301->x9

        #%r302->x9

        #%r303->x9

        #%r304->x9

        #%r305->x9
main:


        #163:x29,#-40

        #bb23:
bb23:


        #  call void @_sysy_starttime(i32 42)
        mov     x16, #48
        sub     sp, sp, x16
        mov     w9, #42
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

        #  %r195 = add i32 0, 0
        mov     w9, #0

        #  %r163 = alloca [ 10 x i32 ]

        #  %r164 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 3, i32* %r164
        mov     w9, #3
        str     w9, [x10]

        #  %r165 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 1
        mov     x10, #1
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 3, i32* %r165
        mov     w9, #3
        str     w9, [x10]

        #  %r166 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 2
        mov     x10, #2
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 9, i32* %r166
        mov     w9, #9
        str     w9, [x10]

        #  %r167 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 3
        mov     x10, #3
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 0, i32* %r167
        mov     w9, #0
        str     w9, [x10]

        #  %r168 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 4
        mov     x10, #4
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 0, i32* %r168
        mov     w9, #0
        str     w9, [x10]

        #  %r169 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 5
        mov     x10, #5
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r169
        mov     w9, #1
        str     w9, [x10]

        #  %r170 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 6
        mov     x10, #6
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r170
        mov     w9, #1
        str     w9, [x10]

        #  %r171 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 7
        mov     x10, #7
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 5, i32* %r171
        mov     w9, #5
        str     w9, [x10]

        #  %r172 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 8
        mov     x10, #8
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 7, i32* %r172
        mov     w9, #7
        str     w9, [x10]

        #  %r173 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 9
        mov     x10, #9
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 8, i32* %r173
        mov     w9, #8
        str     w9, [x10]

        #  %r196 = add i32 10, 0
        mov     w9, #10
        mov     w10, w9

        #  %r197 = call i32 @canJump(i32* %r163, i32 %r196)
        mov     x9, #-40
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     canJump
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  call void @_sysy_stoptime(i32 49)
        mov     w9, #49
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

        #  ret i32 %r197
        mov     w0, w10
        mov     sp, x29
        ret
