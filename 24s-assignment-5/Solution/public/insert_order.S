.section .data
.global    N
N:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global insert
.global main
        //%r186->x12
        //%r185->x12
        //%r126->x12
        //%r183->x9
        //%r124->x13
        //%r180->x9
        //%r179->x9
        //%r168->x12
        //%r167->x13
        //%r108->x12
        //%r164->x9
        //%r163->x9
        //%r162->x10
        //%r184->x12
        //%r165->x12
        //%r107->x12
        //%r166->x14
        //%r101->x10
        //%r160->x9
        //%r159->x9
        //%r100->x11
        //%r169->x9
        //%r111->x12
        //%r182->x9
        //%r123->x12
        //%r181->x9
        //%r129->x12
        //%r188->x12
        //%r158->x9
        //%r161->x9
        //%r187->x12
        //%r189->x12
        //%r190->x12
        //%r191->x12
        //%r192->x12
        //%r193->x12
        //%r194->x9
insert:

        //bb13:

bb13:

        //  %r158 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, x1
        mov     x9, #0
        //  %r159 = add i32 0, 0

        mov     x9, #0
        //  %r160 = add i32 0, 0

        mov     x9, #0
        //  %r161 = add i32 0, 0

        mov     x9, #0
        //  %r162 = add i32 %r101, 0

        mov     x10, x10
        //  %r163 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb2


        //bb2:  %r164 = phi i32 [ %r163, %bb13 ], [ %r169, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb2:

bb2:

        //  %r164 = phi i32 [ %r163, %bb13 ], [ %r169, %bb3 ]

        //  %r107 = getelementptr i32, i32* %r100, i32 %r164

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        //  %r108 = load i32, i32* %r107

        ldr     x12, [x12]
        //  %r109 = icmp sgt i32 %r162, %r108

        cmp     x10, x12
        //  br i1 %r109, label %bb5, label %bb4


        b.gt     bb5
        b     bb4
        //bb5:

bb5:

        //  %r111 = load i32, i32* @N

        adrp     x12, N
        add     x12, x12, #:lo12:N
        ldr     x12, [x12]
        //  %r112 = icmp slt i32 %r164, %r111

        cmp     x9, x12
        //  br i1 %r112, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r169 = add i32 %r164, 1

        add     x9, x9, #1
        //  br label %bb2


        //bb2:  %r164 = phi i32 [ %r163, %bb13 ], [ %r169, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb4:

bb4:

        //  %r165 = load i32, i32* @N

        adrp     x12, N
        add     x12, x12, #:lo12:N
        ldr     x12, [x12]
        //  br label %bb6


        //bb6:  %r166 = phi i32 [ %r165, %bb4 ], [ %r168, %bb7 ]

        mov     x14, x12
        b     bb6
        //bb6:

bb6:

        //  %r166 = phi i32 [ %r165, %bb4 ], [ %r168, %bb7 ]

        //  %r118 = icmp sgt i32 %r166, %r164

        cmp     x14, x9
        //  br i1 %r118, label %bb7, label %bb8


        b.gt     bb7
        b     bb8
        //bb7:

bb7:

        //  %r167 = sub i32 %r166, 1

        sub     x13, x14, #1
        //  %r123 = getelementptr i32, i32* %r100, i32 %r167

        mov     x12, #8
        mul     x12, x13, x12
        add     x12, x11, x12
        //  %r124 = load i32, i32* %r123

        ldr     x13, [x12]
        //  %r126 = getelementptr i32, i32* %r100, i32 %r166

        mov     x12, #8
        mul     x12, x14, x12
        add     x12, x11, x12
        //  store i32 %r124, i32* %r126

        str     x13, [x12]
        //  %r129 = getelementptr i32, i32* %r100, i32 %r164

        mov     x12, #8
        mul     x12, x9, x12
        add     x12, x11, x12
        //  store i32 %r162, i32* %r129

        str     x10, [x12]
        //  %r168 = sub i32 %r166, 1

        sub     x12, x14, #1
        //  br label %bb6


        //bb6:  %r166 = phi i32 [ %r165, %bb4 ], [ %r168, %bb7 ]

        mov     x14, x12
        b     bb6
        //bb8:

bb8:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r228->x10
        //%r227->x9
        //%r226->x9
        //%r225->x9
        //%r224->x10
        //%r223->x9
        //%r222->x10
        //%r221->x9
        //%r220->x9
        //%r219->x9
        //%r218->x10
        //%r217->x9
        //%r216->x10
        //%r215->x9
        //%r214->x9
        //%r213->x9
        //%r212->x10
        //%r210->x10
        //%r209->x9
        //%r207->x9
        //%r206->x10
        //%r205->x9
        //%r204->x10
        //%r203->x9
        //%r229->x9
        //%r170->x9
        //%r230->x10
        //%r171->x9
        //%r141->x10
        //%r268->x9
        //%r200->x10
        //%r199->x9
        //%r140->x10
        //%r267->x9
        //%r211->x9
        //%r152->x9
        //%r198->x10
        //%r139->x10
        //%r266->x9
        //%r197->x9
        //%r138->x10
        //%r265->x10
        //%r196->x10
        //%r137->x10
        //%r264->x9
        //%r208->x9
        //%r149->x9
        //%r178->x9
        //%r195->x9
        //%r136->x10
        //%r263->x9
        //%r135->x10
        //%r262->x9
        //%r134->x10
        //%r261->x9
        //%r133->x10
        //%r260->x9
        //%r231->x9
        //%r172->x11
        //%r142->x10
        //%r269->x9
        //%r201->x9
        //%r232->x9
        //%r173->x10
        //%r202->x9
        //%r174->x9
        //%r175->x11
        //%r176->x9
        //%r177->x9
        //%r233->x9
        //%r234->x10
        //%r235->x9
        //%r236->x10
        //%r237->x9
        //%r238->x9
        //%r239->x9
        //%r240->x10
        //%r241->x9
        //%r242->x10
        //%r243->x9
        //%r244->x9
        //%r245->x9
        //%r246->x10
        //%r247->x9
        //%r248->x10
        //%r249->x9
        //%r250->x9
        //%r251->x9
        //%r252->x10
        //%r253->x9
        //%r254->x10
        //%r255->x9
        //%r256->x9
        //%r257->x9
        //%r258->x9
        //%r259->x9
        //%r270->x9
main:

        //132:x29,#-88

        //bb9:

bb9:

        //  call void @_sysy_starttime(i32 27)

        mov     x16, #96
        sub     sp, sp, x16
        mov     x9, #27
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
        //  store i32 10, i32* @N

        mov     x10, #10
        adrp     x9, N
        add     x9, x9, #:lo12:N
        str     x10, [x9]
        //  %r132 = alloca [ 11 x i32 ]

        //  %r133 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r133

        mov     x9, #1
        str     x9, [x10]
        //  %r134 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 1

        mov     x10, #1
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 3, i32* %r134

        mov     x9, #3
        str     x9, [x10]
        //  %r135 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 2

        mov     x10, #2
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 4, i32* %r135

        mov     x9, #4
        str     x9, [x10]
        //  %r136 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 7, i32* %r136

        mov     x9, #7
        str     x9, [x10]
        //  %r137 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 4

        mov     x10, #4
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 8, i32* %r137

        mov     x9, #8
        str     x9, [x10]
        //  %r138 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 5

        mov     x10, #5
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 11, i32* %r138

        mov     x9, #11
        str     x9, [x10]
        //  %r139 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 6

        mov     x10, #6
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 13, i32* %r139

        mov     x9, #13
        str     x9, [x10]
        //  %r140 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 7

        mov     x10, #7
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 18, i32* %r140

        mov     x9, #18
        str     x9, [x10]
        //  %r141 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 8

        mov     x10, #8
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 56, i32* %r141

        mov     x9, #56
        str     x9, [x10]
        //  %r142 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 9

        mov     x10, #9
        mov     x9, #8
        mul     x10, x10, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 78, i32* %r142

        mov     x9, #78
        str     x9, [x10]
        //  %r170 = add i32 0, 0

        mov     x9, #0
        //  %r171 = add i32 0, 0

        mov     x9, #0
        //  %r172 = add i32 0, 0

        mov     x9, #0
        mov     x11, x9
        //  %r173 = call i32 @getint()

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
        bl     getint
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r174 = call i32 @insert(i32* %r132, i32 %r173)

        mov     x9, #-88
        add     x9, x29, x9
        mov     x0, x9
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
        bl     insert
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb10


        //bb10:  %r175 = phi i32 [ %r172, %bb9 ], [ %r178, %bb11 ]

        mov     x11, x11
        b     bb10
        //bb10:

bb10:

        //  %r175 = phi i32 [ %r172, %bb9 ], [ %r178, %bb11 ]

        //  %r149 = load i32, i32* @N

        adrp     x9, N
        add     x9, x9, #:lo12:N
        ldr     x9, [x9]
        //  %r150 = icmp slt i32 %r175, %r149

        cmp     x11, x9
        //  br i1 %r150, label %bb11, label %bb12


        b.lt     bb11
        b     bb12
        //bb11:

bb11:

        //  %r152 = getelementptr [11 x i32 ], [11 x i32 ]* %r132, i32 0 , i32 %r175

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-88
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r176 = load i32, i32* %r152

        ldr     x9, [x9]
        //  call void @putint(i32 %r176)

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
        //  %r177 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  call void @putch(i32 %r177)

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
        //  %r178 = add i32 %r175, 1

        add     x9, x11, #1
        //  br label %bb10


        //bb10:  %r175 = phi i32 [ %r172, %bb9 ], [ %r178, %bb11 ]

        mov     x11, x9
        b     bb10
        //bb12:

bb12:

        //  call void @_sysy_stoptime(i32 54)

        mov     x9, #54
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
