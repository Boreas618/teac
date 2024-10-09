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
.global bubblesort
.global insertsort
.global QuickSort
.global getMid
.global getMost
.global revert
.global arrCopy
.global calSum
.global avgPooling
.global main
        //%r565->x9
        //%r742->x10
        //%r562->x9
        //%r739->x13
        //%r561->x9
        //%r738->x9
        //%r560->x11
        //%r737->x9
        //%r559->x9
        //%r736->x9
        //%r558->x12
        //%r735->x13
        //%r557->x9
        //%r734->x10
        //%r554->x9
        //%r731->x9
        //%r564->x10
        //%r741->x15
        //%r100->x14
        //%r104->x9
        //%r552->x9
        //%r729->x9
        //%r117->x10
        //%r134->x10
        //%r724->x9
        //%r105->x9
        //%r553->x9
        //%r730->x9
        //%r118->x10
        //%r131->x13
        //%r137->x10
        //%r727->x9
        //%r108->x9
        //%r556->x9
        //%r733->x10
        //%r121->x9
        //%r110->x9
        //%r111->x9
        //%r555->x9
        //%r732->x9
        //%r120->x9
        //%r563->x9
        //%r740->x13
        //%r128->x9
        //%r132->x13
        //%r725->x9
        //%r726->x9
        //%r728->x9
        //%r743->x10
        //%r744->x10
        //%r745->x9
bubblesort:

        //bb1:

bb1:

        //  %r552 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x14, x0
        mov     x9, #0
        //  %r553 = add i32 0, 0

        mov     x9, #0
        //  %r554 = add i32 0, 0

        mov     x9, #0
        //  %r555 = add i32 0, 0

        mov     x9, #0
        //  %r556 = add i32 0, 0

        mov     x9, #0
        //  %r557 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r558 = phi i32 [ %r557, %bb1 ], [ %r561, %bb7 ]

        mov     x12, x9
        b     bb2
        //bb2:

bb2:

        //  %r558 = phi i32 [ %r557, %bb1 ], [ %r561, %bb7 ]

        //  %r104 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r105 = sub i32 %r104, 1

        sub     x9, x9, #1
        //  %r106 = icmp slt i32 %r558, %r105

        cmp     x12, x9
        //  br i1 %r106, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r559 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb5


        //bb5:  %r560 = phi i32 [ %r559, %bb3 ], [ %r563, %bb10 ]

        mov     x11, x9
        b     bb5
        //bb5:

bb5:

        //  %r560 = phi i32 [ %r559, %bb3 ], [ %r563, %bb10 ]

        //  %r108 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r110 = sub i32 %r108, %r558

        sub     x9, x9, x12
        //  %r111 = sub i32 %r110, 1

        sub     x9, x9, #1
        //  %r112 = icmp slt i32 %r560, %r111

        cmp     x11, x9
        //  br i1 %r112, label %bb6, label %bb7


        b.lt     bb6
        b     bb7
        //bb6:

bb6:

        //  %r562 = add i32 %r560, 1

        add     x9, x11, #1
        //  %r117 = getelementptr i32, i32* %r100, i32 %r560

        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x14, x10
        //  %r118 = load i32, i32* %r117

        ldr     x10, [x10]
        //  %r120 = getelementptr i32, i32* %r100, i32 %r562

        mov     x13, #8
        mul     x9, x9, x13
        add     x9, x14, x9
        //  %r121 = load i32, i32* %r120

        ldr     x9, [x9]
        //  %r122 = icmp sgt i32 %r118, %r121

        cmp     x10, x9
        //  br i1 %r122, label %bb8, label %bb9


        b.gt     bb8
        b     bb9
        //bb8:

bb8:

        //  %r564 = add i32 %r560, 1

        add     x10, x11, #1
        //  %r128 = getelementptr i32, i32* %r100, i32 %r564

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        //  %r565 = load i32, i32* %r128

        ldr     x9, [x9]
        //  %r131 = getelementptr i32, i32* %r100, i32 %r560

        mov     x13, #8
        mul     x13, x11, x13
        add     x13, x14, x13
        //  %r132 = load i32, i32* %r131

        ldr     x13, [x13]
        //  %r134 = getelementptr i32, i32* %r100, i32 %r564

        mov     x15, #8
        mul     x10, x10, x15
        add     x10, x14, x10
        //  store i32 %r132, i32* %r134

        str     x13, [x10]
        //  %r137 = getelementptr i32, i32* %r100, i32 %r560

        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x14, x10
        //  store i32 %r565, i32* %r137

        str     x9, [x10]
        //  br label %bb10


        b     bb10
        //bb9:

bb9:

        //  br label %bb10


        b     bb10
        //bb10:

bb10:

        //  %r563 = add i32 %r560, 1

        add     x9, x11, #1
        //  br label %bb5


        //bb5:  %r560 = phi i32 [ %r559, %bb3 ], [ %r563, %bb10 ]

        mov     x11, x9
        b     bb5
        //bb7:

bb7:

        //  %r561 = add i32 %r558, 1

        add     x9, x12, #1
        //  br label %bb2


        //bb2:  %r558 = phi i32 [ %r557, %bb1 ], [ %r561, %bb7 ]

        mov     x12, x9
        b     bb2
        //bb4:

bb4:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r579->x9
        //%r166->x13
        //%r756->x9
        //%r578->x9
        //%r755->x9
        //%r750->x9
        //%r573->x11
        //%r160->x9
        //%r576->x10
        //%r753->x9
        //%r748->x9
        //%r571->x9
        //%r574->x9
        //%r751->x9
        //%r570->x9
        //%r747->x9
        //%r569->x9
        //%r746->x9
        //%r577->x9
        //%r754->x9
        //%r142->x14
        //%r155->x9
        //%r568->x9
        //%r145->x9
        //%r149->x9
        //%r159->x9
        //%r572->x12
        //%r749->x9
        //%r167->x13
        //%r757->x9
        //%r575->x10
        //%r752->x9
        //%r169->x9
        //%r759->x13
        //%r177->x9
        //%r567->x9
        //%r566->x9
        //%r758->x13
        //%r760->x15
        //%r761->x9
        //%r762->x9
        //%r763->x9
        //%r764->x9
insertsort:

        //bb11:

bb11:

        //  %r566 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x14, x0
        mov     x9, #0
        //  %r567 = add i32 0, 0

        mov     x9, #0
        //  %r568 = add i32 0, 0

        mov     x9, #0
        //  %r569 = add i32 0, 0

        mov     x9, #0
        //  %r570 = add i32 0, 0

        mov     x9, #0
        //  %r571 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb12


        //bb12:  %r572 = phi i32 [ %r571, %bb11 ], [ %r577, %bb17 ]

        mov     x12, x9
        b     bb12
        //bb12:

bb12:

        //  %r572 = phi i32 [ %r571, %bb11 ], [ %r577, %bb17 ]

        //  %r145 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r146 = icmp slt i32 %r572, %r145

        cmp     x12, x9
        //  br i1 %r146, label %bb13, label %bb14


        b.lt     bb13
        b     bb14
        //bb13:

bb13:

        //  %r149 = getelementptr i32, i32* %r142, i32 %r572

        mov     x9, #8
        mul     x9, x12, x9
        add     x9, x14, x9
        //  %r573 = load i32, i32* %r149

        ldr     x11, [x9]
        //  %r574 = sub i32 %r572, 1

        sub     x9, x12, #1
        //  br label %bb15


        //bb15:  %r575 = phi i32 [ %r574, %bb13 ], [ %r579, %bb16 ]

        mov     x10, x9
        b     bb15
        //bb15:

bb15:

        //  %r575 = phi i32 [ %r574, %bb13 ], [ %r579, %bb16 ]

        //  %r155 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  %r156 = icmp sgt i32 %r575, %r155

        cmp     x10, x9
        //  br i1 %r156, label %bb18, label %bb17


        b.gt     bb18
        b     bb17
        //bb18:

bb18:

        //  %r159 = getelementptr i32, i32* %r142, i32 %r575

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        //  %r160 = load i32, i32* %r159

        ldr     x9, [x9]
        //  %r161 = icmp slt i32 %r573, %r160

        cmp     x11, x9
        //  br i1 %r161, label %bb16, label %bb17


        b.lt     bb16
        b     bb17
        //bb16:

bb16:

        //  %r578 = add i32 %r575, 1

        add     x9, x10, #1
        //  %r166 = getelementptr i32, i32* %r142, i32 %r575

        mov     x13, #8
        mul     x13, x10, x13
        add     x13, x14, x13
        //  %r167 = load i32, i32* %r166

        ldr     x13, [x13]
        //  %r169 = getelementptr i32, i32* %r142, i32 %r578

        mov     x15, #8
        mul     x9, x9, x15
        add     x9, x14, x9
        //  store i32 %r167, i32* %r169

        str     x13, [x9]
        //  %r579 = sub i32 %r575, 1

        sub     x9, x10, #1
        //  br label %bb15


        //bb15:  %r575 = phi i32 [ %r574, %bb13 ], [ %r579, %bb16 ]

        mov     x10, x9
        b     bb15
        //bb17:

bb17:

        //  %r576 = add i32 %r575, 1

        add     x10, x10, #1
        //  %r177 = getelementptr i32, i32* %r142, i32 %r576

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x14, x9
        //  store i32 %r573, i32* %r177

        str     x11, [x9]
        //  %r577 = add i32 %r572, 1

        add     x9, x12, #1
        //  br label %bb12


        //bb12:  %r572 = phi i32 [ %r571, %bb11 ], [ %r577, %bb17 ]

        mov     x12, x9
        b     bb12
        //bb14:

bb14:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r782->x9
        //%r781->x9
        //%r604->x9
        //%r780->x9
        //%r603->x9
        //%r779->x9
        //%r602->x9
        //%r778->x9
        //%r601->x9
        //%r777->x9
        //%r600->x9
        //%r776->x9
        //%r599->x10
        //%r775->x9
        //%r598->x9
        //%r217->x9
        //%r774->x9
        //%r597->x11
        //%r772->x11
        //%r595->x9
        //%r214->x9
        //%r582->x9
        //%r225->x9
        //%r224->x9
        //%r215->x15
        //%r596->x9
        //%r769->x11
        //%r592->x10
        //%r204->x15
        //%r585->x9
        //%r581->x9
        //%r203->x9
        //%r584->x9
        //%r580->x9
        //%r194->x11
        //%r771->x11
        //%r594->x9
        //%r181->x10
        //%r587->x13
        //%r206->x9
        //%r766->x11
        //%r589->x9
        //%r235->x15
        //%r583->x9
        //%r770->x10
        //%r593->x9
        //%r180->[sp,#0]
        //%r586->x14
        //%r768->x11
        //%r591->x9
        //%r237->x9
        //%r773->x9
        //%r183->x9
        //%r242->x9
        //%r767->x11
        //%r590->x12
        //%r765->x11
        //%r234->x9
        //%r588->x10
        //%r783->x9
        //%r784->x9
        //%r785->x9
        //%r786->x9
        //%r787->x9
QuickSort:

        //bb104:

bb104:

        //  %r580 = add i32 0, 0

        mov     x16, #8
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x10, x1
        mov     x9, x2
        mov     x11, #0
        //  %r581 = add i32 0, 0

        mov     x11, #0
        //  %r582 = add i32 0, 0

        mov     x11, #0
        //  %r583 = add i32 0, 0

        mov     x11, #0
        //  %r584 = add i32 0, 0

        mov     x11, #0
        //  %r586 = add i32 %r181, 0

        mov     x14, x10
        //  %r585 = add i32 0, 0

        mov     x10, #0
        //  %r587 = add i32 %r183, 0

        mov     x13, x9
        //  %r187 = icmp slt i32 %r586, %r587

        cmp     x14, x13
        //  br i1 %r187, label %bb20, label %bb21


        b.lt     bb20
        b     bb21
        //bb20:

bb20:

        //  %r588 = add i32 %r586, 0

        mov     x10, x14
        //  %r589 = add i32 %r587, 0

        mov     x9, x13
        //  %r194 = getelementptr i32, i32* %r180, i32 %r586

        mov     x11, #8
        mul     x11, x14, x11
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x11, x19, x11
        //  %r590 = load i32, i32* %r194

        ldr     x12, [x11]
        //  br label %bb23


        //bb23:  %r591 = phi i32 [ %r589, %bb20 ], [ %r600, %bb39 ]

        mov     x9, x9
        //bb23:  %r592 = phi i32 [ %r588, %bb20 ], [ %r599, %bb39 ]

        mov     x10, x10
        b     bb23
        //bb23:

bb23:

        //  %r591 = phi i32 [ %r589, %bb20 ], [ %r600, %bb39 ]

        //  %r592 = phi i32 [ %r588, %bb20 ], [ %r599, %bb39 ]

        //  %r198 = icmp slt i32 %r592, %r591

        cmp     x10, x9
        //  br i1 %r198, label %bb24, label %bb25


        b.lt     bb24
        b     bb25
        //bb24:

bb24:

        //  br label %bb26


        //bb26:  %r597 = phi i32 [ %r591, %bb24 ], [ %r604, %bb27 ]

        mov     x11, x9
        b     bb26
        //bb26:

bb26:

        //  %r597 = phi i32 [ %r591, %bb24 ], [ %r604, %bb27 ]

        //  %r201 = icmp slt i32 %r592, %r597

        cmp     x10, x11
        //  br i1 %r201, label %bb29, label %bb28


        b.lt     bb29
        b     bb28
        //bb29:

bb29:

        //  %r203 = getelementptr i32, i32* %r180, i32 %r597

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r204 = load i32, i32* %r203

        ldr     x15, [x9]
        //  %r206 = sub i32 %r590, 1

        sub     x9, x12, #1
        //  %r207 = icmp sgt i32 %r204, %r206

        cmp     x15, x9
        //  br i1 %r207, label %bb27, label %bb28


        b.gt     bb27
        b     bb28
        //bb27:

bb27:

        //  %r604 = sub i32 %r597, 1

        sub     x9, x11, #1
        //  br label %bb26


        //bb26:  %r597 = phi i32 [ %r591, %bb24 ], [ %r604, %bb27 ]

        mov     x11, x9
        b     bb26
        //bb28:

bb28:

        //  %r212 = icmp slt i32 %r592, %r597

        cmp     x10, x11
        //  br i1 %r212, label %bb30, label %bb31


        b.lt     bb30
        b     bb31
        //bb30:

bb30:

        //  %r214 = getelementptr i32, i32* %r180, i32 %r597

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r215 = load i32, i32* %r214

        ldr     x15, [x9]
        //  %r217 = getelementptr i32, i32* %r180, i32 %r592

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  store i32 %r215, i32* %r217

        str     x15, [x9]
        //  %r603 = add i32 %r592, 1

        add     x9, x10, #1
        //  br label %bb32


        //bb32:  %r598 = phi i32 [ %r603, %bb30 ], [ %r592, %bb31 ]

        mov     x9, x9
        b     bb32
        //bb31:

bb31:

        //  br label %bb32


        //bb32:  %r598 = phi i32 [ %r603, %bb30 ], [ %r592, %bb31 ]

        mov     x9, x10
        b     bb32
        //bb32:

bb32:

        //  %r598 = phi i32 [ %r603, %bb30 ], [ %r592, %bb31 ]

        //  br label %bb33


        //bb33:  %r599 = phi i32 [ %r598, %bb32 ], [ %r602, %bb34 ]

        mov     x10, x9
        b     bb33
        //bb33:

bb33:

        //  %r599 = phi i32 [ %r598, %bb32 ], [ %r602, %bb34 ]

        //  %r222 = icmp slt i32 %r599, %r597

        cmp     x10, x11
        //  br i1 %r222, label %bb36, label %bb35


        b.lt     bb36
        b     bb35
        //bb36:

bb36:

        //  %r224 = getelementptr i32, i32* %r180, i32 %r599

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r225 = load i32, i32* %r224

        ldr     x9, [x9]
        //  %r227 = icmp slt i32 %r225, %r590

        cmp     x9, x12
        //  br i1 %r227, label %bb34, label %bb35


        b.lt     bb34
        b     bb35
        //bb34:

bb34:

        //  %r602 = add i32 %r599, 1

        add     x9, x10, #1
        //  br label %bb33


        //bb33:  %r599 = phi i32 [ %r598, %bb32 ], [ %r602, %bb34 ]

        mov     x10, x9
        b     bb33
        //bb35:

bb35:

        //  %r232 = icmp slt i32 %r599, %r597

        cmp     x10, x11
        //  br i1 %r232, label %bb37, label %bb38


        b.lt     bb37
        b     bb38
        //bb37:

bb37:

        //  %r234 = getelementptr i32, i32* %r180, i32 %r599

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r235 = load i32, i32* %r234

        ldr     x15, [x9]
        //  %r237 = getelementptr i32, i32* %r180, i32 %r597

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  store i32 %r235, i32* %r237

        str     x15, [x9]
        //  %r601 = sub i32 %r597, 1

        sub     x9, x11, #1
        //  br label %bb39


        //bb39:  %r600 = phi i32 [ %r601, %bb37 ], [ %r597, %bb38 ]

        mov     x9, x9
        b     bb39
        //bb38:

bb38:

        //  br label %bb39


        //bb39:  %r600 = phi i32 [ %r601, %bb37 ], [ %r597, %bb38 ]

        mov     x9, x11
        b     bb39
        //bb39:

bb39:

        //  %r600 = phi i32 [ %r601, %bb37 ], [ %r597, %bb38 ]

        //  br label %bb23


        //bb23:  %r591 = phi i32 [ %r589, %bb20 ], [ %r600, %bb39 ]

        mov     x9, x9
        //bb23:  %r592 = phi i32 [ %r588, %bb20 ], [ %r599, %bb39 ]

        mov     x10, x10
        b     bb23
        //bb25:

bb25:

        //  %r242 = getelementptr i32, i32* %r180, i32 %r592

        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  store i32 %r590, i32* %r242

        str     x12, [x9]
        //  %r593 = sub i32 %r592, 1

        sub     x9, x10, #1
        //  %r594 = call i32 @QuickSort(i32* %r180, i32 %r586, i32 %r593)

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x1, x14
        mov     x2, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     QuickSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r595 = add i32 %r592, 1

        add     x9, x10, #1
        //  %r596 = call i32 @QuickSort(i32* %r180, i32 %r595, i32 %r587)

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     x1, x9
        mov     x2, x13
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     QuickSort
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

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r791->x9
        //%r788->x9
        //%r257->x11
        //%r608->x12
        //%r254->x10
        //%r278->x9
        //%r277->x9
        //%r789->x9
        //%r258->x11
        //%r267->x11
        //%r798->x11
        //%r256->x11
        //%r605->x9
        //%r792->x9
        //%r261->x11
        //%r270->x9
        //%r801->x9
        //%r606->x9
        //%r793->x9
        //%r271->x9
        //%r802->x9
        //%r607->x11
        //%r259->x9
        //%r790->x9
        //%r794->x9
        //%r272->x10
        //%r803->x9
        //%r609->x9
        //%r796->x11
        //%r274->x11
        //%r268->x12
        //%r799->x9
        //%r795->x9
        //%r273->x9
        //%r804->x9
        //%r797->x11
        //%r800->x9
getMid:

        //bb40:

bb40:

        //  %r605 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r606 = add i32 0, 0

        mov     x9, #0
        //  %r256 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x11, [x9]
        //  %r257 = sdiv i32 %r256, 2

        mov     x9, #2
        sdiv     x11, x11, x9
        //  %r258 = mul i32 %r257, 2

        mov     x9, #2
        mul     x11, x11, x9
        //  %r259 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r260 = icmp eq i32 %r258, %r259

        cmp     x11, x9
        //  br i1 %r260, label %bb41, label %bb42


        b.eq     bb41
        b     bb42
        //bb41:

bb41:

        //  %r261 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x11, [x9]
        //  %r608 = sdiv i32 %r261, 2

        mov     x9, #2
        sdiv     x12, x11, x9
        //  %r609 = sub i32 %r608, 1

        sub     x9, x12, #1
        //  %r267 = getelementptr i32, i32* %r254, i32 %r608

        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x10, x11
        //  %r268 = load i32, i32* %r267

        ldr     x12, [x11]
        //  %r270 = getelementptr i32, i32* %r254, i32 %r609

        mov     x11, #8
        mul     x9, x9, x11
        add     x9, x10, x9
        //  %r271 = load i32, i32* %r270

        ldr     x9, [x9]
        //  %r272 = add i32 %r268, %r271

        add     x10, x12, x9
        //  %r273 = sdiv i32 %r272, 2

        mov     x9, #2
        sdiv     x9, x10, x9
        //  ret i32 %r273

        mov     x0, x9
        mov     sp, x29
        ret
        //bb42:

bb42:

        //  %r274 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x11, [x9]
        //  %r607 = sdiv i32 %r274, 2

        mov     x9, #2
        sdiv     x11, x11, x9
        //  %r277 = getelementptr i32, i32* %r254, i32 %r607

        mov     x9, #8
        mul     x9, x11, x9
        add     x9, x10, x9
        //  %r278 = load i32, i32* %r277

        ldr     x9, [x9]
        //  ret i32 %r278

        mov     x0, x9
        mov     sp, x29
        ret
        //%r834->x10
        //%r832->x10
        //%r828->x9
        //%r827->x9
        //%r825->x9
        //%r824->x10
        //%r823->x10
        //%r821->x9
        //%r820->x9
        //%r819->x9
        //%r818->x9
        //%r817->x9
        //%r309->x9
        //%r815->x11
        //%r814->x11
        //%r813->x11
        //%r305->x9
        //%r812->x12
        //%r304->x9
        //%r811->x11
        //%r809->x9
        //%r808->x9
        //%r300->x15
        //%r807->x9
        //%r299->x9
        //%r806->x9
        //%r298->x9
        //%r805->x9
        //%r833->x9
        //%r302->x9
        //%r810->x11
        //%r621->x11
        //%r831->x10
        //%r619->x13
        //%r611->x10
        //%r830->x9
        //%r618->x14
        //%r826->x10
        //%r295->x9
        //%r614->x9
        //%r623->x10
        //%r822->x9
        //%r291->x9
        //%r610->x9
        //%r829->x9
        //%r617->x9
        //%r816->x9
        //%r285->x12
        //%r624->x9
        //%r279->[sp,#0]
        //%r627->x9
        //%r612->x9
        //%r613->x9
        //%r615->x9
        //%r616->x11
        //%r620->x12
        //%r622->x11
        //%r625->x10
        //%r626->x9
        //%r835->x9
        //%r836->x9
getMost:

        //280:x29,#-8000

        //bb44:

bb44:

        //  %r610 = add i32 0, 0

        mov     x16, #8008
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x9, #0
        //  %r611 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r612 = add i32 0, 0

        mov     x9, #0
        //  %r280 = alloca [ 1000 x i32 ]

        //  %r613 = add i32 0, 0

        mov     x9, #0
        //  %r614 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb45


        //bb45:  %r615 = phi i32 [ %r614, %bb44 ], [ %r627, %bb46 ]

        mov     x9, x9
        b     bb45
        //bb45:

bb45:

        //  %r615 = phi i32 [ %r614, %bb44 ], [ %r627, %bb46 ]

        //  %r283 = icmp slt i32 %r615, 1000

        mov     x11, #1000
        cmp     x9, x11
        //  br i1 %r283, label %bb46, label %bb47


        b.lt     bb46
        b     bb47
        //bb46:

bb46:

        //  %r285 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r280, i32 0 , i32 %r615

        mov     x11, #8
        mul     x12, x9, x11
        mov     x11, #-8000
        add     x11, x29, x11
        add     x12, x11, x12
        //  store i32 0, i32* %r285

        mov     x11, #0
        str     x11, [x12]
        //  %r627 = add i32 %r615, 1

        add     x9, x9, #1
        //  br label %bb45


        //bb45:  %r615 = phi i32 [ %r614, %bb44 ], [ %r627, %bb46 ]

        mov     x9, x9
        b     bb45
        //bb47:

bb47:

        //  %r616 = add i32 0, 0

        mov     x9, #0
        mov     x11, x9
        //  %r617 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb48


        //bb48:  %r618 = phi i32 [ %r616, %bb47 ], [ %r624, %bb53 ]

        mov     x14, x11
        //bb48:  %r619 = phi i32 [ %r617, %bb47 ], [ %r622, %bb53 ]

        mov     x13, x9
        //bb48:  %r620 = phi i32 [ %r611, %bb47 ], [ %r623, %bb53 ]

        mov     x12, x10
        b     bb48
        //bb48:

bb48:

        //  %r618 = phi i32 [ %r616, %bb47 ], [ %r624, %bb53 ]

        //  %r619 = phi i32 [ %r617, %bb47 ], [ %r622, %bb53 ]

        //  %r620 = phi i32 [ %r611, %bb47 ], [ %r623, %bb53 ]

        //  %r291 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r292 = icmp slt i32 %r618, %r291

        cmp     x14, x9
        //  br i1 %r292, label %bb49, label %bb50


        b.lt     bb49
        b     bb50
        //bb49:

bb49:

        //  %r295 = getelementptr i32, i32* %r279, i32 %r618

        mov     x9, #8
        mul     x9, x14, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r621 = load i32, i32* %r295

        ldr     x11, [x9]
        //  %r298 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r280, i32 0 , i32 %r621

        mov     x9, #8
        mul     x9, x11, x9
        mov     x10, #-8000
        add     x10, x29, x10
        add     x9, x10, x9
        //  %r299 = load i32, i32* %r298

        ldr     x9, [x9]
        //  %r300 = add i32 %r299, 1

        add     x15, x9, #1
        //  %r302 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r280, i32 0 , i32 %r621

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-8000
        add     x9, x29, x9
        add     x9, x9, x10
        //  store i32 %r300, i32* %r302

        str     x15, [x9]
        //  %r304 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r280, i32 0 , i32 %r621

        mov     x9, #8
        mul     x9, x11, x9
        mov     x10, #-8000
        add     x10, x29, x10
        add     x9, x10, x9
        //  %r305 = load i32, i32* %r304

        ldr     x9, [x9]
        //  %r307 = icmp sgt i32 %r305, %r619

        cmp     x9, x13
        //  br i1 %r307, label %bb51, label %bb52


        b.gt     bb51
        b     bb52
        //bb51:

bb51:

        //  %r309 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r280, i32 0 , i32 %r621

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-8000
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r625 = load i32, i32* %r309

        ldr     x10, [x9]
        //  %r626 = add i32 %r621, 0

        mov     x9, x11
        //  br label %bb53


        //bb53:  %r622 = phi i32 [ %r625, %bb51 ], [ %r619, %bb52 ]

        mov     x11, x10
        //bb53:  %r623 = phi i32 [ %r626, %bb51 ], [ %r620, %bb52 ]

        mov     x10, x9
        b     bb53
        //bb52:

bb52:

        //  br label %bb53


        //bb53:  %r622 = phi i32 [ %r625, %bb51 ], [ %r619, %bb52 ]

        mov     x11, x13
        //bb53:  %r623 = phi i32 [ %r626, %bb51 ], [ %r620, %bb52 ]

        mov     x10, x12
        b     bb53
        //bb53:

bb53:

        //  %r622 = phi i32 [ %r625, %bb51 ], [ %r619, %bb52 ]

        //  %r623 = phi i32 [ %r626, %bb51 ], [ %r620, %bb52 ]

        //  %r624 = add i32 %r618, 1

        add     x9, x14, #1
        //  br label %bb48


        //bb48:  %r618 = phi i32 [ %r616, %bb47 ], [ %r624, %bb53 ]

        mov     x14, x9
        //bb48:  %r619 = phi i32 [ %r617, %bb47 ], [ %r622, %bb53 ]

        mov     x13, x11
        //bb48:  %r620 = phi i32 [ %r611, %bb47 ], [ %r623, %bb53 ]

        mov     x12, x10
        b     bb48
        //bb50:

bb50:

        //  ret i32 %r620

        mov     x0, x12
        mov     sp, x29
        ret
        //%r847->x14
        //%r846->x14
        //%r315->x13
        //%r844->x12
        //%r843->x9
        //%r842->x9
        //%r841->x9
        //%r840->x9
        //%r637->x9
        //%r839->x9
        //%r636->x10
        //%r838->x9
        //%r635->x9
        //%r845->x12
        //%r323->x9
        //%r848->x12
        //%r326->x12
        //%r849->x12
        //%r327->x12
        //%r329->x14
        //%r628->x9
        //%r332->x12
        //%r631->x10
        //%r629->x9
        //%r630->x9
        //%r632->x9
        //%r633->x11
        //%r837->x9
        //%r634->x10
        //%r850->x9
revert:

        //bb54:

bb54:

        //  %r628 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     x9, #0
        //  %r629 = add i32 0, 0

        mov     x9, #0
        //  %r630 = add i32 0, 0

        mov     x9, #0
        //  %r631 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r632 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb55


        //bb55:  %r633 = phi i32 [ %r632, %bb54 ], [ %r637, %bb56 ]

        mov     x11, x9
        //bb55:  %r634 = phi i32 [ %r631, %bb54 ], [ %r636, %bb56 ]

        mov     x10, x10
        b     bb55
        //bb55:

bb55:

        //  %r633 = phi i32 [ %r632, %bb54 ], [ %r637, %bb56 ]

        //  %r634 = phi i32 [ %r631, %bb54 ], [ %r636, %bb56 ]

        //  %r321 = icmp slt i32 %r634, %r633

        cmp     x10, x11
        //  br i1 %r321, label %bb56, label %bb57


        b.lt     bb56
        b     bb57
        //bb56:

bb56:

        //  %r323 = getelementptr i32, i32* %r315, i32 %r634

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x13, x9
        //  %r635 = load i32, i32* %r323

        ldr     x9, [x9]
        //  %r326 = getelementptr i32, i32* %r315, i32 %r633

        mov     x12, #8
        mul     x12, x11, x12
        add     x12, x13, x12
        //  %r327 = load i32, i32* %r326

        ldr     x12, [x12]
        //  %r329 = getelementptr i32, i32* %r315, i32 %r634

        mov     x14, #8
        mul     x14, x10, x14
        add     x14, x13, x14
        //  store i32 %r327, i32* %r329

        str     x12, [x14]
        //  %r332 = getelementptr i32, i32* %r315, i32 %r633

        mov     x12, #8
        mul     x12, x11, x12
        add     x12, x13, x12
        //  store i32 %r635, i32* %r332

        str     x9, [x12]
        //  %r636 = add i32 %r634, 1

        add     x10, x10, #1
        //  %r637 = sub i32 %r633, 1

        sub     x9, x11, #1
        //  br label %bb55


        //bb55:  %r633 = phi i32 [ %r632, %bb54 ], [ %r637, %bb56 ]

        mov     x11, x9
        //bb55:  %r634 = phi i32 [ %r631, %bb54 ], [ %r636, %bb56 ]

        mov     x10, x10
        b     bb55
        //bb57:

bb57:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r853->x12
        //%r641->x9
        //%r639->x9
        //%r638->x9
        //%r347->x12
        //%r852->x9
        //%r345->x13
        //%r851->x9
        //%r344->x12
        //%r640->x9
        //%r341->x12
        //%r338->x10
        //%r337->x11
        //%r854->x12
        //%r855->x12
        //%r856->x12
        //%r857->x12
        //%r858->x9
arrCopy:

        //bb58:

bb58:

        //  %r638 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        //  %r639 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb59


        //bb59:  %r640 = phi i32 [ %r639, %bb58 ], [ %r641, %bb60 ]

        mov     x9, x9
        b     bb59
        //bb59:

bb59:

        //  %r640 = phi i32 [ %r639, %bb58 ], [ %r641, %bb60 ]

        //  %r341 = load i32, i32* @n

        adrp     x12, n
        add     x12, x12, #:lo12:n
        ldr     x12, [x12]
        //  %r342 = icmp slt i32 %r640, %r341

        cmp     x9, x12
        //  br i1 %r342, label %bb60, label %bb61


        b.lt     bb60
        b     bb61
        //bb60:

bb60:

        //  %r344 = getelementptr i32, i32* %r337, i32 %r640

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        //  %r345 = load i32, i32* %r344

        ldr     x13, [x12]
        //  %r347 = getelementptr i32, i32* %r338, i32 %r640

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x10, x12
        //  store i32 %r345, i32* %r347

        str     x13, [x12]
        //  %r641 = add i32 %r640, 1

        add     x9, x9, #1
        //  br label %bb59


        //bb59:  %r640 = phi i32 [ %r639, %bb58 ], [ %r641, %bb60 ]

        mov     x9, x9
        b     bb59
        //bb61:

bb61:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r863->x9
        //%r860->x9
        //%r653->x9
        //%r652->x10
        //%r649->x10
        //%r648->x9
        //%r647->x10
        //%r645->x11
        //%r350->x12
        //%r644->x9
        //%r351->x10
        //%r646->x13
        //%r377->x13
        //%r356->x13
        //%r651->x9
        //%r862->x9
        //%r369->x14
        //%r642->x9
        //%r650->x9
        //%r360->x13
        //%r361->x13
        //%r374->x14
        //%r859->x9
        //%r366->x13
        //%r861->x9
        //%r368->x13
        //%r864->x13
        //%r371->x13
        //%r643->x9
        //%r865->x13
        //%r866->x13
        //%r867->x13
        //%r868->x13
        //%r869->x13
        //%r870->x13
        //%r871->x13
        //%r872->x9
        //%r873->x9
calSum:

        //bb107:

bb107:

        //  %r642 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x12, x0
        mov     x10, x1
        mov     x9, #0
        //  %r643 = add i32 0, 0

        mov     x9, #0
        //  %r644 = add i32 0, 0

        mov     x9, #0
        //  %r645 = add i32 %r351, 0

        mov     x11, x10
        //  %r646 = add i32 0, 0

        mov     x9, #0
        mov     x13, x9
        //  %r647 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  br label %bb63


        //bb63:  %r648 = phi i32 [ %r646, %bb107 ], [ %r651, %bb68 ]

        mov     x9, x13
        //bb63:  %r649 = phi i32 [ %r647, %bb107 ], [ %r652, %bb68 ]

        mov     x10, x10
        b     bb63
        //bb63:

bb63:

        //  %r648 = phi i32 [ %r646, %bb107 ], [ %r651, %bb68 ]

        //  %r649 = phi i32 [ %r647, %bb107 ], [ %r652, %bb68 ]

        //  %r356 = load i32, i32* @n

        adrp     x13, n
        add     x13, x13, #:lo12:n
        ldr     x13, [x13]
        //  %r357 = icmp slt i32 %r649, %r356

        cmp     x10, x13
        //  br i1 %r357, label %bb64, label %bb65


        b.lt     bb64
        b     bb65
        //bb64:

bb64:

        //  %r360 = getelementptr i32, i32* %r350, i32 %r649

        mov     x13, #8
        mul     x13, x10, x13
        add     x13, x12, x13
        //  %r361 = load i32, i32* %r360

        ldr     x13, [x13]
        //  %r650 = add i32 %r648, %r361

        add     x9, x9, x13
        //  %r366 = sdiv i32 %r649, %r645

        sdiv     x13, x10, x11
        //  %r368 = mul i32 %r366, %r645

        mul     x13, x13, x11
        //  %r369 = sub i32 %r649, %r368

        sub     x14, x10, x13
        //  %r371 = sub i32 %r645, 1

        sub     x13, x11, #1
        //  %r372 = icmp ne i32 %r369, %r371

        cmp     x14, x13
        //  br i1 %r372, label %bb66, label %bb67


        b.ne     bb66
        b     bb67
        //bb66:

bb66:

        //  %r374 = getelementptr i32, i32* %r350, i32 %r649

        mov     x13, #8
        mul     x13, x10, x13
        add     x14, x12, x13
        //  store i32 0, i32* %r374

        mov     x13, #0
        str     x13, [x14]
        //  br label %bb68


        //bb68:  %r651 = phi i32 [ %r650, %bb66 ], [ %r653, %bb67 ]

        mov     x9, x9
        b     bb68
        //bb67:

bb67:

        //  %r377 = getelementptr i32, i32* %r350, i32 %r649

        mov     x13, #8
        mul     x13, x10, x13
        add     x13, x12, x13
        //  store i32 %r650, i32* %r377

        str     x9, [x13]
        //  %r653 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb68


        //bb68:  %r651 = phi i32 [ %r650, %bb66 ], [ %r653, %bb67 ]

        mov     x9, x9
        b     bb68
        //bb68:

bb68:

        //  %r651 = phi i32 [ %r650, %bb66 ], [ %r653, %bb67 ]

        //  %r652 = add i32 %r649, 1

        add     x10, x10, #1
        //  br label %bb63


        //bb63:  %r648 = phi i32 [ %r646, %bb107 ], [ %r651, %bb68 ]

        mov     x9, x9
        //bb63:  %r649 = phi i32 [ %r647, %bb107 ], [ %r652, %bb68 ]

        mov     x10, x10
        b     bb63
        //bb65:

bb65:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r887->x10
        //%r886->x9
        //%r885->x9
        //%r881->x10
        //%r880->x10
        //%r877->x11
        //%r876->x11
        //%r875->x9
        //%r677->x10
        //%r673->x12
        //%r672->x10
        //%r418->x9
        //%r670->x10
        //%r669->x11
        //%r667->x9
        //%r665->x9
        //%r411->x10
        //%r664->x12
        //%r410->x10
        //%r662->x9
        //%r884->x10
        //%r412->x10
        //%r666->x9
        //%r883->x10
        //%r882->x10
        //%r676->x11
        //%r381->x10
        //%r889->x9
        //%r874->x9
        //%r402->x9
        //%r656->x9
        //%r396->x10
        //%r395->x10
        //%r391->x10
        //%r899->x10
        //%r400->x10
        //%r654->x9
        //%r425->x15
        //%r661->x10
        //%r407->x9
        //%r387->x10
        //%r895->x9
        //%r879->x10
        //%r878->x11
        //%r406->x15
        //%r660->x11
        //%r671->x9
        //%r435->x10
        //%r675->x10
        //%r421->x9
        //%r380->[sp,#0]
        //%r888->x9
        //%r674->x11
        //%r438->x11
        //%r657->x9
        //%r663->x13
        //%r427->x9
        //%r659->x14
        //%r430->x9
        //%r668->x9
        //%r432->x9
        //%r655->x9
        //%r658->x9
        //%r890->x10
        //%r891->x10
        //%r892->x9
        //%r893->x9
        //%r894->x9
        //%r896->x9
        //%r897->x10
        //%r898->x10
        //%r900->x10
        //%r901->x9
avgPooling:

        //bb108:

bb108:

        //  %r654 = add i32 0, 0

        mov     x16, #8
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     x10, x1
        mov     x9, #0
        //  %r655 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  %r656 = add i32 0, 0

        mov     x11, #0
        //  %r657 = add i32 0, 0

        mov     x11, #0
        //  %r658 = add i32 0, 0

        mov     x11, #0
        //  %r659 = add i32 %r381, 0

        mov     x14, x10
        //  %r660 = add i32 0, 0

        mov     x10, #0
        mov     x11, x10
        //  %r661 = add i32 0, 0

        mov     x10, #0
        mov     x10, x10
        //  br label %bb70


        //bb70:  %r662 = phi i32 [ %r655, %bb108 ], [ %r668, %bb75 ]

        mov     x9, x9
        //bb70:  %r663 = phi i32 [ %r660, %bb108 ], [ %r670, %bb75 ]

        mov     x13, x11
        //bb70:  %r664 = phi i32 [ %r661, %bb108 ], [ %r669, %bb75 ]

        mov     x12, x10
        b     bb70
        //bb70:

bb70:

        //  %r662 = phi i32 [ %r655, %bb108 ], [ %r668, %bb75 ]

        //  %r663 = phi i32 [ %r660, %bb108 ], [ %r670, %bb75 ]

        //  %r664 = phi i32 [ %r661, %bb108 ], [ %r669, %bb75 ]

        //  %r387 = load i32, i32* @n

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     x10, [x10]
        //  %r388 = icmp slt i32 %r663, %r387

        cmp     x13, x10
        //  br i1 %r388, label %bb71, label %bb72


        b.lt     bb71
        b     bb72
        //bb71:

bb71:

        //  %r391 = sub i32 %r659, 1

        sub     x10, x14, #1
        //  %r392 = icmp slt i32 %r663, %r391

        cmp     x13, x10
        //  br i1 %r392, label %bb73, label %bb74


        b.lt     bb73
        b     bb74
        //bb73:

bb73:

        //  %r395 = getelementptr i32, i32* %r380, i32 %r663

        mov     x10, #8
        mul     x10, x13, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x10, x19, x10
        //  %r396 = load i32, i32* %r395

        ldr     x10, [x10]
        //  %r677 = add i32 %r664, %r396

        add     x10, x12, x10
        //  br label %bb75


        //bb75:  %r668 = phi i32 [ %r662, %bb73 ], [ %r671, %bb78 ]

        mov     x9, x9
        //bb75:  %r669 = phi i32 [ %r677, %bb73 ], [ %r672, %bb78 ]

        mov     x11, x10
        b     bb75
        //bb74:

bb74:

        //  %r400 = sub i32 %r659, 1

        sub     x10, x14, #1
        //  %r401 = icmp eq i32 %r663, %r400

        cmp     x13, x10
        //  br i1 %r401, label %bb76, label %bb77


        b.eq     bb76
        b     bb77
        //bb76:

bb76:

        //  %r402 = getelementptr i32, i32* %r380, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r676 = load i32, i32* %r402

        ldr     x11, [x9]
        //  %r406 = sdiv i32 %r664, %r659

        sdiv     x15, x12, x14
        //  %r407 = getelementptr i32, i32* %r380, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  store i32 %r406, i32* %r407

        str     x15, [x9]
        //  br label %bb78


        //bb78:  %r671 = phi i32 [ %r676, %bb76 ], [ %r675, %bb77 ]

        mov     x9, x11
        //bb78:  %r672 = phi i32 [ %r664, %bb76 ], [ %r673, %bb77 ]

        mov     x10, x12
        b     bb78
        //bb77:

bb77:

        //  %r410 = getelementptr i32, i32* %r380, i32 %r663

        mov     x10, #8
        mul     x10, x13, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x10, x19, x10
        //  %r411 = load i32, i32* %r410

        ldr     x10, [x10]
        //  %r412 = add i32 %r664, %r411

        add     x10, x12, x10
        //  %r673 = sub i32 %r412, %r662

        sub     x12, x10, x9
        //  %r418 = sub i32 %r663, %r659

        sub     x9, x13, x14
        //  %r674 = add i32 %r418, 1

        add     x11, x9, #1
        //  %r421 = getelementptr i32, i32* %r380, i32 %r674

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  %r675 = load i32, i32* %r421

        ldr     x10, [x9]
        //  %r425 = sdiv i32 %r673, %r659

        sdiv     x15, x12, x14
        //  %r427 = getelementptr i32, i32* %r380, i32 %r674

        mov     x9, #8
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9
        //  store i32 %r425, i32* %r427

        str     x15, [x9]
        //  br label %bb78


        //bb78:  %r671 = phi i32 [ %r676, %bb76 ], [ %r675, %bb77 ]

        mov     x9, x10
        //bb78:  %r672 = phi i32 [ %r664, %bb76 ], [ %r673, %bb77 ]

        mov     x10, x12
        b     bb78
        //bb78:

bb78:

        //  %r671 = phi i32 [ %r676, %bb76 ], [ %r675, %bb77 ]

        //  %r672 = phi i32 [ %r664, %bb76 ], [ %r673, %bb77 ]

        //  br label %bb75


        //bb75:  %r668 = phi i32 [ %r662, %bb73 ], [ %r671, %bb78 ]

        mov     x9, x9
        //bb75:  %r669 = phi i32 [ %r677, %bb73 ], [ %r672, %bb78 ]

        mov     x11, x10
        b     bb75
        //bb75:

bb75:

        //  %r668 = phi i32 [ %r662, %bb73 ], [ %r671, %bb78 ]

        //  %r669 = phi i32 [ %r677, %bb73 ], [ %r672, %bb78 ]

        //  %r670 = add i32 %r663, 1

        add     x10, x13, #1
        //  br label %bb70


        //bb70:  %r662 = phi i32 [ %r655, %bb108 ], [ %r668, %bb75 ]

        mov     x9, x9
        //bb70:  %r663 = phi i32 [ %r660, %bb108 ], [ %r670, %bb75 ]

        mov     x13, x10
        //bb70:  %r664 = phi i32 [ %r661, %bb108 ], [ %r669, %bb75 ]

        mov     x12, x11
        b     bb70
        //bb72:

bb72:

        //  %r430 = load i32, i32* @n

        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     x9, [x9]
        //  %r432 = sub i32 %r430, %r659

        sub     x9, x9, x14
        //  %r665 = add i32 %r432, 1

        add     x9, x9, #1
        //  br label %bb79


        //bb79:  %r666 = phi i32 [ %r665, %bb72 ], [ %r667, %bb80 ]

        mov     x9, x9
        b     bb79
        //bb79:

bb79:

        //  %r666 = phi i32 [ %r665, %bb72 ], [ %r667, %bb80 ]

        //  %r435 = load i32, i32* @n

        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     x10, [x10]
        //  %r436 = icmp slt i32 %r666, %r435

        cmp     x9, x10
        //  br i1 %r436, label %bb80, label %bb81


        b.lt     bb80
        b     bb81
        //bb80:

bb80:

        //  %r438 = getelementptr i32, i32* %r380, i32 %r666

        mov     x10, #8
        mul     x10, x9, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x11, x19, x10
        //  store i32 0, i32* %r438

        mov     x10, #0
        str     x10, [x11]
        //  %r667 = add i32 %r666, 1

        add     x9, x9, #1
        //  br label %bb79


        //bb79:  %r666 = phi i32 [ %r665, %bb72 ], [ %r667, %bb80 ]

        mov     x9, x9
        b     bb79
        //bb81:

bb81:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r1073->x10
        //%r1072->x9
        //%r1071->x9
        //%r1070->x9
        //%r1069->x10
        //%r1068->x9
        //%r527->x10
        //%r1067->x10
        //%r1066->x9
        //%r1065->x9
        //%r1064->x9
        //%r1063->x10
        //%r1062->x9
        //%r1060->x9
        //%r1059->x9
        //%r1058->x9
        //%r1057->x10
        //%r1056->x9
        //%r515->x10
        //%r1055->x10
        //%r1054->x9
        //%r1053->x9
        //%r1052->x9
        //%r1050->x9
        //%r1049->x10
        //%r1048->x9
        //%r1047->x9
        //%r1046->x9
        //%r505->x10
        //%r1045->x10
        //%r1044->x9
        //%r1043->x10
        //%r1042->x9
        //%r1040->x9
        //%r1039->x10
        //%r1038->x9
        //%r1037->x10
        //%r1036->x9
        //%r1035->x9
        //%r1034->x9
        //%r1033->x10
        //%r1032->x9
        //%r491->x10
        //%r1031->x10
        //%r1030->x9
        //%r1028->x9
        //%r1027->x10
        //%r1026->x9
        //%r1025->x10
        //%r1024->x9
        //%r1023->x9
        //%r482->x10
        //%r1022->x9
        //%r1021->x10
        //%r1020->x9
        //%r1018->x9
        //%r1017->x9
        //%r1016->x9
        //%r1015->x10
        //%r474->x10
        //%r1014->x9
        //%r473->x10
        //%r1013->x10
        //%r472->x10
        //%r1012->x9
        //%r471->x10
        //%r1011->x9
        //%r470->x10
        //%r1010->x9
        //%r469->x10
        //%r1009->x10
        //%r468->x10
        //%r1008->x9
        //%r467->x10
        //%r1007->x10
        //%r466->x10
        //%r1006->x9
        //%r465->x10
        //%r1004->x9
        //%r463->x10
        //%r1003->x10
        //%r462->x10
        //%r1002->x9
        //%r461->x10
        //%r1001->x10
        //%r460->x10
        //%r1000->x9
        //%r459->x10
        //%r999->x9
        //%r458->x10
        //%r998->x9
        //%r457->x10
        //%r997->x10
        //%r456->x10
        //%r995->x10
        //%r454->x10
        //%r994->x9
        //%r453->x10
        //%r993->x9
        //%r452->x10
        //%r992->x9
        //%r451->x10
        //%r991->x10
        //%r450->x10
        //%r990->x9
        //%r449->x10
        //%r989->x10
        //%r448->x10
        //%r932->x9
        //%r1061->x10
        //%r547->x10
        //%r1088->x9
        //%r928->x9
        //%r1051->x10
        //%r537->x10
        //%r1078->x9
        //%r918->x9
        //%r1005->x9
        //%r464->x10
        //%r996->x9
        //%r455->x10
        //%r988->x9
        //%r447->x10
        //%r987->x9
        //%r446->x10
        //%r986->x9
        //%r445->x10
        //%r948->x9
        //%r691->x9
        //%r947->x10
        //%r690->x9
        //%r946->x9
        //%r689->x9
        //%r945->x9
        //%r688->x9
        //%r966->x9
        //%r709->x9
        //%r944->x9
        //%r687->x9
        //%r965->x10
        //%r708->x9
        //%r943->x10
        //%r686->x9
        //%r964->x9
        //%r707->x9
        //%r942->x9
        //%r685->x9
        //%r963->x9
        //%r706->x9
        //%r941->x10
        //%r684->x9
        //%r962->x9
        //%r705->x9
        //%r940->x9
        //%r683->x9
        //%r961->x10
        //%r704->x9
        //%r939->x9
        //%r682->x9
        //%r1019->x10
        //%r960->x9
        //%r703->x9
        //%r938->x9
        //%r681->x9
        //%r678->x9
        //%r935->x10
        //%r959->x10
        //%r702->x9
        //%r956->x9
        //%r699->x10
        //%r937->x10
        //%r680->x9
        //%r934->x9
        //%r958->x9
        //%r701->x9
        //%r444->x10
        //%r985->x10
        //%r955->x10
        //%r698->x11
        //%r936->x9
        //%r679->x9
        //%r933->x9
        //%r957->x9
        //%r700->x9
        //%r443->x10
        //%r984->x9
        //%r954->x9
        //%r697->x9
        //%r949->x10
        //%r692->x9
        //%r1029->x9
        //%r967->x10
        //%r710->x10
        //%r950->x9
        //%r693->x9
        //%r968->x9
        //%r711->x9
        //%r951->x9
        //%r694->x9
        //%r969->x9
        //%r712->x10
        //%r952->x9
        //%r695->x9
        //%r970->x9
        //%r713->x9
        //%r953->x10
        //%r696->x9
        //%r971->x10
        //%r714->x10
        //%r972->x9
        //%r715->x9
        //%r973->x10
        //%r716->x10
        //%r974->x9
        //%r717->x9
        //%r975->x9
        //%r718->x10
        //%r976->x9
        //%r719->x9
        //%r977->x10
        //%r720->x10
        //%r981->x9
        //%r978->x9
        //%r721->x9
        //%r1041->x9
        //%r908->x9
        //%r982->x9
        //%r979->x10
        //%r722->x10
        //%r983->x10
        //%r980->x9
        //%r723->x9
        //%r902->x9
        //%r903->x10
        //%r904->x9
        //%r905->x10
        //%r906->x9
        //%r907->x10
        //%r909->x9
        //%r910->x9
        //%r911->x10
        //%r912->x9
        //%r913->x10
        //%r914->x9
        //%r915->x9
        //%r916->x9
        //%r917->x10
        //%r919->x10
        //%r920->x9
        //%r921->x9
        //%r922->x9
        //%r923->x10
        //%r924->x9
        //%r925->x10
        //%r926->x9
        //%r927->x9
        //%r929->x10
        //%r930->x9
        //%r931->x10
        //%r1074->x9
        //%r1075->x10
        //%r1076->x9
        //%r1077->x9
        //%r1079->x10
        //%r1080->x9
        //%r1081->x10
        //%r1082->x9
        //%r1083->x9
        //%r1084->x9
        //%r1085->x10
        //%r1086->x9
        //%r1087->x10
        //%r1089->x9
        //%r1090->x9
        //%r1091->x10
        //%r1092->x9
        //%r1093->x10
        //%r1094->x9
        //%r1095->x9
        //%r1096->x9
        //%r1097->x9
        //%r1098->x9
        //%r1099->x9
        //%r1100->x9
        //%r1101->x9
        //%r1102->x9
        //%r1103->x9
        //%r1104->x9
        //%r1105->x9
        //%r1106->x10
        //%r1107->x10
        //%r1108->x11
        //%r1109->x10
        //%r1110->x10
        //%r1111->x9
        //%r1112->x9
        //%r1113->x9
        //%r1114->x10
        //%r1115->x10
        //%r1116->x11
        //%r1117->x10
        //%r1118->x10
        //%r1119->x9
        //%r1120->x9
        //%r1121->x9
        //%r1122->x9
        //%r1123->x9
        //%r1124->x9
        //%r1125->x9
        //%r1126->x9
        //%r1127->x9
        //%r1128->x9
        //%r1129->x9
        //%r1130->x10
        //%r1131->x10
        //%r1132->x11
        //%r1133->x10
        //%r1134->x10
        //%r1135->x9
        //%r1136->x9
        //%r1137->x9
        //%r1138->x9
        //%r1139->x9
        //%r1140->x9
        //%r1141->x9
        //%r1142->x10
        //%r1143->x10
        //%r1144->x11
        //%r1145->x10
        //%r1146->x10
        //%r1147->x9
        //%r1148->x9
        //%r1149->x9
        //%r1150->x9
        //%r1151->x9
        //%r1152->x9
        //%r1153->x9
        //%r1154->x9
        //%r1155->x10
        //%r1156->x10
        //%r1157->x11
        //%r1158->x10
        //%r1159->x10
        //%r1160->x9
        //%r1161->x9
        //%r1162->x9
        //%r1163->x9
        //%r1164->x9
        //%r1165->x9
        //%r1166->x9
        //%r1167->x9
        //%r1168->x10
        //%r1169->x10
        //%r1170->x11
        //%r1171->x10
        //%r1172->x10
        //%r1173->x9
        //%r1174->x9
        //%r1175->x9
        //%r1176->x9
        //%r1177->x9
        //%r1178->x9
        //%r1179->x9
        //%r1180->x9
        //%r1181->x10
        //%r1182->x10
        //%r1183->x11
        //%r1184->x10
        //%r1185->x10
        //%r1186->x9
        //%r1187->x9
