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
.global mod
.global split
.global main
        //%r100->x10
        //%r165->x9
        //%r102->x11
        //%r107->x11
        //%r146->x9
        //%r109->x9
        //%r110->x9
        //%r143->x9
        //%r144->x9
        //%r145->x10
        //%r164->x9
mod:

        //bb10:

bb10:

        //  %r143 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r145 = add i32 %r100, 0

        mov     x10, x10
        //  %r144 = add i32 0, 0

        mov     x9, #0
        //  %r146 = add i32 %r102, 0

        mov     x9, x11
        //  %r107 = sdiv i32 %r145, %r146

        sdiv     x11, x10, x9
        //  %r109 = mul i32 %r107, %r146

        mul     x9, x11, x9
        //  %r110 = sub i32 %r145, %r109

        sub     x9, x10, x9
        //  ret i32 %r110

        mov     x0, x9
        mov     sp, x29
        ret
        //%r153->x11
        //%r151->x11
        //%r148->x9
        //%r149->x11
        //%r123->x10
        //%r152->x12
        //%r147->x9
        //%r118->x10
        //%r121->x13
        //%r150->x10
        //%r115->x10
        //%r173->x10
        //%r113->x9
        //%r171->x10
        //%r111->x11
        //%r169->x10
        //%r154->x10
        //%r166->x10
        //%r167->x10
        //%r168->x10
        //%r170->x10
        //%r172->x10
        //%r174->x9
split:

        //bb11:

bb11:

        //  %r147 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x9, x1
        mov     x10, #0
        //  %r148 = add i32 0, 0

        mov     x10, #0
        //  %r149 = add i32 %r111, 0

        mov     x11, x11
        //  %r115 = load i32, i32* @N

        adrp     x10, N
        add     x10, x10, #:lo12:N
        ldr     x10, [x10]
        //  %r150 = sub i32 %r115, 1

        sub     x10, x10, #1
        //  br label %bb3


        //bb3:  %r151 = phi i32 [ %r149, %bb11 ], [ %r153, %bb4 ]

        mov     x11, x11
        //bb3:  %r152 = phi i32 [ %r150, %bb11 ], [ %r154, %bb4 ]

        mov     x12, x10
        b     bb3
        //bb3:

bb3:

        //  %r151 = phi i32 [ %r149, %bb11 ], [ %r153, %bb4 ]

        //  %r152 = phi i32 [ %r150, %bb11 ], [ %r154, %bb4 ]

        //  %r118 = sub i32 0, 1

        mov     x10, #0
        sub     x10, x10, #1
        //  %r119 = icmp ne i32 %r152, %r118

        cmp     x12, x10
        //  br i1 %r119, label %bb4, label %bb5


        b.ne     bb4
        b     bb5
        //bb4:

bb4:

        //  %r121 = call i32 @mod(i32 %r151, i32 10)

        mov     x0, x11
        mov     x10, #10
        mov     x1, x10
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x13, x0
        //  %r123 = getelementptr i32, i32* %r113, i32 %r152

        mov     x10, #8
        mul     x10, x12, x10
        add     x10, x9, x10
        //  store i32 %r121, i32* %r123

        str     x13, [x10]
        //  %r153 = sdiv i32 %r151, 10

        mov     x10, #10
        sdiv     x11, x11, x10
        //  %r154 = sub i32 %r152, 1

        sub     x10, x12, #1
        //  br label %bb3


        //bb3:  %r151 = phi i32 [ %r149, %bb11 ], [ %r153, %bb4 ]

        mov     x11, x11
        //bb3:  %r152 = phi i32 [ %r150, %bb11 ], [ %r154, %bb4 ]

        mov     x12, x10
        b     bb3
        //bb5:

bb5:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r183->x9
        //%r182->x9
        //%r181->x9
        //%r180->x9
        //%r179->x9
        //%r178->x10
        //%r177->x9
        //%r137->x9
        //%r192->x9
        //%r163->x9
        //%r176->x10
        //%r140->x9
        //%r184->x9
        //%r155->x9
        //%r185->x9
        //%r156->x9
        //%r186->x9
        //%r157->x9
        //%r187->x9
        //%r158->x9
        //%r188->x9
        //%r159->x9
        //%r189->x10
        //%r160->x9
        //%r190->x9
        //%r161->x11
        //%r191->x9
        //%r162->x9
        //%r175->x9
        //%r193->x9
        //%r194->x9
main:

        //130:x29,#-32

        //bb6:

bb6:

        //  call void @_sysy_starttime(i32 26)

        mov     x16, #32
        sub     sp, sp, x16
        mov     x9, #26
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
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
        //  %r155 = add i32 0, 0

        mov     x9, #0
        //  %r156 = add i32 0, 0

        mov     x9, #0
        //  %r130 = alloca [ 4 x i32 ]

        //  %r158 = add i32 1478, 0

        mov     x9, #1478
        mov     x9, x9
        //  %r159 = call i32 @split(i32 %r158, i32* %r130)

        mov     x0, x9
        mov     x9, #-32
        add     x9, x29, x9
        mov     x1, x9
        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     split
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r157 = add i32 0, 0

        mov     x9, #0
        //  %r160 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb7


        //bb7:  %r161 = phi i32 [ %r160, %bb6 ], [ %r163, %bb8 ]

        mov     x11, x9
        b     bb7
        //bb7:

bb7:

        //  %r161 = phi i32 [ %r160, %bb6 ], [ %r163, %bb8 ]

        //  %r135 = icmp slt i32 %r161, 4

        mov     x9, #4
        cmp     x11, x9
        //  br i1 %r135, label %bb8, label %bb9


        b.lt     bb8
        b     bb9
        //bb8:

bb8:

        //  %r137 = getelementptr [4 x i32 ], [4 x i32 ]* %r130, i32 0 , i32 %r161

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-32
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r162 = load i32, i32* %r137

        ldr     x9, [x9]
        //  call void @putint(i32 %r162)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r140 = load i32, i32* @newline

        adrp     x9, newline
        add     x9, x9, #:lo12:newline
        ldr     x9, [x9]
        //  call void @putch(i32 %r140)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r163 = add i32 %r161, 1

        add     x9, x11, #1
        //  br label %bb7


        //bb7:  %r161 = phi i32 [ %r160, %bb6 ], [ %r163, %bb8 ]

        mov     x11, x9
        b     bb7
        //bb9:

bb9:

        //  call void @_sysy_stoptime(i32 42)

        mov     x9, #42
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        str     x27, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
