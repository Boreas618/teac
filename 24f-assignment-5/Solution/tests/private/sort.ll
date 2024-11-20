declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@base = global i32 16
@a = global [ 30000010 x i32 ] zeroinitializer
@ans = global i32 0
define i32 @getMaxNum( i32 %r100, i32* %r102 ) {
bb51:
  %r374 = add i32 0, 0
  %r375 = add i32 0, 0
  %r376 = add i32 0, 0
  %r377 = add i32 %r100, 0
  br label %bb1

bb1:
  %r378 = add i32 0, 0
  %r379 = add i32 0, 0
  br label %bb2

bb2:
  %r380 = phi i32 [ %r378, %bb1 ], [ %r382, %bb7 ]
  %r381 = phi i32 [ %r379, %bb1 ], [ %r383, %bb7 ]
  %r107 = icmp slt i32 %r381, %r377
  br i1 %r107, label %bb3, label %bb4

bb3:
  %r109 = getelementptr i32, i32* %r102, i32 %r381
  %r110 = load i32, i32* %r109
  %r112 = icmp sgt i32 %r110, %r380
  br i1 %r112, label %bb5, label %bb6

bb5:
  %r114 = getelementptr i32, i32* %r102, i32 %r381
  %r384 = load i32, i32* %r114
  br label %bb7

bb6:
  br label %bb7

bb7:
  %r382 = phi i32 [ %r384, %bb5 ], [ %r380, %bb6 ]
  %r383 = add i32 %r381, 1
  br label %bb2

bb4:
  ret i32 %r380
}

define i32 @getNumPos( i32 %r119, i32 %r121 ) {
bb52:
  %r385 = add i32 0, 0
  %r386 = add i32 0, 0
  %r387 = add i32 0, 0
  %r389 = add i32 %r119, 0
  %r388 = add i32 0, 0
  %r390 = add i32 %r121, 0
  br label %bb8

bb8:
  %r391 = add i32 1, 0
  %r392 = add i32 0, 0
  br label %bb9

bb9:
  %r393 = phi i32 [ %r389, %bb8 ], [ %r395, %bb10 ]
  %r394 = phi i32 [ %r392, %bb8 ], [ %r396, %bb10 ]
  %r127 = icmp slt i32 %r394, %r390
  br i1 %r127, label %bb10, label %bb11

bb10:
  %r129 = load i32, i32* @base
  %r395 = sdiv i32 %r393, %r129
  %r396 = add i32 %r394, 1
  br label %bb9

bb11:
  %r135 = load i32, i32* @base
  %r136 = sdiv i32 %r393, %r135
  %r137 = load i32, i32* @base
  %r138 = mul i32 %r136, %r137
  %r139 = sub i32 %r393, %r138
  ret i32 %r139
}

