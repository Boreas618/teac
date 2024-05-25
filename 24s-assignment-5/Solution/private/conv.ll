declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@max = global i32 1073741824
@a = global [ 10000000 x i32 ] zeroinitializer
@b = global [ 10000000 x i32 ] zeroinitializer
@kernelid = global [ 10000 x i32 ] zeroinitializer
define i32 @checkrange( i32 %r100 ) {
bb94:
  %r101 = alloca i32
  store i32 %r100, i32* %r101
  br label %bb1

bb1:
  br label %bb2

bb2:
  %r102 = load i32, i32* %r101
  %r103 = load i32, i32* @max
  %r104 = icmp sgt i32 %r102, %r103
  br i1 %r104, label %bb3, label %bb4

bb3:
  %r105 = load i32, i32* %r101
  %r106 = load i32, i32* @max
  %r107 = sub i32 %r105, %r106
  store i32 %r107, i32* %r101
  br label %bb2

bb4:
  br label %bb5

bb5:
  %r108 = load i32, i32* %r101
  %r109 = icmp slt i32 %r108, 0
  br i1 %r109, label %bb6, label %bb7

bb6:
  %r110 = load i32, i32* %r101
  %r111 = load i32, i32* @max
  %r112 = add i32 %r110, %r111
  store i32 %r112, i32* %r101
  br label %bb5

bb7:
  %r113 = load i32, i32* %r101
  ret i32 %r113
}

define i32 @mod( i32 %r114, i32 %r116 ) {
bb95:
  %r115 = alloca i32
  store i32 %r114, i32* %r115
  %r117 = alloca i32
  store i32 %r116, i32* %r117
  br label %bb8

bb8:
  %r118 = load i32, i32* %r115
  %r119 = load i32, i32* %r115
  %r120 = load i32, i32* %r117
  %r121 = sdiv i32 %r119, %r120
  %r122 = load i32, i32* %r117
  %r123 = mul i32 %r121, %r122
  %r124 = sub i32 %r118, %r123
  ret i32 %r124
}

