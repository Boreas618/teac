.section .data
.global    len
len:
        .quad   20
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global main

        #%r436->x9

        #%r435->x10

        #%r433->x10

        #%r432->x9

        #%r431->x9

        #%r430->x9

        #%r428->x9

        #%r425->x9

        #%r424->x9

        #%r423->x10

        #%r422->x9

        #%r421->x10

        #%r420->x9

        #%r418->x9

        #%r415->x10

        #%r414->x9

        #%r413->x9

        #%r412->x9

        #%r410->x9

        #%r409->x10

        #%r408->x9

        #%r407->x9

        #%r406->x9

        #%r405->x10

        #%r404->x9

        #%r383->x9

        #%r362->x9

        #%r361->x10

        #%r360->x9

        #%r359->x9

        #%r358->x9

        #%r357->x10

        #%r356->x9

        #%r355->x10

        #%r354->x9

        #%r353->x9

        #%r352->x9

        #%r351->x10

        #%r350->x9

        #%r349->x10

        #%r348->x9

        #%r347->x9

        #%r346->x9

        #%r345->x10

        #%r344->x9

        #%r343->x10

        #%r342->x9

        #%r341->x9

        #%r340->x9

        #%r339->x10

        #%r338->x9

        #%r337->x10

        #%r336->x9

        #%r335->x9

        #%r334->x9

        #%r333->x10

        #%r332->x9

        #%r331->x10

        #%r330->x9

        #%r329->x9

        #%r328->x9

        #%r327->x10

        #%r326->x9

        #%r325->x10

        #%r324->x9

        #%r323->x9

        #%r322->x9

        #%r321->x10

        #%r320->x9

        #%r319->x10

        #%r318->x9

        #%r317->x9

        #%r316->x9

        #%r315->x10

        #%r314->x9

        #%r313->x10

        #%r312->x9

        #%r311->x9

        #%r310->x9

        #%r309->x10

        #%r308->x9

        #%r307->x10

        #%r216->x10

        #%r215->x9

        #%r210->x9

        #%r419->x9

        #%r162->x11

        #%r289->x9

        #%r417->x10

        #%r160->x10

        #%r287->x9

        #%r218->x9

        #%r416->x9

        #%r159->x10

        #%r286->x9

        #%r411->x10

        #%r154->x10

        #%r281->x12

        #%r403->x10

        #%r146->x10

        #%r273->x9

        #%r204->x9

        #%r402->x9

        #%r145->x10

        #%r272->x9

        #%r203->x9

        #%r401->x9

        #%r144->x10

        #%r271->[sp,#16]

        #%r202->x9

        #%r400->x9

        #%r143->x10

        #%r270->x9

        #%r399->x10

        #%r142->x10

        #%r269->x11

        #%r398->x9

        #%r141->x10

        #%r268->x9

        #%r199->x11

        #%r397->x10

        #%r140->x10

        #%r267->x9

        #%r198->x9

        #%r396->x9

        #%r139->x10

        #%r266->x9

        #%r395->x9

        #%r138->x10

        #%r265->x10

        #%r394->x9

        #%r137->x10

        #%r264->x9

        #%r393->x10

        #%r136->x10

        #%r263->x9

        #%r434->x9

        #%r177->x9

        #%r304->x9

        #%r375->x10

        #%r118->x10

        #%r374->x9

        #%r117->x10

        #%r244->x10

        #%r373->x10

        #%r116->x10

        #%r243->x10

        #%r372->x9

        #%r115->x10

        #%r371->x9

        #%r114->x10

        #%r429->x10

        #%r172->x11

        #%r299->x9

        #%r370->x9

        #%r113->x10

        #%r369->x10

        #%r112->x10

        #%r239->x9

        #%r427->x10

        #%r170->x10

        #%r297->x10

        #%r368->x9

        #%r111->x10

        #%r238->x9

        #%r426->x9

        #%r169->x10

        #%r296->x9

        #%r367->x10

        #%r110->x10

        #%r366->x9

        #%r109->x10

        #%r236->x10

        #%r365->x9

        #%r108->x10

        #%r235->x9

        #%r364->x9

        #%r107->x10

        #%r363->x10

        #%r106->x10

        #%r392->x9

        #%r135->x10

        #%r262->x9

        #%r376->x9

        #%r119->x10

        #%r377->x9

        #%r120->x10

        #%r247->x10

        #%r378->x9

        #%r121->x10

        #%r248->x10

        #%r379->x10

        #%r122->x10

        #%r380->x9

        #%r123->x10

        #%r183->x12

        #%r381->x10

        #%r124->x10

        #%r251->x9

        #%r382->x9

        #%r125->x10

        #%r252->x9

        #%r384->x9

        #%r127->x10

        #%r254->x9

        #%r385->x10

        #%r128->x10

        #%r255->x9

        #%r386->x9

        #%r129->x10

        #%r256->x9

        #%r387->x10

        #%r130->x10

        #%r257->x9

        #%r388->x9

        #%r131->x10

        #%r258->x9

        #%r191->x10

        #%r389->x9

        #%r132->x10

        #%r259->[sp,#0]

        #%r390->x9

        #%r133->x10

        #%r260->[sp,#8]

        #%r391->x10

        #%r134->x10

        #%r261->x9

        #%r219->x12

        #%r221->x9

        #%r224->x9

        #%r231->x9

        #%r253->x9

        #%r274->x9

        #%r275->x15

        #%r276->x10

        #%r277->x14

        #%r278->x13

        #%r279->x9

        #%r280->x10

        #%r282->x10

        #%r283->x9

        #%r284->x11

        #%r285->x9

        #%r288->x9

        #%r290->x9

        #%r291->x9

        #%r292->x9

        #%r293->x9

        #%r294->x9

        #%r295->x10

        #%r298->x9

        #%r300->x9

        #%r301->x10

        #%r302->x9

        #%r303->x10

        #%r305->x9

        #%r306->x9

        #%r437->x9

        #%r438->x9

        #%r439->x10

        #%r440->x9

        #%r441->x10

        #%r442->x9

        #%r443->x9

        #%r444->x9

        #%r445->x10

        #%r446->x9

        #%r447->x10

        #%r448->x9

        #%r449->x9

        #%r450->x9

        #%r451->x10

        #%r452->x9

        #%r453->x10

        #%r454->x9

        #%r455->x9

        #%r456->x9

        #%r457->x10

        #%r458->x9

        #%r459->x10

        #%r460->x9

        #%r461->x9

        #%r462->x9

        #%r463->x10

        #%r464->x9

        #%r465->x10

        #%r466->x9

        #%r467->x9

        #%r468->x9

        #%r469->x10

        #%r470->x9

        #%r471->x10

        #%r472->x9

        #%r473->x9

        #%r474->x9

        #%r475->x10

        #%r476->x9

        #%r477->x10

        #%r478->x9

        #%r479->x9

        #%r480->x9

        #%r481->x10

        #%r482->x9

        #%r483->x10

        #%r484->x9

        #%r485->x9

        #%r486->x9

        #%r487->x10

        #%r488->x9

        #%r489->x10

        #%r490->x9

        #%r491->x9

        #%r492->x9

        #%r493->x10

        #%r494->x9

        #%r495->x10

        #%r496->x9

        #%r497->x9

        #%r498->x9

        #%r499->x10

        #%r500->x9

        #%r501->x10

        #%r502->x9

        #%r503->x9

        #%r504->x9

        #%r505->x10

        #%r506->x9

        #%r507->x10

        #%r508->x9

        #%r509->x9

        #%r510->x9

        #%r511->x10

        #%r512->x9

        #%r513->x10

        #%r514->x9

        #%r515->x9

        #%r516->x9

        #%r517->x10

        #%r518->x9

        #%r519->x10

        #%r520->x9

        #%r521->x9

        #%r522->x9

        #%r523->x10

        #%r524->x9

        #%r525->x10

        #%r526->x9

        #%r527->x9

        #%r528->x9

        #%r529->x10

        #%r530->x9

        #%r531->x10

        #%r532->x9

        #%r533->x9

        #%r534->x9

        #%r535->x9

        #%r536->x9

        #%r537->x9

        #%r538->x9

        #%r539->x10

        #%r540->x9

        #%r541->x10

        #%r542->x9

        #%r543->x9

        #%r544->x9

        #%r545->x9

        #%r546->x10

        #%r547->x11

        #%r548->x10

        #%r549->x10

        #%r550->x11

        #%r551->x12

        #%r552->x11

        #%r553->x11

        #%r554->x9

        #%r555->x10

        #%r556->x11

        #%r557->x10

        #%r558->x10

        #%r559->x11

        #%r560->x12

        #%r561->x11

        #%r562->x11

        #%r563->x9

        #%r564->x11

        #%r565->x12

        #%r566->x11

        #%r567->x11

        #%r568->x11

        #%r569->x9

        #%r570->x10

        #%r571->x10

        #%r572->x11

        #%r573->x10

        #%r574->x10

        #%r575->x9

        #%r576->x9

        #%r577->x10

        #%r578->x9

        #%r579->x9

        #%r580->x9

        #%r581->x10

        #%r582->x9

        #%r583->x9

        #%r584->x9

        #%r585->x9

        #%r586->x10

        #%r587->x9

        #%r588->x9

        #%r589->x9

        #%r590->x10

        #%r591->x9

        #%r592->x9

        #%r593->x9

        #%r594->x9

        #%r595->x10

        #%r596->x9

        #%r597->x9

        #%r598->x9

        #%r599->x10

        #%r600->x9

        #%r601->x9

        #%r602->x10

        #%r603->x9

        #%r604->x10

        #%r605->x9

        #%r606->x9

        #%r607->x9

        #%r608->x10

        #%r609->x9

        #%r610->x10

        #%r611->x9

        #%r612->x9

        #%r613->x9

        #%r614->x10

        #%r615->x11

        #%r616->x10

        #%r617->x10

        #%r618->x9

        #%r619->x9
