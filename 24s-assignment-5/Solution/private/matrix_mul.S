.section .data
.global    M
.global    L
.global    N
M:
        .quad   0
L:
        .quad   0
N:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global mul
.global main
        //%r366->x10
        //%r338->x9
        //%r337->x9
        //%r271->x9
        //%r270->x12
        //%r269->x10
        //%r268->x10
        //%r267->x10
        //%r266->x13
        //%r265->x10
        //%r264->x9
        //%r263->x10
        //%r262->x10
        //%r261->x10
        //%r260->x13
        //%r259->x10
        //%r258->x9
        //%r257->x9
        //%r256->x9
        //%r255->x12
        //%r254->x9
        //%r253->x9
        //%r252->x12
        //%r251->x10
        //%r250->x10
        //%r249->x10
        //%r248->x13
        //%r247->x10
        //%r246->x9
        //%r245->x10
        //%r244->x10
        //%r243->x10
        //%r242->x13
        //%r241->x10
        //%r240->x9
        //%r239->x9
        //%r238->x9
        //%r237->x12
        //%r236->x9
        //%r235->x9
        //%r234->x12
        //%r233->x10
        //%r232->x10
        //%r231->x10
        //%r230->x13
        //%r229->x10
        //%r228->x9
        //%r415->x24
        //%r158->x9
        //%r414->x24
        //%r157->x9
        //%r413->x25
        //%r156->x10
        //%r412->x9
        //%r155->x9
        //%r411->x9
        //%r154->x24
        //%r410->x24
        //%r153->x24
        //%r409->x10
        //%r152->x9
        //%r408->x10
        //%r151->x9
        //%r407->x24
        //%r150->x10
        //%r406->x9
        //%r149->x10
        //%r405->x9
        //%r148->x10
        //%r404->x10
        //%r147->x9
        //%r403->x9
        //%r146->x9
        //%r402->x9
        //%r145->x9
        //%r401->x10
        //%r144->x24
        //%r400->x24
        //%r143->x9
        //%r399->x24
        //%r142->x24
        //%r398->x25
        //%r141->x24
        //%r397->x9
        //%r140->x9
        //%r396->x9
        //%r139->x9
        //%r395->x24
        //%r138->x10
        //%r394->x24
        //%r137->x9
        //%r393->x24
        //%r136->x24
        //%r392->x25
        //%r135->x24
        //%r391->x9
        //%r134->x9
        //%r390->x9
        //%r133->x9
        //%r389->x24
        //%r132->x10
        //%r388->x10
        //%r131->x10
        //%r387->x10
        //%r130->x10
        //%r369->x9
        //%r112->x10
        //%r368->x24
        //%r111->x9
        //%r367->x10
        //%r110->x9
        //%r365->x24
        //%r108->x11
        //%r364->x9
        //%r107->x12
        //%r363->x9
        //%r106->x13
        //%r362->x10
        //%r105->x14
        //%r361->x9
        //%r104->x15
        //%r360->x9
        //%r103->x20
        //%r359->x9
        //%r102->x21
        //%r101->x22
        //%r370->x9
        //%r113->x10
        //%r416->x24
        //%r159->x23
        //%r100->x23
        //%r227->x10
        //%r386->x24
        //%r129->x9
        //%r371->x25
        //%r114->x10
        //%r372->x24
        //%r115->x9
        //%r373->x24
        //%r116->x9
        //%r374->x24
        //%r117->x24
        //%r375->x9
        //%r118->x24
        //%r376->x9
        //%r119->x9
        //%r377->x25
        //%r120->x10
        //%r378->x24
        //%r121->x9
        //%r379->x24
        //%r122->x9
        //%r380->x10
        //%r123->x24
        //%r381->x9
        //%r124->x24
        //%r382->x9
        //%r125->x9
        //%r383->x10
        //%r126->x24
        //%r384->x9
        //%r127->x9
        //%r385->x9
        //%r128->x9
        //%r417->x9
        //%r160->x23
        //%r418->x9
        //%r161->x9
        //%r419->x24
        //%r162->x23
        //%r420->x23
        //%r163->x9
        //%r421->x23
        //%r164->x9
        //%r422->x10
        //%r165->x13
        //%r423->x9
        //%r166->x9
        //%r424->x9
        //%r167->x9
        //%r425->x10
        //%r168->x9
        //%r426->x9
        //%r169->x10
        //%r427->x9
        //%r170->x23
        //%r428->x10
        //%r171->x10
        //%r429->x9
        //%r172->x10
        //%r430->x9
        //%r173->x10
        //%r431->x13
        //%r174->x9
        //%r432->x10
        //%r175->x10
        //%r433->x10
        //%r176->x23
        //%r434->x13
        //%r177->x10
        //%r435->x10
        //%r178->x10
        //%r436->x10
        //%r179->x10
        //%r437->x13
        //%r180->x13
        //%r438->x10
        //%r181->x9
        //%r439->x10
        //%r182->x9
        //%r440->x13
        //%r183->x13
        //%r441->x10
        //%r184->x9
        //%r442->x10
        //%r185->x9
        //%r186->x9
        //%r187->x10
        //%r188->x23
        //%r189->x10
        //%r190->x10
        //%r191->x10
        //%r192->x9
        //%r193->x10
        //%r194->x23
        //%r195->x10
        //%r196->x10
        //%r197->x10
        //%r198->x13
        //%r199->x9
        //%r200->x9
        //%r201->x13
        //%r202->x9
        //%r203->x9
        //%r204->x9
        //%r205->x10
        //%r206->x23
        //%r207->x10
        //%r208->x10
        //%r209->x10
        //%r210->x9
        //%r211->x10
        //%r212->x22
        //%r213->x10
        //%r214->x10
        //%r215->x10
        //%r216->x13
        //%r217->x9
        //%r218->x9
        //%r219->x12
        //%r220->x9
        //%r221->x9
        //%r222->x9
        //%r223->x10
        //%r224->x13
        //%r225->x10
        //%r226->x10
        //%r443->x10
        //%r444->x9
        //%r445->x9
        //%r446->x10
        //%r447->x9
        //%r448->x9
        //%r449->x10
        //%r450->x9
        //%r451->x9
        //%r452->x13
        //%r453->x10
        //%r454->x10
        //%r455->x13
        //%r456->x10
        //%r457->x10
        //%r458->x13
        //%r459->x10
        //%r460->x10
        //%r461->x13
        //%r462->x10
        //%r463->x10
        //%r464->x10
        //%r465->x9
        //%r466->x9
        //%r467->x10
        //%r468->x9
        //%r469->x9
        //%r470->x10
        //%r471->x9
        //%r472->x9
        //%r473->x13
        //%r474->x10
        //%r475->x10
        //%r476->x13
        //%r477->x10
        //%r478->x10
        //%r479->x13
        //%r480->x10
        //%r481->x10
        //%r482->x13
        //%r483->x10
        //%r484->x10
        //%r485->x10
        //%r486->x9
        //%r487->x9
        //%r488->x10
        //%r489->x9
        //%r490->x9
        //%r491->x10
        //%r492->x9
        //%r493->x9
        //%r494->x12
        //%r495->x10
        //%r496->x10
        //%r497->x12
        //%r498->x10
        //%r499->x10
        //%r500->x12
        //%r501->x10
        //%r502->x10
        //%r503->x12
        //%r504->x10
        //%r505->x10
        //%r506->x10
        //%r507->x9
        //%r508->x9
        //%r509->x10
        //%r510->x9
        //%r511->x9
        //%r512->x10
        //%r513->x9
        //%r514->x9
        //%r515->x12
        //%r516->x10
        //%r517->x10
        //%r518->x12
        //%r519->x10
        //%r520->x10
        //%r521->x12
        //%r522->x10
        //%r523->x10
        //%r524->x12
        //%r525->x10
        //%r526->x10
        //%r527->x10
        //%r528->x9
        //%r529->x9
        //%r530->x10
        //%r531->x9
        //%r532->x9
        //%r533->x10
        //%r534->x9
        //%r535->x9
        //%r536->x12
        //%r537->x10
        //%r538->x10
        //%r539->x12
        //%r540->x10
        //%r541->x10
        //%r542->x12
        //%r543->x10
        //%r544->x10
        //%r545->x12
        //%r546->x10
        //%r547->x10
        //%r548->x10
        //%r549->x9
        //%r550->x9
        //%r551->x9
