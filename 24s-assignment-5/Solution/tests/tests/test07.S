.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global main
        //%r150->x11
        //%r149->x10
        //%r148->x10
        //%r147->x9
        //%r146->x9
        //%r145->x9
        //%r144->x9
        //%r143->x9
        //%r142->x9
        //%r141->x9
        //%r140->x9
        //%r139->x9
        //%r138->x10
        //%r137->x10
        //%r136->x9
        //%r135->x9
        //%r122->x9
        //%r123->x9
        //%r124->x9
        //%r125->x9
        //%r126->x9
        //%r127->x9
        //%r128->x9
        //%r129->x9
        //%r130->x9
        //%r131->x9
        //%r132->x10
        //%r133->x11
        //%r134->x10
        //%r151->x10
        //%r152->x10
        //%r153->x10
        //%r154->x10
        //%r155->x9
        //%r156->x9
        //%r157->x9
        //%r158->x9
main:

        //bb1:

bb1:

        //  %r122 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r123 = add i32 0, 0

        mov     x9, #0
        //  %r124 = add i32 0, 0

        mov     x9, #0
        //  %r125 = add i32 0, 0

        mov     x9, #0
        //  %r126 = add i32 0, 0

        mov     x9, #0
        //  %r127 = add i32 0, 0

        mov     x9, #0
        //  call void @_sysy_starttime(i32 2)

        mov     x9, #2
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
        //  %r128 = add i32 0, 0

        mov     x9, #0
        //  %r131 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  %r129 = add i32 0, 0

        mov     x10, #0
        //  %r130 = add i32 0, 0

        mov     x10, #0
        //  %r104 = icmp slt i32 1, 9

        mov     x11, #1
        mov     x10, #9
        cmp     x11, x10
        //  br i1 %r104, label %bb5, label %bb3


        b.lt     bb5
        b     bb3
        //bb5:

bb5:

        //  %r106 = icmp sgt i32 %r131, 0

        mov     x10, #0
        cmp     x9, x10
        //  br i1 %r106, label %bb2, label %bb3


        b.gt     bb2
        b     bb3
        //bb2:

bb2:

        //  %r138 = add i32 1, 0

        mov     x10, #1
        mov     x10, x10
        //  br label %bb4


        //bb4:  %r132 = phi i32 [ %r138, %bb2 ], [ %r137, %bb3 ]

        mov     x10, x10
        b     bb4
        //bb3:

bb3:

        //  %r137 = add i32 0, 0

        mov     x10, #0
        mov     x10, x10
        //  br label %bb4


        //bb4:  %r132 = phi i32 [ %r138, %bb2 ], [ %r137, %bb3 ]

        mov     x10, x10
        b     bb4
        //bb4:

bb4:

        //  %r132 = phi i32 [ %r138, %bb2 ], [ %r137, %bb3 ]

        //  %r133 = add i32 %r132, 0

        mov     x11, x10
        //  br label %bb6


        //bb6:  %r134 = phi i32 [ %r131, %bb4 ], [ %r136, %bb7 ]

        mov     x10, x9
        b     bb6
        //bb6:

bb6:

        //  %r134 = phi i32 [ %r131, %bb4 ], [ %r136, %bb7 ]

        //  %r108 = icmp slt i32 %r134, 1000000

        movz     x9, #15, LSL #16
        movk     x9, #16960, LSL #0
        cmp     x10, x9
        //  br i1 %r108, label %bb7, label %bb8


        b.lt     bb7
        b     bb8
        //bb7:

bb7:

        //  %r135 = add i32 0, 0

        mov     x9, #0
        //  %r136 = add i32 %r134, 1

        add     x9, x10, #1
        //  br label %bb6


        //bb6:  %r134 = phi i32 [ %r131, %bb4 ], [ %r136, %bb7 ]

        mov     x10, x9
        b     bb6
        //bb8:

bb8:

        //  call void @putint(i32 %r133)

        mov     x0, x11
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
        //  call void @_sysy_stoptime(i32 10)

        mov     x9, #10
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
