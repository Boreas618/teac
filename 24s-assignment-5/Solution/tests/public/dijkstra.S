.section .data
.global    INF
.global    e
.global    book
.global    dis
.global    n
.global    m
.global    v1
.global    v2
.global    w
INF:
        .quad   65535
e:
        .zero   2048
book:
        .zero   128
dis:
        .zero   128
n:
        .quad   0
m:
        .quad   0
v1:
        .quad   0
v2:
        .quad   0
w:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global Dijkstra
.global main
        //%r341->x11
        //%r340->x11
        //%r339->x13
        //%r338->x11
        //%r337->x11
        //%r336->x13
        //%r335->x11
        //%r334->x11
        //%r333->x11
        //%r332->x11
        //%r331->x11
        //%r330->x11
        //%r329->x13
        //%r328->x11
        //%r327->x11
        //%r326->x9
        //%r325->x9
        //%r324->x9
        //%r323->x11
        //%r322->x9
        //%r321->x9
        //%r320->x10
        //%r319->x9
        //%r318->x13
        //%r317->x13
        //%r316->x14
        //%r315->x13
        //%r314->x13
        //%r313->x14
        //%r312->x13
        //%r311->x13
        //%r310->x10
        //%r309->x10
        //%r307->x9
        //%r303->x10
        //%r300->x10
        //%r297->x10
        //%r296->x10
        //%r292->x10
        //%r289->x11
        //%r286->x10
        //%r283->x9
        //%r282->x9
        //%r259->x10
        //%r258->x9
        //%r291->x10
        //%r164->x11
        //%r105->x11
        //%r288->x10
        //%r161->x13
        //%r102->x10
        //%r284->x9
        //%r157->x11
        //%r280->x9
        //%r153->x13
        //%r152->x11
        //%r150->x13
        //%r149->x13
        //%r143->x11
        //%r287->x11
        //%r160->x11
        //%r301->x10
        //%r174->x14
        //%r260->x9
        //%r133->x13
        //%r251->x9
        //%r104->x11
        //%r290->x10
        //%r163->x15
        //%r146->x11
        //%r257->x13
        //%r130->x13
        //%r248->x10
        //%r261->x9
        //%r134->x14
        //%r304->x9
        //%r177->x13
        //%r107->x10
        //%r293->x10
        //%r166->x11
        //%r137->x9
        //%r255->x9
        //%r108->x12
        //%r294->x10
        //%r167->x11
        //%r298->x11
        //%r171->x11
        //%r281->x9
        //%r154->x11
        //%r252->x9
        //%r125->x13
        //%r243->x9
        //%r285->x9
        //%r158->x14
        //%r256->x14
        //%r129->x13
        //%r247->x13
        //%r295->x11
        //%r168->x11
        //%r299->x10
        //%r172->x11
        //%r302->x9
        //%r175->x14
        //%r305->x9
        //%r178->x13
        //%r110->x10
        //%r237->x9
        //%r306->x9
        //%r179->x11
        //%r238->x9
        //%r308->x9
        //%r181->x13
        //%r240->x9
        //%r112->x11
        //%r239->x9
        //%r241->x9
        //%r115->x10
        //%r242->x9
        //%r117->x9
        //%r244->x9
        //%r118->x9
        //%r245->x12
        //%r246->x9
        //%r249->x11
        //%r250->x10
        //%r253->x9
        //%r254->x9
        //%r342->x15
        //%r343->x11
        //%r344->x11
        //%r345->x15
        //%r346->x15
        //%r347->x11
        //%r348->x13
        //%r349->x11
        //%r350->x13
        //%r351->x14
        //%r352->x13
        //%r353->x13
        //%r354->x13
        //%r355->x13
        //%r356->x13
        //%r357->x14
        //%r358->x13
Dijkstra:

        //bb1:

bb1:

        //  %r237 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r238 = add i32 0, 0

        mov     x9, #0
        //  %r239 = add i32 0, 0

        mov     x9, #0
        //  %r240 = add i32 0, 0

        mov     x9, #0
        //  %r241 = add i32 0, 0

        mov     x9, #0
        //  %r242 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r243 = phi i32 [ %r242, %bb1 ], [ %r261, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb2:

bb2:

        //  %r243 = phi i32 [ %r242, %bb1 ], [ %r261, %bb3 ]

        //  %r102 = load i32, i32* @n

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     x10, [x10]
        //  %r103 = icmp sle i32 %r243, %r102

        cmp     x9, x10
        //  br i1 %r103, label %bb3, label %bb4


        b.le     bb3
        b     bb4
        //bb3:

bb3:

        //  %r104 = getelementptr [16 x %array2D ], [16 x %array2D ]* @e, i32 0, i32 1

        mov     x11, #1
        mov     x10, #128
        mul     x11, x11, x10
        adrp     x10, e
        add     x10, x10, #:lo12:e
        add     x11, x10, x11
        //  %r105 = getelementptr %array2D, %array2D* %r104, i32 0, i32 0

        mov     x10, #0
        add     x11, x11, x10
        //  %r107 = getelementptr [16 x i32 ], [16 x i32 ]* %r105, i32 0 , i32 %r243

        mov     x10, #8
        mul     x10, x9, x10
        add     x10, x11, x10
        //  %r108 = load i32, i32* %r107

        ldr     x12, [x10]
        //  %r110 = getelementptr [16 x i32 ], [16 x i32 ]* @dis, i32 0, i32 %r243

        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, dis
        add     x10, x10, #:lo12:dis
        add     x10, x10, x11
        //  store i32 %r108, i32* %r110

        str     x12, [x10]
        //  %r112 = getelementptr [16 x i32 ], [16 x i32 ]* @book, i32 0, i32 %r243

        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, book
        add     x10, x10, #:lo12:book
        add     x11, x10, x11
        //  store i32 0, i32* %r112

        mov     x10, #0
        str     x10, [x11]
        //  %r261 = add i32 %r243, 1

        add     x9, x9, #1
        //  br label %bb2


        //bb2:  %r243 = phi i32 [ %r242, %bb1 ], [ %r261, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb4:

bb4:

        //  %r115 = getelementptr [16 x i32 ], [16 x i32 ]* @book, i32 0, i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        adrp     x9, book
        add     x9, x9, #:lo12:book
        add     x10, x9, x10
        //  store i32 1, i32* %r115

        mov     x9, #1
        str     x9, [x10]
        //  %r244 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb5


        //bb5:  %r245 = phi i32 [ %r244, %bb4 ], [ %r254, %bb17 ]

        mov     x12, x9
        b     bb5
        //bb5:

bb5:

        //  %r245 = phi i32 [ %r244, %bb4 ], [ %r254, %bb17 ]

        //  %r117 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r118 = sub i32 %r117, 1

        sub     x9, x9, #1
        //  %r119 = icmp sle i32 %r245, %r118

        cmp     x12, x9
        //  br i1 %r119, label %bb6, label %bb7


        b.le     bb6
        b     bb7
        //bb6:

bb6:

        //  %r246 = load i32, i32* @INF

        adrp     x9, INF
        add     x9, x9, #:lo12:INF
        ldr     x9, [x9]
        //  %r247 = add i32 0, 0

        mov     x10, #0
        mov     x13, x10
        //  %r248 = add i32 1, 0

        mov     x10, #1
        mov     x10, x10
        //  br label %bb8


        //bb8:  %r249 = phi i32 [ %r248, %bb6 ], [ %r258, %bb13 ]

        mov     x11, x10
        //bb8:  %r250 = phi i32 [ %r247, %bb6 ], [ %r256, %bb13 ]

        mov     x10, x13
        //bb8:  %r251 = phi i32 [ %r246, %bb6 ], [ %r257, %bb13 ]

        mov     x9, x9
        b     bb8
        //bb8:

bb8:

        //  %r249 = phi i32 [ %r248, %bb6 ], [ %r258, %bb13 ]

        //  %r250 = phi i32 [ %r247, %bb6 ], [ %r256, %bb13 ]

        //  %r251 = phi i32 [ %r246, %bb6 ], [ %r257, %bb13 ]

        //  %r125 = load i32, i32* @n

        adrp     x13, n
        add     x13, x13, #:lo12:n
        ldr     x13, [x13]
        //  %r126 = icmp sle i32 %r249, %r125

        cmp     x11, x13
        //  br i1 %r126, label %bb9, label %bb10


        b.le     bb9
        b     bb10
        //bb9:

bb9:

        //  %r129 = getelementptr [16 x i32 ], [16 x i32 ]* @dis, i32 0, i32 %r249

        mov     x13, #8
        mul     x14, x11, x13
        adrp     x13, dis
        add     x13, x13, #:lo12:dis
        add     x13, x13, x14
        //  %r130 = load i32, i32* %r129

        ldr     x13, [x13]
        //  %r131 = icmp sgt i32 %r251, %r130

        cmp     x9, x13
        //  br i1 %r131, label %bb14, label %bb12


        b.gt     bb14
        b     bb12
        //bb14:

bb14:

        //  %r133 = getelementptr [16 x i32 ], [16 x i32 ]* @book, i32 0, i32 %r249

        mov     x13, #8
        mul     x14, x11, x13
        adrp     x13, book
        add     x13, x13, #:lo12:book
        add     x13, x13, x14
        //  %r134 = load i32, i32* %r133

        ldr     x14, [x13]
        //  %r135 = icmp eq i32 %r134, 0

        mov     x13, #0
        cmp     x14, x13
        //  br i1 %r135, label %bb11, label %bb12


        b.eq     bb11
        b     bb12
        //bb11:

bb11:

        //  %r137 = getelementptr [16 x i32 ], [16 x i32 ]* @dis, i32 0, i32 %r249

        mov     x9, #8
        mul     x10, x11, x9
        adrp     x9, dis
        add     x9, x9, #:lo12:dis
        add     x9, x9, x10
        //  %r259 = load i32, i32* %r137

        ldr     x10, [x9]
        //  %r260 = add i32 %r249, 0

        mov     x9, x11
        //  br label %bb13


        //bb13:  %r256 = phi i32 [ %r260, %bb11 ], [ %r250, %bb12 ]

        mov     x14, x9
        //bb13:  %r257 = phi i32 [ %r259, %bb11 ], [ %r251, %bb12 ]

        mov     x13, x10
        b     bb13
        //bb12:

bb12:

        //  br label %bb13


        //bb13:  %r256 = phi i32 [ %r260, %bb11 ], [ %r250, %bb12 ]

        mov     x14, x10
        //bb13:  %r257 = phi i32 [ %r259, %bb11 ], [ %r251, %bb12 ]

        mov     x13, x9
        b     bb13
        //bb13:

bb13:

        //  %r256 = phi i32 [ %r260, %bb11 ], [ %r250, %bb12 ]

        //  %r257 = phi i32 [ %r259, %bb11 ], [ %r251, %bb12 ]

        //  %r258 = add i32 %r249, 1

        add     x9, x11, #1
        //  br label %bb8


        //bb8:  %r249 = phi i32 [ %r248, %bb6 ], [ %r258, %bb13 ]

        mov     x11, x9
        //bb8:  %r250 = phi i32 [ %r247, %bb6 ], [ %r256, %bb13 ]

        mov     x10, x14
        //bb8:  %r251 = phi i32 [ %r246, %bb6 ], [ %r257, %bb13 ]

        mov     x9, x13
        b     bb8
        //bb10:

bb10:

        //  %r143 = getelementptr [16 x i32 ], [16 x i32 ]* @book, i32 0, i32 %r250

        mov     x9, #8
        mul     x11, x10, x9
        adrp     x9, book
        add     x9, x9, #:lo12:book
        add     x11, x9, x11
        //  store i32 1, i32* %r143

        mov     x9, #1
        str     x9, [x11]
        //  %r252 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb15


        //bb15:  %r253 = phi i32 [ %r252, %bb10 ], [ %r255, %bb20 ]

        mov     x9, x9
        b     bb15
        //bb15:

bb15:

        //  %r253 = phi i32 [ %r252, %bb10 ], [ %r255, %bb20 ]

        //  %r146 = load i32, i32* @n

        adrp     x11, n
        add     x11, x11, #:lo12:n
        ldr     x11, [x11]
        //  %r147 = icmp sle i32 %r253, %r146

        cmp     x9, x11
        //  br i1 %r147, label %bb16, label %bb17


        b.le     bb16
        b     bb17
        //bb16:

bb16:

        //  %r149 = getelementptr [16 x %array2D ], [16 x %array2D ]* @e, i32 0, i32 %r250

        mov     x11, #128
        mul     x13, x10, x11
        adrp     x11, e
        add     x11, x11, #:lo12:e
        add     x13, x11, x13
        //  %r150 = getelementptr %array2D, %array2D* %r149, i32 0, i32 0

        mov     x11, #0
        add     x13, x13, x11
        //  %r152 = getelementptr [16 x i32 ], [16 x i32 ]* %r150, i32 0 , i32 %r253

        mov     x11, #8
        mul     x11, x9, x11
        add     x11, x13, x11
        //  %r153 = load i32, i32* %r152

        ldr     x13, [x11]
        //  %r154 = load i32, i32* @INF

        adrp     x11, INF
        add     x11, x11, #:lo12:INF
        ldr     x11, [x11]
        //  %r155 = icmp slt i32 %r153, %r154

        cmp     x13, x11
        //  br i1 %r155, label %bb18, label %bb19


        b.lt     bb18
        b     bb19
        //bb18:

bb18:

        //  %r157 = getelementptr [16 x i32 ], [16 x i32 ]* @dis, i32 0, i32 %r253

        mov     x11, #8
        mul     x13, x9, x11
        adrp     x11, dis
        add     x11, x11, #:lo12:dis
        add     x11, x11, x13
        //  %r158 = load i32, i32* %r157

        ldr     x14, [x11]
        //  %r160 = getelementptr [16 x i32 ], [16 x i32 ]* @dis, i32 0, i32 %r250

        mov     x11, #8
        mul     x13, x10, x11
        adrp     x11, dis
        add     x11, x11, #:lo12:dis
        add     x11, x11, x13
        //  %r161 = load i32, i32* %r160

        ldr     x13, [x11]
        //  %r163 = getelementptr [16 x %array2D ], [16 x %array2D ]* @e, i32 0, i32 %r250

        mov     x11, #128
        mul     x15, x10, x11
        adrp     x11, e
        add     x11, x11, #:lo12:e
        add     x15, x11, x15
        //  %r164 = getelementptr %array2D, %array2D* %r163, i32 0, i32 0

        mov     x11, #0
        add     x11, x15, x11
        //  %r166 = getelementptr [16 x i32 ], [16 x i32 ]* %r164, i32 0 , i32 %r253

        mov     x15, #8
        mul     x15, x9, x15
        add     x11, x11, x15
        //  %r167 = load i32, i32* %r166

        ldr     x11, [x11]
        //  %r168 = add i32 %r161, %r167

        add     x11, x13, x11
        //  %r169 = icmp sgt i32 %r158, %r168

        cmp     x14, x11
        //  br i1 %r169, label %bb21, label %bb22


        b.gt     bb21
        b     bb22
        //bb21:

bb21:

        //  %r171 = getelementptr [16 x i32 ], [16 x i32 ]* @dis, i32 0, i32 %r250

        mov     x11, #8
        mul     x13, x10, x11
        adrp     x11, dis
        add     x11, x11, #:lo12:dis
        add     x11, x11, x13
        //  %r172 = load i32, i32* %r171

        ldr     x11, [x11]
        //  %r174 = getelementptr [16 x %array2D ], [16 x %array2D ]* @e, i32 0, i32 %r250

        mov     x13, #128
        mul     x14, x10, x13
        adrp     x13, e
        add     x13, x13, #:lo12:e
        add     x14, x13, x14
        //  %r175 = getelementptr %array2D, %array2D* %r174, i32 0, i32 0

        mov     x13, #0
        add     x14, x14, x13
        //  %r177 = getelementptr [16 x i32 ], [16 x i32 ]* %r175, i32 0 , i32 %r253

        mov     x13, #8
        mul     x13, x9, x13
        add     x13, x14, x13
        //  %r178 = load i32, i32* %r177

        ldr     x13, [x13]
        //  %r179 = add i32 %r172, %r178

        add     x11, x11, x13
        //  %r181 = getelementptr [16 x i32 ], [16 x i32 ]* @dis, i32 0, i32 %r253

        mov     x13, #8
        mul     x14, x9, x13
        adrp     x13, dis
        add     x13, x13, #:lo12:dis
        add     x13, x13, x14
        //  store i32 %r179, i32* %r181

        str     x11, [x13]
        //  br label %bb23


        b     bb23
        //bb22:

bb22:

        //  br label %bb23


        b     bb23
        //bb23:

bb23:

        //  br label %bb20


        b     bb20
        //bb19:

bb19:

        //  br label %bb20


        b     bb20
        //bb20:

bb20:

        //  %r255 = add i32 %r253, 1

        add     x9, x9, #1
        //  br label %bb15


        //bb15:  %r253 = phi i32 [ %r252, %bb10 ], [ %r255, %bb20 ]

        mov     x9, x9
        b     bb15
        //bb17:

bb17:

        //  %r254 = add i32 %r245, 1

        add     x9, x12, #1
        //  br label %bb5


        //bb5:  %r245 = phi i32 [ %r244, %bb4 ], [ %r254, %bb17 ]

        mov     x12, x9
        b     bb5
        //bb7:

bb7:

        //  ret void

        mov     sp, x29
        ret
        //%r379->x13
        //%r376->x11
        //%r375->x11
        //%r374->x11
        //%r373->x11
        //%r372->x11
        //%r370->x11
        //%r369->x11
        //%r368->x9
        //%r366->x9
        //%r363->x9
        //%r362->x9
        //%r361->x9
        //%r234->x10
        //%r360->x9
        //%r233->x10
        //%r359->x9
        //%r279->x9
        //%r278->x9
        //%r277->x9
        //%r276->x9
        //%r275->x9
        //%r273->x13
        //%r400->x9
        //%r272->x9
        //%r399->x9
        //%r221->x11
        //%r274->x9
        //%r215->x9
        //%r267->x10
        //%r394->x10
        //%r264->x9
        //%r391->x9
        //%r206->x13
        //%r265->x9
        //%r392->x9
        //%r371->x12
        //%r194->x11
        //%r223->x13
        //%r380->x12
        //%r262->x9
        //%r389->x12
        //%r203->x12
        //%r367->x9
        //%r190->x9
        //%r378->x12
        //%r201->x12
        //%r230->x10
        //%r365->x9
        //%r188->x10
        //%r377->x11
        //%r200->x12
        //%r364->x9
        //%r187->x10
        //%r224->x13
        //%r226->x9
        //%r204->x11
        //%r263->x9
        //%r390->x12
        //%r207->x13
        //%r266->x9
        //%r393->x10
        //%r209->x12
        //%r268->x9
        //%r395->x11
        //%r269->x10
        //%r396->x10
        //%r270->x9
        //%r397->x10
        //%r271->x9
        //%r398->x9
        //%r381->x12
        //%r382->x12
        //%r383->x12
        //%r384->x9
        //%r385->x9
        //%r386->x12
        //%r387->x13
        //%r388->x12
