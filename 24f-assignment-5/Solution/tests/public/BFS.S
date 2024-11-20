.section .data
.global    n
.global    m
.global    to
.global    next
.global    head
.global    cnt
.global    que
.global    h
.global    tail
.global    inq
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
que:
        .zero   4020
h:
        .quad   0
tail:
        .quad   0
inq:
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
.global inqueue
.global popqueue
.global same
.global main

        #%r326->x11

        #%r325->x11

        #%r266->x11

        #%r324->x10

        #%r265->x9

        #%r323->x11

        #%r264->x12

        #%r322->x11

        #%r263->x9

        #%r320->x10

        #%r261->x11

        #%r262->x10

        #%r321->x11

        #%r317->x9

        #%r258->x10

        #%r259->x12

        #%r318->x9

        #%r118->x9

        #%r319->x10

        #%r260->x10

        #%r116->x9

        #%r124->x9

        #%r254->x9

        #%r252->x9

        #%r253->x9

        #%r255->x11

        #%r256->x9

        #%r257->x10

        #%r316->x9

        #%r327->x11

        #%r328->x11

        #%r329->x10
quickread:


        #bb1:
bb1:


        #  %r252 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0

        #  %r255 = call i32 @getch()
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

        #  %r253 = add i32 0, 0
        mov     w9, #0

        #  %r256 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  %r254 = add i32 0, 0
        mov     w10, #0

        #  %r257 = add i32 0, 0
        mov     w10, #0
        mov     w10, w10

        #  br label %bb2


        #bb2:  %r258 = phi i32 [ %r257, %bb1 ], [ %r260, %bb8 ]
        mov     w10, w10

        #bb2:  %r259 = phi i32 [ %r255, %bb1 ], [ %r261, %bb8 ]
        mov     w12, w11
        b     bb2

        #bb2:
bb2:


        #  %r258 = phi i32 [ %r257, %bb1 ], [ %r260, %bb8 ]

        #  %r259 = phi i32 [ %r255, %bb1 ], [ %r261, %bb8 ]

        #  %r105 = icmp slt i32 %r259, 48
        mov     w11, #48
        cmp     w12, w11

        #  br i1 %r105, label %bb3, label %bb5

        b.lt     bb3
        b     bb5

        #bb5:
bb5:


        #  %r107 = icmp sgt i32 %r259, 57
        mov     w11, #57
        cmp     w12, w11

        #  br i1 %r107, label %bb3, label %bb4

        b.gt     bb3
        b     bb4

        #bb3:
bb3:


        #  %r109 = icmp eq i32 %r259, 45
        mov     w11, #45
        cmp     w12, w11

        #  br i1 %r109, label %bb6, label %bb7

        b.eq     bb6
        b     bb7

        #bb6:
bb6:


        #  %r262 = add i32 1, 0
        mov     w10, #1
        mov     w10, w10

        #  br label %bb8


        #bb8:  %r260 = phi i32 [ %r262, %bb6 ], [ %r258, %bb7 ]
        mov     w10, w10
        b     bb8

        #bb7:
bb7:


        #  br label %bb8


        #bb8:  %r260 = phi i32 [ %r262, %bb6 ], [ %r258, %bb7 ]
        mov     w10, w10
        b     bb8

        #bb8:
bb8:


        #  %r260 = phi i32 [ %r262, %bb6 ], [ %r258, %bb7 ]

        #  %r261 = call i32 @getch()
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


        #bb2:  %r258 = phi i32 [ %r257, %bb1 ], [ %r260, %bb8 ]
        mov     w10, w10

        #bb2:  %r259 = phi i32 [ %r255, %bb1 ], [ %r261, %bb8 ]
        mov     w12, w11
        b     bb2

        #bb4:
bb4:


        #  br label %bb9


        #bb9:  %r263 = phi i32 [ %r256, %bb4 ], [ %r265, %bb10 ]
        mov     w9, w9

        #bb9:  %r264 = phi i32 [ %r259, %bb4 ], [ %r266, %bb10 ]
        mov     w12, w12
        b     bb9

        #bb9:
bb9:


        #  %r263 = phi i32 [ %r256, %bb4 ], [ %r265, %bb10 ]

        #  %r264 = phi i32 [ %r259, %bb4 ], [ %r266, %bb10 ]

        #  %r112 = icmp sge i32 %r264, 48
        mov     w11, #48
        cmp     w12, w11

        #  br i1 %r112, label %bb12, label %bb11

        b.ge     bb12
        b     bb11

        #bb12:
bb12:


        #  %r114 = icmp sle i32 %r264, 57
        mov     w11, #57
        cmp     w12, w11

        #  br i1 %r114, label %bb10, label %bb11

        b.le     bb10
        b     bb11

        #bb10:
bb10:


        #  %r116 = mul i32 %r263, 10
        mov     w11, #10
        mul     w9, w9, w11

        #  %r118 = add i32 %r116, %r264
        add     w9, w9, w12

        #  %r265 = sub i32 %r118, 48
        sub     w9, w9, #48

        #  %r266 = call i32 @getch()
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


        #bb9:  %r263 = phi i32 [ %r256, %bb4 ], [ %r265, %bb10 ]
        mov     w9, w9

        #bb9:  %r264 = phi i32 [ %r259, %bb4 ], [ %r266, %bb10 ]
        mov     w12, w11
        b     bb9

        #bb11:
bb11:


        #  %r122 = icmp ne i32 %r258, 0
        mov     w11, #0
        cmp     w10, w11

        #  br i1 %r122, label %bb13, label %bb14

        b.ne     bb13
        b     bb14

        #bb13:
bb13:


        #  %r124 = sub i32 0, %r263
        mov     w10, #0
        sub     w9, w10, w9

        #  ret i32 %r124
        mov     w0, w9
        mov     sp, x29
        ret

        #bb14:
bb14:


        #  ret i32 %r263
        mov     w0, w9
        mov     sp, x29
        ret

        #%r361->x10

        #%r360->x10

        #%r359->x11

        #%r358->x12

        #%r357->x11

        #%r356->x11

        #%r355->x10

        #%r354->x11

        #%r353->x10

        #%r352->x11

        #%r351->x12

        #%r350->x11

        #%r349->x11

        #%r348->x11

        #%r347->x11

        #%r346->x11

        #%r345->x12

        #%r344->x11

        #%r343->x11

        #%r342->x12

        #%r341->x13

        #%r340->x12

        #%r339->x12

        #%r338->x11

        #%r337->x12

        #%r336->x11

        #%r335->x11

        #%r334->x12

        #%r333->x11

        #%r142->x12

        #%r269->x10

        #%r140->x11

        #%r267->x9

        #%r138->x13

        #%r137->x12

        #%r136->x13

        #%r135->x11

        #%r134->x11

        #%r132->x11

        #%r144->x12

        #%r131->x12

        #%r141->x11

        #%r268->x9

        #%r128->x11

        #%r362->x10

        #%r126->x10

        #%r145->x11

        #%r147->x10

        #%r148->x10

        #%r149->x12

        #%r151->x11

        #%r331->x9

        #%r154->x9

        #%r270->x9

        #%r150->x11

        #%r153->x9

        #%r330->x9

        #%r155->x10

        #%r332->x11

        #%r363->x9

        #%r364->x9

        #%r365->x9
addedge:


        #bb52:
bb52:


        #  %r267 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w11, w1
        mov     w9, #0

        #  %r269 = add i32 %r126, 0
        mov     w10, w10

        #  %r268 = add i32 0, 0
        mov     w9, #0

        #  %r270 = add i32 %r128, 0
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

        #  store i32 %r270, i32* %r132
        str     w9, [x11]

        #  %r134 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r269
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

        #  %r140 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r269
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

        #  store i32 %r269, i32* %r145
        str     w10, [x11]

        #  %r147 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r270
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

        #  %r153 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r270
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

        #%r368->x9

        #%r271->x9

        #%r272->x9

        #%r273->x11

        #%r274->x9

        #%r366->x9

        #%r367->x9

        #%r369->x9

        #%r370->x10

        #%r371->x9

        #%r372->x9
init:


        #bb17:
bb17:


        #  %r271 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0

        #  %r272 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb18


        #bb18:  %r273 = phi i32 [ %r272, %bb17 ], [ %r274, %bb19 ]
        mov     w11, w9
        b     bb18

        #bb18:
bb18:


        #  %r273 = phi i32 [ %r272, %bb17 ], [ %r274, %bb19 ]

        #  %r158 = icmp slt i32 %r273, 1005
        mov     w9, #1005
        cmp     w11, w9

        #  br i1 %r158, label %bb19, label %bb20

        b.lt     bb19
        b     bb20

        #bb19:
bb19:


        #  %r160 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r273
        mov     x9, #4
        mul     x10, x11, x9
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x10, x9, x10

        #  store i32 -1, i32* %r160
        mov     w9, #-1
        str     w9, [x10]

        #  %r274 = add i32 %r273, 1
        add     w9, w11, #1

        #  br label %bb18


        #bb18:  %r273 = phi i32 [ %r272, %bb17 ], [ %r274, %bb19 ]
        mov     w11, w9
        b     bb18

        #bb20:
bb20:


        #  ret void
        mov     sp, x29
        ret

        #%r377->x10

        #%r373->x9

        #%r170->x11

        #%r276->x9

        #%r275->x9

        #%r171->x10

        #%r374->x10

        #%r376->x10

        #%r168->x11

        #%r375->x11

        #%r167->x10

        #%r166->x11

        #%r163->x10

        #%r378->x10

        #%r379->x10

        #%r380->x10

        #%r381->x10

        #%r382->x11

        #%r383->x10
inqueue:


        #bb53:
bb53:


        #  %r275 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0

        #  %r276 = add i32 %r163, 0
        mov     w9, w10

        #  br label %bb21

        b     bb21

        #bb21:
bb21:


        #  %r166 = getelementptr [1005 x i32 ], [1005 x i32 ]* @inq, i32 0, i32 %r276
        mov     x10, #4
        mul     x11, x9, x10
        adrp     x10, inq
        add     x10, x10, #:lo12:inq
        add     x11, x10, x11

        #  store i32 1, i32* %r166
        mov     w10, #1
        str     w10, [x11]

        #  %r167 = load i32, i32* @tail
        adrp     x10, tail
        add     x10, x10, #:lo12:tail
        ldr     w10, [x10]

        #  %r168 = add i32 %r167, 1
        add     w11, w10, #1

        #  store i32 %r168, i32* @tail
        adrp     x10, tail
        add     x10, x10, #:lo12:tail
        str     w11, [x10]

        #  %r170 = load i32, i32* @tail
        adrp     x10, tail
        add     x10, x10, #:lo12:tail
        ldr     w11, [x10]

        #  %r171 = getelementptr [1005 x i32 ], [1005 x i32 ]* @que, i32 0, i32 %r170
        mov     x10, #4
        mul     x11, x11, x10
        adrp     x10, que
        add     x10, x10, #:lo12:que
        add     x10, x10, x11

        #  store i32 %r276, i32* %r171
        str     w9, [x10]

        #  ret void
        mov     sp, x29
        ret

        #%r385->x9

        #%r278->x9

        #%r394->x9

        #%r180->x9

        #%r387->x9

        #%r179->x9

        #%r386->x9

        #%r178->x10

        #%r384->x9

        #%r176->x9

        #%r175->x10

        #%r277->x9

        #%r393->x10

        #%r173->x10

        #%r172->x9

        #%r388->x9

        #%r389->x10

        #%r390->x9

        #%r391->x9

        #%r392->x9
popqueue:


        #bb22:
bb22:


        #  %r172 = load i32, i32* @h
        mov     x16, #0
        sub     sp, sp, x16
        adrp     x9, h
        add     x9, x9, #:lo12:h
        ldr     w9, [x9]

        #  %r173 = add i32 %r172, 1
        add     w10, w9, #1

        #  store i32 %r173, i32* @h
        adrp     x9, h
        add     x9, x9, #:lo12:h
        str     w10, [x9]

        #  %r277 = add i32 0, 0
        mov     w9, #0

        #  %r175 = load i32, i32* @h
        adrp     x9, h
        add     x9, x9, #:lo12:h
        ldr     w10, [x9]

        #  %r176 = getelementptr [1005 x i32 ], [1005 x i32 ]* @que, i32 0, i32 %r175
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, que
        add     x9, x9, #:lo12:que
        add     x9, x9, x10

        #  %r278 = load i32, i32* %r176

        #  %r178 = load i32, i32* @h
        adrp     x9, h
        add     x9, x9, #:lo12:h
        ldr     w10, [x9]

        #  %r179 = getelementptr [1005 x i32 ], [1005 x i32 ]* @que, i32 0, i32 %r178
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, que
        add     x9, x9, #:lo12:que
        add     x9, x9, x10

        #  %r180 = load i32, i32* %r179
        ldr     w9, [x9]

        #  ret i32 %r180
        mov     w0, w9
        mov     sp, x29
        ret

        #%r395->x9

        #%r302->x9

        #%r429->x9

        #%r300->x13

        #%r427->x12

        #%r298->x9

        #%r425->x12

        #%r415->x12

        #%r288->x9

        #%r297->x10

        #%r424->x13

        #%r414->x9

        #%r287->x10

        #%r296->x12

        #%r423->x12

        #%r413->x12

        #%r286->x11

        #%r295->x9

        #%r422->x12

        #%r412->x9

        #%r285->x9

        #%r294->x12

        #%r421->x12

        #%r213->x9

        #%r210->x12

        #%r299->x9

        #%r426->x12

        #%r181->x11

        #%r435->x12

        #%r396->x9

        #%r219->x11

        #%r190->x12

        #%r206->x12

        #%r411->x9

        #%r284->x9

        #%r293->x9

        #%r420->x13

        #%r211->x12

        #%r198->x9

        #%r403->x12

        #%r191->x9

        #%r216->x11

        #%r203->x12

        #%r408->x9

        #%r281->x9

        #%r290->x9

        #%r417->x13

        #%r301->x9

        #%r428->x9

        #%r183->x10

        #%r437->x11

        #%r207->x13

        #%r398->x9

        #%r280->x9

        #%r407->x9

        #%r397->x9

        #%r279->x9

        #%r406->x9

        #%r399->x9

        #%r222->x12

        #%r400->x11

        #%r282->x9

        #%r409->x9

        #%r401->x12

        #%r283->x9

        #%r410->x9

        #%r402->x10

        #%r404->x10

        #%r405->x9

        #%r289->x9

        #%r416->x12

        #%r291->x10

        #%r418->x12

        #%r292->x9

        #%r419->x12

        #%r430->x11

        #%r431->x11

        #%r432->x12

        #%r433->x11

        #%r434->x11

        #%r436->x11