define i32 @reduce( i32 %r125, i32 %r127, i32 %r129 ) {
bb96:
  %r196 = alloca i32
  %r195 = alloca i32
  %r171 = alloca i32
  %r170 = alloca i32
  %r140 = alloca i32
  %r139 = alloca i32
  %r126 = alloca i32
  store i32 %r125, i32* %r126
  %r128 = alloca i32
  store i32 %r127, i32* %r128
  %r130 = alloca i32
  store i32 %r129, i32* %r130
  br label %bb9

bb9:
  %r131 = load i32, i32* %r126
  %r132 = icmp eq i32 %r131, 0
  br i1 %r132, label %bb10, label %bb11

bb10:
  %r133 = load i32, i32* %r128
  %r134 = load i32, i32* %r130
  %r135 = add i32 %r133, %r134
  %r136 = call i32 @checkrange(i32 %r135)
  ret i32 %r136
bb97:
  br label %bb12

bb11:
  br label %bb12

bb12:
  %r137 = load i32, i32* %r126
  %r138 = icmp eq i32 %r137, 1
  br i1 %r138, label %bb13, label %bb14

bb13:
  store i32 0, i32* %r139
  store i32 1, i32* %r140
  br label %bb16

bb16:
  %r141 = load i32, i32* %r140
  %r142 = load i32, i32* @max
  %r143 = icmp slt i32 %r141, %r142
  br i1 %r143, label %bb17, label %bb18

bb17:
  %r144 = load i32, i32* %r128
  %r145 = load i32, i32* %r140
  %r146 = sdiv i32 %r144, %r145
  %r147 = call i32 @mod(i32 %r146, i32 2)
  %r148 = load i32, i32* %r130
  %r149 = load i32, i32* %r140
  %r150 = sdiv i32 %r148, %r149
  %r151 = call i32 @mod(i32 %r150, i32 2)
  %r152 = icmp eq i32 %r147, %r151
  br i1 %r152, label %bb19, label %bb20

bb19:
  %r153 = load i32, i32* %r139
  %r154 = mul i32 %r153, 2
  store i32 %r154, i32* %r139
  br label %bb21

bb20:
  %r155 = load i32, i32* %r139
  %r156 = mul i32 %r155, 2
  %r157 = add i32 %r156, 1
  store i32 %r157, i32* %r139
  br label %bb21

bb21:
  %r158 = load i32, i32* %r140
  %r159 = mul i32 %r158, 2
  store i32 %r159, i32* %r140
  br label %bb16

bb18:
  %r160 = load i32, i32* %r139
  ret i32 %r160
bb98:
  br label %bb15

bb14:
  br label %bb15

bb15:
  %r161 = load i32, i32* %r126
  %r162 = icmp eq i32 %r161, 2
  br i1 %r162, label %bb22, label %bb23

bb22:
  %r163 = load i32, i32* %r128
  %r164 = load i32, i32* %r130
  %r165 = icmp sgt i32 %r163, %r164
  br i1 %r165, label %bb25, label %bb26

bb25:
  %r166 = load i32, i32* %r128
  ret i32 %r166
bb99:
  br label %bb27

bb26:
  %r167 = load i32, i32* %r130
  ret i32 %r167
bb100:
  br label %bb27

bb27:
  br label %bb24

bb23:
  br label %bb24

bb24:
  %r168 = load i32, i32* %r126
  %r169 = icmp eq i32 %r168, 3
  br i1 %r169, label %bb28, label %bb29

bb28:
  store i32 0, i32* %r170
  store i32 1, i32* %r171
  br label %bb31

bb31:
  %r172 = load i32, i32* %r171
  %r173 = load i32, i32* @max
  %r174 = icmp slt i32 %r172, %r173
  br i1 %r174, label %bb32, label %bb33

bb32:
  %r175 = load i32, i32* %r128
  %r176 = load i32, i32* %r171
  %r177 = sdiv i32 %r175, %r176
  %r178 = call i32 @mod(i32 %r177, i32 2)
  %r179 = icmp eq i32 %r178, 1
  br i1 %r179, label %bb34, label %bb37

bb37:
  %r180 = load i32, i32* %r130
  %r181 = load i32, i32* %r171
  %r182 = sdiv i32 %r180, %r181
  %r183 = call i32 @mod(i32 %r182, i32 2)
  %r184 = icmp eq i32 %r183, 1
  br i1 %r184, label %bb34, label %bb35

bb34:
  %r185 = load i32, i32* %r170
  %r186 = mul i32 %r185, 2
  %r187 = add i32 %r186, 1
  store i32 %r187, i32* %r170
  br label %bb36

bb35:
  %r188 = load i32, i32* %r170
  %r189 = mul i32 %r188, 2
  store i32 %r189, i32* %r170
  br label %bb36

bb36:
  %r190 = load i32, i32* %r171
  %r191 = mul i32 %r190, 2
  store i32 %r191, i32* %r171
  br label %bb31

bb33:
  %r192 = load i32, i32* %r170
  ret i32 %r192
bb101:
  br label %bb30

bb29:
  br label %bb30

bb30:
  %r193 = load i32, i32* %r126
  %r194 = icmp eq i32 %r193, 4
  br i1 %r194, label %bb38, label %bb39

bb38:
  store i32 0, i32* %r195
  store i32 1, i32* %r196
  br label %bb41

bb41:
  %r197 = load i32, i32* %r196
  %r198 = load i32, i32* @max
  %r199 = icmp slt i32 %r197, %r198
  br i1 %r199, label %bb42, label %bb43

bb42:
  %r200 = load i32, i32* %r128
  %r201 = load i32, i32* %r196
  %r202 = sdiv i32 %r200, %r201
  %r203 = call i32 @mod(i32 %r202, i32 2)
  %r204 = icmp eq i32 %r203, 1
  br i1 %r204, label %bb47, label %bb45

bb47:
  %r205 = load i32, i32* %r130
  %r206 = load i32, i32* %r196
  %r207 = sdiv i32 %r205, %r206
  %r208 = call i32 @mod(i32 %r207, i32 2)
  %r209 = icmp eq i32 %r208, 1
  br i1 %r209, label %bb44, label %bb45

bb44:
  %r210 = load i32, i32* %r195
  %r211 = mul i32 %r210, 2
  %r212 = add i32 %r211, 1
  store i32 %r212, i32* %r195
  br label %bb46

bb45:
  %r213 = load i32, i32* %r195
  %r214 = mul i32 %r213, 2
  store i32 %r214, i32* %r195
  br label %bb46

bb46:
  %r215 = load i32, i32* %r196
  %r216 = mul i32 %r215, 2
  store i32 %r216, i32* %r196
  br label %bb41

bb43:
  %r217 = load i32, i32* %r195
  ret i32 %r217
bb102:
  br label %bb40

bb39:
  br label %bb40

bb40:
  ret i32 0
}

