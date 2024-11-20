declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@TOKEN_NUM = global i32 0
@TOKEN_OTHER = global i32 1
@last_char = global i32 32
@num = global i32 0
@other = global i32 0
@cur_token = global i32 0
define i32 @next_char( ) {
bb1:
  %r100 = call i32 @getch()
  store i32 %r100, i32* @last_char
  %r101 = load i32, i32* @last_char
  ret i32 %r101
}

define i32 @is_space( i32 %r102 ) {
bb81:
  %r291 = add i32 0, 0
  %r292 = add i32 %r102, 0
  br label %bb2

bb2:
  %r105 = icmp eq i32 %r292, 32
  br i1 %r105, label %bb3, label %bb6

bb6:
  %r107 = icmp eq i32 %r292, 10
  br i1 %r107, label %bb3, label %bb4

bb3:
  ret i32 1
bb4:
  ret i32 0
}

define i32 @is_num( i32 %r108 ) {
bb84:
  %r293 = add i32 0, 0
  %r294 = add i32 %r108, 0
  br label %bb7

bb7:
  %r111 = icmp sge i32 %r294, 48
  br i1 %r111, label %bb11, label %bb9

bb11:
  %r113 = icmp sle i32 %r294, 57
  br i1 %r113, label %bb8, label %bb9

bb8:
  ret i32 1
bb9:
  ret i32 0
}

define i32 @next_token( ) {
bb12:
  br label %bb13

bb13:
  %r114 = load i32, i32* @last_char
  %r115 = call i32 @is_space(i32 %r114)
  %r116 = icmp ne i32 %r115, 0
  br i1 %r116, label %bb14, label %bb15

bb14:
  call void @next_char()
  br label %bb13

bb15:
  %r117 = load i32, i32* @last_char
  %r118 = call i32 @is_num(i32 %r117)
  %r119 = icmp ne i32 %r118, 0
  br i1 %r119, label %bb16, label %bb17

bb16:
  %r120 = load i32, i32* @last_char
  %r121 = sub i32 %r120, 48
  store i32 %r121, i32* @num
  br label %bb19

bb19:
  %r122 = call i32 @next_char()
  %r123 = call i32 @is_num(i32 %r122)
  %r124 = icmp ne i32 %r123, 0
  br i1 %r124, label %bb20, label %bb21

bb20:
  %r125 = load i32, i32* @num
  %r126 = mul i32 %r125, 10
  %r127 = load i32, i32* @last_char
  %r128 = add i32 %r126, %r127
  %r129 = sub i32 %r128, 48
  store i32 %r129, i32* @num
  br label %bb19

bb21:
  %r130 = load i32, i32* @TOKEN_NUM
  store i32 %r130, i32* @cur_token
  br label %bb18

bb17:
  %r131 = load i32, i32* @last_char
  store i32 %r131, i32* @other
  call void @next_char()
  %r132 = load i32, i32* @TOKEN_OTHER
  store i32 %r132, i32* @cur_token
  br label %bb18

bb18:
  %r133 = load i32, i32* @cur_token
  ret i32 %r133
}

define i32 @panic( ) {
bb22:
  call void @putch(i32 112)
  call void @putch(i32 97)
  call void @putch(i32 110)
  call void @putch(i32 105)
  call void @putch(i32 99)
  call void @putch(i32 33)
  call void @putch(i32 10)
  ret i32 -1
}

define i32 @get_op_prec( i32 %r134 ) {
bb87:
  %r295 = add i32 0, 0
  %r296 = add i32 %r134, 0
  br label %bb23

bb23:
  %r137 = icmp eq i32 %r296, 43
  br i1 %r137, label %bb24, label %bb27

bb27:
  %r139 = icmp eq i32 %r296, 45
  br i1 %r139, label %bb24, label %bb25

bb24:
  ret i32 10
bb25:
  br label %bb26

bb26:
  %r141 = icmp eq i32 %r296, 42
  br i1 %r141, label %bb28, label %bb32

bb32:
  %r143 = icmp eq i32 %r296, 47
  br i1 %r143, label %bb28, label %bb31

bb31:
  %r145 = icmp eq i32 %r296, 37
  br i1 %r145, label %bb28, label %bb29

bb28:
  ret i32 20
bb29:
  br label %bb30

bb30:
  ret i32 0
}

