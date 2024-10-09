.section .data
.global    d
.global    e
d:
        .zero   16
e:
        .zero   160
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global foo
.global baz
.global main
        //%r100->x11
        //%r101->x10
        //%r102->x9
        //%r103->x10
        //%r104->x9
        //%r132->x9
        //%r133->x9
foo:

        //bb1:

bb1:

        //  %r101 = call i32 @getint()

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
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
        mov     x10, x0
        //  %r102 = getelementptr %Node, %Node* %r100, i32 0, i32 0

        mov     x9, #0
        add     x9, x11, x9
        //  store i32 %r101, i32* %r102

        str     x10, [x9]
        //  %r103 = call i32 @getint()

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
        mov     x10, x0
        //  %r104 = getelementptr %Node, %Node* %r100, i32 0, i32 1

        mov     x9, #8
        add     x9, x11, x9
        //  store i32 %r103, i32* %r104

        str     x10, [x9]
        //  ret void

        mov     sp, x29
        ret
        //%r139->x11
        //%r110->x11
        //%r138->x12
        //%r109->x9
        //%r137->x11
        //%r108->x11
        //%r111->x10
        //%r140->x11
        //%r136->x11
        //%r107->x12
        //%r135->x11
        //%r106->x9
        //%r134->x12
        //%r105->x10
        //%r141->x10
baz:

        //bb2:

bb2:

        //  %r106 = call i32 @getint()

        mov     x16, #0
        sub     sp, sp, x16
        mov     x10, x0
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
        //  %r107 = getelementptr %Node, %Node* %r105, i32 2

        mov     x12, #2
        mov     x11, #16
        mul     x11, x12, x11
        add     x12, x10, x11
        //  %r108 = getelementptr %Node, %Node* %r107, i32 0, i32 0

        mov     x11, #0
        add     x11, x12, x11
        //  store i32 %r106, i32* %r108

        str     x9, [x11]
        //  %r109 = call i32 @getint()

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
        //  %r110 = getelementptr %Node, %Node* %r105, i32 2

        mov     x12, #2
        mov     x11, #16
        mul     x11, x12, x11
        add     x11, x10, x11
        //  %r111 = getelementptr %Node, %Node* %r110, i32 0, i32 1

        mov     x10, #8
        add     x10, x11, x10
        //  store i32 %r109, i32* %r111

        str     x9, [x10]
        //  ret void

        mov     sp, x29
        ret
        //%r131->x9
        //%r130->x10
        //%r129->x10
        //%r128->x11
        //%r127->x9
        //%r126->x9
        //%r142->x9
        //%r113->x10
        //%r172->x11
        //%r143->x10
        //%r114->x10
        //%r173->x10
        //%r144->x9
        //%r115->x9
        //%r174->x11
        //%r145->x9
        //%r116->x11
        //%r175->x10
        //%r146->x9
        //%r117->x9
        //%r176->x10
        //%r147->x10
        //%r118->x9
        //%r177->x9
        //%r148->x9
        //%r119->x9
        //%r178->x9
        //%r149->x9
        //%r120->x9
        //%r150->x9
        //%r121->x11
        //%r151->x9
        //%r122->x9
        //%r123->x9
        //%r124->x9
        //%r125->x10
        //%r152->x9
        //%r153->x9
        //%r154->x9
        //%r155->x9
        //%r156->x9
        //%r157->x10
        //%r158->x9
        //%r159->x9
        //%r160->x10
        //%r161->x9
        //%r162->x9
        //%r163->x10
        //%r164->x9
        //%r165->x10
        //%r166->x9
        //%r167->x10
        //%r168->x9
        //%r169->x10
        //%r170->x9
        //%r171->x9
main:

        //112:x29,#-16

        //bb3:

bb3:

        //  call void @_sysy_starttime(i32 13)

        mov     x16, #16
        sub     sp, sp, x16
        mov     x9, #13
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
        //  %r112 = alloca %Node

        //  %r113 = getelementptr %Node, %Node* %r112, i32 0, i32 0

        mov     x10, #0
        mov     x9, #-16
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 1, i32* %r113

        mov     x9, #1
        str     x9, [x10]
        //  %r114 = getelementptr %Node, %Node* %r112, i32 0, i32 1

        mov     x10, #8
        mov     x9, #-16
        add     x9, x29, x9
        add     x10, x9, x10
        //  store i32 2, i32* %r114

        mov     x9, #2
        str     x9, [x10]
        //  call void @foo(%Node* %r112)

        mov     x9, #-16
        add     x9, x29, x9
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     foo
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @foo(%Node* @d)

        adrp     x9, d
        add     x9, x9, #:lo12:d
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     foo
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  call void @baz(%Node* @e)

        adrp     x9, e
        add     x9, x9, #:lo12:e
        mov     x0, x9
        stp     x9, x10, [sp, #-16]!
        stp     x11, x12, [sp, #-16]!
        stp     x13, x14, [sp, #-16]!
        str     x15, [sp, #-8]!
        stp     x29, x30, [sp, #-16]!
        mov     x29, sp
        bl     baz
        ldp     x29, x30, [sp], #16
        ldr     x15, [sp], #8
        ldp     x13, x14, [sp], #16
        ldp     x11, x12, [sp], #16
        ldp     x9, x10, [sp], #16
        //  %r115 = getelementptr %Node, %Node* %r112, i32 0, i32 0

        mov     x10, #0
        mov     x9, #-16
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r116 = load i32, i32* %r115

        ldr     x11, [x9]
        //  %r117 = getelementptr %Node, %Node* %r112, i32 0, i32 1

        mov     x10, #8
        mov     x9, #-16
        add     x9, x29, x9
        add     x9, x9, x10
        //  %r118 = load i32, i32* %r117

        ldr     x9, [x9]
        //  %r119 = add i32 %r116, %r118

        add     x9, x11, x9
        //  call void @putint(i32 %r119)

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
        //  %r120 = getelementptr %Node, %Node* @d, i32 0, i32 0

        mov     x10, #0
        adrp     x9, d
        add     x9, x9, #:lo12:d
        add     x9, x9, x10
        //  %r121 = load i32, i32* %r120

        ldr     x11, [x9]
        //  %r122 = getelementptr %Node, %Node* @d, i32 0, i32 1

        mov     x10, #8
        adrp     x9, d
        add     x9, x9, #:lo12:d
        add     x9, x9, x10
        //  %r123 = load i32, i32* %r122

        ldr     x9, [x9]
        //  %r124 = add i32 %r121, %r123

        add     x9, x11, x9
        //  call void @putint(i32 %r124)

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
        //  %r125 = getelementptr [10 x %Node ], [10 x %Node ]* @e, i32 0, i32 2

        mov     x10, #2
        mov     x9, #16
        mul     x10, x10, x9
        adrp     x9, e
        add     x9, x9, #:lo12:e
        add     x10, x9, x10
        //  %r126 = getelementptr %Node, %Node* %r125, i32 0, i32 0

        mov     x9, #0
        add     x9, x10, x9
        //  %r127 = load i32, i32* %r126

        ldr     x9, [x9]
        //  %r128 = getelementptr [10 x %Node ], [10 x %Node ]* @e, i32 0, i32 2

        mov     x11, #2
        mov     x10, #16
        mul     x11, x11, x10
        adrp     x10, e
        add     x10, x10, #:lo12:e
        add     x11, x10, x11
        //  %r129 = getelementptr %Node, %Node* %r128, i32 0, i32 1

        mov     x10, #8
        add     x10, x11, x10
        //  %r130 = load i32, i32* %r129

        ldr     x10, [x10]
        //  %r131 = add i32 %r127, %r130

        add     x9, x9, x10
        //  call void @putint(i32 %r131)

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
        //  call void @_sysy_stoptime(i32 19)

        mov     x9, #19
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