main:

        //bb24:

bb24:

        //  %r262 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r263 = add i32 0, 0

        mov     x9, #0
        //  %r264 = add i32 0, 0

        mov     x9, #0
        //  call void @_sysy_starttime(i32 53)

        mov     x9, #53
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
        //  %r265 = add i32 0, 0

        mov     x9, #0
        //  %r187 = call i32 @getint()

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
        mov     x10, x0
        //  store i32 %r187, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     x10, [x9]
        //  %r188 = call i32 @getint()

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
        mov     x10, x0
        //  store i32 %r188, i32* @m

        adrp     x9, m
        add     x9, x9, #:lo12:m
        str     x10, [x9]
        //  %r266 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb25


        //bb25:  %r267 = phi i32 [ %r266, %bb24 ], [ %r278, %bb30 ]

        mov     x10, x9
        b     bb25
        //bb25:

bb25:

        //  %r267 = phi i32 [ %r266, %bb24 ], [ %r278, %bb30 ]

        //  %r190 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r191 = icmp sle i32 %r267, %r190

        cmp     x10, x9
        //  br i1 %r191, label %bb26, label %bb27


        b.le     bb26
        b     bb27
        //bb26:

bb26:

        //  %r276 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb28


        //bb28:  %r277 = phi i32 [ %r276, %bb26 ], [ %r279, %bb33 ]

        mov     x9, x9
        b     bb28
        //bb28:

bb28:

        //  %r277 = phi i32 [ %r276, %bb26 ], [ %r279, %bb33 ]

        //  %r194 = load i32, i32* @n

        adrp     x11, n
        add     x11, x11, #:lo12:n
        ldr     x11, [x11]
        //  %r195 = icmp sle i32 %r277, %r194

        cmp     x9, x11
        //  br i1 %r195, label %bb29, label %bb30


        b.le     bb29
        b     bb30
        //bb29:

bb29:

        //  %r198 = icmp eq i32 %r267, %r277

        cmp     x10, x9
        //  br i1 %r198, label %bb31, label %bb32


        b.eq     bb31
        b     bb32
        //bb31:

bb31:

        //  %r200 = getelementptr [16 x %array2D ], [16 x %array2D ]* @e, i32 0, i32 %r267

        mov     x11, #128
        mul     x12, x10, x11
        adrp     x11, e
        add     x11, x11, #:lo12:e
        add     x12, x11, x12
        //  %r201 = getelementptr %array2D, %array2D* %r200, i32 0, i32 0

        mov     x11, #0
        add     x12, x12, x11
        //  %r203 = getelementptr [16 x i32 ], [16 x i32 ]* %r201, i32 0 , i32 %r277

        mov     x11, #8
        mul     x11, x9, x11
        add     x12, x12, x11
        //  store i32 0, i32* %r203

        mov     x11, #0
        str     x11, [x12]
        //  br label %bb33


        b     bb33
        //bb32:

bb32:

        //  %r204 = load i32, i32* @INF

        adrp     x11, INF
        add     x11, x11, #:lo12:INF
        ldr     x11, [x11]
        //  %r206 = getelementptr [16 x %array2D ], [16 x %array2D ]* @e, i32 0, i32 %r267

        mov     x12, #128
        mul     x13, x10, x12
        adrp     x12, e
        add     x12, x12, #:lo12:e
        add     x13, x12, x13
        //  %r207 = getelementptr %array2D, %array2D* %r206, i32 0, i32 0

        mov     x12, #0
        add     x13, x13, x12
        //  %r209 = getelementptr [16 x i32 ], [16 x i32 ]* %r207, i32 0 , i32 %r277

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x13, x12
        //  store i32 %r204, i32* %r209

        str     x11, [x12]
        //  br label %bb33


        b     bb33
        //bb33:

bb33:

        //  %r279 = add i32 %r277, 1

        add     x9, x9, #1
        //  br label %bb28


        //bb28:  %r277 = phi i32 [ %r276, %bb26 ], [ %r279, %bb33 ]

        mov     x9, x9
        b     bb28
        //bb30:

bb30:

        //  %r278 = add i32 %r267, 1

        add     x9, x10, #1
        //  br label %bb25


        //bb25:  %r267 = phi i32 [ %r266, %bb24 ], [ %r278, %bb30 ]

        mov     x10, x9
        b     bb25
        //bb27:

bb27:

        //  %r268 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb34


        //bb34:  %r269 = phi i32 [ %r268, %bb27 ], [ %r275, %bb35 ]

        mov     x10, x9
        b     bb34
        //bb34:

bb34:

        //  %r269 = phi i32 [ %r268, %bb27 ], [ %r275, %bb35 ]

        //  %r215 = load i32, i32* @m

        adrp     x9, m
        add     x9, x9, #:lo12:m
        ldr     x9, [x9]
        //  %r216 = icmp sle i32 %r269, %r215

        cmp     x10, x9
        //  br i1 %r216, label %bb35, label %bb36


        b.le     bb35
        b     bb36
        //bb35:

bb35:

        //  %r273 = call i32 @getint()

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
        //  %r274 = call i32 @getint()

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
        mov     x9, x0
        //  %r221 = call i32 @getint()

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
        mov     x11, x0
        //  %r223 = getelementptr [16 x %array2D ], [16 x %array2D ]* @e, i32 0, i32 %r273

        mov     x12, #128
        mul     x13, x13, x12
        adrp     x12, e
        add     x12, x12, #:lo12:e
        add     x13, x12, x13
        //  %r224 = getelementptr %array2D, %array2D* %r223, i32 0, i32 0

        mov     x12, #0
        add     x13, x13, x12
        //  %r226 = getelementptr [16 x i32 ], [16 x i32 ]* %r224, i32 0 , i32 %r274

        mov     x12, #8
        mul     x9, x9, x12
        add     x9, x13, x9
        //  store i32 %r221, i32* %r226

        str     x11, [x9]
        //  %r275 = add i32 %r269, 1

        add     x9, x10, #1
        //  br label %bb34


        //bb34:  %r269 = phi i32 [ %r268, %bb27 ], [ %r275, %bb35 ]

        mov     x10, x9
        b     bb34
        //bb36:

bb36:

        //  call void @Dijkstra()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     Dijkstra
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r270 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb37


        //bb37:  %r271 = phi i32 [ %r270, %bb36 ], [ %r272, %bb38 ]

        mov     x9, x9
        b     bb37
        //bb37:

bb37:

        //  %r271 = phi i32 [ %r270, %bb36 ], [ %r272, %bb38 ]

        //  %r230 = load i32, i32* @n

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     x10, [x10]
        //  %r231 = icmp sle i32 %r271, %r230

        cmp     x9, x10
        //  br i1 %r231, label %bb38, label %bb39


        b.le     bb38
        b     bb39
        //bb38:

bb38:

        //  %r233 = getelementptr [16 x i32 ], [16 x i32 ]* @dis, i32 0, i32 %r271

        mov     x10, #8
        mul     x11, x9, x10
        adrp     x10, dis
        add     x10, x10, #:lo12:dis
        add     x10, x10, x11
        //  %r234 = load i32, i32* %r233

        ldr     x10, [x10]
        //  call void @putint(i32 %r234)

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
        //  call void @putch(i32 32)

        mov     x10, #32
        mov     x0, x10
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
        //  %r272 = add i32 %r271, 1

        add     x9, x9, #1
        //  br label %bb37


        //bb37:  %r271 = phi i32 [ %r270, %bb36 ], [ %r272, %bb38 ]

        mov     x9, x9
        b     bb37
        //bb39:

bb39:

        //  call void @putch(i32 10)

        mov     x9, #10
        mov     x0, x9
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
        //  call void @_sysy_stoptime(i32 91)

        mov     x9, #91
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
