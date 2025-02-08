declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@n = global i32 0
@m = global i32 0
@to = global [ 5005 x i32 ] zeroinitializer
@next = global [ 5005 x i32 ] zeroinitializer
@head = global [ 1005 x i32 ] zeroinitializer
@cnt = global i32 0
@que = global [ 1005 x i32 ] zeroinitializer
@h = global i32 0
@tail = global i32 0
@inq = global [ 1005 x i32 ] zeroinitializer
define i32 @quickread( ) {
bb1:
  %r252 = add i32 0, 0
  %r255 = call i32 @getch()
  %r253 = add i32 0, 0
  %r256 = add i32 0, 0
  %r254 = add i32 0, 0
  %r257 = add i32 0, 0
  br label %bb2

bb2:
  %r258 = phi i32 [ %r257, %bb1 ], [ %r260, %bb8 ]
  %r259 = phi i32 [ %r255, %bb1 ], [ %r261, %bb8 ]
  %r105 = icmp slt i32 %r259, 48
  br i1 %r105, label %bb3, label %bb5

bb5:
  %r107 = icmp sgt i32 %r259, 57
  br i1 %r107, label %bb3, label %bb4

bb3:
  %r109 = icmp eq i32 %r259, 45
  br i1 %r109, label %bb6, label %bb7

bb6:
  %r262 = add i32 1, 0
  br label %bb8

bb7:
  br label %bb8

bb8:
  %r260 = phi i32 [ %r262, %bb6 ], [ %r258, %bb7 ]
  %r261 = call i32 @getch()
  br label %bb2

bb4:
  br label %bb9

bb9:
  %r263 = phi i32 [ %r256, %bb4 ], [ %r265, %bb10 ]
  %r264 = phi i32 [ %r259, %bb4 ], [ %r266, %bb10 ]
  %r112 = icmp sge i32 %r264, 48
  br i1 %r112, label %bb12, label %bb11

bb12:
  %r114 = icmp sle i32 %r264, 57
  br i1 %r114, label %bb10, label %bb11

bb10:
  %r116 = mul i32 %r263, 10
  %r118 = add i32 %r116, %r264
  %r265 = sub i32 %r118, 48
  %r266 = call i32 @getch()
  br label %bb9

bb11:
  %r122 = icmp ne i32 %r258, 0
  br i1 %r122, label %bb13, label %bb14

bb13:
  %r124 = sub i32 0, %r263
  ret i32 %r124
bb14:
  ret i32 %r263
}

define void @addedge( i32 %r126, i32 %r128 ) {
bb52:
  %r267 = add i32 0, 0
  %r269 = add i32 %r126, 0
  %r268 = add i32 0, 0
  %r270 = add i32 %r128, 0
  br label %bb16

bb16:
  %r131 = load i32, i32* @cnt
  %r132 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r131
  store i32 %r270, i32* %r132
  %r134 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r269
  %r135 = load i32, i32* %r134
  %r136 = load i32, i32* @cnt
  %r137 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r136
  store i32 %r135, i32* %r137
  %r138 = load i32, i32* @cnt
  %r140 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r269
  store i32 %r138, i32* %r140
  %r141 = load i32, i32* @cnt
  %r142 = add i32 %r141, 1
  store i32 %r142, i32* @cnt
  %r144 = load i32, i32* @cnt
  %r145 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r144
  store i32 %r269, i32* %r145
  %r147 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r270
  %r148 = load i32, i32* %r147
  %r149 = load i32, i32* @cnt
  %r150 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r149
  store i32 %r148, i32* %r150
  %r151 = load i32, i32* @cnt
  %r153 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r270
  store i32 %r151, i32* %r153
  %r154 = load i32, i32* @cnt
  %r155 = add i32 %r154, 1
  store i32 %r155, i32* @cnt
  ret void
}

define void @init( ) {
bb17:
  %r271 = add i32 0, 0
  %r272 = add i32 0, 0
  br label %bb18

bb18:
  %r273 = phi i32 [ %r272, %bb17 ], [ %r274, %bb19 ]
  %r158 = icmp slt i32 %r273, 1005
  br i1 %r158, label %bb19, label %bb20

bb19:
  %r160 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r273
  store i32 -1, i32* %r160
  %r274 = add i32 %r273, 1
  br label %bb18

bb20:
  ret void
}

define void @inqueue( i32 %r163 ) {
bb53:
  %r275 = add i32 0, 0
  %r276 = add i32 %r163, 0
  br label %bb21

bb21:
  %r166 = getelementptr [1005 x i32 ], [1005 x i32 ]* @inq, i32 0, i32 %r276
  store i32 1, i32* %r166
  %r167 = load i32, i32* @tail
  %r168 = add i32 %r167, 1
  store i32 %r168, i32* @tail
  %r170 = load i32, i32* @tail
  %r171 = getelementptr [1005 x i32 ], [1005 x i32 ]* @que, i32 0, i32 %r170
  store i32 %r276, i32* %r171
  ret void
}

define i32 @popqueue( ) {
bb22:
  %r172 = load i32, i32* @h
  %r173 = add i32 %r172, 1
  store i32 %r173, i32* @h
  %r277 = add i32 0, 0
  %r175 = load i32, i32* @h
  %r176 = getelementptr [1005 x i32 ], [1005 x i32 ]* @que, i32 0, i32 %r175
  %r278 = load i32, i32* %r176
  %r178 = load i32, i32* @h
  %r179 = getelementptr [1005 x i32 ], [1005 x i32 ]* @que, i32 0, i32 %r178
  %r180 = load i32, i32* %r179
  ret i32 %r180
}

