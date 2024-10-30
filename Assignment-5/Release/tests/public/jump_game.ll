declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
define i32 @canJump( i32* %r100, i32 %r101 ) {
bb24:
  %r177 = add i32 0, 0
  %r178 = add i32 0, 0
  %r179 = add i32 0, 0
  %r110 = alloca [ 10 x i32 ]
  %r180 = add i32 0, 0
  %r181 = add i32 %r101, 0
  br label %bb1

bb1:
  %r104 = icmp eq i32 %r181, 1
  br i1 %r104, label %bb2, label %bb3

bb2:
  ret i32 1
bb3:
  br label %bb4

bb4:
  %r105 = getelementptr i32, i32* %r100, i32 0
  %r106 = load i32, i32* %r105
  %r108 = sub i32 %r181, 2
  %r109 = icmp sgt i32 %r106, %r108
  br i1 %r109, label %bb5, label %bb6

bb5:
  ret i32 1
bb6:
  br label %bb7

bb7:
  %r182 = add i32 0, 0
  br label %bb8

bb8:
  %r183 = phi i32 [ %r182, %bb7 ], [ %r194, %bb9 ]
  %r114 = sub i32 %r181, 1
  %r115 = icmp slt i32 %r183, %r114
  br i1 %r115, label %bb9, label %bb10

bb9:
  %r117 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 %r183
  store i32 0, i32* %r117
  %r194 = add i32 %r183, 1
  br label %bb8

bb10:
  %r184 = sub i32 %r181, 1
  %r124 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 %r184
  store i32 1, i32* %r124
  %r185 = sub i32 %r181, 2
  br label %bb11

bb11:
  %r186 = phi i32 [ %r185, %bb10 ], [ %r189, %bb19 ]
  %r128 = icmp sgt i32 %r186, -1
  br i1 %r128, label %bb12, label %bb13

bb12:
  %r131 = getelementptr i32, i32* %r100, i32 %r186
  %r132 = load i32, i32* %r131
  %r134 = sub i32 %r181, 1
  %r136 = sub i32 %r134, %r186
  %r137 = icmp slt i32 %r132, %r136
  br i1 %r137, label %bb14, label %bb15

bb14:
  %r139 = getelementptr i32, i32* %r100, i32 %r186
  %r193 = load i32, i32* %r139
  br label %bb16

bb15:
  %r142 = sub i32 %r181, 1
  %r192 = sub i32 %r142, %r186
  br label %bb16

bb16:
  %r187 = phi i32 [ %r193, %bb14 ], [ %r192, %bb15 ]
  br label %bb17

bb17:
  %r188 = phi i32 [ %r187, %bb16 ], [ %r191, %bb22 ]
  %r146 = icmp sgt i32 %r188, -1
  br i1 %r146, label %bb18, label %bb19

bb18:
  %r190 = add i32 %r186, %r188
  %r151 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 %r190
  %r152 = load i32, i32* %r151
  %r153 = icmp ne i32 %r152, 0
  br i1 %r153, label %bb20, label %bb21

bb20:
  %r155 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 %r186
  store i32 1, i32* %r155
  br label %bb22

bb21:
  br label %bb22

bb22:
  %r191 = sub i32 %r188, 1
  br label %bb17

bb19:
  %r189 = sub i32 %r186, 1
  br label %bb11

bb13:
  %r160 = getelementptr [10 x i32 ], [10 x i32 ]* %r110, i32 0, i32 0
  %r161 = load i32, i32* %r160
  ret i32 %r161
}

define i32 @main( ) {
bb23:
  call void @_sysy_starttime(i32 42)
  %r195 = add i32 0, 0
  %r163 = alloca [ 10 x i32 ]
  %r164 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 0
  store i32 3, i32* %r164
  %r165 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 1
  store i32 3, i32* %r165
  %r166 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 2
  store i32 9, i32* %r166
  %r167 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 3
  store i32 0, i32* %r167
  %r168 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 4
  store i32 0, i32* %r168
  %r169 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 5
  store i32 1, i32* %r169
  %r170 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 6
  store i32 1, i32* %r170
  %r171 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 7
  store i32 5, i32* %r171
  %r172 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 8
  store i32 7, i32* %r172
  %r173 = getelementptr [10 x i32 ], [10 x i32 ]* %r163, i32 0, i32 9
  store i32 8, i32* %r173
  %r196 = add i32 10, 0
  %r197 = call i32 @canJump(i32* %r163, i32 %r196)
  call void @_sysy_stoptime(i32 49)
  ret i32 %r197
}

