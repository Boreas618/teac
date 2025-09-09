@n = global i32 0

@m = global i32 0

@to = global [5005 x i32] zeroinitializer

@next = global [5005 x i32] zeroinitializer

@head = global [1005 x i32] zeroinitializer

@cnt = global i32 0

@vis = global [1005 x i32] zeroinitializer

declare i32 @getch();

declare void @_sysy_starttime(i32);

declare void @_sysy_stoptime(i32);

declare void @putint(i32);

declare void @putch(i32);

define i32 @quickread() {
quickread:
	%r123 = alloca i32, align 4
	%r118 = alloca i32, align 4
	%r109 = alloca i32, align 4
	%r104 = alloca i32, align 4
	%r100 = call i32 @getch()
	%r101 = alloca i32, align 4
	store i32 %r100, ptr %r101, align 4
	%r102 = alloca i32, align 4
	store i32 0, ptr %r102, align 4
	%r103 = alloca i32, align 4
	store i32 0, ptr %r103, align 4
	br label %bb1
bb1:
	%r105 = load i32, ptr %r101, align 4
	%r106 = icmp slt i32 %r105, 48
	br i1 %r106, label %bb5, label %bb6
bb5:
	store i32 1, ptr %r104, align 4
	br label %bb7
bb6:
	store i32 0, ptr %r104, align 4
	br label %bb7
bb7:
	%r108 = load i32, ptr %r104, align 4
	%r107 = icmp ne i32 %r108, 0
	br i1 %r107, label %bb2, label %bb4
bb4:
	%r110 = load i32, ptr %r101, align 4
	%r111 = icmp sgt i32 %r110, 57
	br i1 %r111, label %bb8, label %bb9
bb8:
	store i32 1, ptr %r109, align 4
	br label %bb10
bb9:
	store i32 0, ptr %r109, align 4
	br label %bb10
bb10:
	%r113 = load i32, ptr %r109, align 4
	%r112 = icmp ne i32 %r113, 0
	br i1 %r112, label %bb2, label %bb3
bb2:
	%r115 = load i32, ptr %r101, align 4
	%r116 = icmp eq i32 %r115, 45
	br i1 %r116, label %bb11, label %bb12
bb11:
	store i32 1, ptr %r103, align 4
	br label %bb13
bb12:
	br label %bb13
bb13:
	%r117 = call i32 @getch()
	store i32 %r117, ptr %r101, align 4
	br label %bb1
bb3:
	br label %bb14
bb14:
	%r119 = load i32, ptr %r101, align 4
	%r120 = icmp sge i32 %r119, 48
	br i1 %r120, label %bb18, label %bb19
bb18:
	store i32 1, ptr %r118, align 4
	br label %bb20
bb19:
	store i32 0, ptr %r118, align 4
	br label %bb20
bb20:
	%r122 = load i32, ptr %r118, align 4
	%r121 = icmp ne i32 %r122, 0
	br i1 %r121, label %bb17, label %bb16
bb17:
	%r124 = load i32, ptr %r101, align 4
	%r125 = icmp sle i32 %r124, 57
	br i1 %r125, label %bb21, label %bb22
bb21:
	store i32 1, ptr %r123, align 4
	br label %bb23
bb22:
	store i32 0, ptr %r123, align 4
	br label %bb23
bb23:
	%r127 = load i32, ptr %r123, align 4
	%r126 = icmp ne i32 %r127, 0
	br i1 %r126, label %bb15, label %bb16
bb15:
	%r128 = load i32, ptr %r102, align 4
	%r129 = mul i32 %r128, 10
	%r130 = load i32, ptr %r101, align 4
	%r131 = add i32 %r129, %r130
	%r132 = sub i32 %r131, 48
	store i32 %r132, ptr %r102, align 4
	%r133 = call i32 @getch()
	store i32 %r133, ptr %r101, align 4
	br label %bb14
bb16:
	%r135 = load i32, ptr %r103, align 4
	%r136 = icmp ne i32 %r135, 0
	br i1 %r136, label %bb24, label %bb25
bb24:
	%r137 = load i32, ptr %r102, align 4
	%r138 = sub i32 0, %r137
	ret i32 %r138
bb25:
	%r139 = load i32, ptr %r102, align 4
	ret i32 %r139
bb26:
	ret i32 0
}