define void @radixSort( i32 %r140, i32* %r142, i32 %r143, i32 %r145 ) {
bb53:
  %r397 = add i32 0, 0
  %r398 = add i32 0, 0
  %r399 = add i32 0, 0
  %r400 = add i32 0, 0
  %r401 = add i32 0, 0
  %r402 = add i32 0, 0
  %r403 = add i32 0, 0
  %r404 = add i32 0, 0
  %r405 = add i32 0, 0
  %r406 = add i32 0, 0
  %r407 = add i32 0, 0
  %r408 = add i32 0, 0
  %r149 = alloca [ 16 x i32 ]
  %r148 = alloca [ 16 x i32 ]
  %r147 = alloca [ 16 x i32 ]
  %r409 = add i32 0, 0
  %r412 = add i32 %r140, 0
  %r410 = add i32 0, 0
  %r413 = add i32 %r143, 0
  %r411 = add i32 0, 0
  %r414 = add i32 %r145, 0
  br label %bb12

bb12:
  %r415 = add i32 0, 0
  br label %bb13

bb13:
  %r416 = phi i32 [ %r415, %bb12 ], [ %r446, %bb14 ]
  %r152 = load i32, i32* @base
  %r153 = icmp slt i32 %r416, %r152
  br i1 %r153, label %bb14, label %bb15

bb14:
  %r155 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r416
  store i32 0, i32* %r155
  %r157 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r416
  store i32 0, i32* %r157
  %r159 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r416
  store i32 0, i32* %r159
  %r446 = add i32 %r416, 1
  br label %bb13

bb15:
  %r163 = icmp eq i32 %r412, -1
  br i1 %r163, label %bb16, label %bb19

bb19:
  %r165 = add i32 %r413, 1
  %r167 = icmp sge i32 %r165, %r414
  br i1 %r167, label %bb16, label %bb17

bb16:
  ret void
bb17:
  br label %bb18

bb18:
  %r417 = add i32 %r413, 0
  br label %bb20

bb20:
  %r418 = phi i32 [ %r417, %bb18 ], [ %r445, %bb21 ]
  %r172 = icmp slt i32 %r418, %r414
  br i1 %r172, label %bb21, label %bb22

bb21:
  %r175 = getelementptr i32, i32* %r142, i32 %r418
  %r176 = load i32, i32* %r175
  %r443 = call i32 @getNumPos(i32 %r176, i32 %r412)
  %r181 = getelementptr i32, i32* %r142, i32 %r418
  %r182 = load i32, i32* %r181
  %r444 = call i32 @getNumPos(i32 %r182, i32 %r412)
  %r186 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r443
  %r187 = load i32, i32* %r186
  %r188 = add i32 %r187, 1
  %r190 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r444
  store i32 %r188, i32* %r190
  %r445 = add i32 %r418, 1
  br label %bb20

bb22:
  %r194 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 0
  store i32 %r413, i32* %r194
  %r196 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 0
  %r197 = load i32, i32* %r196
  %r198 = add i32 %r413, %r197
  %r199 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 0
  store i32 %r198, i32* %r199
  %r419 = add i32 1, 0
  br label %bb23

bb23:
  %r420 = phi i32 [ %r419, %bb22 ], [ %r442, %bb24 ]
  %r201 = load i32, i32* @base
  %r202 = icmp slt i32 %r420, %r201
  br i1 %r202, label %bb24, label %bb25

bb24:
  %r441 = sub i32 %r420, 1
  %r207 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r441
  %r208 = load i32, i32* %r207
  %r210 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r420
  store i32 %r208, i32* %r210
  %r212 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r420
  %r213 = load i32, i32* %r212
  %r215 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r420
  %r216 = load i32, i32* %r215
  %r217 = add i32 %r213, %r216
  %r219 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r420
  store i32 %r217, i32* %r219
  %r442 = add i32 %r420, 1
  br label %bb23

bb25:
  %r421 = add i32 0, 0
  br label %bb26

bb26:
  %r422 = phi i32 [ %r421, %bb25 ], [ %r428, %bb31 ]
  %r223 = load i32, i32* @base
  %r224 = icmp slt i32 %r422, %r223
  br i1 %r224, label %bb27, label %bb28

bb27:
  br label %bb29

bb29:
  %r226 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
  %r227 = load i32, i32* %r226
  %r229 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r422
  %r230 = load i32, i32* %r229
  %r231 = icmp slt i32 %r227, %r230
  br i1 %r231, label %bb30, label %bb31

bb30:
  %r234 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
  %r429 = load i32, i32* %r234
  %r238 = getelementptr i32, i32* %r142, i32 %r429
  %r430 = load i32, i32* %r238
  br label %bb32

bb32:
  %r431 = phi i32 [ %r430, %bb30 ], [ %r436, %bb33 ]
  %r242 = call i32 @getNumPos(i32 %r431, i32 %r412)
  %r244 = icmp ne i32 %r242, %r422
  br i1 %r244, label %bb33, label %bb34

bb33:
  %r433 = add i32 %r431, 0
  %r434 = call i32 @getNumPos(i32 %r433, i32 %r412)
  %r252 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r434
  %r435 = load i32, i32* %r252
  %r255 = getelementptr i32, i32* %r142, i32 %r435
  %r436 = load i32, i32* %r255
  %r437 = call i32 @getNumPos(i32 %r433, i32 %r412)
  %r261 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r437
  %r438 = load i32, i32* %r261
  %r265 = getelementptr i32, i32* %r142, i32 %r438
  store i32 %r433, i32* %r265
  %r439 = call i32 @getNumPos(i32 %r433, i32 %r412)
  %r440 = call i32 @getNumPos(i32 %r433, i32 %r412)
  %r274 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r439
  %r275 = load i32, i32* %r274
  %r276 = add i32 %r275, 1
  %r278 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r440
  store i32 %r276, i32* %r278
  br label %bb32

bb34:
  %r281 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
  %r432 = load i32, i32* %r281
  %r285 = getelementptr i32, i32* %r142, i32 %r432
  store i32 %r431, i32* %r285
  %r287 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
  %r288 = load i32, i32* %r287
  %r289 = add i32 %r288, 1
  %r291 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r422
  store i32 %r289, i32* %r291
  br label %bb29

bb31:
  %r428 = add i32 %r422, 1
  br label %bb26

bb28:
  %r423 = add i32 %r413, 0
  %r296 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 0
  store i32 %r413, i32* %r296
  %r298 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 0
  %r299 = load i32, i32* %r298
  %r300 = add i32 %r413, %r299
  %r301 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 0
  store i32 %r300, i32* %r301
  %r424 = add i32 0, 0
  br label %bb35

bb35:
  %r425 = phi i32 [ %r424, %bb28 ], [ %r426, %bb40 ]
  %r303 = load i32, i32* @base
  %r304 = icmp slt i32 %r425, %r303
  br i1 %r304, label %bb36, label %bb37

bb36:
  %r306 = icmp sgt i32 %r425, 0
  br i1 %r306, label %bb38, label %bb39

bb38:
  %r427 = sub i32 %r425, 1
  %r311 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r427
  %r312 = load i32, i32* %r311
  %r314 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r425
  store i32 %r312, i32* %r314
  %r316 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r425
  %r317 = load i32, i32* %r316
  %r319 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r425
  %r320 = load i32, i32* %r319
  %r321 = add i32 %r317, %r320
  %r323 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r425
  store i32 %r321, i32* %r323
  br label %bb40

bb39:
  br label %bb40

bb40:
  %r325 = sub i32 %r412, 1
  %r327 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r425
  %r328 = load i32, i32* %r327
  %r330 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r425
  %r331 = load i32, i32* %r330
  call void @radixSort(i32 %r325, i32* %r142, i32 %r328, i32 %r331)
  %r426 = add i32 %r425, 1
  br label %bb35

bb37:
  ret void
}