mul:

        //bb1:

bb1:

        //  %r337 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x23, x0
        mov     x22, x1
        mov     x21, x2
        mov     x20, x3
        mov     x15, x4
        mov     x14, x5
        mov     x13, x6
        mov     x12, x7
        ldr     x9, [x29]
        mov     x11, x9
        mov     x9, #0
        //  %r338 = add i32 0, 0

        mov     x9, #0
        //  %r110 = getelementptr i32, i32* %r100, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x23, x9
        //  %r111 = load i32, i32* %r110

        ldr     x9, [x9]
        //  %r112 = getelementptr i32, i32* %r103, i32 0

        mov     x24, #0
        mov     x10, #8
        mul     x10, x24, x10
        add     x10, x20, x10
        //  %r113 = load i32, i32* %r112

        ldr     x10, [x10]
        //  %r114 = mul i32 %r111, %r113

        mul     x10, x9, x10
        //  %r115 = getelementptr i32, i32* %r100, i32 1

        mov     x24, #1
        mov     x9, #8
        mul     x9, x24, x9
        add     x9, x23, x9
        //  %r116 = load i32, i32* %r115

        ldr     x9, [x9]
        //  %r117 = getelementptr i32, i32* %r104, i32 0

        mov     x25, #0
        mov     x24, #8
        mul     x24, x25, x24
        add     x24, x15, x24
        //  %r118 = load i32, i32* %r117

        ldr     x24, [x24]
        //  %r119 = mul i32 %r116, %r118

        mul     x9, x9, x24
        //  %r120 = add i32 %r114, %r119

        add     x10, x10, x9
        //  %r121 = getelementptr i32, i32* %r100, i32 2

        mov     x24, #2
        mov     x9, #8
        mul     x9, x24, x9
        add     x9, x23, x9
        //  %r122 = load i32, i32* %r121

        ldr     x9, [x9]
        //  %r123 = getelementptr i32, i32* %r105, i32 0

        mov     x25, #0
        mov     x24, #8
        mul     x24, x25, x24
        add     x24, x14, x24
        //  %r124 = load i32, i32* %r123

        ldr     x24, [x24]
        //  %r125 = mul i32 %r122, %r124

        mul     x9, x9, x24
        //  %r126 = add i32 %r120, %r125

        add     x24, x10, x9
        //  %r127 = getelementptr i32, i32* %r106, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        //  store i32 %r126, i32* %r127

        str     x24, [x9]
        //  %r128 = getelementptr i32, i32* %r100, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x23, x9
        //  %r129 = load i32, i32* %r128

        ldr     x9, [x9]
        //  %r130 = getelementptr i32, i32* %r103, i32 1

        mov     x24, #1
        mov     x10, #8
        mul     x10, x24, x10
        add     x10, x20, x10
        //  %r131 = load i32, i32* %r130

        ldr     x10, [x10]
        //  %r132 = mul i32 %r129, %r131

        mul     x10, x9, x10
        //  %r133 = getelementptr i32, i32* %r100, i32 1

        mov     x24, #1
        mov     x9, #8
        mul     x9, x24, x9
        add     x9, x23, x9
        //  %r134 = load i32, i32* %r133

        ldr     x9, [x9]
        //  %r135 = getelementptr i32, i32* %r104, i32 1

        mov     x25, #1
        mov     x24, #8
        mul     x24, x25, x24
        add     x24, x15, x24
        //  %r136 = load i32, i32* %r135

        ldr     x24, [x24]
        //  %r137 = mul i32 %r134, %r136

        mul     x9, x9, x24
        //  %r138 = add i32 %r132, %r137

        add     x10, x10, x9
        //  %r139 = getelementptr i32, i32* %r100, i32 2

        mov     x24, #2
        mov     x9, #8
        mul     x9, x24, x9
        add     x9, x23, x9
        //  %r140 = load i32, i32* %r139

        ldr     x9, [x9]
        //  %r141 = getelementptr i32, i32* %r105, i32 1

        mov     x25, #1
        mov     x24, #8
        mul     x24, x25, x24
        add     x24, x14, x24
        //  %r142 = load i32, i32* %r141

        ldr     x24, [x24]
        //  %r143 = mul i32 %r140, %r142

        mul     x9, x9, x24
        //  %r144 = add i32 %r138, %r143

        add     x24, x10, x9
        //  %r145 = getelementptr i32, i32* %r106, i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        //  store i32 %r144, i32* %r145

        str     x24, [x9]
        //  %r146 = getelementptr i32, i32* %r100, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x23, x9
        //  %r147 = load i32, i32* %r146

        ldr     x9, [x9]
        //  %r148 = getelementptr i32, i32* %r103, i32 2

        mov     x24, #2
        mov     x10, #8
        mul     x10, x24, x10
        add     x10, x20, x10
        //  %r149 = load i32, i32* %r148

        ldr     x10, [x10]
        //  %r150 = mul i32 %r147, %r149

        mul     x10, x9, x10
        //  %r151 = getelementptr i32, i32* %r100, i32 1

        mov     x24, #1
        mov     x9, #8
        mul     x9, x24, x9
        add     x9, x23, x9
        //  %r152 = load i32, i32* %r151

        ldr     x9, [x9]
        //  %r153 = getelementptr i32, i32* %r104, i32 2

        mov     x25, #2
        mov     x24, #8
        mul     x24, x25, x24
        add     x24, x15, x24
        //  %r154 = load i32, i32* %r153

        ldr     x24, [x24]
        //  %r155 = mul i32 %r152, %r154

        mul     x9, x9, x24
        //  %r156 = add i32 %r150, %r155

        add     x10, x10, x9
        //  %r157 = getelementptr i32, i32* %r100, i32 2

        mov     x24, #2
        mov     x9, #8
        mul     x9, x24, x9
        add     x9, x23, x9
        //  %r158 = load i32, i32* %r157

        ldr     x9, [x9]
        //  %r159 = getelementptr i32, i32* %r105, i32 2

        mov     x24, #2
        mov     x23, #8
        mul     x23, x24, x23
        add     x23, x14, x23
        //  %r160 = load i32, i32* %r159

        ldr     x23, [x23]
        //  %r161 = mul i32 %r158, %r160

        mul     x9, x9, x23
        //  %r162 = add i32 %r156, %r161

        add     x23, x10, x9
        //  %r163 = getelementptr i32, i32* %r106, i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        //  store i32 %r162, i32* %r163

        str     x23, [x9]
        //  %r164 = getelementptr i32, i32* %r101, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x22, x9
        //  %r165 = load i32, i32* %r164

        ldr     x13, [x9]
        //  %r166 = getelementptr i32, i32* %r103, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x20, x9
        //  %r167 = load i32, i32* %r166

        ldr     x9, [x9]
        //  %r168 = mul i32 %r165, %r167

        mul     x9, x13, x9
        //  %r169 = getelementptr i32, i32* %r101, i32 1

        mov     x13, #1
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x22, x10
        //  %r170 = load i32, i32* %r169

        ldr     x23, [x10]
        //  %r171 = getelementptr i32, i32* %r104, i32 0

        mov     x13, #0
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x15, x10
        //  %r172 = load i32, i32* %r171

        ldr     x10, [x10]
        //  %r173 = mul i32 %r170, %r172

        mul     x10, x23, x10
        //  %r174 = add i32 %r168, %r173

        add     x9, x9, x10
        //  %r175 = getelementptr i32, i32* %r101, i32 2

        mov     x13, #2
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x22, x10
        //  %r176 = load i32, i32* %r175

        ldr     x23, [x10]
        //  %r177 = getelementptr i32, i32* %r105, i32 0

        mov     x13, #0
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x14, x10
        //  %r178 = load i32, i32* %r177

        ldr     x10, [x10]
        //  %r179 = mul i32 %r176, %r178

        mul     x10, x23, x10
        //  %r180 = add i32 %r174, %r179

        add     x13, x9, x10
        //  %r181 = getelementptr i32, i32* %r107, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        //  store i32 %r180, i32* %r181

        str     x13, [x9]
        //  %r182 = getelementptr i32, i32* %r101, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x22, x9
        //  %r183 = load i32, i32* %r182

        ldr     x13, [x9]
        //  %r184 = getelementptr i32, i32* %r103, i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x20, x9
        //  %r185 = load i32, i32* %r184

        ldr     x9, [x9]
        //  %r186 = mul i32 %r183, %r185

        mul     x9, x13, x9
        //  %r187 = getelementptr i32, i32* %r101, i32 1

        mov     x13, #1
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x22, x10
        //  %r188 = load i32, i32* %r187

        ldr     x23, [x10]
        //  %r189 = getelementptr i32, i32* %r104, i32 1

        mov     x13, #1
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x15, x10
        //  %r190 = load i32, i32* %r189

        ldr     x10, [x10]
        //  %r191 = mul i32 %r188, %r190

        mul     x10, x23, x10
        //  %r192 = add i32 %r186, %r191

        add     x9, x9, x10
        //  %r193 = getelementptr i32, i32* %r101, i32 2

        mov     x13, #2
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x22, x10
        //  %r194 = load i32, i32* %r193

        ldr     x23, [x10]
        //  %r195 = getelementptr i32, i32* %r105, i32 1

        mov     x13, #1
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x14, x10
        //  %r196 = load i32, i32* %r195

        ldr     x10, [x10]
        //  %r197 = mul i32 %r194, %r196

        mul     x10, x23, x10
        //  %r198 = add i32 %r192, %r197

        add     x13, x9, x10
        //  %r199 = getelementptr i32, i32* %r107, i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        //  store i32 %r198, i32* %r199

        str     x13, [x9]
        //  %r200 = getelementptr i32, i32* %r101, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x22, x9
        //  %r201 = load i32, i32* %r200

        ldr     x13, [x9]
        //  %r202 = getelementptr i32, i32* %r103, i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x20, x9
        //  %r203 = load i32, i32* %r202

        ldr     x9, [x9]
        //  %r204 = mul i32 %r201, %r203

        mul     x9, x13, x9
        //  %r205 = getelementptr i32, i32* %r101, i32 1

        mov     x13, #1
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x22, x10
        //  %r206 = load i32, i32* %r205

        ldr     x23, [x10]
        //  %r207 = getelementptr i32, i32* %r104, i32 2

        mov     x13, #2
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x15, x10
        //  %r208 = load i32, i32* %r207

        ldr     x10, [x10]
        //  %r209 = mul i32 %r206, %r208

        mul     x10, x23, x10
        //  %r210 = add i32 %r204, %r209

        add     x9, x9, x10
        //  %r211 = getelementptr i32, i32* %r101, i32 2

        mov     x13, #2
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x22, x10
        //  %r212 = load i32, i32* %r211

        ldr     x22, [x10]
        //  %r213 = getelementptr i32, i32* %r105, i32 2

        mov     x13, #2
        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x14, x10
        //  %r214 = load i32, i32* %r213

        ldr     x10, [x10]
        //  %r215 = mul i32 %r212, %r214

        mul     x10, x22, x10
        //  %r216 = add i32 %r210, %r215

        add     x13, x9, x10
        //  %r217 = getelementptr i32, i32* %r107, i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        //  store i32 %r216, i32* %r217

        str     x13, [x9]
        //  %r218 = getelementptr i32, i32* %r102, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x21, x9
        //  %r219 = load i32, i32* %r218

        ldr     x12, [x9]
        //  %r220 = getelementptr i32, i32* %r103, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x20, x9
        //  %r221 = load i32, i32* %r220

        ldr     x9, [x9]
        //  %r222 = mul i32 %r219, %r221

        mul     x9, x12, x9
        //  %r223 = getelementptr i32, i32* %r102, i32 1

        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x21, x10
        //  %r224 = load i32, i32* %r223

        ldr     x13, [x10]
        //  %r225 = getelementptr i32, i32* %r104, i32 0

        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x15, x10
        //  %r226 = load i32, i32* %r225

        ldr     x10, [x10]
        //  %r227 = mul i32 %r224, %r226

        mul     x10, x13, x10
        //  %r228 = add i32 %r222, %r227

        add     x9, x9, x10
        //  %r229 = getelementptr i32, i32* %r102, i32 2

        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x21, x10
        //  %r230 = load i32, i32* %r229

        ldr     x13, [x10]
        //  %r231 = getelementptr i32, i32* %r105, i32 0

        mov     x12, #0
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x14, x10
        //  %r232 = load i32, i32* %r231

        ldr     x10, [x10]
        //  %r233 = mul i32 %r230, %r232

        mul     x10, x13, x10
        //  %r234 = add i32 %r228, %r233

        add     x12, x9, x10
        //  %r235 = getelementptr i32, i32* %r108, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        //  store i32 %r234, i32* %r235

        str     x12, [x9]
        //  %r236 = getelementptr i32, i32* %r102, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x21, x9
        //  %r237 = load i32, i32* %r236

        ldr     x12, [x9]
        //  %r238 = getelementptr i32, i32* %r103, i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x20, x9
        //  %r239 = load i32, i32* %r238

        ldr     x9, [x9]
        //  %r240 = mul i32 %r237, %r239

        mul     x9, x12, x9
        //  %r241 = getelementptr i32, i32* %r102, i32 1

        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x21, x10
        //  %r242 = load i32, i32* %r241

        ldr     x13, [x10]
        //  %r243 = getelementptr i32, i32* %r104, i32 1

        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x15, x10
        //  %r244 = load i32, i32* %r243

        ldr     x10, [x10]
        //  %r245 = mul i32 %r242, %r244

        mul     x10, x13, x10
        //  %r246 = add i32 %r240, %r245

        add     x9, x9, x10
        //  %r247 = getelementptr i32, i32* %r102, i32 2

        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x21, x10
        //  %r248 = load i32, i32* %r247

        ldr     x13, [x10]
        //  %r249 = getelementptr i32, i32* %r105, i32 1

        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x14, x10
        //  %r250 = load i32, i32* %r249

        ldr     x10, [x10]
        //  %r251 = mul i32 %r248, %r250

        mul     x10, x13, x10
        //  %r252 = add i32 %r246, %r251

        add     x12, x9, x10
        //  %r253 = getelementptr i32, i32* %r108, i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        //  store i32 %r252, i32* %r253

        str     x12, [x9]
        //  %r254 = getelementptr i32, i32* %r102, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x21, x9
        //  %r255 = load i32, i32* %r254

        ldr     x12, [x9]
        //  %r256 = getelementptr i32, i32* %r103, i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x20, x9
        //  %r257 = load i32, i32* %r256

        ldr     x9, [x9]
        //  %r258 = mul i32 %r255, %r257

        mul     x9, x12, x9
        //  %r259 = getelementptr i32, i32* %r102, i32 1

        mov     x12, #1
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x21, x10
        //  %r260 = load i32, i32* %r259

        ldr     x13, [x10]
        //  %r261 = getelementptr i32, i32* %r104, i32 2

        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x15, x10
        //  %r262 = load i32, i32* %r261

        ldr     x10, [x10]
        //  %r263 = mul i32 %r260, %r262

        mul     x10, x13, x10
        //  %r264 = add i32 %r258, %r263

        add     x9, x9, x10
        //  %r265 = getelementptr i32, i32* %r102, i32 2

        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x21, x10
        //  %r266 = load i32, i32* %r265

        ldr     x13, [x10]
        //  %r267 = getelementptr i32, i32* %r105, i32 2

        mov     x12, #2
        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x14, x10
        //  %r268 = load i32, i32* %r267

        ldr     x10, [x10]
        //  %r269 = mul i32 %r266, %r268

        mul     x10, x13, x10
        //  %r270 = add i32 %r264, %r269

        add     x12, x9, x10
        //  %r271 = getelementptr i32, i32* %r108, i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        //  store i32 %r270, i32* %r271

        str     x12, [x9]
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r574->x10
        //%r573->x10
        //%r572->x11
        //%r318->x9
        //%r571->x10
        //%r570->x10
        //%r569->x10
        //%r568->x11
        //%r566->x10
        //%r565->x10
        //%r311->x9
        //%r563->x10
        //%r562->x10
        //%r308->x9
        //%r561->x9
        //%r560->x9
        //%r559->x9
        //%r558->x10
        //%r556->x10
        //%r302->x10
        //%r555->x9
        //%r553->x9
        //%r299->x10
        //%r552->x9
        //%r357->x9
        //%r611->x9
        //%r356->x9
        //%r610->x9
        //%r567->x10
        //%r331->x9
        //%r585->x10
        //%r554->x10
        //%r347->x11
        //%r601->x9
        //%r576->x11
        //%r340->x9
        //%r594->x9
        //%r557->x9
        //%r321->x9
        //%r575->x10
        //%r350->x11
        //%r604->x9
        //%r564->x11
        //%r328->x9
        //%r582->x10
        //%r358->x9
        //%r612->x9
        //%r351->x9
        //%r605->x9
        //%r348->x10
        //%r602->x9
        //%r345->x10
        //%r599->x9
        //%r355->x9
        //%r609->x9
        //%r296->x10
        //%r354->x9
        //%r608->x9
        //%r577->x10
        //%r341->x9
        //%r595->x9
        //%r339->x9
        //%r593->x9
        //%r283->x10
        //%r342->x9
        //%r596->x9
        //%r343->x9
        //%r597->x9
        //%r344->x11
        //%r598->x9
        //%r287->x10
        //%r346->x9
        //%r600->x9
        //%r290->x10
        //%r349->x9
        //%r603->x9
        //%r293->x10
        //%r352->x9
        //%r606->x9
        //%r353->x9
        //%r607->x10
        //%r578->x10
        //%r579->x10
        //%r580->x11
        //%r581->x10
        //%r583->x10
        //%r584->x11
        //%r586->x10
        //%r587->x9
        //%r588->x9
        //%r589->x9
        //%r590->x9
        //%r591->x9
        //%r592->x9
        //%r613->x9
        //%r614->x10
        //%r615->x9
        //%r616->x9
        //%r617->x9
        //%r618->x9
        //%r619->x9
        //%r620->x9
        //%r621->x10
        //%r622->x9
        //%r623->x9
        //%r624->x9
        //%r625->x9
        //%r626->x9
