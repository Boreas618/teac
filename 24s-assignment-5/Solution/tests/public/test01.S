.section .data
.global    a
.global    b
.global    c
a:
        .zero   80
b:
        .quad   27
c:
        .quad   1
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global main
        //%r144->x12
        //%r141->x10
        //%r140->x10
        //%r139->x11
        //%r138->x10
        //%r137->x10
        //%r136->x9
        //%r134->x9
        //%r133->x9
        //%r132->x9
        //%r131->x10
        //%r130->x9
        //%r129->x10
        //%r135->x9
        //%r106->x10
        //%r119->x9
        //%r142->x11
        //%r113->x11
        //%r126->x11
        //%r143->x11
        //%r114->x11
        //%r127->x10
        //%r118->x9
        //%r121->x9
        //%r122->x9
        //%r123->x10
        //%r124->x9
        //%r125->x12
        //%r128->x9
        //%r145->x11
        //%r146->x9
        //%r147->x9
        //%r148->x9
        //%r149->x9
main:

        //bb1:

bb1:

        //  call void @_sysy_starttime(i32 4)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #4
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r121 = add i32 0, 0

        mov     x9, #0
        //  %r123 = add i32 0, 0

        mov     x9, #0
        mov     x10, x9
        //  %r122 = add i32 0, 0

        mov     x9, #0
        //  %r124 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r125 = phi i32 [ %r123, %bb1 ], [ %r131, %bb3 ]

        mov     x12, x10
        b     bb2
        //bb2:

bb2:

        //  %r125 = phi i32 [ %r123, %bb1 ], [ %r131, %bb3 ]

        //  %r103 = icmp slt i32 %r125, 10

        mov     x10, #10
        cmp     x12, x10
        //  br i1 %r103, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r106 = getelementptr [10 x i32 ], [10 x i32 ]* @a, i32 0, i32 %r125

        mov     x10, #8
        mul     x11, x12, x10
        adrp     x10, a
        add     x10, x10, #:lo12:a
        add     x10, x10, x11
        //  store i32 %r125, i32* %r106

        str     x12, [x10]
        //  %r131 = add i32 %r125, 1

        add     x10, x12, #1
        //  br label %bb2


        //bb2:  %r125 = phi i32 [ %r123, %bb1 ], [ %r131, %bb3 ]

        mov     x12, x10
        b     bb2
        //bb4:

bb4:

        //  %r126 = add i32 0, 0

        mov     x10, #0
        mov     x11, x10
        //  br label %bb5


        //bb5:  %r127 = phi i32 [ %r124, %bb4 ], [ %r129, %bb6 ]

        mov     x10, x9
        //bb5:  %r128 = phi i32 [ %r126, %bb4 ], [ %r130, %bb6 ]

        mov     x9, x11
        b     bb5
        //bb5:

bb5:

        //  %r127 = phi i32 [ %r124, %bb4 ], [ %r129, %bb6 ]

        //  %r128 = phi i32 [ %r126, %bb4 ], [ %r130, %bb6 ]

        //  %r110 = icmp slt i32 %r128, 10

        mov     x11, #10
        cmp     x9, x11
        //  br i1 %r110, label %bb6, label %bb7


        b.lt     bb6
        b     bb7
        //bb6:

bb6:

        //  %r113 = getelementptr [10 x i32 ], [10 x i32 ]* @a, i32 0, i32 %r128

        mov     x11, #8
        mul     x12, x9, x11
        adrp     x11, a
        add     x11, x11, #:lo12:a
        add     x11, x11, x12
        //  %r114 = load i32, i32* %r113

        ldr     x11, [x11]
        //  %r129 = add i32 %r127, %r114

        add     x10, x10, x11
        //  %r130 = add i32 %r128, 1

        add     x9, x9, #1
        //  br label %bb5


        //bb5:  %r127 = phi i32 [ %r124, %bb4 ], [ %r129, %bb6 ]

        mov     x10, x10
        //bb5:  %r128 = phi i32 [ %r126, %bb4 ], [ %r130, %bb6 ]

        mov     x9, x9
        b     bb5
        //bb7:

bb7:

        //  %r118 = load i32, i32* @b

        adrp     x9, b
        add     x9, x9, #:lo12:b
        ldr     x9, [x9]
        //  call void @putint(i32 %r118)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r119 = load i32, i32* @c

        adrp     x9, c
        add     x9, x9, #:lo12:c
        ldr     x9, [x9]
        //  call void @putint(i32 %r119)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putint(i32 %r127)

        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @_sysy_stoptime(i32 19)

        mov     x9, #19
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
