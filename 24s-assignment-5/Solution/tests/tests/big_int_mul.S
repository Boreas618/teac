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
        //%r436->x9
        //%r435->x10
        //%r433->x9
        //%r432->x9
        //%r431->x10
        //%r430->x9
        //%r428->x9
        //%r425->x10
        //%r424->x9
        //%r423->x10
        //%r422->x9
        //%r421->x9
        //%r420->x9
        //%r418->x9
        //%r415->x9
        //%r414->x9
        //%r413->x10
        //%r412->x9
        //%r410->x9
        //%r409->x9
        //%r408->x9
        //%r407->x10
        //%r406->x9
        //%r405->x10
        //%r404->x9
        //%r383->x10
        //%r362->x9
        //%r361->x9
        //%r360->x9
        //%r359->x10
        //%r358->x9
        //%r357->x10
        //%r356->x9
        //%r355->x9
        //%r354->x9
        //%r353->x10
        //%r352->x9
        //%r351->x10
        //%r350->x9
        //%r349->x9
        //%r348->x9
        //%r347->x10
        //%r346->x9
        //%r345->x10
        //%r344->x9
        //%r343->x9
        //%r342->x9
        //%r341->x10
        //%r340->x9
        //%r339->x10
        //%r338->x9
        //%r337->x9
        //%r336->x9
        //%r335->x10
        //%r334->x9
        //%r333->x10
        //%r332->x9
        //%r331->x9
        //%r330->x9
        //%r329->x10
        //%r328->x9
        //%r327->x10
        //%r326->x9
        //%r325->x9
        //%r324->x9
        //%r323->x10
        //%r322->x9
        //%r321->x10
        //%r320->x9
        //%r319->x9
        //%r318->x9
        //%r317->x10
        //%r316->x9
        //%r315->x10
        //%r314->x9
        //%r313->x9
        //%r312->x9
        //%r311->x10
        //%r310->x9
        //%r309->x10
        //%r308->x9
        //%r307->x9
        //%r217->x9
        //%r212->x9
        //%r206->x9
        //%r419->x10
        //%r162->x11
        //%r289->x9
        //%r417->x10
        //%r160->x10
        //%r287->x9
        //%r416->x9
        //%r159->x10
        //%r286->x11
        //%r411->x10
        //%r154->x10
        //%r281->x9
        //%r205->x9
        //%r403->x9
        //%r146->x10
        //%r273->[sp,#16]
        //%r204->x9
        //%r402->x9
        //%r145->x10
        //%r272->x9
        //%r401->x10
        //%r144->x10
        //%r271->x11
        //%r400->x9
        //%r143->x10
        //%r270->x9
        //%r201->x11
        //%r399->x10
        //%r142->x10
        //%r269->x9
        //%r200->x9
        //%r398->x9
        //%r141->x10
        //%r268->x9
        //%r397->x9
        //%r140->x10
        //%r267->x10
        //%r396->x9
        //%r139->x10
        //%r266->x9
        //%r197->x9
        //%r395->x10
        //%r138->x10
        //%r265->x9
        //%r394->x9
        //%r137->x10
        //%r264->x9
        //%r393->x10
        //%r136->x10
        //%r263->x9
        //%r434->x9
        //%r177->x9
        //%r304->x9
        //%r375->x10
        //%r118->x10
        //%r245->x10
        //%r374->x9
        //%r117->x10
        //%r373->x9
        //%r116->x10
        //%r372->x9
        //%r115->x10
        //%r371->x10
        //%r114->x10
        //%r241->x9
        //%r429->x10
        //%r172->x11
        //%r299->x10
        //%r370->x9
        //%r113->x10
        //%r240->x9
        //%r369->x10
        //%r112->x10
        //%r427->x9
        //%r170->x10
        //%r297->x10
        //%r368->x9
        //%r111->x10
        //%r238->x10
        //%r426->x9
        //%r169->x10
        //%r296->x9
        //%r367->x9
        //%r110->x10
        //%r237->x9
        //%r366->x9
        //%r109->x10
        //%r365->x10
        //%r108->x10
        //%r364->x9
        //%r107->x10
        //%r363->x10
        //%r106->x10
        //%r233->x9
        //%r392->x9
        //%r135->x10
        //%r262->[sp,#8]
        //%r376->x9
        //%r119->x10
        //%r246->x10
        //%r377->x10
        //%r120->x10
        //%r378->x9
        //%r121->x10
        //%r379->x9
        //%r122->x10
        //%r249->x10
        //%r380->x9
        //%r123->x10
        //%r250->x10
        //%r183->x12
        //%r381->x10
        //%r124->x10
        //%r382->x9
        //%r125->x10
        //%r384->x9
        //%r127->x10
        //%r254->x9
        //%r385->x9
        //%r128->x10
        //%r255->x9
        //%r386->x9
        //%r129->x10
        //%r256->x9
        //%r189->x10
        //%r387->x10
        //%r130->x10
        //%r257->x9
        //%r388->x9
        //%r131->x10
        //%r258->x9
        //%r389->x10
        //%r132->x10
        //%r259->x9
        //%r192->x10
        //%r390->x9
        //%r133->x10
        //%r260->x9
        //%r391->x9
        //%r134->x10
        //%r261->[sp,#0]
        //%r218->x10
        //%r220->x9
        //%r221->x12
        //%r223->x9
        //%r226->x9
        //%r253->x9
        //%r274->x9
        //%r275->x9
        //%r276->x9
        //%r277->x15
        //%r278->x10
        //%r279->x14
        //%r280->x13
        //%r282->x10
        //%r283->x12
        //%r284->x10
        //%r285->x9
        //%r288->x9
        //%r290->x9
        //%r291->x9
        //%r292->x9
        //%r293->x9
        //%r294->x9
        //%r295->x9
        //%r298->x9
        //%r300->x9
        //%r301->x9
        //%r302->x9
        //%r303->x10
        //%r305->x10
        //%r306->x9
        //%r437->x10
        //%r438->x9
        //%r439->x9
        //%r440->x9
        //%r441->x10
        //%r442->x9
        //%r443->x10
        //%r444->x9
        //%r445->x9
        //%r446->x9
        //%r447->x10
        //%r448->x9
        //%r449->x10
        //%r450->x9
        //%r451->x9
        //%r452->x9
        //%r453->x10
        //%r454->x9
        //%r455->x10
        //%r456->x9
        //%r457->x9
        //%r458->x9
        //%r459->x10
        //%r460->x9
        //%r461->x10
        //%r462->x9
        //%r463->x9
        //%r464->x9
        //%r465->x10
        //%r466->x9
        //%r467->x10
        //%r468->x9
        //%r469->x9
        //%r470->x9
        //%r471->x10
        //%r472->x9
        //%r473->x10
        //%r474->x9
        //%r475->x9
        //%r476->x9
        //%r477->x10
        //%r478->x9
        //%r479->x10
        //%r480->x9
        //%r481->x9
        //%r482->x9
        //%r483->x10
        //%r484->x9
        //%r485->x10
        //%r486->x9
        //%r487->x9
        //%r488->x9
        //%r489->x10
        //%r490->x9
        //%r491->x10
        //%r492->x9
        //%r493->x9
        //%r494->x9
        //%r495->x10
        //%r496->x9
        //%r497->x10
        //%r498->x9
        //%r499->x9
        //%r500->x9
        //%r501->x10
        //%r502->x9
        //%r503->x10
        //%r504->x9
        //%r505->x9
        //%r506->x9
        //%r507->x10
        //%r508->x9
        //%r509->x10
        //%r510->x9
        //%r511->x9
        //%r512->x9
        //%r513->x10
        //%r514->x9
        //%r515->x10
        //%r516->x9
        //%r517->x9
        //%r518->x9
        //%r519->x10
        //%r520->x9
        //%r521->x10
        //%r522->x9
        //%r523->x9
        //%r524->x9
        //%r525->x10
        //%r526->x9
        //%r527->x10
        //%r528->x9
        //%r529->x9
        //%r530->x9
        //%r531->x10
        //%r532->x9
        //%r533->x10
        //%r534->x9
        //%r535->x9
        //%r536->x9
        //%r537->x9
        //%r538->x9
        //%r539->x9
        //%r540->x9
        //%r541->x10
        //%r542->x9
        //%r543->x10
        //%r544->x9
        //%r545->x9
        //%r546->x9
        //%r547->x9
        //%r548->x10
        //%r549->x11
        //%r550->x10
        //%r551->x10
        //%r552->x11
        //%r553->x12
        //%r554->x11
        //%r555->x11
        //%r556->x9
        //%r557->x10
        //%r558->x11
        //%r559->x10
        //%r560->x10
        //%r561->x11
        //%r562->x12
        //%r563->x11
        //%r564->x11
        //%r565->x9
        //%r566->x11
        //%r567->x12
        //%r568->x11
        //%r569->x11
        //%r570->x11
        //%r571->x9
        //%r572->x10
        //%r573->x10
        //%r574->x11
        //%r575->x10
        //%r576->x10
        //%r577->x9
        //%r578->x9
        //%r579->x10
        //%r580->x9
        //%r581->x9
        //%r582->x9
        //%r583->x10
        //%r584->x9
        //%r585->x9
        //%r586->x9
        //%r587->x9
        //%r588->x10
        //%r589->x9
        //%r590->x9
        //%r591->x9
        //%r592->x10
        //%r593->x9
        //%r594->x9
        //%r595->x9
        //%r596->x9
        //%r597->x10
        //%r598->x9
        //%r599->x9
        //%r600->x9
        //%r601->x10
        //%r602->x9
        //%r603->x9
        //%r604->x10
        //%r605->x9
        //%r606->x10
        //%r607->x9
        //%r608->x9
        //%r609->x9
        //%r610->x10
        //%r611->x9
        //%r612->x10
        //%r613->x9
        //%r614->x9
        //%r615->x9
        //%r616->x10
        //%r617->x11
        //%r618->x10
        //%r619->x10
        //%r620->x9
        //%r621->x9