main:

        //280:x29,#-240

        //279:x29,#-216

        //278:x29,#-192

        //277:x29,#-144

        //276:x29,#-120

        //275:x29,#-96

        //274:x29,#-72

        //273:x29,#-48

        //272:x29,#-24

        //bb2:

bb2:

        //  %r339 = add i32 0, 0

        mov     x16, #240
        sub     sp, sp, x16
        mov     x9, #0
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
        //  store i32 3, i32* @N

        mov     x10, #3
        adrp     x9, N
        add     x9, x9, #:lo12:N
        str     x10, [x9]
        //  store i32 3, i32* @M

        mov     x10, #3
        adrp     x9, M
        add     x9, x9, #:lo12:M
        str     x10, [x9]
        //  store i32 3, i32* @L

        mov     x10, #3
        adrp     x9, L
        add     x9, x9, #:lo12:L
        str     x10, [x9]
        //  %r272 = alloca [ 3 x i32 ]

        //  %r273 = alloca [ 3 x i32 ]

        //  %r274 = alloca [ 3 x i32 ]

        //  %r275 = alloca [ 3 x i32 ]

        //  %r276 = alloca [ 3 x i32 ]

        //  %r277 = alloca [ 3 x i32 ]

        //  %r278 = alloca [ 6 x i32 ]

        //  %r279 = alloca [ 3 x i32 ]

        //  %r280 = alloca [ 3 x i32 ]

        //  %r340 = add i32 0, 0

        mov     x9, #0
        //  %r341 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb3


        //bb3:  %r342 = phi i32 [ %r341, %bb2 ], [ %r358, %bb4 ]

        mov     x9, x9
        b     bb3
        //bb3:

bb3:

        //  %r342 = phi i32 [ %r341, %bb2 ], [ %r358, %bb4 ]

        //  %r283 = load i32, i32* @M

        adrp     x10, M
        add     x10, x10, #:lo12:M
        ldr     x10, [x10]
        //  %r284 = icmp slt i32 %r342, %r283

        cmp     x9, x10
        //  br i1 %r284, label %bb4, label %bb5


        b.lt     bb4
        b     bb5
        //bb4:

bb4:

        //  %r287 = getelementptr [3 x i32 ], [3 x i32 ]* %r272, i32 0 , i32 %r342

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-24
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r342, i32* %r287

        str     x9, [x10]
        //  %r290 = getelementptr [3 x i32 ], [3 x i32 ]* %r273, i32 0 , i32 %r342

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-48
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r342, i32* %r290

        str     x9, [x10]
        //  %r293 = getelementptr [3 x i32 ], [3 x i32 ]* %r274, i32 0 , i32 %r342

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-72
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r342, i32* %r293

        str     x9, [x10]
        //  %r296 = getelementptr [3 x i32 ], [3 x i32 ]* %r275, i32 0 , i32 %r342

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-96
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r342, i32* %r296

        str     x9, [x10]
        //  %r299 = getelementptr [3 x i32 ], [3 x i32 ]* %r276, i32 0 , i32 %r342

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-120
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r342, i32* %r299

        str     x9, [x10]
        //  %r302 = getelementptr [3 x i32 ], [3 x i32 ]* %r277, i32 0 , i32 %r342

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-144
        add     x10, x29, x10
        add     x10, x10, x11
        //  store i32 %r342, i32* %r302

        str     x9, [x10]
        //  %r358 = add i32 %r342, 1

        add     x9, x9, #1
        //  br label %bb3


        //bb3:  %r342 = phi i32 [ %r341, %bb2 ], [ %r358, %bb4 ]

        mov     x9, x9
        b     bb3
        //bb5:

bb5:

        //  %r343 = call i32 @mul(i32* %r272, i32* %r273, i32* %r274, i32* %r275, i32* %r276, i32* %r277, i32* %r278, i32* %r279, i32* %r280)

        mov     x9, #-24
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-48
        add     x9, x29, x9
        mov     x1, x9
        mov     x9, #-72
        add     x9, x29, x9
        mov     x2, x9
        mov     x9, #-96
        add     x9, x29, x9
        mov     x3, x9
        mov     x9, #-120
        add     x9, x29, x9
        mov     x4, x9
        mov     x9, #-144
        add     x9, x29, x9
        mov     x5, x9
        mov     x9, #-192
        add     x9, x29, x9
        mov     x6, x9
        mov     x9, #-216
        add     x9, x29, x9
        mov     x7, x9
        mov     x9, #-240
        add     x9, x29, x9
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
        str     x9, [sp,#-136]
        sub     sp, sp, #136
        mov     x29, sp
        bl     mul
        add     sp, sp, #-8
        ldp     x29, x30, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb6


        //bb6:  %r344 = phi i32 [ %r343, %bb5 ], [ %r357, %bb7 ]

        mov     x11, x9
        b     bb6
        //bb6:

bb6:

        //  %r344 = phi i32 [ %r343, %bb5 ], [ %r357, %bb7 ]

        //  %r308 = load i32, i32* @N

        adrp     x9, N
        add     x9, x9, #:lo12:N
        ldr     x9, [x9]
        //  %r309 = icmp slt i32 %r344, %r308

        cmp     x11, x9
        //  br i1 %r309, label %bb7, label %bb8


        b.lt     bb7
        b     bb8
        //bb7:

bb7:

        //  %r311 = getelementptr [6 x i32 ], [6 x i32 ]* %r278, i32 0 , i32 %r344

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-192
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r356 = load i32, i32* %r311

        ldr     x9, [x9]
        //  call void @putint(i32 %r356)

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
        //  %r357 = add i32 %r344, 1

        add     x9, x11, #1
        //  br label %bb6


        //bb6:  %r344 = phi i32 [ %r343, %bb5 ], [ %r357, %bb7 ]

        mov     x11, x9
        b     bb6
        //bb8:

bb8:

        //  %r345 = add i32 10, 0

        mov     x9, #10
        mov     x10, x9
        //  %r346 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  call void @putch(i32 %r345)

        mov     x0, x10
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
        //  br label %bb9


        //bb9:  %r347 = phi i32 [ %r346, %bb8 ], [ %r355, %bb10 ]

        mov     x11, x9
        b     bb9
        //bb9:

bb9:

        //  %r347 = phi i32 [ %r346, %bb8 ], [ %r355, %bb10 ]

        //  %r318 = load i32, i32* @N

        adrp     x9, N
        add     x9, x9, #:lo12:N
        ldr     x9, [x9]
        //  %r319 = icmp slt i32 %r347, %r318

        cmp     x11, x9
        //  br i1 %r319, label %bb10, label %bb11


        b.lt     bb10
        b     bb11
        //bb10:

bb10:

        //  %r321 = getelementptr [3 x i32 ], [3 x i32 ]* %r279, i32 0 , i32 %r347

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-216
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r354 = load i32, i32* %r321

        ldr     x9, [x9]
        //  call void @putint(i32 %r354)

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
        //  %r355 = add i32 %r347, 1

        add     x9, x11, #1
        //  br label %bb9


        //bb9:  %r347 = phi i32 [ %r346, %bb8 ], [ %r355, %bb10 ]

        mov     x11, x9
        b     bb9
        //bb11:

bb11:

        //  %r348 = add i32 10, 0

        mov     x9, #10
        mov     x10, x9
        //  %r349 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  call void @putch(i32 %r348)

        mov     x0, x10
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
        //  br label %bb12


        //bb12:  %r350 = phi i32 [ %r349, %bb11 ], [ %r353, %bb13 ]

        mov     x11, x9
        b     bb12
        //bb12:

bb12:

        //  %r350 = phi i32 [ %r349, %bb11 ], [ %r353, %bb13 ]

        //  %r328 = load i32, i32* @N

        adrp     x9, N
        add     x9, x9, #:lo12:N
        ldr     x9, [x9]
        //  %r329 = icmp slt i32 %r350, %r328

        cmp     x11, x9
        //  br i1 %r329, label %bb13, label %bb14


        b.lt     bb13
        b     bb14
        //bb13:

bb13:

        //  %r331 = getelementptr [3 x i32 ], [3 x i32 ]* %r280, i32 0 , i32 %r350

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-240
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r352 = load i32, i32* %r331

        ldr     x9, [x9]
        //  call void @putint(i32 %r352)

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
        //  %r353 = add i32 %r350, 1

        add     x9, x11, #1
        //  br label %bb12


        //bb12:  %r350 = phi i32 [ %r349, %bb11 ], [ %r353, %bb13 ]

        mov     x11, x9
        b     bb12
        //bb14:

bb14:

        //  %r351 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  call void @putch(i32 %r351)

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
