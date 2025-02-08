.section .data
.global    hashmod
.global    bucket
.global    head
.global    next
.global    nextvalue
.global    key
.global    value
.global    cnt
.global    keys
.global    values
.global    requests
.global    ans
hashmod:
        .quad   0
bucket:
        .zero   40000000
head:
        .zero   40000000
next:
        .zero   40000000
nextvalue:
        .zero   40000000
key:
        .zero   40000000
value:
        .zero   40000000
cnt:
        .quad   0
keys:
        .zero   40000000
values:
        .zero   40000000
requests:
        .zero   40000000
ans:
        .zero   40000000
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global hash
.global insert
.global reduce
.global main

        #%r100->x10

        #%r269->x9

        #%r321->x9

        #%r104->x9

        #%r105->x11

        #%r106->x9

        #%r107->x9

        #%r108->x9

        #%r270->x10

        #%r322->x9

        #%r320->x9
hash:


        #bb38:
bb38:


        #  %r269 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0

        #  %r270 = add i32 %r100, 0
        mov     w10, w10

        #  br label %bb1

        b     bb1

        #bb1:
bb1:


        #  %r104 = load i32, i32* @hashmod
        adrp     x9, hashmod
        add     x9, x9, #:lo12:hashmod
        ldr     w9, [x9]

        #  %r105 = sdiv i32 %r270, %r104
        sdiv     w11, w10, w9

        #  %r106 = load i32, i32* @hashmod
        adrp     x9, hashmod
        add     x9, x9, #:lo12:hashmod
        ldr     w9, [x9]

        #  %r107 = mul i32 %r105, %r106
        mul     w9, w11, w9

        #  %r108 = sub i32 %r270, %r107
        sub     w9, w10, w9

        #  ret i32 %r108
        mov     w0, w9
        mov     sp, x29
        ret

        #%r395->x13

        #%r394->x13

        #%r137->x9

        #%r393->x9

        #%r392->x13

        #%r390->x13

        #%r133->x10

        #%r389->x13

        #%r132->x10

        #%r382->x13

        #%r379->x9

        #%r122->x9

        #%r377->x9

        #%r120->x9

        #%r373->x10

        #%r370->x13

        #%r369->x12

        #%r368->x12

        #%r111->x10

        #%r367->x10

        #%r366->x12

        #%r109->x11

        #%r364->x10

        #%r362->x13

        #%r361->x14

        #%r360->x13

        #%r359->x13

        #%r358->x9

        #%r357->x13

        #%r356->x9

        #%r355->x9

        #%r354->x9

        #%r353->x9

        #%r352->x10

        #%r351->x9

        #%r350->x9

        #%r349->x9

        #%r348->x9

        #%r347->x10

        #%r346->x9

        #%r345->x9

        #%r344->x9

        #%r343->x10

        #%r342->x9

        #%r341->x9

        #%r340->x9

        #%r339->x10

        #%r338->x9

        #%r337->x9

        #%r336->x10

        #%r335->x13

        #%r334->x13

        #%r333->x9

        #%r332->x9

        #%r331->x9

        #%r330->x9

        #%r329->x9

        #%r328->x13

        #%r157->x10

        #%r275->x12

        #%r143->x13

        #%r400->x9

        #%r142->x13

        #%r399->x10

        #%r391->x14

        #%r134->x10

        #%r388->x9

        #%r131->x10

        #%r387->x13

        #%r130->x9

        #%r386->x9

        #%r129->x10

        #%r363->x10

        #%r168->x13

        #%r376->x9

        #%r365->x10

        #%r271->x9

        #%r378->x10

        #%r121->x13

        #%r124->x10

        #%r381->x13

        #%r323->x9

        #%r371->x12

        #%r117->x9

        #%r374->x10

        #%r176->x10

        #%r384->x9

        #%r127->x9

        #%r324->x9

        #%r372->x10

        #%r118->x13

        #%r375->x9

        #%r177->x9

        #%r385->x9

        #%r326->x9

        #%r179->x10

        #%r327->x9

        #%r155->x9

        #%r146->x10

        #%r403->x10

        #%r273->x9

        #%r380->x9

        #%r126->x10

        #%r383->x9

        #%r158->x9

        #%r149->x10

        #%r406->x9

        #%r276->x11

        #%r160->x9

        #%r151->x13

        #%r408->x9

        #%r278->x9

        #%r162->x9

        #%r153->x12

        #%r410->x9

        #%r280->x9

        #%r163->x13

        #%r165->x9

        #%r166->x9

        #%r167->x14

        #%r169->x9

        #%r171->x10

        #%r173->x10

        #%r174->x9

        #%r178->x10

        #%r272->x9

        #%r147->x12

        #%r404->x9

        #%r274->x9

        #%r150->x10

        #%r407->x10

        #%r277->x10

        #%r152->x12

        #%r409->x9

        #%r279->x9

        #%r325->x9

        #%r396->x10

        #%r397->x9

        #%r398->x9

        #%r401->x9

        #%r402->x9

        #%r405->x9