define i32 @getvalue( i32* %r218, i32 %r219, i32 %r221, i32 %r223, i32 %r225 ) {
bb103:
  %r237 = alloca i32
  %r220 = alloca i32
  store i32 %r219, i32* %r220
  %r222 = alloca i32
  store i32 %r221, i32* %r222
  %r224 = alloca i32
  store i32 %r223, i32* %r224
  %r226 = alloca i32
  store i32 %r225, i32* %r226
  br label %bb48

bb48:
  %r227 = load i32, i32* %r224
  %r228 = icmp slt i32 %r227, 0
  br i1 %r228, label %bb49, label %bb54

bb54:
  %r229 = load i32, i32* %r226
  %r230 = icmp slt i32 %r229, 0
  br i1 %r230, label %bb49, label %bb53

bb53:
  %r231 = load i32, i32* %r224
  %r232 = load i32, i32* %r220
  %r233 = icmp sge i32 %r231, %r232
  br i1 %r233, label %bb49, label %bb52

bb52:
  %r234 = load i32, i32* %r226
  %r235 = load i32, i32* %r222
  %r236 = icmp sge i32 %r234, %r235
  br i1 %r236, label %bb49, label %bb50

bb49:
  ret i32 0
bb104:
  br label %bb51

bb50:
  br label %bb51

bb51:
  %r238 = load i32, i32* %r224
  %r239 = load i32, i32* %r222
  %r240 = mul i32 %r238, %r239
  %r241 = load i32, i32* %r226
  %r242 = add i32 %r240, %r241
  store i32 %r242, i32* %r237
  %r243 = load i32, i32* %r237
  %r244 = getelementptr i32, i32* %r218, i32 %r243
  %r245 = load i32, i32* %r244
  ret i32 %r245
}

