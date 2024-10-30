declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@N = global i32 0
@newline = global i32 0
define i32 @mod( i32 %r100, i32 %r102 ) {
bb10:
  %r142 = add i32 0, 0
  %r144 = add i32 %r100, 0
  %r143 = add i32 0, 0
  %r145 = add i32 %r102, 0
  br label %bb1

bb1:
  %r107 = sdiv i32 %r144, %r145
  %r109 = mul i32 %r107, %r145
  %r110 = sub i32 %r144, %r109
  ret i32 %r110
}

define i32 @split( i32 %r111, i32* %r113 ) {
bb11:
  %r146 = add i32 0, 0
  %r147 = add i32 0, 0
  %r148 = add i32 %r111, 0
  br label %bb2

bb2:
  %r115 = load i32, i32* @N
  %r149 = sub i32 %r115, 1
  br label %bb3

bb3:
  %r150 = phi i32 [ %r148, %bb2 ], [ %r152, %bb4 ]
  %r151 = phi i32 [ %r149, %bb2 ], [ %r153, %bb4 ]
  %r118 = icmp ne i32 %r151, -1
  br i1 %r118, label %bb4, label %bb5

bb4:
  %r120 = call i32 @mod(i32 %r150, i32 10)
  %r122 = getelementptr i32, i32* %r113, i32 %r151
  store i32 %r120, i32* %r122
  %r152 = sdiv i32 %r150, 10
  %r153 = sub i32 %r151, 1
  br label %bb3

bb5:
  ret i32 0
}

define i32 @main( ) {
bb6:
  call void @_sysy_starttime(i32 26)
  store i32 4, i32* @N
  store i32 10, i32* @newline
  %r154 = add i32 0, 0
  %r155 = add i32 0, 0
  %r129 = alloca [ 4 x i32 ]
  %r157 = add i32 1478, 0
  %r158 = call i32 @split(i32 %r157, i32* %r129)
  %r156 = add i32 0, 0
  %r159 = add i32 0, 0
  br label %bb7

bb7:
  %r160 = phi i32 [ %r159, %bb6 ], [ %r162, %bb8 ]
  %r134 = icmp slt i32 %r160, 4
  br i1 %r134, label %bb8, label %bb9

bb8:
  %r136 = getelementptr [4 x i32 ], [4 x i32 ]* %r129, i32 0, i32 %r160
  %r161 = load i32, i32* %r136
  call void @putint(i32 %r161)
  %r139 = load i32, i32* @newline
  call void @putch(i32 %r139)
  %r162 = add i32 %r160, 1
  br label %bb7

bb9:
  call void @_sysy_stoptime(i32 42)
  ret i32 0
}

