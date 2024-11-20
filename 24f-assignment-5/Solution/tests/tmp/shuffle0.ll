declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@hashmod = global i32 0
@bucket = global [ 10000000 x i32 ] zeroinitializer
@head = global [ 10000000 x i32 ] zeroinitializer
@next = global [ 10000000 x i32 ] zeroinitializer
@nextvalue = global [ 10000000 x i32 ] zeroinitializer
@key = global [ 10000000 x i32 ] zeroinitializer
@value = global [ 10000000 x i32 ] zeroinitializer
@cnt = global i32 0
@keys = global [ 10000000 x i32 ] zeroinitializer
@values = global [ 10000000 x i32 ] zeroinitializer
@requests = global [ 10000000 x i32 ] zeroinitializer
@ans = global [ 10000000 x i32 ] zeroinitializer
define i32 @hash( i32 %r100 ) {
bb38:
  %r269 = add i32 0, 0
  %r270 = add i32 %r100, 0
  br label %bb1

bb1:
  %r104 = load i32, i32* @hashmod
  %r105 = sdiv i32 %r270, %r104
  %r106 = load i32, i32* @hashmod
  %r107 = mul i32 %r105, %r106
  %r108 = sub i32 %r270, %r107
  ret i32 %r108
}

define i32 @insert( i32 %r109, i32 %r111 ) {
bb39:
  %r271 = add i32 0, 0
  %r272 = add i32 0, 0
  %r273 = add i32 0, 0
  %r275 = add i32 %r109, 0
  %r274 = add i32 0, 0
  %r276 = add i32 %r111, 0
  br label %bb2

bb2:
  %r277 = call i32 @hash(i32 %r275)
  %r117 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
  %r118 = load i32, i32* %r117
  %r119 = icmp eq i32 %r118, 0
  br i1 %r119, label %bb3, label %bb4

bb3:
  %r120 = load i32, i32* @cnt
  %r121 = add i32 %r120, 1
  store i32 %r121, i32* @cnt
  %r122 = load i32, i32* @cnt
  %r124 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
  store i32 %r122, i32* %r124
  %r126 = load i32, i32* @cnt
  %r127 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @key, i32 0, i32 %r126
  store i32 %r275, i32* %r127
  %r129 = load i32, i32* @cnt
  %r130 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @value, i32 0, i32 %r129
  store i32 %r276, i32* %r130
  %r131 = load i32, i32* @cnt
  %r132 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @next, i32 0, i32 %r131
  store i32 0, i32* %r132
  %r133 = load i32, i32* @cnt
  %r134 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r133
  store i32 0, i32* %r134
  ret i32 0
bb4:
  br label %bb5

bb5:
  %r137 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
  %r278 = load i32, i32* %r137
  br label %bb6

bb6:
  %r279 = phi i32 [ %r278, %bb5 ], [ %r280, %bb11 ]
  %r140 = icmp ne i32 %r279, 0
  br i1 %r140, label %bb7, label %bb8

bb7:
  %r142 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @key, i32 0, i32 %r279
  %r143 = load i32, i32* %r142
  %r145 = icmp eq i32 %r143, %r275
  br i1 %r145, label %bb9, label %bb10

bb9:
  %r146 = load i32, i32* @cnt
  %r147 = add i32 %r146, 1
  store i32 %r147, i32* @cnt
  %r149 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r279
  %r150 = load i32, i32* %r149
  %r151 = load i32, i32* @cnt
  %r152 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r151
  store i32 %r150, i32* %r152
  %r153 = load i32, i32* @cnt
  %r155 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r279
  store i32 %r153, i32* %r155
  %r157 = load i32, i32* @cnt
  %r158 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @value, i32 0, i32 %r157
  store i32 %r276, i32* %r158
  ret i32 1
bb10:
  br label %bb11

bb11:
  %r160 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @next, i32 0, i32 %r279
  %r280 = load i32, i32* %r160
  br label %bb6

bb8:
  %r162 = load i32, i32* @cnt
  %r163 = add i32 %r162, 1
  store i32 %r163, i32* @cnt
  %r165 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
  %r166 = load i32, i32* %r165
  %r167 = load i32, i32* @cnt
  %r168 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @next, i32 0, i32 %r167
  store i32 %r166, i32* %r168
  %r169 = load i32, i32* @cnt
  %r171 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r277
  store i32 %r169, i32* %r171
  %r173 = load i32, i32* @cnt
  %r174 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @key, i32 0, i32 %r173
  store i32 %r275, i32* %r174
  %r176 = load i32, i32* @cnt
  %r177 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @value, i32 0, i32 %r176
  store i32 %r276, i32* %r177
  %r178 = load i32, i32* @cnt
  %r179 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r178
  store i32 0, i32* %r179
  ret i32 0
}

