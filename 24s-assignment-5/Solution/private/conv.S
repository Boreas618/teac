.section .data
.global    max
.global    a
.global    b
.global    kernelid
max:
        .quad   1073741824
a:
        .zero   80000000
b:
        .zero   80000000
kernelid:
        .zero   80000
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global checkrange
.global mod
.global reduce
.global getvalue
.global convn
.global memmove
.global main
        //%r508->x9
        //%r391->x9
        //%r507->x9
        //%r390->x9
        //%r506->x9
        //%r100->x10
        //%r388->x10
        //%r387->x9
        //%r111->x9
        //%r106->x9
        //%r389->x10
        //%r103->x9
        //%r509->x9
        //%r386->x9
        //%r510->x9
checkrange:

        //bb94:

bb94:

        //  %r386 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r387 = add i32 %r100, 0

        mov     x9, x10
        //  br label %bb2


        //bb2:  %r388 = phi i32 [ %r387, %bb94 ], [ %r391, %bb3 ]

        mov     x10, x9
        b     bb2
        //bb2:

bb2:

        //  %r388 = phi i32 [ %r387, %bb94 ], [ %r391, %bb3 ]

        //  %r103 = load i32, i32* @max

        adrp     x9, max
        add     x9, x9, #:lo12:max
        ldr     x9, [x9]
        //  %r104 = icmp sgt i32 %r388, %r103

        cmp     x10, x9
        //  br i1 %r104, label %bb3, label %bb4


        b.gt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r106 = load i32, i32* @max

        adrp     x9, max
        add     x9, x9, #:lo12:max
        ldr     x9, [x9]
        //  %r391 = sub i32 %r388, %r106

        sub     x9, x10, x9
        //  br label %bb2


        //bb2:  %r388 = phi i32 [ %r387, %bb94 ], [ %r391, %bb3 ]

        mov     x10, x9
        b     bb2
        //bb4:

bb4:

        //  br label %bb5


        //bb5:  %r389 = phi i32 [ %r388, %bb4 ], [ %r390, %bb6 ]

        mov     x10, x10
        b     bb5
        //bb5:

bb5:

        //  %r389 = phi i32 [ %r388, %bb4 ], [ %r390, %bb6 ]

        //  %r109 = icmp slt i32 %r389, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r109, label %bb6, label %bb7


        b.lt     bb6
        b     bb7
        //bb6:

bb6:

        //  %r111 = load i32, i32* @max

        adrp     x9, max
        add     x9, x9, #:lo12:max
        ldr     x9, [x9]
        //  %r390 = add i32 %r389, %r111

        add     x9, x10, x9
        //  br label %bb5


        //bb5:  %r389 = phi i32 [ %r388, %bb4 ], [ %r390, %bb6 ]

        mov     x10, x9
        b     bb5
        //bb7:

bb7:

        //  ret i32 %r389

        mov     x0, x10
        mov     sp, x29
        ret
        //%r114->x10
        //%r116->x11
        //%r121->x11
        //%r394->x10
        //%r511->x9
        //%r123->x9
        //%r124->x9
        //%r392->x9
        //%r393->x9
        //%r395->x9
        //%r512->x9
mod:

        //bb95:

bb95:

        //  %r392 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r394 = add i32 %r114, 0

        mov     x10, x10
        //  %r393 = add i32 0, 0

        mov     x9, #0
        //  %r395 = add i32 %r116, 0

        mov     x9, x11
        //  %r121 = sdiv i32 %r394, %r395

        sdiv     x11, x10, x9
        //  %r123 = mul i32 %r121, %r395

        mul     x9, x11, x9
        //  %r124 = sub i32 %r394, %r123

        sub     x9, x10, x9
        //  ret i32 %r124

        mov     x0, x9
        mov     sp, x29
        ret
        //%r429->x9
        //%r428->x13
        //%r555->x9
        //%r427->x9
        //%r173->x13
        //%r554->x10
        //%r426->x13
        //%r553->x10
        //%r425->x9
        //%r552->x10
        //%r423->x10
        //%r550->x10
        //%r421->x9
        //%r548->x10
        //%r417->x9
        //%r544->x9
        //%r416->x10
        //%r543->x10
        //%r415->x10
        //%r542->x13
        //%r412->x13
        //%r539->x13
        //%r411->x13
        //%r538->x13
        //%r410->x9
        //%r156->x10
        //%r537->x13
        //%r408->x10
        //%r535->x9
        //%r407->x11
        //%r534->x9
        //%r406->x12
        //%r533->x9
        //%r405->x10
        //%r151->x10
        //%r532->x9
        //%r404->x9
        //%r150->x10
        //%r531->x10
        //%r403->x9
        //%r530->x10
        //%r402->x9
        //%r529->x10
        //%r208->x14
        //%r409->x9
        //%r536->x13
        //%r202->x10
        //%r147->x14
        //%r401->x9
        //%r528->x10
        //%r146->x10
        //%r400->x9
        //%r527->x10
        //%r431->x10
        //%r177->x13
        //%r136->x9
        //%r517->x9
        //%r397->x9
        //%r524->x9
        //%r430->x10
        //%r135->x9
        //%r516->x9
        //%r396->x9
        //%r142->x10
        //%r523->x9
        //%r424->x10
        //%r551->x10
        //%r129->x11
        //%r413->x9
        //%r540->x13
        //%r420->x13
        //%r547->x10
        //%r125->x10
        //%r419->x9
        //%r546->x9
        //%r183->x14
        //%r414->x10
        //%r541->x13
        //%r178->x14
        //%r207->x10
        //%r418->x10
        //%r545->x9
        //%r182->x13
        //%r211->x10
        //%r422->x10
        //%r549->x10
        //%r127->x12
        //%r186->x10
        //%r198->x10
        //%r203->x14
        //%r398->x9
        //%r525->x9
        //%r399->x9
        //%r526->x10
        //%r513->x9
        //%r514->x9
        //%r515->x9
        //%r518->x9
        //%r519->x9
        //%r520->x9
        //%r521->x9
        //%r522->x9