insert:


        #bb39:
bb39:


        #  %r271 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w11, w0
        mov     w10, w1
        mov     w9, #0

        #  %r272 = add i32 0, 0
        mov     w9, #0

        #  %r273 = add i32 0, 0
        mov     w9, #0

        #  %r275 = add i32 %r109, 0
        mov     w12, w11

        #  %r274 = add i32 0, 0
        mov     w9, #0

        #  %r276 = add i32 %r111, 0
        mov     w11, w10

        #  br label %bb2

        b     bb2

        #bb2:
bb2:


        #  %r277 = call i32 @hash(i32 %r275)
        mov     w0, w12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     hash
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r117 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
        mov     x9, #4
        mul     x13, x10, x9
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x13

        #  %r118 = load i32, i32* %r117
        ldr     w13, [x9]

        #  %r119 = icmp eq i32 %r118, 0
        mov     w9, #0
        cmp     w13, w9

        #  br i1 %r119, label %bb3, label %bb4

        b.eq     bb3
        b     bb4

        #bb3:
bb3:


        #  %r120 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w9, [x9]

        #  %r121 = add i32 %r120, 1
        add     w13, w9, #1

        #  store i32 %r121, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        str     w13, [x9]

        #  %r122 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w9, [x9]

        #  %r124 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
        mov     x13, #4
        mul     x13, x10, x13
        adrp     x10, head
        add     x10, x10, #:lo12:head
        add     x10, x10, x13

        #  store i32 %r122, i32* %r124
        str     w9, [x10]

        #  %r126 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w10, [x9]

        #  %r127 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @key, i32 0, i32 %r126
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, key
        add     x9, x9, #:lo12:key
        add     x9, x9, x10

        #  store i32 %r275, i32* %r127
        str     w12, [x9]

        #  %r129 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w10, [x9]

        #  %r130 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @value, i32 0, i32 %r129
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, value
        add     x9, x9, #:lo12:value
        add     x9, x9, x10

        #  store i32 %r276, i32* %r130
        str     w11, [x9]

        #  %r131 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w10, [x9]

        #  %r132 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @next, i32 0, i32 %r131
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, next
        add     x9, x9, #:lo12:next
        add     x10, x9, x10

        #  store i32 0, i32* %r132
        mov     w9, #0
        str     w9, [x10]

        #  %r133 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w10, [x9]

        #  %r134 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r133
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, nextvalue
        add     x9, x9, #:lo12:nextvalue
        add     x10, x9, x10

        #  store i32 0, i32* %r134
        mov     w9, #0
        str     w9, [x10]

        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #bb4:
bb4:


        #  br label %bb5

        b     bb5

        #bb5:
bb5:


        #  %r137 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
        mov     x9, #4
        mul     x13, x10, x9
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x13

        #  %r278 = load i32, i32* %r137
        ldr     w9, [x9]

        #  br label %bb6


        #bb6:  %r279 = phi i32 [ %r278, %bb5 ], [ %r280, %bb11 ]
        mov     w9, w9
        b     bb6

        #bb6:
bb6:


        #  %r279 = phi i32 [ %r278, %bb5 ], [ %r280, %bb11 ]

        #  %r140 = icmp ne i32 %r279, 0
        mov     w13, #0
        cmp     w9, w13

        #  br i1 %r140, label %bb7, label %bb8

        b.ne     bb7
        b     bb8

        #bb7:
bb7:


        #  %r142 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @key, i32 0, i32 %r279
        mov     x13, #4
        mul     x14, x9, x13
        adrp     x13, key
        add     x13, x13, #:lo12:key
        add     x13, x13, x14

        #  %r143 = load i32, i32* %r142
        ldr     w13, [x13]

        #  %r145 = icmp eq i32 %r143, %r275
        cmp     w13, w12

        #  br i1 %r145, label %bb9, label %bb10

        b.eq     bb9
        b     bb10

        #bb9:
bb9:


        #  %r146 = load i32, i32* @cnt
        adrp     x10, cnt
        add     x10, x10, #:lo12:cnt
        ldr     w10, [x10]

        #  %r147 = add i32 %r146, 1
        add     w12, w10, #1

        #  store i32 %r147, i32* @cnt
        adrp     x10, cnt
        add     x10, x10, #:lo12:cnt
        str     w12, [x10]

        #  %r149 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r279
        mov     x10, #4
        mul     x12, x9, x10
        adrp     x10, nextvalue
        add     x10, x10, #:lo12:nextvalue
        add     x10, x10, x12

        #  %r150 = load i32, i32* %r149
        ldr     w10, [x10]

        #  %r151 = load i32, i32* @cnt
        adrp     x12, cnt
        add     x12, x12, #:lo12:cnt
        ldr     w13, [x12]

        #  %r152 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r151
        mov     x12, #4
        mul     x13, x13, x12
        adrp     x12, nextvalue
        add     x12, x12, #:lo12:nextvalue
        add     x12, x12, x13

        #  store i32 %r150, i32* %r152
        str     w10, [x12]

        #  %r153 = load i32, i32* @cnt
        adrp     x10, cnt
        add     x10, x10, #:lo12:cnt
        ldr     w12, [x10]

        #  %r155 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r279
        mov     x10, #4
        mul     x10, x9, x10
        adrp     x9, nextvalue
        add     x9, x9, #:lo12:nextvalue
        add     x9, x9, x10

        #  store i32 %r153, i32* %r155
        str     w12, [x9]

        #  %r157 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w10, [x9]

        #  %r158 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @value, i32 0, i32 %r157
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, value
        add     x9, x9, #:lo12:value
        add     x9, x9, x10

        #  store i32 %r276, i32* %r158
        str     w11, [x9]

        #  ret i32 1
        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret

        #bb10:
bb10:


        #  br label %bb11

        b     bb11

        #bb11:
bb11:


        #  %r160 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @next, i32 0, i32 %r279
        mov     x13, #4
        mul     x13, x9, x13
        adrp     x9, next
        add     x9, x9, #:lo12:next
        add     x9, x9, x13

        #  %r280 = load i32, i32* %r160
        ldr     w9, [x9]

        #  br label %bb6


        #bb6:  %r279 = phi i32 [ %r278, %bb5 ], [ %r280, %bb11 ]
        mov     w9, w9
        b     bb6

        #bb8:
bb8:


        #  %r162 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w9, [x9]

        #  %r163 = add i32 %r162, 1
        add     w13, w9, #1

        #  store i32 %r163, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        str     w13, [x9]

        #  %r165 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
        mov     x9, #4
        mul     x13, x10, x9
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x13

        #  %r166 = load i32, i32* %r165
        ldr     w9, [x9]

        #  %r167 = load i32, i32* @cnt
        adrp     x13, cnt
        add     x13, x13, #:lo12:cnt
        ldr     w14, [x13]

        #  %r168 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @next, i32 0, i32 %r167
        mov     x13, #4
        mul     x14, x14, x13
        adrp     x13, next
        add     x13, x13, #:lo12:next
        add     x13, x13, x14

        #  store i32 %r166, i32* %r168
        str     w9, [x13]

        #  %r169 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w9, [x9]

        #  %r171 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
        mov     x13, #4
        mul     x13, x10, x13
        adrp     x10, head
        add     x10, x10, #:lo12:head
        add     x10, x10, x13

        #  store i32 %r169, i32* %r171
        str     w9, [x10]

        #  %r173 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w10, [x9]

        #  %r174 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @key, i32 0, i32 %r173
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, key
        add     x9, x9, #:lo12:key
        add     x9, x9, x10

        #  store i32 %r275, i32* %r174
        str     w12, [x9]

        #  %r176 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w10, [x9]

        #  %r177 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @value, i32 0, i32 %r176
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, value
        add     x9, x9, #:lo12:value
        add     x9, x9, x10

        #  store i32 %r276, i32* %r177
        str     w11, [x9]

        #  %r178 = load i32, i32* @cnt
        adrp     x9, cnt
        add     x9, x9, #:lo12:cnt
        ldr     w10, [x9]

        #  %r179 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r178
        mov     x9, #4
        mul     x10, x10, x9
        adrp     x9, nextvalue
        add     x9, x9, #:lo12:nextvalue
        add     x10, x9, x10

        #  store i32 0, i32* %r179
        mov     w9, #0
        str     w9, [x10]

        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r415->x9

        #%r413->x9

        #%r295->x11

        #%r411->x9

        #%r293->x10

        #%r292->x9

        #%r289->x9

        #%r288->x9

        #%r287->x11

        #%r286->x10

        #%r412->x9

        #%r294->x9

        #%r296->x9

        #%r414->x9

        #%r180->x10

        #%r416->x9

        #%r193->x11

        #%r429->x10

        #%r284->x9

        #%r187->x9

        #%r423->x10

        #%r192->x11

        #%r428->x10

        #%r283->x9

        #%r290->x9

        #%r203->x11

        #%r281->x9

        #%r291->x10

        #%r204->x11

        #%r282->x9

        #%r207->x9

        #%r285->x9

        #%r211->x9

        #%r417->x11

        #%r418->x9

        #%r419->x11

        #%r420->x11

        #%r421->x12

        #%r422->x11

        #%r424->x11

        #%r425->x11

        #%r426->x12

        #%r427->x11

        #%r430->x9

        #%r431->x11

        #%r432->x11

        #%r433->x9

        #%r434->x9
reduce:


        #bb42:
bb42:


        #  %r281 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0

        #  %r282 = add i32 0, 0
        mov     w9, #0

        #  %r283 = add i32 0, 0
        mov     w9, #0

        #  %r284 = add i32 0, 0
        mov     w9, #0

        #  %r285 = add i32 0, 0
        mov     w9, #0

        #  %r286 = add i32 %r180, 0
        mov     w10, w10

        #  br label %bb12

        b     bb12

        #bb12:
bb12:


        #  %r287 = call i32 @hash(i32 %r286)
        mov     w0, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     hash
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  %r187 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r287
        mov     x9, #4
        mul     x11, x11, x9
        adrp     x9, head
        add     x9, x9, #:lo12:head
        add     x9, x9, x11

        #  %r288 = load i32, i32* %r187
        ldr     w9, [x9]

        #  br label %bb13


        #bb13:  %r289 = phi i32 [ %r288, %bb12 ], [ %r290, %bb18 ]
        mov     w9, w9
        b     bb13

        #bb13:
bb13:


        #  %r289 = phi i32 [ %r288, %bb12 ], [ %r290, %bb18 ]

        #  %r190 = icmp ne i32 %r289, 0
        mov     w11, #0
        cmp     w9, w11

        #  br i1 %r190, label %bb14, label %bb15

        b.ne     bb14
        b     bb15

        #bb14:
bb14:


        #  %r192 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @key, i32 0, i32 %r289
        mov     x11, #4
        mul     x12, x9, x11
        adrp     x11, key
        add     x11, x11, #:lo12:key
        add     x11, x11, x12

        #  %r193 = load i32, i32* %r192
        ldr     w11, [x11]

        #  %r195 = icmp eq i32 %r193, %r286
        cmp     w11, w10

        #  br i1 %r195, label %bb16, label %bb17

        b.eq     bb16
        b     bb17

        #bb16:
bb16:


        #  %r291 = add i32 0, 0
        mov     w10, #0
        mov     w10, w10

        #  %r292 = add i32 %r289, 0
        mov     w9, w9

        #  br label %bb19


        #bb19:  %r293 = phi i32 [ %r291, %bb16 ], [ %r295, %bb20 ]
        mov     w10, w10

        #bb19:  %r294 = phi i32 [ %r292, %bb16 ], [ %r296, %bb20 ]
        mov     w9, w9
        b     bb19

        #bb19:
bb19:


        #  %r293 = phi i32 [ %r291, %bb16 ], [ %r295, %bb20 ]

        #  %r294 = phi i32 [ %r292, %bb16 ], [ %r296, %bb20 ]

        #  %r200 = icmp ne i32 %r294, 0
        mov     w11, #0
        cmp     w9, w11

        #  br i1 %r200, label %bb20, label %bb21

        b.ne     bb20
        b     bb21

        #bb20:
bb20:


        #  %r203 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @value, i32 0, i32 %r294
        mov     x11, #4
        mul     x12, x9, x11
        adrp     x11, value
        add     x11, x11, #:lo12:value
        add     x11, x11, x12

        #  %r204 = load i32, i32* %r203
        ldr     w11, [x11]

        #  %r295 = add i32 %r293, %r204
        add     w11, w10, w11

        #  %r207 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r294
        mov     x10, #4
        mul     x10, x9, x10
        adrp     x9, nextvalue
        add     x9, x9, #:lo12:nextvalue
        add     x9, x9, x10

        #  %r296 = load i32, i32* %r207
        ldr     w9, [x9]

        #  br label %bb19


        #bb19:  %r293 = phi i32 [ %r291, %bb16 ], [ %r295, %bb20 ]
        mov     w10, w11

        #bb19:  %r294 = phi i32 [ %r292, %bb16 ], [ %r296, %bb20 ]
        mov     w9, w9
        b     bb19

        #bb21:
bb21:


        #  ret i32 %r293
        mov     w0, w10
        mov     sp, x29
        ret

        #bb17:
bb17:


        #  br label %bb18

        b     bb18

        #bb18:
bb18:


        #  %r211 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @next, i32 0, i32 %r289
        mov     x11, #4
        mul     x11, x9, x11
        adrp     x9, next
        add     x9, x9, #:lo12:next
        add     x9, x9, x11

        #  %r290 = load i32, i32* %r211
        ldr     w9, [x9]

        #  br label %bb13


        #bb13:  %r289 = phi i32 [ %r288, %bb12 ], [ %r290, %bb18 ]
        mov     w9, w9
        b     bb13

        #bb15:
bb15:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r455->x12

        #%r454->x9

        #%r453->x9

        #%r452->x13

        #%r451->x14

        #%r450->x13

        #%r448->x13

        #%r447->x14

        #%r446->x13

        #%r319->x9

        #%r445->x9

        #%r318->x9

        #%r444->x9

        #%r317->x9

        #%r443->x10

        #%r316->x9

        #%r441->x9

        #%r314->x9

        #%r437->x9

        #%r310->x9

        #%r436->x9

        #%r309->x9

        #%r435->x9

        #%r308->x10

        #%r315->x9

        #%r442->x9

        #%r311->x9

        #%r438->x9

        #%r439->x9

        #%r312->x9

        #%r262->x11

        #%r313->x9

        #%r440->x9

        #%r254->x13

        #%r222->x9

        #%r250->x12

        #%r449->x9

        #%r213->x10

        #%r467->x11

        #%r300->x9

        #%r253->x13

        #%r298->x9

        #%r232->x13

        #%r261->x11

        #%r230->x12

        #%r220->x13

        #%r307->x9

        #%r263->x13

        #%r265->x11

        #%r297->x9

        #%r240->x12

        #%r299->x9

        #%r242->x13

        #%r301->x9

        #%r302->x11

        #%r303->x9

        #%r304->x12

        #%r305->x10

        #%r306->x9

        #%r251->x12

        #%r456->x13

        #%r457->x12

        #%r458->x13

        #%r459->x14

        #%r460->x13

        #%r461->x9

        #%r462->x11

        #%r463->x12

        #%r464->x11

        #%r465->x11

        #%r466->x12

        #%r468->x9

        #%r469->x9

        #%r470->x9

        #%r471->x9
