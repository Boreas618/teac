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

        #%r178->x9

        #%r177->x12

        #%r176->x9

        #%r175->x10

        #%r174->x9

        #%r173->x9

        #%r172->x11

        #%r170->x9

        #%r168->x14

        #%r167->x15

        #%r166->[sp,#16]

        #%r165->x9

        #%r164->x9

        #%r123->[sp,#0]

        #%r182->x10

        #%r162->x9

        #%r124->x9

        #%r183->x9

        #%r125->[sp,#8]

        #%r184->x9

        #%r163->x9

        #%r134->x9

        #%r193->x9

        #%r160->x9

        #%r169->x13

        #%r140->x10

        #%r199->x9

        #%r171->x10

        #%r142->x10

        #%r201->x9

        #%r157->x9

        #%r158->x9

        #%r130->x9

        #%r189->x9

        #%r159->x9

        #%r161->x9

        #%r179->x10

        #%r180->x11

        #%r181->x9

        #%r185->x9

        #%r186->x9

        #%r187->x9

        #%r188->x9

        #%r190->x9

        #%r191->x9

        #%r192->x9

        #%r194->x9

        #%r195->x9

        #%r196->x10

        #%r197->x10

        #%r198->x10

        #%r200->x9

        #%r202->x9

        #%r203->x9

        #%r204->x9
main:


        #bb1:
bb1:


        #  %r157 = add i32 0, 0
        mov     x16, #24
        sub     sp, sp, x16
        mov     w9, #0

        #  %r158 = add i32 0, 0
        mov     w9, #0

        #  %r159 = add i32 0, 0
        mov     w9, #0

        #  %r166 = add i32 2, 0
        mov     w9, #2
        mov     w16, w9
        mov     x17, #16
        str     x16, [sp,x17]

        #  %r160 = add i32 0, 0
        mov     w9, #0

        #  %r167 = add i32 3, 0
        mov     w9, #3
        mov     w15, w9

        #  %r161 = add i32 0, 0
        mov     w9, #0

        #  %r162 = add i32 0, 0
        mov     w9, #0

        #  %r163 = add i32 0, 0
        mov     w9, #0

        #  %r168 = add i32 5381, 0
        mov     w9, #5381
        mov     w14, w9

        #  %r169 = call i32 @getint()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w13, w0

        #  %r170 = add i32 %r166, %r167
        mov     x16, #16
        ldr     x19, [sp,x16]
        add     w9, w19, w15

        #  %r164 = add i32 0, 0
        mov     w10, #0

        #  %r165 = add i32 0, 0
        mov     w10, #0

        #  %r171 = add i32 0, 0
        mov     w10, #0
        mov     w10, w10

        #  %r113 = icmp sgt i32 %r169, %r170
        cmp     w13, w9

        #  br i1 %r113, label %bb2, label %bb3

        b.gt     bb2
        b     bb3

        #bb2:
bb2:


        #  %r177 = sub i32 %r169, %r170
        sub     w12, w13, w9

        #  %r178 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb5


        #bb5:  %r179 = phi i32 [ %r171, %bb2 ], [ %r182, %bb10 ]
        mov     w10, w10

        #bb5:  %r180 = phi i32 [ %r178, %bb2 ], [ %r183, %bb10 ]
        mov     w11, w9
        b     bb5

        #bb5:
bb5:


        #  %r179 = phi i32 [ %r171, %bb2 ], [ %r182, %bb10 ]

        #  %r180 = phi i32 [ %r178, %bb2 ], [ %r183, %bb10 ]

        #  %r120 = icmp slt i32 %r180, %r177
        cmp     w11, w12

        #  br i1 %r120, label %bb6, label %bb7

        b.lt     bb6
        b     bb7

        #bb6:
bb6:


        #  %r123 = sdiv i32 %r180, 2
        mov     w9, #2
        sdiv     w16, w11, w9
        mov     x17, #0
        str     x16, [sp,x17]

        #  %r124 = mul i32 %r123, 2
        mov     w9, #2
        mov     x16, #0
        ldr     x19, [sp,x16]
        mul     w9, w19, w9

        #  %r125 = sub i32 %r180, %r124
        sub     w16, w11, w9
        mov     x17, #8
        str     x16, [sp,x17]

        #  %r126 = icmp eq i32 %r125, 0
        mov     w9, #0
        mov     x16, #8
        ldr     x19, [sp,x16]
        cmp     w19, w9

        #  br i1 %r126, label %bb8, label %bb9

        b.eq     bb8
        b     bb9

        #bb8:
bb8:


        #  %r130 = mul i32 %r166, %r167
        mov     x16, #16
        ldr     x19, [sp,x16]
        mul     w9, w19, w15

        #  %r185 = add i32 %r179, %r130
        add     w9, w10, w9

        #  br label %bb10


        #bb10:  %r181 = phi i32 [ %r185, %bb8 ], [ %r184, %bb9 ]
        mov     w9, w9
        b     bb10

        #bb9:
bb9:


        #  %r134 = add i32 %r179, %r167
        add     w9, w10, w15

        #  %r184 = add i32 %r134, %r169
        add     w9, w9, w13

        #  br label %bb10


        #bb10:  %r181 = phi i32 [ %r185, %bb8 ], [ %r184, %bb9 ]
        mov     w9, w9
        b     bb10

        #bb10:
bb10:


        #  %r181 = phi i32 [ %r185, %bb8 ], [ %r184, %bb9 ]

        #  %r140 = sdiv i32 %r181, %r168
        sdiv     w10, w9, w14

        #  %r142 = mul i32 %r140, %r168
        mul     w10, w10, w14

        #  %r182 = sub i32 %r181, %r142
        sub     w10, w9, w10

        #  %r183 = add i32 %r180, 1
        add     w9, w11, #1

        #  br label %bb5


        #bb5:  %r179 = phi i32 [ %r171, %bb2 ], [ %r182, %bb10 ]
        mov     w10, w10

        #bb5:  %r180 = phi i32 [ %r178, %bb2 ], [ %r183, %bb10 ]
        mov     w11, w9
        b     bb5

        #bb7:
bb7:


        #  br label %bb4


        #bb4:  %r172 = phi i32 [ %r179, %bb7 ], [ %r176, %bb3 ]
        mov     w11, w10

        #bb4:  %r173 = phi i32 [ %r177, %bb7 ], [ %r175, %bb3 ]
        mov     w9, w12
        b     bb4

        #bb3:
bb3:


        #  %r175 = sub i32 %r170, %r169
        sub     w10, w9, w13

        #  %r176 = mul i32 %r166, %r169
        mov     x16, #16
        ldr     x19, [sp,x16]
        mul     w9, w19, w13

        #  br label %bb4


        #bb4:  %r172 = phi i32 [ %r179, %bb7 ], [ %r176, %bb3 ]
        mov     w11, w9

        #bb4:  %r173 = phi i32 [ %r177, %bb7 ], [ %r175, %bb3 ]
        mov     w9, w10
        b     bb4

        #bb4:
bb4:


        #  %r172 = phi i32 [ %r179, %bb7 ], [ %r176, %bb3 ]

        #  %r173 = phi i32 [ %r177, %bb7 ], [ %r175, %bb3 ]

        #  %r174 = add i32 %r172, %r173
        add     w9, w11, w9

        #  call void @putint(i32 %r174)
        mov     w0, w9
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

        #  call void @putch(i32 10)
        mov     w9, #10
        mov     w0, w9
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

        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
