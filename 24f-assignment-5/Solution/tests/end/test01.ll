declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
define i32 @main( ) {
bb1:
  %r157 = add i32 0, 0
  %r158 = add i32 0, 0
  %r159 = add i32 0, 0
  %r166 = add i32 2, 0
  %r160 = add i32 0, 0
  %r167 = add i32 3, 0
  %r161 = add i32 0, 0
  %r162 = add i32 0, 0
  %r163 = add i32 0, 0
  %r168 = add i32 5381, 0
  %r169 = call i32 @getint()
  %r170 = add i32 %r166, %r167
  %r164 = add i32 0, 0
  %r165 = add i32 0, 0
  %r171 = add i32 0, 0
  %r113 = icmp sgt i32 %r169, %r170
  br i1 %r113, label %bb2, label %bb3

bb2:
  %r177 = sub i32 %r169, %r170
  %r178 = add i32 0, 0
  br label %bb5

bb5:
  %r179 = phi i32 [ %r171, %bb2 ], [ %r182, %bb10 ]
  %r180 = phi i32 [ %r178, %bb2 ], [ %r183, %bb10 ]
  %r120 = icmp slt i32 %r180, %r177
  br i1 %r120, label %bb6, label %bb7

bb6:
  %r123 = sdiv i32 %r180, 2
  %r124 = mul i32 %r123, 2
  %r125 = sub i32 %r180, %r124
  %r126 = icmp eq i32 %r125, 0
  br i1 %r126, label %bb8, label %bb9

bb8:
  %r130 = mul i32 %r166, %r167
  %r185 = add i32 %r179, %r130
  br label %bb10

bb9:
  %r134 = add i32 %r179, %r167
  %r184 = add i32 %r134, %r169
  br label %bb10

bb10:
  %r181 = phi i32 [ %r185, %bb8 ], [ %r184, %bb9 ]
  %r140 = sdiv i32 %r181, %r168
  %r142 = mul i32 %r140, %r168
  %r182 = sub i32 %r181, %r142
  %r183 = add i32 %r180, 1
  br label %bb5

bb7:
  br label %bb4

bb3:
  %r175 = sub i32 %r170, %r169
  %r176 = mul i32 %r166, %r169
  br label %bb4

bb4:
  %r172 = phi i32 [ %r179, %bb7 ], [ %r176, %bb3 ]
  %r173 = phi i32 [ %r177, %bb7 ], [ %r175, %bb3 ]
  %r174 = add i32 %r172, %r173
  call void @putint(i32 %r174)
  call void @putch(i32 10)
  ret i32 0
}