main:


        #bb22:
bb22:


        #  %r297 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0

        #  %r298 = add i32 0, 0
        mov     w9, #0

        #  %r299 = add i32 0, 0
        mov     w9, #0

        #  %r213 = call i32 @getint()
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
        mov     w10, w0

        #  store i32 %r213, i32* @hashmod
        adrp     x9, hashmod
        add     x9, x9, #:lo12:hashmod
        str     w10, [x9]

        #  %r300 = add i32 0, 0
        mov     w9, #0

        #  %r302 = call i32 @getint()
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
        mov     w11, w0

        #  %r301 = add i32 0, 0
        mov     w9, #0

        #  %r303 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb23


        #bb23:  %r304 = phi i32 [ %r303, %bb22 ], [ %r319, %bb24 ]
        mov     w12, w9
        b     bb23

        #bb23:
bb23:


        #  %r304 = phi i32 [ %r303, %bb22 ], [ %r319, %bb24 ]

        #  %r219 = icmp slt i32 %r304, %r302
        cmp     w12, w11

        #  br i1 %r219, label %bb24, label %bb25

        b.lt     bb24
        b     bb25

        #bb24:
bb24:


        #  %r220 = call i32 @getint()
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
        mov     w13, w0

        #  %r222 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @keys, i32 0, i32 %r304
        mov     x9, #4
        mul     x10, x12, x9
        adrp     x9, keys
        add     x9, x9, #:lo12:keys
        add     x9, x9, x10

        #  store i32 %r220, i32* %r222
        str     w13, [x9]

        #  %r319 = add i32 %r304, 1
        add     w9, w12, #1

        #  br label %bb23


        #bb23:  %r304 = phi i32 [ %r303, %bb22 ], [ %r319, %bb24 ]
        mov     w12, w9
        b     bb23

        #bb25:
bb25:


        #  %r305 = call i32 @getint()
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
        mov     w10, w0

        #  %r306 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb26


        #bb26:  %r307 = phi i32 [ %r306, %bb25 ], [ %r318, %bb27 ]
        mov     w9, w9
        b     bb26

        #bb26:
bb26:


        #  %r307 = phi i32 [ %r306, %bb25 ], [ %r318, %bb27 ]

        #  %r229 = icmp slt i32 %r307, %r305
        cmp     w9, w10

        #  br i1 %r229, label %bb27, label %bb28

        b.lt     bb27
        b     bb28

        #bb27:
bb27:


        #  %r230 = call i32 @getint()
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
        mov     w12, w0

        #  %r232 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @values, i32 0, i32 %r307
        mov     x13, #4
        mul     x14, x9, x13
        adrp     x13, values
        add     x13, x13, #:lo12:values
        add     x13, x13, x14

        #  store i32 %r230, i32* %r232
        str     w12, [x13]

        #  %r318 = add i32 %r307, 1
        add     w9, w9, #1

        #  br label %bb26


        #bb26:  %r307 = phi i32 [ %r306, %bb25 ], [ %r318, %bb27 ]
        mov     w9, w9
        b     bb26

        #bb28:
bb28:


        #  %r308 = call i32 @getint()
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
        mov     w10, w0

        #  %r309 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb29


        #bb29:  %r310 = phi i32 [ %r309, %bb28 ], [ %r317, %bb30 ]
        mov     w9, w9
        b     bb29

        #bb29:
bb29:


        #  %r310 = phi i32 [ %r309, %bb28 ], [ %r317, %bb30 ]

        #  %r239 = icmp slt i32 %r310, %r308
        cmp     w9, w10

        #  br i1 %r239, label %bb30, label %bb31

        b.lt     bb30
        b     bb31

        #bb30:
bb30:


        #  %r240 = call i32 @getint()
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
        mov     w12, w0

        #  %r242 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @requests, i32 0, i32 %r310
        mov     x13, #4
        mul     x14, x9, x13
        adrp     x13, requests
        add     x13, x13, #:lo12:requests
        add     x13, x13, x14

        #  store i32 %r240, i32* %r242
        str     w12, [x13]

        #  %r317 = add i32 %r310, 1
        add     w9, w9, #1

        #  br label %bb29


        #bb29:  %r310 = phi i32 [ %r309, %bb28 ], [ %r317, %bb30 ]
        mov     w9, w9
        b     bb29

        #bb31:
bb31:


        #  call void @_sysy_starttime(i32 209)
        mov     w9, #209
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

        #  %r311 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb32


        #bb32:  %r312 = phi i32 [ %r311, %bb31 ], [ %r316, %bb33 ]
        mov     w9, w9
        b     bb32

        #bb32:
bb32:


        #  %r312 = phi i32 [ %r311, %bb31 ], [ %r316, %bb33 ]

        #  %r248 = icmp slt i32 %r312, %r302
        cmp     w9, w11

        #  br i1 %r248, label %bb33, label %bb34

        b.lt     bb33
        b     bb34

        #bb33:
bb33:


        #  %r250 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @keys, i32 0, i32 %r312
        mov     x12, #4
        mul     x13, x9, x12
        adrp     x12, keys
        add     x12, x12, #:lo12:keys
        add     x12, x12, x13

        #  %r251 = load i32, i32* %r250
        ldr     w12, [x12]

        #  %r253 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @values, i32 0, i32 %r312
        mov     x13, #4
        mul     x14, x9, x13
        adrp     x13, values
        add     x13, x13, #:lo12:values
        add     x13, x13, x14

        #  %r254 = load i32, i32* %r253
        ldr     w13, [x13]

        #  call void @insert(i32 %r251, i32 %r254)
        mov     w0, w12
        mov     w1, w13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     insert
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r316 = add i32 %r312, 1
        add     w9, w9, #1

        #  br label %bb32


        #bb32:  %r312 = phi i32 [ %r311, %bb31 ], [ %r316, %bb33 ]
        mov     w9, w9
        b     bb32

        #bb34:
bb34:


        #  %r313 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb35


        #bb35:  %r314 = phi i32 [ %r313, %bb34 ], [ %r315, %bb36 ]
        mov     w9, w9
        b     bb35

        #bb35:
bb35:


        #  %r314 = phi i32 [ %r313, %bb34 ], [ %r315, %bb36 ]

        #  %r259 = icmp slt i32 %r314, %r308
        cmp     w9, w10

        #  br i1 %r259, label %bb36, label %bb37

        b.lt     bb36
        b     bb37

        #bb36:
bb36:


        #  %r261 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @requests, i32 0, i32 %r314
        mov     x11, #4
        mul     x12, x9, x11
        adrp     x11, requests
        add     x11, x11, #:lo12:requests
        add     x11, x11, x12

        #  %r262 = load i32, i32* %r261
        ldr     w11, [x11]

        #  %r263 = call i32 @reduce(i32 %r262)
        mov     w0, w11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     reduce
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w13, w0

        #  %r265 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @ans, i32 0, i32 %r314
        mov     x11, #4
        mul     x12, x9, x11
        adrp     x11, ans
        add     x11, x11, #:lo12:ans
        add     x11, x11, x12

        #  store i32 %r263, i32* %r265
        str     w13, [x11]

        #  %r315 = add i32 %r314, 1
        add     w9, w9, #1

        #  br label %bb35


        #bb35:  %r314 = phi i32 [ %r313, %bb34 ], [ %r315, %bb36 ]
        mov     w9, w9
        b     bb35

        #bb37:
bb37:


        #  call void @_sysy_stoptime(i32 312)
        mov     w9, #312
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

        #  call void @putarray(i32 %r308, i32* @ans)
        mov     w0, w10
        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putarray
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
