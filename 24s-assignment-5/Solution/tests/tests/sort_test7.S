.section .data
.global    n
n:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global Merge
.global MergeSort
.global main
        //%r377->x11
        //%r376->x11
        //%r375->x12
        //%r374->x11
        //%r373->x9
        //%r372->x9
        //%r371->x9
        //%r370->x9
        //%r369->x10
        //%r368->x9
        //%r367->x9
        //%r110->x10
        //%r366->x9
        //%r365->x9
        //%r363->x10
        //%r362->x9
        //%r105->x9
        //%r361->x9
        //%r360->x9
        //%r103->x10
        //%r358->x9
        //%r101->x11
        //%r356->x9
        //%r353->x10
        //%r352->x9
        //%r351->x9
        //%r350->x9
        //%r349->x10
        //%r348->x9
        //%r347->x10
        //%r346->x9
        //%r345->x9
        //%r344->x9
        //%r343->x10
        //%r342->x9
        //%r341->x9
        //%r340->x9
        //%r339->x9
        //%r338->x9
        //%r337->x10
        //%r336->x9
        //%r335->x9
        //%r334->x9
        //%r333->x10
        //%r332->x9
        //%r331->x10
        //%r330->x11
        //%r329->x12
        //%r327->x12
        //%r324->x12
        //%r323->x12
        //%r300->x9
        //%r299->x10
        //%r298->x9
        //%r297->x10
        //%r296->x10
        //%r294->x9
        //%r291->x9
        //%r290->x10
        //%r326->x12
        //%r199->x11
        //%r325->x12
        //%r198->x11
        //%r177->x9
        //%r302->x9
        //%r175->x10
        //%r293->x10
        //%r166->x10
        //%r292->x11
        //%r165->x9
        //%r283->x13
        //%r357->x10
        //%r100->[sp,#0]
        //%r280->x10
        //%r355->x9
        //%r278->x9
        //%r279->x11
        //%r187->x10
        //%r128->x9
        //%r276->x11
        //%r354->x9
        //%r277->x11
        //%r129->[sp,#8]
        //%r328->x12
        //%r201->x12
        //%r260->x9
        //%r359->x9
        //%r282->x11
        //%r189->x9
        //%r131->x9
        //%r295->x9
        //%r168->x9
        //%r286->x10
        //%r364->x9
        //%r160->x9
        //%r287->x9
        //%r186->x9
        //%r284->x12
        //%r157->x9
        //%r275->x12
        //%r261->x9
        //%r301->x10
        //%r174->x9
        //%r263->x9
        //%r262->x9
        //%r264->x9
        //%r265->x9
        //%r139->x9
        //%r266->x9
        //%r267->x9
        //%r268->x9
        //%r142->x9
        //%r269->x14
        //%r143->x12
        //%r270->x13
        //%r271->x9
        //%r145->x9
        //%r272->[sp,#16]
        //%r273->x15
        //%r274->x9
        //%r281->x14
        //%r158->x12
        //%r285->x11
        //%r161->x9
        //%r288->x11
        //%r162->x9
        //%r289->x9
        //%r378->x12
        //%r379->x12
        //%r380->x9
Merge:

        //116:x29,#-160

        //117:x29,#-80

        //bb29:

bb29:

        //  %r260 = add i32 0, 0

        mov     x16, #184
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x11, x1
        mov     x10, x2
        mov     x9, x3
        mov     x12, #0
        //  %r261 = add i32 0, 0

        mov     x12, #0
        //  %r262 = add i32 0, 0

        mov     x12, #0
        //  %r263 = add i32 0, 0

        mov     x12, #0
        //  %r117 = alloca [ 10 x i32 ]

        //  %r116 = alloca [ 10 x i32 ]

        //  %r264 = add i32 0, 0

        mov     x12, #0
        //  %r265 = add i32 0, 0

        mov     x12, #0
        //  %r266 = add i32 0, 0

        mov     x12, #0
        //  %r269 = add i32 %r101, 0

        mov     x14, x11
        //  %r267 = add i32 0, 0

        mov     x11, #0
        //  %r270 = add i32 %r103, 0

        mov     x13, x10
        //  %r268 = add i32 0, 0

        mov     x10, #0
        //  %r271 = add i32 %r105, 0

        mov     x9, x9
        //  %r110 = sub i32 %r270, %r269

        sub     x10, x13, x14
        //  %r272 = add i32 %r110, 1

        add     x16, x10, #1
        mov     x17, #16
        str     x16, [sp,x17]
        //  %r273 = sub i32 %r271, %r270

        sub     x15, x9, x13
        //  %r274 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  %r275 = add i32 0, 0

        mov     x10, #0
        mov     x12, x10
        //  br label %bb2


        //bb2:  %r276 = phi i32 [ %r274, %bb29 ], [ %r302, %bb3 ]

        mov     x11, x9
        b     bb2
        //bb2:

bb2:

        //  %r276 = phi i32 [ %r274, %bb29 ], [ %r302, %bb3 ]

        //  %r123 = icmp slt i32 %r276, %r272

        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     x11, x19
        //  br i1 %r123, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r301 = add i32 %r276, %r269

        add     x10, x11, x14
        //  %r128 = getelementptr i32, i32* %r100, i32 %r301

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r129 = load i32, i32* %r128

        ldr     x16, [x9]
        mov     x17, #8
        str     x16, [sp,x17]
        //  %r131 = getelementptr [10 x i32 ], [10 x i32 ]* %r116, i32 0 , i32 %r276

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r129, i32* %r131

        mov     x16, #8
        ldr     x19, [sp,x16]
        str     x19, [x9]
        //  %r302 = add i32 %r276, 1

        add     x9, x11, #1
        //  br label %bb2


        //bb2:  %r276 = phi i32 [ %r274, %bb29 ], [ %r302, %bb3 ]

        mov     x11, x9
        b     bb2
        //bb4:

bb4:

        //  br label %bb5


        //bb5:  %r277 = phi i32 [ %r275, %bb4 ], [ %r300, %bb6 ]

        mov     x11, x12
        b     bb5
        //bb5:

bb5:

        //  %r277 = phi i32 [ %r275, %bb4 ], [ %r300, %bb6 ]

        //  %r136 = icmp slt i32 %r277, %r273

        cmp     x11, x15
        //  br i1 %r136, label %bb6, label %bb7


        b.lt     bb6
        b     bb7
        //bb6:

bb6:

        //  %r139 = add i32 %r277, %r270

        add     x9, x11, x13
        //  %r299 = add i32 %r139, 1

        add     x10, x9, #1
        //  %r142 = getelementptr i32, i32* %r100, i32 %r299

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r143 = load i32, i32* %r142

        ldr     x12, [x9]
        //  %r145 = getelementptr [10 x i32 ], [10 x i32 ]* %r117, i32 0 , i32 %r277

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r143, i32* %r145

        str     x12, [x9]
        //  %r300 = add i32 %r277, 1

        add     x9, x11, #1
        //  br label %bb5


        //bb5:  %r277 = phi i32 [ %r275, %bb4 ], [ %r300, %bb6 ]

        mov     x11, x9
        b     bb5
        //bb7:

bb7:

        //  %r278 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  %r279 = add i32 0, 0

        mov     x10, #0
        mov     x11, x10
        //  %r280 = add i32 %r269, 0

        mov     x10, x14
        //  br label %bb8


        //bb8:  %r281 = phi i32 [ %r279, %bb7 ], [ %r292, %bb14 ]

        mov     x14, x11
        //bb8:  %r282 = phi i32 [ %r280, %bb7 ], [ %r293, %bb14 ]

        mov     x11, x10
        //bb8:  %r283 = phi i32 [ %r278, %bb7 ], [ %r294, %bb14 ]

        mov     x13, x9
        b     bb8
        //bb8:

bb8:

        //  %r281 = phi i32 [ %r279, %bb7 ], [ %r292, %bb14 ]

        //  %r282 = phi i32 [ %r280, %bb7 ], [ %r293, %bb14 ]

        //  %r283 = phi i32 [ %r278, %bb7 ], [ %r294, %bb14 ]

        //  %r152 = icmp ne i32 %r283, %r272

        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     x13, x19
        //  br i1 %r152, label %bb11, label %bb10


        b.ne     bb11
        b     bb10
        //bb11:

bb11:

        //  %r155 = icmp ne i32 %r281, %r273

        cmp     x14, x15
        //  br i1 %r155, label %bb9, label %bb10


        b.ne     bb9
        b     bb10
        //bb9:

bb9:

        //  %r157 = getelementptr [10 x i32 ], [10 x i32 ]* %r116, i32 0 , i32 %r283

        mov     x9, #8
        mul     x10, x13, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r158 = load i32, i32* %r157

        ldr     x12, [x9]
        //  %r160 = getelementptr [10 x i32 ], [10 x i32 ]* %r117, i32 0 , i32 %r281

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r161 = load i32, i32* %r160

        ldr     x9, [x9]
        //  %r162 = add i32 %r161, 1

        add     x9, x9, #1
        //  %r163 = icmp slt i32 %r158, %r162

        cmp     x12, x9
        //  br i1 %r163, label %bb12, label %bb13


        b.lt     bb12
        b     bb13
        //bb12:

bb12:

        //  %r165 = getelementptr [10 x i32 ], [10 x i32 ]* %r116, i32 0 , i32 %r283

        mov     x9, #8
        mul     x10, x13, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r166 = load i32, i32* %r165

        ldr     x10, [x9]
        //  %r168 = getelementptr i32, i32* %r100, i32 %r282

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  store i32 %r166, i32* %r168

        str     x10, [x9]
        //  %r297 = add i32 %r282, 1

        add     x10, x11, #1
        //  %r298 = add i32 %r283, 1

        add     x9, x13, #1
        //  br label %bb14


        //bb14:  %r292 = phi i32 [ %r281, %bb12 ], [ %r296, %bb13 ]

        mov     x11, x14
        //bb14:  %r293 = phi i32 [ %r297, %bb12 ], [ %r295, %bb13 ]

        mov     x10, x10
        //bb14:  %r294 = phi i32 [ %r298, %bb12 ], [ %r283, %bb13 ]

        mov     x9, x9
        b     bb14
        //bb13:

bb13:

        //  %r174 = getelementptr [10 x i32 ], [10 x i32 ]* %r117, i32 0 , i32 %r281

        mov     x9, #8
        mul     x10, x14, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r175 = load i32, i32* %r174

        ldr     x10, [x9]
        //  %r177 = getelementptr i32, i32* %r100, i32 %r282

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  store i32 %r175, i32* %r177

        str     x10, [x9]
        //  %r295 = add i32 %r282, 1

        add     x9, x11, #1
        //  %r296 = add i32 %r281, 1

        add     x10, x14, #1
        //  br label %bb14


        //bb14:  %r292 = phi i32 [ %r281, %bb12 ], [ %r296, %bb13 ]

        mov     x11, x10
        //bb14:  %r293 = phi i32 [ %r297, %bb12 ], [ %r295, %bb13 ]

        mov     x10, x9
        //bb14:  %r294 = phi i32 [ %r298, %bb12 ], [ %r283, %bb13 ]

        mov     x9, x13
        b     bb14
        //bb14:

bb14:

        //  %r292 = phi i32 [ %r281, %bb12 ], [ %r296, %bb13 ]

        //  %r293 = phi i32 [ %r297, %bb12 ], [ %r295, %bb13 ]

        //  %r294 = phi i32 [ %r298, %bb12 ], [ %r283, %bb13 ]

        //  br label %bb8


        //bb8:  %r281 = phi i32 [ %r279, %bb7 ], [ %r292, %bb14 ]

        mov     x14, x11
        //bb8:  %r282 = phi i32 [ %r280, %bb7 ], [ %r293, %bb14 ]

        mov     x11, x10
        //bb8:  %r283 = phi i32 [ %r278, %bb7 ], [ %r294, %bb14 ]

        mov     x13, x9
        b     bb8
        //bb10:

bb10:

        //  br label %bb15


        //bb15:  %r284 = phi i32 [ %r282, %bb10 ], [ %r290, %bb16 ]

        mov     x12, x11
        //bb15:  %r285 = phi i32 [ %r283, %bb10 ], [ %r291, %bb16 ]

        mov     x11, x13
        b     bb15
        //bb15:

bb15:

        //  %r284 = phi i32 [ %r282, %bb10 ], [ %r290, %bb16 ]

        //  %r285 = phi i32 [ %r283, %bb10 ], [ %r291, %bb16 ]

        //  %r184 = icmp slt i32 %r285, %r272

        mov     x16, #16
        ldr     x19, [sp,x16]
        cmp     x11, x19
        //  br i1 %r184, label %bb16, label %bb17


        b.lt     bb16
        b     bb17
        //bb16:

bb16:

        //  %r186 = getelementptr [10 x i32 ], [10 x i32 ]* %r116, i32 0 , i32 %r285

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-160
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r187 = load i32, i32* %r186

        ldr     x10, [x9]
        //  %r189 = getelementptr i32, i32* %r100, i32 %r284

        mov     x9, #8
        mul     x9, x12, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  store i32 %r187, i32* %r189

        str     x10, [x9]
        //  %r290 = add i32 %r284, 1

        add     x10, x12, #1
        //  %r291 = add i32 %r285, 1

        add     x9, x11, #1
        //  br label %bb15


        //bb15:  %r284 = phi i32 [ %r282, %bb10 ], [ %r290, %bb16 ]

        mov     x12, x10
        //bb15:  %r285 = phi i32 [ %r283, %bb10 ], [ %r291, %bb16 ]

        mov     x11, x9
        b     bb15
        //bb17:

bb17:

        //  br label %bb18


        //bb18:  %r286 = phi i32 [ %r281, %bb17 ], [ %r289, %bb19 ]

        mov     x10, x14
        //bb18:  %r287 = phi i32 [ %r284, %bb17 ], [ %r288, %bb19 ]

        mov     x9, x12
        b     bb18
        //bb18:

bb18:

        //  %r286 = phi i32 [ %r281, %bb17 ], [ %r289, %bb19 ]

        //  %r287 = phi i32 [ %r284, %bb17 ], [ %r288, %bb19 ]

        //  %r196 = icmp slt i32 %r286, %r273

        cmp     x10, x15
        //  br i1 %r196, label %bb19, label %bb20


        b.lt     bb19
        b     bb20
        //bb19:

bb19:

        //  %r198 = getelementptr [10 x i32 ], [10 x i32 ]* %r117, i32 0 , i32 %r286

        mov     x11, #8
        mul     x12, x10, x11
        mov     x11, #-80
        add     x11, x29, x11
        add     x11, x11, x12
        //  %r199 = load i32, i32* %r198

        ldr     x11, [x11]
        //  %r201 = getelementptr i32, i32* %r100, i32 %r287

        mov     x12, #8
        mul     x12, x9, x12
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x12, x19, x12
        //  store i32 %r199, i32* %r201

        str     x11, [x12]
        //  %r288 = add i32 %r287, 1

        add     x11, x9, #1
        //  %r289 = add i32 %r286, 1

        add     x9, x10, #1
        //  br label %bb18


        //bb18:  %r286 = phi i32 [ %r281, %bb17 ], [ %r289, %bb19 ]

        mov     x10, x9
        //bb18:  %r287 = phi i32 [ %r284, %bb17 ], [ %r288, %bb19 ]

        mov     x9, x11
        b     bb18
        //bb20:

bb20:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r309->x12
        //%r307->x9
        //%r306->x9
        //%r305->x9
        //%r304->x9
        //%r217->x12
        //%r303->x9
        //%r308->x13
        //%r209->x10
        //%r383->x9
        //%r311->x10
        //%r207->x12
        //%r381->x9
        //%r310->x9
        //%r206->x11
        //%r312->x9
        //%r313->x9
        //%r382->x9
        //%r384->x12
        //%r385->x10
        //%r386->x9
MergeSort:

        //bb30:

bb30:

        //  %r303 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x12, x1
        mov     x10, x2
        mov     x9, #0
        //  %r304 = add i32 0, 0

        mov     x9, #0
        //  %r305 = add i32 0, 0

        mov     x9, #0
        //  %r307 = add i32 %r207, 0

        mov     x9, x12
        //  %r306 = add i32 0, 0

        mov     x12, #0
        //  %r308 = add i32 %r209, 0

        mov     x13, x10
        //  %r213 = icmp slt i32 %r307, %r308

        cmp     x9, x13
        //  br i1 %r213, label %bb22, label %bb23


        b.lt     bb22
        b     bb23
        //bb22:

bb22:

        //  %r217 = add i32 %r307, %r308

        add     x12, x9, x13
        //  %r309 = sdiv i32 %r217, 2

        mov     x10, #2
        sdiv     x12, x12, x10
        //  %r310 = call i32 @MergeSort(i32* %r206, i32 %r307, i32 %r309)

        mov     x0, x11
        mov     x1, x9
        mov     x2, x12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r311 = add i32 %r309, 1

        add     x10, x12, #1
        //  %r312 = call i32 @MergeSort(i32* %r206, i32 %r311, i32 %r308)

        mov     x0, x11
        mov     x1, x10
        mov     x2, x13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r313 = call i32 @Merge(i32* %r206, i32 %r307, i32 %r309, i32 %r308)

        mov     x0, x11
        mov     x1, x9
        mov     x2, x12
        mov     x3, x13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     Merge
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb24


        b     bb24
        //bb23:

bb23:

        //  br label %bb24


        b     bb24
        //bb24:

bb24:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r423->x9
        //%r421->x9
        //%r420->x10
        //%r409->x9
        //%r408->x10
        //%r407->x9
        //%r406->x9
        //%r405->x9
        //%r404->x10
        //%r403->x9
        //%r402->x10
        //%r401->x9
        //%r400->x9
        //%r399->x9
        //%r398->x10
        //%r397->x9
        //%r396->x10
        //%r395->x9
        //%r394->x9
        //%r422->x10
        //%r245->x9
        //%r390->x10
        //%r419->x9
        //%r242->x10
        //%r387->x9
        //%r254->x10
        //%r418->x9
        //%r241->x10
        //%r417->x9
        //%r240->x10
        //%r416->x10
        //%r239->x10
        //%r251->x10
        //%r415->x9
        //%r238->x10
        //%r414->x10
        //%r237->x10
        //%r413->x9
        //%r236->x10
        //%r412->x9
        //%r235->x10
        //%r322->x9
        //%r449->x9
        //%r411->x9
        //%r234->x10
        //%r321->x10
        //%r448->x9
        //%r410->x10
        //%r233->x10
        //%r320->x10
        //%r447->x9
        //%r314->x9
        //%r441->x9
        //%r315->x9
        //%r442->x9
        //%r316->x11
        //%r443->x9
        //%r317->x10
        //%r444->x10
        //%r318->x9
        //%r445->x9
        //%r319->x9
        //%r446->x10
        //%r388->x10
        //%r389->x9
        //%r391->x9
        //%r392->x10
        //%r393->x9
        //%r424->x9
        //%r425->x9
        //%r426->x10
        //%r427->x9
        //%r428->x10
        //%r429->x9
        //%r430->x9
        //%r431->x9
        //%r432->x10
        //%r433->x9
        //%r434->x10
        //%r435->x9
        //%r436->x9
        //%r437->x9
        //%r438->x10
        //%r439->x9
        //%r440->x10
        //%r450->x9
        //%r451->x9
        //%r452->x9
        //%r453->x9
        //%r454->x9
        //%r455->x9
        //%r456->x10
        //%r457->x10
        //%r458->x11
        //%r459->x10
        //%r460->x10
        //%r461->x10
        //%r462->x9
        //%r463->x9
