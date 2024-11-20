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

        #%r562->x9

        #%r739->x13

        #%r561->x9

        #%r738->x13

        #%r560->x9

        #%r737->x9

        #%r559->x11

        #%r736->x9

        #%r558->x9

        #%r735->x9

        #%r557->x12

        #%r734->x13

        #%r554->x9

        #%r731->x9

        #%r551->x9

        #%r728->x9

        #%r564->x9

        #%r741->x10

        #%r100->x14

        #%r104->x9

        #%r552->x9

        #%r729->x9

        #%r117->x10

        #%r134->x10

        #%r724->x9

        #%r105->x9

        #%r553->x9

        #%r730->x9

        #%r118->x10

        #%r131->x13

        #%r137->x10

        #%r727->x9

        #%r108->x9

        #%r556->x9

        #%r733->x10

        #%r121->x9

        #%r110->x9

        #%r111->x9

        #%r555->x9

        #%r732->x10

        #%r120->x9

        #%r563->x10

        #%r740->x15

        #%r128->x9

        #%r132->x13

        #%r723->x9

        #%r725->x9

        #%r726->x9

        #%r742->x10

        #%r743->x10

        #%r744->x9
bubblesort:


        #bb1:
bb1:


        #  %r551 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x14, x0
        mov     w9, #0

        #  %r552 = add i32 0, 0
        mov     w9, #0

        #  %r553 = add i32 0, 0
        mov     w9, #0

        #  %r554 = add i32 0, 0
        mov     w9, #0

        #  %r555 = add i32 0, 0
        mov     w9, #0

        #  %r556 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb2


        #bb2:  %r557 = phi i32 [ %r556, %bb1 ], [ %r560, %bb7 ]
        mov     w12, w9
        b     bb2

        #bb2:
bb2:


        #  %r557 = phi i32 [ %r556, %bb1 ], [ %r560, %bb7 ]

        #  %r104 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]

        #  %r105 = sub i32 %r104, 1
        sub     w9, w9, #1

        #  %r106 = icmp slt i32 %r557, %r105
        cmp     w12, w9

        #  br i1 %r106, label %bb3, label %bb4

        b.lt     bb3
        b     bb4

        #bb3:
bb3:


        #  %r558 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb5


        #bb5:  %r559 = phi i32 [ %r558, %bb3 ], [ %r562, %bb10 ]
        mov     w11, w9
        b     bb5

        #bb5:
bb5:


        #  %r559 = phi i32 [ %r558, %bb3 ], [ %r562, %bb10 ]

        #  %r108 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]

        #  %r110 = sub i32 %r108, %r557
        sub     w9, w9, w12

        #  %r111 = sub i32 %r110, 1
        sub     w9, w9, #1

        #  %r112 = icmp slt i32 %r559, %r111
        cmp     w11, w9

        #  br i1 %r112, label %bb6, label %bb7

        b.lt     bb6
        b     bb7

        #bb6:
bb6:


        #  %r561 = add i32 %r559, 1
        add     w9, w11, #1

        #  %r117 = getelementptr i32, i32* %r100, i32 %r559
        mov     x10, #4
        mul     x10, x11, x10
        add     x10, x14, x10

        #  %r118 = load i32, i32* %r117
        ldr     w10, [x10]

        #  %r120 = getelementptr i32, i32* %r100, i32 %r561
        mov     x13, #4
        mul     x9, x9, x13
        add     x9, x14, x9

        #  %r121 = load i32, i32* %r120
        ldr     w9, [x9]

        #  %r122 = icmp sgt i32 %r118, %r121
        cmp     w10, w9

        #  br i1 %r122, label %bb8, label %bb9

        b.gt     bb8
        b     bb9

        #bb8:
bb8:


        #  %r563 = add i32 %r559, 1
        add     w10, w11, #1

        #  %r128 = getelementptr i32, i32* %r100, i32 %r563
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x14, x9

        #  %r564 = load i32, i32* %r128
        ldr     w9, [x9]

        #  %r131 = getelementptr i32, i32* %r100, i32 %r559
        mov     x13, #4
        mul     x13, x11, x13
        add     x13, x14, x13

        #  %r132 = load i32, i32* %r131
        ldr     w13, [x13]

        #  %r134 = getelementptr i32, i32* %r100, i32 %r563
        mov     x15, #4
        mul     x10, x10, x15
        add     x10, x14, x10

        #  store i32 %r132, i32* %r134
        str     w13, [x10]

        #  %r137 = getelementptr i32, i32* %r100, i32 %r559
        mov     x10, #4
        mul     x10, x11, x10
        add     x10, x14, x10

        #  store i32 %r564, i32* %r137
        str     w9, [x10]

        #  br label %bb10

        b     bb10

        #bb9:
bb9:


        #  br label %bb10

        b     bb10

        #bb10:
bb10:


        #  %r562 = add i32 %r559, 1
        add     w9, w11, #1

        #  br label %bb5


        #bb5:  %r559 = phi i32 [ %r558, %bb3 ], [ %r562, %bb10 ]
        mov     w11, w9
        b     bb5

        #bb7:
bb7:


        #  %r560 = add i32 %r557, 1
        add     w9, w12, #1

        #  br label %bb2


        #bb2:  %r557 = phi i32 [ %r556, %bb1 ], [ %r560, %bb7 ]
        mov     w12, w9
        b     bb2

        #bb4:
bb4:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r578->x9

        #%r165->x13

        #%r755->x9

        #%r750->x9

        #%r573->x9

        #%r576->x9

        #%r753->x9

        #%r749->x9

        #%r159->x9

        #%r572->x11

        #%r575->x10

        #%r752->x9

        #%r747->x9

        #%r570->x9

        #%r569->x9

        #%r746->x9

        #%r577->x9

        #%r754->x9

        #%r142->x14

        #%r748->x9

        #%r158->x9

        #%r571->x12

        #%r574->x10

        #%r751->x9

        #%r168->x9

        #%r758->x13

        #%r145->x9

        #%r149->x9

        #%r565->x9

        #%r745->x9

        #%r568->x9

        #%r166->x13

        #%r756->x9

        #%r176->x9

        #%r566->x9

        #%r567->x9

        #%r757->x13

        #%r759->x15

        #%r760->x9

        #%r761->x9

        #%r762->x9

        #%r763->x9
insertsort:


        #bb11:
bb11:


        #  %r565 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x14, x0
        mov     w9, #0

        #  %r566 = add i32 0, 0
        mov     w9, #0

        #  %r567 = add i32 0, 0
        mov     w9, #0

        #  %r568 = add i32 0, 0
        mov     w9, #0

        #  %r569 = add i32 0, 0
        mov     w9, #0

        #  %r570 = add i32 1, 0
        mov     w9, #1
        mov     w9, w9

        #  br label %bb12


        #bb12:  %r571 = phi i32 [ %r570, %bb11 ], [ %r576, %bb17 ]
        mov     w12, w9
        b     bb12

        #bb12:
bb12:


        #  %r571 = phi i32 [ %r570, %bb11 ], [ %r576, %bb17 ]

        #  %r145 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]

        #  %r146 = icmp slt i32 %r571, %r145
        cmp     w12, w9

        #  br i1 %r146, label %bb13, label %bb14

        b.lt     bb13
        b     bb14

        #bb13:
bb13:


        #  %r149 = getelementptr i32, i32* %r142, i32 %r571
        mov     x9, #4
        mul     x9, x12, x9
        add     x9, x14, x9

        #  %r572 = load i32, i32* %r149
        ldr     w11, [x9]

        #  %r573 = sub i32 %r571, 1
        sub     w9, w12, #1

        #  br label %bb15


        #bb15:  %r574 = phi i32 [ %r573, %bb13 ], [ %r578, %bb16 ]
        mov     w10, w9
        b     bb15

        #bb15:
bb15:


        #  %r574 = phi i32 [ %r573, %bb13 ], [ %r578, %bb16 ]

        #  %r155 = icmp sgt i32 %r574, -1
        mov     w9, #-1
        cmp     w10, w9

        #  br i1 %r155, label %bb18, label %bb17

        b.gt     bb18
        b     bb17

        #bb18:
bb18:


        #  %r158 = getelementptr i32, i32* %r142, i32 %r574
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x14, x9

        #  %r159 = load i32, i32* %r158
        ldr     w9, [x9]

        #  %r160 = icmp slt i32 %r572, %r159
        cmp     w11, w9

        #  br i1 %r160, label %bb16, label %bb17

        b.lt     bb16
        b     bb17

        #bb16:
bb16:


        #  %r577 = add i32 %r574, 1
        add     w9, w10, #1

        #  %r165 = getelementptr i32, i32* %r142, i32 %r574
        mov     x13, #4
        mul     x13, x10, x13
        add     x13, x14, x13

        #  %r166 = load i32, i32* %r165
        ldr     w13, [x13]

        #  %r168 = getelementptr i32, i32* %r142, i32 %r577
        mov     x15, #4
        mul     x9, x9, x15
        add     x9, x14, x9

        #  store i32 %r166, i32* %r168
        str     w13, [x9]

        #  %r578 = sub i32 %r574, 1
        sub     w9, w10, #1

        #  br label %bb15


        #bb15:  %r574 = phi i32 [ %r573, %bb13 ], [ %r578, %bb16 ]
        mov     w10, w9
        b     bb15

        #bb17:
bb17:


        #  %r575 = add i32 %r574, 1
        add     w10, w10, #1

        #  %r176 = getelementptr i32, i32* %r142, i32 %r575
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x14, x9

        #  store i32 %r572, i32* %r176
        str     w11, [x9]

        #  %r576 = add i32 %r571, 1
        add     w9, w12, #1

        #  br label %bb12


        #bb12:  %r571 = phi i32 [ %r570, %bb11 ], [ %r576, %bb17 ]
        mov     w12, w9
        b     bb12

        #bb14:
bb14:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r781->x9

        #%r780->x9

        #%r603->x9

        #%r779->x9

        #%r602->x9

        #%r778->x9

        #%r601->x9

        #%r777->x9

        #%r600->x9

        #%r776->x9

        #%r599->x9

        #%r775->x9

        #%r598->x10

        #%r774->x9

        #%r597->x9

        #%r216->x9

        #%r773->x9

        #%r596->x11

        #%r771->x11

        #%r594->x9

        #%r213->x9

        #%r581->x9

        #%r224->x9

        #%r223->x9

        #%r214->x15

        #%r595->x9

        #%r768->x11

        #%r591->x9

        #%r203->x15

        #%r584->x9

        #%r580->x9

        #%r202->x9

        #%r583->x9

        #%r579->x9

        #%r193->x11

        #%r770->x11

        #%r593->x9

        #%r180->x10

        #%r586->x13

        #%r205->x9

        #%r765->x11

        #%r588->x9

        #%r234->x15

        #%r582->x9

        #%r769->x10

        #%r592->x9

        #%r179->[sp,#0]

        #%r585->x14

        #%r767->x11

        #%r590->x10

        #%r236->x9

        #%r772->x9

        #%r182->x9

        #%r241->x9

        #%r766->x11

        #%r589->x12

        #%r764->x11

        #%r233->x9

        #%r587->x10

        #%r782->x9

        #%r783->x9

        #%r784->x9

        #%r785->x9

        #%r786->x9
QuickSort:


        #bb104:
bb104:


        #  %r579 = add i32 0, 0
        mov     x16, #8
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w10, w1
        mov     w9, w2
        mov     w11, #0

        #  %r580 = add i32 0, 0
        mov     w11, #0

        #  %r581 = add i32 0, 0
        mov     w11, #0

        #  %r582 = add i32 0, 0
        mov     w11, #0

        #  %r583 = add i32 0, 0
        mov     w11, #0

        #  %r585 = add i32 %r180, 0
        mov     w14, w10

        #  %r584 = add i32 0, 0
        mov     w10, #0

        #  %r586 = add i32 %r182, 0
        mov     w13, w9

        #  br label %bb19

        b     bb19

        #bb19:
bb19:


        #  %r186 = icmp slt i32 %r585, %r586
        cmp     w14, w13

        #  br i1 %r186, label %bb20, label %bb21

        b.lt     bb20
        b     bb21

        #bb20:
bb20:


        #  %r587 = add i32 %r585, 0
        mov     w10, w14

        #  %r588 = add i32 %r586, 0
        mov     w9, w13

        #  %r193 = getelementptr i32, i32* %r179, i32 %r585
        mov     x11, #4
        mul     x11, x14, x11
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x11, x19, x11

        #  %r589 = load i32, i32* %r193
        ldr     w12, [x11]

        #  br label %bb23


        #bb23:  %r590 = phi i32 [ %r587, %bb20 ], [ %r598, %bb39 ]
        mov     w10, w10

        #bb23:  %r591 = phi i32 [ %r588, %bb20 ], [ %r599, %bb39 ]
        mov     w9, w9
        b     bb23

        #bb23:
bb23:


        #  %r590 = phi i32 [ %r587, %bb20 ], [ %r598, %bb39 ]

        #  %r591 = phi i32 [ %r588, %bb20 ], [ %r599, %bb39 ]

        #  %r197 = icmp slt i32 %r590, %r591
        cmp     w10, w9

        #  br i1 %r197, label %bb24, label %bb25

        b.lt     bb24
        b     bb25

        #bb24:
bb24:


        #  br label %bb26


        #bb26:  %r596 = phi i32 [ %r591, %bb24 ], [ %r603, %bb27 ]
        mov     w11, w9
        b     bb26

        #bb26:
bb26:


        #  %r596 = phi i32 [ %r591, %bb24 ], [ %r603, %bb27 ]

        #  %r200 = icmp slt i32 %r590, %r596
        cmp     w10, w11

        #  br i1 %r200, label %bb29, label %bb28

        b.lt     bb29
        b     bb28

        #bb29:
bb29:


        #  %r202 = getelementptr i32, i32* %r179, i32 %r596
        mov     x9, #4
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r203 = load i32, i32* %r202
        ldr     w15, [x9]

        #  %r205 = sub i32 %r589, 1
        sub     w9, w12, #1

        #  %r206 = icmp sgt i32 %r203, %r205
        cmp     w15, w9

        #  br i1 %r206, label %bb27, label %bb28

        b.gt     bb27
        b     bb28

        #bb27:
bb27:


        #  %r603 = sub i32 %r596, 1
        sub     w9, w11, #1

        #  br label %bb26


        #bb26:  %r596 = phi i32 [ %r591, %bb24 ], [ %r603, %bb27 ]
        mov     w11, w9
        b     bb26

        #bb28:
bb28:


        #  %r211 = icmp slt i32 %r590, %r596
        cmp     w10, w11

        #  br i1 %r211, label %bb30, label %bb31

        b.lt     bb30
        b     bb31

        #bb30:
bb30:


        #  %r213 = getelementptr i32, i32* %r179, i32 %r596
        mov     x9, #4
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r214 = load i32, i32* %r213
        ldr     w15, [x9]

        #  %r216 = getelementptr i32, i32* %r179, i32 %r590
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  store i32 %r214, i32* %r216
        str     w15, [x9]

        #  %r602 = add i32 %r590, 1
        add     w9, w10, #1

        #  br label %bb32


        #bb32:  %r597 = phi i32 [ %r602, %bb30 ], [ %r590, %bb31 ]
        mov     w9, w9
        b     bb32

        #bb31:
bb31:


        #  br label %bb32


        #bb32:  %r597 = phi i32 [ %r602, %bb30 ], [ %r590, %bb31 ]
        mov     w9, w10
        b     bb32

        #bb32:
bb32:


        #  %r597 = phi i32 [ %r602, %bb30 ], [ %r590, %bb31 ]

        #  br label %bb33


        #bb33:  %r598 = phi i32 [ %r597, %bb32 ], [ %r601, %bb34 ]
        mov     w10, w9
        b     bb33

        #bb33:
bb33:


        #  %r598 = phi i32 [ %r597, %bb32 ], [ %r601, %bb34 ]

        #  %r221 = icmp slt i32 %r598, %r596
        cmp     w10, w11

        #  br i1 %r221, label %bb36, label %bb35

        b.lt     bb36
        b     bb35

        #bb36:
bb36:


        #  %r223 = getelementptr i32, i32* %r179, i32 %r598
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r224 = load i32, i32* %r223
        ldr     w9, [x9]

        #  %r226 = icmp slt i32 %r224, %r589
        cmp     w9, w12

        #  br i1 %r226, label %bb34, label %bb35

        b.lt     bb34
        b     bb35

        #bb34:
bb34:


        #  %r601 = add i32 %r598, 1
        add     w9, w10, #1

        #  br label %bb33


        #bb33:  %r598 = phi i32 [ %r597, %bb32 ], [ %r601, %bb34 ]
        mov     w10, w9
        b     bb33

        #bb35:
bb35:


        #  %r231 = icmp slt i32 %r598, %r596
        cmp     w10, w11

        #  br i1 %r231, label %bb37, label %bb38

        b.lt     bb37
        b     bb38

        #bb37:
bb37:


        #  %r233 = getelementptr i32, i32* %r179, i32 %r598
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r234 = load i32, i32* %r233
        ldr     w15, [x9]

        #  %r236 = getelementptr i32, i32* %r179, i32 %r596
        mov     x9, #4
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  store i32 %r234, i32* %r236
        str     w15, [x9]

        #  %r600 = sub i32 %r596, 1
        sub     w9, w11, #1

        #  br label %bb39


        #bb39:  %r599 = phi i32 [ %r600, %bb37 ], [ %r596, %bb38 ]
        mov     w9, w9
        b     bb39

        #bb38:
bb38:


        #  br label %bb39


        #bb39:  %r599 = phi i32 [ %r600, %bb37 ], [ %r596, %bb38 ]
        mov     w9, w11
        b     bb39

        #bb39:
bb39:


        #  %r599 = phi i32 [ %r600, %bb37 ], [ %r596, %bb38 ]

        #  br label %bb23


        #bb23:  %r590 = phi i32 [ %r587, %bb20 ], [ %r598, %bb39 ]
        mov     w10, w10

        #bb23:  %r591 = phi i32 [ %r588, %bb20 ], [ %r599, %bb39 ]
        mov     w9, w9
        b     bb23

        #bb25:
bb25:


        #  %r241 = getelementptr i32, i32* %r179, i32 %r590
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  store i32 %r589, i32* %r241
        str     w12, [x9]

        #  %r592 = sub i32 %r590, 1
        sub     w9, w10, #1

        #  %r593 = call i32 @QuickSort(i32* %r179, i32 %r585, i32 %r592)
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     w1, w14
        mov     w2, w9
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

        #  %r594 = add i32 %r590, 1
        add     w9, w10, #1

        #  %r595 = call i32 @QuickSort(i32* %r179, i32 %r594, i32 %r586)
        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
        mov     w1, w9
        mov     w2, w13
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

        #  br label %bb22

        b     bb22

        #bb21:
bb21:


        #  br label %bb22

        b     bb22

        #bb22:
bb22:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r790->x9

        #%r787->x9

        #%r256->x11

        #%r607->x12

        #%r253->x10

        #%r277->x9

        #%r276->x9

        #%r788->x9

        #%r257->x11

        #%r266->x11

        #%r797->x11

        #%r255->x11

        #%r604->x9

        #%r791->x9

        #%r260->x11

        #%r269->x9

        #%r800->x9

        #%r605->x9

        #%r792->x9

        #%r270->x9

        #%r801->x9

        #%r606->x11

        #%r258->x9

        #%r789->x9

        #%r793->x9

        #%r271->x10

        #%r802->x9

        #%r608->x9

        #%r795->x11

        #%r273->x11

        #%r267->x12

        #%r798->x9

        #%r794->x9

        #%r272->x9

        #%r803->x9

        #%r796->x11

        #%r799->x9
getMid:


        #bb40:
bb40:


        #  %r604 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     w9, #0

        #  %r605 = add i32 0, 0
        mov     w9, #0

        #  %r255 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w11, [x9]

        #  %r256 = sdiv i32 %r255, 2
        mov     w9, #2
        sdiv     w11, w11, w9

        #  %r257 = mul i32 %r256, 2
        mov     w9, #2
        mul     w11, w11, w9

        #  %r258 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]

        #  %r259 = icmp eq i32 %r257, %r258
        cmp     w11, w9

        #  br i1 %r259, label %bb41, label %bb42

        b.eq     bb41
        b     bb42

        #bb41:
bb41:


        #  %r260 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w11, [x9]

        #  %r607 = sdiv i32 %r260, 2
        mov     w9, #2
        sdiv     w12, w11, w9

        #  %r608 = sub i32 %r607, 1
        sub     w9, w12, #1

        #  %r266 = getelementptr i32, i32* %r253, i32 %r607
        mov     x11, #4
        mul     x11, x12, x11
        add     x11, x10, x11

        #  %r267 = load i32, i32* %r266
        ldr     w12, [x11]

        #  %r269 = getelementptr i32, i32* %r253, i32 %r608
        mov     x11, #4
        mul     x9, x9, x11
        add     x9, x10, x9

        #  %r270 = load i32, i32* %r269
        ldr     w9, [x9]

        #  %r271 = add i32 %r267, %r270
        add     w10, w12, w9

        #  %r272 = sdiv i32 %r271, 2
        mov     w9, #2
        sdiv     w9, w10, w9

        #  ret i32 %r272
        mov     w0, w9
        mov     sp, x29
        ret

        #bb42:
bb42:


        #  %r273 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w11, [x9]

        #  %r606 = sdiv i32 %r273, 2
        mov     w9, #2
        sdiv     w11, w11, w9

        #  %r276 = getelementptr i32, i32* %r253, i32 %r606
        mov     x9, #4
        mul     x9, x11, x9
        add     x9, x10, x9

        #  %r277 = load i32, i32* %r276
        ldr     w9, [x9]

        #  ret i32 %r277
        mov     w0, w9
        mov     sp, x29
        ret

        #%r833->x10

        #%r831->x10

        #%r827->x9

        #%r826->x9

        #%r824->x9

        #%r823->x10

        #%r822->x10

        #%r820->x9

        #%r819->x9

        #%r818->x9

        #%r817->x9

        #%r816->x9

        #%r308->x9

        #%r814->x11

        #%r813->x11

        #%r812->x11

        #%r304->x9

        #%r811->x12

        #%r303->x9

        #%r810->x11

        #%r808->x9

        #%r807->x9

        #%r299->x15

        #%r806->x9

        #%r298->x9

        #%r805->x9

        #%r297->x9

        #%r804->x9

        #%r832->x9

        #%r301->x9

        #%r809->x11

        #%r620->x11

        #%r830->x10

        #%r618->x13

        #%r610->x10

        #%r829->x9

        #%r617->x14

        #%r825->x10

        #%r294->x9

        #%r613->x9

        #%r622->x10

        #%r821->x9

        #%r290->x9

        #%r609->x9

        #%r828->x9

        #%r616->x9

        #%r815->x9

        #%r284->x12

        #%r623->x9

        #%r278->[sp,#0]

        #%r626->x9

        #%r611->x9

        #%r612->x9

        #%r614->x9

        #%r615->x11

        #%r619->x12

        #%r621->x11

        #%r624->x10

        #%r625->x9

        #%r834->x9

        #%r835->x9
getMost:


        #279:x29,#-4000

        #bb44:
bb44:


        #  %r609 = add i32 0, 0
        mov     x16, #4008
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w9, #0

        #  %r610 = add i32 0, 0
        mov     w9, #0
        mov     w10, w9

        #  %r611 = add i32 0, 0
        mov     w9, #0

        #  %r279 = alloca [ 1000 x i32 ]

        #  %r612 = add i32 0, 0
        mov     w9, #0

        #  %r613 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb45


        #bb45:  %r614 = phi i32 [ %r613, %bb44 ], [ %r626, %bb46 ]
        mov     w9, w9
        b     bb45

        #bb45:
bb45:


        #  %r614 = phi i32 [ %r613, %bb44 ], [ %r626, %bb46 ]

        #  %r282 = icmp slt i32 %r614, 1000
        mov     w11, #1000
        cmp     w9, w11

        #  br i1 %r282, label %bb46, label %bb47

        b.lt     bb46
        b     bb47

        #bb46:
bb46:


        #  %r284 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r614
        mov     x11, #4
        mul     x12, x9, x11
        mov     x11, #-4000
        add     x11, x29, x11
        add     x12, x11, x12

        #  store i32 0, i32* %r284
        mov     w11, #0
        str     w11, [x12]

        #  %r626 = add i32 %r614, 1
        add     w9, w9, #1

        #  br label %bb45


        #bb45:  %r614 = phi i32 [ %r613, %bb44 ], [ %r626, %bb46 ]
        mov     w9, w9
        b     bb45

        #bb47:
bb47:


        #  %r615 = add i32 0, 0
        mov     w9, #0
        mov     w11, w9

        #  %r616 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb48


        #bb48:  %r617 = phi i32 [ %r615, %bb47 ], [ %r623, %bb53 ]
        mov     w14, w11

        #bb48:  %r618 = phi i32 [ %r610, %bb47 ], [ %r621, %bb53 ]
        mov     w13, w10

        #bb48:  %r619 = phi i32 [ %r616, %bb47 ], [ %r622, %bb53 ]
        mov     w12, w9
        b     bb48

        #bb48:
bb48:


        #  %r617 = phi i32 [ %r615, %bb47 ], [ %r623, %bb53 ]

        #  %r618 = phi i32 [ %r610, %bb47 ], [ %r621, %bb53 ]

        #  %r619 = phi i32 [ %r616, %bb47 ], [ %r622, %bb53 ]

        #  %r290 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]

        #  %r291 = icmp slt i32 %r617, %r290
        cmp     w14, w9

        #  br i1 %r291, label %bb49, label %bb50

        b.lt     bb49
        b     bb50

        #bb49:
bb49:


        #  %r294 = getelementptr i32, i32* %r278, i32 %r617
        mov     x9, #4
        mul     x9, x14, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r620 = load i32, i32* %r294
        ldr     w11, [x9]

        #  %r297 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r620
        mov     x9, #4
        mul     x9, x11, x9
        mov     x10, #-4000
        add     x10, x29, x10
        add     x9, x10, x9

        #  %r298 = load i32, i32* %r297
        ldr     w9, [x9]

        #  %r299 = add i32 %r298, 1
        add     w15, w9, #1

        #  %r301 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r620
        mov     x9, #4
        mul     x10, x11, x9
        mov     x9, #-4000
        add     x9, x29, x9
        add     x9, x9, x10

        #  store i32 %r299, i32* %r301
        str     w15, [x9]

        #  %r303 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r620
        mov     x9, #4
        mul     x9, x11, x9
        mov     x10, #-4000
        add     x10, x29, x10
        add     x9, x10, x9

        #  %r304 = load i32, i32* %r303
        ldr     w9, [x9]

        #  %r306 = icmp sgt i32 %r304, %r619
        cmp     w9, w12

        #  br i1 %r306, label %bb51, label %bb52

        b.gt     bb51
        b     bb52

        #bb51:
