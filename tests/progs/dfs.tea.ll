define i32 @quickread():
	%r100 = call i32 @getch()
	%r101 = alloca i32, align 4
	store i32 %r100, ptr %r101, align 4
	%r102 = alloca i32, align 4
	store i32 0, ptr %r102, align 4
	%r103 = alloca i32, align 4
	store i32 0, ptr %r103, align 4
	br label %bb1
	%r104 = alloca i32, align 4
	%r108 = alloca i32, align 4
	%r112 = alloca i32, align 4
	%r115 = alloca i32, align 4
	%r119 = alloca i32, align 4
	%r127 = alloca i32, align 4
bb1:
	%r105 = load ptr, %r101, align 4
bb5:
	store i32 1, ptr %r104, align 4
	br label %bb7
bb6:
	store i32 0, ptr %r104, align 4
	br label %bb7
bb4:
	%r109 = load ptr, %r101, align 4
bb8:
	store i32 1, ptr %r108, align 4
	br label %bb10
bb9:
	store i32 0, ptr %r108, align 4
	br label %bb10
bb2:
	%r113 = load ptr, %r101, align 4
bb11:
	store i32 1, ptr %r103, align 4
	br label %bb13
bb12:
	store i32 1, ptr %r103, align 4
	br label %bb13
bb13:
	%r114 = call i32 @getch()
	store i32 %r114, ptr %r101, align 4
	br label %bb1
bb3:
	br label %bb14
bb14:
	%r116 = load ptr, %r101, align 4
bb18:
	store i32 1, ptr %r115, align 4
	br label %bb20
bb19:
	store i32 0, ptr %r115, align 4
	br label %bb20
bb17:
	%r120 = load ptr, %r101, align 4
bb21:
	store i32 1, ptr %r119, align 4
	br label %bb23
bb22:
	store i32 0, ptr %r119, align 4
	br label %bb23
bb15:
	%r123 = mul %r102, 10
	%r124 = add %r123, %r101
	%r125 = sub %r124, 48
	store i32 %r125, ptr %r102, align 4
	%r126 = call i32 @getch()
	store i32 %r126, ptr %r101, align 4
	br label %bb14
bb16:
	%r128 = load ptr, %r103, align 4
bb24:
	%r129 = sub 0, %r102
	ret %r129
bb25:
	%r130 = sub 0, %r102
	ret %r130
bb26:
	ret 0

define void @addedge(i32, i32,):
	%r101 = load ptr, %cnt, align 4
	%r100 = getelementptr ptr, %to, %r101
	store i32 %r1, ptr %r100, align 4
	%r103 = load ptr, %cnt, align 4
	%r102 = getelementptr ptr, %next, %r103
	%r105 = load ptr, %r0, align 4
	%r104 = getelementptr ptr, %head, %r105
	%r106 = load ptr, %r104, align 4
	store i32 %r104, ptr %r102, align 4
	%r108 = load ptr, %r0, align 4
	%r107 = getelementptr ptr, %head, %r108
	store i32 %cnt, ptr %r107, align 4
	%r109 = add %cnt, 1
	store i32 %r109, ptr %cnt, align 4
	%r111 = load ptr, %cnt, align 4
	%r110 = getelementptr ptr, %to, %r111
	store i32 %r0, ptr %r110, align 4
	%r113 = load ptr, %cnt, align 4
	%r112 = getelementptr ptr, %next, %r113
	%r115 = load ptr, %r1, align 4
	%r114 = getelementptr ptr, %head, %r115
	%r116 = load ptr, %r114, align 4
	store i32 %r114, ptr %r112, align 4
	%r118 = load ptr, %r1, align 4
	%r117 = getelementptr ptr, %head, %r118
	store i32 %cnt, ptr %r117, align 4
	%r119 = add %cnt, 1
	store i32 %r119, ptr %cnt, align 4
	ret void

define void @init():
	%r100 = alloca i32, align 4
	store i32 0, ptr %r100, align 4
	br label %bb1
bb1:
	%r101 = load ptr, %r100, align 4
bb2:
	%r103 = load ptr, %r100, align 4
	%r102 = getelementptr ptr, %head, %r103
	store i32 -1, ptr %r102, align 4
	%r104 = add %r100, 1
	store i32 %r104, ptr %r100, align 4
	br label %bb1
bb3:
	ret void

define void @clear():
	%r100 = alloca i32, align 4
	store i32 1, ptr %r100, align 4
	br label %bb1
bb1:
	%r101 = load ptr, %r100, align 4