define void @stack_push( i32* %r146, i32 %r147 ) {
bb90:
  %r297 = add i32 0, 0
  %r298 = add i32 0, 0
  %r299 = add i32 %r147, 0
  br label %bb33

bb33:
  %r149 = getelementptr i32, i32* %r146, i32 0
  %r150 = load i32, i32* %r149
  %r151 = add i32 %r150, 1
  %r152 = getelementptr i32, i32* %r146, i32 0
  store i32 %r151, i32* %r152
  %r154 = getelementptr i32, i32* %r146, i32 0
  %r300 = load i32, i32* %r154
  %r158 = getelementptr i32, i32* %r146, i32 %r300
  store i32 %r299, i32* %r158
  ret void
}

define i32 @stack_pop( i32* %r159 ) {
bb34:
  %r301 = add i32 0, 0
  %r161 = getelementptr i32, i32* %r159, i32 0
  %r303 = load i32, i32* %r161
  %r302 = add i32 0, 0
  %r165 = getelementptr i32, i32* %r159, i32 %r303
  %r304 = load i32, i32* %r165
  %r167 = getelementptr i32, i32* %r159, i32 0
  %r168 = load i32, i32* %r167
  %r169 = sub i32 %r168, 1
  %r170 = getelementptr i32, i32* %r159, i32 0
  store i32 %r169, i32* %r170
  ret i32 %r304
}

define i32 @stack_peek( i32* %r172 ) {
bb35:
  %r305 = add i32 0, 0
  %r174 = getelementptr i32, i32* %r172, i32 0
  %r306 = load i32, i32* %r174
  %r177 = getelementptr i32, i32* %r172, i32 %r306
  %r178 = load i32, i32* %r177
  ret i32 %r178
}

define i32 @stack_size( i32* %r179 ) {
bb36:
  %r180 = getelementptr i32, i32* %r179, i32 0
  %r181 = load i32, i32* %r180
  ret i32 %r181
}

define i32 @mod( i32 %r182, i32 %r184 ) {
bb91:
  %r307 = add i32 0, 0
  %r309 = add i32 %r182, 0
  %r308 = add i32 0, 0
  %r310 = add i32 %r184, 0
  br label %bb37

bb37:
  %r189 = sdiv i32 %r309, %r310
  %r191 = mul i32 %r189, %r310
  %r192 = sub i32 %r309, %r191
  ret i32 %r192
}

define i32 @eval_op( i32 %r193, i32 %r195, i32 %r197 ) {
bb92:
  %r311 = add i32 0, 0
  %r314 = add i32 %r193, 0
  %r312 = add i32 0, 0
  %r315 = add i32 %r195, 0
  %r313 = add i32 0, 0
  %r316 = add i32 %r197, 0
  br label %bb38

bb38:
  %r200 = icmp eq i32 %r314, 43
  br i1 %r200, label %bb39, label %bb40

bb39:
  %r203 = add i32 %r315, %r316
  ret i32 %r203
bb40:
  br label %bb41

bb41:
  %r205 = icmp eq i32 %r314, 45
  br i1 %r205, label %bb42, label %bb43

bb42:
  %r208 = sub i32 %r315, %r316
  ret i32 %r208
bb43:
  br label %bb44

bb44:
  %r210 = icmp eq i32 %r314, 42
  br i1 %r210, label %bb45, label %bb46

bb45:
  %r213 = mul i32 %r315, %r316
  ret i32 %r213
bb46:
  br label %bb47

bb47:
  %r215 = icmp eq i32 %r314, 47
  br i1 %r215, label %bb48, label %bb49

bb48:
  %r218 = sdiv i32 %r315, %r316
  ret i32 %r218
bb49:
  br label %bb50

bb50:
  %r220 = icmp eq i32 %r314, 37
  br i1 %r220, label %bb51, label %bb52

bb51:
  %r223 = call i32 @mod(i32 %r315, i32 %r316)
  ret i32 %r223
bb52:
  br label %bb53

bb53:
  ret i32 0
}