bb51:


        #  %r308 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r620
        mov     x9, #4
        mul     x10, x11, x9
        mov     x9, #-4000
        add     x9, x29, x9
        add     x9, x9, x10

        #  %r624 = load i32, i32* %r308
        ldr     w10, [x9]

        #  %r625 = add i32 %r620, 0
        mov     w9, w11

        #  br label %bb53


        #bb53:  %r621 = phi i32 [ %r625, %bb51 ], [ %r618, %bb52 ]
        mov     w11, w9

        #bb53:  %r622 = phi i32 [ %r624, %bb51 ], [ %r619, %bb52 ]
        mov     w10, w10
        b     bb53

        #bb52:
bb52:


        #  br label %bb53


        #bb53:  %r621 = phi i32 [ %r625, %bb51 ], [ %r618, %bb52 ]
        mov     w11, w13

        #bb53:  %r622 = phi i32 [ %r624, %bb51 ], [ %r619, %bb52 ]
        mov     w10, w12
        b     bb53

        #bb53:
bb53:


        #  %r621 = phi i32 [ %r625, %bb51 ], [ %r618, %bb52 ]

        #  %r622 = phi i32 [ %r624, %bb51 ], [ %r619, %bb52 ]

        #  %r623 = add i32 %r617, 1
        add     w9, w14, #1

        #  br label %bb48


        #bb48:  %r617 = phi i32 [ %r615, %bb47 ], [ %r623, %bb53 ]
        mov     w14, w9

        #bb48:  %r618 = phi i32 [ %r610, %bb47 ], [ %r621, %bb53 ]
        mov     w13, w11

        #bb48:  %r619 = phi i32 [ %r616, %bb47 ], [ %r622, %bb53 ]
        mov     w12, w10
        b     bb48

        #bb50:
bb50:


        #  ret i32 %r618
        mov     w0, w13
        mov     sp, x29
        ret

        #%r846->x14

        #%r845->x14

        #%r314->x13

        #%r843->x12

        #%r842->x9

        #%r841->x9

        #%r840->x9

        #%r839->x9

        #%r636->x9

        #%r838->x9

        #%r635->x10

        #%r837->x9

        #%r634->x9

        #%r844->x12

        #%r322->x9

        #%r847->x12

        #%r325->x12

        #%r848->x12

        #%r326->x12

        #%r328->x14

        #%r627->x9

        #%r331->x12

        #%r630->x10

        #%r628->x9

        #%r629->x9

        #%r631->x9

        #%r632->x11

        #%r836->x9

        #%r633->x10

        #%r849->x9
revert:


        #bb54:
bb54:


        #  %r627 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x13, x0
        mov     w9, #0

        #  %r628 = add i32 0, 0
        mov     w9, #0

        #  %r629 = add i32 0, 0
        mov     w9, #0

        #  %r630 = add i32 0, 0
        mov     w9, #0
        mov     w10, w9

        #  %r631 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb55


        #bb55:  %r632 = phi i32 [ %r631, %bb54 ], [ %r636, %bb56 ]
        mov     w11, w9

        #bb55:  %r633 = phi i32 [ %r630, %bb54 ], [ %r635, %bb56 ]
        mov     w10, w10
        b     bb55

        #bb55:
bb55:


        #  %r632 = phi i32 [ %r631, %bb54 ], [ %r636, %bb56 ]

        #  %r633 = phi i32 [ %r630, %bb54 ], [ %r635, %bb56 ]

        #  %r320 = icmp slt i32 %r633, %r632
        cmp     w10, w11

        #  br i1 %r320, label %bb56, label %bb57

        b.lt     bb56
        b     bb57

        #bb56:
bb56:


        #  %r322 = getelementptr i32, i32* %r314, i32 %r633
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x13, x9

        #  %r634 = load i32, i32* %r322
        ldr     w9, [x9]

        #  %r325 = getelementptr i32, i32* %r314, i32 %r632
        mov     x12, #4
        mul     x12, x11, x12
        add     x12, x13, x12

        #  %r326 = load i32, i32* %r325
        ldr     w12, [x12]

        #  %r328 = getelementptr i32, i32* %r314, i32 %r633
        mov     x14, #4
        mul     x14, x10, x14
        add     x14, x13, x14

        #  store i32 %r326, i32* %r328
        str     w12, [x14]

        #  %r331 = getelementptr i32, i32* %r314, i32 %r632
        mov     x12, #4
        mul     x12, x11, x12
        add     x12, x13, x12

        #  store i32 %r634, i32* %r331
        str     w9, [x12]

        #  %r635 = add i32 %r633, 1
        add     w10, w10, #1

        #  %r636 = sub i32 %r632, 1
        sub     w9, w11, #1

        #  br label %bb55


        #bb55:  %r632 = phi i32 [ %r631, %bb54 ], [ %r636, %bb56 ]
        mov     w11, w9

        #bb55:  %r633 = phi i32 [ %r630, %bb54 ], [ %r635, %bb56 ]
        mov     w10, w10
        b     bb55

        #bb57:
bb57:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r852->x12

        #%r640->x9

        #%r638->x9

        #%r637->x9

        #%r346->x12

        #%r851->x9

        #%r344->x13

        #%r850->x9

        #%r343->x12

        #%r639->x9

        #%r340->x12

        #%r337->x10

        #%r336->x11

        #%r853->x12

        #%r854->x12

        #%r855->x12

        #%r856->x12

        #%r857->x9
arrCopy:


        #bb58:
bb58:


        #  %r637 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     w9, #0

        #  %r638 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb59


        #bb59:  %r639 = phi i32 [ %r638, %bb58 ], [ %r640, %bb60 ]
        mov     w9, w9
        b     bb59

        #bb59:
bb59:


        #  %r639 = phi i32 [ %r638, %bb58 ], [ %r640, %bb60 ]

        #  %r340 = load i32, i32* @n
        adrp     x12, n
        add     x12, x12, #:lo12:n
        ldr     w12, [x12]

        #  %r341 = icmp slt i32 %r639, %r340
        cmp     w9, w12

        #  br i1 %r341, label %bb60, label %bb61

        b.lt     bb60
        b     bb61

        #bb60:
bb60:


        #  %r343 = getelementptr i32, i32* %r336, i32 %r639
        mov     x12, #4
        mul     x12, x9, x12
        add     x12, x11, x12

        #  %r344 = load i32, i32* %r343
        ldr     w13, [x12]

        #  %r346 = getelementptr i32, i32* %r337, i32 %r639
        mov     x12, #4
        mul     x12, x9, x12
        add     x12, x10, x12

        #  store i32 %r344, i32* %r346
        str     w13, [x12]

        #  %r640 = add i32 %r639, 1
        add     w9, w9, #1

        #  br label %bb59


        #bb59:  %r639 = phi i32 [ %r638, %bb58 ], [ %r640, %bb60 ]
        mov     w9, w9
        b     bb59

        #bb61:
bb61:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r862->x9

        #%r859->x9

        #%r652->x9

        #%r651->x10

        #%r648->x10

        #%r647->x9

        #%r646->x10

        #%r644->x11

        #%r349->x12

        #%r643->x9

        #%r350->x10

        #%r645->x13

        #%r376->x13

        #%r355->x13

        #%r650->x9

        #%r861->x9

        #%r368->x14

        #%r641->x9

        #%r649->x9

        #%r359->x13

        #%r360->x13

        #%r373->x14

        #%r858->x9

        #%r365->x13

        #%r860->x9

        #%r367->x13

        #%r863->x13

        #%r370->x13

        #%r642->x9

        #%r864->x13

        #%r865->x13

        #%r866->x13

        #%r867->x13

        #%r868->x13

        #%r869->x13

        #%r870->x13

        #%r871->x9

        #%r872->x9
calSum:


        #bb107:
bb107:


        #  %r641 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x12, x0
        mov     w10, w1
        mov     w9, #0

        #  %r642 = add i32 0, 0
        mov     w9, #0

        #  %r643 = add i32 0, 0
        mov     w9, #0

        #  %r644 = add i32 %r350, 0
        mov     w11, w10

        #  br label %bb62

        b     bb62

        #bb62:
bb62:


        #  %r645 = add i32 0, 0
        mov     w9, #0
        mov     w13, w9

        #  %r646 = add i32 0, 0
        mov     w9, #0
        mov     w10, w9

        #  br label %bb63


        #bb63:  %r647 = phi i32 [ %r645, %bb62 ], [ %r650, %bb68 ]
        mov     w9, w13

        #bb63:  %r648 = phi i32 [ %r646, %bb62 ], [ %r651, %bb68 ]
        mov     w10, w10
        b     bb63

        #bb63:
bb63:


        #  %r647 = phi i32 [ %r645, %bb62 ], [ %r650, %bb68 ]

        #  %r648 = phi i32 [ %r646, %bb62 ], [ %r651, %bb68 ]

        #  %r355 = load i32, i32* @n
        adrp     x13, n
        add     x13, x13, #:lo12:n
        ldr     w13, [x13]

        #  %r356 = icmp slt i32 %r648, %r355
        cmp     w10, w13

        #  br i1 %r356, label %bb64, label %bb65

        b.lt     bb64
        b     bb65

        #bb64:
bb64:


        #  %r359 = getelementptr i32, i32* %r349, i32 %r648
        mov     x13, #4
        mul     x13, x10, x13
        add     x13, x12, x13

        #  %r360 = load i32, i32* %r359
        ldr     w13, [x13]

        #  %r649 = add i32 %r647, %r360
        add     w9, w9, w13

        #  %r365 = sdiv i32 %r648, %r644
        sdiv     w13, w10, w11

        #  %r367 = mul i32 %r365, %r644
        mul     w13, w13, w11

        #  %r368 = sub i32 %r648, %r367
        sub     w14, w10, w13

        #  %r370 = sub i32 %r644, 1
        sub     w13, w11, #1

        #  %r371 = icmp ne i32 %r368, %r370
        cmp     w14, w13

        #  br i1 %r371, label %bb66, label %bb67

        b.ne     bb66
        b     bb67

        #bb66:
bb66:


        #  %r373 = getelementptr i32, i32* %r349, i32 %r648
        mov     x13, #4
        mul     x13, x10, x13
        add     x14, x12, x13

        #  store i32 0, i32* %r373
        mov     w13, #0
        str     w13, [x14]

        #  br label %bb68


        #bb68:  %r650 = phi i32 [ %r649, %bb66 ], [ %r652, %bb67 ]
        mov     w9, w9
        b     bb68

        #bb67:
bb67:


        #  %r376 = getelementptr i32, i32* %r349, i32 %r648
        mov     x13, #4
        mul     x13, x10, x13
        add     x13, x12, x13

        #  store i32 %r649, i32* %r376
        str     w9, [x13]

        #  %r652 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb68


        #bb68:  %r650 = phi i32 [ %r649, %bb66 ], [ %r652, %bb67 ]
        mov     w9, w9
        b     bb68

        #bb68:
bb68:


        #  %r650 = phi i32 [ %r649, %bb66 ], [ %r652, %bb67 ]

        #  %r651 = add i32 %r648, 1
        add     w10, w10, #1

        #  br label %bb63


        #bb63:  %r647 = phi i32 [ %r645, %bb62 ], [ %r650, %bb68 ]
        mov     w9, w9

        #bb63:  %r648 = phi i32 [ %r646, %bb62 ], [ %r651, %bb68 ]
        mov     w10, w10
        b     bb63

        #bb65:
bb65:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r886->x10

        #%r885->x9

        #%r884->x9

        #%r880->x10

        #%r879->x10

        #%r876->x11

        #%r875->x11

        #%r874->x9

        #%r676->x10

        #%r672->x12

        #%r671->x10

        #%r417->x9

        #%r669->x10

        #%r668->x11

        #%r666->x9

        #%r664->x9

        #%r410->x10

        #%r663->x12

        #%r409->x10

        #%r661->x9

        #%r883->x10

        #%r411->x10

        #%r665->x9

        #%r882->x10

        #%r881->x10

        #%r675->x11

        #%r380->x10

        #%r888->x9

        #%r873->x9

        #%r401->x9

        #%r655->x9

        #%r395->x10

        #%r394->x10

        #%r390->x10

        #%r898->x10

        #%r399->x10

        #%r653->x9

        #%r424->x15

        #%r660->x10

        #%r406->x9

        #%r386->x10

        #%r894->x9

        #%r878->x10

        #%r877->x11

        #%r405->x15

        #%r659->x11

        #%r670->x9

        #%r434->x10

        #%r674->x10

        #%r420->x9

        #%r379->[sp,#0]

        #%r887->x9

        #%r673->x11

        #%r437->x11

        #%r656->x9

        #%r662->x13

        #%r426->x9

        #%r658->x14

        #%r429->x9

        #%r667->x9

        #%r431->x9

        #%r654->x9

        #%r657->x9

        #%r889->x10

        #%r890->x10

        #%r891->x9

        #%r892->x9

        #%r893->x9

        #%r895->x9

        #%r896->x10

        #%r897->x10

        #%r899->x10

        #%r900->x9
avgPooling:


        #bb108:
bb108:


        #  %r653 = add i32 0, 0
        mov     x16, #8
        sub     sp, sp, x16
        mov     x16, x0
        mov     x17, #0
        str     x16, [sp,x17]
        mov     w10, w1
        mov     w9, #0

        #  %r654 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  %r655 = add i32 0, 0
        mov     w11, #0

        #  %r656 = add i32 0, 0
        mov     w11, #0

        #  %r657 = add i32 0, 0
        mov     w11, #0

        #  %r658 = add i32 %r380, 0
        mov     w14, w10

        #  br label %bb69

        b     bb69

        #bb69:
bb69:


        #  %r659 = add i32 0, 0
        mov     w10, #0
        mov     w11, w10

        #  %r660 = add i32 0, 0
        mov     w10, #0
        mov     w10, w10

        #  br label %bb70


        #bb70:  %r661 = phi i32 [ %r654, %bb69 ], [ %r667, %bb75 ]
        mov     w9, w9

        #bb70:  %r662 = phi i32 [ %r659, %bb69 ], [ %r669, %bb75 ]
        mov     w13, w11

        #bb70:  %r663 = phi i32 [ %r660, %bb69 ], [ %r668, %bb75 ]
        mov     w12, w10
        b     bb70

        #bb70:
bb70:


        #  %r661 = phi i32 [ %r654, %bb69 ], [ %r667, %bb75 ]

        #  %r662 = phi i32 [ %r659, %bb69 ], [ %r669, %bb75 ]

        #  %r663 = phi i32 [ %r660, %bb69 ], [ %r668, %bb75 ]

        #  %r386 = load i32, i32* @n
        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]

        #  %r387 = icmp slt i32 %r662, %r386
        cmp     w13, w10

        #  br i1 %r387, label %bb71, label %bb72

        b.lt     bb71
        b     bb72

        #bb71:
bb71:


        #  %r390 = sub i32 %r658, 1
        sub     w10, w14, #1

        #  %r391 = icmp slt i32 %r662, %r390
        cmp     w13, w10

        #  br i1 %r391, label %bb73, label %bb74

        b.lt     bb73
        b     bb74

        #bb73:
bb73:


        #  %r394 = getelementptr i32, i32* %r379, i32 %r662
        mov     x10, #4
        mul     x10, x13, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x10, x19, x10

        #  %r395 = load i32, i32* %r394
        ldr     w10, [x10]

        #  %r676 = add i32 %r663, %r395
        add     w10, w12, w10

        #  br label %bb75


        #bb75:  %r667 = phi i32 [ %r661, %bb73 ], [ %r670, %bb78 ]
        mov     w9, w9

        #bb75:  %r668 = phi i32 [ %r676, %bb73 ], [ %r671, %bb78 ]
        mov     w11, w10
        b     bb75

        #bb74:
bb74:


        #  %r399 = sub i32 %r658, 1
        sub     w10, w14, #1

        #  %r400 = icmp eq i32 %r662, %r399
        cmp     w13, w10

        #  br i1 %r400, label %bb76, label %bb77

        b.eq     bb76
        b     bb77

        #bb76:
bb76:


        #  %r401 = getelementptr i32, i32* %r379, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r675 = load i32, i32* %r401
        ldr     w11, [x9]

        #  %r405 = sdiv i32 %r663, %r658
        sdiv     w15, w12, w14

        #  %r406 = getelementptr i32, i32* %r379, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x9, x10, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  store i32 %r405, i32* %r406
        str     w15, [x9]

        #  br label %bb78


        #bb78:  %r670 = phi i32 [ %r675, %bb76 ], [ %r674, %bb77 ]
        mov     w9, w11

        #bb78:  %r671 = phi i32 [ %r663, %bb76 ], [ %r672, %bb77 ]
        mov     w10, w12
        b     bb78

        #bb77:
bb77:


        #  %r409 = getelementptr i32, i32* %r379, i32 %r662
        mov     x10, #4
        mul     x10, x13, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x10, x19, x10

        #  %r410 = load i32, i32* %r409
        ldr     w10, [x10]

        #  %r411 = add i32 %r663, %r410
        add     w10, w12, w10

        #  %r672 = sub i32 %r411, %r661
        sub     w12, w10, w9

        #  %r417 = sub i32 %r662, %r658
        sub     w9, w13, w14

        #  %r673 = add i32 %r417, 1
        add     w11, w9, #1

        #  %r420 = getelementptr i32, i32* %r379, i32 %r673
        mov     x9, #4
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  %r674 = load i32, i32* %r420
        ldr     w10, [x9]

        #  %r424 = sdiv i32 %r672, %r658
        sdiv     w15, w12, w14

        #  %r426 = getelementptr i32, i32* %r379, i32 %r673
        mov     x9, #4
        mul     x9, x11, x9
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, x9

        #  store i32 %r424, i32* %r426
        str     w15, [x9]

        #  br label %bb78


        #bb78:  %r670 = phi i32 [ %r675, %bb76 ], [ %r674, %bb77 ]
        mov     w9, w10

        #bb78:  %r671 = phi i32 [ %r663, %bb76 ], [ %r672, %bb77 ]
        mov     w10, w12
        b     bb78

        #bb78:
bb78:


        #  %r670 = phi i32 [ %r675, %bb76 ], [ %r674, %bb77 ]

        #  %r671 = phi i32 [ %r663, %bb76 ], [ %r672, %bb77 ]

        #  br label %bb75


        #bb75:  %r667 = phi i32 [ %r661, %bb73 ], [ %r670, %bb78 ]
        mov     w9, w9

        #bb75:  %r668 = phi i32 [ %r676, %bb73 ], [ %r671, %bb78 ]
        mov     w11, w10
        b     bb75

        #bb75:
bb75:


        #  %r667 = phi i32 [ %r661, %bb73 ], [ %r670, %bb78 ]

        #  %r668 = phi i32 [ %r676, %bb73 ], [ %r671, %bb78 ]

        #  %r669 = add i32 %r662, 1
        add     w10, w13, #1

        #  br label %bb70


        #bb70:  %r661 = phi i32 [ %r654, %bb69 ], [ %r667, %bb75 ]
        mov     w9, w9

        #bb70:  %r662 = phi i32 [ %r659, %bb69 ], [ %r669, %bb75 ]
        mov     w13, w10

        #bb70:  %r663 = phi i32 [ %r660, %bb69 ], [ %r668, %bb75 ]
        mov     w12, w11
        b     bb70

        #bb72:
bb72:


        #  %r429 = load i32, i32* @n
        adrp     x9, n
        add     x9, x9, #:lo12:n
        ldr     w9, [x9]

        #  %r431 = sub i32 %r429, %r658
        sub     w9, w9, w14

        #  %r664 = add i32 %r431, 1
        add     w9, w9, #1

        #  br label %bb79


        #bb79:  %r665 = phi i32 [ %r664, %bb72 ], [ %r666, %bb80 ]
        mov     w9, w9
        b     bb79

        #bb79:
bb79:


        #  %r665 = phi i32 [ %r664, %bb72 ], [ %r666, %bb80 ]

        #  %r434 = load i32, i32* @n
        adrp     x10, n
        add     x10, x10, #:lo12:n
        ldr     w10, [x10]

        #  %r435 = icmp slt i32 %r665, %r434
        cmp     w9, w10

        #  br i1 %r435, label %bb80, label %bb81

        b.lt     bb80
        b     bb81

        #bb80:
bb80:


        #  %r437 = getelementptr i32, i32* %r379, i32 %r665
        mov     x10, #4
        mul     x10, x9, x10
        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x11, x19, x10

        #  store i32 0, i32* %r437
        mov     w10, #0
        str     w10, [x11]

        #  %r666 = add i32 %r665, 1
        add     w9, w9, #1

        #  br label %bb79


        #bb79:  %r665 = phi i32 [ %r664, %bb72 ], [ %r666, %bb80 ]
        mov     w9, w9
        b     bb79

        #bb81:
bb81:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r1072->x10

        #%r1071->x9

        #%r1070->x9

        #%r1069->x9

        #%r1068->x10

        #%r1067->x9

        #%r526->x10

        #%r1066->x10

        #%r1065->x9

        #%r1064->x9

        #%r1063->x9

        #%r1062->x10

        #%r1061->x9

        #%r1059->x9

        #%r1058->x9

        #%r1057->x9

        #%r1056->x10

        #%r1055->x9

        #%r514->x10

        #%r1054->x10

        #%r1053->x9

        #%r1052->x9

        #%r1051->x9

        #%r1049->x9

        #%r1048->x10

        #%r1047->x9

        #%r1046->x9

        #%r1045->x9

        #%r504->x10

        #%r1044->x10

        #%r1043->x9

        #%r1042->x10

        #%r1041->x9

        #%r1039->x9

        #%r1038->x10

        #%r1037->x9

        #%r1036->x10

        #%r1035->x9

        #%r1034->x9

        #%r1033->x9

        #%r1032->x10

        #%r1031->x9

        #%r490->x10

        #%r1030->x10

        #%r1029->x9

        #%r1027->x9

        #%r1026->x10

        #%r1025->x9

        #%r1024->x10

        #%r1023->x9

        #%r1022->x9

        #%r481->x10

        #%r1021->x9

        #%r1020->x10

        #%r1019->x9

        #%r1017->x9

        #%r1016->x9

        #%r1015->x9

        #%r1014->x10

        #%r473->x10

        #%r1013->x9

        #%r472->x10

        #%r1012->x10

        #%r471->x10

        #%r1011->x9

        #%r470->x10

        #%r1010->x9

        #%r469->x10

        #%r1009->x9

        #%r468->x10

        #%r1008->x10

        #%r467->x10

        #%r1007->x9

        #%r466->x10

        #%r1006->x10

        #%r465->x10

        #%r1005->x9

        #%r464->x10

        #%r1003->x9

        #%r462->x10

        #%r1002->x10

        #%r461->x10

        #%r1001->x9

        #%r460->x10

        #%r1000->x10

        #%r459->x10

        #%r999->x9

        #%r458->x10

        #%r998->x9

        #%r457->x10

        #%r997->x9

        #%r456->x10

        #%r996->x10

        #%r455->x10

        #%r994->x10

        #%r453->x10

        #%r993->x9

        #%r452->x10

        #%r992->x9

        #%r451->x10

        #%r991->x9

        #%r450->x10

        #%r990->x10

        #%r449->x10

        #%r989->x9

        #%r448->x10

        #%r988->x10

        #%r447->x10

        #%r931->x9

        #%r1060->x10

        #%r546->x10

        #%r1087->x9

        #%r927->x9

        #%r1050->x10

        #%r536->x10

        #%r1077->x9

        #%r917->x9

        #%r1004->x9

        #%r463->x10

        #%r995->x9

        #%r454->x10

        #%r987->x9

        #%r446->x10

        #%r986->x9

        #%r445->x10

        #%r985->x9

        #%r444->x10

        #%r947->x9

        #%r690->x9

        #%r946->x10

        #%r689->x9

        #%r945->x9

        #%r688->x9

        #%r944->x9

        #%r687->x9

        #%r965->x9

        #%r708->x9

        #%r943->x9

        #%r686->x9

        #%r964->x10

        #%r707->x9

        #%r942->x10

        #%r685->x9

        #%r963->x9

        #%r706->x9

        #%r941->x9

        #%r684->x9

        #%r962->x9

        #%r705->x9

        #%r940->x10

        #%r683->x9

        #%r961->x9

        #%r704->x9

        #%r939->x9

        #%r682->x9

        #%r960->x10

        #%r703->x9

        #%r938->x9

        #%r681->x9

        #%r1018->x10

        #%r959->x9

        #%r702->x9

        #%r937->x9

        #%r680->x9

        #%r677->x9

        #%r934->x10

        #%r958->x10

        #%r701->x9

        #%r955->x9

        #%r698->x10

        #%r936->x10

        #%r679->x9

        #%r933->x9

        #%r957->x9

        #%r700->x9

        #%r443->x10

        #%r984->x10

        #%r954->x10

        #%r697->x11

        #%r935->x9

        #%r678->x9

        #%r932->x9

        #%r956->x9

        #%r699->x9

        #%r442->x10

        #%r983->x9

        #%r953->x9

        #%r696->x9

        #%r948->x10

        #%r691->x9

        #%r1028->x9

        #%r966->x10

        #%r709->x10

        #%r949->x9

        #%r692->x9

        #%r967->x9

        #%r710->x9

        #%r950->x9

        #%r693->x9

        #%r968->x9

        #%r711->x10

        #%r951->x9

        #%r694->x9

        #%r969->x9

        #%r712->x9

        #%r952->x10

        #%r695->x9

        #%r970->x10

        #%r713->x10

        #%r971->x9

        #%r714->x9

        #%r972->x10

        #%r715->x10

        #%r973->x9

        #%r716->x9

        #%r974->x9

        #%r717->x10

        #%r975->x9

        #%r718->x9

        #%r976->x10

        #%r719->x10

        #%r980->x9

        #%r977->x9

        #%r720->x9

        #%r1040->x9

        #%r907->x9

        #%r981->x9

        #%r978->x10

        #%r721->x10

        #%r982->x10

        #%r979->x9

        #%r722->x9

        #%r901->x9

        #%r902->x10

        #%r903->x9

        #%r904->x10

        #%r905->x9

        #%r906->x10

        #%r908->x9

        #%r909->x9

        #%r910->x10

        #%r911->x9

        #%r912->x10

        #%r913->x9

        #%r914->x9

        #%r915->x9

        #%r916->x10

        #%r918->x10

        #%r919->x9

        #%r920->x9

        #%r921->x9

        #%r922->x10

        #%r923->x9

        #%r924->x10

        #%r925->x9

        #%r926->x9

        #%r928->x10

        #%r929->x9

        #%r930->x10

        #%r1073->x9

        #%r1074->x10

        #%r1075->x9

        #%r1076->x9

        #%r1078->x10

        #%r1079->x9

        #%r1080->x10

        #%r1081->x9

        #%r1082->x9

        #%r1083->x9

        #%r1084->x10

        #%r1085->x9

        #%r1086->x10

        #%r1088->x9

        #%r1089->x9

        #%r1090->x10

        #%r1091->x9

        #%r1092->x10

        #%r1093->x9

        #%r1094->x9

        #%r1095->x9

        #%r1096->x9

        #%r1097->x9

        #%r1098->x9

        #%r1099->x9

        #%r1100->x9

        #%r1101->x9

        #%r1102->x9

        #%r1103->x9

        #%r1104->x9

        #%r1105->x10

        #%r1106->x10

        #%r1107->x11

        #%r1108->x10

        #%r1109->x10

        #%r1110->x9

        #%r1111->x9

        #%r1112->x9

        #%r1113->x10

        #%r1114->x10

        #%r1115->x11

        #%r1116->x10

        #%r1117->x10

        #%r1118->x9

        #%r1119->x9

        #%r1120->x9

        #%r1121->x9

        #%r1122->x9

        #%r1123->x9

        #%r1124->x9

        #%r1125->x9

        #%r1126->x9

        #%r1127->x9

        #%r1128->x9

        #%r1129->x10

        #%r1130->x10

        #%r1131->x11

        #%r1132->x10

        #%r1133->x10

        #%r1134->x9

        #%r1135->x9

        #%r1136->x9

        #%r1137->x9

        #%r1138->x9

        #%r1139->x9

        #%r1140->x9

        #%r1141->x10

        #%r1142->x10

        #%r1143->x11

        #%r1144->x10

        #%r1145->x10

        #%r1146->x9

        #%r1147->x9

        #%r1148->x9

        #%r1149->x9

        #%r1150->x9

        #%r1151->x9

        #%r1152->x9

        #%r1153->x9

        #%r1154->x10

        #%r1155->x10

        #%r1156->x11

        #%r1157->x10

        #%r1158->x10

        #%r1159->x9

        #%r1160->x9

        #%r1161->x9

        #%r1162->x9

        #%r1163->x9

        #%r1164->x9

        #%r1165->x9

        #%r1166->x9

        #%r1167->x10

        #%r1168->x10

        #%r1169->x11

        #%r1170->x10

        #%r1171->x10

        #%r1172->x9

        #%r1173->x9

        #%r1174->x9

        #%r1175->x9

        #%r1176->x9

        #%r1177->x9

        #%r1178->x9

        #%r1179->x9

        #%r1180->x10

        #%r1181->x10

        #%r1182->x11

        #%r1183->x10

        #%r1184->x10

        #%r1185->x9

        #%r1186->x9