define i32 @reduce( i32 %r180 ) {
bb42:
  %r281 = add i32 0, 0
  %r282 = add i32 0, 0
  %r283 = add i32 0, 0
  %r284 = add i32 0, 0
  %r285 = add i32 0, 0
  %r286 = add i32 %r180, 0
  br label %bb12

bb12:
  %r287 = call i32 @hash(i32 %r286)
  %r187 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @head, i32 0, i32 %r287
  %r288 = load i32, i32* %r187
  br label %bb13

bb13:
  %r289 = phi i32 [ %r288, %bb12 ], [ %r290, %bb18 ]
  %r190 = icmp ne i32 %r289, 0
  br i1 %r190, label %bb14, label %bb15

bb14:
  %r192 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @key, i32 0, i32 %r289
  %r193 = load i32, i32* %r192
  %r195 = icmp eq i32 %r193, %r286
  br i1 %r195, label %bb16, label %bb17

bb16:
  %r291 = add i32 0, 0
  %r292 = add i32 %r289, 0
  br label %bb19

bb19:
  %r293 = phi i32 [ %r291, %bb16 ], [ %r295, %bb20 ]
  %r294 = phi i32 [ %r292, %bb16 ], [ %r296, %bb20 ]
  %r200 = icmp ne i32 %r294, 0
  br i1 %r200, label %bb20, label %bb21

bb20:
  %r203 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @value, i32 0, i32 %r294
  %r204 = load i32, i32* %r203
  %r295 = add i32 %r293, %r204
  %r207 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @nextvalue, i32 0, i32 %r294
  %r296 = load i32, i32* %r207
  br label %bb19

bb21:
  ret i32 %r293
bb17:
  br label %bb18

bb18:
  %r211 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @next, i32 0, i32 %r289
  %r290 = load i32, i32* %r211
  br label %bb13

bb15:
  ret i32 0
}

define i32 @main( ) {
bb22:
  %r297 = add i32 0, 0
  %r298 = add i32 0, 0
  %r299 = add i32 0, 0
  %r213 = call i32 @getint()
  store i32 %r213, i32* @hashmod
  %r300 = add i32 0, 0
  %r302 = call i32 @getint()
  %r301 = add i32 0, 0
  %r303 = add i32 0, 0
  br label %bb23

bb23:
  %r304 = phi i32 [ %r303, %bb22 ], [ %r319, %bb24 ]
  %r219 = icmp slt i32 %r304, %r302
  br i1 %r219, label %bb24, label %bb25

bb24:
  %r220 = call i32 @getint()
  %r222 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @keys, i32 0, i32 %r304
  store i32 %r220, i32* %r222
  %r319 = add i32 %r304, 1
  br label %bb23

bb25:
  %r305 = call i32 @getint()
  %r306 = add i32 0, 0
  br label %bb26

bb26:
  %r307 = phi i32 [ %r306, %bb25 ], [ %r318, %bb27 ]
  %r229 = icmp slt i32 %r307, %r305
  br i1 %r229, label %bb27, label %bb28

bb27:
  %r230 = call i32 @getint()
  %r232 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @values, i32 0, i32 %r307
  store i32 %r230, i32* %r232
  %r318 = add i32 %r307, 1
  br label %bb26

bb28:
  %r308 = call i32 @getint()
  %r309 = add i32 0, 0
  br label %bb29

bb29:
  %r310 = phi i32 [ %r309, %bb28 ], [ %r317, %bb30 ]
  %r239 = icmp slt i32 %r310, %r308
  br i1 %r239, label %bb30, label %bb31

bb30:
  %r240 = call i32 @getint()
  %r242 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @requests, i32 0, i32 %r310
  store i32 %r240, i32* %r242
  %r317 = add i32 %r310, 1
  br label %bb29

bb31:
  call void @_sysy_starttime(i32 209)
  %r311 = add i32 0, 0
  br label %bb32

bb32:
  %r312 = phi i32 [ %r311, %bb31 ], [ %r316, %bb33 ]
  %r248 = icmp slt i32 %r312, %r302
  br i1 %r248, label %bb33, label %bb34

bb33:
  %r250 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @keys, i32 0, i32 %r312
  %r251 = load i32, i32* %r250
  %r253 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @values, i32 0, i32 %r312
  %r254 = load i32, i32* %r253
  call void @insert(i32 %r251, i32 %r254)
  %r316 = add i32 %r312, 1
  br label %bb32

bb34:
  %r313 = add i32 0, 0
  br label %bb35

bb35:
  %r314 = phi i32 [ %r313, %bb34 ], [ %r315, %bb36 ]
  %r259 = icmp slt i32 %r314, %r308
  br i1 %r259, label %bb36, label %bb37

bb36:
  %r261 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @requests, i32 0, i32 %r314
  %r262 = load i32, i32* %r261
  %r263 = call i32 @reduce(i32 %r262)
  %r265 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @ans, i32 0, i32 %r314
  store i32 %r263, i32* %r265
  %r315 = add i32 %r314, 1
  br label %bb35

bb37:
  call void @_sysy_stoptime(i32 312)
  call void @putarray(i32 %r308, i32* @ans)
  ret i32 0
}

