; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

%struct.timeval = type { i64, i32 }

@n = global i32 0
@m = global i32 0
@to = global [5005 x i32] zeroinitializer
@next = global [5005 x i32] zeroinitializer
@head = global [1005 x i32] zeroinitializer
@cnt = global i32 0
@vis = global [1005 x i32] zeroinitializer
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @__GLOBAL_init_65535, ptr null }]
@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@_sysy_us = local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@_sysy_s = local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@_sysy_m = local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@_sysy_h = local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@_sysy_idx = local_unnamed_addr global i32 1, align 4
@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.5 = private unnamed_addr constant [35 x i8] c"Timer@%04d-%04d: %dH-%dM-%dS-%dus\0A\00", align 1
@_sysy_l1 = local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@_sysy_l2 = local_unnamed_addr global [1024 x i32] zeroinitializer, align 4
@.str.6 = private unnamed_addr constant [25 x i8] c"TOTAL: %dH-%dM-%dS-%dus\0A\00", align 1
@_sysy_start = global %struct.timeval zeroinitializer, align 8
@_sysy_end = global %struct.timeval zeroinitializer, align 8
@__dso_handle = external hidden global i8

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

bb1:                                              ; preds = %bb13, %quickread
  %r105 = load i32, ptr %r101, align 4
  %r106 = icmp slt i32 %r105, 48
  br i1 %r106, label %bb5, label %bb6

bb5:                                              ; preds = %bb1
  store i32 1, ptr %r104, align 4
  br label %bb7

bb6:                                              ; preds = %bb1
  store i32 0, ptr %r104, align 4
  br label %bb7

bb7:                                              ; preds = %bb6, %bb5
  %r108 = load i32, ptr %r104, align 4
  %r107 = icmp ne i32 %r108, 0
  br i1 %r107, label %bb2, label %bb4

bb4:                                              ; preds = %bb7
  %r110 = load i32, ptr %r101, align 4
  %r111 = icmp sgt i32 %r110, 57
  br i1 %r111, label %bb8, label %bb9

bb8:                                              ; preds = %bb4
  store i32 1, ptr %r109, align 4
  br label %bb10

bb9:                                              ; preds = %bb4
  store i32 0, ptr %r109, align 4
  br label %bb10

bb10:                                             ; preds = %bb9, %bb8
  %r113 = load i32, ptr %r109, align 4
  %r112 = icmp ne i32 %r113, 0
  br i1 %r112, label %bb2, label %bb3

bb2:                                              ; preds = %bb10, %bb7
  %r115 = load i32, ptr %r101, align 4
  %r116 = icmp eq i32 %r115, 45
  br i1 %r116, label %bb11, label %bb12

bb11:                                             ; preds = %bb2
  store i32 1, ptr %r103, align 4
  br label %bb13

bb12:                                             ; preds = %bb2
  br label %bb13

bb13:                                             ; preds = %bb12, %bb11
  %r117 = call i32 @getch()
  store i32 %r117, ptr %r101, align 4
  br label %bb1

bb3:                                              ; preds = %bb10
  br label %bb14

bb14:                                             ; preds = %bb15, %bb3
  %r119 = load i32, ptr %r101, align 4
  %r120 = icmp sge i32 %r119, 48
  br i1 %r120, label %bb18, label %bb19

bb18:                                             ; preds = %bb14
  store i32 1, ptr %r118, align 4
  br label %bb20

bb19:                                             ; preds = %bb14
  store i32 0, ptr %r118, align 4
  br label %bb20

bb20:                                             ; preds = %bb19, %bb18
  %r122 = load i32, ptr %r118, align 4
  %r121 = icmp ne i32 %r122, 0
  br i1 %r121, label %bb17, label %bb16

bb17:                                             ; preds = %bb20
  %r124 = load i32, ptr %r101, align 4
  %r125 = icmp sle i32 %r124, 57
  br i1 %r125, label %bb21, label %bb22

bb21:                                             ; preds = %bb17
  store i32 1, ptr %r123, align 4
  br label %bb23

