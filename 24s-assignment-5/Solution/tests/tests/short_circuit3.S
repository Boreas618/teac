.section .data
.global    a
.global    b
.global    d
a:
        .quad   0
b:
        .quad   0
d:
        .quad   0
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global set_a
.global set_b
.global set_d
.global main
        //%r100->x10
        //%r103->x9
        //%r194->x9
        //%r176->x9
        //%r177->x10
        //%r195->x9
        //%r196->x9
set_a:

        //bb47:

bb47:

        //  %r176 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r177 = add i32 %r100, 0

        mov     x10, x10
        //  store i32 %r177, i32* @a

        adrp     x9, a
        add     x9, x9, #:lo12:a
        str     x10, [x9]
        //  %r103 = load i32, i32* @a

        adrp     x9, a
        add     x9, x9, #:lo12:a
        ldr     x9, [x9]
        //  ret i32 %r103

        mov     x0, x9
        mov     sp, x29
        ret
        //%r104->x10
        //%r107->x9
        //%r198->x9
        //%r178->x9
        //%r179->x10
        //%r197->x9
        //%r199->x9
set_b:

        //bb48:

bb48:

        //  %r178 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r179 = add i32 %r104, 0

        mov     x10, x10
        //  store i32 %r179, i32* @b

        adrp     x9, b
        add     x9, x9, #:lo12:b
        str     x10, [x9]
        //  %r107 = load i32, i32* @b

        adrp     x9, b
        add     x9, x9, #:lo12:b
        ldr     x9, [x9]
        //  ret i32 %r107

        mov     x0, x9
        mov     sp, x29
        ret
        //%r108->x10
        //%r111->x9
        //%r202->x9
        //%r180->x9
        //%r181->x10
        //%r200->x9
        //%r201->x9
set_d:

        //bb49:

bb49:

        //  %r180 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
        mov     x9, #0
        //  %r181 = add i32 %r108, 0

        mov     x10, x10
        //  store i32 %r181, i32* @d

        adrp     x9, d
        add     x9, x9, #:lo12:d
        str     x10, [x9]
        //  %r111 = load i32, i32* @d

        adrp     x9, d
        add     x9, x9, #:lo12:d
        ldr     x9, [x9]
        //  ret i32 %r111

        mov     x0, x9
        mov     sp, x29
        ret
        //%r237->x10
        //%r233->x9
        //%r231->x9
        //%r229->x9
        //%r228->x9
        //%r227->x9
        //%r226->x9
        //%r225->x9
        //%r224->x10
        //%r223->x9
        //%r222->x10
        //%r221->x9
        //%r220->x9
        //%r219->x9
        //%r218->x9
        //%r217->x9
        //%r216->x9
        //%r215->x9
        //%r214->x9
        //%r213->x9
        //%r212->x10
        //%r211->x9
        //%r210->x10
        //%r209->x9
        //%r208->x9
        //%r192->x10
        //%r190->x12
        //%r122->x9
        //%r249->x9
        //%r120->x10
        //%r247->x9
        //%r207->x9
        //%r236->x10
        //%r118->x10
        //%r245->x9
        //%r205->x9
        //%r123->x9
        //%r250->x9
        //%r182->x9
        //%r235->x11
        //%r117->x9
        //%r244->x9
        //%r204->x9
        //%r187->x9
        //%r234->x9
        //%r116->x9
        //%r243->x9
        //%r203->x9
        //%r185->x9
        //%r232->x9
        //%r114->x10
        //%r241->x10
        //%r230->x9
        //%r112->x10
        //%r239->x10
        //%r183->x9
        //%r184->x9
        //%r127->x11
        //%r254->x14
        //%r186->x9
        //%r129->x10
        //%r256->x14
        //%r188->x9
        //%r189->x13
        //%r132->x10
        //%r259->x13
        //%r191->x11
        //%r134->x9
        //%r261->x11
        //%r193->x9
        //%r206->x9
        //%r238->x10
        //%r240->x10
        //%r242->x10
        //%r246->x9
        //%r248->x9
        //%r251->x9
        //%r252->x9
        //%r253->x14
        //%r255->x14
        //%r257->x14
        //%r258->x14
        //%r260->x11
        //%r262->x11
        //%r263->x11
        //%r264->x9
        //%r265->x9
        //%r266->x9
        //%r267->x9