define void @addedge(i32 %r100, i32 %r101) {
addedge:
	%r103 = load i32, ptr @cnt, align 4
	%r102 = getelementptr [5005 x i32], ptr @to, i32 0, i32 %r103
	store i32 %r101, ptr %r102, align 4
	%r105 = load i32, ptr @cnt, align 4
	%r104 = getelementptr [5005 x i32], ptr @next, i32 0, i32 %r105
	%r107 = load i32, ptr %r100, align 4
	%r106 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r107
	%r108 = load i32, ptr %r106, align 4
	store i32 %r108, ptr %r104, align 4
	%r110 = load i32, ptr %r100, align 4
	%r109 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r110
	store i32 @cnt, ptr %r109, align 4
	%r111 = add i32 @cnt, 1
	store i32 %r111, ptr @cnt, align 4
	%r113 = load i32, ptr @cnt, align 4
	%r112 = getelementptr [5005 x i32], ptr @to, i32 0, i32 %r113
	store i32 %r100, ptr %r112, align 4
	%r115 = load i32, ptr @cnt, align 4
	%r114 = getelementptr [5005 x i32], ptr @next, i32 0, i32 %r115
	%r117 = load i32, ptr %r101, align 4
	%r116 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r117
	%r118 = load i32, ptr %r116, align 4
	store i32 %r118, ptr %r114, align 4
	%r120 = load i32, ptr %r101, align 4
	%r119 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r120
	store i32 @cnt, ptr %r119, align 4
	%r121 = add i32 @cnt, 1
	store i32 %r121, ptr @cnt, align 4
	ret void
}

define void @init() {
init:
	%r100 = alloca i32, align 4
	store i32 0, ptr %r100, align 4
	br label %bb1
bb1:
	%r101 = load i32, ptr %r100, align 4
	%r102 = icmp slt i32 %r101, 1005
	br i1 %r102, label %bb2, label %bb3
bb2:
	%r104 = load i32, ptr %r100, align 4
	%r103 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r104
	store i32 -1, ptr %r103, align 4
	%r105 = load i32, ptr %r100, align 4
	%r106 = add i32 %r105, 1
	store i32 %r106, ptr %r100, align 4
	br label %bb1
bb3:
	ret void
}

define void @clear() {
clear:
	%r100 = alloca i32, align 4
	store i32 1, ptr %r100, align 4
	br label %bb1
bb1:
	%r101 = load i32, ptr %r100, align 4
	%r102 = icmp sle i32 %r101, @n
	br i1 %r102, label %bb2, label %bb3
bb2:
	%r104 = load i32, ptr %r100, align 4
	%r103 = getelementptr [1005 x i32], ptr @vis, i32 0, i32 %r104
	store i32 0, ptr %r103, align 4
	%r105 = load i32, ptr %r100, align 4
	%r106 = add i32 %r105, 1
	store i32 %r106, ptr %r100, align 4
	br label %bb1
bb3:
	ret void
}

define i32 @same(i32 %r100, i32 %r101) {
same:
	%r124 = alloca i32, align 4
	%r115 = alloca i32, align 4
	%r117 = alloca i32, align 4
	%r109 = alloca i32, align 4
	%r103 = load i32, ptr %r100, align 4
	%r102 = getelementptr [1005 x i32], ptr @vis, i32 0, i32 %r103
	store i32 1, ptr %r102, align 4
	%r105 = icmp eq i32 %r100, %r101
	br i1 %r105, label %bb1, label %bb2
bb1:
	ret i32 1
bb2:
	br label %bb3
bb3:
	%r107 = load i32, ptr %r100, align 4
	%r106 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r107
	%r108 = load i32, ptr %r106, align 4
	store i32 %r108, ptr %r109, align 4
	br label %bb4
bb4:
	%r110 = load i32, ptr %r109, align 4
	%r111 = icmp ne i32 %r110, -1
	br i1 %r111, label %bb5, label %bb6
bb5:
	%r113 = load i32, ptr %r109, align 4
	%r112 = getelementptr [5005 x i32], ptr @to, i32 0, i32 %r113
	%r114 = load i32, ptr %r112, align 4
	store i32 %r114, ptr %r115, align 4
	%r119 = load i32, ptr %r115, align 4
	%r118 = getelementptr [1005 x i32], ptr @vis, i32 0, i32 %r119
	%r120 = load i32, ptr %r118, align 4
	%r121 = icmp eq i32 %r120, 0
	br i1 %r121, label %bb11, label %bb12
bb11:
	store i32 1, ptr %r117, align 4
	br label %bb13
bb12:
	store i32 0, ptr %r117, align 4
	br label %bb13
bb13:
	%r123 = load i32, ptr %r117, align 4
	%r122 = icmp ne i32 %r123, 0
	br i1 %r122, label %bb10, label %bb8
bb10:
	%r126 = load i32, ptr %r115, align 4
	%r125 = call i32 @same(%r126, %r101)
	%r127 = icmp ne i32 %r125, 0
	br i1 %r127, label %bb14, label %bb15
bb14:
	store i32 1, ptr %r124, align 4
	br label %bb16
bb15:
	store i32 0, ptr %r124, align 4
	br label %bb16
bb16:
	%r129 = load i32, ptr %r124, align 4
	%r128 = icmp ne i32 %r129, 0
	br i1 %r128, label %bb7, label %bb8
bb7:
	ret i32 1
bb8:
	br label %bb9
bb9:
	%r131 = load i32, ptr %r109, align 4
	%r130 = getelementptr [5005 x i32], ptr @next, i32 0, i32 %r131
	%r132 = load i32, ptr %r130, align 4
	store i32 %r132, ptr %r109, align 4
	br label %bb4
bb6:
	ret i32 0
}

