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
.global swap
.global heap_ajust
.global heap_sort
.global main
        //%r223->x12
        //%r107->x10
        //%r222->x13
        //%r221->x9
        //%r219->x9
        //%r103->x11
        //%r277->x10
        //%r111->x14
        //%r110->x10
        //%r220->x9
        //%r278->x9
        //%r116->x9
        //%r101->x12
        //%r275->x10
        //%r113->x10
        //%r100->x9
        //%r274->x10
        //%r224->x11
        //%r267->x10
        //%r268->x10
        //%r269->x10
        //%r270->x10
        //%r271->x10
        //%r272->x10
        //%r273->x10
        //%r276->x10
swap:

        //bb24:

bb24:

        //  %r219 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     x12, x1
        mov     x11, x2
        mov     x10, #0
        //  %r220 = add i32 0, 0

        mov     x10, #0
        //  %r222 = add i32 %r101, 0

        mov     x13, x12
        //  %r221 = add i32 0, 0

        mov     x10, #0
        //  %r223 = add i32 %r103, 0

        mov     x12, x11
        //  %r107 = getelementptr i32, i32* %r100, i32 %r222

        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x9, x10
        //  %r224 = load i32, i32* %r107

        ldr     x11, [x10]
        //  %r110 = getelementptr i32, i32* %r100, i32 %r223

        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x9, x10
        //  %r111 = load i32, i32* %r110

        ldr     x14, [x10]
        //  %r113 = getelementptr i32, i32* %r100, i32 %r222

        mov     x10, #8
        mul     x10, x13, x10
        add     x10, x9, x10
        //  store i32 %r111, i32* %r113

        str     x14, [x10]
        //  %r116 = getelementptr i32, i32* %r100, i32 %r223

        mov     x10, #8
        mul     x10, x12, x10
        add     x9, x9, x10
        //  store i32 %r224, i32* %r116

        str     x11, [x9]
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r237->x13
        //%r232->x13
        //%r291->x12
        //%r231->x10
        //%r290->x12
        //%r228->x9
        //%r287->x12
        //%r225->x9
        //%r284->x9
        //%r233->x12
        //%r292->x12
        //%r117->x11
        //%r235->x14
        //%r294->x9
        //%r159->x9
        //%r130->x12
        //%r230->x12
        //%r289->x12
        //%r143->x12
        //%r234->x9
        //%r293->x9
        //%r118->x12
        //%r236->x13
        //%r295->x9
        //%r126->x9
        //%r226->x9
        //%r285->x12
        //%r139->x12
        //%r239->x13
        //%r152->x12
        //%r227->x9
        //%r286->x12
        //%r140->x15
        //%r229->x9
        //%r288->x12
        //%r142->x12
        //%r148->x12
        //%r120->x10
        //%r238->x9
        //%r149->x14
        //%r151->x12
        //%r240->x12
        //%r241->x12
        //%r279->x9
        //%r280->x9
        //%r281->x9
        //%r282->x9
        //%r283->x9
heap_ajust:

        //bb25:

bb25:

        //  %r225 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x12, x1
        mov     x10, x2
        mov     x9, #0
        //  %r226 = add i32 0, 0

        mov     x9, #0
        //  %r227 = add i32 0, 0

        mov     x9, #0
        //  %r228 = add i32 0, 0

        mov     x9, #0
        //  %r230 = add i32 %r118, 0

        mov     x12, x12
        //  %r229 = add i32 0, 0

        mov     x9, #0
        //  %r231 = add i32 %r120, 0

        mov     x10, x10
        //  %r232 = add i32 %r230, 0

        mov     x13, x12
        //  %r126 = mul i32 %r232, 2

        mov     x9, #2
        mul     x9, x13, x9
        //  %r233 = add i32 %r126, 1

        add     x12, x9, #1
        //  br label %bb3


        //bb3:  %r234 = phi i32 [ %r232, %bb25 ], [ %r239, %bb11 ]

        mov     x9, x13
        //bb3:  %r235 = phi i32 [ %r233, %bb25 ], [ %r240, %bb11 ]

        mov     x14, x12
        b     bb3
        //bb3:

bb3:

        //  %r234 = phi i32 [ %r232, %bb25 ], [ %r239, %bb11 ]

        //  %r235 = phi i32 [ %r233, %bb25 ], [ %r240, %bb11 ]

        //  %r130 = add i32 %r231, 1

        add     x12, x10, #1
        //  %r131 = icmp slt i32 %r235, %r130

        cmp     x14, x12
        //  br i1 %r131, label %bb4, label %bb5


        b.lt     bb4
        b     bb5
        //bb4:

bb4:

        //  %r236 = add i32 %r235, 1

        add     x13, x14, #1
        //  %r137 = icmp slt i32 %r235, %r231

        cmp     x14, x10
        //  br i1 %r137, label %bb9, label %bb7


        b.lt     bb9
        b     bb7
        //bb9:

bb9:

        //  %r139 = getelementptr i32, i32* %r117, i32 %r235

        mov     x12, #8
        mul     x12, x14, x12
        add     x12, x11, x12
        //  %r140 = load i32, i32* %r139

        ldr     x15, [x12]
        //  %r142 = getelementptr i32, i32* %r117, i32 %r236

        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x11, x12
        //  %r143 = load i32, i32* %r142

        ldr     x12, [x12]
        //  %r144 = icmp slt i32 %r140, %r143

        cmp     x15, x12
        //  br i1 %r144, label %bb6, label %bb7


        b.lt     bb6
        b     bb7
        //bb6:

bb6:

        //  %r241 = add i32 %r235, 1

        add     x12, x14, #1
        //  br label %bb8


        //bb8:  %r237 = phi i32 [ %r241, %bb6 ], [ %r235, %bb7 ]

        mov     x13, x12
        b     bb8
        //bb7:

bb7:

        //  br label %bb8


        //bb8:  %r237 = phi i32 [ %r241, %bb6 ], [ %r235, %bb7 ]

        mov     x13, x14
        b     bb8
        //bb8:

bb8:

        //  %r237 = phi i32 [ %r241, %bb6 ], [ %r235, %bb7 ]

        //  %r148 = getelementptr i32, i32* %r117, i32 %r234

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        //  %r149 = load i32, i32* %r148

        ldr     x14, [x12]
        //  %r151 = getelementptr i32, i32* %r117, i32 %r237

        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x11, x12
        //  %r152 = load i32, i32* %r151

        ldr     x12, [x12]
        //  %r153 = icmp sgt i32 %r149, %r152

        cmp     x14, x12
        //  br i1 %r153, label %bb10, label %bb11


        b.gt     bb10
        b     bb11
        //bb10:

bb10:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //bb11:

bb11:

        //  %r238 = call i32 @swap(i32* %r117, i32 %r234, i32 %r237)

        mov     x0, x11
        mov     x1, x9
        mov     x2, x13
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     swap
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r239 = add i32 %r237, 0

        mov     x13, x13
        //  %r159 = mul i32 %r239, 2

        mov     x9, #2
        mul     x9, x13, x9
        //  %r240 = add i32 %r159, 1

        add     x12, x9, #1
        //  br label %bb3


        //bb3:  %r234 = phi i32 [ %r232, %bb25 ], [ %r239, %bb11 ]

        mov     x9, x13
        //bb3:  %r235 = phi i32 [ %r233, %bb25 ], [ %r240, %bb11 ]

        mov     x14, x12
        b     bb3
        //bb5:

bb5:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r299->x10
        //%r298->x10
        //%r297->x10
        //%r296->x10
        //%r258->x10
        //%r256->x10
        //%r255->x10
        //%r253->x10
        //%r252->x9
        //%r251->x11
        //%r254->x9
        //%r167->x10
        //%r303->x10
        //%r244->x9
        //%r245->x9
        //%r304->x9
        //%r257->x9
        //%r170->x10
        //%r161->x9
        //%r248->x11
        //%r300->x10
        //%r242->x9
        //%r301->x10
        //%r243->x9
        //%r302->x10
        //%r246->x12
        //%r247->x10
        //%r162->x11
        //%r249->x10
        //%r250->x12
heap_sort:

        //bb27:

bb27:

        //  %r242 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     x11, x1
        mov     x10, #0
        //  %r243 = add i32 0, 0

        mov     x10, #0
        //  %r244 = add i32 0, 0

        mov     x10, #0
        //  %r245 = add i32 0, 0

        mov     x10, #0
        //  %r246 = add i32 %r162, 0

        mov     x12, x11
        //  %r167 = sdiv i32 %r246, 2

        mov     x10, #2
        sdiv     x10, x12, x10
        //  %r247 = sub i32 %r167, 1

        sub     x10, x10, #1
        //  br label %bb14


        //bb14:  %r248 = phi i32 [ %r247, %bb27 ], [ %r258, %bb15 ]

        mov     x11, x10
        b     bb14
        //bb14:

bb14:

        //  %r248 = phi i32 [ %r247, %bb27 ], [ %r258, %bb15 ]

        //  %r170 = sub i32 0, 1

        mov     x10, #0
        sub     x10, x10, #1
        //  %r171 = icmp sgt i32 %r248, %r170

        cmp     x11, x10
        //  br i1 %r171, label %bb15, label %bb16


        b.gt     bb15
        b     bb16
        //bb15:

bb15:

        //  %r256 = sub i32 %r246, 1

        sub     x10, x12, #1
        //  %r257 = call i32 @heap_ajust(i32* %r161, i32 %r248, i32 %r256)

        mov     x0, x9
        mov     x1, x11
        mov     x2, x10
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     heap_ajust
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r258 = sub i32 %r248, 1

        sub     x10, x11, #1
        //  br label %bb14


        //bb14:  %r248 = phi i32 [ %r247, %bb27 ], [ %r258, %bb15 ]

        mov     x11, x10
        b     bb14
        //bb16:

bb16:

        //  %r249 = sub i32 %r246, 1

        sub     x10, x12, #1
        //  br label %bb17


        //bb17:  %r250 = phi i32 [ %r249, %bb16 ], [ %r255, %bb18 ]

        mov     x12, x10
        b     bb17
        //bb17:

bb17:

        //  %r250 = phi i32 [ %r249, %bb16 ], [ %r255, %bb18 ]

        //  %r182 = icmp sgt i32 %r250, 0

        mov     x10, #0
        cmp     x12, x10
        //  br i1 %r182, label %bb18, label %bb19


        b.gt     bb18
        b     bb19
        //bb18:

bb18:

        //  %r251 = add i32 0, 0

        mov     x10, #0
        mov     x11, x10
        //  %r252 = call i32 @swap(i32* %r161, i32 %r251, i32 %r250)

        mov     x0, x9
        mov     x1, x11
        mov     x2, x12
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     swap
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r253 = sub i32 %r250, 1

        sub     x10, x12, #1
        //  %r254 = call i32 @heap_ajust(i32* %r161, i32 %r251, i32 %r253)

        mov     x0, x9
        mov     x1, x11
        mov     x2, x10
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     heap_ajust
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r255 = sub i32 %r250, 1

        sub     x10, x12, #1
        //  br label %bb17


        //bb17:  %r250 = phi i32 [ %r249, %bb16 ], [ %r255, %bb18 ]

        mov     x12, x10
        b     bb17
        //bb19:

bb19:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r342->x9
        //%r341->x10
        //%r340->x9
        //%r213->x9
        //%r339->x10
        //%r338->x9
        //%r337->x9
        //%r336->x9
        //%r209->x9
        //%r335->x10
        //%r334->x9
        //%r333->x10
        //%r206->x10
        //%r332->x9
        //%r330->x9
        //%r203->x10
        //%r329->x10
        //%r202->x10
        //%r328->x9
        //%r201->x10
        //%r326->x9
        //%r199->x10
        //%r323->x10
        //%r196->x10
        //%r264->x9
        //%r321->x10
        //%r262->x9
        //%r320->x9
        //%r261->x9
        //%r319->x9
        //%r260->x9
        //%r331->x9
        //%r204->x10
        //%r318->x9
        //%r259->x9
        //%r200->x10
        //%r327->x10
        //%r317->x10
        //%r316->x9
        //%r198->x10
        //%r325->x9
        //%r315->x10
        //%r197->x10
        //%r324->x9
        //%r314->x9
        //%r312->x9
        //%r313->x9
        //%r195->x10
        //%r322->x9
        //%r311->x10
        //%r263->x11
        //%r265->x9
        //%r266->x9
        //%r305->x9
        //%r306->x9
        //%r307->x10
        //%r308->x9
        //%r309->x10
        //%r310->x9
        //%r343->x9
        //%r344->x9
        //%r345->x10
        //%r346->x9
        //%r347->x10
        //%r348->x9
        //%r349->x9
        //%r350->x9
        //%r351->x10
        //%r352->x9
        //%r353->x10
        //%r354->x9
        //%r355->x9
        //%r356->x9
        //%r357->x10
        //%r358->x9
        //%r359->x10
        //%r360->x9
        //%r361->x9
        //%r362->x9
        //%r363->x10
        //%r364->x9
        //%r365->x10
        //%r366->x9
        //%r367->x9
        //%r368->x9
        //%r369->x9
        //%r370->x9
        //%r371->x9
        //%r372->x9
        //%r373->x9
        //%r374->x9
        //%r375->x9
        //%r376->x10
        //%r377->x9
        //%r378->x9
        //%r379->x9
        //%r380->x9
        //%r381->x9
main:

        //194:x29,#-80

        //bb20:

bb20:

        //  %r259 = add i32 0, 0

        mov     x16, #80
        sub     sp, sp, x16
        mov     x9, #0
        //  call void @_sysy_starttime(i32 50)

        mov     x9, #50
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  store i32 10, i32* @n

        mov     x10, #10
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     x10, [x9]
        //  %r194 = alloca [ 10 x i32 ]

        //  %r195 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 4, i32* %r195

        mov     x9, #4
        str     x9, [x10]
        //  %r196 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r196

        mov     x9, #3
        str     x9, [x10]
        //  %r197 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 9, i32* %r197

        mov     x9, #9
        str     x9, [x10]
        //  %r198 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r198

        mov     x9, #2
        str     x9, [x10]
        //  %r199 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r199

        mov     x9, #0
        str     x9, [x10]
        //  %r200 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 5

        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r200

        mov     x9, #1
        str     x9, [x10]
        //  %r201 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 6

        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 6, i32* %r201

        mov     x9, #6
        str     x9, [x10]
        //  %r202 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 5, i32* %r202

        mov     x9, #5
        str     x9, [x10]
        //  %r203 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 8

        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r203

        mov     x9, #7
        str     x9, [x10]
        //  %r204 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 9

        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 8, i32* %r204

        mov     x9, #8
        str     x9, [x10]
        //  %r260 = add i32 0, 0

        mov     x9, #0
        //  %r261 = add i32 0, 0

        mov     x9, #0
        //  %r206 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x10, [x9]
        //  %r262 = call i32 @heap_sort(i32* %r194, i32 %r206)

        mov     x9, #-80
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x10
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     heap_sort
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  br label %bb21


        //bb21:  %r263 = phi i32 [ %r262, %bb20 ], [ %r266, %bb22 ]

        mov     x11, x9
        b     bb21
        //bb21:

bb21:

        //  %r263 = phi i32 [ %r262, %bb20 ], [ %r266, %bb22 ]

        //  %r209 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r210 = icmp slt i32 %r263, %r209

        cmp     x11, x9
        //  br i1 %r210, label %bb22, label %bb23


        b.lt     bb22
        b     bb23
        //bb22:

bb22:

        //  %r213 = getelementptr [10 x i32 ], [10 x i32 ]* %r194, i32 0 , i32 %r263

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-80
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r264 = load i32, i32* %r213

        ldr     x9, [x9]
        //  call void @putint(i32 %r264)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r265 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  call void @putch(i32 %r265)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r266 = add i32 %r263, 1

        add     x9, x11, #1
        //  br label %bb21


        //bb21:  %r263 = phi i32 [ %r262, %bb20 ], [ %r266, %bb22 ]

        mov     x11, x9
        b     bb21
        //bb23:

bb23:

        //  call void @_sysy_stoptime(i32 66)

        mov     x9, #66
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
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
