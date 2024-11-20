declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@n = global i32 0
define i32 @bubblesort( i32* %r100 ) {
bb1:
  %r551 = add i32 0, 0
  %r552 = add i32 0, 0
  %r553 = add i32 0, 0
  %r554 = add i32 0, 0
  %r555 = add i32 0, 0
  %r556 = add i32 0, 0
  br label %bb2

bb2:
  %r557 = phi i32 [ %r556, %bb1 ], [ %r560, %bb7 ]
  %r104 = load i32, i32* @n
  %r105 = sub i32 %r104, 1
  %r106 = icmp slt i32 %r557, %r105
  br i1 %r106, label %bb3, label %bb4

bb3:
  %r558 = add i32 0, 0
  br label %bb5

bb5:
  %r559 = phi i32 [ %r558, %bb3 ], [ %r562, %bb10 ]
  %r108 = load i32, i32* @n
  %r110 = sub i32 %r108, %r557
  %r111 = sub i32 %r110, 1
  %r112 = icmp slt i32 %r559, %r111
  br i1 %r112, label %bb6, label %bb7

bb6:
  %r561 = add i32 %r559, 1
  %r117 = getelementptr i32, i32* %r100, i32 %r559
  %r118 = load i32, i32* %r117
  %r120 = getelementptr i32, i32* %r100, i32 %r561
  %r121 = load i32, i32* %r120
  %r122 = icmp sgt i32 %r118, %r121
  br i1 %r122, label %bb8, label %bb9

bb8:
  %r563 = add i32 %r559, 1
  %r128 = getelementptr i32, i32* %r100, i32 %r563
  %r564 = load i32, i32* %r128
  %r131 = getelementptr i32, i32* %r100, i32 %r559
  %r132 = load i32, i32* %r131
  %r134 = getelementptr i32, i32* %r100, i32 %r563
  store i32 %r132, i32* %r134
  %r137 = getelementptr i32, i32* %r100, i32 %r559
  store i32 %r564, i32* %r137
  br label %bb10

bb9:
  br label %bb10

bb10:
  %r562 = add i32 %r559, 1
  br label %bb5

bb7:
  %r560 = add i32 %r557, 1
  br label %bb2

bb4:
  ret i32 0
}

define i32 @insertsort( i32* %r142 ) {
bb11:
  %r565 = add i32 0, 0
  %r566 = add i32 0, 0
  %r567 = add i32 0, 0
  %r568 = add i32 0, 0
  %r569 = add i32 0, 0
  %r570 = add i32 1, 0
  br label %bb12

bb12:
  %r571 = phi i32 [ %r570, %bb11 ], [ %r576, %bb17 ]
  %r145 = load i32, i32* @n
  %r146 = icmp slt i32 %r571, %r145
  br i1 %r146, label %bb13, label %bb14

bb13:
  %r149 = getelementptr i32, i32* %r142, i32 %r571
  %r572 = load i32, i32* %r149
  %r573 = sub i32 %r571, 1
  br label %bb15

bb15:
  %r574 = phi i32 [ %r573, %bb13 ], [ %r578, %bb16 ]
  %r155 = icmp sgt i32 %r574, -1
  br i1 %r155, label %bb18, label %bb17

bb18:
  %r158 = getelementptr i32, i32* %r142, i32 %r574
  %r159 = load i32, i32* %r158
  %r160 = icmp slt i32 %r572, %r159
  br i1 %r160, label %bb16, label %bb17

bb16:
  %r577 = add i32 %r574, 1
  %r165 = getelementptr i32, i32* %r142, i32 %r574
  %r166 = load i32, i32* %r165
  %r168 = getelementptr i32, i32* %r142, i32 %r577
  store i32 %r166, i32* %r168
  %r578 = sub i32 %r574, 1
  br label %bb15

bb17:
  %r575 = add i32 %r574, 1
  %r176 = getelementptr i32, i32* %r142, i32 %r575
  store i32 %r572, i32* %r176
  %r576 = add i32 %r571, 1
  br label %bb12

bb14:
  ret i32 0
}

