declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@a = global [ 10 x i32 ] zeroinitializer
@b = global i32 27
@c = global i32 1
define i32 @main( ) {
bb1:
  call void @_sysy_starttime(i32 4)
  %r121 = add i32 0, 0
  %r123 = add i32 0, 0
  %r122 = add i32 0, 0
  %r124 = add i32 0, 0
  br label %bb2

bb2:
  %r125 = phi i32 [ %r123, %bb1 ], [ %r131, %bb3 ]
  %r103 = icmp slt i32 %r125, 10
  br i1 %r103, label %bb3, label %bb4

bb3:
  %r106 = getelementptr [10 x i32 ], [10 x i32 ]* @a, i32 0, i32 %r125
  store i32 %r125, i32* %r106
  %r131 = add i32 %r125, 1
  br label %bb2

bb4:
  %r126 = add i32 0, 0
  br label %bb5

bb5:
  %r127 = phi i32 [ %r124, %bb4 ], [ %r129, %bb6 ]
  %r128 = phi i32 [ %r126, %bb4 ], [ %r130, %bb6 ]
  %r110 = icmp slt i32 %r128, 10
  br i1 %r110, label %bb6, label %bb7

bb6:
  %r113 = getelementptr [10 x i32 ], [10 x i32 ]* @a, i32 0, i32 %r128
  %r114 = load i32, i32* %r113
  %r129 = add i32 %r127, %r114
  %r130 = add i32 %r128, 1
  br label %bb5

bb7:
  %r118 = load i32, i32* @b
  call void @putint(i32 %r118)
  %r119 = load i32, i32* @c
  call void @putint(i32 %r119)
  call void @putint(i32 %r127)
  call void @_sysy_stoptime(i32 19)
  ret i32 0
}

