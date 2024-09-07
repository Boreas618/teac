declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@N = global i32 0
@newline = global i32 0
define i32 @factor( i32 %r100 ) {
bb9:
  %r126 = add i32 0, 0
  %r127 = add i32 0, 0
  %r128 = add i32 0, 0
  %r129 = add i32 %r100, 0
  %r130 = add i32 0, 0
  %r131 = add i32 1, 0
  br label %bb2

bb2:
  %r132 = phi i32 [ %r131, %bb9 ], [ %r135, %bb7 ]
  %r133 = phi i32 [ %r130, %bb9 ], [ %r134, %bb7 ]
  %r106 = add i32 %r129, 1
  %r107 = icmp slt i32 %r132, %r106
  br i1 %r107, label %bb3, label %bb4

bb3:
  %r110 = sdiv i32 %r129, %r132
  %r112 = mul i32 %r110, %r132
  %r114 = icmp eq i32 %r112, %r129
  br i1 %r114, label %bb5, label %bb6

bb5:
  %r136 = add i32 %r133, %r132
  br label %bb7

bb6:
  br label %bb7

bb7:
  %r134 = phi i32 [ %r136, %bb5 ], [ %r133, %bb6 ]
  %r135 = add i32 %r132, 1
  br label %bb2

bb4:
  ret i32 %r133
}

define i32 @main( ) {
bb8:
  call void @_sysy_starttime(i32 24)
  store i32 4, i32* @N
  store i32 10, i32* @newline
  %r137 = add i32 0, 0
  %r138 = add i32 0, 0
  %r140 = add i32 1478, 0
  %r139 = add i32 0, 0
  call void @_sysy_stoptime(i32 31)
  %r125 = call i32 @factor(i32 %r140)
  ret i32 %r125
}

