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
mod:

        //bb10:

bb10:

        //  %r145 = add i32 0, 0

        sub     sp, sp, #0
        mov     x100, x0
        mov     x102, x1
        mov     x166, #0
        mov     x145, x166
        //  %r147 = add i32 %r100, 0

        mov     x147, x100
        //  %r146 = add i32 0, 0

        mov     x167, #0
        mov     x146, x167
        //  %r148 = add i32 %r102, 0

        mov     x148, x102
        //  %r107 = sdiv i32 %r147, %r148

        sdiv     x107, x147, x148
        //  %r109 = mul i32 %r107, %r148

        mul     x109, x107, x148
        //  %r110 = sub i32 %r147, %r109

        sub     x110, x147, x109
        //  ret i32 %r110

        mov     x0, x110
        mov     sp, x29
        ret
split:

        //bb11:

bb11:

        //  %r149 = add i32 0, 0

        sub     sp, sp, #0
        mov     x111, x0
        mov     x113, x1
        mov     x168, #0
        mov     x149, x168
        //  %r150 = add i32 0, 0

        mov     x169, #0
        mov     x150, x169
        //  %r151 = add i32 %r111, 0

        mov     x151, x111
        //  %r115 = load i32, i32* @N

        adr     x170, N
        ldr     x115, [x170]
        //  %r152 = sub i32 %r115, 1

        sub     x152, x115, #1
        //  br label %bb3


        //bb3:  %r153 = phi i32 [ %r151, %bb11 ], [ %r155, %bb4 ]

        mov     x153, x151
        //bb3:  %r154 = phi i32 [ %r152, %bb11 ], [ %r156, %bb4 ]

        mov     x154, x152
        b     bb3
        //bb3:

bb3:

        //  %r153 = phi i32 [ %r151, %bb11 ], [ %r155, %bb4 ]

        //  %r154 = phi i32 [ %r152, %bb11 ], [ %r156, %bb4 ]

        //  %r118 = sub i32 0, 1

        mov     x171, #0
        sub     x118, x171, #1
        //  %r119 = icmp ne i32 %r154, %r118

        cmp     x154, x118
        //  br i1 %r119, label %bb4, label %bb5


        b.ne     bb4
        b     bb5
        //bb4:

bb4:

        //  %r121 = call i32 @mod(i32 %r153, i32 10)

        mov     x0, x153
        mov     x172, #10
        mov     x1, x172
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
        //  %r123 = getelementptr i32, i32* %r113, i32 %r154

        mov     x173, #8
        mul     x174, x154, x173
        add     x123, x113, x174
        //  store i32 %r0, i32* %r123

        str     x0, [x123]
        //  %r155 = sdiv i32 %r153, 10

        mov     x175, #10
        sdiv     x155, x153, x175
        //  call void @putint(i32 %r155)

        mov     x0, x155
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

        mov     x176, #10
        mov     x0, x176
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

        sub     x156, x154, #1
        //  call void @putint(i32 1)

        mov     x177, #1
        mov     x0, x177
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

        mov     x178, #10
        mov     x0, x178
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

        mov     x153, x155
        //bb3:  %r154 = phi i32 [ %r152, %bb11 ], [ %r156, %bb4 ]

        mov     x154, x156
        b     bb3
        //bb5:

bb5:

        //  ret i32 0

        mov     x179, #0
        mov     x0, x179
        mov     sp, x29
        ret
main:

        //131:x29,#-8

        //bb6:

bb6:

        //  call void @putint(i32 100)

        sub     sp, sp, #32
        mov     x180, #100
        mov     x0, x180
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

        mov     x181, #4
        adr     x182, N
        str     x181, [x182]
        //  store i32 10, i32* @newline

        mov     x183, #10
        adr     x184, newline
        str     x183, [x184]
        //  %r157 = add i32 0, 0

        mov     x185, #0
        mov     x157, x185
        //  %r158 = add i32 0, 0

        mov     x186, #0
        mov     x158, x186
        //  %r131 = alloca [ 4 x i32 ]

        //  %r160 = add i32 1478, 0

        mov     x187, #1478
        mov     x160, x187
        //  call void @putint(i32 %r160)

        mov     x0, x160
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

        mov     x0, x160
        mov     x188, #-8
        add     x189, x29, x188
        mov     x1, x189
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

        mov     x190, #0
        mov     x159, x190
        //  %r162 = add i32 0, 0

        mov     x191, #0
        mov     x162, x191
        //  br label %bb7


        //bb7:  %r163 = phi i32 [ %r162, %bb6 ], [ %r165, %bb8 ]

        mov     x163, x162
        b     bb7
        //bb7:

bb7:

        //  %r163 = phi i32 [ %r162, %bb6 ], [ %r165, %bb8 ]

        //  %r137 = icmp slt i32 %r163, 4

        mov     x192, #4
        cmp     x163, x192
        //  br i1 %r137, label %bb8, label %bb9


        b.lt     bb8
        b     bb9
        //bb8:

bb8:

        //  %r139 = getelementptr [4 x i32 ], [4 x i32 ]* %r131, i32 0 , i32 %r163

        mov     x193, #8
        mul     x194, x163, x193
        mov     x195, #-8
        add     x196, x29, x195
        add     x139, x196, x194
        //  %r164 = load i32, i32* %r139

        ldr     x164, [x139]
        //  call void @putint(i32 %r164)

        mov     x0, x164
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

        adr     x197, newline
        ldr     x142, [x197]
        //  call void @putch(i32 %r142)

        mov     x0, x142
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

        add     x165, x163, #1
        //  br label %bb7


        //bb7:  %r163 = phi i32 [ %r162, %bb6 ], [ %r165, %bb8 ]

        mov     x163, x165
        b     bb7
        //bb9:

bb9:

        //  ret i32 0

        mov     x198, #0
        mov     x0, x198
        mov     sp, x29
        ret