main:

        //153:x29,#-1040

        //151:x29,#-520

        //152:x29,#-720

        //126:x29,#-320

        //105:x29,#-160

        //bb1:

bb1:

        //  %r253 = add i32 0, 0

        mov     x16, #1064
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
        //  %r254 = add i32 0, 0

        mov     x9, #0
        //  %r255 = add i32 0, 0

        mov     x9, #0
        //  %r256 = add i32 0, 0

        mov     x9, #0
        //  %r257 = add i32 0, 0

        mov     x9, #0
        //  %r258 = add i32 0, 0

        mov     x9, #0
        //  %r105 = alloca [ 20 x i32 ]

        //  %r106 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r106

        mov     x9, #1
        str     x9, [x10]
        //  %r107 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r107

        mov     x9, #2
        str     x9, [x10]
        //  %r108 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r108

        mov     x9, #3
        str     x9, [x10]
        //  %r109 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 4, i32* %r109

        mov     x9, #4
        str     x9, [x10]
        //  %r110 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 5, i32* %r110

        mov     x9, #5
        str     x9, [x10]
        //  %r111 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 5

        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 6, i32* %r111

        mov     x9, #6
        str     x9, [x10]
        //  %r112 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 6

        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r112

        mov     x9, #7
        str     x9, [x10]
        //  %r113 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 8, i32* %r113

        mov     x9, #8
        str     x9, [x10]
        //  %r114 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 8

        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 9, i32* %r114

        mov     x9, #9
        str     x9, [x10]
        //  %r115 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 9

        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r115

        mov     x9, #0
        str     x9, [x10]
        //  %r116 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 10

        mov     x10, #10
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r116

        mov     x9, #1
        str     x9, [x10]
        //  %r117 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 11

        mov     x10, #11
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r117

        mov     x9, #2
        str     x9, [x10]
        //  %r118 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 12

        mov     x10, #12
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r118

        mov     x9, #3
        str     x9, [x10]
        //  %r119 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 13

        mov     x10, #13
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 4, i32* %r119

        mov     x9, #4
        str     x9, [x10]
        //  %r120 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 14

        mov     x10, #14
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 5, i32* %r120

        mov     x9, #5
        str     x9, [x10]
        //  %r121 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 15

        mov     x10, #15
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 6, i32* %r121

        mov     x9, #6
        str     x9, [x10]
        //  %r122 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 16

        mov     x10, #16
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r122

        mov     x9, #7
        str     x9, [x10]
        //  %r123 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 17

        mov     x10, #17
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 8, i32* %r123

        mov     x9, #8
        str     x9, [x10]
        //  %r124 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 18

        mov     x10, #18
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 9, i32* %r124

        mov     x9, #9
        str     x9, [x10]
        //  %r125 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 19

        mov     x10, #19
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r125

        mov     x9, #0
        str     x9, [x10]
        //  %r126 = alloca [ 20 x i32 ]

        //  %r127 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r127

        mov     x9, #2
        str     x9, [x10]
        //  %r128 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r128

        mov     x9, #3
        str     x9, [x10]
        //  %r129 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 4, i32* %r129

        mov     x9, #4
        str     x9, [x10]
        //  %r130 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r130

        mov     x9, #2
        str     x9, [x10]
        //  %r131 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 5, i32* %r131

        mov     x9, #5
        str     x9, [x10]
        //  %r132 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 5

        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r132

        mov     x9, #7
        str     x9, [x10]
        //  %r133 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 6

        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 9, i32* %r133

        mov     x9, #9
        str     x9, [x10]
        //  %r134 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 9, i32* %r134

        mov     x9, #9
        str     x9, [x10]
        //  %r135 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 8

        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r135

        mov     x9, #0
        str     x9, [x10]
        //  %r136 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 9

        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r136

        mov     x9, #1
        str     x9, [x10]
        //  %r137 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 10

        mov     x10, #10
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 9, i32* %r137

        mov     x9, #9
        str     x9, [x10]
        //  %r138 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 11

        mov     x10, #11
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 8, i32* %r138

        mov     x9, #8
        str     x9, [x10]
        //  %r139 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 12

        mov     x10, #12
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r139

        mov     x9, #7
        str     x9, [x10]
        //  %r140 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 13

        mov     x10, #13
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 6, i32* %r140

        mov     x9, #6
        str     x9, [x10]
        //  %r141 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 14

        mov     x10, #14
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 4, i32* %r141

        mov     x9, #4
        str     x9, [x10]
        //  %r142 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 15

        mov     x10, #15
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r142

        mov     x9, #3
        str     x9, [x10]
        //  %r143 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 16

        mov     x10, #16
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r143

        mov     x9, #2
        str     x9, [x10]
        //  %r144 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 17

        mov     x10, #17
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r144

        mov     x9, #1
        str     x9, [x10]
        //  %r145 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 18

        mov     x10, #18
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r145

        mov     x9, #2
        str     x9, [x10]
        //  %r146 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 19

        mov     x10, #19
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-320
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r146

        mov     x9, #2
        str     x9, [x10]
        //  %r259 = add i32 0, 0

        mov     x9, #0
        //  %r261 = load i32, i32* @len

        adrp     x9, len
        add     x9, x9, #:lo12:len
        ldr     x16, [x9]
        mov     x17, #0
        str     x16, [sp,x17]
        //  %r260 = add i32 0, 0

        mov     x9, #0
        //  %r262 = load i32, i32* @len

        adrp     x9, len
        add     x9, x9, #:lo12:len
        ldr     x16, [x9]
        mov     x17, #8
        str     x16, [sp,x17]
        //  %r151 = alloca [ 25 x i32 ]

        //  %r152 = alloca [ 25 x i32 ]

        //  %r153 = alloca [ 40 x i32 ]

        //  %r154 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r154

        mov     x9, #0
        str     x9, [x10]
        //  %r263 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r264 = phi i32 [ %r263, %bb1 ], [ %r289, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb2:

bb2:

        //  %r264 = phi i32 [ %r263, %bb1 ], [ %r289, %bb3 ]

        //  %r157 = icmp slt i32 %r264, %r261

        mov     x16, #0
        ldr     x19, [sp,x16]
        cmp     x9, x19
        //  br i1 %r157, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r159 = getelementptr [20 x i32 ], [20 x i32 ]* %r105, i32 0 , i32 %r264

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-160
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r160 = load i32, i32* %r159

        ldr     x10, [x10]
        //  %r162 = getelementptr [25 x i32 ], [25 x i32 ]* %r151, i32 0 , i32 %r264

        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-520
        add     x11, x29, x11
        add     x11, x11, x12
        //  store i32 %r160, i32* %r162

        str     x10, [x11]
        //  %r289 = add i32 %r264, 1

        add     x9, x9, #1
        //  br label %bb2


        //bb2:  %r264 = phi i32 [ %r263, %bb1 ], [ %r289, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb4:

bb4:

        //  %r265 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb5


        //bb5:  %r266 = phi i32 [ %r265, %bb4 ], [ %r288, %bb6 ]

        mov     x9, x9
        b     bb5
        //bb5:

bb5:

        //  %r266 = phi i32 [ %r265, %bb4 ], [ %r288, %bb6 ]

        //  %r167 = icmp slt i32 %r266, %r262

        mov     x16, #8
        ldr     x19, [sp,x16]
        cmp     x9, x19
        //  br i1 %r167, label %bb6, label %bb7


        b.lt     bb6
        b     bb7
        //bb6:

bb6:

        //  %r169 = getelementptr [20 x i32 ], [20 x i32 ]* %r126, i32 0 , i32 %r266

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-320
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r170 = load i32, i32* %r169

        ldr     x10, [x10]
        //  %r172 = getelementptr [25 x i32 ], [25 x i32 ]* %r152, i32 0 , i32 %r266

        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-720
        add     x11, x29, x11
        add     x11, x11, x12
        //  store i32 %r170, i32* %r172

        str     x10, [x11]
        //  %r288 = add i32 %r266, 1

        add     x9, x9, #1
        //  br label %bb5


        //bb5:  %r266 = phi i32 [ %r265, %bb4 ], [ %r288, %bb6 ]

        mov     x9, x9
        b     bb5
        //bb7:

bb7:

        //  %r177 = add i32 %r261, %r262

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, #8
        ldr     x18, [sp,x16]
        add     x9, x19, x18
        //  %r267 = sub i32 %r177, 1

        sub     x10, x9, #1
        //  %r268 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb8


        //bb8:  %r269 = phi i32 [ %r268, %bb7 ], [ %r287, %bb9 ]

        mov     x9, x9
        b     bb8
        //bb8:

bb8:

        //  %r269 = phi i32 [ %r268, %bb7 ], [ %r287, %bb9 ]

        //  %r181 = icmp sle i32 %r269, %r267

        cmp     x9, x10
        //  br i1 %r181, label %bb9, label %bb10


        b.le     bb9
        b     bb10
        //bb9:

bb9:

        //  %r183 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 %r269

        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-1040
        add     x11, x29, x11
        add     x12, x11, x12
        //  store i32 0, i32* %r183

        mov     x11, #0
        str     x11, [x12]
        //  %r287 = add i32 %r269, 1

        add     x9, x9, #1
        //  br label %bb8


        //bb8:  %r269 = phi i32 [ %r268, %bb7 ], [ %r287, %bb9 ]

        mov     x9, x9
        b     bb8
        //bb10:

bb10:

        //  %r270 = add i32 0, 0

        mov     x9, #0
        //  %r271 = sub i32 %r262, 1

        mov     x16, #8
        ldr     x19, [sp,x16]
        sub     x11, x19, #1
        //  br label %bb11


        //bb11:  %r272 = phi i32 [ %r267, %bb10 ], [ %r281, %bb16 ]

        mov     x9, x10
        //bb11:  %r273 = phi i32 [ %r271, %bb10 ], [ %r282, %bb16 ]

        mov     x16, x11
        mov     x17, #16
        str     x16, [sp,x17]
        b     bb11
        //bb11:

bb11:

        //  %r272 = phi i32 [ %r267, %bb10 ], [ %r281, %bb16 ]

        //  %r273 = phi i32 [ %r271, %bb10 ], [ %r282, %bb16 ]

        //  %r189 = sub i32 0, 1

        mov     x10, #0
        sub     x10, x10, #1
        //  %r190 = icmp sgt i32 %r273, %r189

        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     x19, x10
        //  br i1 %r190, label %bb12, label %bb13


        b.gt     bb12
        b     bb13
        //bb12:

bb12:

        //  %r192 = getelementptr [25 x i32 ], [25 x i32 ]* %r152, i32 0 , i32 %r273

        mov     x10, #8
        mov     x16, #16
        ldr     x19, [sp,x16]
        mul     x11, x19, x10
        mov     x10, #-720
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r277 = load i32, i32* %r192

        ldr     x15, [x10]
        //  %r278 = sub i32 %r261, 1

        mov     x16, #0
        ldr     x19, [sp,x16]
        sub     x10, x19, #1
        //  br label %bb14


        //bb14:  %r279 = phi i32 [ %r272, %bb12 ], [ %r285, %bb19 ]

        mov     x14, x9
        //bb14:  %r280 = phi i32 [ %r278, %bb12 ], [ %r284, %bb19 ]

        mov     x13, x10
        b     bb14
        //bb14:

bb14:

        //  %r279 = phi i32 [ %r272, %bb12 ], [ %r285, %bb19 ]

        //  %r280 = phi i32 [ %r278, %bb12 ], [ %r284, %bb19 ]

        //  %r197 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  %r198 = icmp sgt i32 %r280, %r197

        cmp     x13, x9
        //  br i1 %r198, label %bb15, label %bb16


        b.gt     bb15
        b     bb16
        //bb15:

bb15:

        //  %r200 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 %r279

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r201 = load i32, i32* %r200

        ldr     x11, [x9]
        //  %r204 = getelementptr [25 x i32 ], [25 x i32 ]* %r151, i32 0 , i32 %r280

        mov     x9, #8
        mul     x10, x13, x9
        mov     x9, #-520
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r205 = load i32, i32* %r204

        ldr     x9, [x9]
        //  %r206 = mul i32 %r277, %r205

        mul     x9, x15, x9
        //  %r283 = add i32 %r201, %r206

        add     x12, x11, x9
        //  %r209 = icmp sge i32 %r283, 10

        mov     x9, #10
        cmp     x12, x9
        //  br i1 %r209, label %bb17, label %bb18


        b.ge     bb17
        b     bb18
        //bb17:

bb17:

        //  %r212 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 %r279

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r283, i32* %r212

        str     x12, [x9]
        //  %r286 = sub i32 %r279, 1

        sub     x11, x14, #1
        //  %r217 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 %r286

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r218 = load i32, i32* %r217

        ldr     x10, [x9]
        //  %r220 = sdiv i32 %r283, 10

        mov     x9, #10
        sdiv     x9, x12, x9
        //  %r221 = add i32 %r218, %r220

        add     x12, x10, x9
        //  %r223 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 %r286

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r221, i32* %r223

        str     x12, [x9]
        //  br label %bb19


        b     bb19
        //bb18:

bb18:

        //  %r226 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 %r279

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r283, i32* %r226

        str     x12, [x9]
        //  br label %bb19


        b     bb19
        //bb19:

bb19:

        //  %r284 = sub i32 %r280, 1

        sub     x10, x13, #1
        //  %r285 = sub i32 %r279, 1

        sub     x9, x14, #1
        //  br label %bb14


        //bb14:  %r279 = phi i32 [ %r272, %bb12 ], [ %r285, %bb19 ]

        mov     x14, x9
        //bb14:  %r280 = phi i32 [ %r278, %bb12 ], [ %r284, %bb19 ]

        mov     x13, x10
        b     bb14
        //bb16:

bb16:

        //  %r233 = add i32 %r279, %r261

        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x14, x19
        //  %r281 = sub i32 %r233, 1

        sub     x9, x9, #1
        //  %r282 = sub i32 %r273, 1

        mov     x16, #16
        ldr     x19, [sp,x16]
        sub     x10, x19, #1
        //  br label %bb11


        //bb11:  %r272 = phi i32 [ %r267, %bb10 ], [ %r281, %bb16 ]

        mov     x9, x9
        //bb11:  %r273 = phi i32 [ %r271, %bb10 ], [ %r282, %bb16 ]

        mov     x16, x10
        mov     x17, #16
        str     x16, [sp,x17]
        b     bb11
        //bb13:

bb13:

        //  %r237 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r238 = load i32, i32* %r237

        ldr     x10, [x9]
        //  %r239 = icmp ne i32 %r238, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r239, label %bb20, label %bb21


        b.ne     bb20
        b     bb21
        //bb20:

bb20:

        //  %r240 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-1040
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r241 = load i32, i32* %r240

        ldr     x9, [x9]
        //  call void @putint(i32 %r241)

        mov     x0, x9
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
        //  br label %bb22


        b     bb22
        //bb21:

bb21:

        //  br label %bb22


        b     bb22
        //bb22:

bb22:

        //  %r274 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb23


        //bb23:  %r275 = phi i32 [ %r274, %bb22 ], [ %r276, %bb24 ]

        mov     x9, x9
        b     bb23
        //bb23:

bb23:

        //  %r275 = phi i32 [ %r274, %bb22 ], [ %r276, %bb24 ]

        //  %r245 = add i32 %r261, %r262

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x16, #8
        ldr     x18, [sp,x16]
        add     x10, x19, x18
        //  %r246 = sub i32 %r245, 1

        sub     x10, x10, #1
        //  %r247 = icmp sle i32 %r275, %r246

        cmp     x9, x10
        //  br i1 %r247, label %bb24, label %bb25


        b.le     bb24
        b     bb25
        //bb24:

bb24:

        //  %r249 = getelementptr [40 x i32 ], [40 x i32 ]* %r153, i32 0 , i32 %r275

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-1040
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r250 = load i32, i32* %r249

        ldr     x10, [x10]
        //  call void @putint(i32 %r250)

        mov     x0, x10
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
        //  %r276 = add i32 %r275, 1

        add     x9, x9, #1
        //  br label %bb23


        //bb23:  %r275 = phi i32 [ %r274, %bb22 ], [ %r276, %bb24 ]

        mov     x9, x9
        b     bb23
        //bb25:

bb25:

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
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
