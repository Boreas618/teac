declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@n = global i32 0
define i32 @swap( i32* %r100, i32 %r101, i32 %r103 ) {
bb24:
  %r218 = add i32 0, 0
  %r219 = add i32 0, 0
  %r221 = add i32 %r101, 0
  %r220 = add i32 0, 0
  %r222 = add i32 %r103, 0
  br label %bb1

bb1:
  %r107 = getelementptr i32, i32* %r100, i32 %r221
  %r223 = load i32, i32* %r107
  %r110 = getelementptr i32, i32* %r100, i32 %r222
  %r111 = load i32, i32* %r110
  %r113 = getelementptr i32, i32* %r100, i32 %r221
  store i32 %r111, i32* %r113
  %r116 = getelementptr i32, i32* %r100, i32 %r222
  store i32 %r223, i32* %r116
  ret i32 0
}

define i32 @heap_ajust( i32* %r117, i32 %r118, i32 %r120 ) {
bb25:
  %r224 = add i32 0, 0
  %r225 = add i32 0, 0
  %r226 = add i32 0, 0
  %r227 = add i32 0, 0
  %r229 = add i32 %r118, 0
  %r228 = add i32 0, 0
  %r230 = add i32 %r120, 0
  br label %bb2

bb2:
  %r231 = add i32 %r229, 0
  %r126 = mul i32 %r231, 2
  %r232 = add i32 %r126, 1
  br label %bb3

bb3:
  %r233 = phi i32 [ %r231, %bb2 ], [ %r238, %bb12 ]
  %r234 = phi i32 [ %r232, %bb2 ], [ %r239, %bb12 ]
  %r130 = add i32 %r230, 1
  %r131 = icmp slt i32 %r234, %r130
  br i1 %r131, label %bb4, label %bb5

bb4:
  %r235 = add i32 %r234, 1
  %r137 = icmp slt i32 %r234, %r230
  br i1 %r137, label %bb9, label %bb7

bb9:
  %r139 = getelementptr i32, i32* %r117, i32 %r234
  %r140 = load i32, i32* %r139
  %r142 = getelementptr i32, i32* %r117, i32 %r235
  %r143 = load i32, i32* %r142
  %r144 = icmp slt i32 %r140, %r143
  br i1 %r144, label %bb6, label %bb7

bb6:
  %r240 = add i32 %r234, 1
  br label %bb8

bb7:
  br label %bb8

bb8:
  %r236 = phi i32 [ %r240, %bb6 ], [ %r234, %bb7 ]
  %r148 = getelementptr i32, i32* %r117, i32 %r233
  %r149 = load i32, i32* %r148
  %r151 = getelementptr i32, i32* %r117, i32 %r236
  %r152 = load i32, i32* %r151
  %r153 = icmp sgt i32 %r149, %r152
  br i1 %r153, label %bb10, label %bb11

bb10:
  ret i32 0
bb11:
  %r237 = call i32 @swap(i32* %r117, i32 %r233, i32 %r236)
  %r238 = add i32 %r236, 0
  %r159 = mul i32 %r238, 2
  %r239 = add i32 %r159, 1
  br label %bb12

bb12:
  br label %bb3

bb5:
  ret i32 0
}

define i32 @heap_sort( i32* %r161, i32 %r162 ) {
bb27:
  %r241 = add i32 0, 0
  %r242 = add i32 0, 0
  %r243 = add i32 0, 0
  %r244 = add i32 0, 0
  %r245 = add i32 %r162, 0
  br label %bb13

bb13:
  %r167 = sdiv i32 %r245, 2
  %r246 = sub i32 %r167, 1
  br label %bb14

bb14:
  %r247 = phi i32 [ %r246, %bb13 ], [ %r257, %bb15 ]
  %r170 = icmp sgt i32 %r247, -1
  br i1 %r170, label %bb15, label %bb16

bb15:
  %r255 = sub i32 %r245, 1
  %r256 = call i32 @heap_ajust(i32* %r161, i32 %r247, i32 %r255)
  %r257 = sub i32 %r247, 1
  br label %bb14

bb16:
  %r248 = sub i32 %r245, 1
  br label %bb17

bb17:
  %r249 = phi i32 [ %r248, %bb16 ], [ %r254, %bb18 ]
  %r181 = icmp sgt i32 %r249, 0
  br i1 %r181, label %bb18, label %bb19

bb18:
  %r250 = add i32 0, 0
  %r251 = call i32 @swap(i32* %r161, i32 %r250, i32 %r249)
  %r252 = sub i32 %r249, 1
  %r253 = call i32 @heap_ajust(i32* %r161, i32 %r250, i32 %r252)
  %r254 = sub i32 %r249, 1
  br label %bb17

bb19:
  ret i32 0
}

define i32 @main( ) {
bb20:
  %r258 = add i32 0, 0
  call void @_sysy_starttime(i32 50)
  store i32 10, i32* @n
  %r193 = alloca [ 10 x i32 ]
  %r194 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 0
  store i32 4, i32* %r194
  %r195 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 1
  store i32 3, i32* %r195
  %r196 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 2
  store i32 9, i32* %r196
  %r197 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 3
  store i32 2, i32* %r197
  %r198 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 4
  store i32 0, i32* %r198
  %r199 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 5
  store i32 1, i32* %r199
  %r200 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 6
  store i32 6, i32* %r200
  %r201 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 7
  store i32 5, i32* %r201
  %r202 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 8
  store i32 7, i32* %r202
  %r203 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 9
  store i32 8, i32* %r203
  %r259 = add i32 0, 0
  %r260 = add i32 0, 0
  %r205 = load i32, i32* @n
  %r261 = call i32 @heap_sort(i32* %r193, i32 %r205)
  br label %bb21

bb21:
  %r262 = phi i32 [ %r261, %bb20 ], [ %r265, %bb22 ]
  %r208 = load i32, i32* @n
  %r209 = icmp slt i32 %r262, %r208
  br i1 %r209, label %bb22, label %bb23

bb22:
  %r212 = getelementptr [10 x i32 ], [10 x i32 ]* %r193, i32 0, i32 %r262
  %r263 = load i32, i32* %r212
  call void @putint(i32 %r263)
  %r264 = add i32 10, 0
  call void @putch(i32 %r264)
  %r265 = add i32 %r262, 1
  br label %bb21

bb23:
  call void @_sysy_stoptime(i32 66)
  ret i32 0
}