main:

        //232:x29,#-80

        //bb25:

bb25:

        //  call void @_sysy_starttime(i32 71)

        mov     x16, #80
        sub     sp, sp, x16
        mov     x9, #71
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
        //  store i32 10, i32* @n

        mov     x10, #10
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     x10, [x9]
        //  %r232 = alloca [ 10 x i32 ]

        //  %r233 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 4, i32* %r233

        mov     x9, #4
        str     x9, [x10]
        //  %r234 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r234

        mov     x9, #3
        str     x9, [x10]
        //  %r235 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 9, i32* %r235

        mov     x9, #9
        str     x9, [x10]
        //  %r236 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r236

        mov     x9, #2
        str     x9, [x10]
        //  %r237 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r237

        mov     x9, #0
        str     x9, [x10]
        //  %r238 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 5

        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r238

        mov     x9, #1
        str     x9, [x10]
        //  %r239 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 6

        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 6, i32* %r239

        mov     x9, #6
        str     x9, [x10]
        //  %r240 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 5, i32* %r240

        mov     x9, #5
        str     x9, [x10]
        //  %r241 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 8

        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r241

        mov     x9, #7
        str     x9, [x10]
        //  %r242 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 9

        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 8, i32* %r242

        mov     x9, #8
        str     x9, [x10]
        //  %r314 = add i32 0, 0

        mov     x9, #0
        //  %r316 = add i32 0, 0

        mov     x9, #0
        mov     x11, x9
        //  %r315 = add i32 0, 0

        mov     x9, #0
        //  %r245 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r317 = sub i32 %r245, 1

        sub     x10, x9, #1
        //  %r318 = call i32 @MergeSort(i32* %r232, i32 %r316, i32 %r317)

        mov     x9, #-80
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x11
        mov     x2, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     MergeSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb26


        //bb26:  %r319 = phi i32 [ %r318, %bb25 ], [ %r322, %bb27 ]

        mov     x9, x9
        b     bb26
        //bb26:

bb26:

        //  %r319 = phi i32 [ %r318, %bb25 ], [ %r322, %bb27 ]

        //  %r251 = load i32, i32* @n

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     x10, [x10]
        //  %r252 = icmp slt i32 %r319, %r251

        cmp     x9, x10
        //  br i1 %r252, label %bb27, label %bb28


        b.lt     bb27
        b     bb28
        //bb27:

bb27:

        //  %r254 = getelementptr [10 x i32 ], [10 x i32 ]* %r232, i32 0 , i32 %r319

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-80
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r320 = load i32, i32* %r254

        ldr     x10, [x10]
        //  call void @putint(i32 %r320)

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
        //  %r321 = add i32 10, 0

        mov     x10, #10
        mov     x10, x10
        //  call void @putch(i32 %r321)

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
        //  %r322 = add i32 %r319, 1

        add     x9, x9, #1
        //  br label %bb26


        //bb26:  %r319 = phi i32 [ %r318, %bb25 ], [ %r322, %bb27 ]

        mov     x9, x9
        b     bb26
        //bb28:

bb28:

        //  call void @_sysy_stoptime(i32 97)

        mov     x9, #97
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
