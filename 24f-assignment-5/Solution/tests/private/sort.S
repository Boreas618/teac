.section .data
.global    base
.global    a
.global    ans
base:
        .quad   16
a:
        .zero   120000040
ans:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global getMaxNum
.global getNumPos
.global radixSort
.global main

        #%r381->x9

        #%r380->x10

        #%r379->x9

        #%r378->x10

        #%r465->x10

        #%r377->x11

        #%r464->x10

        #%r376->x9

        #%r463->x13

        #%r374->x9

        #%r461->x9

        #%r114->x10

        #%r375->x9

        #%r462->x13

        #%r110->x13

        #%r458->x9

        #%r109->x13

        #%r457->x9

        #%r102->x12

        #%r100->x10

        #%r382->x10

        #%r383->x9

        #%r384->x10

        #%r459->x9

        #%r460->x9
getMaxNum:


        #bb51:
bb51:


        #  %r374 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     x12, x1
        mov     w9, #0

        #  %r375 = add i32 0, 0
        mov     w9, #0

        #  %r376 = add i32 0, 0
        mov     w9, #0

        #  %r377 = add i32 %r100, 0
        mov     w11, w10

        #  br label %bb1

        b     bb1

        #bb1:
bb1:


        #  %r378 = add i32 0, 0
        mov     w9, #0
        mov     w10, w9

        #  %r379 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb2


        #bb2:  %r380 = phi i32 [ %r378, %bb1 ], [ %r382, %bb7 ]
        mov     w10, w10

        #bb2:  %r381 = phi i32 [ %r379, %bb1 ], [ %r383, %bb7 ]
        mov     w9, w9
        b     bb2

        #bb2:
bb2:


        #  %r380 = phi i32 [ %r378, %bb1 ], [ %r382, %bb7 ]

        #  %r381 = phi i32 [ %r379, %bb1 ], [ %r383, %bb7 ]

        #  %r107 = icmp slt i32 %r381, %r377
        cmp     w9, w11

        #  br i1 %r107, label %bb3, label %bb4

        b.lt     bb3
        b     bb4

        #bb3:
bb3:


        #  %r109 = getelementptr i32, i32* %r102, i32 %r381
        mov     x13, #4
        mul     x13, x9, x13
        add     x13, x12, x13

        #  %r110 = load i32, i32* %r109
        ldr     w13, [x13]

        #  %r112 = icmp sgt i32 %r110, %r380
        cmp     w13, w10

        #  br i1 %r112, label %bb5, label %bb6

        b.gt     bb5
        b     bb6

        #bb5:
bb5:


        #  %r114 = getelementptr i32, i32* %r102, i32 %r381
        mov     x10, #4
        mul     x10, x9, x10
        add     x10, x12, x10

        #  %r384 = load i32, i32* %r114
        ldr     w10, [x10]

        #  br label %bb7


        #bb7:  %r382 = phi i32 [ %r384, %bb5 ], [ %r380, %bb6 ]
        mov     w10, w10
        b     bb7

        #bb6:
bb6:


        #  br label %bb7


        #bb7:  %r382 = phi i32 [ %r384, %bb5 ], [ %r380, %bb6 ]
        mov     w10, w10
        b     bb7

        #bb7:
bb7:


        #  %r382 = phi i32 [ %r384, %bb5 ], [ %r380, %bb6 ]

        #  %r383 = add i32 %r381, 1
        add     w9, w9, #1

        #  br label %bb2


        #bb2:  %r380 = phi i32 [ %r378, %bb1 ], [ %r382, %bb7 ]
        mov     w10, w10

        #bb2:  %r381 = phi i32 [ %r379, %bb1 ], [ %r383, %bb7 ]
        mov     w9, w9
        b     bb2

        #bb4:
bb4:


        #  ret i32 %r380
        mov     w0, w10
        mov     sp, x29
        ret

        #%r388->x9

        #%r387->x9

        #%r474->x10

        #%r386->x9

        #%r473->x10

        #%r139->x9

        #%r385->x9

        #%r472->x11

        #%r138->x10

        #%r137->x10

        #%r136->x11

        #%r135->x10

        #%r396->x11

        #%r389->x12

        #%r129->x11

        #%r390->x10

        #%r121->x10

        #%r469->x9

        #%r119->x11

        #%r467->x9

        #%r391->x9

        #%r392->x11

        #%r393->x9

        #%r394->x12

        #%r395->x9

        #%r466->x9

        #%r468->x9

        #%r470->x9

        #%r471->x9
getNumPos:


        #bb52:
bb52:


        #  %r385 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w11, w0
        mov     w10, w1
        mov     w9, #0

        #  %r386 = add i32 0, 0
        mov     w9, #0

        #  %r387 = add i32 0, 0
        mov     w9, #0

        #  %r389 = add i32 %r119, 0
        mov     w12, w11

        #  %r388 = add i32 0, 0
        mov     w9, #0

        #  %r390 = add i32 %r121, 0
        mov     w10, w10

        #  br label %bb8

        b     bb8

        #bb8:
bb8:


        #  %r391 = add i32 1, 0
        mov     w9, #1

        #  %r392 = add i32 0, 0
        mov     w9, #0
        mov     w11, w9

        #  br label %bb9


        #bb9:  %r393 = phi i32 [ %r389, %bb8 ], [ %r395, %bb10 ]
        mov     w9, w12

        #bb9:  %r394 = phi i32 [ %r392, %bb8 ], [ %r396, %bb10 ]
        mov     w12, w11
        b     bb9

        #bb9:
bb9:


        #  %r393 = phi i32 [ %r389, %bb8 ], [ %r395, %bb10 ]

        #  %r394 = phi i32 [ %r392, %bb8 ], [ %r396, %bb10 ]

        #  %r127 = icmp slt i32 %r394, %r390
        cmp     w12, w10

        #  br i1 %r127, label %bb10, label %bb11

        b.lt     bb10
        b     bb11

        #bb10:
bb10:


        #  %r129 = load i32, i32* @base
        adrp     x11, base
        add     x11, x11, #:lo12:base
        ldr     w11, [x11]

        #  %r395 = sdiv i32 %r393, %r129
        sdiv     w9, w9, w11

        #  %r396 = add i32 %r394, 1
        add     w11, w12, #1

        #  br label %bb9


        #bb9:  %r393 = phi i32 [ %r389, %bb8 ], [ %r395, %bb10 ]
        mov     w9, w9

        #bb9:  %r394 = phi i32 [ %r392, %bb8 ], [ %r396, %bb10 ]
        mov     w12, w11
        b     bb9

        #bb11:
bb11:


        #  %r135 = load i32, i32* @base
        adrp     x10, base
        add     x10, x10, #:lo12:base
        ldr     w10, [x10]

        #  %r136 = sdiv i32 %r393, %r135
        sdiv     w11, w9, w10

        #  %r137 = load i32, i32* @base
        adrp     x10, base
        add     x10, x10, #:lo12:base
        ldr     w10, [x10]

        #  %r138 = mul i32 %r136, %r137
        mul     w10, w11, w10

        #  %r139 = sub i32 %r393, %r138
        sub     w9, w9, w10

        #  ret i32 %r139
        mov     w0, w9
        mov     sp, x29
        ret

        #%r607->x10

        #%r606->x11

        #%r605->x11

        #%r604->x9

        #%r603->x9

        #%r602->x9

        #%r601->x9

        #%r600->x10

        #%r599->x9

        #%r598->x9

        #%r597->x9

        #%r596->x11

        #%r595->x11

        #%r594->x9

        #%r593->x9

        #%r592->x9

        #%r591->x9

        #%r590->x10

        #%r589->x9

        #%r586->x10

        #%r583->x9

        #%r581->x9

        #%r579->x9

        #%r575->x10

        #%r572->x9

        #%r570->x9

        #%r567->x9

        #%r566->x11

        #%r565->x11

        #%r564->x9

        #%r563->x9

        #%r562->x9

        #%r561->x9

        #%r559->x9

        #%r554->x9

        #%r552->x12

        #%r551->x12

        #%r550->x9

        #%r549->x9

        #%r547->x9

        #%r543->x12

        #%r541->x9

        #%r540->x9

        #%r539->x9

        #%r537->x9

        #%r536->x9

        #%r534->x10

        #%r530->x11

        #%r529->x9

        #%r528->x9

        #%r527->x10

        #%r526->x9

        #%r525->x10

        #%r524->x9

        #%r523->x9

        #%r521->x9

        #%r520->x10

        #%r519->x9

        #%r517->x10

        #%r516->x9

        #%r515->x9

        #%r514->x9

        #%r513->x10

        #%r511->x9

        #%r510->x9

        #%r508->x9

        #%r507->x9

        #%r506->x9

        #%r505->x11

        #%r504->x11

        #%r503->x9

        #%r502->x9

        #%r501->x9

        #%r500->x11

        #%r498->x9

        #%r497->x9

        #%r496->x9

        #%r494->x11

        #%r493->x9

        #%r492->x9

        #%r490->x9

        #%r489->x10

        #%r488->x11

        #%r485->x12

        #%r482->x12

        #%r481->x12

        #%r479->x12

        #%r478->x12

        #%r555->x12

        #%r298->x9

        #%r425->x10

        #%r553->x9

        #%r296->x9

        #%r423->x9

        #%r548->x9

        #%r291->x9

        #%r418->x12

        #%r544->x12

        #%r287->x9

        #%r538->x11

        #%r281->x9

        #%r408->x9

        #%r522->x10

        #%r265->x9

        #%r509->x9

        #%r252->x9

        #%r558->x9

        #%r301->x10

        #%r428->x9

        #%r499->x11

        #%r242->x9

        #%r495->x11

        #%r238->x9

        #%r546->x11

        #%r289->x10

        #%r487->x12

        #%r230->x9

        #%r545->x9

        #%r288->x9

        #%r415->x9

        #%r486->x12

        #%r229->x9

        #%r484->x12

        #%r227->x10

        #%r542->x9

        #%r285->x9

        #%r483->x12

        #%r226->x9

        #%r480->x12

        #%r223->x9

        #%r477->x12

        #%r535->x9

        #%r278->x9

        #%r405->x9

        #%r533->x10

        #%r276->[sp,#16]

        #%r403->x9

        #%r217->x11

        #%r560->x10

        #%r303->x9

        #%r430->x9

        #%r491->x9

        #%r234->x9

        #%r429->x10

        #%r416->x10

        #%r159->x11

        #%r413->x14

        #%r442->x9

        #%r532->x11

        #%r275->x9

        #%r216->x9

        #%r414->x13

        #%r157->x11

        #%r411->x9

        #%r440->x11

        #%r531->x10

        #%r274->x9

        #%r401->x9

        #%r215->x9

        #%r419->x9

        #%r194->x9

        #%r578->x9

        #%r321->x9

        #%r406->x9

        #%r556->x12

        #%r299->x9

        #%r426->x9

        #%r435->x10

        #%r210->x9

        #%r402->x9

        #%r145->x9

        #%r557->x9

        #%r300->x9

        #%r427->x11

        #%r436->x12

        #%r518->x9

        #%r261->x9

        #%r412->x15

        #%r155->x11

        #%r152->x9

        #%r409->x9

        #%r213->x11

        #%r201->x9

        #%r585->x9

        #%r328->x11

        #%r399->x9

        #%r142->[sp,#0]

        #%r198->x9

        #%r582->x9

        #%r325->x12

        #%r571->x9

        #%r314->x11

        #%r441->x11

        #%r190->x9

        #%r574->x9

        #%r317->x9

        #%r187->x9

        #%r444->x11

        #%r512->x9

        #%r255->x9

        #%r196->x9

        #%r580->x10

        #%r323->x11

        #%r197->x9

        #%r397->x9

        #%r140->x11

        #%r199->x10

        #%r207->x9

        #%r208->x11

        #%r212->x9

        #%r568->x10

        #%r311->x9

        #%r181->x9

        #%r438->x10

        #%r569->x9

        #%r312->x9

        #%r182->x9

        #%r439->x10

        #%r573->x9

        #%r316->x9

        #%r186->x9

        #%r443->x10

        #%r576->x10

        #%r319->x11

        #%r446->x9

        #%r577->x9

        #%r320->x11

        #%r584->x9

        #%r327->x9

        #%r587->x9

        #%r330->x9

        #%r588->x9

        #%r331->x9

        #%r398->x9

        #%r143->x10

        #%r400->x9

        #%r404->x9

        #%r407->x9

        #%r410->x9

        #%r417->x9

        #%r420->x10

        #%r421->x9

        #%r165->x9

        #%r422->x13

        #%r424->x9

        #%r431->x10

        #%r175->x9

        #%r432->x11

        #%r176->x9

        #%r433->x11

        #%r434->x10

        #%r437->x10

        #%r188->[sp,#8]

        #%r445->x9

        #%r475->x12

        #%r219->x9

        #%r476->x12

        #%r608->x9

        #%r609->x10

        #%r610->x9

        #%r611->x9

        #%r612->x10

        #%r613->x9

        #%r614->x10

        #%r615->x9

        #%r616->x9

        #%r617->x11

        #%r618->x10

        #%r619->x11

        #%r620->x10

        #%r621->x10

        #%r622->x9

        #%r623->x9

        #%r624->x9

        #%r625->x9

        #%r626->x11

        #%r627->x9

        #%r628->x9

        #%r629->x11

        #%r630->x12

        #%r631->x11

        #%r632->x11

        #%r633->x9

        #%r634->x11

        #%r635->x9

        #%r636->x9

        #%r637->x11

        #%r638->x12

        #%r639->x11

        #%r640->x11

        #%r641->x11

        #%r642->x12

        #%r643->x11

        #%r644->x11

        #%r645->x9

        #%r646->x11

        #%r647->x9

        #%r648->x9

        #%r649->x9

        #%r650->x9

        #%r651->x13

        #%r652->x13
radixSort:


        #147:x29,#-192

        #148:x29,#-128

        #149:x29,#-64

        #bb53:
bb53:


        #  %r397 = add i32 0, 0
        mov     x16, #216
        sub     sp, sp, x16
        mov     w11, w0
        mov     x16, x1
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w10, w2
        mov     w9, w3
        mov     w12, #0

        #  %r398 = add i32 0, 0
        mov     w12, #0

        #  %r399 = add i32 0, 0
        mov     w12, #0

        #  %r400 = add i32 0, 0
        mov     w12, #0

        #  %r401 = add i32 0, 0
        mov     w12, #0

        #  %r402 = add i32 0, 0
        mov     w12, #0

        #  %r403 = add i32 0, 0
        mov     w12, #0

        #  %r404 = add i32 0, 0
        mov     w12, #0

        #  %r405 = add i32 0, 0
        mov     w12, #0

        #  %r406 = add i32 0, 0
        mov     w12, #0

        #  %r407 = add i32 0, 0
        mov     w12, #0

        #  %r408 = add i32 0, 0
        mov     w12, #0

        #  %r149 = alloca [ 16 x i32 ]

        #  %r148 = alloca [ 16 x i32 ]

        #  %r147 = alloca [ 16 x i32 ]

        #  %r409 = add i32 0, 0
        mov     w12, #0

        #  %r412 = add i32 %r140, 0
        mov     w15, w11

        #  %r410 = add i32 0, 0
        mov     w11, #0

        #  %r413 = add i32 %r143, 0
        mov     w14, w10

        #  %r411 = add i32 0, 0
        mov     w10, #0

        #  %r414 = add i32 %r145, 0
        mov     w13, w9

        #  br label %bb12

        b     bb12

        #bb12:
bb12:


        #  %r415 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb13


        #bb13:  %r416 = phi i32 [ %r415, %bb12 ], [ %r446, %bb14 ]
        mov     w10, w9
        b     bb13

        #bb13:
bb13:


        #  %r416 = phi i32 [ %r415, %bb12 ], [ %r446, %bb14 ]

        #  %r152 = load i32, i32* @base
        adrp     x9, base
        add     x9, x9, #:lo12:base
        ldr     w9, [x9]

        #  %r153 = icmp slt i32 %r416, %r152
        cmp     w10, w9

        #  br i1 %r153, label %bb14, label %bb15

        b.lt     bb14
        b     bb15

        #bb14:
bb14:


        #  %r155 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r416
        mov     x9, #4
        mul     x9, x10, x9
        mov     x11, #-192
        add     x11, x29, x11
        add     x11, x11, x9

        #  store i32 0, i32* %r155
        mov     w9, #0
        str     w9, [x11]

        #  %r157 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r416
        mov     x9, #4
        mul     x9, x10, x9
        mov     x11, #-128
        add     x11, x29, x11
        add     x11, x11, x9

        #  store i32 0, i32* %r157
        mov     w9, #0
        str     w9, [x11]

        #  %r159 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r416
        mov     x9, #4
        mul     x9, x10, x9
        mov     x11, #-64
        add     x11, x29, x11
        add     x11, x11, x9

        #  store i32 0, i32* %r159
        mov     w9, #0
        str     w9, [x11]

        #  %r446 = add i32 %r416, 1
        add     w9, w10, #1

        #  br label %bb13


        #bb13:  %r416 = phi i32 [ %r415, %bb12 ], [ %r446, %bb14 ]
        mov     w10, w9
        b     bb13

        #bb15:
bb15:


        #  %r163 = icmp eq i32 %r412, -1
        mov     w9, #-1
        cmp     w15, w9

        #  br i1 %r163, label %bb16, label %bb19

        b.eq     bb16
        b     bb19

        #bb19:
bb19:


        #  %r165 = add i32 %r413, 1
        add     w9, w14, #1

        #  %r167 = icmp sge i32 %r165, %r414
        cmp     w9, w13

        #  br i1 %r167, label %bb16, label %bb17

        b.ge     bb16
        b     bb17

        #bb16:
bb16:


        #  ret void
        mov     sp, x29
        ret

        #bb17:
bb17:


        #  br label %bb18

        b     bb18

        #bb18:
bb18:


        #  %r417 = add i32 %r413, 0
        mov     w9, w14

        #  br label %bb20


        #bb20:  %r418 = phi i32 [ %r417, %bb18 ], [ %r445, %bb21 ]
        mov     w12, w9
        b     bb20

        #bb20:
bb20:


        #  %r418 = phi i32 [ %r417, %bb18 ], [ %r445, %bb21 ]

        #  %r172 = icmp slt i32 %r418, %r414
        cmp     w12, w13

        #  br i1 %r172, label %bb21, label %bb22

        b.lt     bb21
        b     bb22

        #bb21:
bb21:


        #  %r175 = getelementptr i32, i32* %r142, i32 %r418
        mov     x9, #4
        mul     x9, x12, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r176 = load i32, i32* %r175
        ldr     w9, [x9]

        #  %r443 = call i32 @getNumPos(i32 %r176, i32 %r412)
        mov     w0, w9
        mov     w1, w15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r181 = getelementptr i32, i32* %r142, i32 %r418
        mov     x9, #4
        mul     x9, x12, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r182 = load i32, i32* %r181
        ldr     w9, [x9]

        #  %r444 = call i32 @getNumPos(i32 %r182, i32 %r412)
        mov     w0, w9
        mov     w1, w15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  %r186 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r443
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-64
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r187 = load i32, i32* %r186
        ldr     w9, [x9]

        #  %r188 = add i32 %r187, 1
        add     w16, w9, #1
        mov     x17, #8
        str     x16, [sp,x17]

        #  %r190 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r444
        mov     x9, #4
        mul     x10, x11, x9
        mov     x9, #-64
        add     x9, x29, x9
        add     x9, x9, x10

        #  store i32 %r188, i32* %r190
        mov     x16, #8
        ldr     x19, [sp,x16]
        str     w19, [x9]

        #  %r445 = add i32 %r418, 1
        add     w9, w12, #1

        #  br label %bb20


        #bb20:  %r418 = phi i32 [ %r417, %bb18 ], [ %r445, %bb21 ]
        mov     w12, w9
        b     bb20

        #bb22:
bb22:


        #  %r194 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10

        #  store i32 %r413, i32* %r194
        str     w14, [x9]

        #  %r196 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-64
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r197 = load i32, i32* %r196
        ldr     w9, [x9]

        #  %r198 = add i32 %r413, %r197
        add     w9, w14, w9

        #  %r199 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 0
        mov     x11, #0
        mov     x10, #4
        mul     x11, x11, x10
        mov     x10, #-128
        add     x10, x29, x10
        add     x10, x10, x11

        #  store i32 %r198, i32* %r199
        str     w9, [x10]

        #  %r419 = add i32 1, 0
        mov     w9, #1
        mov     w9, w9

        #  br label %bb23


        #bb23:  %r420 = phi i32 [ %r419, %bb22 ], [ %r442, %bb24 ]
        mov     w10, w9
        b     bb23

        #bb23:
bb23:


        #  %r420 = phi i32 [ %r419, %bb22 ], [ %r442, %bb24 ]

        #  %r201 = load i32, i32* @base
        adrp     x9, base
        add     x9, x9, #:lo12:base
        ldr     w9, [x9]

        #  %r202 = icmp slt i32 %r420, %r201
        cmp     w10, w9

        #  br i1 %r202, label %bb24, label %bb25

        b.lt     bb24
        b     bb25

        #bb24:
bb24:


        #  %r441 = sub i32 %r420, 1
        sub     w11, w10, #1

        #  %r207 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r441
        mov     x9, #4
        mul     x11, x11, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x9, x9, x11

        #  %r208 = load i32, i32* %r207
        ldr     w11, [x9]

        #  %r210 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r420
        mov     x9, #4
        mul     x9, x10, x9
        mov     x12, #-192
        add     x12, x29, x12
        add     x9, x12, x9

        #  store i32 %r208, i32* %r210
        str     w11, [x9]

        #  %r212 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r420
        mov     x9, #4
        mul     x11, x10, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x11

        #  %r213 = load i32, i32* %r212
        ldr     w11, [x9]

        #  %r215 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r420
        mov     x9, #4
        mul     x9, x10, x9
        mov     x12, #-64
        add     x12, x29, x12
        add     x9, x12, x9

        #  %r216 = load i32, i32* %r215
        ldr     w9, [x9]

        #  %r217 = add i32 %r213, %r216
        add     w11, w11, w9

        #  %r219 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r420
        mov     x9, #4
        mul     x9, x10, x9
        mov     x12, #-128
        add     x12, x29, x12
        add     x9, x12, x9

        #  store i32 %r217, i32* %r219
        str     w11, [x9]

        #  %r442 = add i32 %r420, 1
        add     w9, w10, #1

        #  br label %bb23


        #bb23:  %r420 = phi i32 [ %r419, %bb22 ], [ %r442, %bb24 ]
        mov     w10, w9
        b     bb23

        #bb25:
bb25:


        #  %r421 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb26


        #bb26:  %r422 = phi i32 [ %r421, %bb25 ], [ %r428, %bb31 ]
        mov     w13, w9
        b     bb26

        #bb26:
bb26:


        #  %r422 = phi i32 [ %r421, %bb25 ], [ %r428, %bb31 ]

        #  %r223 = load i32, i32* @base
        adrp     x9, base
        add     x9, x9, #:lo12:base
        ldr     w9, [x9]

        #  %r224 = icmp slt i32 %r422, %r223
        cmp     w13, w9

        #  br i1 %r224, label %bb27, label %bb28

        b.lt     bb27
        b     bb28

        #bb27:
bb27:


        #  br label %bb29

        b     bb29

        #bb29:
bb29:


        #  %r226 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
        mov     x9, #4
        mul     x10, x13, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r227 = load i32, i32* %r226
        ldr     w10, [x9]

        #  %r229 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r422
        mov     x9, #4
        mul     x9, x13, x9
        mov     x11, #-128
        add     x11, x29, x11
        add     x9, x11, x9

        #  %r230 = load i32, i32* %r229
        ldr     w9, [x9]

        #  %r231 = icmp slt i32 %r227, %r230
        cmp     w10, w9

        #  br i1 %r231, label %bb30, label %bb31

        b.lt     bb30
        b     bb31

        #bb30:
bb30:


        #  %r234 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
        mov     x9, #4
        mul     x10, x13, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r429 = load i32, i32* %r234
        ldr     w10, [x9]

        #  %r238 = getelementptr i32, i32* %r142, i32 %r429
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r430 = load i32, i32* %r238
        ldr     w9, [x9]

        #  br label %bb32


        #bb32:  %r431 = phi i32 [ %r430, %bb30 ], [ %r436, %bb33 ]
        mov     w10, w9
        b     bb32

        #bb32:
bb32:


        #  %r431 = phi i32 [ %r430, %bb30 ], [ %r436, %bb33 ]

        #  %r242 = call i32 @getNumPos(i32 %r431, i32 %r412)
        mov     w0, w10
        mov     w1, w15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  %r244 = icmp ne i32 %r242, %r422
        cmp     w9, w13

        #  br i1 %r244, label %bb33, label %bb34

        b.ne     bb33
        b     bb34

        #bb33:
bb33:


        #  %r433 = add i32 %r431, 0
        mov     w11, w10

        #  %r434 = call i32 @getNumPos(i32 %r433, i32 %r412)
        mov     w0, w11
        mov     w1, w15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r252 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r434
        mov     x9, #4
        mul     x9, x10, x9
        mov     x10, #-192
        add     x10, x29, x10
        add     x9, x10, x9

        #  %r435 = load i32, i32* %r252
        ldr     w10, [x9]

        #  %r255 = getelementptr i32, i32* %r142, i32 %r435
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r436 = load i32, i32* %r255
        ldr     w12, [x9]

        #  %r437 = call i32 @getNumPos(i32 %r433, i32 %r412)
        mov     w0, w11
        mov     w1, w15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r261 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r437
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r438 = load i32, i32* %r261
        ldr     w10, [x9]

        #  %r265 = getelementptr i32, i32* %r142, i32 %r438
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  store i32 %r433, i32* %r265
        str     w11, [x9]

        #  %r439 = call i32 @getNumPos(i32 %r433, i32 %r412)
        mov     w0, w11
        mov     w1, w15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r440 = call i32 @getNumPos(i32 %r433, i32 %r412)
        mov     w0, w11
        mov     w1, w15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  %r274 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r439
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r275 = load i32, i32* %r274
        ldr     w9, [x9]

        #  %r276 = add i32 %r275, 1
        add     w16, w9, #1
        mov     x17, #16
        str     x16, [sp,x17]

        #  %r278 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r440
        mov     x9, #4
        mul     x10, x11, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10

        #  store i32 %r276, i32* %r278
        mov     x16, #16
        ldr     x19, [sp,x16]
        str     w19, [x9]

        #  br label %bb32


        #bb32:  %r431 = phi i32 [ %r430, %bb30 ], [ %r436, %bb33 ]
        mov     w10, w12
        b     bb32

        #bb34:
bb34:


        #  %r281 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
        mov     x9, #4
        mul     x9, x13, x9
        mov     x11, #-192
        add     x11, x29, x11
        add     x9, x11, x9

        #  %r432 = load i32, i32* %r281
        ldr     w11, [x9]

        #  %r285 = getelementptr i32, i32* %r142, i32 %r432
        mov     x9, #4
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  store i32 %r431, i32* %r285
        str     w10, [x9]

        #  %r287 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
        mov     x9, #4
        mul     x10, x13, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r288 = load i32, i32* %r287
        ldr     w9, [x9]

        #  %r289 = add i32 %r288, 1
        add     w10, w9, #1

        #  %r291 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
        mov     x9, #4
        mul     x9, x13, x9
        mov     x11, #-192
        add     x11, x29, x11
        add     x9, x11, x9

        #  store i32 %r289, i32* %r291
        str     w10, [x9]

        #  br label %bb29

        b     bb29

        #bb31:
bb31:


        #  %r428 = add i32 %r422, 1
        add     w9, w13, #1

        #  br label %bb26


        #bb26:  %r422 = phi i32 [ %r421, %bb25 ], [ %r428, %bb31 ]
        mov     w13, w9
        b     bb26

        #bb28:
bb28:


        #  %r423 = add i32 %r413, 0

        #  %r296 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10

        #  store i32 %r413, i32* %r296
        str     w14, [x9]

        #  %r298 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-64
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r299 = load i32, i32* %r298
        ldr     w9, [x9]

        #  %r300 = add i32 %r413, %r299
        add     w9, w14, w9

        #  %r301 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 0
        mov     x11, #0
        mov     x10, #4
        mul     x11, x11, x10
        mov     x10, #-128
        add     x10, x29, x10
        add     x10, x10, x11

        #  store i32 %r300, i32* %r301
        str     w9, [x10]

        #  %r424 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb35


        #bb35:  %r425 = phi i32 [ %r424, %bb28 ], [ %r426, %bb40 ]
        mov     w10, w9
        b     bb35

        #bb35:
bb35:


        #  %r425 = phi i32 [ %r424, %bb28 ], [ %r426, %bb40 ]

        #  %r303 = load i32, i32* @base
        adrp     x9, base
        add     x9, x9, #:lo12:base
        ldr     w9, [x9]

        #  %r304 = icmp slt i32 %r425, %r303
        cmp     w10, w9

        #  br i1 %r304, label %bb36, label %bb37

        b.lt     bb36
        b     bb37

        #bb36:
bb36:


        #  %r306 = icmp sgt i32 %r425, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r306, label %bb38, label %bb39

        b.gt     bb38
        b     bb39

        #bb38:
bb38:


        #  %r427 = sub i32 %r425, 1
        sub     w11, w10, #1

        #  %r311 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r427
        mov     x9, #4
        mul     x11, x11, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x9, x9, x11

        #  %r312 = load i32, i32* %r311
        ldr     w9, [x9]

        #  %r314 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r425
        mov     x11, #4
        mul     x12, x10, x11
        mov     x11, #-192
        add     x11, x29, x11
        add     x11, x11, x12

        #  store i32 %r312, i32* %r314
        str     w9, [x11]

        #  %r316 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r425
        mov     x9, #4
        mul     x11, x10, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x11

        #  %r317 = load i32, i32* %r316
        ldr     w9, [x9]

        #  %r319 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r425
        mov     x11, #4
        mul     x12, x10, x11
        mov     x11, #-64
        add     x11, x29, x11
        add     x11, x11, x12

        #  %r320 = load i32, i32* %r319
        ldr     w11, [x11]

        #  %r321 = add i32 %r317, %r320
        add     w9, w9, w11

        #  %r323 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r425
        mov     x11, #4
        mul     x12, x10, x11
        mov     x11, #-128
        add     x11, x29, x11
        add     x11, x11, x12

        #  store i32 %r321, i32* %r323
        str     w9, [x11]

        #  br label %bb40

        b     bb40

        #bb39:
bb39:


        #  br label %bb40

        b     bb40

        #bb40:
bb40:


        #  %r325 = sub i32 %r412, 1
        sub     w12, w15, #1

        #  %r327 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r425
        mov     x9, #4
        mul     x11, x10, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x11

        #  %r328 = load i32, i32* %r327
        ldr     w11, [x9]

        #  %r330 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r425
        mov     x9, #4
        mul     x9, x10, x9
        mov     x13, #-128
        add     x13, x29, x13
        add     x9, x13, x9

        #  %r331 = load i32, i32* %r330
        ldr     w9, [x9]

        #  call void @radixSort(i32 %r325, i32* %r142, i32 %r328, i32 %r331)
        mov     w0, w12
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x1, x19
        mov     w2, w11
        mov     w3, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     radixSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r426 = add i32 %r425, 1
        add     w9, w10, #1

        #  br label %bb35


        #bb35:  %r425 = phi i32 [ %r424, %bb28 ], [ %r426, %bb40 ]
        mov     w10, w9
        b     bb35

        #bb37:
bb37:


        #  ret void
        mov     sp, x29
        ret

        #%r682->x9

        #%r681->x9

        #%r680->x9

        #%r679->x9

        #%r678->x9

        #%r677->x9

        #%r676->x9

        #%r675->x11

        #%r674->x13

        #%r673->x13

        #%r672->x13

        #%r671->x14

        #%r670->x13

        #%r669->x11

        #%r665->x9

        #%r663->x9

        #%r662->x9

        #%r656->x9

        #%r660->x9

        #%r365->x11

        #%r452->x12

        #%r659->x9

        #%r364->x11

        #%r451->x9

        #%r657->x9

        #%r362->x13

        #%r449->x9

        #%r655->x9

        #%r360->x14

        #%r683->x9

        #%r447->x9

        #%r654->x9

        #%r359->x13

        #%r357->x14

        #%r356->x13

        #%r354->x11

        #%r658->x11

        #%r363->x13

        #%r450->x10

        #%r653->x9

        #%r350->x12

        #%r342->x9

        #%r666->x11

        #%r371->x10

        #%r353->x11

        #%r340->x13

        #%r664->x9

        #%r369->x10

        #%r456->x9

        #%r661->x9

        #%r366->x12

        #%r453->x9

        #%r667->x11

        #%r372->x10

        #%r668->x13

        #%r373->x9

        #%r448->x9

        #%r454->x9

        #%r455->x9

        #%r684->x9
