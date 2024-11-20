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
@vis = global [ 1005 x i32 ] zeroinitializer
define i32 @quickread( ) {
bb1:
  %r227 = add i32 0, 0
  %r230 = call i32 @getch()
  %r228 = add i32 0, 0
  %r231 = add i32 0, 0
  %r229 = add i32 0, 0
  %r232 = add i32 0, 0
  br label %bb2

bb2:
  %r233 = phi i32 [ %r232, %bb1 ], [ %r235, %bb8 ]
  %r234 = phi i32 [ %r230, %bb1 ], [ %r236, %bb8 ]
  %r105 = icmp slt i32 %r234, 48
  br i1 %r105, label %bb3, label %bb5

bb5:
  %r107 = icmp sgt i32 %r234, 57
  br i1 %r107, label %bb3, label %bb4

bb3:
  %r109 = icmp eq i32 %r234, 45
  br i1 %r109, label %bb6, label %bb7

bb6:
  %r237 = add i32 1, 0
  br label %bb8

bb7:
  br label %bb8

bb8:
  %r235 = phi i32 [ %r237, %bb6 ], [ %r233, %bb7 ]
  %r236 = call i32 @getch()
  br label %bb2

bb4:
  br label %bb9

bb9:
  %r238 = phi i32 [ %r231, %bb4 ], [ %r240, %bb10 ]
  %r239 = phi i32 [ %r234, %bb4 ], [ %r241, %bb10 ]
  %r112 = icmp sge i32 %r239, 48
  br i1 %r112, label %bb12, label %bb11

bb12:
  %r114 = icmp sle i32 %r239, 57
  br i1 %r114, label %bb10, label %bb11

bb10:
  %r116 = mul i32 %r238, 10
  %r118 = add i32 %r116, %r239
  %r240 = sub i32 %r118, 48
  %r241 = call i32 @getch()
  br label %bb9

bb11:
  %r122 = icmp ne i32 %r233, 0
  br i1 %r122, label %bb13, label %bb14

bb13:
  %r124 = sub i32 0, %r238
  ret i32 %r124
bb14:
  ret i32 %r238
}

define void @addedge( i32 %r126, i32 %r128 ) {
bb49:
  %r242 = add i32 0, 0
  %r244 = add i32 %r126, 0
  %r243 = add i32 0, 0
  %r245 = add i32 %r128, 0
  br label %bb16

bb16:
  %r131 = load i32, i32* @cnt
  %r132 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r131
  store i32 %r245, i32* %r132
  %r134 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r244
  %r135 = load i32, i32* %r134
  %r136 = load i32, i32* @cnt
  %r137 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r136
  store i32 %r135, i32* %r137
  %r138 = load i32, i32* @cnt
  %r140 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r244
  store i32 %r138, i32* %r140
  %r141 = load i32, i32* @cnt
  %r142 = add i32 %r141, 1
  store i32 %r142, i32* @cnt
  %r144 = load i32, i32* @cnt
  %r145 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r144
  store i32 %r244, i32* %r145
  %r147 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r245
  %r148 = load i32, i32* %r147
  %r149 = load i32, i32* @cnt
  %r150 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r149
  store i32 %r148, i32* %r150
  %r151 = load i32, i32* @cnt
  %r153 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r245
  store i32 %r151, i32* %r153
  %r154 = load i32, i32* @cnt
  %r155 = add i32 %r154, 1
  store i32 %r155, i32* @cnt
  ret void
}

define void @init( ) {
bb17:
  %r246 = add i32 0, 0
  %r247 = add i32 0, 0
  br label %bb18

bb18:
  %r248 = phi i32 [ %r247, %bb17 ], [ %r249, %bb19 ]
  %r158 = icmp slt i32 %r248, 1005
  br i1 %r158, label %bb19, label %bb20

bb19:
  %r160 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r248
  store i32 -1, i32* %r160
  %r249 = add i32 %r248, 1
  br label %bb18

bb20:
  ret void
}