main:

        //bb4:

bb4:

        //  %r182 = add i32 0, 0

        mov     x16, #0
        sub     sp, sp, x16
        mov     x9, #0
        //  %r183 = add i32 0, 0

        mov     x9, #0
        //  %r184 = add i32 0, 0

        mov     x9, #0
        //  %r185 = add i32 0, 0

        mov     x9, #0
        //  %r186 = add i32 0, 0

        mov     x9, #0
        //  %r187 = add i32 0, 0

        mov     x9, #0
        //  call void @_sysy_starttime(i32 97)

        mov     x9, #97
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
        //  store i32 2, i32* @a

        mov     x10, #2
        adrp     x9, a
        add     x9, x9, #:lo12:a
        str     x10, [x9]
        //  store i32 3, i32* @b

        mov     x10, #3
        adrp     x9, b
        add     x9, x9, #:lo12:b
        str     x10, [x9]
        //  %r112 = call i32 @set_a(i32 0)

        mov     x9, #0
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     set_a
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r113 = icmp ne i32 %r112, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r113, label %bb8, label %bb6


        b.ne     bb8
        b     bb6
        //bb8:

bb8:

        //  %r114 = call i32 @set_b(i32 1)

        mov     x9, #1
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     set_b
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r115 = icmp ne i32 %r114, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r115, label %bb5, label %bb6


        b.ne     bb5
        b     bb6
        //bb5:

bb5:

        //  br label %bb7


        b     bb7
        //bb6:

bb6:

        //  br label %bb7


        b     bb7
        //bb7:

bb7:

        //  %r116 = load i32, i32* @a

        adrp     x9, a
        add     x9, x9, #:lo12:a
        ldr     x9, [x9]
        //  call void @putint(i32 %r116)

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
        //  call void @putch(i32 32)

        mov     x9, #32
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
        //  %r117 = load i32, i32* @b

        adrp     x9, b
        add     x9, x9, #:lo12:b
        ldr     x9, [x9]
        //  call void @putint(i32 %r117)

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
        //  call void @putch(i32 32)

        mov     x9, #32
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
        //  store i32 2, i32* @a

        mov     x10, #2
        adrp     x9, a
        add     x9, x9, #:lo12:a
        str     x10, [x9]
        //  store i32 3, i32* @b

        mov     x10, #3
        adrp     x9, b
        add     x9, x9, #:lo12:b
        str     x10, [x9]
        //  %r118 = call i32 @set_a(i32 0)

        mov     x9, #0
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     set_a
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r119 = icmp ne i32 %r118, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r119, label %bb12, label %bb10


        b.ne     bb12
        b     bb10
        //bb12:

bb12:

        //  %r120 = call i32 @set_b(i32 1)

        mov     x9, #1
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     set_b
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r121 = icmp ne i32 %r120, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r121, label %bb9, label %bb10


        b.ne     bb9
        b     bb10
        //bb9:

bb9:

        //  br label %bb11


        b     bb11
        //bb10:

bb10:

        //  br label %bb11


        b     bb11
        //bb11:

bb11:

        //  %r122 = load i32, i32* @a

        adrp     x9, a
        add     x9, x9, #:lo12:a
        ldr     x9, [x9]
        //  call void @putint(i32 %r122)

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
        //  call void @putch(i32 32)

        mov     x9, #32
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
        //  %r123 = load i32, i32* @b

        adrp     x9, b
        add     x9, x9, #:lo12:b
        ldr     x9, [x9]
        //  call void @putint(i32 %r123)

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
        //  call void @putch(i32 10)

        mov     x9, #10
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
        //  %r188 = add i32 1, 0

        mov     x9, #1
        mov     x9, x9
        //  store i32 2, i32* @d

        mov     x11, #2
        adrp     x10, d
        add     x10, x10, #:lo12:d
        str     x11, [x10]
        //  %r126 = icmp sge i32 %r188, 1

        mov     x10, #1
        cmp     x9, x10
        //  br i1 %r126, label %bb16, label %bb14


        b.ge     bb16
        b     bb14
        //bb16:

bb16:

        //  %r127 = call i32 @set_d(i32 3)

        mov     x10, #3
        mov     x0, x10
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     set_d
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x11, x0
        //  %r128 = icmp ne i32 %r127, 0

        mov     x10, #0
        cmp     x11, x10
        //  br i1 %r128, label %bb13, label %bb14


        b.ne     bb13
        b     bb14
        //bb13:

bb13:

        //  br label %bb15


        b     bb15
        //bb14:

bb14:

        //  br label %bb15


        b     bb15
        //bb15:

bb15:

        //  %r129 = load i32, i32* @d

        adrp     x10, d
        add     x10, x10, #:lo12:d
        ldr     x10, [x10]
        //  call void @putint(i32 %r129)

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
        //  call void @putch(i32 32)

        mov     x10, #32
        mov     x0, x10
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
        //  %r131 = icmp sle i32 %r188, 1

        mov     x10, #1
        cmp     x9, x10
        //  br i1 %r131, label %bb17, label %bb20


        b.le     bb17
        b     bb20
        //bb20:

bb20:

        //  %r132 = call i32 @set_d(i32 4)

        mov     x9, #4
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     set_d
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        mov     x10, x0
        //  %r133 = icmp ne i32 %r132, 0

        mov     x9, #0
        cmp     x10, x9
        //  br i1 %r133, label %bb17, label %bb18


        b.ne     bb17
        b     bb18
        //bb17:

bb17:

        //  br label %bb19


        b     bb19
        //bb18:

bb18:

        //  br label %bb19


        b     bb19
        //bb19:

bb19:

        //  %r134 = load i32, i32* @d

        adrp     x9, d
        add     x9, x9, #:lo12:d
        ldr     x9, [x9]
        //  call void @putint(i32 %r134)

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
        //  call void @putch(i32 10)

        mov     x9, #10
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
        //  call void @putch(i32 10)

        mov     x9, #10
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
        //  %r189 = add i32 0, 0

        mov     x9, #0
        mov     x13, x9
        //  %r190 = add i32 1, 0

        mov     x9, #1
        mov     x12, x9
        //  %r191 = add i32 2, 0

        mov     x9, #2
        mov     x11, x9
        //  %r192 = add i32 3, 0

        mov     x9, #3
        mov     x10, x9
        //  %r193 = add i32 4, 0

        mov     x9, #4
        mov     x9, x9
        //  br label %bb21


        b     bb21
        //bb21:

bb21:

        //  %r141 = icmp ne i32 %r189, 0

        mov     x14, #0
        cmp     x13, x14
        //  br i1 %r141, label %bb24, label %bb23


        b.ne     bb24
        b     bb23
        //bb24:

bb24:

        //  %r143 = icmp ne i32 %r190, 0

        mov     x14, #0
        cmp     x12, x14
        //  br i1 %r143, label %bb22, label %bb23


        b.ne     bb22
        b     bb23
        //bb22:

bb22:

        //  call void @putch(i32 32)

        mov     x14, #32
        mov     x0, x14
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
        //  br label %bb21


        b     bb21
        //bb23:

bb23:

        //  %r145 = icmp ne i32 %r189, 0

        mov     x14, #0
        cmp     x13, x14
        //  br i1 %r145, label %bb25, label %bb28


        b.ne     bb25
        b     bb28
        //bb28:

bb28:

        //  %r147 = icmp ne i32 %r190, 0

        mov     x14, #0
        cmp     x12, x14
        //  br i1 %r147, label %bb25, label %bb26


        b.ne     bb25
        b     bb26
        //bb25:

bb25:

        //  call void @putch(i32 67)

        mov     x14, #67
        mov     x0, x14
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
        //  br label %bb27


        b     bb27
        //bb26:

bb26:

        //  br label %bb27


        b     bb27
        //bb27:

bb27:

        //  %r150 = icmp sge i32 %r189, %r190

        cmp     x13, x12
        //  br i1 %r150, label %bb29, label %bb32


        b.ge     bb29
        b     bb32
        //bb32:

bb32:

        //  %r153 = icmp sle i32 %r190, %r189

        cmp     x12, x13
        //  br i1 %r153, label %bb29, label %bb30


        b.le     bb29
        b     bb30
        //bb29:

bb29:

        //  call void @putch(i32 72)

        mov     x13, #72
        mov     x0, x13
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
        //  br label %bb31


        b     bb31
        //bb30:

bb30:

        //  br label %bb31


        b     bb31
        //bb31:

bb31:

        //  %r156 = icmp sge i32 %r191, %r190

        cmp     x11, x12
        //  br i1 %r156, label %bb36, label %bb34


        b.ge     bb36
        b     bb34
        //bb36:

bb36:

        //  %r159 = icmp ne i32 %r193, %r192

        cmp     x9, x10
        //  br i1 %r159, label %bb33, label %bb34


        b.ne     bb33
        b     bb34
        //bb33:

bb33:

        //  call void @putch(i32 73)

        mov     x11, #73
        mov     x0, x11
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
        //  br label %bb35


        b     bb35
        //bb34:

bb34:

        //  br label %bb35


        b     bb35
        //bb35:

bb35:

        //  %r161 = icmp ne i32 %r190, 0

        mov     x11, #0
        cmp     x12, x11
        //  br i1 %r161, label %bb40, label %bb41


        b.ne     bb40
        b     bb41
        //bb41:

bb41:

        //  %r164 = icmp slt i32 %r192, %r192

        cmp     x10, x10
        //  br i1 %r164, label %bb37, label %bb40


        b.lt     bb37
        b     bb40
        //bb40:

bb40:

        //  %r167 = icmp sge i32 %r193, %r193

        cmp     x9, x9
        //  br i1 %r167, label %bb37, label %bb38


        b.ge     bb37
        b     bb38
        //bb37:

bb37:

        //  call void @putch(i32 74)

        mov     x11, #74
        mov     x0, x11
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
        //  br label %bb39


        b     bb39
        //bb38:

bb38:

        //  br label %bb39


        b     bb39
        //bb39:

bb39:

        //  %r169 = icmp ne i32 %r190, 0

        mov     x11, #0
        cmp     x12, x11
        //  br i1 %r169, label %bb45, label %bb42


        b.ne     bb45
        b     bb42
        //bb45:

bb45:

        //  %r172 = icmp slt i32 %r192, %r192

        cmp     x10, x10
        //  br i1 %r172, label %bb46, label %bb43


        b.lt     bb46
        b     bb43
        //bb46:

bb46:

        //  %r175 = icmp sge i32 %r193, %r193

        cmp     x9, x9
        //  br i1 %r175, label %bb42, label %bb43


        b.ge     bb42
        b     bb43
        //bb42:

bb42:

        //  call void @putch(i32 75)

        mov     x9, #75
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
        //  br label %bb44


        b     bb44
        //bb43:

bb43:

        //  br label %bb44


        b     bb44
        //bb44:

bb44:

        //  call void @putch(i32 10)

        mov     x9, #10
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
        //  call void @_sysy_stoptime(i32 117)

        mov     x9, #117
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
