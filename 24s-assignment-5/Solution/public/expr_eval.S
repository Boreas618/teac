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
        //%r100->x10
        //%r101->x9
        //%r340->x9
        //%r341->x9
next_char:

        //bb1:

bb1:

        //  %r100 = call i32 @getch()

        mov     x16, #0
        sub     sp, sp, x16
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
        bl     getch
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
        //  store i32 %r100, i32* @last_char

        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        str     x10, [x9]
        //  %r101 = load i32, i32* @last_char

        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     x9, [x9]
        //  ret i32 %r101

        mov     x0, x9
        mov     sp, x29
        ret
        //%r102->x10
        //%r292->x9
        //%r344->x9
        //%r293->x10
        //%r345->x9
        //%r342->x9
        //%r343->x9
        //%r346->x9
is_space:

        //bb81:

bb81:

        //  %r292 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r293 = add i32 %r102, 0

        mov     x10, x10
        //  %r105 = icmp eq i32 %r293, 32

        mov     x9, #32
        cmp     x10, x9
        //  br i1 %r105, label %bb3, label %bb6


        b.eq     bb3
        b     bb6
        //bb6:

bb6:

        //  %r107 = icmp eq i32 %r293, 10

        mov     x9, #10
        cmp     x10, x9
        //  br i1 %r107, label %bb3, label %bb4


        b.eq     bb3
        b     bb4
        //bb3:

bb3:

        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //bb4:

bb4:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r108->x10
        //%r294->x9
        //%r295->x10
        //%r347->x9
        //%r348->x9
        //%r349->x9
        //%r350->x9
        //%r351->x9
is_num:

        //bb84:

bb84:

        //  %r294 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r295 = add i32 %r108, 0

        mov     x10, x10
        //  %r111 = icmp sge i32 %r295, 48

        mov     x9, #48
        cmp     x10, x9
        //  br i1 %r111, label %bb11, label %bb9


        b.ge     bb11
        b     bb9
        //bb11:

bb11:

        //  %r113 = icmp sle i32 %r295, 57

        mov     x9, #57
        cmp     x10, x9
        //  br i1 %r113, label %bb8, label %bb9


        b.le     bb8
        b     bb9
        //bb8:

bb8:

        //  ret i32 1

        mov     x9, #1
        mov     x0, x9
        mov     sp, x29
        ret
        //bb9:

bb9:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r356->x9
        //%r120->x9
        //%r133->x9
        //%r369->x9
        //%r132->x10
        //%r368->x9
        //%r363->x9
        //%r127->x9
        //%r131->x10
        //%r367->x9
        //%r362->x9
        //%r126->x10
        //%r130->x10
        //%r366->x9
        //%r114->x9
        //%r359->x9
        //%r123->x10
        //%r115->x10
        //%r360->x9
        //%r128->x9
        //%r364->x9
        //%r117->x9
        //%r353->x9
        //%r118->x10
        //%r354->x9
        //%r352->x9
        //%r121->x10
        //%r357->x9
        //%r122->x9
        //%r358->x9
        //%r355->x9
        //%r125->x10
        //%r361->x9
        //%r129->x10
        //%r365->x9
next_token:

        //bb12:

bb12:

        //  br label %bb13


        mov     x16, #0
        sub     sp, sp, x16
        b     bb13
        //bb13:

bb13:

        //  %r114 = load i32, i32* @last_char

        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     x9, [x9]
        //  %r115 = call i32 @is_space(i32 %r114)

        mov     x0, x9
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
        bl     is_space
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
        //  %r116 = icmp ne i32 %r115, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r116, label %bb14, label %bb15


        b.ne     bb14
        b     bb15
        //bb14:

bb14:

        //  call void @next_char()

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
        bl     next_char
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb13


        b     bb13
        //bb15:

bb15:

        //  %r117 = load i32, i32* @last_char

        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     x9, [x9]
        //  %r118 = call i32 @is_num(i32 %r117)

        mov     x0, x9
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
        bl     is_num
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
        //  %r119 = icmp ne i32 %r118, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r119, label %bb16, label %bb17


        b.ne     bb16
        b     bb17
        //bb16:

bb16:

        //  %r120 = load i32, i32* @last_char

        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     x9, [x9]
        //  %r121 = sub i32 %r120, 48

        sub     x10, x9, #48
        //  store i32 %r121, i32* @num

        adrp     x9, num
        add     x9, x9, #:lo12:num
        str     x10, [x9]
        //  br label %bb19


        b     bb19
        //bb19:

bb19:

        //  %r122 = call i32 @next_char()

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
        bl     next_char
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r123 = call i32 @is_num(i32 %r122)

        mov     x0, x9
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
        bl     is_num
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
        //  %r124 = icmp ne i32 %r123, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r124, label %bb20, label %bb21


        b.ne     bb20
        b     bb21
        //bb20:

bb20:

        //  %r125 = load i32, i32* @num

        adrp     x9, num
        add     x9, x9, #:lo12:num
        ldr     x10, [x9]
        //  %r126 = mul i32 %r125, 10

        mov     x9, #10
        mul     x10, x10, x9
        //  %r127 = load i32, i32* @last_char

        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     x9, [x9]
        //  %r128 = add i32 %r126, %r127

        add     x9, x10, x9
        //  %r129 = sub i32 %r128, 48

        sub     x10, x9, #48
        //  store i32 %r129, i32* @num

        adrp     x9, num
        add     x9, x9, #:lo12:num
        str     x10, [x9]
        //  br label %bb19


        b     bb19
        //bb21:

bb21:

        //  %r130 = load i32, i32* @TOKEN_NUM

        adrp     x9, TOKEN_NUM
        add     x9, x9, #:lo12:TOKEN_NUM
        ldr     x10, [x9]
        //  store i32 %r130, i32* @cur_token

        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        str     x10, [x9]
        //  br label %bb18


        b     bb18
        //bb17:

bb17:

        //  %r131 = load i32, i32* @last_char

        adrp     x9, last_char
        add     x9, x9, #:lo12:last_char
        ldr     x10, [x9]
        //  store i32 %r131, i32* @other

        adrp     x9, other
        add     x9, x9, #:lo12:other
        str     x10, [x9]
        //  call void @next_char()

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
        bl     next_char
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r132 = load i32, i32* @TOKEN_OTHER

        adrp     x9, TOKEN_OTHER
        add     x9, x9, #:lo12:TOKEN_OTHER
        ldr     x10, [x9]
        //  store i32 %r132, i32* @cur_token

        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        str     x10, [x9]
        //  br label %bb18


        b     bb18
        //bb18:

bb18:

        //  %r133 = load i32, i32* @cur_token

        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        ldr     x9, [x9]
        //  ret i32 %r133

        mov     x0, x9
        mov     sp, x29
        ret
        //%r134->x9
        //%r370->x9
        //%r371->x9
        //%r372->x9
        //%r373->x9
        //%r374->x9
        //%r375->x9
        //%r376->x9
        //%r377->x9
panic:

        //bb22:

bb22:

        //  call void @putch(i32 112)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #112
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
        //  call void @putch(i32 97)

        mov     x9, #97
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
        //  call void @putch(i32 110)

        mov     x9, #110
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
        //  call void @putch(i32 105)

        mov     x9, #105
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
        //  call void @putch(i32 99)

        mov     x9, #99
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
        //  call void @putch(i32 33)

        mov     x9, #33
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
        //  call void @putch(i32 10)

        mov     x9, #10
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
        //  %r134 = sub i32 0, 1

        mov     x9, #0
        sub     x9, x9, #1
        //  ret i32 %r134

        mov     x0, x9
        mov     sp, x29
        ret
        //%r135->x10
        //%r382->x9
        //%r296->x9
        //%r297->x10
        //%r378->x9
        //%r379->x9
        //%r380->x9
        //%r381->x9
        //%r383->x9
        //%r384->x9
        //%r385->x9
        //%r386->x9