define i32 @QuickSort( i32* %r179, i32 %r180, i32 %r182 ) {
bb104:
  %r579 = add i32 0, 0
  %r580 = add i32 0, 0
  %r581 = add i32 0, 0
  %r582 = add i32 0, 0
  %r583 = add i32 0, 0
  %r585 = add i32 %r180, 0
  %r584 = add i32 0, 0
  %r586 = add i32 %r182, 0
  br label %bb19

bb19:
  %r186 = icmp slt i32 %r585, %r586
  br i1 %r186, label %bb20, label %bb21

bb20:
  %r587 = add i32 %r585, 0
  %r588 = add i32 %r586, 0
  %r193 = getelementptr i32, i32* %r179, i32 %r585
  %r589 = load i32, i32* %r193
  br label %bb23

bb23:
  %r590 = phi i32 [ %r587, %bb20 ], [ %r598, %bb39 ]
  %r591 = phi i32 [ %r588, %bb20 ], [ %r599, %bb39 ]
  %r197 = icmp slt i32 %r590, %r591
  br i1 %r197, label %bb24, label %bb25

bb24:
  br label %bb26

bb26:
  %r596 = phi i32 [ %r591, %bb24 ], [ %r603, %bb27 ]
  %r200 = icmp slt i32 %r590, %r596
  br i1 %r200, label %bb29, label %bb28

bb29:
  %r202 = getelementptr i32, i32* %r179, i32 %r596
  %r203 = load i32, i32* %r202
  %r205 = sub i32 %r589, 1
  %r206 = icmp sgt i32 %r203, %r205
  br i1 %r206, label %bb27, label %bb28

bb27:
  %r603 = sub i32 %r596, 1
  br label %bb26

bb28:
  %r211 = icmp slt i32 %r590, %r596
  br i1 %r211, label %bb30, label %bb31

bb30:
  %r213 = getelementptr i32, i32* %r179, i32 %r596
  %r214 = load i32, i32* %r213
  %r216 = getelementptr i32, i32* %r179, i32 %r590
  store i32 %r214, i32* %r216
  %r602 = add i32 %r590, 1
  br label %bb32

bb31:
  br label %bb32

bb32:
  %r597 = phi i32 [ %r602, %bb30 ], [ %r590, %bb31 ]
  br label %bb33

bb33:
  %r598 = phi i32 [ %r597, %bb32 ], [ %r601, %bb34 ]
  %r221 = icmp slt i32 %r598, %r596
  br i1 %r221, label %bb36, label %bb35

bb36:
  %r223 = getelementptr i32, i32* %r179, i32 %r598
  %r224 = load i32, i32* %r223
  %r226 = icmp slt i32 %r224, %r589
  br i1 %r226, label %bb34, label %bb35

bb34:
  %r601 = add i32 %r598, 1
  br label %bb33

bb35:
  %r231 = icmp slt i32 %r598, %r596
  br i1 %r231, label %bb37, label %bb38

bb37:
  %r233 = getelementptr i32, i32* %r179, i32 %r598
  %r234 = load i32, i32* %r233
  %r236 = getelementptr i32, i32* %r179, i32 %r596
  store i32 %r234, i32* %r236
  %r600 = sub i32 %r596, 1
  br label %bb39

bb38:
  br label %bb39

bb39:
  %r599 = phi i32 [ %r600, %bb37 ], [ %r596, %bb38 ]
  br label %bb23

bb25:
  %r241 = getelementptr i32, i32* %r179, i32 %r590
  store i32 %r589, i32* %r241
  %r592 = sub i32 %r590, 1
  %r593 = call i32 @QuickSort(i32* %r179, i32 %r585, i32 %r592)
  %r594 = add i32 %r590, 1
  %r595 = call i32 @QuickSort(i32* %r179, i32 %r594, i32 %r586)
  br label %bb22

bb21:
  br label %bb22

bb22:
  ret i32 0
}