bb22:                                             ; preds = %bb17
  store i32 0, ptr %r123, align 4
  br label %bb23

bb23:                                             ; preds = %bb22, %bb21
  %r127 = load i32, ptr %r123, align 4
  %r126 = icmp ne i32 %r127, 0
  br i1 %r126, label %bb15, label %bb16

bb15:                                             ; preds = %bb23
  %r128 = load i32, ptr %r102, align 4
  %r129 = mul i32 %r128, 10
  %r130 = load i32, ptr %r101, align 4
  %r131 = add i32 %r129, %r130
  %r132 = sub i32 %r131, 48
  store i32 %r132, ptr %r102, align 4
  %r133 = call i32 @getch()
  store i32 %r133, ptr %r101, align 4
  br label %bb14

bb16:                                             ; preds = %bb23, %bb20
  %r135 = load i32, ptr %r103, align 4
  %r136 = icmp ne i32 %r135, 0
  br i1 %r136, label %bb24, label %bb25

bb24:                                             ; preds = %bb16
  %r137 = load i32, ptr %r102, align 4
  %r138 = sub i32 0, %r137
  ret i32 %r138

bb25:                                             ; preds = %bb16
  %r139 = load i32, ptr %r102, align 4
  ret i32 %r139

bb26:                                             ; No predecessors!
  ret i32 0
}

define void @addedge(i32 %r100, i32 %r101) {
addedge:
  %r102 = alloca i32, align 4
  store i32 %r100, ptr %r102, align 4
  %r103 = alloca i32, align 4
  store i32 %r101, ptr %r103, align 4
  %r105 = load i32, ptr @cnt, align 4
  %r104 = getelementptr [5005 x i32], ptr @to, i32 0, i32 %r105
  %r106 = load i32, ptr %r103, align 4
  store i32 %r106, ptr %r104, align 4
  %r108 = load i32, ptr @cnt, align 4
  %r107 = getelementptr [5005 x i32], ptr @next, i32 0, i32 %r108
  %r110 = load i32, ptr %r102, align 4
  %r109 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r110
  %r111 = load i32, ptr %r109, align 4
  store i32 %r111, ptr %r107, align 4
  %r113 = load i32, ptr %r102, align 4
  %r112 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r113
  %r114 = load i32, ptr @cnt, align 4
  store i32 %r114, ptr %r112, align 4
  %r115 = load i32, ptr @cnt, align 4
  %r116 = add i32 %r115, 1
  store i32 %r116, ptr @cnt, align 4
  %r118 = load i32, ptr @cnt, align 4
  %r117 = getelementptr [5005 x i32], ptr @to, i32 0, i32 %r118
  %r119 = load i32, ptr %r102, align 4
  store i32 %r119, ptr %r117, align 4
  %r121 = load i32, ptr @cnt, align 4
  %r120 = getelementptr [5005 x i32], ptr @next, i32 0, i32 %r121
  %r123 = load i32, ptr %r103, align 4
  %r122 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r123
  %r124 = load i32, ptr %r122, align 4
  store i32 %r124, ptr %r120, align 4
  %r126 = load i32, ptr %r103, align 4
  %r125 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r126
  %r127 = load i32, ptr @cnt, align 4
  store i32 %r127, ptr %r125, align 4
  %r128 = load i32, ptr @cnt, align 4
  %r129 = add i32 %r128, 1
  store i32 %r129, ptr @cnt, align 4
  ret void
}

define void @init() {
init:
  %r100 = alloca i32, align 4
  store i32 0, ptr %r100, align 4
  br label %bb1

bb1:                                              ; preds = %bb2, %init
  %r101 = load i32, ptr %r100, align 4
  %r102 = icmp slt i32 %r101, 1005
  br i1 %r102, label %bb2, label %bb3

bb2:                                              ; preds = %bb1
  %r104 = load i32, ptr %r100, align 4
  %r103 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r104
  store i32 -1, ptr %r103, align 4
  %r105 = load i32, ptr %r100, align 4
  %r106 = add i32 %r105, 1
  store i32 %r106, ptr %r100, align 4
  br label %bb1

bb3:                                              ; preds = %bb1
  ret void
}