same:


        #bb54:
bb54:


        #  %r279 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w11, w0
        mov     w10, w1
        mov     w9, #0

        #  %r280 = add i32 0, 0
        mov     w9, #0

        #  %r281 = add i32 0, 0
        mov     w9, #0

        #  %r282 = add i32 0, 0
        mov     w9, #0

        #  %r283 = add i32 0, 0
        mov     w9, #0

        #  %r285 = add i32 %r181, 0
        mov     w9, w11

        #  %r284 = add i32 0, 0
        mov     w11, #0

        #  %r286 = add i32 %r183, 0
        mov     w11, w10

        #  br label %bb23

        b     bb23

        #bb23:
bb23:


        #  store i32 0, i32* @h
        mov     w12, #0
        adrp     x10, h
        add     x10, x10, #:lo12:h
        str     w12, [x10]

        #  store i32 0, i32* @tail
        mov     w12, #0
        adrp     x10, tail
        add     x10, x10, #:lo12:tail
        str     w12, [x10]

        #  call void @inqueue(i32 %r285)
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     inqueue
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r287 = add i32 0, 0
        mov     w9, #0
        mov     w10, w9

        #  %r288 = add i32 0, 0
        mov     w9, #0

        #  %r289 = add i32 0, 0
        mov     w9, #0

        #  %r290 = add i32 0, 0
        mov     w9, #0

        #  br label %bb24


        #bb24:  %r291 = phi i32 [ %r287, %bb23 ], [ %r297, %bb32 ]
        mov     w10, w10
        b     bb24

        #bb24:
bb24:


        #  %r291 = phi i32 [ %r287, %bb23 ], [ %r297, %bb32 ]

        #  %r190 = load i32, i32* @h
        adrp     x9, h
        add     x9, x9, #:lo12:h
        ldr     w12, [x9]

        #  %r191 = load i32, i32* @tail
        adrp     x9, tail
        add     x9, x9, #:lo12:tail
        ldr     w9, [x9]

        #  %r192 = icmp slt i32 %r190, %r191
        cmp     w12, w9

        #  br i1 %r192, label %bb25, label %bb26

        b.lt     bb25
        b     bb26

        #bb25:
bb25:


        #  %r296 = call i32 @popqueue()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     popqueue
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0

        #  %r196 = icmp eq i32 %r296, %r286
        cmp     w12, w11

        #  br i1 %r196, label %bb27, label %bb28

        b.eq     bb27
        b     bb28

        #bb27:
bb27:


        #  %r302 = add i32 1, 0
        mov     w9, #1
        mov     w9, w9

        #  br label %bb29


        #bb29:  %r297 = phi i32 [ %r302, %bb27 ], [ %r291, %bb28 ]
        mov     w10, w9
        b     bb29

        #bb28:
bb28:


        #  br label %bb29


        #bb29:  %r297 = phi i32 [ %r302, %bb27 ], [ %r291, %bb28 ]
        mov     w10, w10
        b     bb29

        #bb29:
bb29:


        #  %r297 = phi i32 [ %r302, %bb27 ], [ %r291, %bb28 ]

        #  %r198 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r296
        mov     x9, #4
        mul     x12, x12, x9
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x12

        #  %r298 = load i32, i32* %r198
        ldr     w9, [x9]

        #  br label %bb30


        #bb30:  %r299 = phi i32 [ %r298, %bb29 ], [ %r301, %bb35 ]
        mov     w9, w9
        b     bb30

        #bb30:
bb30:


        #  %r299 = phi i32 [ %r298, %bb29 ], [ %r301, %bb35 ]

        #  %r201 = icmp ne i32 %r299, -1
        mov     w12, #-1
        cmp     w9, w12

        #  br i1 %r201, label %bb31, label %bb32

        b.ne     bb31
        b     bb32

        #bb31:
bb31:


        #  %r203 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r299
        mov     x12, #4
        mul     x13, x9, x12
        adrp     x12, to
        add     x12, x12, #:lo12:to
        add     x12, x12, x13

        #  %r300 = load i32, i32* %r203
        ldr     w13, [x12]

        #  %r206 = getelementptr [1005 x i32 ], [1005 x i32 ]* @inq, i32 0, i32 %r300
        mov     x12, #4
        mul     x13, x13, x12
        adrp     x12, inq
        add     x12, x12, #:lo12:inq
        add     x12, x12, x13

        #  %r207 = load i32, i32* %r206
        ldr     w13, [x12]

        #  %r208 = icmp eq i32 %r207, 0
        mov     w12, #0
        cmp     w13, w12

        #  br i1 %r208, label %bb33, label %bb34

        b.eq     bb33
        b     bb34

        #bb33:
bb33:


        #  %r210 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r299
        mov     x12, #4
        mul     x13, x9, x12
        adrp     x12, to
        add     x12, x12, #:lo12:to
        add     x12, x12, x13

        #  %r211 = load i32, i32* %r210
        ldr     w12, [x12]

        #  call void @inqueue(i32 %r211)
        mov     w0, w12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     inqueue
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb35

        b     bb35

        #bb34:
bb34:


        #  br label %bb35

        b     bb35

        #bb35:
bb35:


        #  %r213 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r299
        mov     x12, #4
        mul     x12, x9, x12
        adrp     x9, next
        add     x9, x9, #:lo12:next
        add     x9, x9, x12

        #  %r301 = load i32, i32* %r213
        ldr     w9, [x9]

        #  br label %bb30


        #bb30:  %r299 = phi i32 [ %r298, %bb29 ], [ %r301, %bb35 ]
        mov     w9, w9
        b     bb30

        #bb32:
bb32:


        #  br label %bb24


        #bb24:  %r291 = phi i32 [ %r287, %bb23 ], [ %r297, %bb32 ]
        mov     w10, w10
        b     bb24

        #bb26:
bb26:


        #  %r292 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb36


        #bb36:  %r293 = phi i32 [ %r292, %bb26 ], [ %r295, %bb37 ]
        mov     w9, w9
        b     bb36

        #bb36:
bb36:


        #  %r293 = phi i32 [ %r292, %bb26 ], [ %r295, %bb37 ]

        #  %r216 = load i32, i32* @tail
        adrp     x11, tail
        add     x11, x11, #:lo12:tail
        ldr     w11, [x11]

        #  %r217 = icmp sle i32 %r293, %r216
        cmp     w9, w11

        #  br i1 %r217, label %bb37, label %bb38

        b.le     bb37
        b     bb38

        #bb37:
bb37:


        #  %r219 = getelementptr [1005 x i32 ], [1005 x i32 ]* @que, i32 0, i32 %r293
        mov     x11, #4
        mul     x12, x9, x11
        adrp     x11, que
        add     x11, x11, #:lo12:que
        add     x11, x11, x12

        #  %r294 = load i32, i32* %r219
        ldr     w12, [x11]

        #  %r222 = getelementptr [1005 x i32 ], [1005 x i32 ]* @inq, i32 0, i32 %r294
        mov     x11, #4
        mul     x12, x12, x11
        adrp     x11, inq
        add     x11, x11, #:lo12:inq
        add     x12, x11, x12

        #  store i32 0, i32* %r222
        mov     w11, #0
        str     w11, [x12]

        #  %r295 = add i32 %r293, 1
        add     w9, w9, #1

        #  br label %bb36


        #bb36:  %r293 = phi i32 [ %r292, %bb26 ], [ %r295, %bb37 ]
        mov     w9, w9
        b     bb36

        #bb38:
bb38:


        #  ret i32 %r291
        mov     w0, w10
        mov     sp, x29
        ret

        #%r447->x9

        #%r446->x9

        #%r445->x9

        #%r444->x9

        #%r443->x9

        #%r442->x9

        #%r441->x9

        #%r440->x9

        #%r439->x9

        #%r438->x9

        #%r315->x9

        #%r312->x9

        #%r311->x10

        #%r310->x10

        #%r251->x10

        #%r313->x10

        #%r226->x10

        #%r304->x9

        #%r245->x9

        #%r314->x9

        #%r227->x10

        #%r305->x9

        #%r231->x10

        #%r309->x9

        #%r250->x9

        #%r303->x9

        #%r306->x9

        #%r307->x9

        #%r308->x9

        #%r448->x9

        #%r449->x9

        #%r450->x9

        #%r451->x9

        #%r452->x9

        #%r453->x9

        #%r454->x9

        #%r455->x9

        #%r456->x9
main:


        #bb39:
bb39:


        #  %r226 = call i32 @quickread()
        mov     x16, #0
        sub     sp, sp, x16
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

        #  store i32 %r226, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     w10, [x9]

        #  %r227 = call i32 @quickread()
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

        #  store i32 %r227, i32* @m
        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     w10, [x9]

        #  call void @_sysy_starttime(i32 97)
        mov     w9, #97
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

        #  %r303 = add i32 0, 0
        mov     w9, #0

        #  %r306 = add i32 0, 0
        mov     w9, #0

        #  %r304 = add i32 0, 0
        mov     w9, #0

        #  %r307 = add i32 0, 0
        mov     w9, #0

        #  %r305 = add i32 0, 0
        mov     w9, #0

        #  %r308 = add i32 0, 0
        mov     w9, #0

        #  br label %bb40

        b     bb40

        #bb40:
bb40:


        #  %r231 = load i32, i32* @m
        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     w10, [x9]

        #  %r232 = icmp ne i32 %r231, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r232, label %bb41, label %bb42

        b.ne     bb41
        b     bb42

        #bb41:
bb41:


        #  %r309 = call i32 @getch()
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

        #  br label %bb43


        #bb43:  %r310 = phi i32 [ %r309, %bb41 ], [ %r315, %bb44 ]
        mov     w10, w9
        b     bb43

        #bb43:
bb43:


        #  %r310 = phi i32 [ %r309, %bb41 ], [ %r315, %bb44 ]

        #  %r235 = icmp ne i32 %r310, 81
        mov     w9, #81
        cmp     w10, w9

        #  br i1 %r235, label %bb46, label %bb45

        b.ne     bb46
        b     bb45

        #bb46:
bb46:


        #  %r237 = icmp ne i32 %r310, 85
        mov     w9, #85
        cmp     w10, w9

        #  br i1 %r237, label %bb44, label %bb45

        b.ne     bb44
        b     bb45

        #bb44:
bb44:


        #  %r315 = call i32 @getch()
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

        #  br label %bb43


        #bb43:  %r310 = phi i32 [ %r309, %bb41 ], [ %r315, %bb44 ]
        mov     w10, w9
        b     bb43

        #bb45:
bb45:


        #  %r240 = icmp eq i32 %r310, 81
        mov     w9, #81
        cmp     w10, w9

        #  br i1 %r240, label %bb47, label %bb48

        b.eq     bb47
        b     bb48

        #bb47:
bb47:


        #  %r313 = call i32 @quickread()
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

        #  %r314 = call i32 @quickread()
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

        #  %r245 = call i32 @same(i32 %r313, i32 %r314)
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

        #  call void @putint(i32 %r245)
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

        #  br label %bb49

        b     bb49

        #bb48:
bb48:


        #  %r311 = call i32 @quickread()
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

        #  %r312 = call i32 @quickread()
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

        #  call void @addedge(i32 %r311, i32 %r312)
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

        #  br label %bb49

        b     bb49

        #bb49:
bb49:


        #  %r250 = load i32, i32* @m
        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     w9, [x9]

        #  %r251 = sub i32 %r250, 1
        sub     w10, w9, #1

        #  store i32 %r251, i32* @m
        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     w10, [x9]

        #  br label %bb40

        b     bb40

        #bb42:
bb42:


        #  call void @_sysy_stoptime(i32 117)
        mov     w9, #117
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