main:


        #bb41:
bb41:


        #  %r447 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #0

        #  %r448 = add i32 0, 0
        mov     w9, #0

        #  %r450 = call i32 @getint()
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

        #  %r449 = add i32 0, 0
        mov     w9, #0

        #  %r451 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb42


        #bb42:  %r452 = phi i32 [ %r451, %bb41 ], [ %r456, %bb43 ]
        mov     w12, w9
        b     bb42

        #bb42:
bb42:


        #  %r452 = phi i32 [ %r451, %bb41 ], [ %r456, %bb43 ]

        #  %r339 = icmp slt i32 %r452, %r450
        cmp     w12, w10

        #  br i1 %r339, label %bb43, label %bb44

        b.lt     bb43
        b     bb44

        #bb43:
bb43:


        #  %r340 = call i32 @getint()
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

        #  %r342 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r452
        mov     x9, #4
        mul     x11, x12, x9
        adrp     x9, a
        add     x9, x9, #:lo12:a
        add     x9, x9, x11

        #  store i32 %r340, i32* %r342
        str     w13, [x9]

        #  %r456 = add i32 %r452, 1
        add     w9, w12, #1

        #  br label %bb42


        #bb42:  %r452 = phi i32 [ %r451, %bb41 ], [ %r456, %bb43 ]
        mov     w12, w9
        b     bb42

        #bb44:
bb44:


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

        #  call void @radixSort(i32 8, i32* @a, i32 0, i32 %r450)
        mov     w9, #8
        mov     w0, w9
        adrp     x9, a
        add     x9, x9, #:lo12:a
        mov     x1, x9
        mov     w9, #0
        mov     w2, w9
        mov     w3, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     radixSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r453 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb45


        #bb45:  %r454 = phi i32 [ %r453, %bb44 ], [ %r455, %bb46 ]
        mov     w9, w9
        b     bb45

        #bb45:
bb45:


        #  %r454 = phi i32 [ %r453, %bb44 ], [ %r455, %bb46 ]

        #  %r349 = icmp slt i32 %r454, %r450
        cmp     w9, w10

        #  br i1 %r349, label %bb46, label %bb47

        b.lt     bb46
        b     bb47

        #bb46:
bb46:


        #  %r350 = load i32, i32* @ans
        adrp     x11, ans
        add     x11, x11, #:lo12:ans
        ldr     w12, [x11]

        #  %r353 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r454
        mov     x11, #4
        mul     x13, x9, x11
        adrp     x11, a
        add     x11, x11, #:lo12:a
        add     x11, x11, x13

        #  %r354 = load i32, i32* %r353
        ldr     w11, [x11]

        #  %r356 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r454
        mov     x13, #4
        mul     x14, x9, x13
        adrp     x13, a
        add     x13, x13, #:lo12:a
        add     x13, x13, x14

        #  %r357 = load i32, i32* %r356
        ldr     w14, [x13]

        #  %r359 = add i32 2, %r454
        mov     w13, #2
        add     w13, w13, w9

        #  %r360 = sdiv i32 %r357, %r359
        sdiv     w14, w14, w13

        #  %r362 = add i32 2, %r454
        mov     w13, #2
        add     w13, w13, w9

        #  %r363 = mul i32 %r360, %r362
        mul     w13, w14, w13

        #  %r364 = sub i32 %r354, %r363
        sub     w11, w11, w13

        #  %r365 = mul i32 %r454, %r364
        mul     w11, w9, w11

        #  %r366 = add i32 %r350, %r365
        add     w12, w12, w11

        #  store i32 %r366, i32* @ans
        adrp     x11, ans
        add     x11, x11, #:lo12:ans
        str     w12, [x11]

        #  %r455 = add i32 %r454, 1
        add     w9, w9, #1

        #  br label %bb45


        #bb45:  %r454 = phi i32 [ %r453, %bb44 ], [ %r455, %bb46 ]
        mov     w9, w9
        b     bb45

        #bb47:
bb47:


        #  %r369 = load i32, i32* @ans
        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        ldr     w10, [x9]

        #  %r370 = icmp slt i32 %r369, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r370, label %bb48, label %bb49

        b.lt     bb48
        b     bb49

        #bb48:
bb48:


        #  %r371 = load i32, i32* @ans
        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        ldr     w10, [x9]

        #  %r372 = sub i32 0, %r371
        mov     w9, #0
        sub     w10, w9, w10

        #  store i32 %r372, i32* @ans
        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        str     w10, [x9]

        #  br label %bb50

        b     bb50

        #bb49:
bb49:


        #  br label %bb50

        b     bb50

        #bb50:
bb50:


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

        #  %r373 = load i32, i32* @ans
        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        ldr     w9, [x9]

        #  call void @putint(i32 %r373)
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

        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