define void @clear() {
clear:
  %r100 = alloca i32, align 4
  store i32 1, ptr %r100, align 4
  br label %bb1

bb1:                                              ; preds = %bb2, %clear
  %r101 = load i32, ptr %r100, align 4
  %r102 = load i32, ptr @n, align 4
  %r103 = icmp sle i32 %r101, %r102
  br i1 %r103, label %bb2, label %bb3

bb2:                                              ; preds = %bb1
  %r105 = load i32, ptr %r100, align 4
  %r104 = getelementptr [1005 x i32], ptr @vis, i32 0, i32 %r105
  store i32 0, ptr %r104, align 4
  %r106 = load i32, ptr %r100, align 4
  %r107 = add i32 %r106, 1
  store i32 %r107, ptr %r100, align 4
  br label %bb1

bb3:                                              ; preds = %bb1
  ret void
}

define i32 @same(i32 %r100, i32 %r101) {
same:
  %r128 = alloca i32, align 4
  %r119 = alloca i32, align 4
  %r121 = alloca i32, align 4
  %r113 = alloca i32, align 4
  %r102 = alloca i32, align 4
  store i32 %r100, ptr %r102, align 4
  %r103 = alloca i32, align 4
  store i32 %r101, ptr %r103, align 4
  %r105 = load i32, ptr %r102, align 4
  %r104 = getelementptr [1005 x i32], ptr @vis, i32 0, i32 %r105
  store i32 1, ptr %r104, align 4
  %r107 = load i32, ptr %r102, align 4
  %r108 = load i32, ptr %r103, align 4
  %r109 = icmp eq i32 %r107, %r108
  br i1 %r109, label %bb1, label %bb2

bb1:                                              ; preds = %same
  ret i32 1

bb2:                                              ; preds = %same
  br label %bb3

bb3:                                              ; preds = %bb2
  %r111 = load i32, ptr %r102, align 4
  %r110 = getelementptr [1005 x i32], ptr @head, i32 0, i32 %r111
  %r112 = load i32, ptr %r110, align 4
  store i32 %r112, ptr %r113, align 4
  br label %bb4

bb4:                                              ; preds = %bb9, %bb3
  %r114 = load i32, ptr %r113, align 4
  %r115 = icmp ne i32 %r114, -1
  br i1 %r115, label %bb5, label %bb6

bb5:                                              ; preds = %bb4
  %r117 = load i32, ptr %r113, align 4
  %r116 = getelementptr [5005 x i32], ptr @to, i32 0, i32 %r117
  %r118 = load i32, ptr %r116, align 4
  store i32 %r118, ptr %r119, align 4
  %r123 = load i32, ptr %r119, align 4
  %r122 = getelementptr [1005 x i32], ptr @vis, i32 0, i32 %r123
  %r124 = load i32, ptr %r122, align 4
  %r125 = icmp eq i32 %r124, 0
  br i1 %r125, label %bb11, label %bb12

bb11:                                             ; preds = %bb5
  store i32 1, ptr %r121, align 4
  br label %bb13

bb12:                                             ; preds = %bb5
  store i32 0, ptr %r121, align 4
  br label %bb13

bb13:                                             ; preds = %bb12, %bb11
  %r127 = load i32, ptr %r121, align 4
  %r126 = icmp ne i32 %r127, 0
  br i1 %r126, label %bb10, label %bb8

bb10:                                             ; preds = %bb13
  %r130 = load i32, ptr %r119, align 4
  %r131 = load i32, ptr %r103, align 4
  %r129 = call i32 @same(i32 %r130, i32 %r131)
  %r132 = icmp ne i32 %r129, 0
  br i1 %r132, label %bb14, label %bb15

bb14:                                             ; preds = %bb10
  store i32 1, ptr %r128, align 4
  br label %bb16

bb15:                                             ; preds = %bb10
  store i32 0, ptr %r128, align 4
  br label %bb16

bb16:                                             ; preds = %bb15, %bb14
  %r134 = load i32, ptr %r128, align 4
  %r133 = icmp ne i32 %r134, 0
  br i1 %r133, label %bb7, label %bb8

bb7:                                              ; preds = %bb16
  ret i32 1

bb8:                                              ; preds = %bb16, %bb13
  br label %bb9

bb9:                                              ; preds = %bb8
  %r136 = load i32, ptr %r113, align 4
  %r135 = getelementptr [5005 x i32], ptr @next, i32 0, i32 %r136
  %r137 = load i32, ptr %r135, align 4
  store i32 %r137, ptr %r113, align 4
  br label %bb4

bb6:                                              ; preds = %bb4
  ret i32 0
}