define i32 @convn( i32 %r246, i32* %r248, i32* %r249, i32 %r250, i32 %r252, i32 %r254 ) {
bb105:
  %r306 = alloca i32
  %r261 = alloca i32
  %r260 = alloca i32
  %r259 = alloca i32
  %r258 = alloca i32
  %r257 = alloca i32
  %r256 = alloca i32
  %r247 = alloca i32
  store i32 %r246, i32* %r247
  %r251 = alloca i32
  store i32 %r250, i32* %r251
  %r253 = alloca i32
  store i32 %r252, i32* %r253
  %r255 = alloca i32
  store i32 %r254, i32* %r255
  br label %bb55

bb55:
  store i32 0, i32* %r256
  store i32 0, i32* %r257
  store i32 1, i32* %r261
  br label %bb56

bb56:
  %r262 = load i32, i32* %r261
  %r263 = load i32, i32* %r261
  %r264 = icmp eq i32 %r262, %r263
  br i1 %r264, label %bb57, label %bb58

bb57:
  store i32 0, i32* %r257
  br label %bb59

bb59:
  %r265 = load i32, i32* %r261
  %r266 = load i32, i32* %r261
  %r267 = icmp eq i32 %r265, %r266
  br i1 %r267, label %bb60, label %bb61

bb60:
  store i32 0, i32* %r260
  %r268 = load i32, i32* %r256
  %r269 = load i32, i32* %r255
  %r270 = sdiv i32 %r269, 2
  %r271 = sub i32 %r268, %r270
  store i32 %r271, i32* %r258
  br label %bb62

bb62:
  %r272 = load i32, i32* %r261
  %r273 = load i32, i32* %r261
  %r274 = icmp eq i32 %r272, %r273
  br i1 %r274, label %bb63, label %bb64

bb63:
  %r275 = load i32, i32* %r257
  %r276 = load i32, i32* %r255
  %r277 = sdiv i32 %r276, 2
  %r278 = sub i32 %r275, %r277
  store i32 %r278, i32* %r259
  br label %bb65

bb65:
  %r279 = load i32, i32* %r261
  %r280 = load i32, i32* %r261
  %r281 = icmp eq i32 %r279, %r280
  br i1 %r281, label %bb66, label %bb67

bb66:
  %r282 = load i32, i32* %r247
  %r283 = load i32, i32* %r260
  %r284 = load i32, i32* %r251
  %r285 = load i32, i32* %r253
  %r286 = load i32, i32* %r258
  %r287 = load i32, i32* %r259
  %r288 = call i32 @getvalue(i32* %r248, i32 %r284, i32 %r285, i32 %r286, i32 %r287)
  %r289 = call i32 @reduce(i32 %r282, i32 %r283, i32 %r288)
  store i32 %r289, i32* %r260
  %r290 = load i32, i32* %r259
  %r291 = add i32 %r290, 1
  store i32 %r291, i32* %r259
  %r292 = load i32, i32* %r259
  %r293 = load i32, i32* %r257
  %r294 = load i32, i32* %r255
  %r295 = sdiv i32 %r294, 2
  %r296 = add i32 %r293, %r295
  %r297 = icmp sge i32 %r292, %r296
  br i1 %r297, label %bb68, label %bb69

bb68:
  br label %bb67

bb106:
  br label %bb70

bb69:
  br label %bb70

bb70:
  br label %bb65

bb67:
  %r298 = load i32, i32* %r258
  %r299 = add i32 %r298, 1
  store i32 %r299, i32* %r258
  %r300 = load i32, i32* %r258
  %r301 = load i32, i32* %r256
  %r302 = load i32, i32* %r255
  %r303 = sdiv i32 %r302, 2
  %r304 = add i32 %r301, %r303
  %r305 = icmp sge i32 %r300, %r304
  br i1 %r305, label %bb71, label %bb72

bb71:
  br label %bb64

bb107:
  br label %bb73

bb72:
  br label %bb73

bb73:
  br label %bb62

bb64:
  %r307 = load i32, i32* %r256
  %r308 = load i32, i32* %r253
  %r309 = mul i32 %r307, %r308
  %r310 = load i32, i32* %r257
  %r311 = add i32 %r309, %r310
  store i32 %r311, i32* %r306
  %r312 = load i32, i32* %r260
  %r313 = load i32, i32* %r306
  %r314 = getelementptr i32, i32* %r249, i32 %r313
  store i32 %r312, i32* %r314
  %r315 = load i32, i32* %r257
  %r316 = add i32 %r315, 1
  store i32 %r316, i32* %r257
  %r317 = load i32, i32* %r257
  %r318 = load i32, i32* %r253
  %r319 = icmp sge i32 %r317, %r318
  br i1 %r319, label %bb74, label %bb75

bb74:
  br label %bb61

bb108:
  br label %bb76

bb75:
  br label %bb76

bb76:
  br label %bb59

bb61:
  %r320 = load i32, i32* %r256
  %r321 = add i32 %r320, 1
  store i32 %r321, i32* %r256
  %r322 = load i32, i32* %r256
  %r323 = load i32, i32* %r251
  %r324 = icmp sge i32 %r322, %r323
  br i1 %r324, label %bb77, label %bb78

bb77:
  br label %bb58

bb109:
  br label %bb79

bb78:
  br label %bb79

bb79:
  br label %bb56

bb58:
  ret i32 0
}

