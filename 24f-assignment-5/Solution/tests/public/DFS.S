.section .data
.global    n
.global    m
.global    to
.global    next
.global    head
.global    cnt
.global    vis
n:
        .quad   0
m:
        .quad   0
to:
        .zero   20020
next:
        .zero   20020
head:
        .zero   4020
cnt:
        .quad   0
vis:
        .zero   4020
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global quickread
.global addedge
.global init
.global clear
.global same
.global main

        #%r284->x11

        #%r283->x11

        #%r282->x11

        #%r281->x10

        #%r280->x10

        #%r279->x9

        #%r278->x9

        #%r277->x9

        #%r241->x11

        #%r239->x12

        #%r238->x9

        #%r237->x10

        #%r233->x10

        #%r235->x10

        #%r240->x9

        #%r124->x9

        #%r286->x11

        #%r227->x9

        #%r228->x9

        #%r287->x11

        #%r285->x10

        #%r229->x9

        #%r288->x11

        #%r230->x11

        #%r289->x11

        #%r231->x9

        #%r290->x10

        #%r116->x9

        #%r234->x12

        #%r232->x10

        #%r118->x9

        #%r236->x11
quickread:


        #bb1:
bb1:


        #  %r227 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0

        #  %r230 = call i32 @getch()
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
        mov     w11, w0

        #  %r228 = add i32 0, 0
        mov     w9, #0

        #  %r231 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  %r229 = add i32 0, 0
        mov     w10, #0

        #  %r232 = add i32 0, 0
        mov     w10, #0
        mov     w10, w10

        #  br label %bb2


        #bb2:  %r233 = phi i32 [ %r232, %bb1 ], [ %r235, %bb8 ]
        mov     w10, w10

        #bb2:  %r234 = phi i32 [ %r230, %bb1 ], [ %r236, %bb8 ]
        mov     w12, w11
        b     bb2

        #bb2:
bb2:


        #  %r233 = phi i32 [ %r232, %bb1 ], [ %r235, %bb8 ]

        #  %r234 = phi i32 [ %r230, %bb1 ], [ %r236, %bb8 ]

        #  %r105 = icmp slt i32 %r234, 48
        mov     w11, #48
        cmp     w12, w11

        #  br i1 %r105, label %bb3, label %bb5

        b.lt     bb3
        b     bb5

        #bb5:
bb5:


        #  %r107 = icmp sgt i32 %r234, 57
        mov     w11, #57
        cmp     w12, w11

        #  br i1 %r107, label %bb3, label %bb4

        b.gt     bb3
        b     bb4

        #bb3:
bb3:


        #  %r109 = icmp eq i32 %r234, 45
        mov     w11, #45
        cmp     w12, w11

        #  br i1 %r109, label %bb6, label %bb7

        b.eq     bb6
        b     bb7

        #bb6:
bb6:


        #  %r237 = add i32 1, 0
        mov     w10, #1
        mov     w10, w10

        #  br label %bb8


        #bb8:  %r235 = phi i32 [ %r237, %bb6 ], [ %r233, %bb7 ]
        mov     w10, w10
        b     bb8

        #bb7:
bb7:


        #  br label %bb8


        #bb8:  %r235 = phi i32 [ %r237, %bb6 ], [ %r233, %bb7 ]
        mov     w10, w10
        b     bb8

        #bb8:
bb8:


        #  %r235 = phi i32 [ %r237, %bb6 ], [ %r233, %bb7 ]

        #  %r236 = call i32 @getch()
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
        mov     w11, w0

        #  br label %bb2


        #bb2:  %r233 = phi i32 [ %r232, %bb1 ], [ %r235, %bb8 ]
        mov     w10, w10

        #bb2:  %r234 = phi i32 [ %r230, %bb1 ], [ %r236, %bb8 ]
        mov     w12, w11
        b     bb2

        #bb4:
bb4:


        #  br label %bb9


        #bb9:  %r238 = phi i32 [ %r231, %bb4 ], [ %r240, %bb10 ]
        mov     w9, w9

        #bb9:  %r239 = phi i32 [ %r234, %bb4 ], [ %r241, %bb10 ]
        mov     w12, w12
        b     bb9

        #bb9:
bb9:


        #  %r238 = phi i32 [ %r231, %bb4 ], [ %r240, %bb10 ]

        #  %r239 = phi i32 [ %r234, %bb4 ], [ %r241, %bb10 ]

        #  %r112 = icmp sge i32 %r239, 48
        mov     w11, #48
        cmp     w12, w11

        #  br i1 %r112, label %bb12, label %bb11

        b.ge     bb12
        b     bb11

        #bb12:
bb12:


        #  %r114 = icmp sle i32 %r239, 57
        mov     w11, #57
        cmp     w12, w11

        #  br i1 %r114, label %bb10, label %bb11

        b.le     bb10
        b     bb11

        #bb10:
bb10:


        #  %r116 = mul i32 %r238, 10
        mov     w11, #10
        mul     w9, w9, w11

        #  %r118 = add i32 %r116, %r239
        add     w9, w9, w12

        #  %r240 = sub i32 %r118, 48
        sub     w9, w9, #48

        #  %r241 = call i32 @getch()
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
        mov     w11, w0

        #  br label %bb9


        #bb9:  %r238 = phi i32 [ %r231, %bb4 ], [ %r240, %bb10 ]
        mov     w9, w9

        #bb9:  %r239 = phi i32 [ %r234, %bb4 ], [ %r241, %bb10 ]
        mov     w12, w11
        b     bb9

        #bb11:
bb11:


        #  %r122 = icmp ne i32 %r233, 0
        mov     w11, #0
        cmp     w10, w11

        #  br i1 %r122, label %bb13, label %bb14

        b.ne     bb13
        b     bb14

        #bb13:
bb13:


        #  %r124 = sub i32 0, %r238
        mov     w10, #0
        sub     w9, w10, w9

        #  ret i32 %r124
        mov     w0, w9
        mov     sp, x29
        ret

        #bb14:
bb14:


        #  ret i32 %r238
        mov     w0, w9
        mov     sp, x29
        ret

        #%r323->x10

        #%r320->x11

        #%r316->x10

        #%r310->x11

        #%r307->x11

        #%r306->x12

        #%r300->x12

        #%r299->x11

        #%r298->x12

        #%r297->x11

        #%r296->x11

        #%r295->x12

        #%r294->x11

        #%r319->x12

        #%r142->x12

        #%r317->x11

        #%r140->x11

        #%r315->x11

        #%r138->x13

        #%r314->x10

        #%r137->x12

        #%r313->x11

        #%r136->x13

        #%r312->x12

        #%r135->x11

        #%r311->x11

        #%r134->x11

        #%r309->x11

        #%r132->x11

        #%r321->x10

        #%r144->x12

        #%r308->x11

        #%r131->x12

        #%r318->x11

        #%r141->x11

        #%r305->x11

        #%r128->x11

        #%r303->x12

        #%r244->x10

        #%r126->x10

        #%r155->x10

        #%r301->x12

        #%r242->x9

        #%r322->x10

        #%r145->x11

        #%r147->x10

        #%r292->x9

        #%r148->x10

        #%r293->x11

        #%r149->x12

        #%r150->x11

        #%r151->x11

        #%r153->x9

        #%r154->x9

        #%r302->x13

        #%r243->x9

        #%r304->x11

        #%r245->x9

        #%r291->x9

        #%r324->x9

        #%r325->x9

        #%r326->x9
addedge:


        #bb49:
bb49:


        #  %r242 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w11, w1
        mov     w9, #0

        #  %r244 = add i32 %r126, 0
        mov     w10, w10

        #  %r243 = add i32 0, 0
        mov     w9, #0

        #  %r245 = add i32 %r128, 0
        mov     w9, w11

        #  br label %bb16

        b     bb16

        #bb16:
bb16:


        #  %r131 = load i32, i32* @cnt
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w12, [x11]

        #  %r132 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r131
        mov     x11, #4
        mul     x12, x12, x11
        adrp     x11, to
        add     x11, x11, #:lo12:to
        add     x11, x11, x12

        #  store i32 %r245, i32* %r132
        str     w9, [x11]

        #  %r134 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r244
        mov     x11, #4
        mul     x12, x10, x11
        adrp     x11, head
        add     x11, x11, #:lo12:head
        add     x11, x11, x12

        #  %r135 = load i32, i32* %r134
        ldr     w11, [x11]

        #  %r136 = load i32, i32* @cnt
        adrp     x12, cnt
        add     x12, x12, #:lo12:cnt
        ldr     w13, [x12]

        #  %r137 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r136
        mov     x12, #4
        mul     x13, x13, x12
        adrp     x12, next
        add     x12, x12, #:lo12:next
        add     x12, x12, x13

        #  store i32 %r135, i32* %r137
        str     w11, [x12]

        #  %r138 = load i32, i32* @cnt
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w13, [x11]

        #  %r140 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r244
        mov     x11, #4
        mul     x12, x10, x11
        adrp     x11, head
        add     x11, x11, #:lo12:head
        add     x11, x11, x12

        #  store i32 %r138, i32* %r140
        str     w13, [x11]

        #  %r141 = load i32, i32* @cnt
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w11, [x11]

        #  %r142 = add i32 %r141, 1
        add     w12, w11, #1

        #  store i32 %r142, i32* @cnt
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        str     w12, [x11]

        #  %r144 = load i32, i32* @cnt
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w12, [x11]

        #  %r145 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r144
        mov     x11, #4
        mul     x12, x12, x11
        adrp     x11, to
        add     x11, x11, #:lo12:to
        add     x11, x11, x12

        #  store i32 %r244, i32* %r145
        str     w10, [x11]

        #  %r147 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r245
        mov     x10, #4
        mul     x11, x9, x10
        adrp     x10, head
        add     x10, x10, #:lo12:head
        add     x10, x10, x11

        #  %r148 = load i32, i32* %r147
        ldr     w10, [x10]

        #  %r149 = load i32, i32* @cnt
        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     w12, [x11]

        #  %r150 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r149
        mov     x11, #4
        mul     x12, x12, x11
        adrp     x11, next
        add     x11, x11, #:lo12:next
        add     x11, x11, x12

        #  store i32 %r148, i32* %r150
        str     w10, [x11]

        #  %r151 = load i32, i32* @cnt
        adrp     x10, cnt
        add     x10, x10, #:lo12:cnt
        ldr     w11, [x10]

        #  %r153 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r245
        mov     x10, #4
        mul     x10, x9, x10
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x10

        #  store i32 %r151, i32* %r153
        str     w11, [x9]

        #  %r154 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w9, [x9]

        #  %r155 = add i32 %r154, 1
        add     w10, w9, #1

        #  store i32 %r155, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        str     w10, [x9]

        #  ret void
        mov     sp, x29
        ret

        #%r160->x10

        #%r329->x9

        #%r246->x9

        #%r247->x9

        #%r248->x11

        #%r249->x9

        #%r327->x9

        #%r328->x9

        #%r330->x9

        #%r331->x10

        #%r332->x9

        #%r333->x9
init:


        #bb17:
bb17:


        #  %r246 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0

        #  %r247 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb18


        #bb18:  %r248 = phi i32 [ %r247, %bb17 ], [ %r249, %bb19 ]
        mov     w11, w9
        b     bb18

        #bb18:
bb18:


        #  %r248 = phi i32 [ %r247, %bb17 ], [ %r249, %bb19 ]

        #  %r158 = icmp slt i32 %r248, 1005
        mov     w9, #1005
        cmp     w11, w9

        #  br i1 %r158, label %bb19, label %bb20

        b.lt     bb19
        b     bb20

        #bb19:
bb19:


        #  %r160 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r248
        mov     x9, #4
        mul     x10, x11, x9
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x10, x9, x10

        #  store i32 -1, i32* %r160
        mov     w9, #-1
        str     w9, [x10]

        #  %r249 = add i32 %r248, 1
        add     w9, w11, #1

        #  br label %bb18


        #bb18:  %r248 = phi i32 [ %r247, %bb17 ], [ %r249, %bb19 ]
        mov     w11, w9
        b     bb18

        #bb20:
bb20:


        #  ret void
        mov     sp, x29
        ret

        #%r165->x10

        #%r334->x9

        #%r168->x11

        #%r337->x10

        #%r250->x9

        #%r251->x9

        #%r252->x9

        #%r253->x9

        #%r335->x9

        #%r336->x10

        #%r338->x11

        #%r339->x10

        #%r340->x10
clear:


        #bb21:
bb21:


        #  %r250 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0

        #  %r251 = add i32 1, 0
        mov     w9, #1
        mov     w9, w9

        #  br label %bb22


        #bb22:  %r252 = phi i32 [ %r251, %bb21 ], [ %r253, %bb23 ]
        mov     w9, w9
        b     bb22

        #bb22:
bb22:


        #  %r252 = phi i32 [ %r251, %bb21 ], [ %r253, %bb23 ]

        #  %r165 = load i32, i32* @n
        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]

        #  %r166 = icmp sle i32 %r252, %r165
        cmp     w9, w10

        #  br i1 %r166, label %bb23, label %bb24

        b.le     bb23
        b     bb24

        #bb23:
bb23:


        #  %r168 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r252
        mov     x10, #4
        mul     x11, x9, x10
        adrp     x10, vis
        add     x10, x10, #:lo12:vis
        add     x11, x10, x11

        #  store i32 0, i32* %r168
        mov     w10, #0
        str     w10, [x11]

        #  %r253 = add i32 %r252, 1
        add     w9, w9, #1

        #  br label %bb22


        #bb22:  %r252 = phi i32 [ %r251, %bb21 ], [ %r253, %bb23 ]
        mov     w9, w9
        b     bb22

        #bb24:
bb24:


        #  ret void
        mov     sp, x29
        ret

        #%r349->x9

        #%r262->x9

        #%r348->x10

        #%r171->x10

        #%r261->x10

        #%r346->x12

        #%r259->x11

        #%r345->x10

        #%r258->x9

        #%r199->x9

        #%r347->x10

        #%r260->x9

        #%r173->x11

        #%r350->x10

        #%r263->x9

        #%r176->x12

        #%r353->x9

        #%r182->x9

        #%r359->x12

        #%r188->x9

        #%r365->x9

        #%r191->x12

        #%r343->x9

        #%r256->x9

        #%r192->x13

        #%r344->x10

        #%r257->x9

        #%r341->x9

        #%r254->x9

        #%r196->x12

        #%r255->x9

        #%r342->x9

        #%r351->x10

        #%r352->x9

        #%r354->x9

        #%r355->x12

        #%r356->x9

        #%r357->x12

        #%r358->x13

        #%r360->x12

        #%r361->x9

        #%r362->x9

        #%r363->x9

        #%r364->x10

        #%r366->x9
same:


        #bb50:
bb50:


        #  %r254 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w11, w1
        mov     w9, #0

        #  %r255 = add i32 0, 0
        mov     w9, #0

        #  %r256 = add i32 0, 0
        mov     w9, #0

        #  %r258 = add i32 %r171, 0
        mov     w9, w10

        #  %r257 = add i32 0, 0
        mov     w10, #0

        #  %r259 = add i32 %r173, 0
        mov     w11, w11

        #  br label %bb25

        b     bb25

        #bb25:
bb25:


        #  %r176 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r258
        mov     x10, #4
        mul     x12, x9, x10
        adrp     x10, vis
        add     x10, x10, #:lo12:vis
        add     x12, x10, x12

        #  store i32 1, i32* %r176
        mov     w10, #1
        str     w10, [x12]

        #  %r179 = icmp eq i32 %r258, %r259
        cmp     w9, w11

        #  br i1 %r179, label %bb26, label %bb27

        b.eq     bb26
        b     bb27

        #bb26:
bb26:


        #  ret i32 1
        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret

        #bb27:
bb27:


        #  br label %bb28

        b     bb28

        #bb28:
bb28:


        #  %r182 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r258
        mov     x10, #4
        mul     x10, x9, x10
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x10

        #  %r260 = load i32, i32* %r182
        ldr     w9, [x9]

        #  br label %bb29


        #bb29:  %r261 = phi i32 [ %r260, %bb28 ], [ %r263, %bb34 ]
        mov     w10, w9
        b     bb29

        #bb29:
bb29:


        #  %r261 = phi i32 [ %r260, %bb28 ], [ %r263, %bb34 ]

        #  %r185 = icmp ne i32 %r261, -1
        mov     w9, #-1
        cmp     w10, w9

        #  br i1 %r185, label %bb30, label %bb31

        b.ne     bb30
        b     bb31

        #bb30:
bb30:


        #  %r188 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r261
        mov     x9, #4
        mul     x12, x10, x9
        adrp     x9, to
        add     x9, x9, #:lo12:to
        add     x9, x9, x12

        #  %r262 = load i32, i32* %r188
        ldr     w9, [x9]

        #  %r191 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r262
        mov     x12, #4
        mul     x13, x9, x12
        adrp     x12, vis
        add     x12, x12, #:lo12:vis
        add     x12, x12, x13

        #  %r192 = load i32, i32* %r191
        ldr     w13, [x12]

        #  %r193 = icmp eq i32 %r192, 0
        mov     w12, #0
        cmp     w13, w12

        #  br i1 %r193, label %bb35, label %bb33

        b.eq     bb35
        b     bb33

        #bb35:
bb35:


        #  %r196 = call i32 @same(i32 %r262, i32 %r259)
        mov     w0, w9
        mov     w1, w11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     same
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0

        #  %r197 = icmp ne i32 %r196, 0
        mov     w9, #0
        cmp     w12, w9

        #  br i1 %r197, label %bb32, label %bb33

        b.ne     bb32
        b     bb33

        #bb32:
bb32:


        #  ret i32 1
        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret

        #bb33:
bb33:


        #  br label %bb34

        b     bb34

        #bb34:
bb34:


        #  %r199 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r261
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, next
        add     x9, x9, #:lo12:next
        add     x9, x9, x10

        #  %r263 = load i32, i32* %r199
        ldr     w9, [x9]

        #  br label %bb29


        #bb29:  %r261 = phi i32 [ %r260, %bb28 ], [ %r263, %bb34 ]
        mov     w10, w9
        b     bb29

        #bb31:
bb31:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r374->x9

        #%r373->x9

        #%r372->x9

        #%r369->x9

        #%r368->x9

        #%r367->x9

        #%r276->x9

        #%r275->x9

        #%r274->x10

        #%r273->x9

        #%r272->x10

        #%r271->x10

        #%r375->x9

        #%r201->x10

        #%r378->x9

        #%r266->x9

        #%r384->x9

        #%r376->x9

        #%r202->x10

        #%r379->x9

        #%r267->x9

        #%r385->x9

        #%r220->x9

        #%r370->x9

        #%r225->x9

        #%r206->x10

        #%r265->x9

        #%r383->x9

        #%r264->x9

        #%r382->x9

        #%r371->x9

        #%r226->x10

        #%r268->x9

        #%r269->x9

        #%r270->x9

        #%r377->x9

        #%r380->x9

        #%r381->x9
main:


        #bb36:
bb36:


        #  call void @_sysy_starttime(i32 74)
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #74
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

        #  %r201 = call i32 @quickread()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  store i32 %r201, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     w10, [x9]

        #  %r202 = call i32 @quickread()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  store i32 %r202, i32* @m
        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     w10, [x9]

        #  call void @init()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     init
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r264 = add i32 0, 0
        mov     w9, #0

        #  %r267 = add i32 0, 0
        mov     w9, #0

        #  %r265 = add i32 0, 0
        mov     w9, #0

        #  %r268 = add i32 0, 0
        mov     w9, #0

        #  %r266 = add i32 0, 0
        mov     w9, #0

        #  %r269 = add i32 0, 0
        mov     w9, #0

        #  br label %bb37

        b     bb37

        #bb37:
bb37:


        #  %r206 = load i32, i32* @m
        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     w10, [x9]

        #  %r207 = icmp ne i32 %r206, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r207, label %bb38, label %bb39

        b.ne     bb38
        b     bb39

        #bb38:
bb38:


        #  %r270 = call i32 @getch()
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
        mov     w9, w0

        #  br label %bb40


        #bb40:  %r271 = phi i32 [ %r270, %bb38 ], [ %r276, %bb41 ]
        mov     w10, w9
        b     bb40

        #bb40:
bb40:


        #  %r271 = phi i32 [ %r270, %bb38 ], [ %r276, %bb41 ]

        #  %r210 = icmp ne i32 %r271, 81
        mov     w9, #81
        cmp     w10, w9

        #  br i1 %r210, label %bb43, label %bb42

        b.ne     bb43
        b     bb42

        #bb43:
bb43:


        #  %r212 = icmp ne i32 %r271, 85
        mov     w9, #85
        cmp     w10, w9

        #  br i1 %r212, label %bb41, label %bb42

        b.ne     bb41
        b     bb42

        #bb41:
bb41:


        #  %r276 = call i32 @getch()
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
        mov     w9, w0

        #  br label %bb40


        #bb40:  %r271 = phi i32 [ %r270, %bb38 ], [ %r276, %bb41 ]
        mov     w10, w9
        b     bb40

        #bb42:
bb42:


        #  %r215 = icmp eq i32 %r271, 81
        mov     w9, #81
        cmp     w10, w9

        #  br i1 %r215, label %bb44, label %bb45

        b.eq     bb44
        b     bb45

        #bb44:
bb44:


        #  %r274 = call i32 @quickread()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r275 = call i32 @quickread()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  call void @clear()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     clear
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r220 = call i32 @same(i32 %r274, i32 %r275)
        mov     w0, w10
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     same
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  call void @putint(i32 %r220)
        mov     w0, w9
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

        #  br label %bb46

        b     bb46

        #bb45:
bb45:


        #  %r272 = call i32 @quickread()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r273 = call i32 @quickread()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  call void @addedge(i32 %r272, i32 %r273)
        mov     w0, w10
        mov     w1, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     addedge
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb46

        b     bb46

        #bb46:
bb46:


        #  %r225 = load i32, i32* @m
        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     w9, [x9]

        #  %r226 = sub i32 %r225, 1
        sub     w10, w9, #1

        #  store i32 %r226, i32* @m
        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     w10, [x9]

        #  br label %bb37

        b     bb37

        #bb39:
bb39:


        #  call void @_sysy_stoptime(i32 96)
        mov     w9, #96
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