define i32 @same( i32 %r181, i32 %r183 ) {
bb54:
  %r279 = add i32 0, 0
  %r280 = add i32 0, 0
  %r281 = add i32 0, 0
  %r282 = add i32 0, 0
  %r283 = add i32 0, 0
  %r285 = add i32 %r181, 0
  %r284 = add i32 0, 0
  %r286 = add i32 %r183, 0
  br label %bb23

bb23:
  store i32 0, i32* @h
  store i32 0, i32* @tail
  call void @inqueue(i32 %r285)
  %r287 = add i32 0, 0
  %r288 = add i32 0, 0
  %r289 = add i32 0, 0
  %r290 = add i32 0, 0
  br label %bb24

bb24:
  %r291 = phi i32 [ %r287, %bb23 ], [ %r297, %bb32 ]
  %r190 = load i32, i32* @h
  %r191 = load i32, i32* @tail
  %r192 = icmp slt i32 %r190, %r191
  br i1 %r192, label %bb25, label %bb26

bb25:
  %r296 = call i32 @popqueue()
  %r196 = icmp eq i32 %r296, %r286
  br i1 %r196, label %bb27, label %bb28

bb27:
  %r302 = add i32 1, 0
  br label %bb29

bb28:
  br label %bb29

bb29:
  %r297 = phi i32 [ %r302, %bb27 ], [ %r291, %bb28 ]
  %r198 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r296
  %r298 = load i32, i32* %r198
  br label %bb30

bb30:
  %r299 = phi i32 [ %r298, %bb29 ], [ %r301, %bb35 ]
  %r201 = icmp ne i32 %r299, -1
  br i1 %r201, label %bb31, label %bb32

bb31:
  %r203 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r299
  %r300 = load i32, i32* %r203
  %r206 = getelementptr [1005 x i32 ], [1005 x i32 ]* @inq, i32 0, i32 %r300
  %r207 = load i32, i32* %r206
  %r208 = icmp eq i32 %r207, 0
  br i1 %r208, label %bb33, label %bb34

bb33:
  %r210 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r299
  %r211 = load i32, i32* %r210
  call void @inqueue(i32 %r211)
  br label %bb35

bb34:
  br label %bb35

bb35:
  %r213 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r299
  %r301 = load i32, i32* %r213
  br label %bb30

bb32:
  br label %bb24

bb26:
  %r292 = add i32 0, 0
  br label %bb36

bb36:
  %r293 = phi i32 [ %r292, %bb26 ], [ %r295, %bb37 ]
  %r216 = load i32, i32* @tail
  %r217 = icmp sle i32 %r293, %r216
  br i1 %r217, label %bb37, label %bb38

bb37:
  %r219 = getelementptr [1005 x i32 ], [1005 x i32 ]* @que, i32 0, i32 %r293
  %r294 = load i32, i32* %r219
  %r222 = getelementptr [1005 x i32 ], [1005 x i32 ]* @inq, i32 0, i32 %r294
  store i32 0, i32* %r222
  %r295 = add i32 %r293, 1
  br label %bb36

bb38:
  ret i32 %r291
}

define i32 @main( ) {
bb39:
  %r226 = call i32 @quickread()
  store i32 %r226, i32* @n
  %r227 = call i32 @quickread()
  store i32 %r227, i32* @m
  call void @_sysy_starttime(i32 97)
  call void @init()
  %r303 = add i32 0, 0
  %r306 = add i32 0, 0
  %r304 = add i32 0, 0
  %r307 = add i32 0, 0
  %r305 = add i32 0, 0
  %r308 = add i32 0, 0
  br label %bb40

bb40:
  %r231 = load i32, i32* @m
  %r232 = icmp ne i32 %r231, 0
  br i1 %r232, label %bb41, label %bb42

bb41:
  %r309 = call i32 @getch()
  br label %bb43

bb43:
  %r310 = phi i32 [ %r309, %bb41 ], [ %r315, %bb44 ]
  %r235 = icmp ne i32 %r310, 81
  br i1 %r235, label %bb46, label %bb45

bb46:
  %r237 = icmp ne i32 %r310, 85
  br i1 %r237, label %bb44, label %bb45

bb44:
  %r315 = call i32 @getch()
  br label %bb43

bb45:
  %r240 = icmp eq i32 %r310, 81
  br i1 %r240, label %bb47, label %bb48

bb47:
  %r313 = call i32 @quickread()
  %r314 = call i32 @quickread()
  %r245 = call i32 @same(i32 %r313, i32 %r314)
  call void @putint(i32 %r245)
  call void @putch(i32 10)
  br label %bb49

bb48:
  %r311 = call i32 @quickread()
  %r312 = call i32 @quickread()
  call void @addedge(i32 %r311, i32 %r312)
  br label %bb49

bb49:
  %r250 = load i32, i32* @m
  %r251 = sub i32 %r250, 1
  store i32 %r251, i32* @m
  br label %bb40

bb42:
  call void @_sysy_stoptime(i32 117)
  ret i32 0
}