define i32 @main( ) {
bb41:
  %r447 = add i32 0, 0
  %r448 = add i32 0, 0
  %r450 = call i32 @getint()
  %r449 = add i32 0, 0
  %r451 = add i32 0, 0
  br label %bb42

bb42:
  %r452 = phi i32 [ %r451, %bb41 ], [ %r456, %bb43 ]
  %r339 = icmp slt i32 %r452, %r450
  br i1 %r339, label %bb43, label %bb44

bb43:
  %r340 = call i32 @getint()
  %r342 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r452
  store i32 %r340, i32* %r342
  %r456 = add i32 %r452, 1
  br label %bb42

bb44:
  call void @_sysy_starttime(i32 97)
  call void @radixSort(i32 8, i32* @a, i32 0, i32 %r450)
  %r453 = add i32 0, 0
  br label %bb45

bb45:
  %r454 = phi i32 [ %r453, %bb44 ], [ %r455, %bb46 ]
  %r349 = icmp slt i32 %r454, %r450
  br i1 %r349, label %bb46, label %bb47

bb46:
  %r350 = load i32, i32* @ans
  %r353 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r454
  %r354 = load i32, i32* %r353
  %r356 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r454
  %r357 = load i32, i32* %r356
  %r359 = add i32 2, %r454
  %r360 = sdiv i32 %r357, %r359
  %r362 = add i32 2, %r454
  %r363 = mul i32 %r360, %r362
  %r364 = sub i32 %r354, %r363
  %r365 = mul i32 %r454, %r364
  %r366 = add i32 %r350, %r365
  store i32 %r366, i32* @ans
  %r455 = add i32 %r454, 1
  br label %bb45

bb47:
  %r369 = load i32, i32* @ans
  %r370 = icmp slt i32 %r369, 0
  br i1 %r370, label %bb48, label %bb49

bb48:
  %r371 = load i32, i32* @ans
  %r372 = sub i32 0, %r371
  store i32 %r372, i32* @ans
  br label %bb50

bb49:
  br label %bb50

bb50:
  call void @_sysy_stoptime(i32 117)
  %r373 = load i32, i32* @ans
  call void @putint(i32 %r373)
  call void @putch(i32 10)
  ret i32 0
}