get_op_prec:

        //bb87:

bb87:

        //  %r296 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r297 = add i32 %r135, 0

        mov     x10, x10
        //  %r138 = icmp eq i32 %r297, 43

        mov     x9, #43
        cmp     x10, x9
        //  br i1 %r138, label %bb24, label %bb27


        b.eq     bb24
        b     bb27
        //bb27:

bb27:

        //  %r140 = icmp eq i32 %r297, 45

        mov     x9, #45
        cmp     x10, x9
        //  br i1 %r140, label %bb24, label %bb25


        b.eq     bb24
        b     bb25
        //bb24:

bb24:

        //  ret i32 10

        mov     x9, #10
        mov     x0, x9
        mov     sp, x29
        ret
        //bb25:

bb25:

        //  %r142 = icmp eq i32 %r297, 42

        mov     x9, #42
        cmp     x10, x9
        //  br i1 %r142, label %bb28, label %bb32


        b.eq     bb28
        b     bb32
        //bb32:

bb32:

        //  %r144 = icmp eq i32 %r297, 47

        mov     x9, #47
        cmp     x10, x9
        //  br i1 %r144, label %bb28, label %bb31


        b.eq     bb28
        b     bb31
        //bb31:

bb31:

        //  %r146 = icmp eq i32 %r297, 37

        mov     x9, #37
        cmp     x10, x9
        //  br i1 %r146, label %bb28, label %bb29


        b.eq     bb28
        b     bb29
        //bb28:

bb28:

        //  ret i32 20

        mov     x9, #20
        mov     x0, x9
        mov     sp, x29
        ret
        //bb29:

bb29:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r301->x12
        //%r388->x9
        //%r300->x9
        //%r155->x11
        //%r387->x9
        //%r299->x9
        //%r159->x10
        //%r391->x11
        //%r298->x9
        //%r153->x11
        //%r152->x13
        //%r151->x11
        //%r150->x11
        //%r148->x11
        //%r147->x10
        //%r389->x12
        //%r390->x11
        //%r392->x12
        //%r393->x11
        //%r394->x11
        //%r395->x12
        //%r396->x11
        //%r397->x11
        //%r398->x11
        //%r399->x11
stack_push:

        //bb90:

bb90:

        //  %r298 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r299 = add i32 0, 0

        mov     x9, #0
        //  %r300 = add i32 %r148, 0

        mov     x9, x11
        //  %r150 = getelementptr i32, i32* %r147, i32 0

        mov     x12, #0
        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x10, x11
        //  %r151 = load i32, i32* %r150

        ldr     x11, [x11]
        //  %r152 = add i32 %r151, 1

        add     x13, x11, #1
        //  %r153 = getelementptr i32, i32* %r147, i32 0

        mov     x12, #0
        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x10, x11
        //  store i32 %r152, i32* %r153

        str     x13, [x11]
        //  %r155 = getelementptr i32, i32* %r147, i32 0

        mov     x12, #0
        mov     x11, #8
        mul     x11, x12, x11
        add     x11, x10, x11
        //  %r301 = load i32, i32* %r155

        ldr     x12, [x11]
        //  %r159 = getelementptr i32, i32* %r147, i32 %r301

        mov     x11, #8
        mul     x11, x12, x11
        add     x10, x10, x11
        //  store i32 %r300, i32* %r159

        str     x9, [x10]
        //  ret void

        mov     sp, x29
        ret
        //%r401->x11
        //%r169->x10
        //%r304->x11
        //%r302->x9
        //%r171->x9
        //%r403->x10
        //%r170->x13
        //%r402->x10
        //%r168->x10
        //%r400->x10
        //%r166->x10
        //%r305->x12
        //%r160->x9
        //%r162->x10
        //%r303->x9
        //%r404->x10
        //%r405->x10
        //%r406->x10
        //%r407->x11
        //%r408->x10
        //%r409->x10
        //%r410->x11
        //%r411->x10
        //%r412->x10
stack_pop:

        //bb34:

bb34:

        //  %r302 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, x0
        mov     x10, #0
        //  %r162 = getelementptr i32, i32* %r160, i32 0

        mov     x11, #0
        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x9, x10
        //  %r304 = load i32, i32* %r162

        ldr     x11, [x10]
        //  %r303 = add i32 0, 0

        mov     x10, #0
        //  %r166 = getelementptr i32, i32* %r160, i32 %r304

        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x9, x10
        //  %r305 = load i32, i32* %r166

        ldr     x12, [x10]
        //  %r168 = getelementptr i32, i32* %r160, i32 0

        mov     x11, #0
        mov     x10, #8
        mul     x10, x11, x10
        add     x10, x9, x10
        //  %r169 = load i32, i32* %r168

        ldr     x10, [x10]
        //  %r170 = sub i32 %r169, 1

        sub     x13, x10, #1
        //  %r171 = getelementptr i32, i32* %r160, i32 0

        mov     x11, #0
        mov     x10, #8
        mul     x10, x11, x10
        add     x9, x9, x10
        //  store i32 %r170, i32* %r171

        str     x13, [x9]
        //  ret i32 %r305

        mov     x0, x12
        mov     sp, x29
        ret
        //%r173->x11
        //%r175->x9
        //%r178->x9
        //%r179->x9
        //%r413->x9
        //%r306->x9
        //%r307->x10
        //%r414->x10
        //%r415->x9
        //%r416->x9
        //%r417->x9
        //%r418->x9
stack_peek:

        //bb35:

bb35:

        //  %r306 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x9, #0
        //  %r175 = getelementptr i32, i32* %r173, i32 0

        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        //  %r307 = load i32, i32* %r175

        ldr     x10, [x9]
        //  %r178 = getelementptr i32, i32* %r173, i32 %r307

        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        //  %r179 = load i32, i32* %r178

        ldr     x9, [x9]
        //  ret i32 %r179

        mov     x0, x9
        mov     sp, x29
        ret
        //%r180->x11
        //%r181->x9
        //%r182->x9
        //%r419->x10
        //%r420->x9
        //%r421->x9
stack_size:

        //bb36:

bb36:

        //  %r181 = getelementptr i32, i32* %r180, i32 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, #0
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        //  %r182 = load i32, i32* %r181

        ldr     x9, [x9]
        //  ret i32 %r182

        mov     x0, x9
        mov     sp, x29
        ret
        //%r183->x10
        //%r185->x11
        //%r190->x11
        //%r192->x9
        //%r309->x9
        //%r193->x9
        //%r310->x10
        //%r308->x9
        //%r311->x9
        //%r422->x9
        //%r423->x9
mod:

        //bb91:

bb91:

        //  %r308 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x11, x1
        mov     x9, #0
        //  %r310 = add i32 %r183, 0

        mov     x10, x10
        //  %r309 = add i32 0, 0

        mov     x9, #0
        //  %r311 = add i32 %r185, 0

        mov     x9, x11
        //  %r190 = sdiv i32 %r310, %r311

        sdiv     x11, x10, x9
        //  %r192 = mul i32 %r190, %r311

        mul     x9, x11, x9
        //  %r193 = sub i32 %r310, %r192

        sub     x9, x10, x9
        //  ret i32 %r193

        mov     x0, x9
        mov     sp, x29
        ret
        //%r316->x11
        //%r432->x9
        //%r314->x9
        //%r198->x10
        //%r430->x9
        //%r312->x9
        //%r196->x11
        //%r428->x9
        //%r219->x9
        //%r214->x9
        //%r204->x9
        //%r315->x12
        //%r431->x9
        //%r224->x9
        //%r427->x9
        //%r313->x9
        //%r429->x9
        //%r209->x9
        //%r194->x12
        //%r426->x9
        //%r317->x10
        //%r424->x9
        //%r425->x9
eval_op:

        //bb92:

bb92:

        //  %r312 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x12, x0
        mov     x11, x1
        mov     x10, x2
        mov     x9, #0
        //  %r315 = add i32 %r194, 0

        mov     x12, x12
        //  %r313 = add i32 0, 0

        mov     x9, #0
        //  %r316 = add i32 %r196, 0

        mov     x11, x11
        //  %r314 = add i32 0, 0

        mov     x9, #0
        //  %r317 = add i32 %r198, 0

        mov     x10, x10
        //  %r201 = icmp eq i32 %r315, 43

        mov     x9, #43
        cmp     x12, x9
        //  br i1 %r201, label %bb39, label %bb40


        b.eq     bb39
        b     bb40
        //bb39:

bb39:

        //  %r204 = add i32 %r316, %r317

        add     x9, x11, x10
        //  ret i32 %r204

        mov     x0, x9
        mov     sp, x29
        ret
        //bb40:

bb40:

        //  %r206 = icmp eq i32 %r315, 45

        mov     x9, #45
        cmp     x12, x9
        //  br i1 %r206, label %bb42, label %bb43


        b.eq     bb42
        b     bb43
        //bb42:

bb42:

        //  %r209 = sub i32 %r316, %r317

        sub     x9, x11, x10
        //  ret i32 %r209

        mov     x0, x9
        mov     sp, x29
        ret
        //bb43:

bb43:

        //  %r211 = icmp eq i32 %r315, 42

        mov     x9, #42
        cmp     x12, x9
        //  br i1 %r211, label %bb45, label %bb46


        b.eq     bb45
        b     bb46
        //bb45:

bb45:

        //  %r214 = mul i32 %r316, %r317

        mul     x9, x11, x10
        //  ret i32 %r214

        mov     x0, x9
        mov     sp, x29
        ret
        //bb46:

bb46:

        //  %r216 = icmp eq i32 %r315, 47

        mov     x9, #47
        cmp     x12, x9
        //  br i1 %r216, label %bb48, label %bb49


        b.eq     bb48
        b     bb49
        //bb48:

bb48:

        //  %r219 = sdiv i32 %r316, %r317

        sdiv     x9, x11, x10
        //  ret i32 %r219

        mov     x0, x9
        mov     sp, x29
        ret
        //bb49:

bb49:

        //  %r221 = icmp eq i32 %r315, 37

        mov     x9, #37
        cmp     x12, x9
        //  br i1 %r221, label %bb51, label %bb52


        b.eq     bb51
        b     bb52
        //bb51:

bb51:

        //  %r224 = call i32 @mod(i32 %r316, i32 %r317)

        mov     x0, x11
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
        mov     x9, x0
        //  ret i32 %r224

        mov     x0, x9
        mov     sp, x29
        ret
        //bb52:

bb52:

        //  ret i32 0

        mov     x9, #0
        mov     x0, x9
        mov     sp, x29
        ret
        //%r435->x9
        //%r434->x9
        //%r433->x9
        //%r335->x9
        //%r462->x10
        //%r452->x9
        //%r325->x9
        //%r334->x10
        //%r461->x10
        //%r451->x9
        //%r324->x9
        //%r333->x11
        //%r460->x9
        //%r450->x9
        //%r323->x9
        //%r332->x12
        //%r459->x9
        //%r446->x9
        //%r319->x9
        //%r328->x11
        //%r455->x9
        //%r251->x10
        //%r247->x11
        //%r242->x9
        //%r448->x9
        //%r321->x9
        //%r330->x9
        //%r457->x9
        //%r271->x10
        //%r254->x10
        //%r283->x10
        //%r241->x10
        //%r447->x9
        //%r320->x9
        //%r329->x10
        //%r456->x9
        //%r270->x9
        //%r240->x10
        //%r494->x9
        //%r252->x11
        //%r239->x9
        //%r493->x9
        //%r445->x9
        //%r318->x9
        //%r327->x11
        //%r454->x9
        //%r268->x9
        //%r237->x9
        //%r491->x9
        //%r249->x11
        //%r236->x10
        //%r490->x9
        //%r442->x9
        //%r265->x11
        //%r441->x9
        //%r233->x10
        //%r487->x9
        //%r438->x9
        //%r231->x10
        //%r485->x9
        //%r436->x9
        //%r444->x10
        //%r326->x9
        //%r453->x9
        //%r267->x10
        //%r443->x9
        //%r449->x10
        //%r322->x9
        //%r331->x9
        //%r458->x9
        //%r272->x10
        //%r284->x9
        //%r437->x9
        //%r439->x9
        //%r440->x9
        //%r463->x10
        //%r464->x10
        //%r465->x10
        //%r466->x10
        //%r467->x10
        //%r468->x10
        //%r469->x10
        //%r470->x10
        //%r471->x10
        //%r472->x10
        //%r473->x10
        //%r474->x10
        //%r475->x10
        //%r476->x10
        //%r477->x9
        //%r478->x9
        //%r479->x9
        //%r480->x9
        //%r481->x9
        //%r482->x9
        //%r483->x9
        //%r484->x9
        //%r486->x9
        //%r488->x9
        //%r489->x9
        //%r492->x9
