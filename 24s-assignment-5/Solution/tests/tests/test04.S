.section .data
.global    a
a:
        .quad   1
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global foo
.global main
        //%r100->x10
        //%r110->x9
        //%r111->x10
        //%r116->x9
        //%r117->x9
        //%r118->x9
foo:

        //bb7:

bb7:

        //  %r110 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r111 = add i32 %r100, 0

        mov     x10, x10
        //  store i32 %r111, i32* @a

        adrp     x9, a
        add     x9, x9, #:lo12:a
        str     x10, [x9]
        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //%r124->x9
        //%r123->x9
        //%r122->x9
        //%r120->x9
        //%r115->x9
        //%r114->x10
        //%r113->x10
        //%r112->x9
        //%r121->x9
        //%r108->x9
        //%r119->x9
        //%r106->x11
        //%r104->x11
        //%r125->x9
        //%r126->x9
        //%r127->x9
        //%r128->x9
        //%r129->x9
main:

        //bb2:

bb2:

        //  call void @_sysy_starttime(i32 9)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #9
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
        //  %r112 = add i32 0, 0

        mov     x9, #0
        //  %r113 = add i32 1, 0

        mov     x9, #1
        mov     x10, x9
        //  %r104 = call i32 @foo(i32 2)

        mov     x9, #2
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     foo
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r105 = icmp sgt i32 %r104, 0

        mov     x9, #0
        cmp     x11, x9
        //  br i1 %r105, label %bb3, label %bb6


        b.gt     bb3
        b     bb6
        //bb6:

bb6:

        //  %r106 = call i32 @foo(i32 3)

        mov     x9, #3
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     foo
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r107 = icmp sgt i32 %r106, 0

        mov     x9, #0
        cmp     x11, x9
        //  br i1 %r107, label %bb3, label %bb4


        b.gt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r115 = add i32 2, 0

        mov     x9, #2
        mov     x9, x9
        //  br label %bb5


        //bb5:  %r114 = phi i32 [ %r115, %bb3 ], [ %r113, %bb4 ]

        mov     x10, x9
        b     bb5
        //bb4:

bb4:

        //  br label %bb5


        //bb5:  %r114 = phi i32 [ %r115, %bb3 ], [ %r113, %bb4 ]

        mov     x10, x10
        b     bb5
        //bb5:

bb5:

        //  %r114 = phi i32 [ %r115, %bb3 ], [ %r113, %bb4 ]

        //  %r108 = load i32, i32* @a

        adrp     x9, a
        add     x9, x9, #:lo12:a
        ldr     x9, [x9]
        //  call void @putint(i32 %r108)

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
        //  call void @putint(i32 %r114)

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
        //  call void @_sysy_stoptime(i32 17)

        mov     x9, #17
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