define i32 @main() {
main:
	%r112 = alloca i32, align 4
	%r107 = alloca i32, align 4
	call @_sysy_starttime(74)
	%r100 = call i32 @quickread()
	store i32 %r100, ptr @n, align 4
	%r101 = call i32 @quickread()
	store i32 %r101, ptr @m, align 4
	call @init()
	%r102 = alloca i32, align 4
	store i32 0, ptr %r102, align 4
	%r103 = alloca i32, align 4
	store i32 0, ptr %r103, align 4
	%r104 = alloca i32, align 4
	store i32 0, ptr %r104, align 4
	br label %bb1
bb1:
	%r105 = icmp ne i32 @m, 0
	br i1 %r105, label %bb2, label %bb3
bb2:
	%r106 = call i32 @getch()
	store i32 %r106, ptr %r102, align 4
	br label %bb4
bb4:
	%r108 = load i32, ptr %r102, align 4
	%r109 = icmp ne i32 %r108, 81
	br i1 %r109, label %bb8, label %bb9
bb8:
	store i32 1, ptr %r107, align 4
	br label %bb10
bb9:
	store i32 0, ptr %r107, align 4
	br label %bb10
bb10:
	%r111 = load i32, ptr %r107, align 4
	%r110 = icmp ne i32 %r111, 0
	br i1 %r110, label %bb7, label %bb6
bb7:
	%r113 = load i32, ptr %r102, align 4
	%r114 = icmp ne i32 %r113, 85
	br i1 %r114, label %bb11, label %bb12
bb11:
	store i32 1, ptr %r112, align 4
	br label %bb13
bb12:
	store i32 0, ptr %r112, align 4
	br label %bb13
bb13:
	%r116 = load i32, ptr %r112, align 4
	%r115 = icmp ne i32 %r116, 0
	br i1 %r115, label %bb5, label %bb6
bb5:
	%r117 = call i32 @getch()
	store i32 %r117, ptr %r102, align 4
	br label %bb4
bb6:
	%r119 = load i32, ptr %r102, align 4
	%r120 = icmp eq i32 %r119, 81
	br i1 %r120, label %bb14, label %bb15
bb14:
	%r121 = call i32 @quickread()
	store i32 %r121, ptr %r103, align 4
	%r122 = call i32 @quickread()
	store i32 %r122, ptr %r104, align 4
	call @clear()
	%r124 = load i32, ptr %r103, align 4
	%r125 = load i32, ptr %r104, align 4
	%r123 = call i32 @same(%r124, %r125)
	call @putint(%r123)
	call @putch(10)
	br label %bb16
bb15:
	%r126 = call i32 @quickread()
	store i32 %r126, ptr %r103, align 4
	%r127 = call i32 @quickread()
	store i32 %r127, ptr %r104, align 4
	%r128 = load i32, ptr %r103, align 4
	%r129 = load i32, ptr %r104, align 4
	call @addedge(%r128, %r129)
	br label %bb16
bb16:
	%r130 = sub i32 @m, 1
	store i32 %r130, ptr @m, align 4
	br label %bb1
bb3:
	call @_sysy_stoptime(96)
	ret i32 0
}

