.section .data
.global    TOKEN_NUM
.global    TOKEN_OTHER
.global    last_char
.global    num
.global    other
.global    cur_token
TOKEN_NUM:
        .quad   0
TOKEN_OTHER:
        .quad   1
last_char:
        .quad   32
num:
        .quad   0
other:
        .quad   0
cur_token:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global next_char
.global is_space
.global is_num
.global next_token
.global panic
.global get_op_prec
.global stack_push
.global stack_pop
.global stack_peek
.global stack_size
.global mod
.global eval_op
.global eval
.global main

        #%r100->x10

        #%r101->x9

        #%r339->x9

        #%r340->x9
next_char:


        #bb1:
bb1:


        #  %r100 = call i32 @getch()
        mov     x16, #0
        sub     sp, sp, x16
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  store i32 %r100, i32* @last_char
        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        str     w10, [x9]

        #  %r101 = load i32, i32* @last_char
        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     w9, [x9]

        #  ret i32 %r101
        mov     w0, w9
        mov     sp, x29
        ret

        #%r102->x10

        #%r291->x9

        #%r343->x9

        #%r292->x10

        #%r344->x9

        #%r341->x9

        #%r342->x9

        #%r345->x9
is_space:


        #bb81:
bb81:


        #  %r291 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0

        #  %r292 = add i32 %r102, 0
        mov     w10, w10

        #  br label %bb2

        b     bb2

        #bb2:
bb2:


        #  %r105 = icmp eq i32 %r292, 32
        mov     w9, #32
        cmp     w10, w9

        #  br i1 %r105, label %bb3, label %bb6

        b.eq     bb3
        b     bb6

        #bb6:
bb6:


        #  %r107 = icmp eq i32 %r292, 10
        mov     w9, #10
        cmp     w10, w9

        #  br i1 %r107, label %bb3, label %bb4

        b.eq     bb3
        b     bb4

        #bb3:
bb3:


        #  ret i32 1
        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret

        #bb4:
bb4:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r108->x10

        #%r293->x9

        #%r294->x10

        #%r346->x9

        #%r347->x9

        #%r348->x9

        #%r349->x9

        #%r350->x9
is_num:


        #bb84:
bb84:


        #  %r293 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0

        #  %r294 = add i32 %r108, 0
        mov     w10, w10

        #  br label %bb7

        b     bb7

        #bb7:
bb7:


        #  %r111 = icmp sge i32 %r294, 48
        mov     w9, #48
        cmp     w10, w9

        #  br i1 %r111, label %bb11, label %bb9

        b.ge     bb11
        b     bb9

        #bb11:
bb11:


        #  %r113 = icmp sle i32 %r294, 57
        mov     w9, #57
        cmp     w10, w9

        #  br i1 %r113, label %bb8, label %bb9

        b.le     bb8
        b     bb9

        #bb8:
bb8:


        #  ret i32 1
        mov     w9, #1
        mov     w0, w9
        mov     sp, x29
        ret

        #bb9:
bb9:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r356->x9

        #%r120->x9

        #%r351->x9

        #%r115->x10

        #%r133->x9

        #%r132->x10

        #%r368->x9

        #%r131->x10

        #%r367->x9

        #%r362->x9

        #%r126->x10

        #%r130->x10

        #%r366->x9

        #%r114->x9

        #%r359->x9

        #%r123->x10

        #%r127->x9

        #%r363->x9

        #%r360->x9

        #%r128->x9

        #%r364->x9

        #%r117->x9

        #%r353->x9

        #%r118->x10

        #%r354->x9

        #%r352->x9

        #%r121->x10

        #%r357->x9

        #%r122->x9

        #%r358->x9

        #%r355->x9

        #%r125->x10

        #%r361->x9

        #%r129->x10

        #%r365->x9
next_token:


        #bb12:
bb12:


        #  br label %bb13

        mov     x16, #0
        sub     sp, sp, x16
        b     bb13

        #bb13:
bb13:


        #  %r114 = load i32, i32* @last_char
        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     w9, [x9]

        #  %r115 = call i32 @is_space(i32 %r114)
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     is_space
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r116 = icmp ne i32 %r115, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r116, label %bb14, label %bb15

        b.ne     bb14
        b     bb15

        #bb14:
bb14:


        #  call void @next_char()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     next_char
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb13

        b     bb13

        #bb15:
bb15:


        #  %r117 = load i32, i32* @last_char
        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     w9, [x9]

        #  %r118 = call i32 @is_num(i32 %r117)
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     is_num
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r119 = icmp ne i32 %r118, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r119, label %bb16, label %bb17

        b.ne     bb16
        b     bb17

        #bb16:
bb16:


        #  %r120 = load i32, i32* @last_char
        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     w9, [x9]

        #  %r121 = sub i32 %r120, 48
        sub     w10, w9, #48

        #  store i32 %r121, i32* @num
        adrp     x9, num
        add     x9, x9, #:lo12:num
        str     w10, [x9]

        #  br label %bb19

        b     bb19

        #bb19:
bb19:


        #  %r122 = call i32 @next_char()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     next_char
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  %r123 = call i32 @is_num(i32 %r122)
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     is_num
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r124 = icmp ne i32 %r123, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r124, label %bb20, label %bb21

        b.ne     bb20
        b     bb21

        #bb20:
bb20:


        #  %r125 = load i32, i32* @num
        adrp     x9, num
        add     x9, x9, #:lo12:num
        ldr     w10, [x9]

        #  %r126 = mul i32 %r125, 10
        mov     w9, #10
        mul     w10, w10, w9

        #  %r127 = load i32, i32* @last_char
        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     w9, [x9]

        #  %r128 = add i32 %r126, %r127
        add     w9, w10, w9

        #  %r129 = sub i32 %r128, 48
        sub     w10, w9, #48

        #  store i32 %r129, i32* @num
        adrp     x9, num
        add     x9, x9, #:lo12:num
        str     w10, [x9]

        #  br label %bb19

        b     bb19

        #bb21:
bb21:


        #  %r130 = load i32, i32* @TOKEN_NUM
        adrp     x9, TOKEN_NUM
        add     x9, x9, #:lo12:TOKEN_NUM
        ldr     w10, [x9]

        #  store i32 %r130, i32* @cur_token
        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        str     w10, [x9]

        #  br label %bb18

        b     bb18

        #bb17:
bb17:


        #  %r131 = load i32, i32* @last_char
        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     w10, [x9]

        #  store i32 %r131, i32* @other
        adrp     x9, other
        add     x9, x9, #:lo12:other
        str     w10, [x9]

        #  call void @next_char()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     next_char
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r132 = load i32, i32* @TOKEN_OTHER
        adrp     x9, TOKEN_OTHER
        add     x9, x9, #:lo12:TOKEN_OTHER
        ldr     w10, [x9]

        #  store i32 %r132, i32* @cur_token
        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        str     w10, [x9]

        #  br label %bb18

        b     bb18

        #bb18:
bb18:


        #  %r133 = load i32, i32* @cur_token
        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        ldr     w9, [x9]

        #  ret i32 %r133
        mov     w0, w9
        mov     sp, x29
        ret

        #%r369->x9

        #%r370->x9

        #%r371->x9

        #%r372->x9

        #%r373->x9

        #%r374->x9

        #%r375->x9

        #%r376->x9
panic:


        #bb22:
bb22:


        #  call void @putch(i32 112)
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #112
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

        #  call void @putch(i32 97)
        mov     w9, #97
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

        #  call void @putch(i32 110)
        mov     w9, #110
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

        #  call void @putch(i32 105)
        mov     w9, #105
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

        #  call void @putch(i32 99)
        mov     w9, #99
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

        #  call void @putch(i32 33)
        mov     w9, #33
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

        #  ret i32 -1
        mov     w9, #-1
        mov     w0, w9
        mov     sp, x29
        ret

        #%r134->x10

        #%r381->x9

        #%r295->x9

        #%r296->x10

        #%r377->x9

        #%r378->x9

        #%r379->x9

        #%r380->x9

        #%r382->x9

        #%r383->x9

        #%r384->x9

        #%r385->x9
get_op_prec:


        #bb87:
bb87:


        #  %r295 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w9, #0

        #  %r296 = add i32 %r134, 0
        mov     w10, w10

        #  br label %bb23

        b     bb23

        #bb23:
bb23:


        #  %r137 = icmp eq i32 %r296, 43
        mov     w9, #43
        cmp     w10, w9

        #  br i1 %r137, label %bb24, label %bb27

        b.eq     bb24
        b     bb27

        #bb27:
bb27:


        #  %r139 = icmp eq i32 %r296, 45
        mov     w9, #45
        cmp     w10, w9

        #  br i1 %r139, label %bb24, label %bb25

        b.eq     bb24
        b     bb25

        #bb24:
bb24:


        #  ret i32 10
        mov     w9, #10
        mov     w0, w9
        mov     sp, x29
        ret

        #bb25:
bb25:


        #  br label %bb26

        b     bb26

        #bb26:
bb26:


        #  %r141 = icmp eq i32 %r296, 42
        mov     w9, #42
        cmp     w10, w9

        #  br i1 %r141, label %bb28, label %bb32

        b.eq     bb28
        b     bb32

        #bb32:
bb32:


        #  %r143 = icmp eq i32 %r296, 47
        mov     w9, #47
        cmp     w10, w9

        #  br i1 %r143, label %bb28, label %bb31

        b.eq     bb28
        b     bb31

        #bb31:
bb31:


        #  %r145 = icmp eq i32 %r296, 37
        mov     w9, #37
        cmp     w10, w9

        #  br i1 %r145, label %bb28, label %bb29

        b.eq     bb28
        b     bb29

        #bb28:
bb28:


        #  ret i32 20
        mov     w9, #20
        mov     w0, w9
        mov     sp, x29
        ret

        #bb29:
bb29:


        #  br label %bb30

        b     bb30

        #bb30:
bb30:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r300->x12

        #%r387->x9

        #%r299->x9

        #%r154->x11

        #%r386->x9

        #%r298->x9

        #%r158->x10

        #%r390->x11

        #%r297->x9

        #%r152->x11

        #%r151->x13

        #%r150->x11

        #%r149->x11

        #%r147->x11

        #%r146->x10

        #%r388->x12

        #%r389->x11

        #%r391->x12

        #%r392->x11

        #%r393->x11

        #%r394->x12

        #%r395->x11

        #%r396->x11

        #%r397->x11

        #%r398->x11
stack_push:


        #bb90:
bb90:


        #  %r297 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     w11, w1
        mov     w9, #0

        #  %r298 = add i32 0, 0
        mov     w9, #0

        #  %r299 = add i32 %r147, 0
        mov     w9, w11

        #  br label %bb33

        b     bb33

        #bb33:
bb33:


        #  %r149 = getelementptr i32, i32* %r146, i32 0
        mov     x12, #0
        mov     x11, #4
        mul     x11, x12, x11
        add     x11, x10, x11

        #  %r150 = load i32, i32* %r149
        ldr     w11, [x11]

        #  %r151 = add i32 %r150, 1
        add     w13, w11, #1

        #  %r152 = getelementptr i32, i32* %r146, i32 0
        mov     x12, #0
        mov     x11, #4
        mul     x11, x12, x11
        add     x11, x10, x11

        #  store i32 %r151, i32* %r152
        str     w13, [x11]

        #  %r154 = getelementptr i32, i32* %r146, i32 0
        mov     x12, #0
        mov     x11, #4
        mul     x11, x12, x11
        add     x11, x10, x11

        #  %r300 = load i32, i32* %r154
        ldr     w12, [x11]

        #  %r158 = getelementptr i32, i32* %r146, i32 %r300
        mov     x11, #4
        mul     x11, x12, x11
        add     x10, x10, x11

        #  store i32 %r299, i32* %r158
        str     w9, [x10]

        #  ret void
        mov     sp, x29
        ret

        #%r400->x11

        #%r168->x11

        #%r303->x11

        #%r301->x9

        #%r170->x10

        #%r402->x9

        #%r169->x13

        #%r401->x9

        #%r167->x11

        #%r399->x9

        #%r165->x9

        #%r304->x9

        #%r159->x10

        #%r161->x9

        #%r302->x9

        #%r403->x9

        #%r404->x9

        #%r405->x9

        #%r406->x12

        #%r407->x11

        #%r408->x11

        #%r409->x12

        #%r410->x11

        #%r411->x11