define i32 @eval( ) {
bb54:
  %r317 = add i32 0, 0
  %r318 = add i32 0, 0
  %r319 = add i32 0, 0
  %r320 = add i32 0, 0
  %r321 = add i32 0, 0
  %r322 = add i32 0, 0
  %r323 = add i32 0, 0
  %r224 = alloca [ 256 x i32 ]
  %r225 = alloca [ 256 x i32 ]
  %r324 = add i32 0, 0
  %r325 = add i32 0, 0
  br label %bb55

bb55:
  %r326 = phi i32 [ %r325, %bb54 ], [ %r334, %bb56 ]
  %r228 = icmp slt i32 %r326, 256
  br i1 %r228, label %bb56, label %bb57

bb56:
  %r230 = getelementptr [256 x i32 ], [256 x i32 ]* %r224, i32 0, i32 %r326
  store i32 0, i32* %r230
  %r232 = getelementptr [256 x i32 ], [256 x i32 ]* %r225, i32 0, i32 %r326
  store i32 0, i32* %r232
  %r334 = add i32 %r326, 1
  br label %bb55

bb57:
  %r235 = load i32, i32* @cur_token
  %r236 = load i32, i32* @TOKEN_NUM
  %r237 = icmp ne i32 %r235, %r236
  br i1 %r237, label %bb58, label %bb59

bb58:
  %r238 = call i32 @panic()
  ret i32 %r238
bb59:
  br label %bb60

bb60:
  %r239 = load i32, i32* @num
  call void @stack_push(i32* %r224, i32 %r239)
  call void @next_token()
  br label %bb61

bb61:
  %r240 = load i32, i32* @cur_token
  %r241 = load i32, i32* @TOKEN_OTHER
  %r242 = icmp eq i32 %r240, %r241
  br i1 %r242, label %bb62, label %bb63

bb62:
  %r330 = load i32, i32* @other
  %r246 = call i32 @get_op_prec(i32 %r330)
  %r247 = icmp eq i32 %r246, 0
  br i1 %r247, label %bb64, label %bb65

bb64:
  br label %bb63

bb65:
  br label %bb66

bb66:
  call void @next_token()
  br label %bb67

bb67:
  %r248 = call i32 @stack_size(i32* %r225)
  %r249 = icmp ne i32 %r248, 0
  br i1 %r249, label %bb70, label %bb69

bb70:
  %r250 = call i32 @stack_peek(i32* %r225)
  %r251 = call i32 @get_op_prec(i32 %r250)
  %r253 = call i32 @get_op_prec(i32 %r330)
  %r254 = icmp sge i32 %r251, %r253
  br i1 %r254, label %bb68, label %bb69

bb68:
  %r331 = call i32 @stack_pop(i32* %r225)
  %r332 = call i32 @stack_pop(i32* %r224)
  %r333 = call i32 @stack_pop(i32* %r224)
  %r264 = call i32 @eval_op(i32 %r331, i32 %r333, i32 %r332)
  call void @stack_push(i32* %r224, i32 %r264)
  br label %bb67

bb69:
  call void @stack_push(i32* %r225, i32 %r330)
  %r266 = load i32, i32* @cur_token
  %r267 = load i32, i32* @TOKEN_NUM
  %r268 = icmp ne i32 %r266, %r267
  br i1 %r268, label %bb71, label %bb72

bb71:
  %r269 = call i32 @panic()
  ret i32 %r269
bb72:
  br label %bb73

bb73:
  %r270 = load i32, i32* @num
  call void @stack_push(i32* %r224, i32 %r270)
  call void @next_token()
  br label %bb61

bb63:
  call void @next_token()
  br label %bb74

bb74:
  %r271 = call i32 @stack_size(i32* %r225)
  %r272 = icmp ne i32 %r271, 0
  br i1 %r272, label %bb75, label %bb76

bb75:
  %r327 = call i32 @stack_pop(i32* %r225)
  %r328 = call i32 @stack_pop(i32* %r224)
  %r329 = call i32 @stack_pop(i32* %r224)
  %r282 = call i32 @eval_op(i32 %r327, i32 %r329, i32 %r328)
  call void @stack_push(i32* %r224, i32 %r282)
  br label %bb74

bb76:
  %r283 = call i32 @stack_peek(i32* %r224)
  ret i32 %r283
}

define i32 @main( ) {
bb77:
  call void @_sysy_starttime(i32 205)
  %r335 = add i32 0, 0
  %r336 = call i32 @getint()
  call void @getch()
  call void @next_token()
  br label %bb78

bb78:
  %r337 = phi i32 [ %r336, %bb77 ], [ %r338, %bb79 ]
  %r287 = icmp ne i32 %r337, 0
  br i1 %r287, label %bb79, label %bb80

bb79:
  %r288 = call i32 @eval()
  call void @putint(i32 %r288)
  call void @putch(i32 10)
  %r338 = sub i32 %r337, 1
  br label %bb78

bb80:
  call void @_sysy_stoptime(i32 214)
  ret i32 0
}

