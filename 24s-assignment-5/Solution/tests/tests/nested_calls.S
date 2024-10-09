.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global func1
.global func2
.global func3
.global func4
.global func5
.global func6
.global func7
.global main
        //%r276->x11
        //%r102->x12
        //%r275->x12
        //%r313->x9
        //%r110->x9
        //%r274->x9
        //%r100->x11
        //%r272->x9
        //%r114->x10
        //%r317->x9
        //%r273->x9
        //%r104->x10
        //%r271->x9
        //%r115->x9
        //%r314->x11
        //%r315->x11
        //%r316->x10
func1:

        //bb31:

bb31:

        //  %r271 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x12, x1
        mov     x10, x2
        mov     x9, #0
        //  %r274 = add i32 %r100, 0

        mov     x9, x11
        //  %r272 = add i32 0, 0

        mov     x11, #0
        //  %r275 = add i32 %r102, 0

        mov     x12, x12
        //  %r273 = add i32 0, 0

        mov     x11, #0
        //  %r276 = add i32 %r104, 0

        mov     x11, x10
        //  %r107 = icmp eq i32 %r276, 0

        mov     x10, #0
        cmp     x11, x10
        //  br i1 %r107, label %bb2, label %bb3


        b.eq     bb2
        b     bb3
        //bb2:

bb2:

        //  %r110 = mul i32 %r274, %r275

        mul     x9, x9, x12
        //  ret i32 %r110

        mov     x0, x9
        mov     sp, x29
        ret
        //bb3:

bb3:

        //  %r114 = sub i32 %r275, %r276

        sub     x10, x12, x11
        //  %r115 = call i32 @func1(i32 %r274, i32 %r114, i32 0)

        mov     x0, x9
        mov     x1, x10
        mov     x9, #0
        mov     x2, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func1
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  ret i32 %r115

        mov     x0, x9
        mov     sp, x29
        ret
        //%r319->x9
        //%r116->x11
        //%r280->x10
        //%r318->x9
        //%r279->x11
        //%r278->x9
        //%r277->x9
        //%r128->x9
        //%r127->x9
        //%r320->x9
        //%r125->x9
        //%r118->x10
        //%r321->x9
        //%r129->x9
func2:

        //bb34:

bb34:

        //  %r277 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        //  %r279 = add i32 %r116, 0

        mov     x11, x11
        //  %r278 = add i32 0, 0

        mov     x9, #0
        //  %r280 = add i32 %r118, 0

        mov     x10, x10
        //  %r121 = icmp ne i32 %r280, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r121, label %bb6, label %bb7


        b.ne     bb6
        b     bb7
        //bb6:

bb6:

        //  %r125 = sdiv i32 %r279, %r280

        sdiv     x9, x11, x10
        //  %r127 = mul i32 %r125, %r280

        mul     x9, x9, x10
        //  %r128 = sub i32 %r279, %r127

        sub     x9, x11, x9
        //  %r129 = call i32 @func2(i32 %r128, i32 0)

        mov     x0, x9
        mov     x9, #0
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  ret i32 %r129

        mov     x0, x9
        mov     sp, x29
        ret
        //bb7:

bb7:

        //  ret i32 %r279

        mov     x0, x11
        mov     sp, x29
        ret
        //%r131->x11
        //%r133->x10
        //%r138->x9
        //%r281->x9
        //%r141->x9
        //%r284->x10
        //%r323->x9
        //%r142->x9
        //%r324->x9
        //%r282->x9
        //%r283->x11
        //%r322->x9
        //%r325->x9
func3:

        //bb37:

bb37:

        //  %r281 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        //  %r283 = add i32 %r131, 0

        mov     x11, x11
        //  %r282 = add i32 0, 0

        mov     x9, #0
        //  %r284 = add i32 %r133, 0

        mov     x10, x10
        //  %r136 = icmp eq i32 %r284, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r136, label %bb10, label %bb11


        b.eq     bb10
        b     bb11
        //bb10:

bb10:

        //  %r138 = add i32 %r283, 1

        add     x9, x11, #1
        //  ret i32 %r138

        mov     x0, x9
        mov     sp, x29
        ret
        //bb11:

bb11:

        //  %r141 = add i32 %r283, %r284

        add     x9, x11, x10
        //  %r142 = call i32 @func3(i32 %r141, i32 0)

        mov     x0, x9
        mov     x9, #0
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  ret i32 %r142

        mov     x0, x9
        mov     sp, x29
        ret
        //%r143->x11
        //%r286->x9
        //%r145->x12
        //%r288->x9
        //%r327->x11
        //%r147->x10
        //%r290->x11
        //%r329->x10
        //%r285->x9
        //%r287->x9
        //%r326->x9
        //%r289->x12
        //%r328->x11
func4:

        //bb40:

bb40:

        //  %r285 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x12, x1
        mov     x10, x2
        mov     x9, #0
        //  %r288 = add i32 %r143, 0

        mov     x9, x11
        //  %r286 = add i32 0, 0

        mov     x11, #0
        //  %r289 = add i32 %r145, 0

        mov     x12, x12
        //  %r287 = add i32 0, 0

        mov     x11, #0
        //  %r290 = add i32 %r147, 0

        mov     x11, x10
        //  %r150 = icmp ne i32 %r288, 0

        mov     x10, #0
        cmp     x9, x10
        //  br i1 %r150, label %bb14, label %bb15


        b.ne     bb14
        b     bb15
        //bb14:

bb14:

        //  ret i32 %r289

        mov     x0, x12
        mov     sp, x29
        ret
        //bb15:

bb15:

        //  ret i32 %r290

        mov     x0, x11
        mov     sp, x29
        ret
        //%r153->x10
        //%r155->x9
        //%r291->x9
        //%r330->x9
        //%r292->x10
        //%r331->x9
func5:

        //bb43:

bb43:

        //  %r291 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r292 = add i32 %r153, 0

        mov     x10, x10
        //  %r155 = sub i32 0, %r292

        mov     x9, #0
        sub     x9, x9, x10
        //  ret i32 %r155

        mov     x0, x9
        mov     sp, x29
        ret
        //%r157->x11
        //%r159->x10
        //%r293->x9
        //%r332->x9
        //%r294->x9
        //%r333->x9
        //%r295->x11
        //%r334->x9
        //%r296->x10
        //%r335->x9
        //%r336->x9
        //%r337->x9
func6:

        //bb44:

bb44:

        //  %r293 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        //  %r295 = add i32 %r157, 0

        mov     x11, x11
        //  %r294 = add i32 0, 0

        mov     x9, #0
        //  %r296 = add i32 %r159, 0

        mov     x10, x10
        //  %r162 = icmp ne i32 %r295, 0

        mov     x9, #0
        cmp     x11, x9
        //  br i1 %r162, label %bb22, label %bb20


        b.ne     bb22
        b     bb20
        //bb22:

bb22:

        //  %r164 = icmp ne i32 %r296, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r164, label %bb19, label %bb20


        b.ne     bb19
        b     bb20
        //bb19:

bb19:

        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //bb20:

bb20:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r165->x10
        //%r297->x9
        //%r298->x10
        //%r338->x9
        //%r339->x9
        //%r340->x9
        //%r341->x9
func7:

        //bb47:

bb47:

        //  %r297 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r298 = add i32 %r165, 0

        mov     x10, x10
        //  %r168 = icmp ne i32 %r298, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r168, label %bb25, label %bb24


        b.ne     bb25
        b     bb24
        //bb24:

bb24:

        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //bb25:

bb25:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r360->x10
        //%r358->x10
        //%r357->x9
        //%r354->x9
        //%r312->x9
        //%r311->x10
        //%r309->x9
        //%r307->x13
        //%r306->x14
        //%r305->x15
        //%r304->x9
        //%r303->x9
        //%r302->x9
        //%r301->x9
        //%r300->x9
        //%r299->x9
        //%r268->x9
        //%r266->x9
        //%r265->x10
        //%r264->x10
        //%r263->x10
        //%r262->x9
        //%r261->x9
        //%r260->x9
        //%r259->x9
        //%r258->x10
        //%r257->x9
        //%r256->x11
        //%r255->x10
        //%r254->x10
        //%r253->x10
        //%r379->x9
        //%r252->x9
        //%r343->x9
        //%r216->x9
        //%r342->x9
        //%r215->x9
        //%r214->x11
        //%r213->x9
        //%r211->x9
        //%r209->x11
        //%r208->x9
        //%r207->[sp,#32]
        //%r206->x9
        //%r205->x9
        //%r204->x9
        //%r203->x11
        //%r202->x9
        //%r210->x9
        //%r308->x12
        //%r181->[sp,#0]
        //%r438->x10
        //%r367->x10
        //%r240->x11
        //%r212->x9
        //%r310->x11
        //%r183->x9
        //%r440->x10
        //%r369->x9
        //%r242->x10
        //%r196->[sp,#8]
        //%r453->x10
        //%r344->x9
        //%r217->x11
        //%r188->x10
        //%r445->x14
        //%r374->x9
        //%r247->x9
        //%r201->[sp,#24]
        //%r190->x9
        //%r447->x9
        //%r376->x9
        //%r249->x10
        //%r191->x9
        //%r448->x14
        //%r377->x10
        //%r250->x10
        //%r193->x9
        //%r450->x11
        //%r195->x9
        //%r452->x11
        //%r197->x9
        //%r454->x10
        //%r198->[sp,#16]
        //%r455->x9
        //%r199->x9
        //%r200->x9
        //%r345->x9
        //%r218->x9
        //%r346->x9
        //%r219->x9
        //%r347->x9
        //%r220->[sp,#40]
        //%r348->x9
        //%r221->x9
        //%r349->x9
        //%r222->x11
        //%r350->x9
        //%r223->x9
        //%r351->x9
        //%r224->x9
        //%r352->x10
        //%r225->x9
        //%r353->x9
        //%r226->x9
        //%r355->x10
        //%r228->x9
        //%r356->x9
        //%r229->x9
        //%r359->x10
        //%r232->x10
        //%r361->x9
        //%r234->x10
        //%r362->x10
        //%r235->x10
        //%r363->x9
        //%r236->x10
        //%r364->x9
        //%r237->x9
        //%r365->x10
        //%r238->x9
        //%r366->x9
        //%r239->x11
        //%r368->x9
        //%r241->x9
        //%r370->x10
        //%r243->x10
        //%r371->x9
        //%r244->x13
        //%r372->x10
        //%r245->x9
        //%r373->x9
        //%r246->x12
        //%r375->x10
        //%r248->x9
        //%r378->x9
        //%r251->x10
        //%r380->x10
        //%r381->x9
        //%r382->x10
        //%r383->x9
        //%r384->x9
        //%r385->x10
        //%r386->x9
        //%r387->x10
        //%r388->x9
        //%r389->x9
        //%r390->x10
        //%r391->x9
        //%r392->x10
        //%r393->x9
        //%r394->x9
        //%r395->x10
        //%r396->x9
        //%r397->x10
        //%r398->x9
        //%r399->x9
        //%r400->x10
        //%r401->x9
        //%r402->x10
        //%r403->x9
        //%r404->x9
        //%r405->x11
        //%r406->x9
        //%r407->x11
        //%r408->x9
        //%r409->x9
        //%r410->x12
        //%r411->x11
        //%r412->x12
        //%r413->x11
        //%r414->x11
        //%r415->x11
        //%r416->x10
        //%r417->x11
        //%r418->x10
        //%r419->x10
        //%r420->x10
        //%r421->x9
        //%r422->x10
        //%r423->x9
        //%r424->x9
        //%r425->x10
        //%r426->x9
        //%r427->x10
        //%r428->x9
        //%r429->x9
        //%r430->x11
        //%r431->x10
        //%r432->x11
        //%r433->x10
        //%r434->x10
        //%r435->x11
        //%r436->x10
        //%r437->x11
        //%r439->x10
        //%r441->x9
        //%r442->x10
        //%r443->x9
        //%r444->x9
        //%r446->x9
        //%r449->x14
        //%r451->x10
main:

        //177:x29,#-80

        //bb27:

bb27:

        //  %r299 = add i32 0, 0

        mov     x16, #128
        sub     sp, sp, x16
        mov     x9, #0
        //  call void @_sysy_starttime(i32 97)

        mov     x9, #97
        mov     x0, x9
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
        //  %r300 = add i32 0, 0

        mov     x9, #0
        //  %r305 = call i32 @getint()

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
        mov     x15, x0
        //  %r301 = add i32 0, 0

        mov     x9, #0
        //  %r306 = call i32 @getint()

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
        mov     x14, x0
        //  %r302 = add i32 0, 0

        mov     x9, #0
        //  %r307 = call i32 @getint()

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
        mov     x13, x0
        //  %r303 = add i32 0, 0

        mov     x9, #0
        //  %r308 = call i32 @getint()

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
        mov     x12, x0
        //  %r177 = alloca [ 10 x i32 ]

        //  %r304 = add i32 0, 0

        mov     x9, #0
        //  %r309 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb28


        //bb28:  %r310 = phi i32 [ %r309, %bb27 ], [ %r312, %bb29 ]

        mov     x11, x9
        b     bb28
        //bb28:

bb28:

        //  %r310 = phi i32 [ %r309, %bb27 ], [ %r312, %bb29 ]

        //  %r180 = icmp slt i32 %r310, 10

        mov     x9, #10
        cmp     x11, x9
        //  br i1 %r180, label %bb29, label %bb30


        b.lt     bb29
        b     bb30
        //bb29:

bb29:

        //  %r181 = call i32 @getint()

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
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        //  %r183 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 %r310

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r181, i32* %r183

        mov     x16, #0
        ldr     x19, [sp,x16]
        str     x19, [x9]
        //  %r312 = add i32 %r310, 1

        add     x9, x11, #1
        //  br label %bb28


        //bb28:  %r310 = phi i32 [ %r309, %bb27 ], [ %r312, %bb29 ]

        mov     x11, x9
        b     bb28
        //bb30:

bb30:

        //  %r188 = call i32 @func7(i32 %r305)

        mov     x0, x15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func7
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r190 = call i32 @func5(i32 %r306)

        mov     x0, x14
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func5
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r191 = call i32 @func6(i32 %r188, i32 %r190)

        mov     x0, x10
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func6
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r193 = call i32 @func2(i32 %r191, i32 %r307)

        mov     x0, x9
        mov     x1, x13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r195 = call i32 @func3(i32 %r193, i32 %r308)

        mov     x0, x9
        mov     x1, x12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r196 = call i32 @func5(i32 %r195)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func5
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x16, x0
        mov     x17, #8
        str     x16, [sp,x17]
        //  %r197 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x10, #-80
        add     x10, x29, x10
        add     x9, x10, x9
        //  %r198 = load i32, i32* %r197

        ldr     x16, [x9]
        mov     x17, #16
        str     x16, [sp,x17]
        //  %r199 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r200 = load i32, i32* %r199

        ldr     x9, [x9]
        //  %r201 = call i32 @func5(i32 %r200)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func5
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x16, x0
        mov     x17, #24
        str     x16, [sp,x17]
        //  %r202 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r203 = load i32, i32* %r202

        ldr     x11, [x9]
        //  %r204 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r205 = load i32, i32* %r204

        ldr     x9, [x9]
        //  %r206 = call i32 @func7(i32 %r205)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func7
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r207 = call i32 @func6(i32 %r203, i32 %r206)

        mov     x0, x11
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func6
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x16, x0
        mov     x17, #32
        str     x16, [sp,x17]
        //  %r208 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r209 = load i32, i32* %r208

        ldr     x11, [x9]
        //  %r210 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 5

        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r211 = load i32, i32* %r210

        ldr     x9, [x9]
        //  %r212 = call i32 @func7(i32 %r211)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func7
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r213 = call i32 @func2(i32 %r209, i32 %r212)

        mov     x0, x11
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r214 = call i32 @func4(i32 %r201, i32 %r207, i32 %r213)

        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     x1, x19
        mov     x2, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func4
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r215 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 6

        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r216 = load i32, i32* %r215

        ldr     x9, [x9]
        //  %r217 = call i32 @func3(i32 %r214, i32 %r216)

        mov     x0, x11
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r218 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r219 = load i32, i32* %r218

        ldr     x9, [x9]
        //  %r220 = call i32 @func2(i32 %r217, i32 %r219)

        mov     x0, x11
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x16, x0
        mov     x17, #40
        str     x16, [sp,x17]
        //  %r221 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 8

        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r222 = load i32, i32* %r221

        ldr     x11, [x9]
        //  %r223 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 9

        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r224 = load i32, i32* %r223

        ldr     x9, [x9]
        //  %r225 = call i32 @func7(i32 %r224)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func7
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r226 = call i32 @func3(i32 %r222, i32 %r225)

        mov     x0, x11
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r228 = call i32 @func1(i32 %r220, i32 %r226, i32 %r305)

        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x1, x9
        mov     x2, x15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func1
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r229 = call i32 @func4(i32 %r196, i32 %r198, i32 %r228)

        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     x1, x19
        mov     x2, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func4
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r232 = call i32 @func7(i32 %r307)

        mov     x0, x13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func7
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r234 = call i32 @func3(i32 %r232, i32 %r308)

        mov     x0, x10
        mov     x1, x12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r235 = call i32 @func2(i32 %r306, i32 %r234)

        mov     x0, x14
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r236 = call i32 @func3(i32 %r229, i32 %r235)

        mov     x0, x9
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r237 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 0

        mov     x11, #0
        mov     x9, #8
        mul     x11, x11, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x11
        //  %r238 = load i32, i32* %r237

        ldr     x9, [x9]
        //  %r239 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 1

        mov     x12, #1
        mov     x11, #8
        mul     x12, x12, x11
        mov     x11, #-80
        add     x11, x29, x11
        add     x11, x11, x12
        //  %r240 = load i32, i32* %r239

        ldr     x11, [x11]
        //  %r241 = call i32 @func1(i32 %r236, i32 %r238, i32 %r240)

        mov     x0, x10
        mov     x1, x9
        mov     x2, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func1
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r242 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 2

        mov     x11, #2
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r243 = load i32, i32* %r242

        ldr     x10, [x10]
        //  %r244 = call i32 @func2(i32 %r241, i32 %r243)

        mov     x0, x9
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x13, x0
        //  %r245 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r246 = load i32, i32* %r245

        ldr     x12, [x9]
        //  %r247 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r248 = load i32, i32* %r247

        ldr     x9, [x9]
        //  %r249 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 5

        mov     x11, #5
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r250 = load i32, i32* %r249

        ldr     x10, [x10]
        //  %r251 = call i32 @func5(i32 %r250)

        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func5
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r252 = call i32 @func3(i32 %r248, i32 %r251)

        mov     x0, x9
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r253 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 6

        mov     x11, #6
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r254 = load i32, i32* %r253

        ldr     x10, [x10]
        //  %r255 = call i32 @func5(i32 %r254)

        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func5
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r256 = call i32 @func2(i32 %r252, i32 %r255)

        mov     x0, x9
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r257 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r258 = load i32, i32* %r257

        ldr     x10, [x9]
        //  %r259 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 8

        mov     x14, #8
        mov     x9, #8
        mul     x9, x14, x9
        mov     x14, #-80
        add     x14, x29, x14
        add     x9, x14, x9
        //  %r260 = load i32, i32* %r259

        ldr     x9, [x9]
        //  %r261 = call i32 @func7(i32 %r260)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func7
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r262 = call i32 @func1(i32 %r256, i32 %r258, i32 %r261)

        mov     x0, x11
        mov     x1, x10
        mov     x2, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func1
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r263 = getelementptr [10 x i32 ], [10 x i32 ]* %r177, i32 0 , i32 9

        mov     x11, #9
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r264 = load i32, i32* %r263

        ldr     x10, [x10]
        //  %r265 = call i32 @func5(i32 %r264)

        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func5
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r266 = call i32 @func2(i32 %r262, i32 %r265)

        mov     x0, x9
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func2
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r268 = call i32 @func3(i32 %r266, i32 %r305)

        mov     x0, x9
        mov     x1, x15
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func3
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r311 = call i32 @func1(i32 %r244, i32 %r246, i32 %r268)

        mov     x0, x13
        mov     x1, x12
        mov     x2, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     func1
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  call void @_sysy_stoptime(i32 117)

        mov     x9, #117
        mov     x0, x9
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
        //  ret i32 %r311

        mov     x0, x10
        mov     sp, x29
        ret