define void @clear( ) {
bb21:
  %r250 = add i32 0, 0
  %r251 = add i32 1, 0
  br label %bb22

bb22:
  %r252 = phi i32 [ %r251, %bb21 ], [ %r253, %bb23 ]
  %r165 = load i32, i32* @n
  %r166 = icmp sle i32 %r252, %r165
  br i1 %r166, label %bb23, label %bb24

bb23:
  %r168 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r252
  store i32 0, i32* %r168
  %r253 = add i32 %r252, 1
  br label %bb22

bb24:
  ret void
}

define i32 @same( i32 %r171, i32 %r173 ) {
bb50:
  %r254 = add i32 0, 0
  %r255 = add i32 0, 0
  %r256 = add i32 0, 0
  %r258 = add i32 %r171, 0
  %r257 = add i32 0, 0
  %r259 = add i32 %r173, 0
  br label %bb25

bb25:
  %r176 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r258
  store i32 1, i32* %r176
  %r179 = icmp eq i32 %r258, %r259
  br i1 %r179, label %bb26, label %bb27

bb26:
  ret i32 1
bb27:
  br label %bb28

bb28:
  %r182 = getelementptr [1005 x i32 ], [1005 x i32 ]* @head, i32 0, i32 %r258
  %r260 = load i32, i32* %r182
  br label %bb29

bb29:
  %r261 = phi i32 [ %r260, %bb28 ], [ %r263, %bb34 ]
  %r185 = icmp ne i32 %r261, -1
  br i1 %r185, label %bb30, label %bb31

bb30:
  %r188 = getelementptr [5005 x i32 ], [5005 x i32 ]* @to, i32 0, i32 %r261
  %r262 = load i32, i32* %r188
  %r191 = getelementptr [1005 x i32 ], [1005 x i32 ]* @vis, i32 0, i32 %r262
  %r192 = load i32, i32* %r191
  %r193 = icmp eq i32 %r192, 0
  br i1 %r193, label %bb35, label %bb33

bb35:
  %r196 = call i32 @same(i32 %r262, i32 %r259)
  %r197 = icmp ne i32 %r196, 0
  br i1 %r197, label %bb32, label %bb33

bb32:
  ret i32 1
bb33:
  br label %bb34

bb34:
  %r199 = getelementptr [5005 x i32 ], [5005 x i32 ]* @next, i32 0, i32 %r261
  %r263 = load i32, i32* %r199
  br label %bb29

bb31:
  ret i32 0
}

define i32 @main( ) {
bb36:
  call void @_sysy_starttime(i32 74)
  %r201 = call i32 @quickread()
  store i32 %r201, i32* @n
  %r202 = call i32 @quickread()
  store i32 %r202, i32* @m
  call void @init()
  %r264 = add i32 0, 0
  %r267 = add i32 0, 0
  %r265 = add i32 0, 0
  %r268 = add i32 0, 0
  %r266 = add i32 0, 0
  %r269 = add i32 0, 0
  br label %bb37

bb37:
  %r206 = load i32, i32* @m
  %r207 = icmp ne i32 %r206, 0
  br i1 %r207, label %bb38, label %bb39

bb38:
  %r270 = call i32 @getch()
  br label %bb40

bb40:
  %r271 = phi i32 [ %r270, %bb38 ], [ %r276, %bb41 ]
  %r210 = icmp ne i32 %r271, 81
  br i1 %r210, label %bb43, label %bb42

bb43:
  %r212 = icmp ne i32 %r271, 85
  br i1 %r212, label %bb41, label %bb42

bb41:
  %r276 = call i32 @getch()
  br label %bb40

bb42:
  %r215 = icmp eq i32 %r271, 81
  br i1 %r215, label %bb44, label %bb45

bb44:
  %r274 = call i32 @quickread()
  %r275 = call i32 @quickread()
  call void @clear()
  %r220 = call i32 @same(i32 %r274, i32 %r275)
  call void @putint(i32 %r220)
  call void @putch(i32 10)
  br label %bb46

bb45:
  %r272 = call i32 @quickread()
  %r273 = call i32 @quickread()
  call void @addedge(i32 %r272, i32 %r273)
  br label %bb46

bb46:
  %r225 = load i32, i32* @m
  %r226 = sub i32 %r225, 1
  store i32 %r226, i32* @m
  br label %bb37

bb39:
  call void @_sysy_stoptime(i32 96)
  ret i32 0
}

