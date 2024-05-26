.section .data
.global    TAPE_LEN
.global    BUFFER_LEN
.global    tape
.global    program
.global    ptr
TAPE_LEN:
        .quad   65536
BUFFER_LEN:
        .quad   32768
tape:
        .zero   524288
program:
        .zero   262144
ptr:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global read_program
.global interpret
.global main
        //%r206->x9
        //%r205->x9
        //%r204->x9
        //%r185->x9
        //%r183->x11
        //%r212->x9
        //%r182->x9
        //%r211->x10
        //%r207->x12
        //%r181->x9
        //%r210->x10
        //%r112->x10
        //%r186->x9
        //%r108->x12
        //%r184->x10
        //%r213->x9
        //%r106->x11
        //%r208->x13
        //%r209->x12
read_program:

        //bb1:

bb1:

        //  %r181 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r183 = add i32 0, 0

        mov     x9, #0
        mov     x11, x9
        //  %r182 = add i32 0, 0

        mov     x9, #0
        //  %r184 = call i32 @getint()

        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getint
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  br label %bb2


        //bb2:  %r185 = phi i32 [ %r183, %bb1 ], [ %r186, %bb3 ]

        mov     x9, x11
        b     bb2
        //bb2:

bb2:

        //  %r185 = phi i32 [ %r183, %bb1 ], [ %r186, %bb3 ]

        //  %r105 = icmp slt i32 %r185, %r184

        cmp     x9, x10
        //  br i1 %r105, label %bb3, label %bb4


        b.lt     bb3
        b     bb4
        //bb3:

bb3:

        //  %r106 = call i32 @getch()

        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r108 = getelementptr [32768 x i32 ], [32768 x i32 ]* @program, i32 0, i32 %r185

        mov     x12, #8
        mul     x13, x9, x12
        adrp     x12, program
        add     x12, x12, #:lo12:program
        add     x12, x12, x13
        //  store i32 %r106, i32* %r108

        str     x11, [x12]
        //  %r186 = add i32 %r185, 1

        add     x9, x9, #1
        //  br label %bb2


        //bb2:  %r185 = phi i32 [ %r183, %bb1 ], [ %r186, %bb3 ]

        mov     x9, x9
        b     bb2
        //bb4:

bb4:

        //  %r112 = getelementptr [32768 x i32 ], [32768 x i32 ]* @program, i32 0, i32 %r185

        mov     x10, #8
        mul     x10, x9, x10
        adrp     x9, program
        add     x9, x9, #:lo12:program
        add     x10, x9, x10
        //  store i32 0, i32* %r112

        mov     x9, #0
        str     x9, [x10]
        //  ret void

        mov     sp, x29
        ret
        //%r225->x11
        //%r224->x11
        //%r223->x11
        //%r222->x9
        //%r218->x9
        //%r217->x9
        //%r200->x13
        //%r199->x9
        //%r192->x9
        //%r191->x10
        //%r188->x9
        //%r187->x9
        //%r169->x9
        //%r197->x10
        //%r138->x14
        //%r265->x9
        //%r196->x11
        //%r137->x11
        //%r264->x9
        //%r195->x9
        //%r136->x11
        //%r263->x9
        //%r193->x9
        //%r134->x13
        //%r261->x9
        //%r189->x9
        //%r130->x11
        //%r257->x11
        //%r127->x13
        //%r254->x13
        //%r215->x9
        //%r156->x14
        //%r194->x9
        //%r135->x11
        //%r262->x9
        //%r122->x9
        //%r249->x11
        //%r151->x11
        //%r119->x11
        //%r246->x13
        //%r190->x9
        //%r131->x13
        //%r258->x9
        //%r219->x9
        //%r160->x11
        //%r118->x9
        //%r245->x14
        //%r147->x13
        //%r126->x11
        //%r253->x13
        //%r214->x9
        //%r155->x11
        //%r113->x12
        //%r240->x11
        //%r201->x9
        //%r142->x13
        //%r198->x10
        //%r139->x13
        //%r266->x9
        //%r202->x9
        //%r143->x11
        //%r203->x11
        //%r144->x11
        //%r145->x11
        //%r146->x14
        //%r150->x13
        //%r152->x11
        //%r216->x9
        //%r157->x13
        //%r220->x9
        //%r161->x9
        //%r221->x9
        //%r162->x11
        //%r226->x11
        //%r227->x11
        //%r228->x11
        //%r229->x11
        //%r230->x11
        //%r231->x11
        //%r232->x13
        //%r233->x11
        //%r234->x13
        //%r235->x13
        //%r236->x14
        //%r237->x13
        //%r238->x11
        //%r239->x11
        //%r241->x13
        //%r242->x11
        //%r243->x13
        //%r244->x13
        //%r247->x11
        //%r248->x11
        //%r250->x13
        //%r251->x11
        //%r252->x11
        //%r255->x14
        //%r256->x13
        //%r259->x9
        //%r260->x11
        //%r267->x13
        //%r268->x11
