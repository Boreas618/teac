declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
define i32 @main( ) {
bb1:
  %r122 = add i32 0, 0
  %r123 = add i32 0, 0
  %r124 = add i32 0, 0
  %r125 = add i32 0, 0
  %r126 = add i32 0, 0
  %r127 = add i32 0, 0
  call void @_sysy_starttime(i32 2)
  %r128 = add i32 0, 0
  %r131 = add i32 0, 0
  %r129 = add i32 0, 0
  %r130 = add i32 0, 0
  %r104 = icmp slt i32 1, 9
  br i1 %r104, label %bb5, label %bb3

bb5:
  %r106 = icmp sgt i32 %r131, 0
  br i1 %r106, label %bb2, label %bb3

bb2:
  %r138 = add i32 1, 0
  br label %bb4

bb3:
  %r137 = add i32 0, 0
  br label %bb4

bb4:
  %r132 = phi i32 [ %r138, %bb2 ], [ %r137, %bb3 ]
  %r133 = add i32 %r132, 0
  br label %bb6

bb6:
  %r134 = phi i32 [ %r131, %bb4 ], [ %r136, %bb7 ]
  %r108 = icmp slt i32 %r134, 1000000
  br i1 %r108, label %bb7, label %bb8

bb7:
  %r135 = add i32 0, 0
  %r136 = add i32 %r134, 1
  br label %bb6

bb8:
  call void @putint(i32 %r133)
  call void @_sysy_stoptime(i32 10)
  ret i32 0
}

