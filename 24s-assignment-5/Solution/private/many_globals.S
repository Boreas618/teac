.section .data
.global    a0
.global    a1
.global    a2
.global    a3
.global    a4
.global    a5
.global    a6
.global    a7
.global    a8
.global    a9
.global    a10
.global    a11
.global    a12
.global    a13
.global    a14
.global    a15
.global    a16
.global    a17
.global    a18
.global    a19
.global    a20
.global    a21
.global    a22
.global    a23
.global    a24
.global    a25
.global    a26
.global    a27
.global    a28
.global    a29
.global    a30
.global    a31
.global    a32
.global    a33
.global    a34
.global    a35
.global    a36
.global    a37
.global    a38
.global    a39
a0:
        .quad   0
a1:
        .quad   0
a2:
        .quad   0
a3:
        .quad   0
a4:
        .quad   0
a5:
        .quad   0
a6:
        .quad   0
a7:
        .quad   0
a8:
        .quad   0
a9:
        .quad   0
a10:
        .quad   0
a11:
        .quad   0
a12:
        .quad   0
a13:
        .quad   0
a14:
        .quad   0
a15:
        .quad   0
a16:
        .quad   0
a17:
        .quad   0
a18:
        .quad   0
a19:
        .quad   0
a20:
        .quad   0
a21:
        .quad   0
a22:
        .quad   0
a23:
        .quad   0
a24:
        .quad   0
a25:
        .quad   0
a26:
        .quad   0
a27:
        .quad   0
a28:
        .quad   0
a29:
        .quad   0
a30:
        .quad   0
a31:
        .quad   0
a32:
        .quad   0
a33:
        .quad   0
a34:
        .quad   0
a35:
        .quad   0
a36:
        .quad   0
a37:
        .quad   0
a38:
        .quad   0
a39:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global testParam8
.global testParam16
.global testParam32
.global main
        //%r395->x11
        //%r100->x15
        //%r393->x13
        //%r388->x9
        //%r386->x9
        //%r384->x9
        //%r502->x21
        //%r391->x15
        //%r130->x9
        //%r389->x9
        //%r128->x9
        //%r390->x9
        //%r387->x9
        //%r126->x10
        //%r392->x14
        //%r102->x14
        //%r397->x9
        //%r394->x12
        //%r104->x21
        //%r396->x10
        //%r106->x12
        //%r108->x11
        //%r110->x10
        //%r112->x9
        //%r114->x20
        //%r118->x14
        //%r120->x13
        //%r383->x9
        //%r501->x21
        //%r122->x12
        //%r385->x9
        //%r124->x11
        //%r398->x20
        //%r495->x13
        //%r496->x13
        //%r497->x13
        //%r498->x21
        //%r499->x21
        //%r500->x21
testParam8:

        //bb5:

bb5:

        //  %r383 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x15, x0
        mov     x14, x1
        mov     x21, x2
        mov     x12, x3
        mov     x11, x4
        mov     x10, x5
        mov     x9, x6
        mov     x20, x7
        mov     x13, #0
        //  %r391 = add i32 %r100, 0

        mov     x15, x15
        //  %r384 = add i32 0, 0

        mov     x13, #0
        //  %r392 = add i32 %r102, 0

        mov     x14, x14
        //  %r385 = add i32 0, 0

        mov     x13, #0
        //  %r393 = add i32 %r104, 0

        mov     x13, x21
        //  %r386 = add i32 0, 0

        mov     x21, #0
        //  %r394 = add i32 %r106, 0

        mov     x12, x12
        //  %r387 = add i32 0, 0

        mov     x21, #0
        //  %r395 = add i32 %r108, 0

        mov     x11, x11
        //  %r388 = add i32 0, 0

        mov     x21, #0
        //  %r396 = add i32 %r110, 0

        mov     x10, x10
        //  %r389 = add i32 0, 0

        mov     x21, #0
        //  %r397 = add i32 %r112, 0

        mov     x9, x9
        //  %r390 = add i32 0, 0

        mov     x21, #0
        //  %r398 = add i32 %r114, 0

        mov     x20, x20
        //  %r118 = add i32 %r391, %r392

        add     x14, x15, x14
        //  %r120 = add i32 %r118, %r393

        add     x13, x14, x13
        //  %r122 = add i32 %r120, %r394

        add     x12, x13, x12
        //  %r124 = add i32 %r122, %r395

        add     x11, x12, x11
        //  %r126 = add i32 %r124, %r396

        add     x10, x11, x10
        //  %r128 = add i32 %r126, %r397

        add     x9, x10, x9
        //  %r130 = add i32 %r128, %r398

        add     x9, x9, x20
        //  ret i32 %r130

        mov     x0, x9
        mov     sp, x29
        ret
        //%r424->x15
        //%r422->x21
        //%r420->x23
        //%r418->x25
        //%r416->[sp,#40]
        //%r414->x9
        //%r412->x9
        //%r410->x9
        //%r408->x9
        //%r406->x9
        //%r404->x9
        //%r402->x9
        //%r400->x9
        //%r399->x9
        //%r145->x21
        //%r526->x9
        //%r193->x9
        //%r191->x10
        //%r155->x12
        //%r409->x9
        //%r153->x13
        //%r407->x9
        //%r151->x14
        //%r405->x9
        //%r149->x15
        //%r403->x9
        //%r147->x20
        //%r401->x9
        //%r143->x22
        //%r524->x9
        //%r141->x23
        //%r522->x9
        //%r139->x24
        //%r520->x9
        //%r137->x25
        //%r518->x9
        //%r135->x26
        //%r516->x9
        //%r133->[sp,#8]
        //%r514->x9
        //%r426->x13
        //%r131->[sp,#0]
        //%r512->x9
        //%r425->x14
        //%r171->x24
        //%r189->x11
        //%r157->x11
        //%r411->x9
        //%r159->x10
        //%r413->x9
        //%r161->[sp,#16]
        //%r415->[sp,#32]
        //%r165->[sp,#24]
        //%r419->x24
        //%r167->x26
        //%r421->x22
        //%r169->x25
        //%r423->x20
        //%r173->x23
        //%r427->x12
        //%r175->x22
        //%r429->x10
        //%r177->x21
        //%r179->x20
        //%r417->x26
        //%r181->x15
        //%r183->x14
        //%r185->x13
        //%r187->x12
        //%r428->x11
        //%r430->x9
        //%r503->x9
        //%r504->x9
        //%r505->x9
        //%r506->x9
        //%r507->x9
        //%r508->x9
        //%r509->x9
        //%r510->x9
        //%r511->x9
        //%r513->x9
        //%r515->x9
        //%r517->x9
        //%r519->x9
        //%r521->x9
        //%r523->x9
        //%r525->x9