bb2:
	%r103 = load ptr, %r100, align 4
	%r102 = getelementptr ptr, %vis, %r103
	store i32 0, ptr %r102, align 4
	%r104 = add %r100, 1
	store i32 %r104, ptr %r100, align 4
	br label %bb1
bb3:
	ret void

define i32 @same(i32, i32,):
	%r101 = load ptr, %r0, align 4
	%r100 = getelementptr ptr, %vis, %r101
	store i32 1, ptr %r100, align 4
	%r102 = alloca i32, align 4
	%r106 = alloca i32, align 4
	%r111 = alloca i32, align 4
	%r113 = alloca i32, align 4
	%r119 = alloca i32, align 4
bb1:
	ret 1
bb2:
	ret 1
bb3:
	%r104 = load ptr, %r0, align 4
	%r103 = getelementptr ptr, %head, %r104
	%r105 = load ptr, %r103, align 4
	store i32 %r103, ptr %r106, align 4
	br label %bb4
bb4:
	%r107 = load ptr, %r106, align 4
bb5:
	%r109 = load ptr, %r106, align 4
	%r108 = getelementptr ptr, %to, %r109
	%r110 = load ptr, %r108, align 4
	store i32 %r108, ptr %r111, align 4
	%r115 = load ptr, %r111, align 4
	%r114 = getelementptr ptr, %vis, %r115
	%r116 = load ptr, %r114, align 4
bb11:
	store i32 1, ptr %r113, align 4
	br label %bb13
bb12:
	store i32 0, ptr %r113, align 4
	br label %bb13
bb10:
	%r121 = load ptr, %r111, align 4
	%r120 = call i32 @same(%r111, %r1)
bb14:
	store i32 1, ptr %r119, align 4
	br label %bb16
bb15:
	store i32 0, ptr %r119, align 4
	br label %bb16
bb7:
	ret 1
bb8:
	ret 1
bb9:
	%r125 = load ptr, %r106, align 4
	%r124 = getelementptr ptr, %next, %r125
	%r126 = load ptr, %r124, align 4
	store i32 %r124, ptr %r106, align 4
	br label %bb4
bb6:
	ret 0

define i32 @main():
	call @_sysy_starttime(74)
	%r100 = call i32 @quickread()
	store i32 %r100, ptr %n, align 4
	%r101 = call i32 @quickread()
	store i32 %r101, ptr %m, align 4
	call @init()
	%r102 = alloca i32, align 4
	store i32 0, ptr %r102, align 4
	%r103 = alloca i32, align 4
	store i32 0, ptr %r103, align 4
	%r104 = alloca i32, align 4
	store i32 0, ptr %r104, align 4
	br label %bb1
	%r106 = alloca i32, align 4
	%r110 = alloca i32, align 4
	%r115 = alloca i32, align 4
bb1:
bb2:
	%r105 = call i32 @getch()
	store i32 %r105, ptr %r102, align 4
	br label %bb4
bb4:
	%r107 = load ptr, %r102, align 4
bb8:
	store i32 1, ptr %r106, align 4
	br label %bb10
bb9:
	store i32 0, ptr %r106, align 4
	br label %bb10
bb7:
	%r111 = load ptr, %r102, align 4
bb11:
	store i32 1, ptr %r110, align 4
	br label %bb13
bb12:
	store i32 0, ptr %r110, align 4
	br label %bb13
bb5:
	%r114 = call i32 @getch()
	store i32 %r114, ptr %r102, align 4
	br label %bb4
bb6:
	%r116 = load ptr, %r102, align 4
bb14:
	%r117 = call i32 @quickread()
	store i32 %r117, ptr %r103, align 4
	%r118 = call i32 @quickread()
	store i32 %r118, ptr %r104, align 4
	call @clear()
	%r120 = load ptr, %r103, align 4
	%r121 = load ptr, %r104, align 4
	%r119 = call i32 @same(%r103, %r104)
	call @putint(%r119)
	call @putch(10)
	br label %bb16
bb15:
	%r122 = call i32 @quickread()
	store i32 %r122, ptr %r103, align 4
	%r123 = call i32 @quickread()
	store i32 %r123, ptr %r104, align 4
	call @clear()
	%r125 = load ptr, %r103, align 4
	%r126 = load ptr, %r104, align 4
	%r124 = call i32 @same(%r103, %r104)
	call @putint(%r124)
	call @putch(10)
	br label %bb16
bb16:
	%r127 = sub %m, 1
	store i32 %r127, ptr %m, align 4
	br label %bb1
bb3:
	call @_sysy_stoptime(96)
	ret 0