stack_pop:


        #bb34:
bb34:


        #  %r301 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     w9, #0

        #  %r161 = getelementptr i32, i32* %r159, i32 0
        mov     x11, #0
        mov     x9, #4
        mul     x9, x11, x9
        add     x9, x10, x9

        #  %r303 = load i32, i32* %r161
        ldr     w11, [x9]

        #  %r302 = add i32 0, 0
        mov     w9, #0

        #  %r165 = getelementptr i32, i32* %r159, i32 %r303
        mov     x9, #4
        mul     x9, x11, x9
        add     x9, x10, x9

        #  %r304 = load i32, i32* %r165
        ldr     w9, [x9]

        #  %r167 = getelementptr i32, i32* %r159, i32 0
        mov     x12, #0
        mov     x11, #4
        mul     x11, x12, x11
        add     x11, x10, x11

        #  %r168 = load i32, i32* %r167
        ldr     w11, [x11]

        #  %r169 = sub i32 %r168, 1
        sub     w13, w11, #1

        #  %r170 = getelementptr i32, i32* %r159, i32 0
        mov     x12, #0
        mov     x11, #4
        mul     x11, x12, x11
        add     x10, x10, x11

        #  store i32 %r169, i32* %r170
        str     w13, [x10]

        #  ret i32 %r304
        mov     w0, w9
        mov     sp, x29
        ret

        #%r172->x9

        #%r174->x10

        #%r177->x9

        #%r178->x9

        #%r412->x10

        #%r305->x9

        #%r306->x11

        #%r413->x11

        #%r414->x10

        #%r415->x10

        #%r416->x10

        #%r417->x10
stack_peek:


        #bb35:
bb35:


        #  %r305 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     w10, #0

        #  %r174 = getelementptr i32, i32* %r172, i32 0
        mov     x11, #0
        mov     x10, #4
        mul     x10, x11, x10
        add     x10, x9, x10

        #  %r306 = load i32, i32* %r174
        ldr     w11, [x10]

        #  %r177 = getelementptr i32, i32* %r172, i32 %r306
        mov     x10, #4
        mul     x10, x11, x10
        add     x9, x9, x10

        #  %r178 = load i32, i32* %r177
        ldr     w9, [x9]

        #  ret i32 %r178
        mov     w0, w9
        mov     sp, x29
        ret

        #%r179->x11

        #%r180->x9

        #%r181->x9

        #%r418->x10

        #%r419->x9

        #%r420->x9
stack_size:


        #bb36:
bb36:


        #  %r180 = getelementptr i32, i32* %r179, i32 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, #0
        mov     x9, #4
        mul     x9, x10, x9
        add     x9, x11, x9

        #  %r181 = load i32, i32* %r180
        ldr     w9, [x9]

        #  ret i32 %r181
        mov     w0, w9
        mov     sp, x29
        ret

        #%r182->x10

        #%r184->x11

        #%r189->x11

        #%r191->x9

        #%r308->x9

        #%r192->x9

        #%r309->x10

        #%r307->x9

        #%r310->x9

        #%r421->x9

        #%r422->x9
mod:


        #bb91:
bb91:


        #  %r307 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w10, w0
        mov     w11, w1
        mov     w9, #0

        #  %r309 = add i32 %r182, 0
        mov     w10, w10

        #  %r308 = add i32 0, 0
        mov     w9, #0

        #  %r310 = add i32 %r184, 0
        mov     w9, w11

        #  br label %bb37

        b     bb37

        #bb37:
bb37:


        #  %r189 = sdiv i32 %r309, %r310
        sdiv     w11, w10, w9

        #  %r191 = mul i32 %r189, %r310
        mul     w9, w11, w9

        #  %r192 = sub i32 %r309, %r191
        sub     w9, w10, w9

        #  ret i32 %r192
        mov     w0, w9
        mov     sp, x29
        ret

        #%r315->x10

        #%r431->x9

        #%r313->x9

        #%r197->x9

        #%r429->x12

        #%r311->x9

        #%r195->x12

        #%r427->x12

        #%r218->x9

        #%r213->x9

        #%r203->x9

        #%r314->x11

        #%r430->x12

        #%r223->x9

        #%r426->x12

        #%r312->x9

        #%r428->x12

        #%r208->x9

        #%r193->x11

        #%r425->x12

        #%r316->x9

        #%r423->x10

        #%r424->x10