define i32 @getMid( i32* %r253 ) {
bb40:
  %r604 = add i32 0, 0
  %r605 = add i32 0, 0
  %r255 = load i32, i32* @n
  %r256 = sdiv i32 %r255, 2
  %r257 = mul i32 %r256, 2
  %r258 = load i32, i32* @n
  %r259 = icmp eq i32 %r257, %r258
  br i1 %r259, label %bb41, label %bb42

bb41:
  %r260 = load i32, i32* @n
  %r607 = sdiv i32 %r260, 2
  %r608 = sub i32 %r607, 1
  %r266 = getelementptr i32, i32* %r253, i32 %r607
  %r267 = load i32, i32* %r266
  %r269 = getelementptr i32, i32* %r253, i32 %r608
  %r270 = load i32, i32* %r269
  %r271 = add i32 %r267, %r270
  %r272 = sdiv i32 %r271, 2
  ret i32 %r272
bb42:
  %r273 = load i32, i32* @n
  %r606 = sdiv i32 %r273, 2
  %r276 = getelementptr i32, i32* %r253, i32 %r606
  %r277 = load i32, i32* %r276
  ret i32 %r277
}

define i32 @getMost( i32* %r278 ) {
bb44:
  %r609 = add i32 0, 0
  %r610 = add i32 0, 0
  %r611 = add i32 0, 0
  %r279 = alloca [ 1000 x i32 ]
  %r612 = add i32 0, 0
  %r613 = add i32 0, 0
  br label %bb45

bb45:
  %r614 = phi i32 [ %r613, %bb44 ], [ %r626, %bb46 ]
  %r282 = icmp slt i32 %r614, 1000
  br i1 %r282, label %bb46, label %bb47

bb46:
  %r284 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r614
  store i32 0, i32* %r284
  %r626 = add i32 %r614, 1
  br label %bb45

bb47:
  %r615 = add i32 0, 0
  %r616 = add i32 0, 0
  br label %bb48

bb48:
  %r617 = phi i32 [ %r615, %bb47 ], [ %r623, %bb53 ]
  %r618 = phi i32 [ %r610, %bb47 ], [ %r621, %bb53 ]
  %r619 = phi i32 [ %r616, %bb47 ], [ %r622, %bb53 ]
  %r290 = load i32, i32* @n
  %r291 = icmp slt i32 %r617, %r290
  br i1 %r291, label %bb49, label %bb50

bb49:
  %r294 = getelementptr i32, i32* %r278, i32 %r617
  %r620 = load i32, i32* %r294
  %r297 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r620
  %r298 = load i32, i32* %r297
  %r299 = add i32 %r298, 1
  %r301 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r620
  store i32 %r299, i32* %r301
  %r303 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r620
  %r304 = load i32, i32* %r303
  %r306 = icmp sgt i32 %r304, %r619
  br i1 %r306, label %bb51, label %bb52

bb51:
  %r308 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r620
  %r624 = load i32, i32* %r308
  %r625 = add i32 %r620, 0
  br label %bb53

bb52:
  br label %bb53

bb53:
  %r621 = phi i32 [ %r625, %bb51 ], [ %r618, %bb52 ]
  %r622 = phi i32 [ %r624, %bb51 ], [ %r619, %bb52 ]
  %r623 = add i32 %r617, 1
  br label %bb48

bb50:
  ret i32 %r618
}

define i32 @revert( i32* %r314 ) {
bb54:
  %r627 = add i32 0, 0
  %r628 = add i32 0, 0
  %r629 = add i32 0, 0
  %r630 = add i32 0, 0
  %r631 = add i32 0, 0
  br label %bb55

bb55:
  %r632 = phi i32 [ %r631, %bb54 ], [ %r636, %bb56 ]
  %r633 = phi i32 [ %r630, %bb54 ], [ %r635, %bb56 ]
  %r320 = icmp slt i32 %r633, %r632
  br i1 %r320, label %bb56, label %bb57

bb56:
  %r322 = getelementptr i32, i32* %r314, i32 %r633
  %r634 = load i32, i32* %r322
  %r325 = getelementptr i32, i32* %r314, i32 %r632
  %r326 = load i32, i32* %r325
  %r328 = getelementptr i32, i32* %r314, i32 %r633
  store i32 %r326, i32* %r328
  %r331 = getelementptr i32, i32* %r314, i32 %r632
  store i32 %r634, i32* %r331
  %r635 = add i32 %r633, 1
  %r636 = sub i32 %r632, 1
  br label %bb55

bb57:
  ret i32 0
}