eval:

        //226:x29,#-4096

        //225:x29,#-2048

        //bb54:

bb54:

        //  %r318 = add i32 0, 0

        mov     x16, #4096
        sub     sp, sp, x16
        mov     x9, #0
        //  %r319 = add i32 0, 0

        mov     x9, #0
        //  %r320 = add i32 0, 0

        mov     x9, #0
        //  %r321 = add i32 0, 0

        mov     x9, #0
        //  %r322 = add i32 0, 0

        mov     x9, #0
        //  %r323 = add i32 0, 0

        mov     x9, #0
        //  %r324 = add i32 0, 0

        mov     x9, #0
        //  %r225 = alloca [ 256 x i32 ]

        //  %r226 = alloca [ 256 x i32 ]

        //  %r325 = add i32 0, 0

        mov     x9, #0
        //  %r326 = add i32 0, 0

        mov     x9, #0
        mov     x9, x9
        //  br label %bb55


        //bb55:  %r327 = phi i32 [ %r326, %bb54 ], [ %r335, %bb56 ]

        mov     x11, x9
        b     bb55
        //bb55:

bb55:

        //  %r327 = phi i32 [ %r326, %bb54 ], [ %r335, %bb56 ]

        //  %r229 = icmp slt i32 %r327, 256

        mov     x9, #256
        cmp     x11, x9
        //  br i1 %r229, label %bb56, label %bb57


        b.lt     bb56
        b     bb57
        //bb56:

bb56:

        //  %r231 = getelementptr [256 x i32 ], [256 x i32 ]* %r225, i32 0 , i32 %r327

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-2048
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r231

        mov     x9, #0
        str     x9, [x10]
        //  %r233 = getelementptr [256 x i32 ], [256 x i32 ]* %r226, i32 0 , i32 %r327

        mov     x9, #8
        mul     x10, x11, x9
        mov     x9, #-4096
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 0, i32* %r233

        mov     x9, #0
        str     x9, [x10]
        //  %r335 = add i32 %r327, 1

        add     x9, x11, #1
        //  br label %bb55


        //bb55:  %r327 = phi i32 [ %r326, %bb54 ], [ %r335, %bb56 ]

        mov     x11, x9
        b     bb55
        //bb57:

bb57:

        //  %r236 = load i32, i32* @cur_token

        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        ldr     x10, [x9]
        //  %r237 = load i32, i32* @TOKEN_NUM

        adrp     x9, TOKEN_NUM
        add     x9, x9, #:lo12:TOKEN_NUM
        ldr     x9, [x9]
        //  %r238 = icmp ne i32 %r236, %r237

        cmp     x10, x9
        //  br i1 %r238, label %bb58, label %bb59


        b.ne     bb58
        b     bb59
        //bb58:

bb58:

        //  %r239 = call i32 @panic()

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
        bl     panic
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  ret i32 %r239

        mov     x0, x9
        mov     sp, x29
        ret
        //bb59:

bb59:

        //  %r240 = load i32, i32* @num

        adrp     x9, num
        add     x9, x9, #:lo12:num
        ldr     x10, [x9]
        //  call void @stack_push(i32* %r225, i32 %r240)

        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x10
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
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @next_token()

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
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb61


        b     bb61
        //bb61:

bb61:

        //  %r241 = load i32, i32* @cur_token

        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        ldr     x10, [x9]
        //  %r242 = load i32, i32* @TOKEN_OTHER

        adrp     x9, TOKEN_OTHER
        add     x9, x9, #:lo12:TOKEN_OTHER
        ldr     x9, [x9]
        //  %r243 = icmp eq i32 %r241, %r242

        cmp     x10, x9
        //  br i1 %r243, label %bb62, label %bb63


        b.eq     bb62
        b     bb63
        //bb62:

bb62:

        //  %r331 = load i32, i32* @other

        adrp     x9, other
        add     x9, x9, #:lo12:other
        ldr     x9, [x9]
        //  %r247 = call i32 @get_op_prec(i32 %r331)

        mov     x0, x9
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
        bl     get_op_prec
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r248 = icmp eq i32 %r247, 0

        mov     x10, #0
        cmp     x11, x10
        //  br i1 %r248, label %bb64, label %bb65


        b.eq     bb64
        b     bb65
        //bb64:

bb64:

        //  br label %bb63


        b     bb63
        //bb65:

bb65:

        //  call void @next_token()

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
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb67


        b     bb67
        //bb67:

bb67:

        //  %r249 = call i32 @stack_size(i32* %r226)

        mov     x10, #-4096
        add     x10, x29, x10
        mov     x0, x10
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
        bl     stack_size
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r250 = icmp ne i32 %r249, 0

        mov     x10, #0
        cmp     x11, x10
        //  br i1 %r250, label %bb70, label %bb69


        b.ne     bb70
        b     bb69
        //bb70:

bb70:

        //  %r251 = call i32 @stack_peek(i32* %r226)

        mov     x10, #-4096
        add     x10, x29, x10
        mov     x0, x10
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
        bl     stack_peek
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
        //  %r252 = call i32 @get_op_prec(i32 %r251)

        mov     x0, x10
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
        bl     get_op_prec
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r254 = call i32 @get_op_prec(i32 %r331)

        mov     x0, x9
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
        bl     get_op_prec
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
        //  %r255 = icmp sge i32 %r252, %r254

        cmp     x11, x10
        //  br i1 %r255, label %bb68, label %bb69


        b.ge     bb68
        b     bb69
        //bb68:

bb68:

        //  %r332 = call i32 @stack_pop(i32* %r226)

        mov     x10, #-4096
        add     x10, x29, x10
        mov     x0, x10
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
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x12, x0
        //  %r333 = call i32 @stack_pop(i32* %r225)

        mov     x10, #-2048
        add     x10, x29, x10
        mov     x0, x10
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
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r334 = call i32 @stack_pop(i32* %r225)

        mov     x10, #-2048
        add     x10, x29, x10
        mov     x0, x10
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
        bl     stack_pop
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
        //  %r265 = call i32 @eval_op(i32 %r332, i32 %r334, i32 %r333)

        mov     x0, x12
        mov     x1, x10
        mov     x2, x11
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
        bl     eval_op
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  call void @stack_push(i32* %r225, i32 %r265)

        mov     x10, #-2048
        add     x10, x29, x10
        mov     x0, x10
        mov     x1, x11
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
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb67


        b     bb67
        //bb69:

bb69:

        //  call void @stack_push(i32* %r226, i32 %r331)

        mov     x10, #-4096
        add     x10, x29, x10
        mov     x0, x10
        mov     x1, x9
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
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r267 = load i32, i32* @cur_token

        adrp     x9, cur_token
        add     x9, x9, #:lo12:cur_token
        ldr     x10, [x9]
        //  %r268 = load i32, i32* @TOKEN_NUM

        adrp     x9, TOKEN_NUM
        add     x9, x9, #:lo12:TOKEN_NUM
        ldr     x9, [x9]
        //  %r269 = icmp ne i32 %r267, %r268

        cmp     x10, x9
        //  br i1 %r269, label %bb71, label %bb72


        b.ne     bb71
        b     bb72
        //bb71:

bb71:

        //  %r270 = call i32 @panic()

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
        bl     panic
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  ret i32 %r270

        mov     x0, x9
        mov     sp, x29
        ret
        //bb72:

bb72:

        //  %r271 = load i32, i32* @num

        adrp     x9, num
        add     x9, x9, #:lo12:num
        ldr     x10, [x9]
        //  call void @stack_push(i32* %r225, i32 %r271)

        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x10
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
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @next_token()

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
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb61


        b     bb61
        //bb63:

bb63:

        //  call void @next_token()

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
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb74


        b     bb74
        //bb74:

bb74:

        //  %r272 = call i32 @stack_size(i32* %r226)

        mov     x9, #-4096
        add     x9, x29, x9
        mov     x0, x9
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
        bl     stack_size
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
        //  %r273 = icmp ne i32 %r272, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r273, label %bb75, label %bb76


        b.ne     bb75
        b     bb76
        //bb75:

bb75:

        //  %r328 = call i32 @stack_pop(i32* %r226)

        mov     x9, #-4096
        add     x9, x29, x9
        mov     x0, x9
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
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r329 = call i32 @stack_pop(i32* %r225)

        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
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
        bl     stack_pop
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
        //  %r330 = call i32 @stack_pop(i32* %r225)

        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
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
        bl     stack_pop
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  %r283 = call i32 @eval_op(i32 %r328, i32 %r330, i32 %r329)

        mov     x0, x11
        mov     x1, x9
        mov     x2, x10
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
        bl     eval_op
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
        //  call void @stack_push(i32* %r225, i32 %r283)

        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
        mov     x1, x10
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
        bl     stack_push
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb74


        b     bb74
        //bb76:

bb76:

        //  %r284 = call i32 @stack_peek(i32* %r225)

        mov     x9, #-2048
        add     x9, x29, x9
        mov     x0, x9
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
        bl     stack_peek
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  ret i32 %r284

        mov     x0, x9
        mov     sp, x29
        ret
        //%r289->x9
        //%r497->x9
        //%r336->x9
        //%r337->x9
        //%r338->x10
        //%r339->x9
        //%r495->x9
        //%r496->x9
        //%r498->x9
        //%r499->x9
        //%r500->x9
main:

        //bb77:

bb77:

        //  call void @_sysy_starttime(i32 205)

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #205
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
        //  %r336 = add i32 0, 0

        mov     x9, #0
        //  %r337 = call i32 @getint()

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
        mov     x9, x0
        //  call void @getch()

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
        bl     getch
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @next_token()

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
        bl     next_token
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  br label %bb78


        //bb78:  %r338 = phi i32 [ %r337, %bb77 ], [ %r339, %bb79 ]

        mov     x10, x9
        b     bb78
        //bb78:

bb78:

        //  %r338 = phi i32 [ %r337, %bb77 ], [ %r339, %bb79 ]

        //  %r288 = icmp ne i32 %r338, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r288, label %bb79, label %bb80


        b.ne     bb79
        b     bb80
        //bb79:

bb79:

        //  %r289 = call i32 @eval()

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
        bl     eval
        ldp     x29, x30, [sp], #16
        ldr     x27, [sp], #8
        ldp     x25, x26, [sp], #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x15, x20, [sp], #16
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x9, x0
        //  call void @putint(i32 %r289)

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
        //  call void @putch(i32 10)

        mov     x9, #10
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
        //  %r339 = sub i32 %r338, 1

        sub     x9, x10, #1
        //  br label %bb78


        //bb78:  %r338 = phi i32 [ %r337, %bb77 ], [ %r339, %bb79 ]

        mov     x10, x9
        b     bb78
        //bb80:

bb80:

        //  call void @_sysy_stoptime(i32 214)

        mov     x9, #214
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