main:


        #153:x29,#-520

        #151:x29,#-260

        #152:x29,#-360

        #126:x29,#-160

        #105:x29,#-80

        #bb1:
bb1:


        #  %r251 = add i32 0, 0
        mov     x16, #552
        sub     sp, sp, x16
        mov     w9, #0

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

        #  %r252 = add i32 0, 0
        mov     w9, #0

        #  %r253 = add i32 0, 0
        mov     w9, #0

        #  %r254 = add i32 0, 0
        mov     w9, #0

        #  %r255 = add i32 0, 0
        mov     w9, #0

        #  %r256 = add i32 0, 0
        mov     w9, #0

        #  %r105 = alloca [ 20 x i32 ]

        #  %r106 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r106
        mov     w9, #1
        str     w9, [x10]

        #  %r107 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 1
        mov     x10, #1
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 2, i32* %r107
        mov     w9, #2
        str     w9, [x10]

        #  %r108 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 2
        mov     x10, #2
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 3, i32* %r108
        mov     w9, #3
        str     w9, [x10]

        #  %r109 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 3
        mov     x10, #3
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 4, i32* %r109
        mov     w9, #4
        str     w9, [x10]

        #  %r110 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 4
        mov     x10, #4
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 5, i32* %r110
        mov     w9, #5
        str     w9, [x10]

        #  %r111 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 5
        mov     x10, #5
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 6, i32* %r111
        mov     w9, #6
        str     w9, [x10]

        #  %r112 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 6
        mov     x10, #6
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 7, i32* %r112
        mov     w9, #7
        str     w9, [x10]

        #  %r113 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 7
        mov     x10, #7
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 8, i32* %r113
        mov     w9, #8
        str     w9, [x10]

        #  %r114 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 8
        mov     x10, #8
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 9, i32* %r114
        mov     w9, #9
        str     w9, [x10]

        #  %r115 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 9
        mov     x10, #9
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 0, i32* %r115
        mov     w9, #0
        str     w9, [x10]

        #  %r116 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 10
        mov     x10, #10
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r116
        mov     w9, #1
        str     w9, [x10]

        #  %r117 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 11
        mov     x10, #11
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 2, i32* %r117
        mov     w9, #2
        str     w9, [x10]

        #  %r118 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 12
        mov     x10, #12
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 3, i32* %r118
        mov     w9, #3
        str     w9, [x10]

        #  %r119 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 13
        mov     x10, #13
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 4, i32* %r119
        mov     w9, #4
        str     w9, [x10]

        #  %r120 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 14
        mov     x10, #14
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 5, i32* %r120
        mov     w9, #5
        str     w9, [x10]

        #  %r121 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 15
        mov     x10, #15
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 6, i32* %r121
        mov     w9, #6
        str     w9, [x10]

        #  %r122 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 16
        mov     x10, #16
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 7, i32* %r122
        mov     w9, #7
        str     w9, [x10]

        #  %r123 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 17
        mov     x10, #17
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 8, i32* %r123
        mov     w9, #8
        str     w9, [x10]

        #  %r124 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 18
        mov     x10, #18
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 9, i32* %r124
        mov     w9, #9
        str     w9, [x10]

        #  %r125 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 19
        mov     x10, #19
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 0, i32* %r125
        mov     w9, #0
        str     w9, [x10]

        #  %r126 = alloca [ 20 x i32 ]

        #  %r127 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 2, i32* %r127
        mov     w9, #2
        str     w9, [x10]

        #  %r128 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 1
        mov     x10, #1
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 3, i32* %r128
        mov     w9, #3
        str     w9, [x10]

        #  %r129 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 2
        mov     x10, #2
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 4, i32* %r129
        mov     w9, #4
        str     w9, [x10]

        #  %r130 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 3
        mov     x10, #3
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 2, i32* %r130
        mov     w9, #2
        str     w9, [x10]

        #  %r131 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 4
        mov     x10, #4
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 5, i32* %r131
        mov     w9, #5
        str     w9, [x10]

        #  %r132 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 5
        mov     x10, #5
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 7, i32* %r132
        mov     w9, #7
        str     w9, [x10]

        #  %r133 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 6
        mov     x10, #6
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 9, i32* %r133
        mov     w9, #9
        str     w9, [x10]

        #  %r134 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 7
        mov     x10, #7
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 9, i32* %r134
        mov     w9, #9
        str     w9, [x10]

        #  %r135 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 8
        mov     x10, #8
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 0, i32* %r135
        mov     w9, #0
        str     w9, [x10]

        #  %r136 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 9
        mov     x10, #9
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r136
        mov     w9, #1
        str     w9, [x10]

        #  %r137 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 10
        mov     x10, #10
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 9, i32* %r137
        mov     w9, #9
        str     w9, [x10]

        #  %r138 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 11
        mov     x10, #11
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 8, i32* %r138
        mov     w9, #8
        str     w9, [x10]

        #  %r139 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 12
        mov     x10, #12
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 7, i32* %r139
        mov     w9, #7
        str     w9, [x10]

        #  %r140 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 13
        mov     x10, #13
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 6, i32* %r140
        mov     w9, #6
        str     w9, [x10]

        #  %r141 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 14
        mov     x10, #14
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 4, i32* %r141
        mov     w9, #4
        str     w9, [x10]

        #  %r142 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 15
        mov     x10, #15
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 3, i32* %r142
        mov     w9, #3
        str     w9, [x10]

        #  %r143 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 16
        mov     x10, #16
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 2, i32* %r143
        mov     w9, #2
        str     w9, [x10]

        #  %r144 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 17
        mov     x10, #17
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r144
        mov     w9, #1
        str     w9, [x10]

        #  %r145 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 18
        mov     x10, #18
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 2, i32* %r145
        mov     w9, #2
        str     w9, [x10]

        #  %r146 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 19
        mov     x10, #19
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 2, i32* %r146
        mov     w9, #2
        str     w9, [x10]

        #  %r257 = add i32 0, 0
        mov     w9, #0

        #  %r259 = load i32, i32* @len
        adrp     x9, len
        add     x9, x9, #:lo12:len
        ldr     w16, [x9]
        mov     x17, #0
        str     x16, [sp,x17]

        #  %r258 = add i32 0, 0
        mov     w9, #0

        #  %r260 = load i32, i32* @len
        adrp     x9, len
        add     x9, x9, #:lo12:len
        ldr     w16, [x9]
        mov     x17, #8
        str     x16, [sp,x17]

        #  %r151 = alloca [ 25 x i32 ]

        #  %r152 = alloca [ 25 x i32 ]

        #  %r153 = alloca [ 40 x i32 ]

        #  %r154 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 0, i32* %r154
        mov     w9, #0
        str     w9, [x10]

        #  %r261 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb2


        #bb2:  %r262 = phi i32 [ %r261, %bb1 ], [ %r287, %bb3 ]
        mov     w9, w9
        b     bb2

        #bb2:
bb2:


        #  %r262 = phi i32 [ %r261, %bb1 ], [ %r287, %bb3 ]

        #  %r157 = icmp slt i32 %r262, %r259
        mov     x16, #0
        ldr     x19, [sp,x16]
        cmp     w9, w19

        #  br i1 %r157, label %bb3, label %bb4

        b.lt     bb3
        b     bb4

        #bb3:
bb3:


        #  %r159 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0, i32 %r262
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r160 = load i32, i32* %r159
        ldr     w10, [x10]

        #  %r162 = getelementptr [25 x i32 ], [25 x i32 ]* %r151, i32 0, i32 %r262
        mov     x11, #4
        mul     x12, x9, x11
        mov     x11, #-260
        add     x11, x29, x11
        add     x11, x11, x12

        #  store i32 %r160, i32* %r162
        str     w10, [x11]

        #  %r287 = add i32 %r262, 1
        add     w9, w9, #1

        #  br label %bb2


        #bb2:  %r262 = phi i32 [ %r261, %bb1 ], [ %r287, %bb3 ]
        mov     w9, w9
        b     bb2

        #bb4:
bb4:


        #  %r263 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb5


        #bb5:  %r264 = phi i32 [ %r263, %bb4 ], [ %r286, %bb6 ]
        mov     w9, w9
        b     bb5

        #bb5:
bb5:


        #  %r264 = phi i32 [ %r263, %bb4 ], [ %r286, %bb6 ]

        #  %r167 = icmp slt i32 %r264, %r260
        mov     x16, #8
        ldr     x19, [sp,x16]
        cmp     w9, w19

        #  br i1 %r167, label %bb6, label %bb7

        b.lt     bb6
        b     bb7

        #bb6:
bb6:


        #  %r169 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0, i32 %r264
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-160
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r170 = load i32, i32* %r169
        ldr     w10, [x10]

        #  %r172 = getelementptr [25 x i32 ], [25 x i32 ]* %r152, i32 0, i32 %r264
        mov     x11, #4
        mul     x12, x9, x11
        mov     x11, #-360
        add     x11, x29, x11
        add     x11, x11, x12

        #  store i32 %r170, i32* %r172
        str     w10, [x11]

        #  %r286 = add i32 %r264, 1
        add     w9, w9, #1

        #  br label %bb5


        #bb5:  %r264 = phi i32 [ %r263, %bb4 ], [ %r286, %bb6 ]
        mov     w9, w9
        b     bb5

        #bb7:
bb7:


        #  %r177 = add i32 %r259, %r260
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, #8
        ldr     x18, [sp,x16]
        add     w9, w19, w18

        #  %r265 = sub i32 %r177, 1
        sub     w10, w9, #1

        #  %r266 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb8


        #bb8:  %r267 = phi i32 [ %r266, %bb7 ], [ %r285, %bb9 ]
        mov     w9, w9
        b     bb8

        #bb8:
bb8:


        #  %r267 = phi i32 [ %r266, %bb7 ], [ %r285, %bb9 ]

        #  %r181 = icmp sle i32 %r267, %r265
        cmp     w9, w10

        #  br i1 %r181, label %bb9, label %bb10

        b.le     bb9
        b     bb10

        #bb9:
bb9:


        #  %r183 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 %r267
        mov     x11, #4
        mul     x12, x9, x11
        mov     x11, #-520
        add     x11, x29, x11
        add     x12, x11, x12

        #  store i32 0, i32* %r183
        mov     w11, #0
        str     w11, [x12]

        #  %r285 = add i32 %r267, 1
        add     w9, w9, #1

        #  br label %bb8


        #bb8:  %r267 = phi i32 [ %r266, %bb7 ], [ %r285, %bb9 ]
        mov     w9, w9
        b     bb8

        #bb10:
bb10:


        #  %r268 = add i32 0, 0
        mov     w9, #0

        #  %r269 = sub i32 %r260, 1
        mov     x16, #8
        ldr     x19, [sp,x16]
        sub     w11, w19, #1

        #  br label %bb11


        #bb11:  %r270 = phi i32 [ %r265, %bb10 ], [ %r279, %bb16 ]
        mov     w9, w10

        #bb11:  %r271 = phi i32 [ %r269, %bb10 ], [ %r280, %bb16 ]
        mov     w16, w11
        mov     x17, #16
        str     x16, [sp,x17]
        b     bb11

        #bb11:
bb11:


        #  %r270 = phi i32 [ %r265, %bb10 ], [ %r279, %bb16 ]

        #  %r271 = phi i32 [ %r269, %bb10 ], [ %r280, %bb16 ]

        #  %r189 = icmp sgt i32 %r271, -1
        mov     w10, #-1
        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     w19, w10

        #  br i1 %r189, label %bb12, label %bb13

        b.gt     bb12
        b     bb13

        #bb12:
bb12:


        #  %r191 = getelementptr [25 x i32 ], [25 x i32 ]* %r152, i32 0, i32 %r271
        mov     x10, #4
        mov     x16, #16
        ldr     x19, [sp,x16]
        mul     x11, x19, x10
        mov     x10, #-360
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r275 = load i32, i32* %r191
        ldr     w15, [x10]

        #  %r276 = sub i32 %r259, 1
        mov     x16, #0
        ldr     x19, [sp,x16]
        sub     w10, w19, #1

        #  br label %bb14


        #bb14:  %r277 = phi i32 [ %r270, %bb12 ], [ %r283, %bb19 ]
        mov     w14, w9

        #bb14:  %r278 = phi i32 [ %r276, %bb12 ], [ %r282, %bb19 ]
        mov     w13, w10
        b     bb14

        #bb14:
bb14:


        #  %r277 = phi i32 [ %r270, %bb12 ], [ %r283, %bb19 ]

        #  %r278 = phi i32 [ %r276, %bb12 ], [ %r282, %bb19 ]

        #  %r196 = icmp sgt i32 %r278, -1
        mov     w9, #-1
        cmp     w13, w9

        #  br i1 %r196, label %bb15, label %bb16

        b.gt     bb15
        b     bb16

        #bb15:
bb15:


        #  %r198 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 %r277
        mov     x9, #4
        mul     x10, x14, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r199 = load i32, i32* %r198
        ldr     w11, [x9]

        #  %r202 = getelementptr [25 x i32 ], [25 x i32 ]* %r151, i32 0, i32 %r278
        mov     x9, #4
        mul     x10, x13, x9
        mov     x9, #-260
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r203 = load i32, i32* %r202
        ldr     w9, [x9]

        #  %r204 = mul i32 %r275, %r203
        mul     w9, w15, w9

        #  %r281 = add i32 %r199, %r204
        add     w12, w11, w9

        #  %r207 = icmp sge i32 %r281, 10
        mov     w9, #10
        cmp     w12, w9

        #  br i1 %r207, label %bb17, label %bb18

        b.ge     bb17
        b     bb18

        #bb17:
bb17:


        #  %r210 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 %r277
        mov     x9, #4
        mul     x10, x14, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10

        #  store i32 %r281, i32* %r210
        str     w12, [x9]

        #  %r284 = sub i32 %r277, 1
        sub     w11, w14, #1

        #  %r215 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 %r284
        mov     x9, #4
        mul     x10, x11, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r216 = load i32, i32* %r215
        ldr     w10, [x9]

        #  %r218 = sdiv i32 %r281, 10
        mov     w9, #10
        sdiv     w9, w12, w9

        #  %r219 = add i32 %r216, %r218
        add     w12, w10, w9

        #  %r221 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 %r284
        mov     x9, #4
        mul     x10, x11, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10

        #  store i32 %r219, i32* %r221
        str     w12, [x9]

        #  br label %bb19

        b     bb19

        #bb18:
bb18:


        #  %r224 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 %r277
        mov     x9, #4
        mul     x10, x14, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10

        #  store i32 %r281, i32* %r224
        str     w12, [x9]

        #  br label %bb19

        b     bb19

        #bb19:
bb19:


        #  %r282 = sub i32 %r278, 1
        sub     w10, w13, #1

        #  %r283 = sub i32 %r277, 1
        sub     w9, w14, #1

        #  br label %bb14


        #bb14:  %r277 = phi i32 [ %r270, %bb12 ], [ %r283, %bb19 ]
        mov     w14, w9

        #bb14:  %r278 = phi i32 [ %r276, %bb12 ], [ %r282, %bb19 ]
        mov     w13, w10
        b     bb14

        #bb16:
bb16:


        #  %r231 = add i32 %r277, %r259
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     w9, w14, w19

        #  %r279 = sub i32 %r231, 1
        sub     w9, w9, #1

        #  %r280 = sub i32 %r271, 1
        mov     x16, #16
        ldr     x19, [sp,x16]
        sub     w10, w19, #1

        #  br label %bb11


        #bb11:  %r270 = phi i32 [ %r265, %bb10 ], [ %r279, %bb16 ]
        mov     w9, w9

        #bb11:  %r271 = phi i32 [ %r269, %bb10 ], [ %r280, %bb16 ]
        mov     w16, w10
        mov     x17, #16
        str     x16, [sp,x17]
        b     bb11

        #bb13:
bb13:


        #  %r235 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r236 = load i32, i32* %r235
        ldr     w10, [x9]

        #  %r237 = icmp ne i32 %r236, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r237, label %bb20, label %bb21

        b.ne     bb20
        b     bb21

        #bb20:
bb20:


        #  %r238 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r239 = load i32, i32* %r238
        ldr     w9, [x9]

        #  call void @putint(i32 %r239)
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

        #  br label %bb22

        b     bb22

        #bb21:
bb21:


        #  br label %bb22

        b     bb22

        #bb22:
bb22:


        #  %r272 = add i32 1, 0
        mov     w9, #1
        mov     w9, w9

        #  br label %bb23


        #bb23:  %r273 = phi i32 [ %r272, %bb22 ], [ %r274, %bb24 ]
        mov     w9, w9
        b     bb23

        #bb23:
bb23:


        #  %r273 = phi i32 [ %r272, %bb22 ], [ %r274, %bb24 ]

        #  %r243 = add i32 %r259, %r260
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, #8
        ldr     x18, [sp,x16]
        add     w10, w19, w18

        #  %r244 = sub i32 %r243, 1
        sub     w10, w10, #1

        #  %r245 = icmp sle i32 %r273, %r244
        cmp     w9, w10

        #  br i1 %r245, label %bb24, label %bb25

        b.le     bb24
        b     bb25

        #bb24:
bb24:


        #  %r247 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0, i32 %r273
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-520
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r248 = load i32, i32* %r247
        ldr     w10, [x10]

        #  call void @putint(i32 %r248)
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

        #  %r274 = add i32 %r273, 1
        add     w9, w9, #1

        #  br label %bb23


        #bb23:  %r273 = phi i32 [ %r272, %bb22 ], [ %r274, %bb24 ]
        mov     w9, w9
        b     bb23

        #bb25:
bb25:


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
