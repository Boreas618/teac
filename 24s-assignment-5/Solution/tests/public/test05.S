.section .data
.global    N
.global    newline
N:
        .quad   0
newline:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global factor
.global main
        //%r134->x11
        //%r133->x11
        //%r131->x9
        //%r130->x11
        //%r129->x10
        //%r100->x10
        //%r128->x9
        //%r127->x9
        //%r112->x12
        //%r141->x9
        //%r110->x12
        //%r132->x9
        //%r106->x12
        //%r135->x9
        //%r126->x9
        //%r136->x11
        //%r142->x9
        //%r143->x9
        //%r144->x9
        //%r145->x9
factor:

        //bb9:

bb9:

        //  %r126 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r127 = add i32 0, 0

        mov     x9, #0
        //  %r128 = add i32 0, 0

        mov     x9, #0
        //  %r129 = add i32 %r100, 0

        mov     x10, x10
        //  %r130 = add i32 0, 0

        mov     x9, #0
        mov     x11, x9
        //  %r131 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r132 = phi i32 [ %r131, %bb9 ], [ %r135, %bb7 ]

        mov     x9, x9
        //bb2:  %r133 = phi i32 [ %r130, %bb9 ], [ %r134, %bb7 ]

        mov     x11, x11
        b     bb2
        //bb2:

bb2:

        //  %r132 = phi i32 [ %r131, %bb9 ], [ %r135, %bb7 ]

        //  %r133 = phi i32 [ %r130, %bb9 ], [ %r134, %bb7 ]

        //  %r106 = add i32 %r129, 1

        add     x12, x10, #1
        //  %r107 = icmp slt i32 %r132, %r106

        cmp     x9, x12
        //  br i1 %r107, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r110 = sdiv i32 %r129, %r132

        sdiv     x12, x10, x9
        //  %r112 = mul i32 %r110, %r132

        mul     x12, x12, x9
        //  %r114 = icmp eq i32 %r112, %r129

        cmp     x12, x10
        //  br i1 %r114, label %bb5, label %bb6


        b.eq     bb5
        b     bb6
        //bb5:

bb5:

        //  %r136 = add i32 %r133, %r132

        add     x11, x11, x9
        //  br label %bb7


        //bb7:  %r134 = phi i32 [ %r136, %bb5 ], [ %r133, %bb6 ]

        mov     x11, x11
        b     bb7
        //bb6:

bb6:

        //  br label %bb7


        //bb7:  %r134 = phi i32 [ %r136, %bb5 ], [ %r133, %bb6 ]

        mov     x11, x11
        b     bb7
        //bb7:

bb7:

        //  %r134 = phi i32 [ %r136, %bb5 ], [ %r133, %bb6 ]

        //  %r135 = add i32 %r132, 1

        add     x9, x9, #1
        //  br label %bb2


        //bb2:  %r132 = phi i32 [ %r131, %bb9 ], [ %r135, %bb7 ]

        mov     x9, x9
        //bb2:  %r133 = phi i32 [ %r130, %bb9 ], [ %r134, %bb7 ]

        mov     x11, x11
        b     bb2
        //bb4:

bb4:

        //  ret i32 %r133

        mov     x0, x11
        mov     sp, x29
        ret
        //%r149->x10
        //%r148->x9
        //%r147->x10
        //%r146->x9
        //%r153->x9
        //%r140->x10
        //%r152->x9
        //%r139->x9
        //%r150->x9
        //%r137->x9
        //%r151->x9
        //%r138->x9
        //%r125->x9
        //%r154->x9
        //%r155->x9
main:

        //bb8:

bb8:

        //  call void @_sysy_starttime(i32 24)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #24
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
        //  store i32 4, i32* @N

        mov     x10, #4
        adrp     x9, N
        add     x9, x9, #:lo12:N
        str     x10, [x9]
        //  store i32 10, i32* @newline

        mov     x10, #10
        adrp     x9, newline
        add     x9, x9, #:lo12:newline
        str     x10, [x9]
        //  %r137 = add i32 0, 0

        mov     x9, #0
        //  %r138 = add i32 0, 0

        mov     x9, #0
        //  %r140 = add i32 1478, 0

        mov     x9, #1478
        mov     x10, x9
        //  %r139 = add i32 0, 0

        mov     x9, #0
        //  call void @_sysy_stoptime(i32 31)

        mov     x9, #31
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
        //  %r125 = call i32 @factor(i32 %r140)

        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     factor
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  ret i32 %r125

        mov     x0, x9
        mov     sp, x29
        ret