define i32 @arrCopy( i32* %r336, i32* %r337 ) {
bb58:
  %r637 = add i32 0, 0
  %r638 = add i32 0, 0
  br label %bb59

bb59:
  %r639 = phi i32 [ %r638, %bb58 ], [ %r640, %bb60 ]
  %r340 = load i32, i32* @n
  %r341 = icmp slt i32 %r639, %r340
  br i1 %r341, label %bb60, label %bb61

bb60:
  %r343 = getelementptr i32, i32* %r336, i32 %r639
  %r344 = load i32, i32* %r343
  %r346 = getelementptr i32, i32* %r337, i32 %r639
  store i32 %r344, i32* %r346
  %r640 = add i32 %r639, 1
  br label %bb59

bb61:
  ret i32 0
}

define i32 @calSum( i32* %r349, i32 %r350 ) {
bb107:
  %r641 = add i32 0, 0
  %r642 = add i32 0, 0
  %r643 = add i32 0, 0
  %r644 = add i32 %r350, 0
  br label %bb62

bb62:
  %r645 = add i32 0, 0
  %r646 = add i32 0, 0
  br label %bb63

bb63:
  %r647 = phi i32 [ %r645, %bb62 ], [ %r650, %bb68 ]
  %r648 = phi i32 [ %r646, %bb62 ], [ %r651, %bb68 ]
  %r355 = load i32, i32* @n
  %r356 = icmp slt i32 %r648, %r355
  br i1 %r356, label %bb64, label %bb65

bb64:
  %r359 = getelementptr i32, i32* %r349, i32 %r648
  %r360 = load i32, i32* %r359
  %r649 = add i32 %r647, %r360
  %r365 = sdiv i32 %r648, %r644
  %r367 = mul i32 %r365, %r644
  %r368 = sub i32 %r648, %r367
  %r370 = sub i32 %r644, 1
  %r371 = icmp ne i32 %r368, %r370
  br i1 %r371, label %bb66, label %bb67

bb66:
  %r373 = getelementptr i32, i32* %r349, i32 %r648
  store i32 0, i32* %r373
  br label %bb68

bb67:
  %r376 = getelementptr i32, i32* %r349, i32 %r648
  store i32 %r649, i32* %r376
  %r652 = add i32 0, 0
  br label %bb68

bb68:
  %r650 = phi i32 [ %r649, %bb66 ], [ %r652, %bb67 ]
  %r651 = add i32 %r648, 1
  br label %bb63

bb65:
  ret i32 0
}