define i32 @main() {
main:
  %r113 = alloca i32, align 4
  %r108 = alloca i32, align 4
  call void @_sysy_starttime(i32 74)
  %r100 = call i32 @quickread()
  store i32 %r100, ptr @n, align 4
  %r101 = call i32 @quickread()
  store i32 %r101, ptr @m, align 4
  call void @init()
  %r102 = alloca i32, align 4
  store i32 0, ptr %r102, align 4
  %r103 = alloca i32, align 4
  store i32 0, ptr %r103, align 4
  %r104 = alloca i32, align 4
  store i32 0, ptr %r104, align 4
  br label %bb1

bb1:                                              ; preds = %bb16, %main
  %r105 = load i32, ptr @m, align 4
  %r106 = icmp ne i32 %r105, 0
  br i1 %r106, label %bb2, label %bb3

bb2:                                              ; preds = %bb1
  %r107 = call i32 @getch()
  store i32 %r107, ptr %r102, align 4
  br label %bb4

bb4:                                              ; preds = %bb5, %bb2
  %r109 = load i32, ptr %r102, align 4
  %r110 = icmp ne i32 %r109, 81
  br i1 %r110, label %bb8, label %bb9

bb8:                                              ; preds = %bb4
  store i32 1, ptr %r108, align 4
  br label %bb10

bb9:                                              ; preds = %bb4
  store i32 0, ptr %r108, align 4
  br label %bb10

bb10:                                             ; preds = %bb9, %bb8
  %r112 = load i32, ptr %r108, align 4
  %r111 = icmp ne i32 %r112, 0
  br i1 %r111, label %bb7, label %bb6

bb7:                                              ; preds = %bb10
  %r114 = load i32, ptr %r102, align 4
  %r115 = icmp ne i32 %r114, 85
  br i1 %r115, label %bb11, label %bb12

bb11:                                             ; preds = %bb7
  store i32 1, ptr %r113, align 4
  br label %bb13

bb12:                                             ; preds = %bb7
  store i32 0, ptr %r113, align 4
  br label %bb13

bb13:                                             ; preds = %bb12, %bb11
  %r117 = load i32, ptr %r113, align 4
  %r116 = icmp ne i32 %r117, 0
  br i1 %r116, label %bb5, label %bb6

bb5:                                              ; preds = %bb13
  %r118 = call i32 @getch()
  store i32 %r118, ptr %r102, align 4
  br label %bb4

bb6:                                              ; preds = %bb13, %bb10
  %r120 = load i32, ptr %r102, align 4
  %r121 = icmp eq i32 %r120, 81
  br i1 %r121, label %bb14, label %bb15

bb14:                                             ; preds = %bb6
  %r122 = call i32 @quickread()
  store i32 %r122, ptr %r103, align 4
  %r123 = call i32 @quickread()
  store i32 %r123, ptr %r104, align 4
  call void @clear()
  %r125 = load i32, ptr %r103, align 4
  %r126 = load i32, ptr %r104, align 4
  %r124 = call i32 @same(i32 %r125, i32 %r126)
  call void @putint(i32 %r124)
  call void @putch(i32 10)
  br label %bb16

bb15:                                             ; preds = %bb6
  %r127 = call i32 @quickread()
  store i32 %r127, ptr %r103, align 4
  %r128 = call i32 @quickread()
  store i32 %r128, ptr %r104, align 4
  %r129 = load i32, ptr %r103, align 4
  %r130 = load i32, ptr %r104, align 4
  call void @addedge(i32 %r129, i32 %r130)
  br label %bb16

bb16:                                             ; preds = %bb15, %bb14
  %r131 = load i32, ptr @m, align 4
  %r132 = sub i32 %r131, 1
  store i32 %r132, ptr @m, align 4
  br label %bb1

bb3:                                              ; preds = %bb1
  call void @_sysy_stoptime(i32 96)
  ret i32 0
}

