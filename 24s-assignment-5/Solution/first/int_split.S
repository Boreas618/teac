.section .data
.global    N
.global    newline
N:
        .word   0
newline:
        .word   0
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
        //%r102->x11
        //%r167->x9
        //%r107->x11
        //%r146->x9
        //%r109->x9
        //%r148->x9
        //%r110->x9
        //%r145->x9
        //%r147->x10
        //%r166->x9
mod:

        //bb10:

bb10:

        //  %r145 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r147 = add i32 %r100, 0

        mov     x10, x10
        //  %r146 = add i32 0, 0

        mov     x9, #0
        //  %r148 = add i32 %r102, 0

        mov     x9, x11
        //  %r107 = sdiv i32 %r147, %r148

        sdiv     x11, x10, x9
        //  %r109 = mul i32 %r107, %r148

        mul     x9, x11, x9
        //  %r110 = sub i32 %r147, %r109

        sub     x9, x10, x9
        //  ret i32 %r110

        mov     x0, x9
        mov     sp, x29
        ret
        //%r155->x12
        //%r153->x12
        //%r151->x11
        //%r149->x9
        //%r178->x10
        //%r123->x10
        //%r152->x10
        //%r121->x13
        //%r150->x9
        //%r179->x9
        //%r118->x10
        //%r176->x10
        //%r154->x11
        //%r115->x10
        //%r173->x10
        //%r113->x9
        //%r171->x10
        //%r111->x11
        //%r169->x10
        //%r156->x11
        //%r168->x10
        //%r170->x10
        //%r172->x10
        //%r174->x10
        //%r175->x10
        //%r177->x10
split:

        //bb11:

bb11:

        //  %r149 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x9, x1
        mov     x10, #0
        //  %r150 = add i32 0, 0

        mov     x10, #0
        //  %r151 = add i32 %r111, 0

        mov     x11, x11
        //  %r115 = load i32, i32* @N

        adr     x10, N
        ldr     x10, [x10]
        //  %r152 = sub i32 %r115, 1

        sub     x10, x10, #1
        //  br label %bb3


        //bb3:  %r153 = phi i32 [ %r151, %bb11 ], [ %r155, %bb4 ]

        mov     x12, x11
        //bb3:  %r154 = phi i32 [ %r152, %bb11 ], [ %r156, %bb4 ]

        mov     x11, x10
        b     bb3
        //bb3:

bb3:

        //  %r153 = phi i32 [ %r151, %bb11 ], [ %r155, %bb4 ]

        //  %r154 = phi i32 [ %r152, %bb11 ], [ %r156, %bb4 ]

        //  %r118 = sub i32 0, 1

        mov     x10, #0
        sub     x10, x10, #1
        //  %r119 = icmp ne i32 %r154, %r118

        cmp     x11, x10
        //  br i1 %r119, label %bb4, label %bb5


        b.ne     bb4
        b     bb5
        //bb4:

bb4:

        //  %r121 = call i32 @mod(i32 %r153, i32 10)

        mov     x0, x12
        mov     x10, #10
        mov     x1, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x13, x0
        //  %r123 = getelementptr i32, i32* %r113, i32 %r154

        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x9, x10
        //  store i32 %r121, i32* %r123

        str     x13, [x10]
        //  %r155 = sdiv i32 %r153, 10

        mov     x10, #10
        sdiv     x12, x12, x10
        //  call void @putint(i32 %r155)

        mov     x0, x12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 10)

        mov     x10, #10
        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r156 = sub i32 %r154, 1

        sub     x11, x11, #1
        //  call void @putint(i32 1)

        mov     x10, #1
        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 10)

        mov     x10, #10
        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb3


        //bb3:  %r153 = phi i32 [ %r151, %bb11 ], [ %r155, %bb4 ]

        mov     x12, x12
        //bb3:  %r154 = phi i32 [ %r152, %bb11 ], [ %r156, %bb4 ]

        mov     x11, x11
        b     bb3
        //bb5:

bb5:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r196->x9
        //%r195->x9
        //%r185->x9
        //%r184->x9
        //%r183->x10
        //%r182->x9
        //%r197->x9
        //%r139->x9
        //%r198->x9
        //%r194->x10
        //%r165->x9
        //%r142->x9
        //%r181->x10
        //%r186->x9
        //%r157->x9
        //%r187->x9
        //%r158->x9
        //%r188->x9
        //%r159->x9
        //%r189->x9
        //%r160->x9
        //%r190->x9
        //%r161->x9
        //%r191->x9
        //%r162->x9
        //%r192->x9
        //%r163->x11
        //%r193->x9
        //%r164->x9
        //%r180->x9
main:

        //131:x29,#-8

        //bb6:

bb6:

        //  call void @putint(i32 100)

        mov     x16, #32
        sub     sp, sp, x16
        mov     x9, #100
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  store i32 4, i32* @N

        mov     x10, #4
        adr     x9, N
        str     x10, [x9]
        //  store i32 10, i32* @newline

        mov     x10, #10
        adr     x9, newline
        str     x10, [x9]
        //  %r157 = add i32 0, 0

        mov     x9, #0
        //  %r158 = add i32 0, 0

        mov     x9, #0
        //  %r131 = alloca [ 4 x i32 ]

        //  %r160 = add i32 1478, 0

        mov     x9, #1478
        mov     x9, x9
        //  call void @putint(i32 %r160)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r161 = call i32 @split(i32 %r160, i32* %r131)

        mov     x0, x9
        mov     x9, #-8
        add     x9, x29, x9
        mov     x1, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     split
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r159 = add i32 0, 0

        mov     x9, #0
        //  %r162 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb7


        //bb7:  %r163 = phi i32 [ %r162, %bb6 ], [ %r165, %bb8 ]

        mov     x11, x9
        b     bb7
        //bb7:

bb7:

        //  %r163 = phi i32 [ %r162, %bb6 ], [ %r165, %bb8 ]

        //  %r137 = icmp slt i32 %r163, 4

        mov     x9, #4
        cmp     x11, x9
        //  br i1 %r137, label %bb8, label %bb9


        b.lt     bb8
        b     bb9
        //bb8:

bb8:

        //  %r139 = getelementptr [4 x i32 ], [4 x i32 ]* %r131, i32 0 , i32 %r163

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-8
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r164 = load i32, i32* %r139

        ldr     x9, [x9]
        //  call void @putint(i32 %r164)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putint
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r142 = load i32, i32* @newline

        adr     x9, newline
        ldr     x9, [x9]
        //  call void @putch(i32 %r142)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x15, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        stp     x25, x26, [sp, #-16]!
        stp     x27, x28, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x27, x28, [sp], #16
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r165 = add i32 %r163, 1

        add     x9, x11, #1
        //  br label %bb7


        //bb7:  %r163 = phi i32 [ %r162, %bb6 ], [ %r165, %bb8 ]

        mov     x11, x9
        b     bb7
        //bb9:

bb9:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