eval_op:


        #bb92:
bb92:


        #  %r311 = add i32 0, 0
        mov     x16, #0
        sub     sp, sp, x16
        mov     w11, w0
        mov     w12, w1
        mov     w9, w2
        mov     w10, #0

        #  %r314 = add i32 %r193, 0
        mov     w11, w11

        #  %r312 = add i32 0, 0
        mov     w10, #0

        #  %r315 = add i32 %r195, 0
        mov     w10, w12

        #  %r313 = add i32 0, 0
        mov     w12, #0

        #  %r316 = add i32 %r197, 0
        mov     w9, w9

        #  br label %bb38

        b     bb38

        #bb38:
bb38:


        #  %r200 = icmp eq i32 %r314, 43
        mov     w12, #43
        cmp     w11, w12

        #  br i1 %r200, label %bb39, label %bb40

        b.eq     bb39
        b     bb40

        #bb39:
bb39:


        #  %r203 = add i32 %r315, %r316
        add     w9, w10, w9

        #  ret i32 %r203
        mov     w0, w9
        mov     sp, x29
        ret

        #bb40:
bb40:


        #  br label %bb41

        b     bb41

        #bb41:
bb41:


        #  %r205 = icmp eq i32 %r314, 45
        mov     w12, #45
        cmp     w11, w12

        #  br i1 %r205, label %bb42, label %bb43

        b.eq     bb42
        b     bb43

        #bb42:
bb42:


        #  %r208 = sub i32 %r315, %r316
        sub     w9, w10, w9

        #  ret i32 %r208
        mov     w0, w9
        mov     sp, x29
        ret

        #bb43:
bb43:


        #  br label %bb44

        b     bb44

        #bb44:
bb44:


        #  %r210 = icmp eq i32 %r314, 42
        mov     w12, #42
        cmp     w11, w12

        #  br i1 %r210, label %bb45, label %bb46

        b.eq     bb45
        b     bb46

        #bb45:
bb45:


        #  %r213 = mul i32 %r315, %r316
        mul     w9, w10, w9

        #  ret i32 %r213
        mov     w0, w9
        mov     sp, x29
        ret

        #bb46:
bb46:


        #  br label %bb47

        b     bb47

        #bb47:
bb47:


        #  %r215 = icmp eq i32 %r314, 47
        mov     w12, #47
        cmp     w11, w12

        #  br i1 %r215, label %bb48, label %bb49

        b.eq     bb48
        b     bb49

        #bb48:
bb48:


        #  %r218 = sdiv i32 %r315, %r316
        sdiv     w9, w10, w9

        #  ret i32 %r218
        mov     w0, w9
        mov     sp, x29
        ret

        #bb49:
bb49:


        #  br label %bb50

        b     bb50

        #bb50:
bb50:


        #  %r220 = icmp eq i32 %r314, 37
        mov     w12, #37
        cmp     w11, w12

        #  br i1 %r220, label %bb51, label %bb52

        b.eq     bb51
        b     bb52

        #bb51:
bb51:


        #  %r223 = call i32 @mod(i32 %r315, i32 %r316)
        mov     w0, w10
        mov     w1, w9
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
        mov     w9, w0

        #  ret i32 %r223
        mov     w0, w9
        mov     sp, x29
        ret

        #bb52:
bb52:


        #  br label %bb53

        b     bb53

        #bb53:
bb53:


        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret

        #%r434->x9

        #%r433->x9

        #%r432->x9

        #%r334->x9

        #%r461->x9

        #%r451->x10

        #%r324->x9

        #%r333->x11

        #%r460->x9

        #%r450->x10

        #%r323->x9

        #%r332->x12

        #%r459->x9

        #%r449->x10

        #%r322->x9

        #%r331->x9

        #%r458->x9

        #%r445->x10

        #%r318->x9

        #%r327->x11

        #%r454->x9

        #%r250->x9

        #%r246->x11

        #%r241->x9

        #%r447->x10

        #%r320->x9

        #%r329->x9

        #%r456->x9

        #%r270->x10

        #%r253->x9

        #%r282->x10

        #%r240->x10

        #%r446->x10

        #%r319->x9

        #%r328->x10

        #%r455->x9

        #%r269->x9

        #%r239->x10

        #%r493->x9

        #%r251->x11

        #%r238->x9

        #%r492->x9

        #%r444->x10

        #%r317->x9

        #%r326->x9

        #%r453->x9

        #%r267->x9

        #%r236->x9

        #%r490->x9

        #%r248->x11

        #%r235->x10

        #%r489->x9

        #%r441->x10

        #%r264->x11

        #%r440->x9

        #%r232->x11

        #%r486->x9

        #%r437->x9

        #%r230->x11

        #%r484->x9

        #%r435->x9

        #%r443->x11

        #%r325->x9

        #%r452->x9

        #%r266->x10

        #%r442->x10

        #%r448->x11

        #%r321->x9

        #%r330->x10

        #%r457->x9

        #%r271->x10

        #%r283->x9

        #%r436->x9

        #%r438->x9

        #%r439->x9

        #%r462->x9

        #%r463->x9

        #%r464->x9

        #%r465->x9

        #%r466->x9

        #%r467->x9

        #%r468->x11

        #%r469->x11

        #%r470->x11

        #%r471->x11

        #%r472->x9

        #%r473->x9

        #%r474->x9

        #%r475->x9

        #%r476->x9

        #%r477->x9

        #%r478->x9

        #%r479->x9

        #%r480->x9

        #%r481->x9

        #%r482->x9

        #%r483->x9

        #%r485->x9

        #%r487->x9

        #%r488->x9

        #%r491->x9
eval:


        #225:x29,#-2048

        #224:x29,#-1024

        #bb54:
bb54:


        #  %r317 = add i32 0, 0
        mov     x16, #2048
        sub     sp, sp, x16
        mov     w9, #0

        #  %r318 = add i32 0, 0
        mov     w9, #0

        #  %r319 = add i32 0, 0
        mov     w9, #0

        #  %r320 = add i32 0, 0
        mov     w9, #0

        #  %r321 = add i32 0, 0
        mov     w9, #0

        #  %r322 = add i32 0, 0
        mov     w9, #0

        #  %r323 = add i32 0, 0
        mov     w9, #0

        #  %r224 = alloca [ 256 x i32 ]

        #  %r225 = alloca [ 256 x i32 ]

        #  %r324 = add i32 0, 0
        mov     w9, #0

        #  %r325 = add i32 0, 0
        mov     w9, #0
        mov     w9, w9

        #  br label %bb55


        #bb55:  %r326 = phi i32 [ %r325, %bb54 ], [ %r334, %bb56 ]
        mov     w9, w9
        b     bb55

        #bb55:
bb55:


        #  %r326 = phi i32 [ %r325, %bb54 ], [ %r334, %bb56 ]

        #  %r228 = icmp slt i32 %r326, 256
        mov     w10, #256
        cmp     w9, w10

        #  br i1 %r228, label %bb56, label %bb57

        b.lt     bb56
        b     bb57

        #bb56:
bb56:


        #  %r230 = getelementptr [256 x i32 ], [256 x i32 ]* %r224, i32 0, i32 %r326
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-1024
        add     x10, x29, x10
        add     x11, x10, x11

        #  store i32 0, i32* %r230
        mov     w10, #0
        str     w10, [x11]

        #  %r232 = getelementptr [256 x i32 ], [256 x i32 ]* %r225, i32 0, i32 %r326
        mov     x10, #4
        mul     x11, x9, x10
        mov     x10, #-2048
        add     x10, x29, x10
        add     x11, x10, x11

        #  store i32 0, i32* %r232
        mov     w10, #0
        str     w10, [x11]

        #  %r334 = add i32 %r326, 1
        add     w9, w9, #1

        #  br label %bb55


        #bb55:  %r326 = phi i32 [ %r325, %bb54 ], [ %r334, %bb56 ]
        mov     w9, w9
        b     bb55

        #bb57:
bb57:


        #  %r235 = load i32, i32* @cur_token
        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        ldr     w10, [x9]

        #  %r236 = load i32, i32* @TOKEN_NUM
        adrp     x9, TOKEN_NUM
        add     x9, x9, #:lo12:TOKEN_NUM
        ldr     w9, [x9]

        #  %r237 = icmp ne i32 %r235, %r236
        cmp     w10, w9

        #  br i1 %r237, label %bb58, label %bb59

        b.ne     bb58
        b     bb59

        #bb58:
bb58:


        #  %r238 = call i32 @panic()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     panic
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  ret i32 %r238
        mov     w0, w9
        mov     sp, x29
        ret

        #bb59:
bb59:


        #  br label %bb60

        b     bb60

        #bb60:
bb60:


        #  %r239 = load i32, i32* @num
        adrp     x9, num
        add     x9, x9, #:lo12:num
        ldr     w10, [x9]

        #  call void @stack_push(i32* %r224, i32 %r239)
        mov     x9, #-1024
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  call void @next_token()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb61

        b     bb61

        #bb61:
bb61:


        #  %r240 = load i32, i32* @cur_token
        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        ldr     w10, [x9]

        #  %r241 = load i32, i32* @TOKEN_OTHER
        adrp     x9, TOKEN_OTHER
        add     x9, x9, #:lo12:TOKEN_OTHER
        ldr     w9, [x9]

        #  %r242 = icmp eq i32 %r240, %r241
        cmp     w10, w9

        #  br i1 %r242, label %bb62, label %bb63

        b.eq     bb62
        b     bb63

        #bb62:
bb62:


        #  %r330 = load i32, i32* @other
        adrp     x9, other
        add     x9, x9, #:lo12:other
        ldr     w10, [x9]

        #  %r246 = call i32 @get_op_prec(i32 %r330)
        mov     w0, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     get_op_prec
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  %r247 = icmp eq i32 %r246, 0
        mov     w9, #0
        cmp     w11, w9

        #  br i1 %r247, label %bb64, label %bb65

        b.eq     bb64
        b     bb65

        #bb64:
bb64:


        #  br label %bb63

        b     bb63

        #bb65:
bb65:


        #  br label %bb66

        b     bb66

        #bb66:
bb66:


        #  call void @next_token()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb67

        b     bb67

        #bb67:
bb67:


        #  %r248 = call i32 @stack_size(i32* %r225)
        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_size
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  %r249 = icmp ne i32 %r248, 0
        mov     w9, #0
        cmp     w11, w9

        #  br i1 %r249, label %bb70, label %bb69

        b.ne     bb70
        b     bb69

        #bb70:
bb70:


        #  %r250 = call i32 @stack_peek(i32* %r225)
        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_peek
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  %r251 = call i32 @get_op_prec(i32 %r250)
        mov     w0, w9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     get_op_prec
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  %r253 = call i32 @get_op_prec(i32 %r330)
        mov     w0, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     get_op_prec
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  %r254 = icmp sge i32 %r251, %r253
        cmp     w11, w9

        #  br i1 %r254, label %bb68, label %bb69

        b.ge     bb68
        b     bb69

        #bb68:
bb68:


        #  %r331 = call i32 @stack_pop(i32* %r225)
        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  %r332 = call i32 @stack_pop(i32* %r224)
        mov     x11, #-1024
        add     x11, x29, x11
        mov     x0, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w12, w0

        #  %r333 = call i32 @stack_pop(i32* %r224)
        mov     x11, #-1024
        add     x11, x29, x11
        mov     x0, x11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  %r264 = call i32 @eval_op(i32 %r331, i32 %r333, i32 %r332)
        mov     w0, w9
        mov     w1, w11
        mov     w2, w12
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     eval_op
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  call void @stack_push(i32* %r224, i32 %r264)
        mov     x9, #-1024
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w11
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb67

        b     bb67

        #bb69:
bb69:


        #  call void @stack_push(i32* %r225, i32 %r330)
        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  %r266 = load i32, i32* @cur_token
        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        ldr     w10, [x9]

        #  %r267 = load i32, i32* @TOKEN_NUM
        adrp     x9, TOKEN_NUM
        add     x9, x9, #:lo12:TOKEN_NUM
        ldr     w9, [x9]

        #  %r268 = icmp ne i32 %r266, %r267
        cmp     w10, w9

        #  br i1 %r268, label %bb71, label %bb72

        b.ne     bb71
        b     bb72

        #bb71:
bb71:


        #  %r269 = call i32 @panic()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     panic
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  ret i32 %r269
        mov     w0, w9
        mov     sp, x29
        ret

        #bb72:
bb72:


        #  br label %bb73

        b     bb73

        #bb73:
bb73:


        #  %r270 = load i32, i32* @num
        adrp     x9, num
        add     x9, x9, #:lo12:num
        ldr     w10, [x9]

        #  call void @stack_push(i32* %r224, i32 %r270)
        mov     x9, #-1024
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  call void @next_token()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb61

        b     bb61

        #bb63:
bb63:


        #  call void @next_token()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb74

        b     bb74

        #bb74:
bb74:


        #  %r271 = call i32 @stack_size(i32* %r225)
        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_size
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r272 = icmp ne i32 %r271, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r272, label %bb75, label %bb76

        b.ne     bb75
        b     bb76

        #bb75:
bb75:


        #  %r327 = call i32 @stack_pop(i32* %r225)
        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w11, w0

        #  %r328 = call i32 @stack_pop(i32* %r224)
        mov     x9, #-1024
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  %r329 = call i32 @stack_pop(i32* %r224)
        mov     x9, #-1024
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  %r282 = call i32 @eval_op(i32 %r327, i32 %r329, i32 %r328)
        mov     w0, w11
        mov     w1, w9
        mov     w2, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     eval_op
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w10, w0

        #  call void @stack_push(i32* %r224, i32 %r282)
        mov     x9, #-1024
        add     x9, x29, x9
        mov     x0, x9
        mov     w1, w10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb74

        b     bb74

        #bb76:
bb76:


        #  %r283 = call i32 @stack_peek(i32* %r224)
        mov     x9, #-1024
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     stack_peek
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  ret i32 %r283
        mov     w0, w9
        mov     sp, x29
        ret

        #%r288->x9

        #%r496->x9

        #%r335->x9

        #%r336->x9

        #%r337->x10

        #%r338->x9

        #%r494->x9

        #%r495->x9

        #%r497->x9

        #%r498->x9

        #%r499->x9
main:


        #bb77:
bb77:


        #  call void @_sysy_starttime(i32 205)
        mov     x16, #0
        sub     sp, sp, x16
        mov     w9, #205
        mov     w0, w9
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

        #  %r335 = add i32 0, 0
        mov     w9, #0

        #  %r336 = call i32 @getint()
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
        mov     w9, w0

        #  call void @getch()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  call void @next_token()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16

        #  br label %bb78


        #bb78:  %r337 = phi i32 [ %r336, %bb77 ], [ %r338, %bb79 ]
        mov     w10, w9
        b     bb78

        #bb78:
bb78:


        #  %r337 = phi i32 [ %r336, %bb77 ], [ %r338, %bb79 ]

        #  %r287 = icmp ne i32 %r337, 0
        mov     w9, #0
        cmp     w10, w9

        #  br i1 %r287, label %bb79, label %bb80

        b.ne     bb79
        b     bb80

        #bb79:
bb79:


        #  %r288 = call i32 @eval()
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     eval
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     w9, w0

        #  call void @putint(i32 %r288)
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

        #  %r338 = sub i32 %r337, 1
        sub     w9, w10, #1

        #  br label %bb78


        #bb78:  %r337 = phi i32 [ %r336, %bb77 ], [ %r338, %bb79 ]
        mov     w10, w9
        b     bb78

        #bb80:
bb80:


        #  call void @_sysy_stoptime(i32 214)
        mov     w9, #214
        mov     w0, w9
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

        #  ret i32 0
        mov     w9, #0
        mov     w0, w9
        mov     sp, x29
        ret