; Function Attrs: nofree nounwind ssp uwtable(sync)
define internal void @__GLOBAL_init_65535() #0 section "__TEXT,__StaticInit,regular,pure_instructions" {
  %1 = tail call i32 @__cxa_atexit(ptr nonnull @after_main, ptr null, ptr nonnull @__dso_handle) #6
  ret void
}

; Function Attrs: nofree nounwind ssp uwtable(sync)
define void @after_main() #0 {
  %1 = load i32, ptr @_sysy_idx, align 4, !tbaa !5
  %2 = icmp sgt i32 %1, 1
  br i1 %2, label %15, label %3

3:                                                ; preds = %0
  %4 = load i32, ptr @_sysy_h, align 4, !tbaa !5
  %5 = load i32, ptr @_sysy_m, align 4, !tbaa !5
  %6 = load i32, ptr @_sysy_s, align 4, !tbaa !5
  %7 = load i32, ptr @_sysy_us, align 4, !tbaa !5
  br label %8

8:                                                ; preds = %15, %3
  %9 = phi i32 [ %7, %3 ], [ %37, %15 ]
  %10 = phi i32 [ %6, %3 ], [ %41, %15 ]
  %11 = phi i32 [ %5, %3 ], [ %45, %15 ]
  %12 = phi i32 [ %4, %3 ], [ %44, %15 ]
  %13 = load ptr, ptr @__stderrp, align 8, !tbaa !9
  %14 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %13, ptr noundef nonnull @.str.6, i32 noundef %12, i32 noundef %11, i32 noundef %10, i32 noundef %9) #6
  ret void

15:                                               ; preds = %15, %0
  %16 = phi i64 [ %46, %15 ], [ 1, %0 ]
  %17 = load ptr, ptr @__stderrp, align 8, !tbaa !9
  %18 = getelementptr inbounds [1024 x i32], ptr @_sysy_l1, i64 0, i64 %16
  %19 = load i32, ptr %18, align 4, !tbaa !5
  %20 = getelementptr inbounds [1024 x i32], ptr @_sysy_l2, i64 0, i64 %16
  %21 = load i32, ptr %20, align 4, !tbaa !5
  %22 = getelementptr inbounds [1024 x i32], ptr @_sysy_h, i64 0, i64 %16
  %23 = load i32, ptr %22, align 4, !tbaa !5
  %24 = getelementptr inbounds [1024 x i32], ptr @_sysy_m, i64 0, i64 %16
  %25 = load i32, ptr %24, align 4, !tbaa !5
  %26 = getelementptr inbounds [1024 x i32], ptr @_sysy_s, i64 0, i64 %16
  %27 = load i32, ptr %26, align 4, !tbaa !5
  %28 = getelementptr inbounds [1024 x i32], ptr @_sysy_us, i64 0, i64 %16
  %29 = load i32, ptr %28, align 4, !tbaa !5
  %30 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %17, ptr noundef nonnull @.str.5, i32 noundef %19, i32 noundef %21, i32 noundef %23, i32 noundef %25, i32 noundef %27, i32 noundef %29) #6
  %31 = load i32, ptr %28, align 4, !tbaa !5
  %32 = load i32, ptr @_sysy_us, align 4, !tbaa !5
  %33 = add nsw i32 %32, %31
  %34 = load i32, ptr %26, align 4, !tbaa !5
  %35 = load i32, ptr @_sysy_s, align 4, !tbaa !5
  %36 = add nsw i32 %35, %34
  %37 = srem i32 %33, 1000000
  store i32 %37, ptr @_sysy_us, align 4, !tbaa !5
  %38 = load i32, ptr %24, align 4, !tbaa !5
  %39 = load i32, ptr @_sysy_m, align 4, !tbaa !5
  %40 = add nsw i32 %39, %38
  %41 = srem i32 %36, 60
  store i32 %41, ptr @_sysy_s, align 4, !tbaa !5
  %42 = load i32, ptr %22, align 4, !tbaa !5
  %43 = load i32, ptr @_sysy_h, align 4, !tbaa !5
  %44 = add nsw i32 %43, %42
  store i32 %44, ptr @_sysy_h, align 4, !tbaa !5
  %45 = srem i32 %40, 60
  store i32 %45, ptr @_sysy_m, align 4, !tbaa !5
  %46 = add nuw nsw i64 %16, 1
  %47 = load i32, ptr @_sysy_idx, align 4, !tbaa !5
  %48 = sext i32 %47 to i64
  %49 = icmp slt i64 %46, %48
  br i1 %49, label %15, label %8, !llvm.loop !11
}

