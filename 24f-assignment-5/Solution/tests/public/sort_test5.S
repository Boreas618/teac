.section .data
.global    n
n:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global swap
.global heap_ajust
.global heap_sort
.global main

        #%r222->x10

        #%r221->x11

        #%r219->x9

        #%r103->x10

        #%r277->x9

        #%r111->x12

        #%r110->x12

        #%r107->x9

        #%r223->x9

        #%r220->x9

        #%r116->x10

        #%r218->x9

        #%r276->x10

        #%r101->x11

        #%r275->x11

        #%r113->x11

        #%r100->x13

        #%r274->x11

        #%r266->x9

        #%r267->x9

        #%r268->x9

        #%r269->x9

        #%r270->x9

        #%r271->x12

        #%r272->x12

        #%r273->x14
swap:


        #bb24:
bb24:


        #  %r218 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     w11, w1
        mov     w10, w2
        mov     w9, #0

        #  %r219 = add i32 0, 0
        mov     w9, #0

        #  %r221 = add i32 %r101, 0
        mov     w11, w11

        #  %r220 = add i32 0, 0
        mov     w9, #0

        #  %r222 = add i32 %r103, 0
        mov     w10, w10

        #  br label %bb1

        b     bb1

        #bb1:
bb1:


        #  %r107 = getelementptr i32, i32* %r100, i32 %r221
        mov     x9, #4
        mul     x9, x11, x9
        add     x9, x13, x9

        #  %r223 = load i32, i32* %r107
        ldr     w9, [x9]

        #  %r110 = getelementptr i32, i32* %r100, i32 %r222
        mov     x12, #4
        mul     x12, x10, x12
        add     x12, x13, x12

        #  %r111 = load i32, i32* %r110
        ldr     w12, [x12]

        #  %r113 = getelementptr i32, i32* %r100, i32 %r221
        mov     x14, #4
        mul     x11, x11, x14
        add     x11, x13, x11

        #  store i32 %r111, i32* %r113
        str     w12, [x11]

        #  %r116 = getelementptr i32, i32* %r100, i32 %r222
        mov     x11, #4
        mul     x10, x10, x11
        add     x10, x13, x10

        #  store i32 %r223, i32* %r116
        str     w9, [x10]

        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r237->x9

        #%r232->x9

        #%r291->x13

        #%r231->x10

        #%r290->x13

        #%r228->x9

        #%r287->x9

        #%r225->x9

        #%r284->x13

        #%r224->x9

        #%r283->x9

        #%r233->x11

        #%r292->x9

        #%r117->x14

        #%r235->x9

        #%r294->x9

        #%r159->x9

        #%r130->x9

        #%r230->x12

        #%r289->x10

        #%r143->x9

        #%r234->x10

        #%r293->x9

        #%r118->x11

        #%r236->x9

        #%r126->x9

        #%r226->x9

        #%r285->x13

        #%r139->x13

        #%r152->x13

        #%r227->x9

        #%r286->x15

        #%r140->x13

        #%r229->x11

        #%r288->x10

        #%r142->x9

        #%r148->x10

        #%r120->x9

        #%r238->x10

        #%r149->x10

        #%r151->x13

        #%r239->x9

        #%r240->x9

        #%r278->x10

        #%r279->x10

        #%r280->x10

        #%r281->x10

        #%r282->x10
heap_ajust:


        #bb25:
bb25:


        #  %r224 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x14, x0
        mov     w11, w1
        mov     w9, w2
        mov     w10, #0

        #  %r225 = add i32 0, 0
        mov     w10, #0

        #  %r226 = add i32 0, 0
        mov     w10, #0

        #  %r227 = add i32 0, 0
        mov     w10, #0

        #  %r229 = add i32 %r118, 0
        mov     w11, w11

        #  %r228 = add i32 0, 0
        mov     w10, #0

        #  %r230 = add i32 %r120, 0
        mov     w12, w9

        #  br label %bb2

        b     bb2

        #bb2:
bb2:


        #  %r231 = add i32 %r229, 0
        mov     w10, w11

        #  %r126 = mul i32 %r231, 2
        mov     w9, #2
        mul     w9, w10, w9

        #  %r232 = add i32 %r126, 1
        add     w9, w9, #1

        #  br label %bb3


        #bb3:  %r233 = phi i32 [ %r231, %bb2 ], [ %r238, %bb12 ]
        mov     w11, w10

        #bb3:  %r234 = phi i32 [ %r232, %bb2 ], [ %r239, %bb12 ]
        mov     w10, w9
        b     bb3

        #bb3:
bb3:


        #  %r233 = phi i32 [ %r231, %bb2 ], [ %r238, %bb12 ]

        #  %r234 = phi i32 [ %r232, %bb2 ], [ %r239, %bb12 ]

        #  %r130 = add i32 %r230, 1
        add     w9, w12, #1

        #  %r131 = icmp slt i32 %r234, %r130
        cmp     w10, w9

        #  br i1 %r131, label %bb4, label %bb5

        b.lt     bb4
        b     bb5

        #bb4:
bb4:


        #  %r235 = add i32 %r234, 1
        add     w9, w10, #1

        #  %r137 = icmp slt i32 %r234, %r230
        cmp     w10, w12

        #  br i1 %r137, label %bb9, label %bb7

        b.lt     bb9
        b     bb7

        #bb9:
bb9:


        #  %r139 = getelementptr i32, i32* %r117, i32 %r234
        mov     x13, #4
        mul     x13, x10, x13
        add     x13, x14, x13

        #  %r140 = load i32, i32* %r139
        ldr     w13, [x13]

        #  %r142 = getelementptr i32, i32* %r117, i32 %r235
        mov     x15, #4
        mul     x9, x9, x15
        add     x9, x14, x9

        #  %r143 = load i32, i32* %r142
        ldr     w9, [x9]

        #  %r144 = icmp slt i32 %r140, %r143
        cmp     w13, w9

        #  br i1 %r144, label %bb6, label %bb7

        b.lt     bb6
        b     bb7

        #bb6:
bb6:


        #  %r240 = add i32 %r234, 1
        add     w9, w10, #1

        #  br label %bb8


        #bb8:  %r236 = phi i32 [ %r240, %bb6 ], [ %r234, %bb7 ]
        mov     w9, w9
        b     bb8

        #bb7:
bb7:


        #  br label %bb8


        #bb8:  %r236 = phi i32 [ %r240, %bb6 ], [ %r234, %bb7 ]
        mov     w9, w10
        b     bb8

        #bb8:
bb8:


        #  %r236 = phi i32 [ %r240, %bb6 ], [ %r234, %bb7 ]

        #  %r148 = getelementptr i32, i32* %r117, i32 %r233
        mov     x10, #4
        mul     x10, x11, x10
        add     x10, x14, x10

        #  %r149 = load i32, i32* %r148
        ldr     w10, [x10]

        #  %r151 = getelementptr i32, i32* %r117, i32 %r236
        mov     x13, #4
        mul     x13, x9, x13
        add     x13, x14, x13

        #  %r152 = load i32, i32* %r151
        ldr     w13, [x13]

        #  %r153 = icmp sgt i32 %r149, %r152
        cmp     w10, w13

        #  br i1 %r153, label %bb10, label %bb11

        b.gt     bb10
        b     bb11

        #bb10:
bb10:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #bb11:
bb11:


        #  %r237 = call i32 @swap(i32* %r117, i32 %r233, i32 %r236)
        mov     x0, x14
        mov     w1, w11
        mov     w2, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     swap
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r238 = add i32 %r236, 0
        mov     w10, w9

        #  %r159 = mul i32 %r238, 2
        mov     w9, #2
        mul     w9, w10, w9

        #  %r239 = add i32 %r159, 1
        add     w9, w9, #1

        #  br label %bb12

        b     bb12

        #bb12:
bb12:


        #  br label %bb3


        #bb3:  %r233 = phi i32 [ %r231, %bb2 ], [ %r238, %bb12 ]
        mov     w11, w10

        #bb3:  %r234 = phi i32 [ %r232, %bb2 ], [ %r239, %bb12 ]
        mov     w10, w9
        b     bb3

        #bb5:
bb5:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r250->x11

        #%r249->x12

        #%r162->x11

        #%r248->x9

        #%r161->x10

        #%r247->x12

        #%r246->x11

        #%r244->x9

        #%r302->x9

        #%r243->x9

        #%r301->x9

        #%r242->x9

        #%r300->x11

        #%r241->x9

        #%r299->x11

        #%r245->x9

        #%r303->x9

        #%r167->x11

        #%r254->x9

        #%r251->x9

        #%r252->x9

        #%r253->x9

        #%r255->x11

        #%r256->x9

        #%r257->x11

        #%r295->x9

        #%r296->x9

        #%r297->x9

        #%r298->x9
