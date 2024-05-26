.section .data
.global    base
.global    a
.global    ans
base:
        .quad   16
a:
        .zero   240000080
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
        //%r381->x12
        //%r380->x11
        //%r379->x12
        //%r466->x11
        //%r378->x9
        //%r465->x11
        //%r377->x9
        //%r464->x11
        //%r376->x9
        //%r463->x11
        //%r114->x11
        //%r375->x9
        //%r462->x11
        //%r110->x11
        //%r458->x9
        //%r382->x13
        //%r109->x11
        //%r102->x10
        //%r100->x11
        //%r383->x12
        //%r384->x11
        //%r385->x11
        //%r459->x9
        //%r460->x9
        //%r461->x11
getMaxNum:

        //bb51:

bb51:

        //  %r375 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        //  %r376 = add i32 0, 0

        mov     x9, #0
        //  %r377 = add i32 0, 0

        mov     x9, #0
        //  %r378 = add i32 %r100, 0

        mov     x9, x11
        //  %r379 = add i32 0, 0

        mov     x11, #0
        mov     x12, x11
        //  %r380 = add i32 0, 0

        mov     x11, #0
        mov     x11, x11
        //  br label %bb2


        //bb2:  %r381 = phi i32 [ %r379, %bb51 ], [ %r383, %bb7 ]

        mov     x12, x12
        //bb2:  %r382 = phi i32 [ %r380, %bb51 ], [ %r384, %bb7 ]

        mov     x13, x11
        b     bb2
        //bb2:

bb2:

        //  %r381 = phi i32 [ %r379, %bb51 ], [ %r383, %bb7 ]

        //  %r382 = phi i32 [ %r380, %bb51 ], [ %r384, %bb7 ]

        //  %r107 = icmp slt i32 %r382, %r378

        cmp     x13, x9
        //  br i1 %r107, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r109 = getelementptr i32, i32* %r102, i32 %r382

        mov     x11, #8
        mul     x11, x13, x11
        add     x11, x10, x11
        //  %r110 = load i32, i32* %r109

        ldr     x11, [x11]
        //  %r112 = icmp sgt i32 %r110, %r381

        cmp     x11, x12
        //  br i1 %r112, label %bb5, label %bb6


        b.gt     bb5
        b     bb6
        //bb5:

bb5:

        //  %r114 = getelementptr i32, i32* %r102, i32 %r382

        mov     x11, #8
        mul     x11, x13, x11
        add     x11, x10, x11
        //  %r385 = load i32, i32* %r114

        ldr     x11, [x11]
        //  br label %bb7


        //bb7:  %r383 = phi i32 [ %r385, %bb5 ], [ %r381, %bb6 ]

        mov     x12, x11
        b     bb7
        //bb6:

bb6:

        //  br label %bb7


        //bb7:  %r383 = phi i32 [ %r385, %bb5 ], [ %r381, %bb6 ]

        mov     x12, x12
        b     bb7
        //bb7:

bb7:

        //  %r383 = phi i32 [ %r385, %bb5 ], [ %r381, %bb6 ]

        //  %r384 = add i32 %r382, 1

        add     x11, x13, #1
        //  br label %bb2


        //bb2:  %r381 = phi i32 [ %r379, %bb51 ], [ %r383, %bb7 ]

        mov     x12, x12
        //bb2:  %r382 = phi i32 [ %r380, %bb51 ], [ %r384, %bb7 ]

        mov     x13, x11
        b     bb2
        //bb4:

bb4:

        //  ret i32 %r381

        mov     x0, x12
        mov     sp, x29
        ret
        //%r390->x10
        //%r129->x9
        //%r388->x9
        //%r475->x9
        //%r387->x9
        //%r474->x9
        //%r386->x9
        //%r473->x9
        //%r139->x9
        //%r138->x9
        //%r137->x9
        //%r136->x11
        //%r397->x9
        //%r135->x9
        //%r396->x10
        //%r389->x9
        //%r121->x11
        //%r469->x9
        //%r119->x10
        //%r467->x9
        //%r391->x12
        //%r392->x9
        //%r393->x9
        //%r394->x10
        //%r395->x11
        //%r468->x9
        //%r470->x9
        //%r471->x9
        //%r472->x9
getNumPos:

        //bb52:

bb52:

        //  %r386 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r387 = add i32 0, 0

        mov     x9, #0
        //  %r388 = add i32 0, 0

        mov     x9, #0
        //  %r390 = add i32 %r119, 0

        mov     x10, x10
        //  %r389 = add i32 0, 0

        mov     x9, #0
        //  %r391 = add i32 %r121, 0

        mov     x12, x11
        //  %r392 = add i32 1, 0

        mov     x9, #1
        //  %r393 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb9


        //bb9:  %r394 = phi i32 [ %r390, %bb52 ], [ %r396, %bb10 ]

        mov     x10, x10
        //bb9:  %r395 = phi i32 [ %r393, %bb52 ], [ %r397, %bb10 ]

        mov     x11, x9
        b     bb9
        //bb9:

bb9:

        //  %r394 = phi i32 [ %r390, %bb52 ], [ %r396, %bb10 ]

        //  %r395 = phi i32 [ %r393, %bb52 ], [ %r397, %bb10 ]

        //  %r127 = icmp slt i32 %r395, %r391

        cmp     x11, x12
        //  br i1 %r127, label %bb10, label %bb11


        b.lt     bb10
        b     bb11
        //bb10:

bb10:

        //  %r129 = load i32, i32* @base

        adrp     x9, base
        add     x9, x9, #:lo12:base
        ldr     x9, [x9]
        //  %r396 = sdiv i32 %r394, %r129

        sdiv     x10, x10, x9
        //  %r397 = add i32 %r395, 1

        add     x9, x11, #1
        //  br label %bb9


        //bb9:  %r394 = phi i32 [ %r390, %bb52 ], [ %r396, %bb10 ]

        mov     x10, x10
        //bb9:  %r395 = phi i32 [ %r393, %bb52 ], [ %r397, %bb10 ]

        mov     x11, x9
        b     bb9
        //bb11:

bb11:

        //  %r135 = load i32, i32* @base

        adrp     x9, base
        add     x9, x9, #:lo12:base
        ldr     x9, [x9]
        //  %r136 = sdiv i32 %r394, %r135

        sdiv     x11, x10, x9
        //  %r137 = load i32, i32* @base

        adrp     x9, base
        add     x9, x9, #:lo12:base
        ldr     x9, [x9]
        //  %r138 = mul i32 %r136, %r137

        mul     x9, x11, x9
        //  %r139 = sub i32 %r394, %r138

        sub     x9, x10, x9
        //  ret i32 %r139

        mov     x0, x9
        mov     sp, x29
        ret
        //%r607->x9
        //%r606->x9
        //%r605->x10
        //%r604->x9
        //%r603->x9
        //%r602->x9
        //%r601->x10
        //%r600->x9
        //%r599->x10
        //%r598->x10
        //%r597->x10
        //%r596->x10
        //%r595->x15
        //%r594->x10
        //%r593->x9
        //%r592->x9
        //%r591->x15
        //%r590->x15
        //%r587->x20
        //%r584->x15
        //%r582->x15
        //%r580->x15
        //%r576->x10
        //%r573->x9
        //%r571->x9
        //%r568->x9
        //%r567->x9
        //%r566->x9
        //%r565->x10
        //%r564->x9
        //%r563->x9
        //%r562->x9
        //%r560->x9
        //%r555->x11
        //%r553->x10
        //%r552->x10
        //%r551->x11
        //%r550->x10
        //%r548->x10
        //%r544->x10
        //%r542->x10
        //%r541->x10
        //%r540->x10
        //%r538->x10
        //%r537->x10
        //%r535->x9
        //%r531->x10
        //%r530->x9
        //%r529->x9
        //%r528->x10
        //%r527->x9
        //%r526->x10
        //%r525->x9
        //%r524->x9
        //%r522->x9
        //%r521->x10
        //%r520->x9
        //%r518->x15
        //%r517->x15
        //%r516->x15
        //%r515->x15
        //%r514->x20
        //%r512->x9
        //%r511->x9
        //%r509->x9
        //%r508->x9
        //%r507->x10
        //%r506->x10
        //%r505->x10
        //%r504->x15
        //%r503->x10
        //%r502->x10
        //%r501->x10
        //%r499->x15
        //%r498->x10
        //%r497->x10
        //%r495->x10
        //%r494->x15
        //%r493->x10
        //%r491->x9
        //%r490->x10
        //%r489->x11
        //%r486->x12
        //%r483->x12
        //%r482->x12
        //%r480->x12
        //%r479->x12
        //%r478->x12
        //%r556->x10
        //%r299->x9
        //%r426->x9
        //%r554->x10
        //%r297->x9
        //%r424->x9
        //%r549->x10
        //%r292->x9
        //%r419->x10
        //%r545->x10
        //%r288->x9
        //%r415->x11
        //%r539->x11
        //%r282->x10
        //%r523->x10
        //%r266->x15
        //%r519->x9
        //%r262->x15
        //%r510->x9
        //%r253->x10
        //%r500->x10
        //%r243->x10
        //%r496->x10
        //%r239->x9
        //%r547->x11
        //%r290->x15
        //%r417->x9
        //%r488->x12
        //%r231->x9
        //%r546->x10
        //%r289->x9
        //%r487->x12
        //%r230->x9
        //%r485->x12
        //%r228->x15
        //%r543->x11
        //%r286->x10
        //%r416->x9
        //%r159->x15
        //%r413->x13
        //%r484->x12
        //%r227->x9
        //%r481->x12
        //%r224->x9
        //%r536->x9
        //%r279->x9
        //%r409->x9
        //%r152->x10
        //%r406->x9
        //%r533->x10
        //%r276->x15
        //%r403->x9
        //%r217->x10
        //%r561->x10
        //%r304->x10
        //%r431->x9
        //%r492->x10
        //%r235->x9
        //%r430->x10
        //%r534->x9
        //%r277->x20
        //%r404->x9
        //%r218->x15
        //%r572->x9
        //%r315->x10
        //%r442->x11
        //%r532->x9
        //%r275->x15
        //%r216->x10
        //%r411->x9
        //%r402->x9
        //%r145->x9
        //%r557->x10
        //%r300->x9
        //%r427->x9
        //%r436->x15
        //%r211->x10
        //%r213->x10
        //%r399->x9
        //%r142->x14
        //%r200->x9
        //%r163->x9
        //%r420->x9
        //%r195->x9
        //%r579->x10
        //%r322->x12
        //%r198->x9
        //%r558->x9
        //%r301->x11
        //%r428->x11
        //%r437->x10
        //%r441->x9
        //%r443->x9
        //%r191->x9
        //%r575->x15
        //%r318->x12
        //%r188->x15
        //%r445->x9
        //%r513->x15
        //%r256->x10
        //%r197->x9
        //%r581->x20
        //%r324->x10
        //%r140->x11
        //%r199->x11
        //%r583->x15
        //%r326->x10
        //%r202->x10
        //%r586->x15
        //%r329->x15
        //%r208->x10
        //%r209->x15
        //%r214->x15
        //%r559->x9
        //%r302->x9
        //%r429->x9
        //%r569->x10
        //%r312->x10
        //%r182->x9
        //%r439->x20
        //%r570->x9
        //%r313->x12
        //%r183->x9
        //%r440->x20
        //%r574->x10
        //%r317->x10
        //%r187->x15
        //%r444->x20
        //%r577->x10
        //%r320->x10
        //%r447->x9
        //%r578->x10
        //%r321->x10
        //%r585->x15
        //%r328->x11
        //%r588->x15
        //%r331->x11
        //%r589->x15
        //%r332->x11
        //%r398->x9
        //%r143->x10
        //%r400->x9
        //%r401->x9
        //%r405->x9
        //%r407->x9
        //%r408->x9
        //%r410->x9
        //%r155->x15
        //%r412->x9
        //%r157->x15
        //%r414->x12
        //%r418->x9
        //%r421->x9
        //%r422->x9
        //%r166->x9
        //%r423->x11
        //%r425->x9
        //%r432->x9
        //%r176->x9
        //%r433->x15
        //%r177->x9
        //%r434->x9
        //%r435->x15
        //%r438->x20
        //%r189->x20
        //%r446->x9
        //%r476->x12
        //%r220->x10
        //%r477->x12
        //%r608->x10
        //%r609->x9
        //%r610->x10
        //%r611->x9
        //%r612->x9
        //%r613->x10
        //%r614->x9
        //%r615->x10
        //%r616->x9
        //%r617->x9
        //%r618->x10
        //%r619->x9
        //%r620->x10
        //%r621->x9
        //%r622->x9
        //%r623->x9
        //%r624->x10
        //%r625->x10
        //%r626->x10
        //%r627->x11
        //%r628->x10
        //%r629->x10
        //%r630->x10
        //%r631->x11
        //%r632->x10
        //%r633->x10
        //%r634->x10
        //%r635->x11
        //%r636->x10
        //%r637->x10
        //%r638->x10
        //%r639->x11
        //%r640->x10
        //%r641->x10
        //%r642->x10
        //%r643->x11
        //%r644->x10
        //%r645->x10
        //%r646->x11
        //%r647->x12
        //%r648->x11
        //%r649->x11
        //%r650->x11
        //%r651->x12
        //%r652->x11
        //%r653->x11
radixSort:

        //147:x29,#-384

        //148:x29,#-256

        //149:x29,#-128

        //bb53:

bb53:

        //  %r398 = add i32 0, 0

        mov     x16, #384
        sub     sp, sp, x16
        mov     x11, x0
        mov     x14, x1
        mov     x10, x2
        mov     x9, x3
        mov     x12, #0
        //  %r399 = add i32 0, 0

        mov     x12, #0
        //  %r400 = add i32 0, 0

        mov     x12, #0
        //  %r401 = add i32 0, 0

        mov     x12, #0
        //  %r402 = add i32 0, 0

        mov     x12, #0
        //  %r403 = add i32 0, 0

        mov     x12, #0
        //  %r404 = add i32 0, 0

        mov     x12, #0
        //  %r405 = add i32 0, 0

        mov     x12, #0
        //  %r406 = add i32 0, 0

        mov     x12, #0
        //  %r407 = add i32 0, 0

        mov     x12, #0
        //  %r408 = add i32 0, 0

        mov     x12, #0
        //  %r409 = add i32 0, 0

        mov     x12, #0
        //  %r149 = alloca [ 16 x i32 ]

        //  %r148 = alloca [ 16 x i32 ]

        //  %r147 = alloca [ 16 x i32 ]

        //  %r410 = add i32 0, 0

        mov     x12, #0
        //  %r413 = add i32 %r140, 0

        mov     x13, x11
        //  %r411 = add i32 0, 0

        mov     x11, #0
        //  %r414 = add i32 %r143, 0

        mov     x12, x10
        //  %r412 = add i32 0, 0

        mov     x10, #0
        //  %r415 = add i32 %r145, 0

        mov     x11, x9
        //  %r416 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb13


        //bb13:  %r417 = phi i32 [ %r416, %bb53 ], [ %r447, %bb14 ]

        mov     x9, x9
        b     bb13
        //bb13:

bb13:

        //  %r417 = phi i32 [ %r416, %bb53 ], [ %r447, %bb14 ]

        //  %r152 = load i32, i32* @base

        adrp     x10, base
        add     x10, x10, #:lo12:base
        ldr     x10, [x10]
        //  %r153 = icmp slt i32 %r417, %r152

        cmp     x9, x10
        //  br i1 %r153, label %bb14, label %bb15


        b.lt     bb14
        b     bb15
        //bb14:

bb14:

        //  %r155 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r417

        mov     x10, #8
        mul     x15, x9, x10
        mov     x10, #-384
        add     x10, x29, x10
        add     x15, x10, x15
        //  store i32 0, i32* %r155

        mov     x10, #0
        str     x10, [x15]
        //  %r157 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 %r417

        mov     x10, #8
        mul     x15, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x15, x10, x15
        //  store i32 0, i32* %r157

        mov     x10, #0
        str     x10, [x15]
        //  %r159 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0 , i32 %r417

        mov     x10, #8
        mul     x15, x9, x10
        mov     x10, #-128
        add     x10, x29, x10
        add     x15, x10, x15
        //  store i32 0, i32* %r159

        mov     x10, #0
        str     x10, [x15]
        //  %r447 = add i32 %r417, 1

        add     x9, x9, #1
        //  br label %bb13


        //bb13:  %r417 = phi i32 [ %r416, %bb53 ], [ %r447, %bb14 ]

        mov     x9, x9
        b     bb13
        //bb15:

bb15:

        //  %r163 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  %r164 = icmp eq i32 %r413, %r163

        cmp     x13, x9
        //  br i1 %r164, label %bb16, label %bb19


        b.eq     bb16
        b     bb19
        //bb19:

bb19:

        //  %r166 = add i32 %r414, 1

        add     x9, x12, #1
        //  %r168 = icmp sge i32 %r166, %r415

        cmp     x9, x11
        //  br i1 %r168, label %bb16, label %bb17


        b.ge     bb16
        b     bb17
        //bb16:

bb16:

        //  ret void

        mov     sp, x29
        ret
        //bb17:

bb17:

        //  %r418 = add i32 %r414, 0

        mov     x9, x12
        //  br label %bb20


        //bb20:  %r419 = phi i32 [ %r418, %bb17 ], [ %r446, %bb21 ]

        mov     x10, x9
        b     bb20
        //bb20:

bb20:

        //  %r419 = phi i32 [ %r418, %bb17 ], [ %r446, %bb21 ]

        //  %r173 = icmp slt i32 %r419, %r415

        cmp     x10, x11
        //  br i1 %r173, label %bb21, label %bb22


        b.lt     bb21
        b     bb22
        //bb21:

bb21:

        //  %r176 = getelementptr i32, i32* %r142, i32 %r419

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        //  %r177 = load i32, i32* %r176

        ldr     x9, [x9]
        //  %r444 = call i32 @getNumPos(i32 %r177, i32 %r413)

        mov     x0, x9
        mov     x1, x13
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x20, x0
        //  %r182 = getelementptr i32, i32* %r142, i32 %r419

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        //  %r183 = load i32, i32* %r182

        ldr     x9, [x9]
        //  %r445 = call i32 @getNumPos(i32 %r183, i32 %r413)

        mov     x0, x9
        mov     x1, x13
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r187 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0 , i32 %r444

        mov     x15, #8
        mul     x20, x20, x15
        mov     x15, #-128
        add     x15, x29, x15
        add     x15, x15, x20
        //  %r188 = load i32, i32* %r187

        ldr     x15, [x15]
        //  %r189 = add i32 %r188, 1

        add     x20, x15, #1
        //  %r191 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0 , i32 %r445

        mov     x15, #8
        mul     x15, x9, x15
        mov     x9, #-128
        add     x9, x29, x9
        add     x9, x9, x15
        //  store i32 %r189, i32* %r191

        str     x20, [x9]
        //  %r446 = add i32 %r419, 1

        add     x9, x10, #1
        //  br label %bb20


        //bb20:  %r419 = phi i32 [ %r418, %bb17 ], [ %r446, %bb21 ]

        mov     x10, x9
        b     bb20
        //bb22:

bb22:

        //  %r195 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-384
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r414, i32* %r195

        str     x12, [x9]
        //  %r197 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r198 = load i32, i32* %r197

        ldr     x9, [x9]
        //  %r199 = add i32 %r414, %r198

        add     x11, x12, x9
        //  %r200 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r199, i32* %r200

        str     x11, [x9]
        //  %r420 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb23


        //bb23:  %r421 = phi i32 [ %r420, %bb22 ], [ %r443, %bb24 ]

        mov     x9, x9
        b     bb23
        //bb23:

bb23:

        //  %r421 = phi i32 [ %r420, %bb22 ], [ %r443, %bb24 ]

        //  %r202 = load i32, i32* @base

        adrp     x10, base
        add     x10, x10, #:lo12:base
        ldr     x10, [x10]
        //  %r203 = icmp slt i32 %r421, %r202

        cmp     x9, x10
        //  br i1 %r203, label %bb24, label %bb25


        b.lt     bb24
        b     bb25
        //bb24:

bb24:

        //  %r442 = sub i32 %r421, 1

        sub     x11, x9, #1
        //  %r208 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 %r442

        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r209 = load i32, i32* %r208

        ldr     x15, [x10]
        //  %r211 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r421

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-384
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r209, i32* %r211

        str     x15, [x10]
        //  %r213 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r421

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-384
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r214 = load i32, i32* %r213

        ldr     x15, [x10]
        //  %r216 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0 , i32 %r421

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-128
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r217 = load i32, i32* %r216

        ldr     x10, [x10]
        //  %r218 = add i32 %r214, %r217

        add     x15, x15, x10
        //  %r220 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 %r421

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r218, i32* %r220

        str     x15, [x10]
        //  %r443 = add i32 %r421, 1

        add     x9, x9, #1
        //  br label %bb23


        //bb23:  %r421 = phi i32 [ %r420, %bb22 ], [ %r443, %bb24 ]

        mov     x9, x9
        b     bb23
        //bb25:

bb25:

        //  %r422 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb26


        //bb26:  %r423 = phi i32 [ %r422, %bb25 ], [ %r429, %bb31 ]

        mov     x11, x9
        b     bb26
        //bb26:

bb26:

        //  %r423 = phi i32 [ %r422, %bb25 ], [ %r429, %bb31 ]

        //  %r224 = load i32, i32* @base

        adrp     x9, base
        add     x9, x9, #:lo12:base
        ldr     x9, [x9]
        //  %r225 = icmp slt i32 %r423, %r224

        cmp     x11, x9
        //  br i1 %r225, label %bb27, label %bb28


        b.lt     bb27
        b     bb28
        //bb27:

bb27:

        //  br label %bb29


        b     bb29
        //bb29:

bb29:

        //  %r227 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r423

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-384
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r228 = load i32, i32* %r227

        ldr     x15, [x9]
        //  %r230 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 %r423

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r231 = load i32, i32* %r230

        ldr     x9, [x9]
        //  %r232 = icmp slt i32 %r228, %r231

        cmp     x15, x9
        //  br i1 %r232, label %bb30, label %bb31


        b.lt     bb30
        b     bb31
        //bb30:

bb30:

        //  %r235 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r423

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-384
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r430 = load i32, i32* %r235

        ldr     x10, [x9]
        //  %r239 = getelementptr i32, i32* %r142, i32 %r430

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        //  %r431 = load i32, i32* %r239

        ldr     x9, [x9]
        //  br label %bb32


        //bb32:  %r432 = phi i32 [ %r431, %bb30 ], [ %r437, %bb33 ]

        mov     x9, x9
        b     bb32
        //bb32:

bb32:

        //  %r432 = phi i32 [ %r431, %bb30 ], [ %r437, %bb33 ]

        //  %r243 = call i32 @getNumPos(i32 %r432, i32 %r413)

        mov     x0, x9
        mov     x1, x13
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r245 = icmp ne i32 %r243, %r423

        cmp     x10, x11
        //  br i1 %r245, label %bb33, label %bb34


        b.ne     bb33
        b     bb34
        //bb33:

bb33:

        //  %r434 = add i32 %r432, 0

        mov     x9, x9
        //  %r435 = call i32 @getNumPos(i32 %r434, i32 %r413)

        mov     x0, x9
        mov     x1, x13
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x15, x0
        //  %r253 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r435

        mov     x10, #8
        mul     x15, x15, x10
        mov     x10, #-384
        add     x10, x29, x10
        add     x10, x10, x15
        //  %r436 = load i32, i32* %r253

        ldr     x15, [x10]
        //  %r256 = getelementptr i32, i32* %r142, i32 %r436

        mov     x10, #8
        mul     x10, x15, x10
        add     x10, x14, x10
        //  %r437 = load i32, i32* %r256

        ldr     x10, [x10]
        //  %r438 = call i32 @getNumPos(i32 %r434, i32 %r413)

        mov     x0, x9
        mov     x1, x13
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x20, x0
        //  %r262 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r438

        mov     x15, #8
        mul     x20, x20, x15
        mov     x15, #-384
        add     x15, x29, x15
        add     x15, x15, x20
        //  %r439 = load i32, i32* %r262

        ldr     x20, [x15]
        //  %r266 = getelementptr i32, i32* %r142, i32 %r439

        mov     x15, #8
        mul     x15, x20, x15
        add     x15, x14, x15
        //  store i32 %r434, i32* %r266

        str     x9, [x15]
        //  %r440 = call i32 @getNumPos(i32 %r434, i32 %r413)

        mov     x0, x9
        mov     x1, x13
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x20, x0
        //  %r441 = call i32 @getNumPos(i32 %r434, i32 %r413)

        mov     x0, x9
        mov     x1, x13
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getNumPos
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r275 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r440

        mov     x15, #8
        mul     x20, x20, x15
        mov     x15, #-384
        add     x15, x29, x15
        add     x15, x15, x20
        //  %r276 = load i32, i32* %r275

        ldr     x15, [x15]
        //  %r277 = add i32 %r276, 1

        add     x20, x15, #1
        //  %r279 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r441

        mov     x15, #8
        mul     x15, x9, x15
        mov     x9, #-384
        add     x9, x29, x9
        add     x9, x9, x15
        //  store i32 %r277, i32* %r279

        str     x20, [x9]
        //  br label %bb32


        //bb32:  %r432 = phi i32 [ %r431, %bb30 ], [ %r437, %bb33 ]

        mov     x9, x10
        b     bb32
        //bb34:

bb34:

        //  %r282 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r423

        mov     x10, #8
        mul     x15, x11, x10
        mov     x10, #-384
        add     x10, x29, x10
        add     x10, x10, x15
        //  %r433 = load i32, i32* %r282

        ldr     x15, [x10]
        //  %r286 = getelementptr i32, i32* %r142, i32 %r433

        mov     x10, #8
        mul     x10, x15, x10
        add     x10, x14, x10
        //  store i32 %r432, i32* %r286

        str     x9, [x10]
        //  %r288 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r423

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-384
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r289 = load i32, i32* %r288

        ldr     x9, [x9]
        //  %r290 = add i32 %r289, 1

        add     x15, x9, #1
        //  %r292 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r423

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-384
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r290, i32* %r292

        str     x15, [x9]
        //  br label %bb29


        b     bb29
        //bb31:

bb31:

        //  %r429 = add i32 %r423, 1

        add     x9, x11, #1
        //  br label %bb26


        //bb26:  %r423 = phi i32 [ %r422, %bb25 ], [ %r429, %bb31 ]

        mov     x11, x9
        b     bb26
        //bb28:

bb28:

        //  %r424 = add i32 %r414, 0

        //  %r297 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-384
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r414, i32* %r297

        str     x12, [x9]
        //  %r299 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r300 = load i32, i32* %r299

        ldr     x9, [x9]
        //  %r301 = add i32 %r414, %r300

        add     x11, x12, x9
        //  %r302 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r301, i32* %r302

        str     x11, [x9]
        //  %r425 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb35


        //bb35:  %r426 = phi i32 [ %r425, %bb28 ], [ %r427, %bb40 ]

        mov     x9, x9
        b     bb35
        //bb35:

bb35:

        //  %r426 = phi i32 [ %r425, %bb28 ], [ %r427, %bb40 ]

        //  %r304 = load i32, i32* @base

        adrp     x10, base
        add     x10, x10, #:lo12:base
        ldr     x10, [x10]
        //  %r305 = icmp slt i32 %r426, %r304

        cmp     x9, x10
        //  br i1 %r305, label %bb36, label %bb37


        b.lt     bb36
        b     bb37
        //bb36:

bb36:

        //  %r307 = icmp sgt i32 %r426, 0

        mov     x10, #0
        cmp     x9, x10
        //  br i1 %r307, label %bb38, label %bb39


        b.gt     bb38
        b     bb39
        //bb38:

bb38:

        //  %r428 = sub i32 %r426, 1

        sub     x11, x9, #1
        //  %r312 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 %r428

        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r313 = load i32, i32* %r312

        ldr     x12, [x10]
        //  %r315 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r426

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-384
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r313, i32* %r315

        str     x12, [x10]
        //  %r317 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r426

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-384
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r318 = load i32, i32* %r317

        ldr     x12, [x10]
        //  %r320 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0 , i32 %r426

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-128
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r321 = load i32, i32* %r320

        ldr     x10, [x10]
        //  %r322 = add i32 %r318, %r321

        add     x12, x12, x10
        //  %r324 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 %r426

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r322, i32* %r324

        str     x12, [x10]
        //  br label %bb40


        b     bb40
        //bb39:

bb39:

        //  br label %bb40


        b     bb40
        //bb40:

bb40:

        //  %r326 = sub i32 %r413, 1

        sub     x10, x13, #1
        //  %r328 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0 , i32 %r426

        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-384
        add     x11, x29, x11
        add     x11, x11, x12
        //  %r329 = load i32, i32* %r328

        ldr     x15, [x11]
        //  %r331 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0 , i32 %r426

        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-256
        add     x11, x29, x11
        add     x11, x11, x12
        //  %r332 = load i32, i32* %r331

        ldr     x11, [x11]
        //  call void @radixSort(i32 %r326, i32* %r142, i32 %r329, i32 %r332)

        mov     x0, x10
        mov     x1, x14
        mov     x2, x15
        mov     x3, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     radixSort
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r427 = add i32 %r426, 1

        add     x9, x9, #1
        //  br label %bb35


        //bb35:  %r426 = phi i32 [ %r425, %bb28 ], [ %r427, %bb40 ]

        mov     x9, x9
        b     bb35
        //bb37:

bb37:

        //  ret void

        mov     sp, x29
        ret
        //%r683->x9
        //%r682->x9
        //%r681->x9
        //%r680->x9
        //%r679->x9
        //%r678->x9
        //%r677->x9
        //%r676->x11
        //%r675->x13
        //%r674->x13
        //%r673->x13
        //%r672->x14
        //%r671->x13
        //%r670->x11
        //%r666->x9
        //%r664->x9
        //%r663->x9
        //%r657->x9
        //%r661->x9
        //%r366->x11
        //%r453->x12
        //%r660->x9
        //%r365->x11
        //%r452->x9
        //%r658->x9
        //%r363->x13
        //%r450->x9
        //%r656->x9
        //%r361->x14
        //%r684->x9
        //%r448->x9
        //%r655->x9
        //%r360->x13
        //%r358->x14
        //%r357->x13
        //%r355->x11
        //%r659->x11
        //%r364->x13
        //%r451->x10
        //%r654->x9
        //%r351->x12
        //%r343->x9
        //%r667->x11
        //%r372->x10
        //%r354->x11
        //%r341->x13
        //%r665->x9
        //%r370->x10
        //%r457->x9
        //%r662->x9
        //%r367->x12
        //%r454->x9
        //%r668->x11
        //%r373->x10
        //%r669->x13
        //%r374->x9
        //%r449->x9
        //%r455->x9
        //%r456->x9
        //%r685->x9
main:

        //bb41:

bb41:

        //  %r448 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r449 = add i32 0, 0

        mov     x9, #0
        //  %r451 = call i32 @getint()

        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r450 = add i32 0, 0

        mov     x9, #0
        //  %r452 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb42


        //bb42:  %r453 = phi i32 [ %r452, %bb41 ], [ %r457, %bb43 ]

        mov     x12, x9
        b     bb42
        //bb42:

bb42:

        //  %r453 = phi i32 [ %r452, %bb41 ], [ %r457, %bb43 ]

        //  %r340 = icmp slt i32 %r453, %r451

        cmp     x12, x10
        //  br i1 %r340, label %bb43, label %bb44


        b.lt     bb43
        b     bb44
        //bb43:

bb43:

        //  %r341 = call i32 @getint()

        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x13, x0
        //  %r343 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r453

        mov     x9, #8
        mul     x11, x12, x9
        adrp     x9, a
        add     x9, x9, #:lo12:a
        add     x9, x9, x11
        //  store i32 %r341, i32* %r343

        str     x13, [x9]
        //  %r457 = add i32 %r453, 1

        add     x9, x12, #1
        //  br label %bb42


        //bb42:  %r453 = phi i32 [ %r452, %bb41 ], [ %r457, %bb43 ]

        mov     x12, x9
        b     bb42
        //bb44:

bb44:

        //  call void @_sysy_starttime(i32 97)

        mov     x9, #97
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @radixSort(i32 8, i32* @a, i32 0, i32 %r451)

        mov     x9, #8
        mov     x0, x9
        adrp     x9, a
        add     x9, x9, #:lo12:a
        mov     x1, x9
        mov     x9, #0
        mov     x2, x9
        mov     x3, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     radixSort
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r454 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb45


        //bb45:  %r455 = phi i32 [ %r454, %bb44 ], [ %r456, %bb46 ]

        mov     x9, x9
        b     bb45
        //bb45:

bb45:

        //  %r455 = phi i32 [ %r454, %bb44 ], [ %r456, %bb46 ]

        //  %r350 = icmp slt i32 %r455, %r451

        cmp     x9, x10
        //  br i1 %r350, label %bb46, label %bb47


        b.lt     bb46
        b     bb47
        //bb46:

bb46:

        //  %r351 = load i32, i32* @ans

        adrp     x11, ans
        add     x11, x11, #:lo12:ans
        ldr     x12, [x11]
        //  %r354 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r455

        mov     x11, #8
        mul     x13, x9, x11
        adrp     x11, a
        add     x11, x11, #:lo12:a
        add     x11, x11, x13
        //  %r355 = load i32, i32* %r354

        ldr     x11, [x11]
        //  %r357 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r455

        mov     x13, #8
        mul     x14, x9, x13
        adrp     x13, a
        add     x13, x13, #:lo12:a
        add     x13, x13, x14
        //  %r358 = load i32, i32* %r357

        ldr     x14, [x13]
        //  %r360 = add i32 2, %r455

        mov     x13, #2
        add     x13, x13, x9
        //  %r361 = sdiv i32 %r358, %r360

        sdiv     x14, x14, x13
        //  %r363 = add i32 2, %r455

        mov     x13, #2
        add     x13, x13, x9
        //  %r364 = mul i32 %r361, %r363

        mul     x13, x14, x13
        //  %r365 = sub i32 %r355, %r364

        sub     x11, x11, x13
        //  %r366 = mul i32 %r455, %r365

        mul     x11, x9, x11
        //  %r367 = add i32 %r351, %r366

        add     x12, x12, x11
        //  store i32 %r367, i32* @ans

        adrp     x11, ans
        add     x11, x11, #:lo12:ans
        str     x12, [x11]
        //  %r456 = add i32 %r455, 1

        add     x9, x9, #1
        //  br label %bb45


        //bb45:  %r455 = phi i32 [ %r454, %bb44 ], [ %r456, %bb46 ]

        mov     x9, x9
        b     bb45
        //bb47:

bb47:

        //  %r370 = load i32, i32* @ans

        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        ldr     x10, [x9]
        //  %r371 = icmp slt i32 %r370, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r371, label %bb48, label %bb49


        b.lt     bb48
        b     bb49
        //bb48:

bb48:

        //  %r373 = load i32, i32* @ans

        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        ldr     x10, [x9]
        //  %r372 = sub i32 0, %r373

        mov     x9, #0
        sub     x10, x9, x10
        //  store i32 %r372, i32* @ans

        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        str     x10, [x9]
        //  br label %bb50


        b     bb50
        //bb49:

bb49:

        //  br label %bb50


        b     bb50
        //bb50:

bb50:

        //  call void @_sysy_stoptime(i32 117)

        mov     x9, #117
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r374 = load i32, i32* @ans

        adrp     x9, ans
        add     x9, x9, #:lo12:ans
        ldr     x9, [x9]
        //  call void @putint(i32 %r374)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 10)

        mov     x9, #10
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
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