; Function Attrs: nofree nounwind
declare i32 @__cxa_atexit(ptr, ptr, ptr) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: nofree nounwind ssp uwtable(sync)
define i32 @getint() local_unnamed_addr #0 {
  %1 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %1) #6
  %2 = call i32 (ptr, ...) @scanf(ptr noundef nonnull @.str, ptr noundef nonnull %1)
  %3 = load i32, ptr %1, align 4, !tbaa !5
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %1) #6
  ret i32 %3
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #3

; Function Attrs: nofree nounwind
declare noundef i32 @scanf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #3

; Function Attrs: nofree nounwind ssp uwtable(sync)
define range(i32 -128, 128) i32 @getch() #0 {
  %1 = alloca i8, align 1
  call void @llvm.lifetime.start.p0(i64 1, ptr nonnull %1) #6
  %2 = call i32 (ptr, ...) @scanf(ptr noundef nonnull @.str.1, ptr noundef nonnull %1)
  %3 = load i8, ptr %1, align 1, !tbaa !13
  %4 = sext i8 %3 to i32
  call void @llvm.lifetime.end.p0(i64 1, ptr nonnull %1) #6
  ret i32 %4
}

; Function Attrs: nofree nounwind ssp uwtable(sync)
define void @putint(i32 noundef %0) #0 {
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %0)
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: nofree nounwind ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = tail call i32 @putchar(i32 %0)
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind ssp uwtable(sync)
define void @putarray(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef %0)
  %4 = icmp sgt i32 %0, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %2
  %6 = zext nneg i32 %0 to i64
  br label %9

7:                                                ; preds = %9, %2
  %8 = tail call i32 @putchar(i32 10)
  ret void