reduce:

        //bb96:

bb96:

        //  %r396 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x12, x1
        mov     x11, x2
        mov     x9, #0
        //  %r397 = add i32 0, 0

        mov     x9, #0
        //  %r398 = add i32 0, 0

        mov     x9, #0
        //  %r399 = add i32 0, 0

        mov     x9, #0
        //  %r400 = add i32 0, 0

        mov     x9, #0
        //  %r401 = add i32 0, 0

        mov     x9, #0
        //  %r402 = add i32 0, 0

        mov     x9, #0
        //  %r405 = add i32 %r125, 0

        mov     x10, x10
        //  %r403 = add i32 0, 0

        mov     x9, #0
        //  %r406 = add i32 %r127, 0

        mov     x12, x12
        //  %r404 = add i32 0, 0

        mov     x9, #0
        //  %r407 = add i32 %r129, 0

        mov     x11, x11
        //  %r132 = icmp eq i32 %r405, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r132, label %bb10, label %bb11


        b.eq     bb10
        b     bb11
        //bb10:

bb10:

        //  %r135 = add i32 %r406, %r407

        add     x9, x12, x11
        //  %r136 = call i32 @checkrange(i32 %r135)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     checkrange
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  ret i32 %r136

        mov     x0, x9
        mov     sp, x29
        ret
        //bb11:

bb11:

        //  %r138 = icmp eq i32 %r405, 1

        mov     x9, #1
        cmp     x10, x9
        //  br i1 %r138, label %bb13, label %bb14


        b.eq     bb13
        b     bb14
        //bb13:

bb13:

        //  %r424 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r425 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb16


        //bb16:  %r426 = phi i32 [ %r424, %bb13 ], [ %r428, %bb21 ]

        mov     x13, x10
        //bb16:  %r427 = phi i32 [ %r425, %bb13 ], [ %r429, %bb21 ]

        mov     x9, x9
        b     bb16
        //bb16:

bb16:

        //  %r426 = phi i32 [ %r424, %bb13 ], [ %r428, %bb21 ]

        //  %r427 = phi i32 [ %r425, %bb13 ], [ %r429, %bb21 ]

        //  %r142 = load i32, i32* @max

        adrp     x10, max
        add     x10, x10, #:lo12:max
        ldr     x10, [x10]
        //  %r143 = icmp slt i32 %r427, %r142

        cmp     x9, x10
        //  br i1 %r143, label %bb17, label %bb18


        b.lt     bb17
        b     bb18
        //bb17:

bb17:

        //  %r146 = sdiv i32 %r406, %r427

        sdiv     x10, x12, x9
        //  %r147 = call i32 @mod(i32 %r146, i32 2)

        mov     x0, x10
        mov     x10, #2
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x14, x0
        //  %r150 = sdiv i32 %r407, %r427

        sdiv     x10, x11, x9
        //  %r151 = call i32 @mod(i32 %r150, i32 2)

        mov     x0, x10
        mov     x10, #2
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r152 = icmp eq i32 %r147, %r151

        cmp     x14, x10
        //  br i1 %r152, label %bb19, label %bb20


        b.eq     bb19
        b     bb20
        //bb19:

bb19:

        //  %r431 = mul i32 %r426, 2

        mov     x10, #2
        mul     x10, x13, x10
        //  br label %bb21


        //bb21:  %r428 = phi i32 [ %r431, %bb19 ], [ %r430, %bb20 ]

        mov     x13, x10
        b     bb21
        //bb20:

bb20:

        //  %r156 = mul i32 %r426, 2

        mov     x10, #2
        mul     x10, x13, x10
        //  %r430 = add i32 %r156, 1

        add     x10, x10, #1
        //  br label %bb21


        //bb21:  %r428 = phi i32 [ %r431, %bb19 ], [ %r430, %bb20 ]

        mov     x13, x10
        b     bb21
        //bb21:

bb21:

        //  %r428 = phi i32 [ %r431, %bb19 ], [ %r430, %bb20 ]

        //  %r429 = mul i32 %r427, 2

        mov     x10, #2
        mul     x9, x9, x10
        //  br label %bb16


        //bb16:  %r426 = phi i32 [ %r424, %bb13 ], [ %r428, %bb21 ]

        mov     x13, x13
        //bb16:  %r427 = phi i32 [ %r425, %bb13 ], [ %r429, %bb21 ]

        mov     x9, x9
        b     bb16
        //bb18:

bb18:

        //  ret i32 %r426

        mov     x0, x13
        mov     sp, x29
        ret
        //bb14:

bb14:

        //  %r162 = icmp eq i32 %r405, 2

        mov     x9, #2
        cmp     x10, x9
        //  br i1 %r162, label %bb22, label %bb23


        b.eq     bb22
        b     bb23
        //bb22:

bb22:

        //  %r165 = icmp sgt i32 %r406, %r407

        cmp     x12, x11
        //  br i1 %r165, label %bb25, label %bb26


        b.gt     bb25
        b     bb26
        //bb25:

bb25:

        //  ret i32 %r406

        mov     x0, x12
        mov     sp, x29
        ret
        //bb26:

bb26:

        //  ret i32 %r407

        mov     x0, x11
        mov     sp, x29
        ret
        //bb23:

bb23:

        //  %r169 = icmp eq i32 %r405, 3

        mov     x9, #3
        cmp     x10, x9
        //  br i1 %r169, label %bb28, label %bb29


        b.eq     bb28
        b     bb29
        //bb28:

bb28:

        //  %r416 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r417 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb31


        //bb31:  %r418 = phi i32 [ %r416, %bb28 ], [ %r420, %bb36 ]

        mov     x10, x10
        //bb31:  %r419 = phi i32 [ %r417, %bb28 ], [ %r421, %bb36 ]

        mov     x9, x9
        b     bb31
        //bb31:

bb31:

        //  %r418 = phi i32 [ %r416, %bb28 ], [ %r420, %bb36 ]

        //  %r419 = phi i32 [ %r417, %bb28 ], [ %r421, %bb36 ]

        //  %r173 = load i32, i32* @max

        adrp     x13, max
        add     x13, x13, #:lo12:max
        ldr     x13, [x13]
        //  %r174 = icmp slt i32 %r419, %r173

        cmp     x9, x13
        //  br i1 %r174, label %bb32, label %bb33


        b.lt     bb32
        b     bb33
        //bb32:

bb32:

        //  %r177 = sdiv i32 %r406, %r419

        sdiv     x13, x12, x9
        //  %r178 = call i32 @mod(i32 %r177, i32 2)

        mov     x0, x13
        mov     x13, #2
        mov     x1, x13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x14, x0
        //  %r179 = icmp eq i32 %r178, 1

        mov     x13, #1
        cmp     x14, x13
        //  br i1 %r179, label %bb34, label %bb37


        b.eq     bb34
        b     bb37
        //bb37:

bb37:

        //  %r182 = sdiv i32 %r407, %r419

        sdiv     x13, x11, x9
        //  %r183 = call i32 @mod(i32 %r182, i32 2)

        mov     x0, x13
        mov     x13, #2
        mov     x1, x13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x14, x0
        //  %r184 = icmp eq i32 %r183, 1

        mov     x13, #1
        cmp     x14, x13
        //  br i1 %r184, label %bb34, label %bb35


        b.eq     bb34
        b     bb35
        //bb34:

bb34:

        //  %r186 = mul i32 %r418, 2

        mov     x13, #2
        mul     x10, x10, x13
        //  %r422 = add i32 %r186, 1

        add     x10, x10, #1
        //  br label %bb36


        //bb36:  %r420 = phi i32 [ %r422, %bb34 ], [ %r423, %bb35 ]

        mov     x13, x10
        b     bb36
        //bb35:

bb35:

        //  %r423 = mul i32 %r418, 2

        mov     x13, #2
        mul     x10, x10, x13
        //  br label %bb36


        //bb36:  %r420 = phi i32 [ %r422, %bb34 ], [ %r423, %bb35 ]

        mov     x13, x10
        b     bb36
        //bb36:

bb36:

        //  %r420 = phi i32 [ %r422, %bb34 ], [ %r423, %bb35 ]

        //  %r421 = mul i32 %r419, 2

        mov     x10, #2
        mul     x9, x9, x10
        //  br label %bb31


        //bb31:  %r418 = phi i32 [ %r416, %bb28 ], [ %r420, %bb36 ]

        mov     x10, x13
        //bb31:  %r419 = phi i32 [ %r417, %bb28 ], [ %r421, %bb36 ]

        mov     x9, x9
        b     bb31
        //bb33:

bb33:

        //  ret i32 %r418

        mov     x0, x10
        mov     sp, x29
        ret
        //bb29:

bb29:

        //  %r194 = icmp eq i32 %r405, 4

        mov     x9, #4
        cmp     x10, x9
        //  br i1 %r194, label %bb38, label %bb39


        b.eq     bb38
        b     bb39
        //bb38:

bb38:

        //  %r408 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r409 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb41


        //bb41:  %r410 = phi i32 [ %r409, %bb38 ], [ %r413, %bb46 ]

        mov     x9, x9
        //bb41:  %r411 = phi i32 [ %r408, %bb38 ], [ %r412, %bb46 ]

        mov     x13, x10
        b     bb41
        //bb41:

bb41:

        //  %r410 = phi i32 [ %r409, %bb38 ], [ %r413, %bb46 ]

        //  %r411 = phi i32 [ %r408, %bb38 ], [ %r412, %bb46 ]

        //  %r198 = load i32, i32* @max

        adrp     x10, max
        add     x10, x10, #:lo12:max
        ldr     x10, [x10]
        //  %r199 = icmp slt i32 %r410, %r198

        cmp     x9, x10
        //  br i1 %r199, label %bb42, label %bb43


        b.lt     bb42
        b     bb43
        //bb42:

bb42:

        //  %r202 = sdiv i32 %r406, %r410

        sdiv     x10, x12, x9
        //  %r203 = call i32 @mod(i32 %r202, i32 2)

        mov     x0, x10
        mov     x10, #2
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x14, x0
        //  %r204 = icmp eq i32 %r203, 1

        mov     x10, #1
        cmp     x14, x10
        //  br i1 %r204, label %bb47, label %bb45


        b.eq     bb47
        b     bb45
        //bb47:

bb47:

        //  %r207 = sdiv i32 %r407, %r410

        sdiv     x10, x11, x9
        //  %r208 = call i32 @mod(i32 %r207, i32 2)

        mov     x0, x10
        mov     x10, #2
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x14, x0
        //  %r209 = icmp eq i32 %r208, 1

        mov     x10, #1
        cmp     x14, x10
        //  br i1 %r209, label %bb44, label %bb45


        b.eq     bb44
        b     bb45
        //bb44:

bb44:

        //  %r211 = mul i32 %r411, 2

        mov     x10, #2
        mul     x10, x13, x10
        //  %r415 = add i32 %r211, 1

        add     x10, x10, #1
        //  br label %bb46


        //bb46:  %r412 = phi i32 [ %r415, %bb44 ], [ %r414, %bb45 ]

        mov     x13, x10
        b     bb46
        //bb45:

bb45:

        //  %r414 = mul i32 %r411, 2

        mov     x10, #2
        mul     x10, x13, x10
        //  br label %bb46


        //bb46:  %r412 = phi i32 [ %r415, %bb44 ], [ %r414, %bb45 ]

        mov     x13, x10
        b     bb46
        //bb46:

bb46:

        //  %r412 = phi i32 [ %r415, %bb44 ], [ %r414, %bb45 ]

        //  %r413 = mul i32 %r410, 2

        mov     x10, #2
        mul     x9, x9, x10
        //  br label %bb41


        //bb41:  %r410 = phi i32 [ %r409, %bb38 ], [ %r413, %bb46 ]

        mov     x9, x9
        //bb41:  %r411 = phi i32 [ %r408, %bb38 ], [ %r412, %bb46 ]

        mov     x13, x13
        b     bb41
        //bb43:

bb43:

        //  ret i32 %r411

        mov     x0, x13
        mov     sp, x29
        ret
        //bb39:

bb39:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r436->x9
        //%r434->x9
        //%r432->x9
        //%r435->x9
        //%r240->x10
        //%r559->x10
        //%r433->x9
        //%r225->x11
        //%r223->x12
        //%r221->x13
        //%r245->x9
        //%r564->x10
        //%r219->x14
        //%r244->x9
        //%r563->x9
        //%r218->x9
        //%r437->x14
        //%r438->x13
        //%r439->x12
        //%r440->x11
        //%r556->x10
        //%r441->x11
        //%r557->x10
        //%r558->x10
        //%r560->x10
        //%r561->x10
        //%r562->x10
        //%r565->x10
getvalue:

        //bb103:

bb103:

        //  %r432 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     x14, x1
        mov     x13, x2
        mov     x12, x3
        mov     x11, x4
        mov     x10, #0
        //  %r433 = add i32 0, 0

        mov     x10, #0
        //  %r437 = add i32 %r219, 0

        mov     x14, x14
        //  %r434 = add i32 0, 0

        mov     x10, #0
        //  %r438 = add i32 %r221, 0

        mov     x13, x13
        //  %r435 = add i32 0, 0

        mov     x10, #0
        //  %r439 = add i32 %r223, 0

        mov     x12, x12
        //  %r436 = add i32 0, 0

        mov     x10, #0
        //  %r440 = add i32 %r225, 0

        mov     x11, x11
        //  %r228 = icmp slt i32 %r439, 0

        mov     x10, #0
        cmp     x12, x10
        //  br i1 %r228, label %bb49, label %bb54


        b.lt     bb49
        b     bb54
        //bb54:

bb54:

        //  %r230 = icmp slt i32 %r440, 0

        mov     x10, #0
        cmp     x11, x10
        //  br i1 %r230, label %bb49, label %bb53


        b.lt     bb49
        b     bb53
        //bb53:

bb53:

        //  %r233 = icmp sge i32 %r439, %r437

        cmp     x12, x14
        //  br i1 %r233, label %bb49, label %bb52


        b.ge     bb49
        b     bb52
        //bb52:

bb52:

        //  %r236 = icmp sge i32 %r440, %r438

        cmp     x11, x13
        //  br i1 %r236, label %bb49, label %bb50


        b.ge     bb49
        b     bb50
        //bb49:

bb49:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //bb50:

bb50:

        //  %r240 = mul i32 %r439, %r438

        mul     x10, x12, x13
        //  %r441 = add i32 %r240, %r440

        add     x11, x10, x11
        //  %r244 = getelementptr i32, i32* %r218, i32 %r441

        mov     x10, #8
        mul     x10, x11, x10
        add     x9, x9, x10
        //  %r245 = load i32, i32* %r244

        ldr     x9, [x9]
        //  ret i32 %r245

        mov     x0, x9
        mov     sp, x29
        ret
        //%r477->x24
        //%r476->x25
        //%r475->x24
        //%r474->x10
        //%r471->x24
        //%r470->x9
        //%r469->x10
        //%r468->x24
        //%r467->x9
        //%r466->x10
        //%r464->x10
        //%r463->x9
        //%r462->x11
        //%r461->x9
        //%r588->x9
        //%r460->x12
        //%r587->x9
        //%r459->x13
        //%r586->x9
        //%r458->x9
        //%r585->x9
        //%r457->x10
        //%r584->x10
        //%r456->x14
        //%r583->x24
        //%r472->x24
        //%r295->x10
        //%r303->x9
        //%r566->x11
        //%r448->x9
        //%r575->x11
        //%r248->x23
        //%r569->x11
        //%r442->x9
        //%r451->x9
        //%r578->x9
        //%r473->x10
        //%r296->x10
        //%r444->x9
        //%r571->x11
        //%r254->x9
        //%r304->x9
        //%r246->x13
        //%r567->x11
        //%r449->x9
        //%r576->x10
        //%r252->x10
        //%r573->x11
        //%r446->x9
        //%r455->x15
        //%r582->x9
        //%r453->x21
        //%r580->x9
        //%r465->x9
        //%r288->x25
        //%r249->x22
        //%r570->x11
        //%r443->x9
        //%r452->x9
        //%r579->x9
        //%r250->x12
        //%r309->x9
        //%r572->x11
        //%r445->x9
        //%r277->x24
        //%r454->x20
        //%r581->x9
        //%r314->x9
        //%r568->x11
        //%r270->x9
        //%r447->x9
        //%r574->x11
        //%r450->x9
        //%r577->x9
convn:

        //bb105:

bb105:

        //  %r442 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x23, x1
        mov     x22, x2
        mov     x12, x3
        mov     x10, x4
        mov     x9, x5
        mov     x11, #0
        //  %r443 = add i32 0, 0

        mov     x11, #0
        //  %r444 = add i32 0, 0

        mov     x11, #0
        //  %r445 = add i32 0, 0

        mov     x11, #0
        //  %r446 = add i32 0, 0

        mov     x11, #0
        //  %r447 = add i32 0, 0

        mov     x11, #0
        //  %r448 = add i32 0, 0

        mov     x11, #0
        //  %r449 = add i32 0, 0

        mov     x11, #0
        //  %r453 = add i32 %r246, 0

        mov     x21, x13
        //  %r450 = add i32 0, 0

        mov     x11, #0
        //  %r454 = add i32 %r250, 0

        mov     x20, x12
        //  %r451 = add i32 0, 0

        mov     x11, #0
        //  %r455 = add i32 %r252, 0

        mov     x15, x10
        //  %r452 = add i32 0, 0

        mov     x10, #0
        //  %r456 = add i32 %r254, 0

        mov     x14, x9
        //  %r457 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r458 = add i32 0, 0

        mov     x9, #0
        //  %r459 = add i32 1, 0

        mov     x9, #1
        mov     x13, x9
        //  br label %bb56


        //bb56:  %r460 = phi i32 [ %r457, %bb105 ], [ %r463, %bb78 ]

        mov     x12, x10
        b     bb56
        //bb56:

bb56:

        //  %r460 = phi i32 [ %r457, %bb105 ], [ %r463, %bb78 ]

        //  %r264 = icmp eq i32 %r459, %r459

        cmp     x13, x13
        //  br i1 %r264, label %bb57, label %bb58


        b.eq     bb57
        b     bb58
        //bb57:

bb57:

        //  %r461 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb59


        //bb59:  %r462 = phi i32 [ %r461, %bb57 ], [ %r470, %bb75 ]

        mov     x11, x9
        b     bb59
        //bb59:

bb59:

        //  %r462 = phi i32 [ %r461, %bb57 ], [ %r470, %bb75 ]

        //  %r267 = icmp eq i32 %r459, %r459

        cmp     x13, x13
        //  br i1 %r267, label %bb60, label %bb61


        b.eq     bb60
        b     bb61
        //bb60:

bb60:

        //  %r464 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r270 = sdiv i32 %r456, 2

        mov     x9, #2
        sdiv     x9, x14, x9
        //  %r465 = sub i32 %r460, %r270

        sub     x9, x12, x9
        //  br label %bb62


        //bb62:  %r466 = phi i32 [ %r464, %bb60 ], [ %r474, %bb72 ]

        mov     x10, x10
        //bb62:  %r467 = phi i32 [ %r465, %bb60 ], [ %r475, %bb72 ]

        mov     x9, x9
        b     bb62
        //bb62:

bb62:

        //  %r466 = phi i32 [ %r464, %bb60 ], [ %r474, %bb72 ]

        //  %r467 = phi i32 [ %r465, %bb60 ], [ %r475, %bb72 ]

        //  %r274 = icmp eq i32 %r459, %r459

        cmp     x13, x13
        //  br i1 %r274, label %bb63, label %bb64


        b.eq     bb63
        //bb64:  %r468 = phi i32 [ %r466, %bb62 ], [ %r474, %bb71 ]

        mov     x24, x10
        b     bb64
        //bb63:

bb63:

        //  %r277 = sdiv i32 %r456, 2

        mov     x24, #2
        sdiv     x24, x14, x24
        //  %r471 = sub i32 %r462, %r277

        sub     x24, x11, x24
        //  br label %bb65


        //bb65:  %r472 = phi i32 [ %r471, %bb63 ], [ %r477, %bb69 ]

        mov     x24, x24
        //bb65:  %r473 = phi i32 [ %r466, %bb63 ], [ %r476, %bb69 ]

        mov     x10, x10
        b     bb65
        //bb65:

bb65:

        //  %r472 = phi i32 [ %r471, %bb63 ], [ %r477, %bb69 ]

        //  %r473 = phi i32 [ %r466, %bb63 ], [ %r476, %bb69 ]

        //  %r281 = icmp eq i32 %r459, %r459

        cmp     x13, x13
        //  br i1 %r281, label %bb66, label %bb67


        b.eq     bb66
        //bb67:  %r474 = phi i32 [ %r473, %bb65 ], [ %r476, %bb68 ]

        mov     x10, x10
        b     bb67
        //bb66:

bb66:

        //  %r288 = call i32 @getvalue(i32* %r248, i32 %r454, i32 %r455, i32 %r467, i32 %r472)

        mov     x0, x23
        mov     x1, x20
        mov     x2, x15
        mov     x3, x9
        mov     x4, x24
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getvalue
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x25, x0
        //  %r476 = call i32 @reduce(i32 %r453, i32 %r473, i32 %r288)

        mov     x0, x21
        mov     x1, x10
        mov     x2, x25
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     reduce
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x25, x0
        //  %r477 = add i32 %r472, 1

        add     x24, x24, #1
        //  %r295 = sdiv i32 %r456, 2

        mov     x10, #2
        sdiv     x10, x14, x10
        //  %r296 = add i32 %r462, %r295

        add     x10, x11, x10
        //  %r297 = icmp sge i32 %r477, %r296

        cmp     x24, x10
        //  br i1 %r297, label %bb68, label %bb69


        b.ge     bb68
        b     bb69
        //bb68:

bb68:

        //  br label %bb67


        //bb67:  %r474 = phi i32 [ %r473, %bb65 ], [ %r476, %bb68 ]

        mov     x10, x25
        b     bb67
        //bb69:

bb69:

        //  br label %bb65


        //bb65:  %r472 = phi i32 [ %r471, %bb63 ], [ %r477, %bb69 ]

        mov     x24, x24
        //bb65:  %r473 = phi i32 [ %r466, %bb63 ], [ %r476, %bb69 ]

        mov     x10, x25
        b     bb65
        //bb67:

bb67:

        //  %r474 = phi i32 [ %r473, %bb65 ], [ %r476, %bb68 ]

        //  %r475 = add i32 %r467, 1

        add     x24, x9, #1
        //  %r303 = sdiv i32 %r456, 2

        mov     x9, #2
        sdiv     x9, x14, x9
        //  %r304 = add i32 %r460, %r303

        add     x9, x12, x9
        //  %r305 = icmp sge i32 %r475, %r304

        cmp     x24, x9
        //  br i1 %r305, label %bb71, label %bb72


        b.ge     bb71
        b     bb72
        //bb71:

bb71:

        //  br label %bb64


        //bb64:  %r468 = phi i32 [ %r466, %bb62 ], [ %r474, %bb71 ]

        mov     x24, x10
        b     bb64
        //bb72:

bb72:

        //  br label %bb62


        //bb62:  %r466 = phi i32 [ %r464, %bb60 ], [ %r474, %bb72 ]

        mov     x10, x10
        //bb62:  %r467 = phi i32 [ %r465, %bb60 ], [ %r475, %bb72 ]

        mov     x9, x24
        b     bb62
        //bb64:

bb64:

        //  %r468 = phi i32 [ %r466, %bb62 ], [ %r474, %bb71 ]

        //  %r309 = mul i32 %r460, %r455

        mul     x9, x12, x15
        //  %r469 = add i32 %r309, %r462

        add     x10, x9, x11
        //  %r314 = getelementptr i32, i32* %r249, i32 %r469

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x22, x9
        //  store i32 %r468, i32* %r314

        str     x24, [x9]
        //  %r470 = add i32 %r462, 1

        add     x9, x11, #1
        //  %r319 = icmp sge i32 %r470, %r455

        cmp     x9, x15
        //  br i1 %r319, label %bb74, label %bb75


        b.ge     bb74
        b     bb75
        //bb74:

bb74:

        //  br label %bb61


        b     bb61
        //bb75:

bb75:

        //  br label %bb59


        //bb59:  %r462 = phi i32 [ %r461, %bb57 ], [ %r470, %bb75 ]

        mov     x11, x9
        b     bb59
        //bb61:

bb61:

        //  %r463 = add i32 %r460, 1

        add     x9, x12, #1
        //  %r324 = icmp sge i32 %r463, %r454

        cmp     x9, x20
        //  br i1 %r324, label %bb77, label %bb78


        b.ge     bb77
        b     bb78
        //bb77:

bb77:

        //  br label %bb58


        b     bb58
        //bb78:

bb78:

        //  br label %bb56


        //bb56:  %r460 = phi i32 [ %r457, %bb105 ], [ %r463, %bb78 ]

        mov     x12, x9
        b     bb56
        //bb58:

bb58:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r589->x11
        //%r479->x9
        //%r334->x11
        //%r595->x11
        //%r480->x13
        //%r335->x14
        //%r337->x11
        //%r482->x12
        //%r478->x9
        //%r594->x11
        //%r483->x11
        //%r327->x12
        //%r326->x9
        //%r481->x11
        //%r325->x10
        //%r590->x11
        //%r591->x11
        //%r592->x11
        //%r593->x11
memmove:

        //bb110:

bb110:

        //  %r478 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, x1
        mov     x12, x2
        mov     x11, #0
        //  %r479 = add i32 0, 0

        mov     x11, #0
        //  %r480 = add i32 %r327, 0

        mov     x13, x12
        //  %r481 = add i32 0, 0

        mov     x11, #0
        mov     x11, x11
        //  br label %bb81


        //bb81:  %r482 = phi i32 [ %r481, %bb110 ], [ %r483, %bb82 ]

        mov     x12, x11
        b     bb81
        //bb81:

bb81:

        //  %r482 = phi i32 [ %r481, %bb110 ], [ %r483, %bb82 ]

        //  %r332 = icmp slt i32 %r482, %r480

        cmp     x12, x13
        //  br i1 %r332, label %bb82, label %bb83


        b.lt     bb82
        b     bb83
        //bb82:

bb82:

        //  %r334 = getelementptr i32, i32* %r326, i32 %r482

        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x9, x11
        //  %r335 = load i32, i32* %r334

        ldr     x14, [x11]
        //  %r337 = getelementptr i32, i32* %r325, i32 %r482

        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x10, x11
        //  store i32 %r335, i32* %r337

        str     x14, [x11]
        //  %r483 = add i32 %r482, 1

        add     x11, x12, #1
        //  br label %bb81


        //bb81:  %r482 = phi i32 [ %r481, %bb110 ], [ %r483, %bb82 ]

        mov     x12, x11
        b     bb81
        //bb83:

bb83:

        //  ret void

        mov     sp, x29
        ret
        //%r624->x9
        //%r497->x15
        //%r601->x9
        //%r600->x9
        //%r598->x9
        //%r596->x9
        //%r623->x9
        //%r496->x14
        //%r505->x9
        //%r606->x9
        //%r352->x20
        //%r488->x9
        //%r361->x20
        //%r615->x13
        //%r605->x13
        //%r487->x9
        //%r614->x14
        //%r604->x9
        //%r486->x9
        //%r613->x13
        //%r603->x9
        //%r485->x9
        //%r612->x13
        //%r619->x9
        //%r492->x11
        //%r501->x13
        //%r374->x13
        //%r607->x9
        //%r489->x9
        //%r616->x13
        //%r599->x9
        //%r363->x9
        //%r490->x9
        //%r617->x9
        //%r608->x9
        //%r354->x9
        //%r597->x9
        //%r602->x9
        //%r484->x9
        //%r611->x13
        //%r499->x14
        //%r626->x9
        //%r609->x13
        //%r373->x13
        //%r500->x9
        //%r627->x9
        //%r491->x12
        //%r618->x13
        //%r610->x9
        //%r493->x10
        //%r620->x13
        //%r494->x15
        //%r621->x9
        //%r495->x9
        //%r622->x13
        //%r380->x14
        //%r498->x9
        //%r625->x9
        //%r502->x15
        //%r385->x9
        //%r503->x13
        //%r504->x9
main:

        //bb84:

bb84:

        //  %r484 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r485 = add i32 0, 0

        mov     x9, #0
        //  %r486 = add i32 0, 0

        mov     x9, #0
        //  %r491 = call i32 @getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x12, x0
        //  %r487 = add i32 0, 0

        mov     x9, #0
        //  %r492 = call i32 @getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r488 = add i32 0, 0

        mov     x9, #0
        //  %r493 = call i32 @getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r489 = add i32 0, 0

        mov     x9, #0
        //  %r494 = call i32 @getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x15, x0
        //  %r490 = add i32 0, 0

        mov     x9, #0
        //  %r495 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb85


        //bb85:  %r496 = phi i32 [ %r495, %bb84 ], [ %r505, %bb86 ]

        mov     x14, x9
        b     bb85
        //bb85:

bb85:

        //  %r496 = phi i32 [ %r495, %bb84 ], [ %r505, %bb86 ]

        //  %r351 = icmp slt i32 %r496, %r494

        cmp     x14, x15
        //  br i1 %r351, label %bb86, label %bb87


        b.lt     bb86
        b     bb87
        //bb86:

bb86:

        //  %r352 = call i32 @getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x20, x0
        //  %r354 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @a, i32 0, i32 %r496

        mov     x9, #8
        mul     x13, x14, x9
        adrp     x9, a
        add     x9, x9, #:lo12:a
        add     x9, x9, x13
        //  store i32 %r352, i32* %r354

        str     x20, [x9]
        //  %r505 = add i32 %r496, 1

        add     x9, x14, #1
        //  br label %bb85


        //bb85:  %r496 = phi i32 [ %r495, %bb84 ], [ %r505, %bb86 ]

        mov     x14, x9
        b     bb85
        //bb87:

bb87:

        //  %r497 = call i32 @getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x15, x0
        //  %r498 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb88


        //bb88:  %r499 = phi i32 [ %r498, %bb87 ], [ %r504, %bb89 ]

        mov     x14, x9
        b     bb88
        //bb88:

bb88:

        //  %r499 = phi i32 [ %r498, %bb87 ], [ %r504, %bb89 ]

        //  %r360 = icmp slt i32 %r499, %r497

        cmp     x14, x15
        //  br i1 %r360, label %bb89, label %bb90


        b.lt     bb89
        b     bb90
        //bb89:

bb89:

        //  %r361 = call i32 @getint()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x20, x0
        //  %r363 = getelementptr [10000 x i32 ], [10000 x i32 ]* @kernelid, i32 0, i32 %r499

        mov     x9, #8
        mul     x13, x14, x9
        adrp     x9, kernelid
        add     x9, x9, #:lo12:kernelid
        add     x9, x9, x13
        //  store i32 %r361, i32* %r363

        str     x20, [x9]
        //  %r504 = add i32 %r499, 1

        add     x9, x14, #1
        //  br label %bb88


        //bb88:  %r499 = phi i32 [ %r498, %bb87 ], [ %r504, %bb89 ]

        mov     x14, x9
        b     bb88
        //bb90:

bb90:

        //  %r500 = add i32 %r497, 0

        mov     x9, x15
        //  call void @_sysy_starttime(i32 209)

        mov     x13, #209
        mov     x0, x13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r501 = add i32 0, 0

        mov     x13, #0
        mov     x13, x13
        //  br label %bb91


        //bb91:  %r502 = phi i32 [ %r501, %bb90 ], [ %r503, %bb92 ]

        mov     x15, x13
        b     bb91
        //bb91:

bb91:

        //  %r502 = phi i32 [ %r501, %bb90 ], [ %r503, %bb92 ]

        //  %r371 = icmp slt i32 %r502, %r500

        cmp     x15, x9
        //  br i1 %r371, label %bb92, label %bb93


        b.lt     bb92
        b     bb93
        //bb92:

bb92:

        //  %r373 = getelementptr [10000 x i32 ], [10000 x i32 ]* @kernelid, i32 0, i32 %r502

        mov     x13, #8
        mul     x14, x15, x13
        adrp     x13, kernelid
        add     x13, x13, #:lo12:kernelid
        add     x13, x13, x14
        //  %r374 = load i32, i32* %r373

        ldr     x13, [x13]
        //  call void @convn(i32 %r374, i32* @a, i32* @b, i32 %r492, i32 %r493, i32 %r491)

        mov     x0, x13
        adrp     x13, a
        add     x13, x13, #:lo12:a
        mov     x1, x13
        adrp     x13, b
        add     x13, x13, #:lo12:b
        mov     x2, x13
        mov     x3, x11
        mov     x4, x10
        mov     x5, x12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     convn
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r380 = mul i32 %r492, %r493

        mul     x14, x11, x10
        //  call void @memmove(i32* @a, i32* @b, i32 %r380)

        adrp     x13, a
        add     x13, x13, #:lo12:a
        mov     x0, x13
        adrp     x13, b
        add     x13, x13, #:lo12:b
        mov     x1, x13
        mov     x2, x14
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     memmove
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r503 = add i32 %r502, 1

        add     x13, x15, #1
        //  br label %bb91


        //bb91:  %r502 = phi i32 [ %r501, %bb90 ], [ %r503, %bb92 ]

        mov     x15, x13
        b     bb91
        //bb93:

bb93:

        //  call void @_sysy_stoptime(i32 312)

        mov     x9, #312
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r385 = mul i32 %r492, %r493

        mul     x9, x11, x10
        //  call void @putarray(i32 %r385, i32* @a)

        mov     x0, x9
        adrp     x9, a
        add     x9, x9, #:lo12:a
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putarray
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
