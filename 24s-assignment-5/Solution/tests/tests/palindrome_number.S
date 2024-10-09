.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global mod
.global palindrome
.global main
        //%r100->x10
        //%r102->x11
        //%r107->x11
        //%r146->x9
        //%r109->x9
        //%r148->x10
        //%r110->x9
        //%r149->x9
        //%r147->x9
        //%r168->x9
        //%r169->x9
mod:

        //bb14:

bb14:

        //  %r146 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r148 = add i32 %r100, 0

        mov     x10, x10
        //  %r147 = add i32 0, 0

        mov     x9, #0
        //  %r149 = add i32 %r102, 0

        mov     x9, x11
        //  %r107 = sdiv i32 %r148, %r149

        sdiv     x11, x10, x9
        //  %r109 = mul i32 %r107, %r149

        mul     x9, x11, x9
        //  %r110 = sub i32 %r148, %r109

        sub     x9, x10, x9
        //  ret i32 %r110

        mov     x0, x9
        mov     sp, x29
        ret
        //%r175->x11
        //%r174->x11
        //%r173->x9
        //%r172->x9
        //%r171->x9
        //%r170->x9
        //%r111->x10
        //%r159->x9
        //%r154->x9
        //%r153->x10
        //%r152->x9
        //%r119->x11
        //%r178->x12
        //%r161->x9
        //%r132->x9
        //%r191->x10
        //%r150->x9
        //%r121->x12
        //%r180->x11
        //%r134->x10
        //%r193->x10
        //%r155->x10
        //%r126->x9
        //%r185->x9
        //%r156->x9
        //%r127->x9
        //%r186->x11
        //%r157->x9
        //%r128->x10
        //%r187->x10
        //%r158->x9
        //%r129->x10
        //%r188->x11
        //%r160->x10
        //%r131->x9
        //%r190->x10
        //%r133->x10
        //%r192->x9
        //%r151->x9
        //%r176->x12
        //%r177->x13
        //%r179->x12
        //%r181->x10
        //%r182->x9
        //%r183->x10
        //%r184->x9
        //%r189->x10
        //%r194->x9
        //%r195->x9
        //%r196->x11
        //%r197->x10
        //%r198->x11
        //%r199->x10
        //%r200->x10
        //%r201->x9
        //%r202->x9
palindrome:

        //113:x29,#-32

        //bb15:

bb15:

        //  %r150 = add i32 0, 0

        mov     x16, #32
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r151 = add i32 0, 0

        mov     x9, #0
        //  %r113 = alloca [ 4 x i32 ]

        //  %r152 = add i32 0, 0

        mov     x9, #0
        //  %r153 = add i32 %r111, 0

        mov     x10, x10
        //  %r154 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb3


        //bb3:  %r155 = phi i32 [ %r153, %bb15 ], [ %r160, %bb4 ]

        mov     x10, x10
        //bb3:  %r156 = phi i32 [ %r154, %bb15 ], [ %r161, %bb4 ]

        mov     x9, x9
        b     bb3
        //bb3:

bb3:

        //  %r155 = phi i32 [ %r153, %bb15 ], [ %r160, %bb4 ]

        //  %r156 = phi i32 [ %r154, %bb15 ], [ %r161, %bb4 ]

        //  %r117 = icmp slt i32 %r156, 4

        mov     x11, #4
        cmp     x9, x11
        //  br i1 %r117, label %bb4, label %bb5


        b.lt     bb4
        b     bb5
        //bb4:

bb4:

        //  %r119 = call i32 @mod(i32 %r155, i32 10)

        mov     x0, x10
        mov     x11, #10
        mov     x1, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     mod
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r121 = getelementptr [4 x i32 ], [4 x i32 ]* %r113, i32 0 , i32 %r156

        mov     x12, #8
        mul     x13, x9, x12
        mov     x12, #-32
        add     x12, x29, x12
        add     x12, x12, x13
        //  store i32 %r119, i32* %r121

        str     x11, [x12]
        //  %r160 = sdiv i32 %r155, 10

        mov     x11, #10
        sdiv     x10, x10, x11
        //  %r161 = add i32 %r156, 1

        add     x9, x9, #1
        //  br label %bb3


        //bb3:  %r155 = phi i32 [ %r153, %bb15 ], [ %r160, %bb4 ]

        mov     x10, x10
        //bb3:  %r156 = phi i32 [ %r154, %bb15 ], [ %r161, %bb4 ]

        mov     x9, x9
        b     bb3
        //bb5:

bb5:

        //  %r126 = getelementptr [4 x i32 ], [4 x i32 ]* %r113, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-32
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r127 = load i32, i32* %r126

        ldr     x9, [x9]
        //  %r128 = getelementptr [4 x i32 ], [4 x i32 ]* %r113, i32 0 , i32 3

        mov     x11, #3
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-32
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r129 = load i32, i32* %r128

        ldr     x10, [x10]
        //  %r130 = icmp eq i32 %r127, %r129

        cmp     x9, x10
        //  br i1 %r130, label %bb9, label %bb7


        b.eq     bb9
        b     bb7
        //bb9:

bb9:

        //  %r131 = getelementptr [4 x i32 ], [4 x i32 ]* %r113, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-32
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r132 = load i32, i32* %r131

        ldr     x9, [x9]
        //  %r133 = getelementptr [4 x i32 ], [4 x i32 ]* %r113, i32 0 , i32 2

        mov     x11, #2
        mov     x10, #8
        mul     x11, x11, x10
        mov     x10, #-32
        add     x10, x29, x10
        add     x10, x10, x11
        //  %r134 = load i32, i32* %r133

        ldr     x10, [x10]
        //  %r135 = icmp eq i32 %r132, %r134

        cmp     x9, x10
        //  br i1 %r135, label %bb6, label %bb7


        b.eq     bb6
        b     bb7
        //bb6:

bb6:

        //  %r159 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb8


        //bb8:  %r157 = phi i32 [ %r159, %bb6 ], [ %r158, %bb7 ]

        mov     x9, x9
        b     bb8
        //bb7:

bb7:

        //  %r158 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb8


        //bb8:  %r157 = phi i32 [ %r159, %bb6 ], [ %r158, %bb7 ]

        mov     x9, x9
        b     bb8
        //bb8:

bb8:

        //  %r157 = phi i32 [ %r159, %bb6 ], [ %r158, %bb7 ]

        //  ret i32 %r157

        mov     x0, x9
        mov     sp, x29
        ret
        //%r209->x9
        //%r208->x9
        //%r207->x9
        //%r206->x9
        //%r167->x9
        //%r205->x9
        //%r166->x9
        //%r204->x9
        //%r165->x10
        //%r203->x9
        //%r164->x11
        //%r163->x9
        //%r162->x9
        //%r210->x9
        //%r211->x9
main:

        //bb10:

bb10:

        //  call void @_sysy_starttime(i32 30)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #30
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
        //  %r162 = add i32 0, 0

        mov     x9, #0
        //  %r164 = add i32 1221, 0

        mov     x9, #1221
        mov     x11, x9
        //  %r163 = add i32 0, 0

        mov     x9, #0
        //  %r165 = call i32 @palindrome(i32 %r164)

        mov     x0, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     palindrome
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r142 = icmp eq i32 %r165, 1

        mov     x9, #1
        cmp     x10, x9
        //  br i1 %r142, label %bb11, label %bb12


        b.eq     bb11
        b     bb12
        //bb11:

bb11:

        //  call void @putint(i32 %r164)

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
        //  br label %bb13


        b     bb13
        //bb12:

bb12:

        //  %r167 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  call void @putint(i32 %r167)

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
        //  br label %bb13


        b     bb13
        //bb13:

bb13:

        //  %r166 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  call void @putch(i32 %r166)

        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @_sysy_stoptime(i32 47)

        mov     x9, #47
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
