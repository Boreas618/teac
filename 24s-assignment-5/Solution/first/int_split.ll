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
  %r145 = add i32 0, 0
  %r147 = add i32 %r100, 0
  %r146 = add i32 0, 0
  %r148 = add i32 %r102, 0
  %r107 = sdiv i32 %r147, %r148
  %r109 = mul i32 %r107, %r148
  %r110 = sub i32 %r147, %r109
  ret i32 %r110
}

define i32 @split( i32 %r111, i32* %r113 ) {
bb11:
  %r149 = add i32 0, 0
  %r150 = add i32 0, 0
  %r151 = add i32 %r111, 0
  %r115 = load i32, i32* @N
  %r152 = sub i32 %r115, 1
  br label %bb3

bb3:
  %r153 = phi i32 [ %r151, %bb11 ], [ %r155, %bb4 ]
  %r154 = phi i32 [ %r152, %bb11 ], [ %r156, %bb4 ]
  %r118 = sub i32 0, 1
  %r119 = icmp ne i32 %r154, %r118
  br i1 %r119, label %bb4, label %bb5

bb4:
  %r121 = call i32 @mod(i32 %r153, i32 10)
  %r123 = getelementptr i32, i32* %r113, i32 %r154
  store i32 %r121, i32* %r123
  %r155 = sdiv i32 %r153, 10
  call void @putint(i32 %r155)
  call void @putch(i32 10)
  %r156 = sub i32 %r154, 1
  call void @putint(i32 1)
  call void @putch(i32 10)
  br label %bb3

bb5:
  ret i32 0
}

define i32 @main( ) {
bb6:
  call void @putint(i32 100)
  store i32 4, i32* @N
  store i32 10, i32* @newline
  %r157 = add i32 0, 0
  %r158 = add i32 0, 0
  %r131 = alloca [ 4 x i32 ]
  %r160 = add i32 1478, 0
  call void @putint(i32 %r160)
  %r161 = call i32 @split(i32 %r160, i32* %r131)
  %r159 = add i32 0, 0
  %r162 = add i32 0, 0
  br label %bb7

bb7:
  %r163 = phi i32 [ %r162, %bb6 ], [ %r165, %bb8 ]
  %r137 = icmp slt i32 %r163, 4
  br i1 %r137, label %bb8, label %bb9

bb8:
  %r139 = getelementptr [4 x i32 ], [4 x i32 ]* %r131, i32 0 , i32 %r163
  %r164 = load i32, i32* %r139
  call void @putint(i32 %r164)
  %r142 = load i32, i32* @newline
  call void @putch(i32 %r142)
  %r165 = add i32 %r163, 1
  br label %bb7

bb9:
  ret i32 0
}