define i32 @avgPooling( i32* %r379, i32 %r380 ) {
bb108:
  %r653 = add i32 0, 0
  %r654 = add i32 0, 0
  %r655 = add i32 0, 0
  %r656 = add i32 0, 0
  %r657 = add i32 0, 0
  %r658 = add i32 %r380, 0
  br label %bb69

bb69:
  %r659 = add i32 0, 0
  %r660 = add i32 0, 0
  br label %bb70

bb70:
  %r661 = phi i32 [ %r654, %bb69 ], [ %r667, %bb75 ]
  %r662 = phi i32 [ %r660, %bb69 ], [ %r668, %bb75 ]
  %r663 = phi i32 [ %r659, %bb69 ], [ %r669, %bb75 ]
  %r386 = load i32, i32* @n
  %r387 = icmp slt i32 %r663, %r386
  br i1 %r387, label %bb71, label %bb72

bb71:
  %r390 = sub i32 %r658, 1
  %r391 = icmp slt i32 %r663, %r390
  br i1 %r391, label %bb73, label %bb74

bb73:
  %r394 = getelementptr i32, i32* %r379, i32 %r663
  %r395 = load i32, i32* %r394
  %r676 = add i32 %r662, %r395
  br label %bb75

bb74:
  %r399 = sub i32 %r658, 1
  %r400 = icmp eq i32 %r663, %r399
  br i1 %r400, label %bb76, label %bb77

bb76:
  %r401 = getelementptr i32, i32* %r379, i32 0
  %r675 = load i32, i32* %r401
  %r405 = sdiv i32 %r662, %r658
  %r406 = getelementptr i32, i32* %r379, i32 0
  store i32 %r405, i32* %r406
  br label %bb78

bb77:
  %r409 = getelementptr i32, i32* %r379, i32 %r663
  %r410 = load i32, i32* %r409
  %r411 = add i32 %r662, %r410
  %r672 = sub i32 %r411, %r661
  %r417 = sub i32 %r663, %r658
  %r673 = add i32 %r417, 1
  %r420 = getelementptr i32, i32* %r379, i32 %r673
  %r674 = load i32, i32* %r420
  %r424 = sdiv i32 %r672, %r658
  %r426 = getelementptr i32, i32* %r379, i32 %r673
  store i32 %r424, i32* %r426
  br label %bb78

bb78:
  %r670 = phi i32 [ %r675, %bb76 ], [ %r674, %bb77 ]
  %r671 = phi i32 [ %r662, %bb76 ], [ %r672, %bb77 ]
  br label %bb75

bb75:
  %r667 = phi i32 [ %r661, %bb73 ], [ %r670, %bb78 ]
  %r668 = phi i32 [ %r676, %bb73 ], [ %r671, %bb78 ]
  %r669 = add i32 %r663, 1
  br label %bb70

bb72:
  %r429 = load i32, i32* @n
  %r431 = sub i32 %r429, %r658
  %r664 = add i32 %r431, 1
  br label %bb79

bb79:
  %r665 = phi i32 [ %r664, %bb72 ], [ %r666, %bb80 ]
  %r434 = load i32, i32* @n
  %r435 = icmp slt i32 %r665, %r434
  br i1 %r435, label %bb80, label %bb81

bb80:
  %r437 = getelementptr i32, i32* %r379, i32 %r665
  store i32 0, i32* %r437
  %r666 = add i32 %r665, 1
  br label %bb79

bb81:
  ret i32 0
}