define void @memmove( i32* %r325, i32* %r326, i32 %r327 ) {
bb110:
  %r329 = alloca i32
  %r328 = alloca i32
  store i32 %r327, i32* %r328
  br label %bb80

bb80:
  store i32 0, i32* %r329
  br label %bb81

bb81:
  %r330 = load i32, i32* %r329
  %r331 = load i32, i32* %r328
  %r332 = icmp slt i32 %r330, %r331
  br i1 %r332, label %bb82, label %bb83

bb82:
  %r333 = load i32, i32* %r329
  %r334 = getelementptr i32, i32* %r326, i32 %r333
  %r335 = load i32, i32* %r334
  %r336 = load i32, i32* %r329
  %r337 = getelementptr i32, i32* %r325, i32 %r336
  store i32 %r335, i32* %r337
  %r338 = load i32, i32* %r329
  %r339 = add i32 %r338, 1
  store i32 %r339, i32* %r329
  br label %bb81

bb83:
  ret void
}

define i32 @main( ) {
bb84:
  %r368 = alloca i32
  %r366 = alloca i32
  %r340 = alloca i32
  %r341 = call i32 @getint()
  store i32 %r341, i32* %r340
  %r342 = alloca i32
  %r343 = call i32 @getint()
  store i32 %r343, i32* %r342
  %r344 = alloca i32
  %r345 = call i32 @getint()
  store i32 %r345, i32* %r344
  %r346 = alloca i32
  %r347 = call i32 @getint()
  store i32 %r347, i32* %r346
  %r348 = alloca i32
  store i32 0, i32* %r348
  br label %bb85

bb85:
  %r349 = load i32, i32* %r348
  %r350 = load i32, i32* %r346
  %r351 = icmp slt i32 %r349, %r350
  br i1 %r351, label %bb86, label %bb87

bb86:
  %r352 = call i32 @getint()
  %r353 = load i32, i32* %r348
  %r354 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @a, i32 0, i32 %r353
  store i32 %r352, i32* %r354
  %r355 = load i32, i32* %r348
  %r356 = add i32 %r355, 1
  store i32 %r356, i32* %r348
  br label %bb85

bb87:
  %r357 = call i32 @getint()
  store i32 %r357, i32* %r346
  store i32 0, i32* %r348
  br label %bb88

bb88:
  %r358 = load i32, i32* %r348
  %r359 = load i32, i32* %r346
  %r360 = icmp slt i32 %r358, %r359
  br i1 %r360, label %bb89, label %bb90

bb89:
  %r361 = call i32 @getint()
  %r362 = load i32, i32* %r348
  %r363 = getelementptr [10000 x i32 ], [10000 x i32 ]* @kernelid, i32 0, i32 %r362
  store i32 %r361, i32* %r363
  %r364 = load i32, i32* %r348
  %r365 = add i32 %r364, 1
  store i32 %r365, i32* %r348
  br label %bb88

bb90:
  %r367 = load i32, i32* %r346
  store i32 %r367, i32* %r366
  call void @_sysy_starttime(i32 209)
  store i32 0, i32* %r368
  br label %bb91

bb91:
  %r369 = load i32, i32* %r368
  %r370 = load i32, i32* %r366
  %r371 = icmp slt i32 %r369, %r370
  br i1 %r371, label %bb92, label %bb93

bb92:
  %r372 = load i32, i32* %r368
  %r373 = getelementptr [10000 x i32 ], [10000 x i32 ]* @kernelid, i32 0, i32 %r372
  %r374 = load i32, i32* %r373
  %r375 = load i32, i32* %r342
  %r376 = load i32, i32* %r344
  %r377 = load i32, i32* %r340
  call void @convn(i32 %r374, i32* @a, i32* @b, i32 %r375, i32 %r376, i32 %r377)
  %r378 = load i32, i32* %r342
  %r379 = load i32, i32* %r344
  %r380 = mul i32 %r378, %r379
  call void @memmove(i32* @a, i32* @b, i32 %r380)
  %r381 = load i32, i32* %r368
  %r382 = add i32 %r381, 1
  store i32 %r382, i32* %r368
  br label %bb91

bb93:
  call void @_sysy_stoptime(i32 312)
  %r383 = load i32, i32* %r342
  %r384 = load i32, i32* %r344
  %r385 = mul i32 %r383, %r384
  call void @putarray(i32 %r385, i32* @a)
  ret i32 0
}

