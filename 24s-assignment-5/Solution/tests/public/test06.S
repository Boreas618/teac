.section .data
.section .text
.global getch
.global getint
.global putch
.global putint
.global putarray
.global _sysy_starttime
.global _sysy_stoptime
.global foo
.global main
        //%r100->x11
        //%r101->x10
        //%r102->x11
        //%r141->x10
        //%r103->x10
        //%r142->x9
        //%r143->x9
        //%r144->x9
        //%r145->x10
        //%r146->x9
        //%r147->x9
        //%r148->x9
foo:

        //bb1:

bb1:

        //  %r101 = getelementptr %Bar, %Bar* %r100, i32 1

        mov     x16, #0
        sub     sp, sp, x16
        mov     x11, x0
        mov     x10, #1
        mov     x9, #256
        mul     x9, x10, x9
        add     x10, x11, x9
        //  %r102 = getelementptr %Bar, %Bar* %r101, i32 0, i32 2

        mov     x9, #176
        add     x11, x10, x9
        //  %r103 = getelementptr [10 x i32 ], [10 x i32 ]* %r102, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x9, x10, x9
        add     x10, x11, x9
        //  store i32 5, i32* %r103

        mov     x9, #5
        str     x9, [x10]
        //  ret void

        mov     sp, x29
        ret
        //%r163->x9
        //%r162->x9
        //%r161->x9
        //%r160->x10
        //%r159->x9
        //%r158->x10
        //%r157->x9
        //%r156->x9
        //%r155->x9
        //%r154->x9
        //%r153->x9
        //%r152->x10
        //%r151->x9
        //%r150->x10
        //%r149->x9
        //%r140->x9
        //%r139->x9
        //%r138->x11
        //%r137->x10
        //%r136->x9
        //%r135->x9
        //%r134->x10
        //%r117->x10
        //%r116->x11
        //%r115->x10
        //%r114->x10
        //%r113->x10
        //%r171->x9
        //%r112->x11
        //%r170->x9
        //%r111->x10
        //%r169->x9
        //%r110->x10
        //%r168->x10
        //%r109->x10
        //%r167->x9
        //%r108->x10
        //%r166->x10
        //%r107->x10
        //%r234->x9
        //%r165->x9
        //%r106->x10
        //%r233->x9
        //%r164->x9
        //%r105->x10
        //%r232->x9
        //%r118->x10
        //%r119->x10
        //%r120->x10
        //%r121->x9
        //%r122->x9
        //%r123->x10
        //%r124->x10
        //%r125->x9
        //%r126->x9
        //%r127->x10
        //%r128->x11
        //%r129->x10
        //%r130->x9
        //%r131->x9
        //%r132->x10
        //%r133->x11
        //%r172->x10
        //%r173->x9
        //%r174->x9
        //%r175->x9
        //%r176->x9
        //%r177->x10
        //%r178->x9
        //%r179->x10
        //%r180->x9
        //%r181->x9
        //%r182->x9
        //%r183->x10
        //%r184->x9
        //%r185->x9
        //%r186->x9
        //%r187->x9
        //%r188->x9
        //%r189->x9
        //%r190->x10
        //%r191->x9
        //%r192->x10
        //%r193->x9
        //%r194->x9
        //%r195->x9
        //%r196->x9
        //%r197->x10
        //%r198->x9
        //%r199->x10
        //%r200->x9
        //%r201->x9
        //%r202->x9
        //%r203->x9
        //%r204->x10
        //%r205->x9
        //%r206->x10
        //%r207->x9
        //%r208->x9
        //%r209->x9
        //%r210->x10
        //%r211->x9
        //%r212->x9
        //%r213->x9
        //%r214->x10
        //%r215->x9
        //%r216->x10
        //%r217->x9
        //%r218->x9
        //%r219->x9
        //%r220->x10
        //%r221->x9
        //%r222->x9
        //%r223->x9
        //%r224->x10
        //%r225->x9
        //%r226->x10
        //%r227->x9
        //%r228->x9
        //%r229->x9
        //%r230->x10
        //%r231->x9
main:

        //104:x29,#-2560

        //bb2:

bb2:

        //  call void @_sysy_starttime(i32 18)

        mov     x16, #2560
        sub     sp, sp, x16
        mov     x9, #18
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
        //  %r104 = alloca [ 10 x %Bar ]

        //  %r105 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 0

        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r106 = getelementptr %Bar, %Bar* %r105, i32 0, i32 0

        mov     x9, #0
        add     x10, x10, x9
        //  %r107 = getelementptr %Node, %Node* %r106, i32 0, i32 0

        mov     x9, #0
        add     x10, x10, x9
        //  store i32 1, i32* %r107

        mov     x9, #1
        str     x9, [x10]
        //  %r108 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 0

        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r109 = getelementptr %Bar, %Bar* %r108, i32 0, i32 0

        mov     x9, #0
        add     x10, x10, x9
        //  %r110 = getelementptr %Node, %Node* %r109, i32 0, i32 1

        mov     x9, #8
        add     x10, x10, x9
        //  store i32 2, i32* %r110

        mov     x9, #2
        str     x9, [x10]
        //  %r111 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 0

        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r112 = getelementptr %Bar, %Bar* %r111, i32 0, i32 1

        mov     x9, #16
        add     x11, x10, x9
        //  %r113 = getelementptr [10 x %Node ], [10 x %Node ]* %r112, i32 0, i32 2

        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        //  %r114 = getelementptr %Node, %Node* %r113, i32 0, i32 0

        mov     x9, #0
        add     x10, x10, x9
        //  store i32 3, i32* %r114

        mov     x9, #3
        str     x9, [x10]
        //  %r115 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 0

        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r116 = getelementptr %Bar, %Bar* %r115, i32 0, i32 1

        mov     x9, #16
        add     x11, x10, x9
        //  %r117 = getelementptr [10 x %Node ], [10 x %Node ]* %r116, i32 0, i32 2

        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        //  %r118 = getelementptr %Node, %Node* %r117, i32 0, i32 1

        mov     x9, #8
        add     x10, x10, x9
        //  store i32 4, i32* %r118

        mov     x9, #4
        str     x9, [x10]
        //  call void @foo(%Bar* %r104)

        mov     x9, #-2560
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
        //  %r119 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 0

        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r120 = getelementptr %Bar, %Bar* %r119, i32 0, i32 0

        mov     x9, #0
        add     x10, x10, x9
        //  %r121 = getelementptr %Node, %Node* %r120, i32 0, i32 0

        mov     x9, #0
        add     x9, x10, x9
        //  %r122 = load i32, i32* %r121

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
        //  %r123 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 0

        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r124 = getelementptr %Bar, %Bar* %r123, i32 0, i32 0

        mov     x9, #0
        add     x10, x10, x9
        //  %r125 = getelementptr %Node, %Node* %r124, i32 0, i32 1

        mov     x9, #8
        add     x9, x10, x9
        //  %r126 = load i32, i32* %r125

        ldr     x9, [x9]
        //  call void @putint(i32 %r126)

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
        //  %r127 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 0

        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r128 = getelementptr %Bar, %Bar* %r127, i32 0, i32 1

        mov     x9, #16
        add     x11, x10, x9
        //  %r129 = getelementptr [10 x %Node ], [10 x %Node ]* %r128, i32 0, i32 2

        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        //  %r130 = getelementptr %Node, %Node* %r129, i32 0, i32 0

        mov     x9, #0
        add     x9, x10, x9
        //  %r131 = load i32, i32* %r130

        ldr     x9, [x9]
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
        //  %r132 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 0

        mov     x10, #0
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r133 = getelementptr %Bar, %Bar* %r132, i32 0, i32 1

        mov     x9, #16
        add     x11, x10, x9
        //  %r134 = getelementptr [10 x %Node ], [10 x %Node ]* %r133, i32 0, i32 2

        mov     x10, #2
        mov     x9, #16
        mul     x9, x10, x9
        add     x10, x11, x9
        //  %r135 = getelementptr %Node, %Node* %r134, i32 0, i32 1

        mov     x9, #8
        add     x9, x10, x9
        //  %r136 = load i32, i32* %r135

        ldr     x9, [x9]
        //  call void @putint(i32 %r136)

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
        //  %r137 = getelementptr [10 x %Bar ], [10 x %Bar ]* %r104, i32 0, i32 1

        mov     x10, #1
        mov     x9, #256
        mul     x10, x10, x9
        mov     x9, #-2560
        add     x9, x29, x9
        add     x10, x9, x10
        //  %r138 = getelementptr %Bar, %Bar* %r137, i32 0, i32 2

        mov     x9, #176
        add     x11, x10, x9
        //  %r139 = getelementptr [10 x i32 ], [10 x i32 ]* %r138, i32 0 , i32 3

        mov     x10, #3
        mov     x9, #8
        mul     x9, x10, x9
        add     x9, x11, x9
        //  %r140 = load i32, i32* %r139

        ldr     x9, [x9]
        //  call void @putint(i32 %r140)

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
        //  call void @_sysy_stoptime(i32 30)

        mov     x9, #30
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