testParam16:

        //bb6:

bb6:

        //  %r399 = add i32 0, 0

        mov     x16, #48
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x16, x1
        mov     x17, #8
        str     x16, [sp,x17]
        mov     x26, x2
        mov     x25, x3
        mov     x24, x4
        mov     x23, x5
        mov     x22, x6
        mov     x21, x7
        ldr     x9, [x29]
        mov     x20, x9
        ldr     x9, [x29,#8]
        mov     x15, x9
        ldr     x9, [x29,#16]
        mov     x14, x9
        ldr     x9, [x29,#24]
        mov     x13, x9
        ldr     x9, [x29,#32]
        mov     x12, x9
        ldr     x9, [x29,#40]
        mov     x11, x9
        ldr     x9, [x29,#48]
        mov     x10, x9
        ldr     x9, [x29,#56]
        mov     x16, x9
        mov     x17, #16
        str     x16, [sp,x17]
        mov     x9, #0
        //  %r415 = add i32 %r131, 0

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #32
        str     x16, [sp,x17]
        //  %r400 = add i32 0, 0

        mov     x9, #0
        //  %r416 = add i32 %r133, 0

        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #40
        str     x16, [sp,x17]
        //  %r401 = add i32 0, 0

        mov     x9, #0
        //  %r417 = add i32 %r135, 0

        mov     x26, x26
        //  %r402 = add i32 0, 0

        mov     x9, #0
        //  %r418 = add i32 %r137, 0

        mov     x25, x25
        //  %r403 = add i32 0, 0

        mov     x9, #0
        //  %r419 = add i32 %r139, 0

        mov     x24, x24
        //  %r404 = add i32 0, 0

        mov     x9, #0
        //  %r420 = add i32 %r141, 0

        mov     x23, x23
        //  %r405 = add i32 0, 0

        mov     x9, #0
        //  %r421 = add i32 %r143, 0

        mov     x22, x22
        //  %r406 = add i32 0, 0

        mov     x9, #0
        //  %r422 = add i32 %r145, 0

        mov     x21, x21
        //  %r407 = add i32 0, 0

        mov     x9, #0
        //  %r423 = add i32 %r147, 0

        mov     x20, x20
        //  %r408 = add i32 0, 0

        mov     x9, #0
        //  %r424 = add i32 %r149, 0

        mov     x15, x15
        //  %r409 = add i32 0, 0

        mov     x9, #0
        //  %r425 = add i32 %r151, 0

        mov     x14, x14
        //  %r410 = add i32 0, 0

        mov     x9, #0
        //  %r426 = add i32 %r153, 0

        mov     x13, x13
        //  %r411 = add i32 0, 0

        mov     x9, #0
        //  %r427 = add i32 %r155, 0

        mov     x12, x12
        //  %r412 = add i32 0, 0

        mov     x9, #0
        //  %r428 = add i32 %r157, 0

        mov     x11, x11
        //  %r413 = add i32 0, 0

        mov     x9, #0
        //  %r429 = add i32 %r159, 0

        mov     x10, x10
        //  %r414 = add i32 0, 0

        mov     x9, #0
        //  %r430 = add i32 %r161, 0

        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     x9, x19
        //  %r165 = add i32 %r415, %r416

        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     x16, #40
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #24
        str     x16, [sp,x17]
        //  %r167 = add i32 %r165, %r417

        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x26, x19, x26
        //  %r169 = sub i32 %r167, %r418

        sub     x25, x26, x25
        //  %r171 = sub i32 %r169, %r419

        sub     x24, x25, x24
        //  %r173 = sub i32 %r171, %r420

        sub     x23, x24, x23
        //  %r175 = sub i32 %r173, %r421

        sub     x22, x23, x22
        //  %r177 = sub i32 %r175, %r422

        sub     x21, x22, x21
        //  %r179 = add i32 %r177, %r423

        add     x20, x21, x20
        //  %r181 = add i32 %r179, %r424

        add     x15, x20, x15
        //  %r183 = add i32 %r181, %r425

        add     x14, x15, x14
        //  %r185 = add i32 %r183, %r426

        add     x13, x14, x13
        //  %r187 = add i32 %r185, %r427

        add     x12, x13, x12
        //  %r189 = add i32 %r187, %r428

        add     x11, x12, x11
        //  %r191 = add i32 %r189, %r429

        add     x10, x11, x10
        //  %r193 = add i32 %r191, %r430

        add     x9, x10, x9
        //  ret i32 %r193

        mov     x0, x9
        mov     sp, x29
        ret
        //%r493->x10
        //%r236->x23
        //%r491->x12
        //%r234->x24
        //%r489->x14
        //%r232->x25
        //%r487->x20
        //%r230->x26
        //%r485->x22
        //%r228->[sp,#136]
        //%r483->x24
        //%r226->[sp,#128]
        //%r481->x26
        //%r224->[sp,#120]
        //%r479->[sp,#416]
        //%r222->[sp,#112]
        //%r477->[sp,#400]
        //%r220->[sp,#104]
        //%r475->[sp,#384]
        //%r218->[sp,#96]
        //%r473->[sp,#368]
        //%r216->[sp,#88]
        //%r471->[sp,#352]
        //%r214->[sp,#80]
        //%r469->[sp,#336]
        //%r212->[sp,#72]
        //%r467->[sp,#320]
        //%r210->[sp,#64]
        //%r465->[sp,#304]
        //%r208->[sp,#56]
        //%r463->[sp,#288]
        //%r206->[sp,#48]
        //%r461->x9
        //%r204->[sp,#40]
        //%r459->x9
        //%r202->[sp,#32]
        //%r457->x9
        //%r200->[sp,#24]
        //%r455->x9
        //%r198->[sp,#16]
        //%r453->x9
        //%r196->[sp,#8]
        //%r451->x9
        //%r194->[sp,#0]
        //%r449->x9
        //%r446->x9
        //%r444->x9
        //%r442->x9
        //%r440->x9
        //%r438->x9
        //%r436->x9
        //%r434->x9
        //%r432->x9
        //%r447->x9
        //%r320->x9
        //%r577->x9
        //%r445->x9
        //%r318->x10
        //%r575->x9
        //%r443->x9
        //%r316->x11
        //%r573->x9
        //%r441->x9
        //%r314->x12
        //%r571->x9
        //%r250->x12
        //%r248->x13
        //%r246->x14
        //%r244->x15
        //%r242->x20
        //%r494->x9
        //%r240->x21
        //%r492->x11
        //%r238->x22
        //%r490->x13
        //%r488->x15
        //%r486->x21
        //%r484->x23
        //%r482->x25
        //%r480->[sp,#424]
        //%r478->[sp,#408]
        //%r476->[sp,#392]
        //%r474->[sp,#376]
        //%r448->x9
        //%r439->x9
        //%r312->x13
        //%r569->x9
        //%r450->x9
        //%r452->x9
        //%r454->x9
        //%r456->x9
        //%r458->x9
        //%r460->x9
        //%r462->x9
        //%r464->[sp,#296]
        //%r466->[sp,#312]
        //%r468->[sp,#328]
        //%r470->[sp,#344]
        //%r472->[sp,#360]
        //%r252->x11
        //%r254->x10
        //%r256->[sp,#144]
        //%r260->[sp,#152]
        //%r262->[sp,#160]
        //%r264->[sp,#168]
        //%r266->[sp,#176]
        //%r268->[sp,#184]
        //%r270->[sp,#192]
        //%r527->x9
        //%r272->[sp,#200]
        //%r529->x9
        //%r274->[sp,#208]
        //%r531->x9
        //%r276->[sp,#216]
        //%r533->x9
        //%r278->[sp,#224]
        //%r535->x9
        //%r280->[sp,#232]
        //%r537->x9
        //%r282->[sp,#240]
        //%r539->x9
        //%r284->[sp,#248]
        //%r541->x9
        //%r286->[sp,#256]
        //%r543->x9
        //%r288->[sp,#264]
        //%r545->x9
        //%r290->[sp,#272]
        //%r547->x9
        //%r292->[sp,#280]
        //%r549->x9
        //%r294->x26
        //%r551->x9
        //%r296->x25
        //%r553->x9
        //%r298->x24
        //%r555->x9
        //%r300->x23
        //%r557->x9
        //%r302->x22
        //%r559->x9
        //%r431->x9
        //%r304->x21
        //%r561->x9
        //%r433->x9
        //%r306->x20
        //%r563->x9
        //%r435->x9
        //%r308->x15
        //%r565->x9
        //%r437->x9
        //%r310->x14
        //%r567->x9
        //%r528->x9
        //%r530->x9
        //%r532->x9
        //%r534->x9
        //%r536->x9
        //%r538->x9
        //%r540->x9
        //%r542->x9
        //%r544->x9
        //%r546->x9
        //%r548->x9
        //%r550->x9
        //%r552->x9
        //%r554->x9
        //%r556->x9
        //%r558->x9
        //%r560->x9
        //%r562->x9
        //%r564->x9
        //%r566->x9
        //%r568->x9
        //%r570->x9
        //%r572->x9
        //%r574->x9
        //%r576->x9
        //%r578->x9
        //%r579->x9
        //%r580->x9
        //%r581->x9
        //%r582->x9
testParam32:

        //bb7:

bb7:

        //  %r431 = add i32 0, 0

        mov     x16, #432
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x16, x1
        mov     x17, #8
        str     x16, [sp,x17]
        mov     x16, x2
        mov     x17, #16
        str     x16, [sp,x17]
        mov     x16, x3
        mov     x17, #24
        str     x16, [sp,x17]
        mov     x16, x4
        mov     x17, #32
        str     x16, [sp,x17]
        mov     x16, x5
        mov     x17, #40
        str     x16, [sp,x17]
        mov     x16, x6
        mov     x17, #48
        str     x16, [sp,x17]
        mov     x16, x7
        mov     x17, #56
        str     x16, [sp,x17]
        ldr     x9, [x29]
        mov     x16, x9
        mov     x17, #64
        str     x16, [sp,x17]
        ldr     x9, [x29,#8]
        mov     x16, x9
        mov     x17, #72
        str     x16, [sp,x17]
        ldr     x9, [x29,#16]
        mov     x16, x9
        mov     x17, #80
        str     x16, [sp,x17]
        ldr     x9, [x29,#24]
        mov     x16, x9
        mov     x17, #88
        str     x16, [sp,x17]
        ldr     x9, [x29,#32]
        mov     x16, x9
        mov     x17, #96
        str     x16, [sp,x17]
        ldr     x9, [x29,#40]
        mov     x16, x9
        mov     x17, #104
        str     x16, [sp,x17]
        ldr     x9, [x29,#48]
        mov     x16, x9
        mov     x17, #112
        str     x16, [sp,x17]
        ldr     x9, [x29,#56]
        mov     x16, x9
        mov     x17, #120
        str     x16, [sp,x17]
        ldr     x9, [x29,#64]
        mov     x16, x9
        mov     x17, #128
        str     x16, [sp,x17]
        ldr     x9, [x29,#72]
        mov     x16, x9
        mov     x17, #136
        str     x16, [sp,x17]
        ldr     x9, [x29,#80]
        mov     x26, x9
        ldr     x9, [x29,#88]
        mov     x25, x9
        ldr     x9, [x29,#96]
        mov     x24, x9
        ldr     x9, [x29,#104]
        mov     x23, x9
        ldr     x9, [x29,#112]
        mov     x22, x9
        ldr     x9, [x29,#120]
        mov     x21, x9
        ldr     x9, [x29,#128]
        mov     x20, x9
        ldr     x9, [x29,#136]
        mov     x15, x9
        ldr     x9, [x29,#144]
        mov     x14, x9
        ldr     x9, [x29,#152]
        mov     x13, x9
        ldr     x9, [x29,#160]
        mov     x12, x9
        ldr     x9, [x29,#168]
        mov     x11, x9
        ldr     x9, [x29,#176]
        mov     x10, x9
        ldr     x9, [x29,#184]
        mov     x16, x9
        mov     x17, #144
        str     x16, [sp,x17]
        mov     x9, #0
        //  %r463 = add i32 %r194, 0

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #288
        str     x16, [sp,x17]
        //  %r432 = add i32 0, 0

        mov     x9, #0
        //  %r464 = add i32 %r196, 0

        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #296
        str     x16, [sp,x17]
        //  %r433 = add i32 0, 0

        mov     x9, #0
        //  %r465 = add i32 %r198, 0

        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #304
        str     x16, [sp,x17]
        //  %r434 = add i32 0, 0

        mov     x9, #0
        //  %r466 = add i32 %r200, 0

        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #312
        str     x16, [sp,x17]
        //  %r435 = add i32 0, 0

        mov     x9, #0
        //  %r467 = add i32 %r202, 0

        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #320
        str     x16, [sp,x17]
        //  %r436 = add i32 0, 0

        mov     x9, #0
        //  %r468 = add i32 %r204, 0

        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #328
        str     x16, [sp,x17]
        //  %r437 = add i32 0, 0

        mov     x9, #0
        //  %r469 = add i32 %r206, 0

        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #336
        str     x16, [sp,x17]
        //  %r438 = add i32 0, 0

        mov     x9, #0
        //  %r470 = add i32 %r208, 0

        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #344
        str     x16, [sp,x17]
        //  %r439 = add i32 0, 0

        mov     x9, #0
        //  %r471 = add i32 %r210, 0

        mov     x16, #64
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #352
        str     x16, [sp,x17]
        //  %r440 = add i32 0, 0

        mov     x9, #0
        //  %r472 = add i32 %r212, 0

        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #360
        str     x16, [sp,x17]
        //  %r441 = add i32 0, 0

        mov     x9, #0
        //  %r473 = add i32 %r214, 0

        mov     x16, #80
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #368
        str     x16, [sp,x17]
        //  %r442 = add i32 0, 0

        mov     x9, #0
        //  %r474 = add i32 %r216, 0

        mov     x16, #88
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #376
        str     x16, [sp,x17]
        //  %r443 = add i32 0, 0

        mov     x9, #0
        //  %r475 = add i32 %r218, 0

        mov     x16, #96
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #384
        str     x16, [sp,x17]
        //  %r444 = add i32 0, 0

        mov     x9, #0
        //  %r476 = add i32 %r220, 0

        mov     x16, #104
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #392
        str     x16, [sp,x17]
        //  %r445 = add i32 0, 0

        mov     x9, #0
        //  %r477 = add i32 %r222, 0

        mov     x16, #112
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #400
        str     x16, [sp,x17]
        //  %r446 = add i32 0, 0

        mov     x9, #0
        //  %r478 = add i32 %r224, 0

        mov     x16, #120
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #408
        str     x16, [sp,x17]
        //  %r447 = add i32 0, 0

        mov     x9, #0
        //  %r479 = add i32 %r226, 0

        mov     x16, #128
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #416
        str     x16, [sp,x17]
        //  %r448 = add i32 0, 0

        mov     x9, #0
        //  %r480 = add i32 %r228, 0

        mov     x16, #136
        ldr     x19, [sp,x16]
        mov     x16, x19
        mov     x17, #424
        str     x16, [sp,x17]
        //  %r449 = add i32 0, 0

        mov     x9, #0
        //  %r481 = add i32 %r230, 0

        mov     x26, x26
        //  %r450 = add i32 0, 0

        mov     x9, #0
        //  %r482 = add i32 %r232, 0

        mov     x25, x25
        //  %r451 = add i32 0, 0

        mov     x9, #0
        //  %r483 = add i32 %r234, 0

        mov     x24, x24
        //  %r452 = add i32 0, 0

        mov     x9, #0
        //  %r484 = add i32 %r236, 0

        mov     x23, x23
        //  %r453 = add i32 0, 0

        mov     x9, #0
        //  %r485 = add i32 %r238, 0

        mov     x22, x22
        //  %r454 = add i32 0, 0

        mov     x9, #0
        //  %r486 = add i32 %r240, 0

        mov     x21, x21
        //  %r455 = add i32 0, 0

        mov     x9, #0
        //  %r487 = add i32 %r242, 0

        mov     x20, x20
        //  %r456 = add i32 0, 0

        mov     x9, #0
        //  %r488 = add i32 %r244, 0

        mov     x15, x15
        //  %r457 = add i32 0, 0

        mov     x9, #0
        //  %r489 = add i32 %r246, 0

        mov     x14, x14
        //  %r458 = add i32 0, 0

        mov     x9, #0
        //  %r490 = add i32 %r248, 0

        mov     x13, x13
        //  %r459 = add i32 0, 0

        mov     x9, #0
        //  %r491 = add i32 %r250, 0

        mov     x12, x12
        //  %r460 = add i32 0, 0

        mov     x9, #0
        //  %r492 = add i32 %r252, 0

        mov     x11, x11
        //  %r461 = add i32 0, 0

        mov     x9, #0
        //  %r493 = add i32 %r254, 0

        mov     x10, x10
        //  %r462 = add i32 0, 0

        mov     x9, #0
        //  %r494 = add i32 %r256, 0

        mov     x16, #144
        ldr     x19, [sp,x16]
        mov     x9, x19
        //  %r260 = add i32 %r463, %r464

        mov     x16, #288
        ldr     x19, [sp,x16]
        mov     x16, #296
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #152
        str     x16, [sp,x17]
        //  %r262 = add i32 %r260, %r465

        mov     x16, #152
        ldr     x19, [sp,x16]
        mov     x16, #304
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #160
        str     x16, [sp,x17]
        //  %r264 = add i32 %r262, %r466

        mov     x16, #160
        ldr     x19, [sp,x16]
        mov     x16, #312
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #168
        str     x16, [sp,x17]
        //  %r266 = add i32 %r264, %r467

        mov     x16, #168
        ldr     x19, [sp,x16]
        mov     x16, #320
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #176
        str     x16, [sp,x17]
        //  %r268 = add i32 %r266, %r468

        mov     x16, #176
        ldr     x19, [sp,x16]
        mov     x16, #328
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #184
        str     x16, [sp,x17]
        //  %r270 = add i32 %r268, %r469

        mov     x16, #184
        ldr     x19, [sp,x16]
        mov     x16, #336
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #192
        str     x16, [sp,x17]
        //  %r272 = add i32 %r270, %r470

        mov     x16, #192
        ldr     x19, [sp,x16]
        mov     x16, #344
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #200
        str     x16, [sp,x17]
        //  %r274 = add i32 %r272, %r471

        mov     x16, #200
        ldr     x19, [sp,x16]
        mov     x16, #352
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #208
        str     x16, [sp,x17]
        //  %r276 = add i32 %r274, %r472

        mov     x16, #208
        ldr     x19, [sp,x16]
        mov     x16, #360
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #216
        str     x16, [sp,x17]
        //  %r278 = add i32 %r276, %r473

        mov     x16, #216
        ldr     x19, [sp,x16]
        mov     x16, #368
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #224
        str     x16, [sp,x17]
        //  %r280 = add i32 %r278, %r474

        mov     x16, #224
        ldr     x19, [sp,x16]
        mov     x16, #376
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #232
        str     x16, [sp,x17]
        //  %r282 = add i32 %r280, %r475

        mov     x16, #232
        ldr     x19, [sp,x16]
        mov     x16, #384
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #240
        str     x16, [sp,x17]
        //  %r284 = add i32 %r282, %r476

        mov     x16, #240
        ldr     x19, [sp,x16]
        mov     x16, #392
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #248
        str     x16, [sp,x17]
        //  %r286 = add i32 %r284, %r477

        mov     x16, #248
        ldr     x19, [sp,x16]
        mov     x16, #400
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #256
        str     x16, [sp,x17]
        //  %r288 = add i32 %r286, %r478

        mov     x16, #256
        ldr     x19, [sp,x16]
        mov     x16, #408
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #264
        str     x16, [sp,x17]
        //  %r290 = add i32 %r288, %r479

        mov     x16, #264
        ldr     x19, [sp,x16]
        mov     x16, #416
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #272
        str     x16, [sp,x17]
        //  %r292 = add i32 %r290, %r480

        mov     x16, #272
        ldr     x19, [sp,x16]
        mov     x16, #424
        ldr     x18, [sp,x16]
        add     x16, x19, x18
        mov     x17, #280
        str     x16, [sp,x17]
        //  %r294 = sub i32 %r292, %r481

        mov     x16, #280
        ldr     x19, [sp,x16]
        sub     x26, x19, x26
        //  %r296 = sub i32 %r294, %r482

        sub     x25, x26, x25
        //  %r298 = sub i32 %r296, %r483

        sub     x24, x25, x24
        //  %r300 = sub i32 %r298, %r484

        sub     x23, x24, x23
        //  %r302 = sub i32 %r300, %r485

        sub     x22, x23, x22
        //  %r304 = add i32 %r302, %r486

        add     x21, x22, x21
        //  %r306 = add i32 %r304, %r487

        add     x20, x21, x20
        //  %r308 = add i32 %r306, %r488

        add     x15, x20, x15
        //  %r310 = add i32 %r308, %r489

        add     x14, x15, x14
        //  %r312 = add i32 %r310, %r490

        add     x13, x14, x13
        //  %r314 = add i32 %r312, %r491

        add     x12, x13, x12
        //  %r316 = add i32 %r314, %r492

        add     x11, x12, x11
        //  %r318 = add i32 %r316, %r493

        add     x10, x11, x10
        //  %r320 = add i32 %r318, %r494

        add     x9, x10, x9
        //  ret i32 %r320

        mov     x0, x9
        mov     sp, x29
        ret
        //%r647->x9
        //%r646->x10
        //%r645->x9
        //%r644->x10
        //%r643->x9
        //%r642->x10
        //%r641->x9
        //%r640->x10
        //%r639->x9
        //%r382->x9
        //%r638->x10
        //%r381->x10
        //%r637->x9
        //%r380->x9
        //%r636->x10
        //%r379->x10
        //%r635->x9
        //%r378->x11
        //%r634->x10
        //%r377->x12
        //%r603->x9
        //%r346->x9
        //%r349->[sp,#16]
        //%r606->x10
        //%r602->x10
        //%r345->x10
        //%r348->x9
        //%r605->x9
        //%r601->x9
        //%r344->x11
        //%r347->x10
        //%r604->x10
        //%r600->x10
        //%r343->x12
        //%r599->x9
        //%r342->x13
        //%r598->x10
        //%r341->x14
        //%r597->x9
        //%r340->x15
        //%r596->x10
        //%r339->x20
        //%r595->x9
        //%r338->x21
        //%r594->x10
        //%r337->x22
        //%r593->x9
        //%r336->x23
        //%r592->x10
        //%r335->x24
        //%r591->x9
        //%r334->x25
        //%r590->x10
        //%r333->x26
        //%r589->x9
        //%r332->[sp,#8]
        //%r588->x10
        //%r331->[sp,#0]
        //%r321->x9
        //%r322->x20
        //%r323->x15
        //%r324->x14
        //%r325->x13
        //%r326->x12
        //%r583->x9
        //%r327->x11
        //%r584->x10
        //%r328->x10
        //%r585->x9
        //%r329->x10
        //%r586->x10
        //%r330->x9
        //%r587->x9
        //%r350->[sp,#24]
        //%r607->x9
        //%r351->[sp,#32]
        //%r608->x10
        //%r352->[sp,#40]
        //%r609->x9
        //%r353->[sp,#48]
        //%r610->x10
        //%r354->[sp,#56]
        //%r611->x9
        //%r355->[sp,#64]
        //%r612->x10
        //%r356->[sp,#72]
        //%r613->x9
        //%r357->[sp,#80]
        //%r614->x10
        //%r358->[sp,#88]
        //%r615->x9
        //%r359->[sp,#96]
        //%r616->x10
        //%r360->[sp,#104]
        //%r617->x9
        //%r361->[sp,#112]
        //%r618->x10
        //%r362->[sp,#120]
        //%r619->x9
        //%r363->[sp,#128]
        //%r620->x10
        //%r364->[sp,#136]
        //%r621->x9
        //%r365->[sp,#144]
        //%r622->x10
        //%r366->[sp,#152]
        //%r623->x9
        //%r367->x26
        //%r624->x10
        //%r368->x25
        //%r625->x9
        //%r369->x24
        //%r626->x10
        //%r370->x23
        //%r627->x9
        //%r371->x22
        //%r628->x10
        //%r372->x21
        //%r629->x9
        //%r373->x20
        //%r630->x10
        //%r374->x15
        //%r631->x9
        //%r375->x14
        //%r632->x10
        //%r376->x13
        //%r633->x9
        //%r648->x10
        //%r649->x9
        //%r650->x10
        //%r651->x9
        //%r652->x10
        //%r653->x9
        //%r654->x10
        //%r655->x9
        //%r656->x10
        //%r657->x9
        //%r658->x10
        //%r659->x9
        //%r660->x10
        //%r661->x9
        //%r662->x10
        //%r663->x9
        //%r664->x9
        //%r665->x10
        //%r666->x10
        //%r667->x10
        //%r668->x10
        //%r669->x10
        //%r670->x10
        //%r671->x10
        //%r672->x9
        //%r673->x9
        //%r674->x9
        //%r675->x9
        //%r676->x9
        //%r677->x9
        //%r678->x9
        //%r679->x9
        //%r680->x9
        //%r681->x9
        //%r682->x9
        //%r683->x9
        //%r684->x9
        //%r685->x9
        //%r686->x9
        //%r687->x9
        //%r688->x9
        //%r689->x9
        //%r690->x9
        //%r691->x9
        //%r692->x9
        //%r693->x9
        //%r694->x9
        //%r695->x9
        //%r696->x9
        //%r697->x9
        //%r698->x9
        //%r699->x9
        //%r700->x9
        //%r701->x9
        //%r702->x9
        //%r703->x9
        //%r704->x9
        //%r705->x9
        //%r706->x9
        //%r707->x9
        //%r708->x9
        //%r709->x9
        //%r710->x9
        //%r711->x9
        //%r712->x9
        //%r713->x9
        //%r714->x9
        //%r715->x9
        //%r716->x9
        //%r717->x9
        //%r718->x9
        //%r719->x9
        //%r720->x9
        //%r721->x9
        //%r722->x9
        //%r723->x9
        //%r724->x9
        //%r725->x9
        //%r726->x9
        //%r727->x9
main:

        //bb4:

bb4:

        //  call void @_sysy_starttime(i32 97)

        mov     x16, #160
        sub     sp, sp, x16
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
        //  store i32 0, i32* @a0

        mov     x10, #0
        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        str     x10, [x9]
        //  store i32 1, i32* @a1

        mov     x10, #1
        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        str     x10, [x9]
        //  store i32 2, i32* @a2

        mov     x10, #2
        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        str     x10, [x9]
        //  store i32 3, i32* @a3

        mov     x10, #3
        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        str     x10, [x9]
        //  store i32 4, i32* @a4

        mov     x10, #4
        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        str     x10, [x9]
        //  store i32 5, i32* @a5

        mov     x10, #5
        adrp     x9, a5
        add     x9, x9, #:lo12:a5
        str     x10, [x9]
        //  store i32 6, i32* @a6

        mov     x10, #6
        adrp     x9, a6
        add     x9, x9, #:lo12:a6
        str     x10, [x9]
        //  store i32 7, i32* @a7

        mov     x10, #7
        adrp     x9, a7
        add     x9, x9, #:lo12:a7
        str     x10, [x9]
        //  store i32 8, i32* @a8

        mov     x10, #8
        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        str     x10, [x9]
        //  store i32 9, i32* @a9

        mov     x10, #9
        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        str     x10, [x9]
        //  store i32 0, i32* @a10

        mov     x10, #0
        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        str     x10, [x9]
        //  store i32 1, i32* @a11

        mov     x10, #1
        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        str     x10, [x9]
        //  store i32 2, i32* @a12

        mov     x10, #2
        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        str     x10, [x9]
        //  store i32 3, i32* @a13

        mov     x10, #3
        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        str     x10, [x9]
        //  store i32 4, i32* @a14

        mov     x10, #4
        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        str     x10, [x9]
        //  store i32 5, i32* @a15

        mov     x10, #5
        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        str     x10, [x9]
        //  store i32 6, i32* @a16

        mov     x10, #6
        adrp     x9, a16
        add     x9, x9, #:lo12:a16
        str     x10, [x9]
        //  store i32 7, i32* @a17

        mov     x10, #7
        adrp     x9, a17
        add     x9, x9, #:lo12:a17
        str     x10, [x9]
        //  store i32 8, i32* @a18

        mov     x10, #8
        adrp     x9, a18
        add     x9, x9, #:lo12:a18
        str     x10, [x9]
        //  store i32 9, i32* @a19

        mov     x10, #9
        adrp     x9, a19
        add     x9, x9, #:lo12:a19
        str     x10, [x9]
        //  store i32 0, i32* @a20

        mov     x10, #0
        adrp     x9, a20
        add     x9, x9, #:lo12:a20
        str     x10, [x9]
        //  store i32 1, i32* @a21

        mov     x10, #1
        adrp     x9, a21
        add     x9, x9, #:lo12:a21
        str     x10, [x9]
        //  store i32 2, i32* @a22

        mov     x10, #2
        adrp     x9, a22
        add     x9, x9, #:lo12:a22
        str     x10, [x9]
        //  store i32 3, i32* @a23

        mov     x10, #3
        adrp     x9, a23
        add     x9, x9, #:lo12:a23
        str     x10, [x9]
        //  store i32 4, i32* @a24

        mov     x10, #4
        adrp     x9, a24
        add     x9, x9, #:lo12:a24
        str     x10, [x9]
        //  store i32 5, i32* @a25

        mov     x10, #5
        adrp     x9, a25
        add     x9, x9, #:lo12:a25
        str     x10, [x9]
        //  store i32 6, i32* @a26

        mov     x10, #6
        adrp     x9, a26
        add     x9, x9, #:lo12:a26
        str     x10, [x9]
        //  store i32 7, i32* @a27

        mov     x10, #7
        adrp     x9, a27
        add     x9, x9, #:lo12:a27
        str     x10, [x9]
        //  store i32 8, i32* @a28

        mov     x10, #8
        adrp     x9, a28
        add     x9, x9, #:lo12:a28
        str     x10, [x9]
        //  store i32 9, i32* @a29

        mov     x10, #9
        adrp     x9, a29
        add     x9, x9, #:lo12:a29
        str     x10, [x9]
        //  store i32 0, i32* @a30

        mov     x10, #0
        adrp     x9, a30
        add     x9, x9, #:lo12:a30
        str     x10, [x9]
        //  store i32 1, i32* @a31

        mov     x10, #1
        adrp     x9, a31
        add     x9, x9, #:lo12:a31
        str     x10, [x9]
        //  store i32 4, i32* @a32

        mov     x10, #4
        adrp     x9, a32
        add     x9, x9, #:lo12:a32
        str     x10, [x9]
        //  store i32 5, i32* @a33

        mov     x10, #5
        adrp     x9, a33
        add     x9, x9, #:lo12:a33
        str     x10, [x9]
        //  store i32 6, i32* @a34

        mov     x10, #6
        adrp     x9, a34
        add     x9, x9, #:lo12:a34
        str     x10, [x9]
        //  store i32 7, i32* @a35

        mov     x10, #7
        adrp     x9, a35
        add     x9, x9, #:lo12:a35
        str     x10, [x9]
        //  store i32 8, i32* @a36

        mov     x10, #8
        adrp     x9, a36
        add     x9, x9, #:lo12:a36
        str     x10, [x9]
        //  store i32 9, i32* @a37

        mov     x10, #9
        adrp     x9, a37
        add     x9, x9, #:lo12:a37
        str     x10, [x9]
        //  store i32 0, i32* @a38

        mov     x10, #0
        adrp     x9, a38
        add     x9, x9, #:lo12:a38
        str     x10, [x9]
        //  store i32 1, i32* @a39

        mov     x10, #1
        adrp     x9, a39
        add     x9, x9, #:lo12:a39
        str     x10, [x9]
        //  %r321 = load i32, i32* @a0

        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        ldr     x9, [x9]
        //  %r322 = load i32, i32* @a1

        adrp     x10, a1
        add     x10, x10, #:lo12:a1
        ldr     x20, [x10]
        //  %r323 = load i32, i32* @a2

        adrp     x10, a2
        add     x10, x10, #:lo12:a2
        ldr     x15, [x10]
        //  %r324 = load i32, i32* @a3

        adrp     x10, a3
        add     x10, x10, #:lo12:a3
        ldr     x14, [x10]
        //  %r325 = load i32, i32* @a4

        adrp     x10, a4
        add     x10, x10, #:lo12:a4
        ldr     x13, [x10]
        //  %r326 = load i32, i32* @a5

        adrp     x10, a5
        add     x10, x10, #:lo12:a5
        ldr     x12, [x10]
        //  %r327 = load i32, i32* @a6

        adrp     x10, a6
        add     x10, x10, #:lo12:a6
        ldr     x11, [x10]
        //  %r328 = load i32, i32* @a7

        adrp     x10, a7
        add     x10, x10, #:lo12:a7
        ldr     x10, [x10]
        //  %r329 = call i32 @testParam8(i32 %r321, i32 %r322, i32 %r323, i32 %r324, i32 %r325, i32 %r326, i32 %r327, i32 %r328)

        mov     x0, x9
        mov     x1, x20
        mov     x2, x15
        mov     x3, x14
        mov     x4, x13
        mov     x5, x12
        mov     x6, x11
        mov     x7, x10
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
        bl     testParam8
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  store i32 %r329, i32* @a0

        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        str     x10, [x9]
        //  %r330 = load i32, i32* @a0

        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        ldr     x9, [x9]
        //  call void @putint(i32 %r330)

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
        //  %r331 = load i32, i32* @a32

        adrp     x9, a32
        add     x9, x9, #:lo12:a32
        ldr     x16, [x9]
        mov     x17, #0
        str     x16, [sp,x17]
        //  %r332 = load i32, i32* @a33

        adrp     x9, a33
        add     x9, x9, #:lo12:a33
        ldr     x16, [x9]
        mov     x17, #8
        str     x16, [sp,x17]
        //  %r333 = load i32, i32* @a34

        adrp     x9, a34
        add     x9, x9, #:lo12:a34
        ldr     x26, [x9]
        //  %r334 = load i32, i32* @a35

        adrp     x9, a35
        add     x9, x9, #:lo12:a35
        ldr     x25, [x9]
        //  %r335 = load i32, i32* @a36

        adrp     x9, a36
        add     x9, x9, #:lo12:a36
        ldr     x24, [x9]
        //  %r336 = load i32, i32* @a37

        adrp     x9, a37
        add     x9, x9, #:lo12:a37
        ldr     x23, [x9]
        //  %r337 = load i32, i32* @a38

        adrp     x9, a38
        add     x9, x9, #:lo12:a38
        ldr     x22, [x9]
        //  %r338 = load i32, i32* @a39

        adrp     x9, a39
        add     x9, x9, #:lo12:a39
        ldr     x21, [x9]
        //  %r339 = load i32, i32* @a8

        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        ldr     x20, [x9]
        //  %r340 = load i32, i32* @a9

        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        ldr     x15, [x9]
        //  %r341 = load i32, i32* @a10

        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        ldr     x14, [x9]
        //  %r342 = load i32, i32* @a11

        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        ldr     x13, [x9]
        //  %r343 = load i32, i32* @a12

        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        ldr     x12, [x9]
        //  %r344 = load i32, i32* @a13

        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        ldr     x11, [x9]
        //  %r345 = load i32, i32* @a14

        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        ldr     x10, [x9]
        //  %r346 = load i32, i32* @a15

        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        ldr     x9, [x9]
        //  %r347 = call i32 @testParam16(i32 %r331, i32 %r332, i32 %r333, i32 %r334, i32 %r335, i32 %r336, i32 %r337, i32 %r338, i32 %r339, i32 %r340, i32 %r341, i32 %r342, i32 %r343, i32 %r344, i32 %r345, i32 %r346)

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     x1, x19
        mov     x2, x26
        mov     x3, x25
        mov     x4, x24
        mov     x5, x23
        mov     x6, x22
        mov     x7, x21
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
        str     x20, [sp,#-136]
        str     x15, [sp,#-144]
        str     x14, [sp,#-152]
        str     x13, [sp,#-160]
        str     x12, [sp,#-168]
        str     x11, [sp,#-176]
        str     x10, [sp,#-184]
        str     x9, [sp,#-192]
        sub     sp, sp, #192
        mov     x29, sp
        bl     testParam16
        add     sp, sp, #-64
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  store i32 %r347, i32* @a0

        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        str     x10, [x9]
        //  %r348 = load i32, i32* @a0

        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        ldr     x9, [x9]
        //  call void @putint(i32 %r348)

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
        //  %r349 = load i32, i32* @a0

        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        ldr     x16, [x9]
        mov     x17, #16
        str     x16, [sp,x17]
        //  %r350 = load i32, i32* @a1

        adrp     x9, a1
        add     x9, x9, #:lo12:a1
        ldr     x16, [x9]
        mov     x17, #24
        str     x16, [sp,x17]
        //  %r351 = load i32, i32* @a2

        adrp     x9, a2
        add     x9, x9, #:lo12:a2
        ldr     x16, [x9]
        mov     x17, #32
        str     x16, [sp,x17]
        //  %r352 = load i32, i32* @a3

        adrp     x9, a3
        add     x9, x9, #:lo12:a3
        ldr     x16, [x9]
        mov     x17, #40
        str     x16, [sp,x17]
        //  %r353 = load i32, i32* @a4

        adrp     x9, a4
        add     x9, x9, #:lo12:a4
        ldr     x16, [x9]
        mov     x17, #48
        str     x16, [sp,x17]
        //  %r354 = load i32, i32* @a5

        adrp     x9, a5
        add     x9, x9, #:lo12:a5
        ldr     x16, [x9]
        mov     x17, #56
        str     x16, [sp,x17]
        //  %r355 = load i32, i32* @a6

        adrp     x9, a6
        add     x9, x9, #:lo12:a6
        ldr     x16, [x9]
        mov     x17, #64
        str     x16, [sp,x17]
        //  %r356 = load i32, i32* @a7

        adrp     x9, a7
        add     x9, x9, #:lo12:a7
        ldr     x16, [x9]
        mov     x17, #72
        str     x16, [sp,x17]
        //  %r357 = load i32, i32* @a8

        adrp     x9, a8
        add     x9, x9, #:lo12:a8
        ldr     x16, [x9]
        mov     x17, #80
        str     x16, [sp,x17]
        //  %r358 = load i32, i32* @a9

        adrp     x9, a9
        add     x9, x9, #:lo12:a9
        ldr     x16, [x9]
        mov     x17, #88
        str     x16, [sp,x17]
        //  %r359 = load i32, i32* @a10

        adrp     x9, a10
        add     x9, x9, #:lo12:a10
        ldr     x16, [x9]
        mov     x17, #96
        str     x16, [sp,x17]
        //  %r360 = load i32, i32* @a11

        adrp     x9, a11
        add     x9, x9, #:lo12:a11
        ldr     x16, [x9]
        mov     x17, #104
        str     x16, [sp,x17]
        //  %r361 = load i32, i32* @a12

        adrp     x9, a12
        add     x9, x9, #:lo12:a12
        ldr     x16, [x9]
        mov     x17, #112
        str     x16, [sp,x17]
        //  %r362 = load i32, i32* @a13

        adrp     x9, a13
        add     x9, x9, #:lo12:a13
        ldr     x16, [x9]
        mov     x17, #120
        str     x16, [sp,x17]
        //  %r363 = load i32, i32* @a14

        adrp     x9, a14
        add     x9, x9, #:lo12:a14
        ldr     x16, [x9]
        mov     x17, #128
        str     x16, [sp,x17]
        //  %r364 = load i32, i32* @a15

        adrp     x9, a15
        add     x9, x9, #:lo12:a15
        ldr     x16, [x9]
        mov     x17, #136
        str     x16, [sp,x17]
        //  %r365 = load i32, i32* @a16

        adrp     x9, a16
        add     x9, x9, #:lo12:a16
        ldr     x16, [x9]
        mov     x17, #144
        str     x16, [sp,x17]
        //  %r366 = load i32, i32* @a17

        adrp     x9, a17
        add     x9, x9, #:lo12:a17
        ldr     x16, [x9]
        mov     x17, #152
        str     x16, [sp,x17]
        //  %r367 = load i32, i32* @a18

        adrp     x9, a18
        add     x9, x9, #:lo12:a18
        ldr     x26, [x9]
        //  %r368 = load i32, i32* @a19

        adrp     x9, a19
        add     x9, x9, #:lo12:a19
        ldr     x25, [x9]
        //  %r369 = load i32, i32* @a20

        adrp     x9, a20
        add     x9, x9, #:lo12:a20
        ldr     x24, [x9]
        //  %r370 = load i32, i32* @a21

        adrp     x9, a21
        add     x9, x9, #:lo12:a21
        ldr     x23, [x9]
        //  %r371 = load i32, i32* @a22

        adrp     x9, a22
        add     x9, x9, #:lo12:a22
        ldr     x22, [x9]
        //  %r372 = load i32, i32* @a23

        adrp     x9, a23
        add     x9, x9, #:lo12:a23
        ldr     x21, [x9]
        //  %r373 = load i32, i32* @a24

        adrp     x9, a24
        add     x9, x9, #:lo12:a24
        ldr     x20, [x9]
        //  %r374 = load i32, i32* @a25

        adrp     x9, a25
        add     x9, x9, #:lo12:a25
        ldr     x15, [x9]
        //  %r375 = load i32, i32* @a26

        adrp     x9, a26
        add     x9, x9, #:lo12:a26
        ldr     x14, [x9]
        //  %r376 = load i32, i32* @a27

        adrp     x9, a27
        add     x9, x9, #:lo12:a27
        ldr     x13, [x9]
        //  %r377 = load i32, i32* @a28

        adrp     x9, a28
        add     x9, x9, #:lo12:a28
        ldr     x12, [x9]
        //  %r378 = load i32, i32* @a29

        adrp     x9, a29
        add     x9, x9, #:lo12:a29
        ldr     x11, [x9]
        //  %r379 = load i32, i32* @a30

        adrp     x9, a30
        add     x9, x9, #:lo12:a30
        ldr     x10, [x9]
        //  %r380 = load i32, i32* @a31

        adrp     x9, a31
        add     x9, x9, #:lo12:a31
        ldr     x9, [x9]
        //  %r381 = call i32 @testParam32(i32 %r349, i32 %r350, i32 %r351, i32 %r352, i32 %r353, i32 %r354, i32 %r355, i32 %r356, i32 %r357, i32 %r358, i32 %r359, i32 %r360, i32 %r361, i32 %r362, i32 %r363, i32 %r364, i32 %r365, i32 %r366, i32 %r367, i32 %r368, i32 %r369, i32 %r370, i32 %r371, i32 %r372, i32 %r373, i32 %r374, i32 %r375, i32 %r376, i32 %r377, i32 %r378, i32 %r379, i32 %r380)

        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x1, x19
        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     x2, x19
        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     x3, x19
        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     x4, x19
        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     x5, x19
        mov     x16, #64
        ldr     x19, [sp,x16]
        mov     x6, x19
        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     x7, x19
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
        mov     x16, #80
        ldr     x19, [sp,x16]
        str     x19, [sp,#-136]
        mov     x16, #88
        ldr     x19, [sp,x16]
        str     x19, [sp,#-144]
        mov     x16, #96
        ldr     x19, [sp,x16]
        str     x19, [sp,#-152]
        mov     x16, #104
        ldr     x19, [sp,x16]
        str     x19, [sp,#-160]
        mov     x16, #112
        ldr     x19, [sp,x16]
        str     x19, [sp,#-168]
        mov     x16, #120
        ldr     x19, [sp,x16]
        str     x19, [sp,#-176]
        mov     x16, #128
        ldr     x19, [sp,x16]
        str     x19, [sp,#-184]
        mov     x16, #136
        ldr     x19, [sp,x16]
        str     x19, [sp,#-192]
        mov     x16, #144
        ldr     x19, [sp,x16]
        str     x19, [sp,#-200]
        mov     x16, #152
        ldr     x19, [sp,x16]
        str     x19, [sp,#-208]
        str     x26, [sp,#-216]
        str     x25, [sp,#-224]
        str     x24, [sp,#-232]
        str     x23, [sp,#-240]
        str     x22, [sp,#-248]
        str     x21, [sp,#-256]
        mov     x27, #-264
        str     x20, [sp,x27]
        mov     x27, #-272
        str     x15, [sp,x27]
        mov     x27, #-280
        str     x14, [sp,x27]
        mov     x27, #-288
        str     x13, [sp,x27]
        mov     x27, #-296
        str     x12, [sp,x27]
        mov     x27, #-304
        str     x11, [sp,x27]
        mov     x27, #-312
        str     x10, [sp,x27]
        mov     x27, #-320
        str     x9, [sp,x27]
        sub     sp, sp, #320
        mov     x29, sp
        bl     testParam32
        add     sp, sp, #-192
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  store i32 %r381, i32* @a0

        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        str     x10, [x9]
        //  %r382 = load i32, i32* @a0

        adrp     x9, a0
        add     x9, x9, #:lo12:a0
        ldr     x9, [x9]
        //  call void @putint(i32 %r382)

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
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