9:                                                ; preds = %9, %5
  %10 = phi i64 [ 0, %5 ], [ %14, %9 ]
  %11 = getelementptr inbounds i32, ptr %1, i64 %10
  %12 = load i32, ptr %11, align 4, !tbaa !5
  %13 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef %12)
  %14 = add nuw nsw i64 %10, 1
  %15 = icmp eq i64 %14, %6
  br i1 %15, label %7, label %9, !llvm.loop !14
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind ssp willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable(sync)
define void @before_main() local_unnamed_addr #4 {
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(4096) @_sysy_us, i8 0, i64 4096, i1 false), !tbaa !5
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(4096) @_sysy_s, i8 0, i64 4096, i1 false), !tbaa !5
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(4096) @_sysy_m, i8 0, i64 4096, i1 false), !tbaa !5
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(4096) @_sysy_h, i8 0, i64 4096, i1 false), !tbaa !5
  store i32 1, ptr @_sysy_idx, align 4, !tbaa !5
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nofree nounwind ssp uwtable(sync)
define void @_sysy_starttime(i32 noundef %0) #0 {
  %2 = load i32, ptr @_sysy_idx, align 4, !tbaa !5
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds [1024 x i32], ptr @_sysy_l1, i64 0, i64 %3
  store i32 %0, ptr %4, align 4, !tbaa !5
  %5 = tail call i32 @gettimeofday(ptr noundef nonnull @_sysy_start, ptr noundef null)
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @gettimeofday(ptr nocapture noundef, ptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind ssp uwtable(sync)
define void @_sysy_stoptime(i32 noundef %0) #0 {
  %2 = tail call i32 @gettimeofday(ptr noundef nonnull @_sysy_end, ptr noundef null)
  %3 = load i32, ptr @_sysy_idx, align 4, !tbaa !5
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds [1024 x i32], ptr @_sysy_l2, i64 0, i64 %4
  store i32 %0, ptr %5, align 4, !tbaa !5
  %6 = load i64, ptr @_sysy_end, align 8, !tbaa !15
  %7 = load i64, ptr @_sysy_start, align 8, !tbaa !15
  %8 = sub nsw i64 %6, %7
  %9 = load i32, ptr getelementptr inbounds (i8, ptr @_sysy_end, i64 8), align 8, !tbaa !18
  %10 = load i32, ptr getelementptr inbounds (i8, ptr @_sysy_start, i64 8), align 8, !tbaa !18
  %11 = getelementptr inbounds [1024 x i32], ptr @_sysy_us, i64 0, i64 %4
  %12 = load i32, ptr %11, align 4, !tbaa !5
  %13 = trunc i64 %8 to i32
  %14 = mul i32 %13, 1000000
  %15 = sub i32 %9, %10
  %16 = add i32 %15, %14
  %17 = add i32 %16, %12
  %18 = freeze i32 %17
  %19 = sdiv i32 %18, 1000000
  %20 = getelementptr inbounds [1024 x i32], ptr @_sysy_s, i64 0, i64 %4
  %21 = load i32, ptr %20, align 4, !tbaa !5
  %22 = add nsw i32 %19, %21
  %23 = mul i32 %19, 1000000
  %24 = sub i32 %18, %23
  store i32 %24, ptr %11, align 4, !tbaa !5
  %25 = freeze i32 %22
  %26 = sdiv i32 %25, 60
  %27 = getelementptr inbounds [1024 x i32], ptr @_sysy_m, i64 0, i64 %4
  %28 = load i32, ptr %27, align 4, !tbaa !5
  %29 = add nsw i32 %26, %28
  %30 = mul i32 %26, 60
  %31 = sub i32 %25, %30
  store i32 %31, ptr %20, align 4, !tbaa !5
  %32 = freeze i32 %29
  %33 = sdiv i32 %32, 60
  %34 = getelementptr inbounds [1024 x i32], ptr @_sysy_h, i64 0, i64 %4
  %35 = load i32, ptr %34, align 4, !tbaa !5
  %36 = add nsw i32 %35, %33
  store i32 %36, ptr %34, align 4, !tbaa !5
  %37 = mul i32 %33, 60
  %38 = sub i32 %32, %37
  store i32 %38, ptr %27, align 4, !tbaa !5
  %39 = add nsw i32 %3, 1
  store i32 %39, ptr @_sysy_idx, align 4, !tbaa !5
  ret void
}

attributes #0 = { nofree nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { nofree nounwind }
attributes #2 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { mustprogress nofree norecurse nosync nounwind ssp willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #5 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #6 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4}

!0 = !{!"Homebrew clang version 19.1.0"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !7, i64 0}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!7, !7, i64 0}
!14 = distinct !{!14, !12}
!15 = !{!16, !17, i64 0}
!16 = !{!"timeval", !17, i64 0, !6, i64 8}
!17 = !{!"long", !7, i64 0}
!18 = !{!16, !6, i64 8}
