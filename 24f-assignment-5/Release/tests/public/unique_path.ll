declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
define i32 @uniquePaths( i32 %r100, i32 %r102 ) {
bb19:
  %r181 = add i32 0, 0
  %r182 = add i32 0, 0
  %r183 = add i32 0, 0
  %r184 = add i32 0, 0
  %r185 = add i32 0, 0
  %r108 = alloca [ 9 x i32 ]
  %r186 = add i32 0, 0
  %r188 = add i32 %r100, 0
  %r187 = add i32 0, 0
  %r189 = add i32 %r102, 0
  br label %bb1

bb1:
  %r105 = icmp eq i32 %r188, 1
  br i1 %r105, label %bb2, label %bb5

bb5:
  %r107 = icmp eq i32 %r189, 1
  br i1 %r107, label %bb2, label %bb3

bb2:
  ret i32 1
bb3:
  br label %bb4

bb4:
  %r190 = add i32 0, 0
  br label %bb6

bb6:
  %r191 = phi i32 [ %r190, %bb4 ], [ %r206, %bb7 ]
  %r116 = icmp slt i32 %r191, %r188
  br i1 %r116, label %bb7, label %bb8

bb7:
  %r118 = mul i32 %r191, 3
  %r120 = add i32 %r118, %r189
  %r205 = sub i32 %r120, 1
  %r123 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r205
  store i32 1, i32* %r123
  %r206 = add i32 %r191, 1
  br label %bb6

bb8:
  %r192 = add i32 0, 0
  br label %bb9

bb9:
  %r193 = phi i32 [ %r192, %bb8 ], [ %r204, %bb10 ]
  %r128 = icmp slt i32 %r193, %r189
  br i1 %r128, label %bb10, label %bb11

bb10:
  %r130 = sub i32 %r188, 1
  %r131 = mul i32 %r130, 3
  %r203 = add i32 %r131, %r193
  %r135 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r203
  store i32 1, i32* %r135
  %r204 = add i32 %r193, 1
  br label %bb9

bb11:
  %r194 = sub i32 %r188, 2
  br label %bb12

bb12:
  %r195 = phi i32 [ %r194, %bb11 ], [ %r198, %bb17 ]
  %r141 = icmp sgt i32 %r195, -1
  br i1 %r141, label %bb13, label %bb14

bb13:
  %r196 = sub i32 %r189, 2
  br label %bb15

bb15:
  %r197 = phi i32 [ %r196, %bb13 ], [ %r202, %bb16 ]
  %r145 = icmp sgt i32 %r197, -1
  br i1 %r145, label %bb16, label %bb17

bb16:
  %r147 = mul i32 %r195, 3
  %r199 = add i32 %r147, %r197
  %r151 = add i32 %r195, 1
  %r152 = mul i32 %r151, 3
  %r200 = add i32 %r152, %r197
  %r156 = mul i32 %r195, 3
  %r158 = add i32 %r156, %r197
  %r201 = add i32 %r158, 1
  %r161 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r200
  %r162 = load i32, i32* %r161
  %r164 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r201
  %r165 = load i32, i32* %r164
  %r166 = add i32 %r162, %r165
  %r168 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 %r199
  store i32 %r166, i32* %r168
  %r202 = sub i32 %r197, 1
  br label %bb15

bb17:
  %r198 = sub i32 %r195, 1
  br label %bb12

bb14:
  %r173 = getelementptr [9 x i32 ], [9 x i32 ]* %r108, i32 0, i32 0
  %r174 = load i32, i32* %r173
  ret i32 %r174
}

define i32 @main( ) {
bb18:
  call void @_sysy_starttime(i32 40)
  %r207 = add i32 0, 0
  %r208 = add i32 0, 0
  %r209 = add i32 3, 0
  %r210 = call i32 @uniquePaths(i32 %r209, i32 %r209)
  call void @_sysy_stoptime(i32 45)
  ret i32 %r210
}

