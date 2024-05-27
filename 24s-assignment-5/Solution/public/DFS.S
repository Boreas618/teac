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
        .zero   40040
next:
        .zero   40040
head:
        .zero   8040
cnt:
        .quad   0
vis:
        .zero   8040
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
        //%r286->x12
        //%r285->x12
        //%r284->x12
        //%r283->x11
        //%r282->x11
        //%r281->x10
        //%r280->x10
        //%r279->x9
        //%r243->x9
        //%r242->x10
        //%r241->x9
        //%r123->x9
        //%r240->x10
        //%r233->x10
        //%r292->x9
        //%r235->x11
        //%r239->x9
        //%r287->x9
        //%r229->x9
        //%r288->x12
        //%r230->x9
        //%r289->x12
        //%r231->x9
        //%r290->x12
        //%r116->x10
        //%r234->x11
        //%r232->x9
        //%r291->x9
        //%r118->x9
        //%r236->x9
        //%r237->x11
        //%r238->x9
quickread:

        //bb1:

bb1:

        //  %r229 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r232 = call i32 @getch()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r230 = add i32 0, 0

        mov     x10, #0
        //  %r233 = add i32 0, 0

        mov     x10, #0
        mov     x10, x10
        //  %r231 = add i32 0, 0

        mov     x11, #0
        //  %r234 = add i32 0, 0

        mov     x11, #0
        mov     x11, x11
        //  br label %bb2


        //bb2:  %r235 = phi i32 [ %r234, %bb1 ], [ %r237, %bb8 ]

        mov     x11, x11
        //bb2:  %r236 = phi i32 [ %r232, %bb1 ], [ %r238, %bb8 ]

        mov     x9, x9
        b     bb2
        //bb2:

bb2:

        //  %r235 = phi i32 [ %r234, %bb1 ], [ %r237, %bb8 ]

        //  %r236 = phi i32 [ %r232, %bb1 ], [ %r238, %bb8 ]

        //  %r105 = icmp slt i32 %r236, 48

        mov     x12, #48
        cmp     x9, x12
        //  br i1 %r105, label %bb3, label %bb5


        b.lt     bb3
        b     bb5
        //bb5:

bb5:

        //  %r107 = icmp sgt i32 %r236, 57

        mov     x12, #57
        cmp     x9, x12
        //  br i1 %r107, label %bb3, label %bb4


        b.gt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r109 = icmp eq i32 %r236, 45

        mov     x12, #45
        cmp     x9, x12
        //  br i1 %r109, label %bb6, label %bb7


        b.eq     bb6
        b     bb7
        //bb6:

bb6:

        //  %r239 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb8


        //bb8:  %r237 = phi i32 [ %r239, %bb6 ], [ %r235, %bb7 ]

        mov     x11, x9
        b     bb8
        //bb7:

bb7:

        //  br label %bb8


        //bb8:  %r237 = phi i32 [ %r239, %bb6 ], [ %r235, %bb7 ]

        mov     x11, x11
        b     bb8
        //bb8:

bb8:

        //  %r237 = phi i32 [ %r239, %bb6 ], [ %r235, %bb7 ]

        //  %r238 = call i32 @getch()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb2


        //bb2:  %r235 = phi i32 [ %r234, %bb1 ], [ %r237, %bb8 ]

        mov     x11, x11
        //bb2:  %r236 = phi i32 [ %r232, %bb1 ], [ %r238, %bb8 ]

        mov     x9, x9
        b     bb2
        //bb4:

bb4:

        //  br label %bb9


        //bb9:  %r240 = phi i32 [ %r233, %bb4 ], [ %r242, %bb10 ]

        mov     x10, x10
        //bb9:  %r241 = phi i32 [ %r236, %bb4 ], [ %r243, %bb10 ]

        mov     x9, x9
        b     bb9
        //bb9:

bb9:

        //  %r240 = phi i32 [ %r233, %bb4 ], [ %r242, %bb10 ]

        //  %r241 = phi i32 [ %r236, %bb4 ], [ %r243, %bb10 ]

        //  %r112 = icmp sge i32 %r241, 48

        mov     x12, #48
        cmp     x9, x12
        //  br i1 %r112, label %bb12, label %bb11


        b.ge     bb12
        b     bb11
        //bb12:

bb12:

        //  %r114 = icmp sle i32 %r241, 57

        mov     x12, #57
        cmp     x9, x12
        //  br i1 %r114, label %bb10, label %bb11


        b.le     bb10
        b     bb11
        //bb10:

bb10:

        //  %r116 = mul i32 %r240, 10

        mov     x12, #10
        mul     x10, x10, x12
        //  %r118 = add i32 %r116, %r241

        add     x9, x10, x9
        //  %r242 = sub i32 %r118, 48

        sub     x10, x9, #48
        //  %r243 = call i32 @getch()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb9


        //bb9:  %r240 = phi i32 [ %r233, %bb4 ], [ %r242, %bb10 ]

        mov     x10, x10
        //bb9:  %r241 = phi i32 [ %r236, %bb4 ], [ %r243, %bb10 ]

        mov     x9, x9
        b     bb9
        //bb11:

bb11:

        //  %r122 = icmp ne i32 %r235, 0

        mov     x9, #0
        cmp     x11, x9
        //  br i1 %r122, label %bb13, label %bb14


        b.ne     bb13
        b     bb14
        //bb13:

bb13:

        //  %r123 = sub i32 0, %r240

        mov     x9, #0
        sub     x9, x9, x10
        //  ret i32 %r123

        mov     x0, x9
        mov     sp, x29
        ret
        //bb14:

bb14:

        //  ret i32 %r240

        mov     x0, x10
        mov     sp, x29
        ret
        //%r323->x10
        //%r320->x11
        //%r316->x10
        //%r310->x11
        //%r307->x12
        //%r302->x12
        //%r301->x11
        //%r300->x12
        //%r299->x11
        //%r298->x11
        //%r297->x12
        //%r296->x11
        //%r319->x11
        //%r142->x12
        //%r317->x11
        //%r140->x12
        //%r315->x11
        //%r138->x11
        //%r314->x12
        //%r137->x12
        //%r313->x11
        //%r136->x13
        //%r312->x11
        //%r135->x11
        //%r311->x11
        //%r134->x11
        //%r309->x12
        //%r132->x11
        //%r321->x12
        //%r144->x12
        //%r308->x13
        //%r131->x12
        //%r306->x11
        //%r247->x9
        //%r318->x10
        //%r141->x11
        //%r303->x12
        //%r244->x9
        //%r126->x10
        //%r155->x10
        //%r322->x11
        //%r145->x11
        //%r324->x10
        //%r147->x10
        //%r325->x10
        //%r148->x10
        //%r293->x9
        //%r149->x12
        //%r294->x9
        //%r150->x11
        //%r295->x11
        //%r151->x11
        //%r153->x9
        //%r154->x9
        //%r304->x13
        //%r245->x9
        //%r305->x12
        //%r128->x11
        //%r246->x10
        //%r326->x9
        //%r327->x9
        //%r328->x9
addedge:

        //bb49:

bb49:

        //  %r244 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r246 = add i32 %r126, 0

        mov     x10, x10
        //  %r245 = add i32 0, 0

        mov     x9, #0
        //  %r247 = add i32 %r128, 0

        mov     x9, x11
        //  %r131 = load i32, i32* @cnt

        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     x12, [x11]
        //  %r132 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r131

        mov     x11, #8
        mul     x12, x12, x11
        adrp     x11, to
        add     x11, x11, #:lo12:to
        add     x11, x11, x12
        //  store i32 %r247, i32* %r132

        str     x9, [x11]
        //  %r134 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r246

        mov     x11, #8
        mul     x12, x10, x11
        adrp     x11, head
        add     x11, x11, #:lo12:head
        add     x11, x11, x12
        //  %r135 = load i32, i32* %r134

        ldr     x11, [x11]
        //  %r136 = load i32, i32* @cnt

        adrp     x12, cnt
        add     x12, x12, #:lo12:cnt
        ldr     x13, [x12]
        //  %r137 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r136

        mov     x12, #8
        mul     x13, x13, x12
        adrp     x12, next
        add     x12, x12, #:lo12:next
        add     x12, x12, x13
        //  store i32 %r135, i32* %r137

        str     x11, [x12]
        //  %r138 = load i32, i32* @cnt

        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     x11, [x11]
        //  %r140 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r246

        mov     x12, #8
        mul     x13, x10, x12
        adrp     x12, head
        add     x12, x12, #:lo12:head
        add     x12, x12, x13
        //  store i32 %r138, i32* %r140

        str     x11, [x12]
        //  %r141 = load i32, i32* @cnt

        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     x11, [x11]
        //  %r142 = add i32 %r141, 1

        add     x12, x11, #1
        //  store i32 %r142, i32* @cnt

        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        str     x12, [x11]
        //  %r144 = load i32, i32* @cnt

        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     x12, [x11]
        //  %r145 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r144

        mov     x11, #8
        mul     x12, x12, x11
        adrp     x11, to
        add     x11, x11, #:lo12:to
        add     x11, x11, x12
        //  store i32 %r246, i32* %r145

        str     x10, [x11]
        //  %r147 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r247

        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, head
        add     x10, x10, #:lo12:head
        add     x10, x10, x11
        //  %r148 = load i32, i32* %r147

        ldr     x10, [x10]
        //  %r149 = load i32, i32* @cnt

        adrp     x11, cnt
        add     x11, x11, #:lo12:cnt
        ldr     x12, [x11]
        //  %r150 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r149

        mov     x11, #8
        mul     x12, x12, x11
        adrp     x11, next
        add     x11, x11, #:lo12:next
        add     x11, x11, x12
        //  store i32 %r148, i32* %r150

        str     x10, [x11]
        //  %r151 = load i32, i32* @cnt

        adrp     x10, cnt
        add     x10, x10, #:lo12:cnt
        ldr     x11, [x10]
        //  %r153 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r247

        mov     x10, #8
        mul     x10, x9, x10
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x10
        //  store i32 %r151, i32* %r153

        str     x11, [x9]
        //  %r154 = load i32, i32* @cnt

        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     x9, [x9]
        //  %r155 = add i32 %r154, 1

        add     x10, x9, #1
        //  store i32 %r155, i32* @cnt

        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        str     x10, [x9]
        //  ret void

        mov     sp, x29
        ret
        //%r159->x12
        //%r250->x9
        //%r161->x10
        //%r330->x9
        //%r248->x9
        //%r249->x9
        //%r251->x9
        //%r329->x9
        //%r331->x10
        //%r332->x10
        //%r333->x10
        //%r334->x11
        //%r335->x10
init:

        //bb17:

bb17:

        //  %r248 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r249 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb18


        //bb18:  %r250 = phi i32 [ %r249, %bb17 ], [ %r251, %bb19 ]

        mov     x9, x9
        b     bb18
        //bb18:

bb18:

        //  %r250 = phi i32 [ %r249, %bb17 ], [ %r251, %bb19 ]

        //  %r158 = icmp slt i32 %r250, 1005

        mov     x10, #1005
        cmp     x9, x10
        //  br i1 %r158, label %bb19, label %bb20


        b.lt     bb19
        b     bb20
        //bb19:

bb19:

        //  %r159 = sub i32 0, 1

        mov     x10, #0
        sub     x12, x10, #1
        //  %r161 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r250

        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, head
        add     x10, x10, #:lo12:head
        add     x10, x10, x11
        //  store i32 %r159, i32* %r161

        str     x12, [x10]
        //  %r251 = add i32 %r250, 1

        add     x9, x9, #1
        //  br label %bb18


        //bb18:  %r250 = phi i32 [ %r249, %bb17 ], [ %r251, %bb19 ]

        mov     x9, x9
        b     bb18
        //bb20:

bb20:

        //  ret void

        mov     sp, x29
        ret
        //%r166->x10
        //%r169->x11
        //%r338->x10
        //%r252->x9
        //%r253->x9
        //%r254->x9
        //%r255->x9
        //%r336->x9
        //%r337->x9
        //%r339->x10
        //%r340->x11
        //%r341->x10
        //%r342->x10
clear:

        //bb21:

bb21:

        //  %r252 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r253 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb22


        //bb22:  %r254 = phi i32 [ %r253, %bb21 ], [ %r255, %bb23 ]

        mov     x9, x9
        b     bb22
        //bb22:

bb22:

        //  %r254 = phi i32 [ %r253, %bb21 ], [ %r255, %bb23 ]

        //  %r166 = load i32, i32* @n

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     x10, [x10]
        //  %r167 = icmp sle i32 %r254, %r166

        cmp     x9, x10
        //  br i1 %r167, label %bb23, label %bb24


        b.le     bb23
        b     bb24
        //bb23:

bb23:

        //  %r169 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r254

        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, vis
        add     x10, x10, #:lo12:vis
        add     x11, x10, x11
        //  store i32 0, i32* %r169

        mov     x10, #0
        str     x10, [x11]
        //  %r255 = add i32 %r254, 1

        add     x9, x9, #1
        //  br label %bb22


        //bb22:  %r254 = phi i32 [ %r253, %bb21 ], [ %r255, %bb23 ]

        mov     x9, x9
        b     bb22
        //bb24:

bb24:

        //  ret void

        mov     sp, x29
        ret
        //%r265->x9
        //%r350->x10
        //%r263->x10
        //%r349->x10
        //%r172->x11
        //%r262->x9
        //%r347->x10
        //%r260->x9
        //%r201->x9
        //%r348->x12
        //%r261->x11
        //%r174->x10
        //%r351->x9
        //%r264->x9
        //%r177->x12
        //%r354->x9
        //%r190->x9
        //%r367->x9
        //%r183->x9
        //%r360->x13
        //%r186->x9
        //%r363->x9
        //%r193->x12
        //%r345->x9
        //%r258->x9
        //%r194->x13
        //%r346->x11
        //%r259->x9
        //%r343->x9
        //%r198->x12
        //%r257->x9
        //%r256->x9
        //%r344->x9
        //%r352->x10
        //%r353->x10
        //%r355->x9
        //%r356->x9
        //%r357->x12
        //%r358->x9
        //%r359->x12
        //%r361->x12
        //%r362->x12
        //%r364->x9
        //%r365->x9
        //%r366->x10
        //%r368->x9
same:

        //bb50:

bb50:

        //  %r256 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        //  %r257 = add i32 0, 0

        mov     x9, #0
        //  %r258 = add i32 0, 0

        mov     x9, #0
        //  %r260 = add i32 %r172, 0

        mov     x9, x11
        //  %r259 = add i32 0, 0

        mov     x11, #0
        //  %r261 = add i32 %r174, 0

        mov     x11, x10
        //  %r177 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r260

        mov     x10, #8
        mul     x12, x9, x10
        adrp     x10, vis
        add     x10, x10, #:lo12:vis
        add     x12, x10, x12
        //  store i32 1, i32* %r177

        mov     x10, #1
        str     x10, [x12]
        //  %r180 = icmp eq i32 %r260, %r261

        cmp     x9, x11
        //  br i1 %r180, label %bb26, label %bb27


        b.eq     bb26
        b     bb27
        //bb26:

bb26:

        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //bb27:

bb27:

        //  %r183 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r260

        mov     x10, #8
        mul     x10, x9, x10
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x10
        //  %r262 = load i32, i32* %r183

        ldr     x9, [x9]
        //  br label %bb29


        //bb29:  %r263 = phi i32 [ %r262, %bb27 ], [ %r265, %bb33 ]

        mov     x10, x9
        b     bb29
        //bb29:

bb29:

        //  %r263 = phi i32 [ %r262, %bb27 ], [ %r265, %bb33 ]

        //  %r186 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  %r187 = icmp ne i32 %r263, %r186

        cmp     x10, x9
        //  br i1 %r187, label %bb30, label %bb31


        b.ne     bb30
        b     bb31
        //bb30:

bb30:

        //  %r190 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r263

        mov     x9, #8
        mul     x12, x10, x9
        adrp     x9, to
        add     x9, x9, #:lo12:to
        add     x9, x9, x12
        //  %r264 = load i32, i32* %r190

        ldr     x9, [x9]
        //  %r193 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r264

        mov     x12, #8
        mul     x13, x9, x12
        adrp     x12, vis
        add     x12, x12, #:lo12:vis
        add     x12, x12, x13
        //  %r194 = load i32, i32* %r193

        ldr     x13, [x12]
        //  %r195 = icmp eq i32 %r194, 0

        mov     x12, #0
        cmp     x13, x12
        //  br i1 %r195, label %bb35, label %bb33


        b.eq     bb35
        b     bb33
        //bb35:

bb35:

        //  %r198 = call i32 @same(i32 %r264, i32 %r261)

        mov     x0, x9
        mov     x1, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     same
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x12, x0
        //  %r199 = icmp ne i32 %r198, 0

        mov     x9, #0
        cmp     x12, x9
        //  br i1 %r199, label %bb32, label %bb33


        b.ne     bb32
        b     bb33
        //bb32:

bb32:

        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //bb33:

bb33:

        //  %r201 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r263

        mov     x9, #8
        mul     x10, x10, x9
        adrp     x9, next
        add     x9, x9, #:lo12:next
        add     x9, x9, x10
        //  %r265 = load i32, i32* %r201

        ldr     x9, [x9]
        //  br label %bb29


        //bb29:  %r263 = phi i32 [ %r262, %bb27 ], [ %r265, %bb33 ]

        mov     x10, x9
        b     bb29
        //bb31:

bb31:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r376->x9
        //%r375->x9
        //%r374->x9
        //%r371->x9
        //%r370->x9
        //%r369->x9
        //%r278->x9
        //%r277->x9
        //%r276->x10
        //%r275->x9
        //%r274->x10
        //%r273->x10
        //%r377->x9
        //%r203->x10
        //%r380->x9
        //%r268->x9
        //%r386->x9
        //%r378->x9
        //%r204->x10
        //%r381->x9
        //%r269->x9
        //%r387->x9
        //%r222->x9
        //%r372->x9
        //%r227->x9
        //%r208->x10
        //%r267->x9
        //%r385->x9
        //%r266->x9
        //%r384->x9
        //%r373->x9
        //%r228->x10
        //%r270->x9
        //%r271->x9
        //%r272->x9
        //%r379->x9
        //%r382->x9
        //%r383->x9
main:

        //bb36:

bb36:

        //  call void @_sysy_starttime(i32 74)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #74
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
        //  %r203 = call i32 @quickread()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  store i32 %r203, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     x10, [x9]
        //  %r204 = call i32 @quickread()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  store i32 %r204, i32* @m

        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     x10, [x9]
        //  call void @init()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     init
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r266 = add i32 0, 0

        mov     x9, #0
        //  %r269 = add i32 0, 0

        mov     x9, #0
        //  %r267 = add i32 0, 0

        mov     x9, #0
        //  %r270 = add i32 0, 0

        mov     x9, #0
        //  %r268 = add i32 0, 0

        mov     x9, #0
        //  %r271 = add i32 0, 0

        mov     x9, #0
        //  br label %bb37


        b     bb37
        //bb37:

bb37:

        //  %r208 = load i32, i32* @m

        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     x10, [x9]
        //  %r209 = icmp ne i32 %r208, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r209, label %bb38, label %bb39


        b.ne     bb38
        b     bb39
        //bb38:

bb38:

        //  %r272 = call i32 @getch()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb40


        //bb40:  %r273 = phi i32 [ %r272, %bb38 ], [ %r278, %bb41 ]

        mov     x10, x9
        b     bb40
        //bb40:

bb40:

        //  %r273 = phi i32 [ %r272, %bb38 ], [ %r278, %bb41 ]

        //  %r212 = icmp ne i32 %r273, 81

        mov     x9, #81
        cmp     x10, x9
        //  br i1 %r212, label %bb43, label %bb42


        b.ne     bb43
        b     bb42
        //bb43:

bb43:

        //  %r214 = icmp ne i32 %r273, 85

        mov     x9, #85
        cmp     x10, x9
        //  br i1 %r214, label %bb41, label %bb42


        b.ne     bb41
        b     bb42
        //bb41:

bb41:

        //  %r278 = call i32 @getch()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb40


        //bb40:  %r273 = phi i32 [ %r272, %bb38 ], [ %r278, %bb41 ]

        mov     x10, x9
        b     bb40
        //bb42:

bb42:

        //  %r217 = icmp eq i32 %r273, 81

        mov     x9, #81
        cmp     x10, x9
        //  br i1 %r217, label %bb44, label %bb45


        b.eq     bb44
        b     bb45
        //bb44:

bb44:

        //  %r276 = call i32 @quickread()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r277 = call i32 @quickread()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  call void @clear()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     clear
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r222 = call i32 @same(i32 %r276, i32 %r277)

        mov     x0, x10
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     same
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  call void @putint(i32 %r222)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 10)

        mov     x9, #10
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb46


        b     bb46
        //bb45:

bb45:

        //  %r274 = call i32 @quickread()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r275 = call i32 @quickread()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     quickread
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  call void @addedge(i32 %r274, i32 %r275)

        mov     x0, x10
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     addedge
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb46


        b     bb46
        //bb46:

bb46:

        //  %r227 = load i32, i32* @m

        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     x9, [x9]
        //  %r228 = sub i32 %r227, 1

        sub     x10, x9, #1
        //  store i32 %r228, i32* @m

        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     x10, [x9]
        //  br label %bb37


        b     bb37
        //bb39:

bb39:

        //  call void @_sysy_stoptime(i32 96)

        mov     x9, #96
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
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