main:

        //442:x29,#-512

        //441:x29,#-256

        //bb82:

bb82:

        //  call void @_sysy_starttime(i32 209)

        mov     x16, #512
        sub     sp, sp, x16
        mov     x9, #209
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
        //  store i32 32, i32* @n

        mov     x10, #32
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     x10, [x9]
        //  %r441 = alloca [ 32 x i32 ]

        //  %r442 = alloca [ 32 x i32 ]

        //  %r443 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r443

        mov     x9, #7
        str     x9, [x10]
        //  %r444 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 23, i32* %r444

        mov     x9, #23
        str     x9, [x10]
        //  %r445 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 89, i32* %r445

        mov     x9, #89
        str     x9, [x10]
        //  %r446 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 26, i32* %r446

        mov     x9, #26
        str     x9, [x10]
        //  %r447 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 282, i32* %r447

        mov     x9, #282
        str     x9, [x10]
        //  %r448 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 5

        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 254, i32* %r448

        mov     x9, #254
        str     x9, [x10]
        //  %r449 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 6

        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 27, i32* %r449

        mov     x9, #27
        str     x9, [x10]
        //  %r450 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 5, i32* %r450

        mov     x9, #5
        str     x9, [x10]
        //  %r451 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 8

        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 83, i32* %r451

        mov     x9, #83
        str     x9, [x10]
        //  %r452 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 9

        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 273, i32* %r452

        mov     x9, #273
        str     x9, [x10]
        //  %r453 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 10

        mov     x10, #10
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 574, i32* %r453

        mov     x9, #574
        str     x9, [x10]
        //  %r454 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 11

        mov     x10, #11
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 905, i32* %r454

        mov     x9, #905
        str     x9, [x10]
        //  %r455 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 12

        mov     x10, #12
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 354, i32* %r455

        mov     x9, #354
        str     x9, [x10]
        //  %r456 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 13

        mov     x10, #13
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 657, i32* %r456

        mov     x9, #657
        str     x9, [x10]
        //  %r457 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 14

        mov     x10, #14
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 935, i32* %r457

        mov     x9, #935
        str     x9, [x10]
        //  %r458 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 15

        mov     x10, #15
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 264, i32* %r458

        mov     x9, #264
        str     x9, [x10]
        //  %r459 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 16

        mov     x10, #16
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 639, i32* %r459

        mov     x9, #639
        str     x9, [x10]
        //  %r460 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 17

        mov     x10, #17
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 459, i32* %r460

        mov     x9, #459
        str     x9, [x10]
        //  %r461 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 18

        mov     x10, #18
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 29, i32* %r461

        mov     x9, #29
        str     x9, [x10]
        //  %r462 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 19

        mov     x10, #19
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 68, i32* %r462

        mov     x9, #68
        str     x9, [x10]
        //  %r463 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 20

        mov     x10, #20
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 929, i32* %r463

        mov     x9, #929
        str     x9, [x10]
        //  %r464 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 21

        mov     x10, #21
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 756, i32* %r464

        mov     x9, #756
        str     x9, [x10]
        //  %r465 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 22

        mov     x10, #22
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 452, i32* %r465

        mov     x9, #452
        str     x9, [x10]
        //  %r466 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 23

        mov     x10, #23
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 279, i32* %r466

        mov     x9, #279
        str     x9, [x10]
        //  %r467 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 24

        mov     x10, #24
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 58, i32* %r467

        mov     x9, #58
        str     x9, [x10]
        //  %r468 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 25

        mov     x10, #25
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 87, i32* %r468

        mov     x9, #87
        str     x9, [x10]
        //  %r469 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 26

        mov     x10, #26
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 96, i32* %r469

        mov     x9, #96
        str     x9, [x10]
        //  %r470 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 27

        mov     x10, #27
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 36, i32* %r470

        mov     x9, #36
        str     x9, [x10]
        //  %r471 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 28

        mov     x10, #28
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 39, i32* %r471

        mov     x9, #39
        str     x9, [x10]
        //  %r472 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 29

        mov     x10, #29
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 28, i32* %r472

        mov     x9, #28
        str     x9, [x10]
        //  %r473 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 30

        mov     x10, #30
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r473

        mov     x9, #1
        str     x9, [x10]
        //  %r474 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0 , i32 31

        mov     x10, #31
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-256
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 290, i32* %r474

        mov     x9, #290
        str     x9, [x10]
        //  %r678 = add i32 0, 0

        mov     x9, #0
        //  %r680 = call i32 @arrCopy(i32* %r441, i32* %r442)

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r681 = call i32 @revert(i32* %r442)

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     revert
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r679 = add i32 0, 0

        mov     x9, #0
        //  %r682 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb83


        //bb83:  %r683 = phi i32 [ %r682, %bb82 ], [ %r723, %bb84 ]

        mov     x9, x9
        b     bb83
        //bb83:

bb83:

        //  %r683 = phi i32 [ %r682, %bb82 ], [ %r723, %bb84 ]

        //  %r480 = icmp slt i32 %r683, 32

        mov     x10, #32
        cmp     x9, x10
        //  br i1 %r480, label %bb84, label %bb85


        b.lt     bb84
        b     bb85
        //bb84:

bb84:

        //  %r482 = getelementptr [32 x i32 ], [32 x i32 ]* %r442, i32 0 , i32 %r683

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r722 = load i32, i32* %r482

        ldr     x10, [x10]
        //  call void @putint(i32 %r722)

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
        //  %r723 = add i32 %r683, 1

        add     x9, x9, #1
        //  br label %bb83


        //bb83:  %r683 = phi i32 [ %r682, %bb82 ], [ %r723, %bb84 ]

        mov     x9, x9
        b     bb83
        //bb85:

bb85:

        //  %r684 = call i32 @bubblesort(i32* %r442)

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     bubblesort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r685 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb86


        //bb86:  %r686 = phi i32 [ %r685, %bb85 ], [ %r721, %bb87 ]

        mov     x9, x9
        b     bb86
        //bb86:

bb86:

        //  %r686 = phi i32 [ %r685, %bb85 ], [ %r721, %bb87 ]

        //  %r489 = icmp slt i32 %r686, 32

        mov     x10, #32
        cmp     x9, x10
        //  br i1 %r489, label %bb87, label %bb88


        b.lt     bb87
        b     bb88
        //bb87:

bb87:

        //  %r491 = getelementptr [32 x i32 ], [32 x i32 ]* %r442, i32 0 , i32 %r686

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r720 = load i32, i32* %r491

        ldr     x10, [x10]
        //  call void @putint(i32 %r720)

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
        //  %r721 = add i32 %r686, 1

        add     x9, x9, #1
        //  br label %bb86


        //bb86:  %r686 = phi i32 [ %r685, %bb85 ], [ %r721, %bb87 ]

        mov     x9, x9
        b     bb86
        //bb88:

bb88:

        //  %r687 = call i32 @getMid(i32* %r442)

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getMid
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  call void @putint(i32 %r687)

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
        //  %r688 = call i32 @getMost(i32* %r442)

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getMost
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  call void @putint(i32 %r688)

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
        //  %r689 = call i32 @arrCopy(i32* %r441, i32* %r442)

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r690 = call i32 @bubblesort(i32* %r442)

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     bubblesort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r691 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb89


        //bb89:  %r692 = phi i32 [ %r691, %bb88 ], [ %r719, %bb90 ]

        mov     x9, x9
        b     bb89
        //bb89:

bb89:

        //  %r692 = phi i32 [ %r691, %bb88 ], [ %r719, %bb90 ]

        //  %r503 = icmp slt i32 %r692, 32

        mov     x10, #32
        cmp     x9, x10
        //  br i1 %r503, label %bb90, label %bb91


        b.lt     bb90
        b     bb91
        //bb90:

bb90:

        //  %r505 = getelementptr [32 x i32 ], [32 x i32 ]* %r442, i32 0 , i32 %r692

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r718 = load i32, i32* %r505

        ldr     x10, [x10]
        //  call void @putint(i32 %r718)

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
        //  %r719 = add i32 %r692, 1

        add     x9, x9, #1
        //  br label %bb89


        //bb89:  %r692 = phi i32 [ %r691, %bb88 ], [ %r719, %bb90 ]

        mov     x9, x9
        b     bb89
        //bb91:

bb91:

        //  %r693 = call i32 @arrCopy(i32* %r441, i32* %r442)

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r694 = call i32 @insertsort(i32* %r442)

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     insertsort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r695 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb92


        //bb92:  %r696 = phi i32 [ %r695, %bb91 ], [ %r717, %bb93 ]

        mov     x9, x9
        b     bb92
        //bb92:

bb92:

        //  %r696 = phi i32 [ %r695, %bb91 ], [ %r717, %bb93 ]

        //  %r513 = icmp slt i32 %r696, 32

        mov     x10, #32
        cmp     x9, x10
        //  br i1 %r513, label %bb93, label %bb94


        b.lt     bb93
        b     bb94
        //bb93:

bb93:

        //  %r515 = getelementptr [32 x i32 ], [32 x i32 ]* %r442, i32 0 , i32 %r696

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r716 = load i32, i32* %r515

        ldr     x10, [x10]
        //  call void @putint(i32 %r716)

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
        //  %r717 = add i32 %r696, 1

        add     x9, x9, #1
        //  br label %bb92


        //bb92:  %r696 = phi i32 [ %r695, %bb91 ], [ %r717, %bb93 ]

        mov     x9, x9
        b     bb92
        //bb94:

bb94:

        //  %r697 = call i32 @arrCopy(i32* %r441, i32* %r442)

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r698 = add i32 0, 0

        mov     x9, #0
        mov     x11, x9
        //  %r699 = add i32 31, 0

        mov     x9, #31
        mov     x10, x9
        //  %r700 = call i32 @QuickSort(i32* %r442, i32 %r698, i32 %r699)

        mov     x9, #-512
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
        bl     QuickSort
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb95


        //bb95:  %r701 = phi i32 [ %r698, %bb94 ], [ %r715, %bb96 ]

        mov     x9, x11
        b     bb95
        //bb95:

bb95:

        //  %r701 = phi i32 [ %r698, %bb94 ], [ %r715, %bb96 ]

        //  %r525 = icmp slt i32 %r701, 32

        mov     x10, #32
        cmp     x9, x10
        //  br i1 %r525, label %bb96, label %bb97


        b.lt     bb96
        b     bb97
        //bb96:

bb96:

        //  %r527 = getelementptr [32 x i32 ], [32 x i32 ]* %r442, i32 0 , i32 %r701

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r714 = load i32, i32* %r527

        ldr     x10, [x10]
        //  call void @putint(i32 %r714)

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
        //  %r715 = add i32 %r701, 1

        add     x9, x9, #1
        //  br label %bb95


        //bb95:  %r701 = phi i32 [ %r698, %bb94 ], [ %r715, %bb96 ]

        mov     x9, x9
        b     bb95
        //bb97:

bb97:

        //  %r702 = call i32 @arrCopy(i32* %r441, i32* %r442)

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r703 = call i32 @calSum(i32* %r442, i32 4)

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #4
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     calSum
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r704 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb98


        //bb98:  %r705 = phi i32 [ %r704, %bb97 ], [ %r713, %bb99 ]

        mov     x9, x9
        b     bb98
        //bb98:

bb98:

        //  %r705 = phi i32 [ %r704, %bb97 ], [ %r713, %bb99 ]

        //  %r535 = icmp slt i32 %r705, 32

        mov     x10, #32
        cmp     x9, x10
        //  br i1 %r535, label %bb99, label %bb100


        b.lt     bb99
        b     bb100
        //bb99:

bb99:

        //  %r537 = getelementptr [32 x i32 ], [32 x i32 ]* %r442, i32 0 , i32 %r705

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r712 = load i32, i32* %r537

        ldr     x10, [x10]
        //  call void @putint(i32 %r712)

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
        //  %r713 = add i32 %r705, 1

        add     x9, x9, #1
        //  br label %bb98


        //bb98:  %r705 = phi i32 [ %r704, %bb97 ], [ %r713, %bb99 ]

        mov     x9, x9
        b     bb98
        //bb100:

bb100:

        //  %r706 = call i32 @arrCopy(i32* %r441, i32* %r442)

        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-512
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     arrCopy
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r707 = call i32 @avgPooling(i32* %r442, i32 3)

        mov     x9, #-512
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #3
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     avgPooling
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r708 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb101


        //bb101:  %r709 = phi i32 [ %r708, %bb100 ], [ %r711, %bb102 ]

        mov     x9, x9
        b     bb101
        //bb101:

bb101:

        //  %r709 = phi i32 [ %r708, %bb100 ], [ %r711, %bb102 ]

        //  %r545 = icmp slt i32 %r709, 32

        mov     x10, #32
        cmp     x9, x10
        //  br i1 %r545, label %bb102, label %bb103


        b.lt     bb102
        b     bb103
        //bb102:

bb102:

        //  %r547 = getelementptr [32 x i32 ], [32 x i32 ]* %r442, i32 0 , i32 %r709

        mov     x10, #8
        mul     x11, x9, x10
        mov     x10, #-512
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r710 = load i32, i32* %r547

        ldr     x10, [x10]
        //  call void @putint(i32 %r710)

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
        //  %r711 = add i32 %r709, 1

        add     x9, x9, #1
        //  br label %bb101


        //bb101:  %r709 = phi i32 [ %r708, %bb100 ], [ %r711, %bb102 ]

        mov     x9, x9
        b     bb101
        //bb103:

bb103:

        //  call void @_sysy_stoptime(i32 312)

        mov     x9, #312
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