heap_sort:


        #bb27:
bb27:


        #  %r241 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     w11, w1
        mov     w9, #0

        #  %r242 = add i32 0, 0
        mov     w9, #0

        #  %r243 = add i32 0, 0
        mov     w9, #0

        #  %r244 = add i32 0, 0
        mov     w9, #0

        #  %r245 = add i32 %r162, 0
        mov     w9, w11

        #  br label %bb13

        b     bb13

        #bb13:
bb13:


        #  %r167 = sdiv i32 %r245, 2
        mov     w11, #2
        sdiv     w11, w9, w11

        #  %r246 = sub i32 %r167, 1
        sub     w11, w11, #1

        #  br label %bb14


        #bb14:  %r247 = phi i32 [ %r246, %bb13 ], [ %r257, %bb15 ]
        mov     w12, w11
        b     bb14

        #bb14:
bb14:


        #  %r247 = phi i32 [ %r246, %bb13 ], [ %r257, %bb15 ]

        #  %r170 = icmp sgt i32 %r247, -1
        mov     w11, #-1
        cmp     w12, w11

        #  br i1 %r170, label %bb15, label %bb16

        b.gt     bb15
        b     bb16

        #bb15:
bb15:


        #  %r255 = sub i32 %r245, 1
        sub     w11, w9, #1

        #  %r256 = call i32 @heap_ajust(i32* %r161, i32 %r247, i32 %r255)
        mov     x0, x10
        mov     w1, w12
        mov     w2, w11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     heap_ajust
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r257 = sub i32 %r247, 1
        sub     w11, w12, #1

        #  br label %bb14


        #bb14:  %r247 = phi i32 [ %r246, %bb13 ], [ %r257, %bb15 ]
        mov     w12, w11
        b     bb14

        #bb16:
bb16:


        #  %r248 = sub i32 %r245, 1
        sub     w9, w9, #1

        #  br label %bb17


        #bb17:  %r249 = phi i32 [ %r248, %bb16 ], [ %r254, %bb18 ]
        mov     w12, w9
        b     bb17

        #bb17:
bb17:


        #  %r249 = phi i32 [ %r248, %bb16 ], [ %r254, %bb18 ]

        #  %r181 = icmp sgt i32 %r249, 0
        mov     w9, #0
        cmp     w12, w9

        #  br i1 %r181, label %bb18, label %bb19

        b.gt     bb18
        b     bb19

        #bb18:
bb18:


        #  %r250 = add i32 0, 0
        mov     w9, #0
        mov     w11, w9

        #  %r251 = call i32 @swap(i32* %r161, i32 %r250, i32 %r249)
        mov     x0, x10
        mov     w1, w11
        mov     w2, w12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     swap
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r252 = sub i32 %r249, 1
        sub     w9, w12, #1

        #  %r253 = call i32 @heap_ajust(i32* %r161, i32 %r250, i32 %r252)
        mov     x0, x10
        mov     w1, w11
        mov     w2, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     heap_ajust
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r254 = sub i32 %r249, 1
        sub     w9, w12, #1

        #  br label %bb17


        #bb17:  %r249 = phi i32 [ %r248, %bb16 ], [ %r254, %bb18 ]
        mov     w12, w9
        b     bb17

        #bb19:
bb19:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r341->x9

        #%r340->x10

        #%r339->x9

        #%r212->x10

        #%r338->x10

        #%r337->x9

        #%r336->x9

        #%r335->x9

        #%r208->x10

        #%r334->x10

        #%r333->x9

        #%r332->x10

        #%r205->x10

        #%r331->x9

        #%r329->x9

        #%r202->x10

        #%r328->x10

        #%r201->x10

        #%r327->x9

        #%r200->x10

        #%r325->x9

        #%r198->x10

        #%r322->x10

        #%r195->x10

        #%r263->x10

        #%r320->x10

        #%r261->x9

        #%r319->x9

        #%r260->x9

        #%r318->x9

        #%r259->x9

        #%r330->x9

        #%r203->x10

        #%r317->x9

        #%r258->x9

        #%r199->x10

        #%r326->x10

        #%r316->x10

        #%r315->x9

        #%r197->x10

        #%r324->x9

        #%r314->x10

        #%r196->x10

        #%r323->x9

        #%r313->x9

        #%r311->x9

        #%r312->x9

        #%r194->x10

        #%r321->x9

        #%r310->x10

        #%r262->x9

        #%r264->x10

        #%r265->x9

        #%r304->x9

        #%r305->x9

        #%r306->x10

        #%r307->x9

        #%r308->x10

        #%r309->x9

        #%r342->x9

        #%r343->x9

        #%r344->x10

        #%r345->x9

        #%r346->x10

        #%r347->x9

        #%r348->x9

        #%r349->x9

        #%r350->x10

        #%r351->x9

        #%r352->x10

        #%r353->x9

        #%r354->x9

        #%r355->x9

        #%r356->x10

        #%r357->x9

        #%r358->x10

        #%r359->x9

        #%r360->x9

        #%r361->x9

        #%r362->x10

        #%r363->x9

        #%r364->x10

        #%r365->x9

        #%r366->x9

        #%r367->x9

        #%r368->x9

        #%r369->x9

        #%r370->x9

        #%r371->x9

        #%r372->x9

        #%r373->x10

        #%r374->x10

        #%r375->x11

        #%r376->x10

        #%r377->x10

        #%r378->x10

        #%r379->x9

        #%r380->x9
main:


        #193:x29,#-40

        #bb20:
bb20:


        #  %r258 = add i32 0, 0
        mov     x16, #48
        sub     sp, sp, x16
        mov     w9, #0

        #  call void @_sysy_starttime(i32 50)
        mov     w9, #50
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

        #  store i32 10, i32* @n
        mov     w10, #10
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     w10, [x9]

        #  %r193 = alloca [ 10 x i32 ]

        #  %r194 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 4, i32* %r194
        mov     w9, #4
        str     w9, [x10]

        #  %r195 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 1
        mov     x10, #1
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 3, i32* %r195
        mov     w9, #3
        str     w9, [x10]

        #  %r196 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 2
        mov     x10, #2
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 9, i32* %r196
        mov     w9, #9
        str     w9, [x10]

        #  %r197 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 3
        mov     x10, #3
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 2, i32* %r197
        mov     w9, #2
        str     w9, [x10]

        #  %r198 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 4
        mov     x10, #4
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 0, i32* %r198
        mov     w9, #0
        str     w9, [x10]

        #  %r199 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 5
        mov     x10, #5
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r199
        mov     w9, #1
        str     w9, [x10]

        #  %r200 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 6
        mov     x10, #6
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 6, i32* %r200
        mov     w9, #6
        str     w9, [x10]

        #  %r201 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 7
        mov     x10, #7
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 5, i32* %r201
        mov     w9, #5
        str     w9, [x10]

        #  %r202 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 8
        mov     x10, #8
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 7, i32* %r202
        mov     w9, #7
        str     w9, [x10]

        #  %r203 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 9
        mov     x10, #9
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-40
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 8, i32* %r203
        mov     w9, #8
        str     w9, [x10]

        #  %r259 = add i32 0, 0
        mov     w9, #0

        #  %r260 = add i32 0, 0
        mov     w9, #0

        #  %r205 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w10, [x9]

        #  %r261 = call i32 @heap_sort(i32* %r193, i32 %r205)
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
        bl     heap_sort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  br label %bb21


        #bb21:  %r262 = phi i32 [ %r261, %bb20 ], [ %r265, %bb22 ]
        mov     w9, w9
        b     bb21

        #bb21:
bb21:


        #  %r262 = phi i32 [ %r261, %bb20 ], [ %r265, %bb22 ]

        #  %r208 = load i32, i32* @n
        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]

        #  %r209 = icmp slt i32 %r262, %r208
        cmp     w9, w10

        #  br i1 %r209, label %bb22, label %bb23

        b.lt     bb22
        b     bb23

        #bb22:
bb22:


        #  %r212 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 %r262
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-40
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r263 = load i32, i32* %r212
        ldr     w10, [x10]

        #  call void @putint(i32 %r263)
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

        #  %r264 = add i32 10, 0
        mov     w10, #10
        mov     w10, w10

        #  call void @putch(i32 %r264)
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

        #  %r265 = add i32 %r262, 1
        add     w9, w9, #1

        #  br label %bb21


        #bb21:  %r262 = phi i32 [ %r261, %bb20 ], [ %r265, %bb22 ]
        mov     w9, w9
        b     bb21

        #bb23:
bb23:


        #  call void @_sysy_stoptime(i32 66)
        mov     w9, #66
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