main:


        #441:x29,#-256

        #440:x29,#-128

        #bb82:
bb82:


        #  call void @_sysy_starttime(i32 209)
        mov     x16, #256
        sub     sp, sp, x16
        mov     w9, #209
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

        #  store i32 32, i32* @n
        mov     w10, #32
        adrp     x9, n
        add     x9, x9, #:lo12:n
        str     w10, [x9]

        #  %r440 = alloca [ 32 x i32 ]

        #  %r441 = alloca [ 32 x i32 ]

        #  %r442 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 0
        mov     x10, #0
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 7, i32* %r442
        mov     w9, #7
        str     w9, [x10]

        #  %r443 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 1
        mov     x10, #1
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 23, i32* %r443
        mov     w9, #23
        str     w9, [x10]

        #  %r444 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 2
        mov     x10, #2
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 89, i32* %r444
        mov     w9, #89
        str     w9, [x10]

        #  %r445 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 3
        mov     x10, #3
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 26, i32* %r445
        mov     w9, #26
        str     w9, [x10]

        #  %r446 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 4
        mov     x10, #4
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 282, i32* %r446
        mov     w9, #282
        str     w9, [x10]

        #  %r447 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 5
        mov     x10, #5
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 254, i32* %r447
        mov     w9, #254
        str     w9, [x10]

        #  %r448 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 6
        mov     x10, #6
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 27, i32* %r448
        mov     w9, #27
        str     w9, [x10]

        #  %r449 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 7
        mov     x10, #7
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 5, i32* %r449
        mov     w9, #5
        str     w9, [x10]

        #  %r450 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 8
        mov     x10, #8
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 83, i32* %r450
        mov     w9, #83
        str     w9, [x10]

        #  %r451 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 9
        mov     x10, #9
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 273, i32* %r451
        mov     w9, #273
        str     w9, [x10]

        #  %r452 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 10
        mov     x10, #10
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 574, i32* %r452
        mov     w9, #574
        str     w9, [x10]

        #  %r453 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 11
        mov     x10, #11
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 905, i32* %r453
        mov     w9, #905
        str     w9, [x10]

        #  %r454 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 12
        mov     x10, #12
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 354, i32* %r454
        mov     w9, #354
        str     w9, [x10]

        #  %r455 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 13
        mov     x10, #13
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 657, i32* %r455
        mov     w9, #657
        str     w9, [x10]

        #  %r456 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 14
        mov     x10, #14
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 935, i32* %r456
        mov     w9, #935
        str     w9, [x10]

        #  %r457 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 15
        mov     x10, #15
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 264, i32* %r457
        mov     w9, #264
        str     w9, [x10]

        #  %r458 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 16
        mov     x10, #16
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 639, i32* %r458
        mov     w9, #639
        str     w9, [x10]

        #  %r459 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 17
        mov     x10, #17
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 459, i32* %r459
        mov     w9, #459
        str     w9, [x10]

        #  %r460 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 18
        mov     x10, #18
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 29, i32* %r460
        mov     w9, #29
        str     w9, [x10]

        #  %r461 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 19
        mov     x10, #19
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 68, i32* %r461
        mov     w9, #68
        str     w9, [x10]

        #  %r462 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 20
        mov     x10, #20
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 929, i32* %r462
        mov     w9, #929
        str     w9, [x10]

        #  %r463 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 21
        mov     x10, #21
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 756, i32* %r463
        mov     w9, #756
        str     w9, [x10]

        #  %r464 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 22
        mov     x10, #22
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 452, i32* %r464
        mov     w9, #452
        str     w9, [x10]

        #  %r465 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 23
        mov     x10, #23
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 279, i32* %r465
        mov     w9, #279
        str     w9, [x10]

        #  %r466 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 24
        mov     x10, #24
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 58, i32* %r466
        mov     w9, #58
        str     w9, [x10]

        #  %r467 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 25
        mov     x10, #25
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 87, i32* %r467
        mov     w9, #87
        str     w9, [x10]

        #  %r468 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 26
        mov     x10, #26
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 96, i32* %r468
        mov     w9, #96
        str     w9, [x10]

        #  %r469 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 27
        mov     x10, #27
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 36, i32* %r469
        mov     w9, #36
        str     w9, [x10]

        #  %r470 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 28
        mov     x10, #28
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 39, i32* %r470
        mov     w9, #39
        str     w9, [x10]

        #  %r471 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 29
        mov     x10, #29
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 28, i32* %r471
        mov     w9, #28
        str     w9, [x10]

        #  %r472 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 30
        mov     x10, #30
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 1, i32* %r472
        mov     w9, #1
        str     w9, [x10]

        #  %r473 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 31
        mov     x10, #31
        mov     x9, #4
        mul     x10, x10, x9
        mov     x9, #-128
        add     x9, x29, x9
        add     x10, x9, x10

        #  store i32 290, i32* %r473
        mov     w9, #290
        str     w9, [x10]

        #  %r677 = add i32 0, 0
        mov     w9, #0

        #  %r679 = call i32 @arrCopy(i32* %r440, i32* %r441)
        mov     x9, #-128
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-256
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

        #  %r680 = call i32 @revert(i32* %r441)
        mov     x9, #-256
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

        #  %r678 = add i32 0, 0
        mov     w9, #0

        #  %r681 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb83


        #bb83:  %r682 = phi i32 [ %r681, %bb82 ], [ %r722, %bb84 ]
        mov     w9, w9
        b     bb83

        #bb83:
bb83:


        #  %r682 = phi i32 [ %r681, %bb82 ], [ %r722, %bb84 ]

        #  %r479 = icmp slt i32 %r682, 32
        mov     w10, #32
        cmp     w9, w10

        #  br i1 %r479, label %bb84, label %bb85

        b.lt     bb84
        b     bb85

        #bb84:
bb84:


        #  %r481 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r682
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r721 = load i32, i32* %r481
        ldr     w10, [x10]

        #  call void @putint(i32 %r721)
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

        #  %r722 = add i32 %r682, 1
        add     w9, w9, #1

        #  br label %bb83


        #bb83:  %r682 = phi i32 [ %r681, %bb82 ], [ %r722, %bb84 ]
        mov     w9, w9
        b     bb83

        #bb85:
bb85:


        #  %r683 = call i32 @bubblesort(i32* %r441)
        mov     x9, #-256
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

        #  %r684 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb86


        #bb86:  %r685 = phi i32 [ %r684, %bb85 ], [ %r720, %bb87 ]
        mov     w9, w9
        b     bb86

        #bb86:
bb86:


        #  %r685 = phi i32 [ %r684, %bb85 ], [ %r720, %bb87 ]

        #  %r488 = icmp slt i32 %r685, 32
        mov     w10, #32
        cmp     w9, w10

        #  br i1 %r488, label %bb87, label %bb88

        b.lt     bb87
        b     bb88

        #bb87:
bb87:


        #  %r490 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r685
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r719 = load i32, i32* %r490
        ldr     w10, [x10]

        #  call void @putint(i32 %r719)
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

        #  %r720 = add i32 %r685, 1
        add     w9, w9, #1

        #  br label %bb86


        #bb86:  %r685 = phi i32 [ %r684, %bb85 ], [ %r720, %bb87 ]
        mov     w9, w9
        b     bb86

        #bb88:
bb88:


        #  %r686 = call i32 @getMid(i32* %r441)
        mov     x9, #-256
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
        mov     w9, w0

        #  call void @putint(i32 %r686)
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

        #  %r687 = call i32 @getMost(i32* %r441)
        mov     x9, #-256
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
        mov     w9, w0

        #  call void @putint(i32 %r687)
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

        #  %r688 = call i32 @arrCopy(i32* %r440, i32* %r441)
        mov     x9, #-128
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-256
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

        #  %r689 = call i32 @bubblesort(i32* %r441)
        mov     x9, #-256
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

        #  %r690 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb89


        #bb89:  %r691 = phi i32 [ %r690, %bb88 ], [ %r718, %bb90 ]
        mov     w9, w9
        b     bb89

        #bb89:
bb89:


        #  %r691 = phi i32 [ %r690, %bb88 ], [ %r718, %bb90 ]

        #  %r502 = icmp slt i32 %r691, 32
        mov     w10, #32
        cmp     w9, w10

        #  br i1 %r502, label %bb90, label %bb91

        b.lt     bb90
        b     bb91

        #bb90:
bb90:


        #  %r504 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r691
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r717 = load i32, i32* %r504
        ldr     w10, [x10]

        #  call void @putint(i32 %r717)
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

        #  %r718 = add i32 %r691, 1
        add     w9, w9, #1

        #  br label %bb89


        #bb89:  %r691 = phi i32 [ %r690, %bb88 ], [ %r718, %bb90 ]
        mov     w9, w9
        b     bb89

        #bb91:
bb91:


        #  %r692 = call i32 @arrCopy(i32* %r440, i32* %r441)
        mov     x9, #-128
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-256
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

        #  %r693 = call i32 @insertsort(i32* %r441)
        mov     x9, #-256
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

        #  %r694 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb92


        #bb92:  %r695 = phi i32 [ %r694, %bb91 ], [ %r716, %bb93 ]
        mov     w9, w9
        b     bb92

        #bb92:
bb92:


        #  %r695 = phi i32 [ %r694, %bb91 ], [ %r716, %bb93 ]

        #  %r512 = icmp slt i32 %r695, 32
        mov     w10, #32
        cmp     w9, w10

        #  br i1 %r512, label %bb93, label %bb94

        b.lt     bb93
        b     bb94

        #bb93:
bb93:


        #  %r514 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r695
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r715 = load i32, i32* %r514
        ldr     w10, [x10]

        #  call void @putint(i32 %r715)
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

        #  %r716 = add i32 %r695, 1
        add     w9, w9, #1

        #  br label %bb92


        #bb92:  %r695 = phi i32 [ %r694, %bb91 ], [ %r716, %bb93 ]
        mov     w9, w9
        b     bb92

        #bb94:
bb94:


        #  %r696 = call i32 @arrCopy(i32* %r440, i32* %r441)
        mov     x9, #-128
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-256
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

        #  %r697 = add i32 0, 0
        mov     w9, #0
        mov     w11, w9

        #  %r698 = add i32 31, 0
        mov     w9, #31
        mov     w10, w9

        #  %r699 = call i32 @QuickSort(i32* %r441, i32 %r697, i32 %r698)
        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w11
        mov     w2, w10
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

        #  br label %bb95


        #bb95:  %r700 = phi i32 [ %r697, %bb94 ], [ %r714, %bb96 ]
        mov     w9, w11
        b     bb95

        #bb95:
bb95:


        #  %r700 = phi i32 [ %r697, %bb94 ], [ %r714, %bb96 ]

        #  %r524 = icmp slt i32 %r700, 32
        mov     w10, #32
        cmp     w9, w10

        #  br i1 %r524, label %bb96, label %bb97

        b.lt     bb96
        b     bb97

        #bb96:
bb96:


        #  %r526 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r700
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r713 = load i32, i32* %r526
        ldr     w10, [x10]

        #  call void @putint(i32 %r713)
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

        #  %r714 = add i32 %r700, 1
        add     w9, w9, #1

        #  br label %bb95


        #bb95:  %r700 = phi i32 [ %r697, %bb94 ], [ %r714, %bb96 ]
        mov     w9, w9
        b     bb95

        #bb97:
bb97:


        #  %r701 = call i32 @arrCopy(i32* %r440, i32* %r441)
        mov     x9, #-128
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-256
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

        #  %r702 = call i32 @calSum(i32* %r441, i32 4)
        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     w9, #4
        mov     w1, w9
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

        #  %r703 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb98


        #bb98:  %r704 = phi i32 [ %r703, %bb97 ], [ %r712, %bb99 ]
        mov     w9, w9
        b     bb98

        #bb98:
bb98:


        #  %r704 = phi i32 [ %r703, %bb97 ], [ %r712, %bb99 ]

        #  %r534 = icmp slt i32 %r704, 32
        mov     w10, #32
        cmp     w9, w10

        #  br i1 %r534, label %bb99, label %bb100

        b.lt     bb99
        b     bb100

        #bb99:
bb99:


        #  %r536 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r704
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r711 = load i32, i32* %r536
        ldr     w10, [x10]

        #  call void @putint(i32 %r711)
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

        #  %r712 = add i32 %r704, 1
        add     w9, w9, #1

        #  br label %bb98


        #bb98:  %r704 = phi i32 [ %r703, %bb97 ], [ %r712, %bb99 ]
        mov     w9, w9
        b     bb98

        #bb100:
bb100:


        #  %r705 = call i32 @arrCopy(i32* %r440, i32* %r441)
        mov     x9, #-128
        add     x9, x29, x9
        mov     x0, x9
        mov     x9, #-256
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

        #  %r706 = call i32 @avgPooling(i32* %r441, i32 3)
        mov     x9, #-256
        add     x9, x29, x9
        mov     x0, x9
        mov     w9, #3
        mov     w1, w9
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

        #  %r707 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb101


        #bb101:  %r708 = phi i32 [ %r707, %bb100 ], [ %r710, %bb102 ]
        mov     w9, w9
        b     bb101

        #bb101:
bb101:


        #  %r708 = phi i32 [ %r707, %bb100 ], [ %r710, %bb102 ]

        #  %r544 = icmp slt i32 %r708, 32
        mov     w10, #32
        cmp     w9, w10

        #  br i1 %r544, label %bb102, label %bb103

        b.lt     bb102
        b     bb103

        #bb102:
bb102:


        #  %r546 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r708
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-256
        add     x10, x29, x10
        add     x10, x10, x11

        #  %r709 = load i32, i32* %r546
        ldr     w10, [x10]

        #  call void @putint(i32 %r709)
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

        #  %r710 = add i32 %r708, 1
        add     w9, w9, #1

        #  br label %bb101


        #bb101:  %r708 = phi i32 [ %r707, %bb100 ], [ %r710, %bb102 ]
        mov     w9, w9
        b     bb101

        #bb103:
bb103:


        #  call void @_sysy_stoptime(i32 312)
        mov     w9, #312
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