define i32 @main( ) {
bb82:
  call void @_sysy_starttime(i32 209)
  store i32 32, i32* @n
  %r440 = alloca [ 32 x i32 ]
  %r441 = alloca [ 32 x i32 ]
  %r442 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 0
  store i32 7, i32* %r442
  %r443 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 1
  store i32 23, i32* %r443
  %r444 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 2
  store i32 89, i32* %r444
  %r445 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 3
  store i32 26, i32* %r445
  %r446 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 4
  store i32 282, i32* %r446
  %r447 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 5
  store i32 254, i32* %r447
  %r448 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 6
  store i32 27, i32* %r448
  %r449 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 7
  store i32 5, i32* %r449
  %r450 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 8
  store i32 83, i32* %r450
  %r451 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 9
  store i32 273, i32* %r451
  %r452 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 10
  store i32 574, i32* %r452
  %r453 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 11
  store i32 905, i32* %r453
  %r454 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 12
  store i32 354, i32* %r454
  %r455 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 13
  store i32 657, i32* %r455
  %r456 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 14
  store i32 935, i32* %r456
  %r457 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 15
  store i32 264, i32* %r457
  %r458 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 16
  store i32 639, i32* %r458
  %r459 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 17
  store i32 459, i32* %r459
  %r460 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 18
  store i32 29, i32* %r460
  %r461 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 19
  store i32 68, i32* %r461
  %r462 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 20
  store i32 929, i32* %r462
  %r463 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 21
  store i32 756, i32* %r463
  %r464 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 22
  store i32 452, i32* %r464
  %r465 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 23
  store i32 279, i32* %r465
  %r466 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 24
  store i32 58, i32* %r466
  %r467 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 25
  store i32 87, i32* %r467
  %r468 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 26
  store i32 96, i32* %r468
  %r469 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 27
  store i32 36, i32* %r469
  %r470 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 28
  store i32 39, i32* %r470
  %r471 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 29
  store i32 28, i32* %r471
  %r472 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 30
  store i32 1, i32* %r472
  %r473 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 31
  store i32 290, i32* %r473
  %r677 = add i32 0, 0
  %r679 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r680 = call i32 @revert(i32* %r441)
  %r678 = add i32 0, 0
  %r681 = add i32 0, 0
  br label %bb83

bb83:
  %r682 = phi i32 [ %r681, %bb82 ], [ %r722, %bb84 ]
  %r479 = icmp slt i32 %r682, 32
  br i1 %r479, label %bb84, label %bb85

bb84:
  %r481 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r682
  %r721 = load i32, i32* %r481
  call void @putint(i32 %r721)
  %r722 = add i32 %r682, 1
  br label %bb83

bb85:
  %r683 = call i32 @bubblesort(i32* %r441)
  %r684 = add i32 0, 0
  br label %bb86

bb86:
  %r685 = phi i32 [ %r684, %bb85 ], [ %r720, %bb87 ]
  %r488 = icmp slt i32 %r685, 32
  br i1 %r488, label %bb87, label %bb88

bb87:
  %r490 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r685
  %r719 = load i32, i32* %r490
  call void @putint(i32 %r719)
  %r720 = add i32 %r685, 1
  br label %bb86

bb88:
  %r686 = call i32 @getMid(i32* %r441)
  call void @putint(i32 %r686)
  %r687 = call i32 @getMost(i32* %r441)
  call void @putint(i32 %r687)
  %r688 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r689 = call i32 @bubblesort(i32* %r441)
  %r690 = add i32 0, 0
  br label %bb89

bb89:
  %r691 = phi i32 [ %r690, %bb88 ], [ %r718, %bb90 ]
  %r502 = icmp slt i32 %r691, 32
  br i1 %r502, label %bb90, label %bb91

bb90:
  %r504 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r691
  %r717 = load i32, i32* %r504
  call void @putint(i32 %r717)
  %r718 = add i32 %r691, 1
  br label %bb89

bb91:
  %r692 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r693 = call i32 @insertsort(i32* %r441)
  %r694 = add i32 0, 0
  br label %bb92

bb92:
  %r695 = phi i32 [ %r694, %bb91 ], [ %r716, %bb93 ]
  %r512 = icmp slt i32 %r695, 32
  br i1 %r512, label %bb93, label %bb94

bb93:
  %r514 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r695
  %r715 = load i32, i32* %r514
  call void @putint(i32 %r715)
  %r716 = add i32 %r695, 1
  br label %bb92

bb94:
  %r696 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r697 = add i32 0, 0
  %r698 = add i32 31, 0
  %r699 = call i32 @QuickSort(i32* %r441, i32 %r697, i32 %r698)
  br label %bb95

bb95:
  %r700 = phi i32 [ %r697, %bb94 ], [ %r714, %bb96 ]
  %r524 = icmp slt i32 %r700, 32
  br i1 %r524, label %bb96, label %bb97

bb96:
  %r526 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r700
  %r713 = load i32, i32* %r526
  call void @putint(i32 %r713)
  %r714 = add i32 %r700, 1
  br label %bb95

bb97:
  %r701 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r702 = call i32 @calSum(i32* %r441, i32 4)
  %r703 = add i32 0, 0
  br label %bb98

bb98:
  %r704 = phi i32 [ %r703, %bb97 ], [ %r712, %bb99 ]
  %r534 = icmp slt i32 %r704, 32
  br i1 %r534, label %bb99, label %bb100

bb99:
  %r536 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r704
  %r711 = load i32, i32* %r536
  call void @putint(i32 %r711)
  %r712 = add i32 %r704, 1
  br label %bb98

bb100:
  %r705 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r706 = call i32 @avgPooling(i32* %r441, i32 3)
  %r707 = add i32 0, 0
  br label %bb101

bb101:
  %r708 = phi i32 [ %r707, %bb100 ], [ %r710, %bb102 ]
  %r544 = icmp slt i32 %r708, 32
  br i1 %r544, label %bb102, label %bb103

bb102:
  %r546 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r708
  %r709 = load i32, i32* %r546
  call void @putint(i32 %r709)
  %r710 = add i32 %r708, 1
  br label %bb101

bb103:
  call void @_sysy_stoptime(i32 312)
  ret i32 0
}