interpret:

        //bb5:

bb5:

        //  %r187 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x12, x0
        mov     x9, #0
        //  %r188 = add i32 0, 0

        mov     x9, #0
        //  %r189 = add i32 0, 0

        mov     x9, #0
        //  %r190 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb6


        //bb6:  %r191 = phi i32 [ %r190, %bb5 ], [ %r194, %bb29 ]

        mov     x10, x9
        b     bb6
        //bb6:

bb6:

        //  %r191 = phi i32 [ %r190, %bb5 ], [ %r194, %bb29 ]

        //  %r118 = getelementptr i32, i32* %r113, i32 %r191

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        //  %r119 = load i32, i32* %r118

        ldr     x11, [x9]
        //  %r120 = icmp ne i32 %r119, 0

        mov     x9, #0
        cmp     x11, x9
        //  br i1 %r120, label %bb7, label %bb8


        b.ne     bb7
        b     bb8
        //bb7:

bb7:

        //  %r122 = getelementptr i32, i32* %r113, i32 %r191

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        //  %r192 = load i32, i32* %r122

        ldr     x9, [x9]
        //  %r125 = icmp eq i32 %r192, 62

        mov     x11, #62
        cmp     x9, x11
        //  br i1 %r125, label %bb9, label %bb10


        b.eq     bb9
        b     bb10
        //bb9:

bb9:

        //  %r126 = load i32, i32* @ptr

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     x11, [x11]
        //  %r127 = add i32 %r126, 1

        add     x13, x11, #1
        //  store i32 %r127, i32* @ptr

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        str     x13, [x11]
        //  br label %bb11


        b     bb11
        //bb10:

bb10:

        //  br label %bb11


        b     bb11
        //bb11:

bb11:

        //  %r129 = icmp eq i32 %r192, 60

        mov     x11, #60
        cmp     x9, x11
        //  br i1 %r129, label %bb12, label %bb13


        b.eq     bb12
        b     bb13
        //bb12:

bb12:

        //  %r130 = load i32, i32* @ptr

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     x11, [x11]
        //  %r131 = sub i32 %r130, 1

        sub     x13, x11, #1
        //  store i32 %r131, i32* @ptr

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        str     x13, [x11]
        //  br label %bb14


        b     bb14
        //bb13:

bb13:

        //  br label %bb14


        b     bb14
        //bb14:

bb14:

        //  %r133 = icmp eq i32 %r192, 43

        mov     x11, #43
        cmp     x9, x11
        //  br i1 %r133, label %bb15, label %bb16


        b.eq     bb15
        b     bb16
        //bb15:

bb15:

        //  %r134 = load i32, i32* @ptr

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     x13, [x11]
        //  %r135 = getelementptr [65536 x i32 ], [65536 x i32 ]* @tape, i32 0, i32 %r134

        mov     x11, #8
        mul     x13, x13, x11
        adrp     x11, tape
        add     x11, x11, #:lo12:tape
        add     x11, x11, x13
        //  %r136 = load i32, i32* %r135

        ldr     x11, [x11]
        //  %r137 = add i32 %r136, 1

        add     x11, x11, #1
        //  %r138 = load i32, i32* @ptr

        adrp     x13, ptr
        add     x13, x13, #:lo12:ptr
        ldr     x14, [x13]
        //  %r139 = getelementptr [65536 x i32 ], [65536 x i32 ]* @tape, i32 0, i32 %r138

        mov     x13, #8
        mul     x14, x14, x13
        adrp     x13, tape
        add     x13, x13, #:lo12:tape
        add     x13, x13, x14
        //  store i32 %r137, i32* %r139

        str     x11, [x13]
        //  br label %bb17


        b     bb17
        //bb16:

bb16:

        //  br label %bb17


        b     bb17
        //bb17:

bb17:

        //  %r141 = icmp eq i32 %r192, 45

        mov     x11, #45
        cmp     x9, x11
        //  br i1 %r141, label %bb18, label %bb19


        b.eq     bb18
        b     bb19
        //bb18:

bb18:

        //  %r142 = load i32, i32* @ptr

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     x13, [x11]
        //  %r143 = getelementptr [65536 x i32 ], [65536 x i32 ]* @tape, i32 0, i32 %r142

        mov     x11, #8
        mul     x13, x13, x11
        adrp     x11, tape
        add     x11, x11, #:lo12:tape
        add     x11, x11, x13
        //  %r144 = load i32, i32* %r143

        ldr     x11, [x11]
        //  %r145 = sub i32 %r144, 1

        sub     x11, x11, #1
        //  %r146 = load i32, i32* @ptr

        adrp     x13, ptr
        add     x13, x13, #:lo12:ptr
        ldr     x14, [x13]
        //  %r147 = getelementptr [65536 x i32 ], [65536 x i32 ]* @tape, i32 0, i32 %r146

        mov     x13, #8
        mul     x14, x14, x13
        adrp     x13, tape
        add     x13, x13, #:lo12:tape
        add     x13, x13, x14
        //  store i32 %r145, i32* %r147

        str     x11, [x13]
        //  br label %bb20


        b     bb20
        //bb19:

bb19:

        //  br label %bb20


        b     bb20
        //bb20:

bb20:

        //  %r149 = icmp eq i32 %r192, 46

        mov     x11, #46
        cmp     x9, x11
        //  br i1 %r149, label %bb21, label %bb22


        b.eq     bb21
        b     bb22
        //bb21:

bb21:

        //  %r150 = load i32, i32* @ptr

        adrp     x11, ptr
        add     x11, x11, #:lo12:ptr
        ldr     x13, [x11]
        //  %r151 = getelementptr [65536 x i32 ], [65536 x i32 ]* @tape, i32 0, i32 %r150

        mov     x11, #8
        mul     x13, x13, x11
        adrp     x11, tape
        add     x11, x11, #:lo12:tape
        add     x11, x11, x13
        //  %r152 = load i32, i32* %r151

        ldr     x11, [x11]
        //  call void @putch(i32 %r152)

        mov     x0, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb23


        b     bb23
        //bb22:

bb22:

        //  br label %bb23


        b     bb23
        //bb23:

bb23:

        //  %r154 = icmp eq i32 %r192, 44

        mov     x11, #44
        cmp     x9, x11
        //  br i1 %r154, label %bb24, label %bb25


        b.eq     bb24
        b     bb25
        //bb24:

bb24:

        //  %r155 = call i32 @getch()

        mov     x28, sp
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     sp, x28
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r156 = load i32, i32* @ptr

        adrp     x13, ptr
        add     x13, x13, #:lo12:ptr
        ldr     x14, [x13]
        //  %r157 = getelementptr [65536 x i32 ], [65536 x i32 ]* @tape, i32 0, i32 %r156

        mov     x13, #8
        mul     x14, x14, x13
        adrp     x13, tape
        add     x13, x13, #:lo12:tape
        add     x13, x13, x14
        //  store i32 %r155, i32* %r157

        str     x11, [x13]
        //  br label %bb26


        b     bb26
        //bb25:

bb25:

        //  br label %bb26


        b     bb26
        //bb26:

bb26:

        //  %r159 = icmp eq i32 %r192, 93

        mov     x11, #93
        cmp     x9, x11
        //  br i1 %r159, label %bb30, label %bb28


        b.eq     bb30
        b     bb28
        //bb30:

bb30:

        //  %r160 = load i32, i32* @ptr

        adrp     x9, ptr
        add     x9, x9, #:lo12:ptr
        ldr     x11, [x9]
        //  %r161 = getelementptr [65536 x i32 ], [65536 x i32 ]* @tape, i32 0, i32 %r160

        mov     x9, #8
        mul     x11, x11, x9
        adrp     x9, tape
        add     x9, x9, #:lo12:tape
        add     x9, x9, x11
        //  %r162 = load i32, i32* %r161

        ldr     x11, [x9]
        //  %r163 = icmp ne i32 %r162, 0

        mov     x9, #0
        cmp     x11, x9
        //  br i1 %r163, label %bb27, label %bb28


        b.ne     bb27
        b     bb28
        //bb27:

bb27:

        //  %r195 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  br label %bb31


        //bb31:  %r196 = phi i32 [ %r195, %bb27 ], [ %r201, %bb39 ]

        mov     x11, x9
        //bb31:  %r197 = phi i32 [ %r191, %bb27 ], [ %r198, %bb39 ]

        mov     x10, x10
        b     bb31
        //bb31:

bb31:

        //  %r196 = phi i32 [ %r195, %bb27 ], [ %r201, %bb39 ]

        //  %r197 = phi i32 [ %r191, %bb27 ], [ %r198, %bb39 ]

        //  %r165 = icmp sgt i32 %r196, 0

        mov     x9, #0
        cmp     x11, x9
        //  br i1 %r165, label %bb32, label %bb33


        b.gt     bb32
        b     bb33
        //bb32:

bb32:

        //  %r198 = sub i32 %r197, 1

        sub     x10, x10, #1
        //  %r169 = getelementptr i32, i32* %r113, i32 %r198

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x12, x9
        //  %r199 = load i32, i32* %r169

        ldr     x9, [x9]
        //  %r172 = icmp eq i32 %r199, 91

        mov     x13, #91
        cmp     x9, x13
        //  br i1 %r172, label %bb34, label %bb35


        b.eq     bb34
        b     bb35
        //bb34:

bb34:

        //  %r203 = sub i32 %r196, 1

        sub     x11, x11, #1
        //  br label %bb36


        //bb36:  %r200 = phi i32 [ %r203, %bb34 ], [ %r196, %bb35 ]

        mov     x13, x11
        b     bb36
        //bb35:

bb35:

        //  br label %bb36


        //bb36:  %r200 = phi i32 [ %r203, %bb34 ], [ %r196, %bb35 ]

        mov     x13, x11
        b     bb36
        //bb36:

bb36:

        //  %r200 = phi i32 [ %r203, %bb34 ], [ %r196, %bb35 ]

        //  %r176 = icmp eq i32 %r199, 93

        mov     x11, #93
        cmp     x9, x11
        //  br i1 %r176, label %bb37, label %bb38


        b.eq     bb37
        b     bb38
        //bb37:

bb37:

        //  %r202 = add i32 %r200, 1

        add     x9, x13, #1
        //  br label %bb39


        //bb39:  %r201 = phi i32 [ %r202, %bb37 ], [ %r200, %bb38 ]

        mov     x9, x9
        b     bb39
        //bb38:

bb38:

        //  br label %bb39


        //bb39:  %r201 = phi i32 [ %r202, %bb37 ], [ %r200, %bb38 ]

        mov     x9, x13
        b     bb39
        //bb39:

bb39:

        //  %r201 = phi i32 [ %r202, %bb37 ], [ %r200, %bb38 ]

        //  br label %bb31


        //bb31:  %r196 = phi i32 [ %r195, %bb27 ], [ %r201, %bb39 ]

        mov     x11, x9
        //bb31:  %r197 = phi i32 [ %r191, %bb27 ], [ %r198, %bb39 ]

        mov     x10, x10
        b     bb31
        //bb33:

bb33:

        //  br label %bb29


        //bb29:  %r193 = phi i32 [ %r197, %bb33 ], [ %r191, %bb28 ]

        mov     x9, x10
        b     bb29
        //bb28:

bb28:

        //  br label %bb29


        //bb29:  %r193 = phi i32 [ %r197, %bb33 ], [ %r191, %bb28 ]

        mov     x9, x10
        b     bb29
        //bb29:

bb29:

        //  %r193 = phi i32 [ %r197, %bb33 ], [ %r191, %bb28 ]

        //  %r194 = add i32 %r193, 1

        add     x9, x9, #1
        //  br label %bb6


        //bb6:  %r191 = phi i32 [ %r190, %bb5 ], [ %r194, %bb29 ]

        mov     x10, x9
        b     bb6
        //bb8:

bb8:

        //  ret void

        mov     sp, x29
        ret
        //%r269->x9
        //%r270->x9
        //%r271->x9
        //%r272->x9
        //%r273->x9
        //%r274->x9
main:

        //bb40:

bb40:

        //  call void @_sysy_starttime(i32 76)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #76
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_starttime
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @read_program()

        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     read_program
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @interpret(i32* @program)

        adrp     x9, program
        add     x9, x9, #:lo12:program
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     interpret
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @putch(i32 10)

        mov     x9, #10
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     putch
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @_sysy_stoptime(i32 80)

        mov     x9, #80
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     _sysy_stoptime
        ldp     x29, x30, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
