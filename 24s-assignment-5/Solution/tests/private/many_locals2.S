.section .data
.global    n
n:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global main
        //%r288->x15
        //%r287->[sp,#184]
        //%r286->[sp,#176]
        //%r285->[sp,#168]
        //%r284->[sp,#160]
        //%r283->[sp,#152]
        //%r282->[sp,#144]
        //%r281->[sp,#136]
        //%r280->[sp,#128]
        //%r279->[sp,#120]
        //%r278->[sp,#112]
        //%r277->[sp,#104]
        //%r276->[sp,#96]
        //%r275->[sp,#88]
        //%r274->[sp,#80]
        //%r273->[sp,#72]
        //%r272->[sp,#64]
        //%r271->[sp,#56]
        //%r270->[sp,#48]
        //%r269->[sp,#40]
        //%r268->[sp,#32]
        //%r267->[sp,#24]
        //%r266->[sp,#16]
        //%r265->[sp,#8]
        //%r264->[sp,#0]
        //%r263->x9
        //%r262->x9
        //%r261->x9
        //%r260->x9
        //%r259->x9
        //%r242->x9
        //%r241->x9
        //%r240->x9
        //%r239->x9
        //%r238->x9
        //%r237->x9
        //%r236->x9
        //%r235->x9
        //%r234->x9
        //%r233->x9
        //%r232->x9
        //%r231->x9
        //%r230->x9
        //%r243->x9
        //%r244->x9
        //%r245->x9
        //%r246->x9
        //%r247->x9
        //%r248->x9
        //%r249->x9
        //%r250->x9
        //%r251->x9
        //%r252->x9
        //%r253->x9
        //%r254->x9
        //%r255->x9
        //%r256->x9
        //%r257->x9
        //%r258->x9
        //%r289->x14
        //%r290->x13
        //%r291->x12
        //%r292->x11
        //%r293->x10
        //%r294->x9
        //%r295->x9
        //%r296->x9
        //%r297->x9
        //%r298->x9
        //%r299->x9
        //%r300->x9
        //%r301->x9
        //%r302->x9
        //%r303->x9
        //%r304->x9
        //%r305->x9
        //%r306->x9
        //%r307->x9
        //%r308->x9
        //%r309->x9
        //%r310->x9
        //%r311->x9
        //%r312->x9
        //%r313->x9
        //%r314->x9
        //%r315->x9
        //%r316->x9
        //%r317->x9
        //%r318->x9
        //%r319->x9
        //%r320->x9
        //%r321->x9
        //%r322->x9
        //%r323->x9
        //%r324->x9
        //%r325->x9
        //%r326->x9
        //%r327->x9
        //%r328->x9
        //%r329->x9
        //%r330->x9
        //%r331->x9
        //%r332->x9
        //%r333->x9
        //%r334->x9
main:

        //bb1:

bb1:

        //  %r230 = add i32 0, 0

        mov     x16, #192
        sub     sp, sp, x16
        mov     x9, #0
        //  %r231 = add i32 0, 0

        mov     x9, #0
        //  call void @_sysy_starttime(i32 4)

        mov     x9, #4
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
        //  %r232 = add i32 0, 0

        mov     x9, #0
        //  %r233 = add i32 0, 0

        mov     x9, #0
        //  %r234 = add i32 0, 0

        mov     x9, #0
        //  %r235 = add i32 0, 0

        mov     x9, #0
        //  %r236 = add i32 0, 0

        mov     x9, #0
        //  %r237 = add i32 0, 0

        mov     x9, #0
        //  %r238 = add i32 0, 0

        mov     x9, #0
        //  %r239 = add i32 0, 0

        mov     x9, #0
        //  %r240 = add i32 0, 0

        mov     x9, #0
        //  %r241 = add i32 0, 0

        mov     x9, #0
        //  %r242 = add i32 0, 0

        mov     x9, #0
        //  %r243 = add i32 0, 0

        mov     x9, #0
        //  %r244 = add i32 0, 0

        mov     x9, #0
        //  %r245 = add i32 0, 0

        mov     x9, #0
        //  %r246 = add i32 0, 0

        mov     x9, #0
        //  %r247 = add i32 0, 0

        mov     x9, #0
        //  %r248 = add i32 0, 0

        mov     x9, #0
        //  %r249 = add i32 0, 0

        mov     x9, #0
        //  %r250 = add i32 0, 0

        mov     x9, #0
        //  %r251 = add i32 0, 0

        mov     x9, #0
        //  %r252 = add i32 0, 0

        mov     x9, #0
        //  %r253 = add i32 0, 0

        mov     x9, #0
        //  %r254 = add i32 0, 0

        mov     x9, #0
        //  %r255 = add i32 0, 0

        mov     x9, #0
        //  %r256 = add i32 0, 0

        mov     x9, #0
        //  %r257 = add i32 0, 0

        mov     x9, #0
        //  %r258 = add i32 0, 0

        mov     x9, #0
        //  %r259 = add i32 0, 0

        mov     x9, #0
        //  %r260 = add i32 0, 0

        mov     x9, #0
        //  %r261 = add i32 0, 0

        mov     x9, #0
        //  %r262 = add i32 0, 0

        mov     x9, #0
        //  %r263 = call i32 @getint()

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
        mov     x9, x0
        //  br label %bb2


        //bb2:  %r264 = phi i32 [ %r263, %bb1 ], [ %r296, %bb3 ]

        mov     x16, x9
        mov     x17, #0
        str     x16, [sp,x17]
        b     bb2
        //bb2:

bb2:

        //  %r264 = phi i32 [ %r263, %bb1 ], [ %r296, %bb3 ]

        //  %r133 = icmp eq i32 %r264, 5

        mov     x9, #5
        mov     x16, #0
        ldr     x19, [sp,x16]
        cmp     x19, x9
        //  br i1 %r133, label %bb3, label %bb4


        b.eq     bb3
        b     bb4
        //bb3:

bb3:

        //  %r296 = add i32 %r264, 1

        mov     x16, #0
        ldr     x19, [sp,x16]
        add     x9, x19, #1
        //  br label %bb2


        //bb2:  %r264 = phi i32 [ %r263, %bb1 ], [ %r296, %bb3 ]

        mov     x16, x9
        mov     x17, #0
        str     x16, [sp,x17]
        b     bb2
        //bb4:

bb4:

        //  %r265 = add i32 0, 0

        mov     x9, #0
        mov     x16, x9
        mov     x17, #8
        str     x16, [sp,x17]
        //  %r266 = add i32 %r265, 1

        mov     x16, #8
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #16
        str     x16, [sp,x17]
        //  %r267 = add i32 %r266, 1

        mov     x16, #16
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #24
        str     x16, [sp,x17]
        //  %r268 = add i32 %r267, 1

        mov     x16, #24
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #32
        str     x16, [sp,x17]
        //  %r269 = add i32 %r268, 1

        mov     x16, #32
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #40
        str     x16, [sp,x17]
        //  %r270 = add i32 %r269, 1

        mov     x16, #40
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #48
        str     x16, [sp,x17]
        //  %r271 = add i32 %r270, 1

        mov     x16, #48
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #56
        str     x16, [sp,x17]
        //  %r272 = add i32 %r271, 1

        mov     x16, #56
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #64
        str     x16, [sp,x17]
        //  %r273 = add i32 %r272, 1

        mov     x16, #64
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #72
        str     x16, [sp,x17]
        //  %r274 = add i32 %r273, 1

        mov     x16, #72
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #80
        str     x16, [sp,x17]
        //  %r275 = add i32 %r274, 1

        mov     x16, #80
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #88
        str     x16, [sp,x17]
        //  %r276 = add i32 %r275, 1

        mov     x16, #88
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #96
        str     x16, [sp,x17]
        //  %r277 = add i32 %r276, 1

        mov     x16, #96
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #104
        str     x16, [sp,x17]
        //  %r278 = add i32 %r277, 1

        mov     x16, #104
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #112
        str     x16, [sp,x17]
        //  %r279 = add i32 %r278, 1

        mov     x16, #112
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #120
        str     x16, [sp,x17]
        //  %r280 = add i32 %r279, 1

        mov     x16, #120
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #128
        str     x16, [sp,x17]
        //  %r281 = add i32 %r280, 1

        mov     x16, #128
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #136
        str     x16, [sp,x17]
        //  %r282 = add i32 %r281, 1

        mov     x16, #136
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #144
        str     x16, [sp,x17]
        //  %r283 = add i32 %r282, 1

        mov     x16, #144
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #152
        str     x16, [sp,x17]
        //  %r284 = add i32 %r283, 1

        mov     x16, #152
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #160
        str     x16, [sp,x17]
        //  %r285 = add i32 %r284, 1

        mov     x16, #160
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #168
        str     x16, [sp,x17]
        //  %r286 = add i32 %r285, 1

        mov     x16, #168
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #176
        str     x16, [sp,x17]
        //  %r287 = add i32 %r286, 1

        mov     x16, #176
        ldr     x19, [sp,x16]
        add     x16, x19, #1
        mov     x17, #184
        str     x16, [sp,x17]
        //  %r288 = add i32 %r287, 1

        mov     x16, #184
        ldr     x19, [sp,x16]
        add     x15, x19, #1
        //  %r289 = add i32 %r288, 1

        add     x14, x15, #1
        //  %r290 = add i32 %r289, 1

        add     x13, x14, #1
        //  %r291 = add i32 %r290, 1

        add     x12, x13, #1
        //  %r292 = add i32 %r291, 1

        add     x11, x12, #1
        //  %r293 = add i32 %r292, 1

        add     x10, x11, #1
        //  %r294 = add i32 %r293, 1

        add     x9, x10, #1
        //  call void @putint(i32 %r265)

        mov     x16, #8
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r266)

        mov     x16, #16
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r267)

        mov     x16, #24
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r268)

        mov     x16, #32
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r269)

        mov     x16, #40
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r270)

        mov     x16, #48
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r271)

        mov     x16, #56
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r272)

        mov     x16, #64
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r273)

        mov     x16, #72
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r274)

        mov     x16, #80
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r275)

        mov     x16, #88
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r276)

        mov     x16, #96
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r277)

        mov     x16, #104
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r278)

        mov     x16, #112
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r279)

        mov     x16, #120
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r280)

        mov     x16, #128
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r281)

        mov     x16, #136
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r282)

        mov     x16, #144
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r283)

        mov     x16, #152
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r284)

        mov     x16, #160
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r285)

        mov     x16, #168
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r286)

        mov     x16, #176
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r287)

        mov     x16, #184
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putint(i32 %r288)

        mov     x0, x15
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
        //  call void @putint(i32 %r289)

        mov     x0, x14
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
        //  call void @putint(i32 %r290)

        mov     x0, x13
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
        //  call void @putint(i32 %r291)

        mov     x0, x12
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
        //  call void @putint(i32 %r292)

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
        //  call void @putint(i32 %r293)

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
        //  call void @putint(i32 %r294)

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
        //  %r295 = add i32 10, 0

        mov     x9, #10
        mov     x9, x9
        //  call void @putch(i32 %r295)

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
        //  call void @putint(i32 %r264)

        mov     x16, #0
        ldr     x19, [sp,x16]
        mov     x0, x19
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
        //  call void @putch(i32 %r295)

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
        //  call void @_sysy_stoptime(i32 312)

        mov     x9, #312
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
        //  ret i32 %r290

        mov     x0, x13
        mov     sp, x29
        ret
