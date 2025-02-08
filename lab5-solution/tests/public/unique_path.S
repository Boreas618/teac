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

        #%r222->x11

        #%r219->x9

        #%r216->x11

        #%r214->x11

        #%r213->x11

        #%r212->x11

        #%r205->x12

        #%r204->x9

        #%r203->x12

        #%r202->x9

        #%r201->x10

        #%r200->x9

        #%r199->x11

        #%r198->x9

        #%r197->x12

        #%r196->x9

        #%r195->x13

        #%r193->x9

        #%r192->x9

        #%r191->x9

        #%r217->x11

        #%r158->x10

        #%r218->x9

        #%r100->x10

        #%r227->x11

        #%r187->x9

        #%r151->x10

        #%r206->x9

        #%r147->x9

        #%r118->x11

        #%r245->x9

        #%r194->x9

        #%r135->x12

        #%r164->x9

        #%r215->x11

        #%r156->x10

        #%r185->x9

        #%r189->x14

        #%r130->x12

        #%r188->x10

        #%r211->x11

        #%r152->x9

        #%r181->x9

        #%r120->x11

        #%r247->x10

        #%r190->x9

        #%r131->x11

        #%r220->x9

        #%r102->x9

        #%r229->x11

        #%r161->x9

        #%r221->x9

        #%r162->x15

        #%r165->x9

        #%r166->x9

        #%r168->x10

        #%r173->x9

        #%r174->x9

        #%r123->x12

        #%r250->x10

        #%r182->x9

        #%r183->x9

        #%r184->x9

        #%r186->x9

        #%r223->x11

        #%r224->x12

        #%r225->x11

        #%r226->x11

        #%r228->x9

        #%r230->x11

        #%r231->x12

        #%r232->x11

        #%r233->x11

        #%r234->x11

        #%r235->x9

        #%r236->x9

        #%r237->x9

        #%r238->x9

        #%r239->x10

        #%r240->x15

        #%r241->x9

        #%r242->x15

        #%r243->x15

        #%r244->x9

        #%r246->x10

        #%r248->x10

        #%r249->x11

        #%r251->x10

        #%r252->x10

        #%r253->x9

        #%r254->x10

        #%r255->x9

        #%r256->x9
uniquePaths:


        #108:x29,#-36

        #bb19:
bb19:


        #  %r181 = add i32 0, 0
        mov     x16, #48
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, w1
        mov     w11, #0

        #  %r182 = add i32 0, 0
        mov     w11, #0

        #  %r183 = add i32 0, 0
        mov     w11, #0

        #  %r184 = add i32 0, 0
        mov     w11, #0

        #  %r185 = add i32 0, 0
        mov     w11, #0

        #  %r108 = alloca [ 9 x i32 ]

        #  %r186 = add i32 0, 0
        mov     w11, #0

        #  %r188 = add i32 %r100, 0
        mov     w10, w10

        #  %r187 = add i32 0, 0
        mov     w11, #0

        #  %r189 = add i32 %r102, 0
        mov     w14, w9

        #  br label %bb1

        b     bb1

        #bb1:
bb1:


        #  %r105 = icmp eq i32 %r188, 1
        mov     w9, #1
        cmp     w10, w9

        #  br i1 %r105, label %bb2, label %bb5

        b.eq     bb2
        b     bb5

        #bb5:
bb5:


        #  %r107 = icmp eq i32 %r189, 1
        mov     w9, #1
        cmp     w14, w9

        #  br i1 %r107, label %bb2, label %bb3

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


        #  %r190 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb6


        #bb6:  %r191 = phi i32 [ %r190, %bb4 ], [ %r206, %bb7 ]
        mov     w9, w9
        b     bb6

        #bb6:
bb6:


        #  %r191 = phi i32 [ %r190, %bb4 ], [ %r206, %bb7 ]

        #  %r116 = icmp slt i32 %r191, %r188
        cmp     w9, w10

        #  br i1 %r116, label %bb7, label %bb8

        b.lt     bb7
        b     bb8

        #bb7:
bb7:


        #  %r118 = mul i32 %r191, 3
        mov     w11, #3
        mul     w11, w9, w11

        #  %r120 = add i32 %r118, %r189
        add     w11, w11, w14

        #  %r205 = sub i32 %r120, 1
        sub     w12, w11, #1

        #  %r123 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r205
        mov     x11, #4
        mul     x12, x12, x11
        mov     x11, #-36
        add     x11, x29, x11
        add     x12, x11, x12

        #  store i32 1, i32* %r123
        mov     w11, #1
        str     w11, [x12]

        #  %r206 = add i32 %r191, 1
        add     w9, w9, #1

        #  br label %bb6


        #bb6:  %r191 = phi i32 [ %r190, %bb4 ], [ %r206, %bb7 ]
        mov     w9, w9
        b     bb6

        #bb8:
bb8:


        #  %r192 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb9


        #bb9:  %r193 = phi i32 [ %r192, %bb8 ], [ %r204, %bb10 ]
        mov     w9, w9
        b     bb9

        #bb9:
bb9:


        #  %r193 = phi i32 [ %r192, %bb8 ], [ %r204, %bb10 ]

        #  %r128 = icmp slt i32 %r193, %r189
        cmp     w9, w14

        #  br i1 %r128, label %bb10, label %bb11

        b.lt     bb10
        b     bb11

        #bb10:
bb10:


        #  %r130 = sub i32 %r188, 1
        sub     w12, w10, #1

        #  %r131 = mul i32 %r130, 3
        mov     w11, #3
        mul     w11, w12, w11

        #  %r203 = add i32 %r131, %r193
        add     w12, w11, w9

        #  %r135 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r203
        mov     x11, #4
        mul     x12, x12, x11
        mov     x11, #-36
        add     x11, x29, x11
        add     x12, x11, x12

        #  store i32 1, i32* %r135
        mov     w11, #1
        str     w11, [x12]

        #  %r204 = add i32 %r193, 1
        add     w9, w9, #1

        #  br label %bb9


        #bb9:  %r193 = phi i32 [ %r192, %bb8 ], [ %r204, %bb10 ]
        mov     w9, w9
        b     bb9

        #bb11:
bb11:


        #  %r194 = sub i32 %r188, 2
        sub     w9, w10, #2

        #  br label %bb12


        #bb12:  %r195 = phi i32 [ %r194, %bb11 ], [ %r198, %bb17 ]
        mov     w13, w9
        b     bb12

        #bb12:
bb12:


        #  %r195 = phi i32 [ %r194, %bb11 ], [ %r198, %bb17 ]

        #  %r141 = icmp sgt i32 %r195, -1
        mov     w9, #-1
        cmp     w13, w9

        #  br i1 %r141, label %bb13, label %bb14

        b.gt     bb13
        b     bb14

        #bb13:
bb13:


        #  %r196 = sub i32 %r189, 2
        sub     w9, w14, #2

        #  br label %bb15


        #bb15:  %r197 = phi i32 [ %r196, %bb13 ], [ %r202, %bb16 ]
        mov     w12, w9
        b     bb15

        #bb15:
bb15:


        #  %r197 = phi i32 [ %r196, %bb13 ], [ %r202, %bb16 ]

        #  %r145 = icmp sgt i32 %r197, -1
        mov     w9, #-1
        cmp     w12, w9

        #  br i1 %r145, label %bb16, label %bb17

        b.gt     bb16
        b     bb17

        #bb16:
bb16:


        #  %r147 = mul i32 %r195, 3
        mov     w9, #3
        mul     w9, w13, w9

        #  %r199 = add i32 %r147, %r197
        add     w11, w9, w12

        #  %r151 = add i32 %r195, 1
        add     w10, w13, #1

        #  %r152 = mul i32 %r151, 3
        mov     w9, #3
        mul     w9, w10, w9

        #  %r200 = add i32 %r152, %r197
        add     w9, w9, w12

        #  %r156 = mul i32 %r195, 3
        mov     w10, #3
        mul     w10, w13, w10

        #  %r158 = add i32 %r156, %r197
        add     w10, w10, w12

        #  %r201 = add i32 %r158, 1
        add     w10, w10, #1

        #  %r161 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r200
        mov     x15, #4
        mul     x9, x9, x15
        mov     x15, #-36
        add     x15, x29, x15
        add     x9, x15, x9

        #  %r162 = load i32, i32* %r161
        ldr     w15, [x9]

        #  %r164 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r201
        mov     x9, #4
        mul     x9, x10, x9
        mov     x10, #-36
        add     x10, x29, x10
        add     x9, x10, x9

        #  %r165 = load i32, i32* %r164
        ldr     w9, [x9]

        #  %r166 = add i32 %r162, %r165
        add     w9, w15, w9

        #  %r168 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r199
        mov     x10, #4
        mul     x11, x11, x10
        mov     x10, #-36
        add     x10, x29, x10
        add     x10, x10, x11

        #  store i32 %r166, i32* %r168
        str     w9, [x10]

        #  %r202 = sub i32 %r197, 1
        sub     w9, w12, #1

        #  br label %bb15


        #bb15:  %r197 = phi i32 [ %r196, %bb13 ], [ %r202, %bb16 ]
        mov     w12, w9
        b     bb15

        #bb17:
bb17:


        #  %r198 = sub i32 %r195, 1
        sub     w9, w13, #1

        #  br label %bb12


        #bb12:  %r195 = phi i32 [ %r194, %bb11 ], [ %r198, %bb17 ]
        mov     w13, w9
        b     bb12

        #bb14:
bb14:


        #  %r173 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-36
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r174 = load i32, i32* %r173
        ldr     w9, [x9]

        #  ret i32 %r174
        mov     w0, w9
        mov     sp, x29
        ret

        #%r207->x9

        #%r259->x9

        #%r208->x9

        #%r260->x9

        #%r209->x9

        #%r261->x9

        #%r210->x10

        #%r257->x9

        #%r258->x9
main:


        #bb18:
bb18:


        #  call void @_sysy_starttime(i32 40)
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #40
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

        #  %r207 = add i32 0, 0
        mov     w9, #0

        #  %r208 = add i32 0, 0
        mov     w9, #0

        #  %r209 = add i32 3, 0
        mov     w9, #3
        mov     w9, w9

        #  %r210 = call i32 @uniquePaths(i32 %r209, i32 %r209)
        mov     w0, w9
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     uniquePaths
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  call void @_sysy_stoptime(i32 45)
        mov     w9, #45
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

        #  ret i32 %r210
        mov     w0, w10
        mov     sp, x29
        ret
