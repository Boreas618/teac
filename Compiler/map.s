	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"map.c"
	.text
	.align	2
	.arch armv7-a
	.syntax unified
	.arm
	.fpu neon
	.type	map_getref.isra.1, %function
map_getref.isra.1:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldrb	r3, [r2]	@ zero_extendqisi2
	push	{r4, r5, r6, r7, r8, lr}
	cmp	r3, #0
	beq	.L7
	mov	ip, r2
	movw	r4, #5381
.L3:
	add	r4, r4, r4, lsl #5
	eor	r4, r4, r3
	ldrb	r3, [ip, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L3
.L2:
	ldr	r6, [r1]
	cmp	r6, #0
	beq	.L1
	ldr	r3, [r0]
	sub	r6, r6, #1
	and	r6, r6, r4
	mov	r7, r2
	ldr	r5, [r3, r6, lsl #2]
	add	r6, r3, r6, lsl #2
	cmp	r5, #0
	bne	.L6
	b	.L9
.L5:
	add	r6, r5, #8
	ldr	r5, [r5, #8]
	cmp	r5, #0
	beq	.L9
.L6:
	ldr	r3, [r5]
	cmp	r3, r4
	bne	.L5
	mov	r1, r7
	add	r0, r5, #12
	bl	strcmp
	cmp	r0, #0
	bne	.L5
.L1:
	mov	r0, r6
	pop	{r4, r5, r6, r7, r8, pc}
.L9:
	mov	r6, r5
	mov	r0, r6
	pop	{r4, r5, r6, r7, r8, pc}
.L7:
	movw	r4, #5381
	b	.L2
	.size	map_getref.isra.1, .-map_getref.isra.1
	.align	2
	.global	map_get_
	.syntax unified
	.arm
	.fpu neon
	.type	map_get_, %function
map_get_:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r2, r1
	add	r1, r0, #4
	push	{r4, lr}
	bl	map_getref.isra.1
	cmp	r0, #0
	ldrne	r3, [r0]
	ldrne	r0, [r3, #4]
	pop	{r4, pc}
	.size	map_get_, .-map_get_
	.align	2
	.global	map_set_
	.syntax unified
	.arm
	.fpu neon
	.type	map_set_, %function
map_set_:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r4, r1
	mov	r9, r2
	mov	r2, r1
	add	r1, r0, #4
	mov	r5, r0
	mov	r8, r3
	bl	map_getref.isra.1
	cmp	r0, #0
	beq	.L22
	ldr	r3, [r0]
	mov	r2, r8
	mov	r1, r9
	ldr	r0, [r3, #4]
	bl	memcpy
	mov	r0, #0
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L22:
	mov	r0, r4
	bl	strlen
	mvn	r7, r0
	add	r10, r0, #1
	and	r7, r7, #3
	add	r0, r8, #12
	add	r7, r7, r10
	add	r0, r0, r7
	bl	malloc
	subs	r6, r0, #0
	beq	.L55
	mov	r2, r10
	mov	r1, r4
	add	r0, r6, #12
	bl	memcpy
	ldrb	r2, [r4]	@ zero_extendqisi2
	movw	r3, #5381
	cmp	r2, #0
	beq	.L24
.L25:
	add	r3, r3, r3, lsl #5
	eor	r3, r3, r2
	ldrb	r2, [r4, #1]!	@ zero_extendqisi2
	cmp	r2, #0
	bne	.L25
.L24:
	add	r0, r7, #12
	str	r3, [r6]
	add	r0, r6, r0
	mov	r2, r8
	mov	r1, r9
	mov	r3, #0
	str	r0, [r6, #4]
	str	r3, [r6, #8]
	bl	memcpy
	ldrd	r0, [r5, #4]
	cmp	r1, r0
	ldrcc	r2, [r5]
	bcc	.L26
	ldr	r2, [r5]
	cmp	r0, #0
	lslne	r7, r0, #1
	lslne	r9, r0, #3
	add	r0, r2, r0, lsl #2
	moveq	r9, #4
	moveq	r7, #1
	cmp	r0, r2
	mov	r4, #0
	beq	.L56
.L31:
	ldr	r3, [r0, #-4]!
	cmp	r3, #0
	bne	.L30
	b	.L57
.L42:
	mov	r3, r1
.L30:
	ldr	r1, [r3, #8]
	str	r4, [r3, #8]
	mov	r4, r3
	cmp	r1, #0
	bne	.L42
	mov	r4, r3
.L58:
	cmp	r0, r2
	bne	.L31
.L56:
	mov	r1, r9
	bl	realloc
	subs	r8, r0, #0
	beq	.L32
	mov	r2, r9
	str	r8, [r5]
	str	r7, [r5, #4]
	mov	r1, #0
	bl	memset
	cmp	r4, #0
	ldreq	r2, [r5]
	ldreq	r0, [r5, #4]
	beq	.L34
.L33:
	ldr	r0, [r5, #4]
	ldr	r2, [r5]
	sub	lr, r0, #1
.L36:
	ldr	r3, [r4]
	ldr	r1, [r4, #8]
	and	r3, r3, lr
	ldr	ip, [r2, r3, lsl #2]
	str	ip, [r4, #8]
	str	r4, [r2, r3, lsl #2]
	subs	r4, r1, #0
	bne	.L36
	cmp	r8, #0
	beq	.L35
.L34:
	ldr	r1, [r5, #8]
.L26:
	ldr	ip, [r6]
	sub	r3, r0, #1
	add	r1, r1, #1
	mov	r0, #0
	and	r3, r3, ip
	ldr	ip, [r2, r3, lsl #2]
	str	ip, [r6, #8]
	str	r6, [r2, r3, lsl #2]
	str	r1, [r5, #8]
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L57:
	mov	r3, r4
	mov	r4, r3
	b	.L58
.L32:
	ldr	r0, [r5]
	cmp	r0, #0
	beq	.L35
	ldr	r2, [r5, #4]
	mov	r1, r8
	lsl	r2, r2, #2
	bl	memset
	cmp	r4, #0
	bne	.L33
.L35:
	mov	r0, r6
	bl	free
.L55:
	mvn	r0, #0
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
	.size	map_set_, .-map_set_
	.align	2
	.global	__built__in__sy_f_init
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_init, %function
__built__in__sy_f_init:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov.i32	q8, #0  @ v16qi
	movw	r3, #:lower16:.LANCHOR0
	movt	r3, #:upper16:.LANCHOR0
	vst1.8	{q8}, [r3]
	vstr	d16, [r3, #12]
	bx	lr
	.size	__built__in__sy_f_init, .-__built__in__sy_f_init
	.align	2
	.global	__built__in__sy_f_get
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_get, %function
__built__in__sy_f_get:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movw	r3, #:lower16:.LANCHOR0
	movt	r3, #:upper16:.LANCHOR0
	vldr.32	s0, [r3, #20]
	bx	lr
	.size	__built__in__sy_f_get, .-__built__in__sy_f_get
	.align	2
	.global	__built__in__sy_f_i_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_i_set, %function
__built__in__sy_f_i_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, r1
	vpush.64	{d8}
	mov	r2, r0
	movw	r1, #:lower16:.LC0
	movt	r1, #:upper16:.LC0
	vmov.f32	s16, s0
	sub	sp, sp, #104
	add	r0, sp, #4
	bl	sprintf
	add	r0, sp, #4
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #4
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #104
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_i_set, .-__built__in__sy_f_i_set
	.align	2
	.global	__built__in__sy_f_i_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_i_find, %function
__built__in__sy_f_i_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movw	r4, #:lower16:.LANCHOR0
	sub	sp, sp, #104
	movt	r4, #:upper16:.LANCHOR0
	mov	r3, r1
	mov	r2, r0
	movw	r1, #:lower16:.LC0
	add	r0, sp, #4
	movt	r1, #:upper16:.LC0
	bl	sprintf
	add	r2, sp, #4
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L63
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L63:
	add	sp, sp, #104
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_i_find, .-__built__in__sy_f_i_find
	.align	2
	.global	__built__in__sy_f_f_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_f_set, %function
__built__in__sy_f_f_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s0
	mov	r2, r0
	push	{r4, lr}
	movw	r1, #:lower16:.LC1
	vpush.64	{d8}
	movt	r1, #:upper16:.LC1
	sub	sp, sp, #112
	vmov.f32	s16, s1
	add	r0, sp, #12
	vstr.64	d16, [sp]
	bl	sprintf
	add	r0, sp, #12
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #12
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #112
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_f_set, .-__built__in__sy_f_f_set
	.align	2
	.global	__built__in__sy_f_f_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_f_find, %function
__built__in__sy_f_f_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #112
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	movw	r1, #:lower16:.LC1
	add	r0, sp, #12
	movt	r1, #:upper16:.LC1
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #12
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L70
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L70:
	add	sp, sp, #112
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_f_find, .-__built__in__sy_f_f_find
	.align	2
	.global	__built__in__sy_f_ii_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_ii_set, %function
__built__in__sy_f_ii_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, r1
	vpush.64	{d8}
	movw	r1, #:lower16:.LC2
	movt	r1, #:upper16:.LC2
	vmov.f32	s16, s0
	sub	sp, sp, #112
	str	r2, [sp]
	mov	r2, r0
	add	r0, sp, #12
	bl	sprintf
	add	r0, sp, #12
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #12
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #112
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_ii_set, .-__built__in__sy_f_ii_set
	.align	2
	.global	__built__in__sy_f_ii_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_ii_find, %function
__built__in__sy_f_ii_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #112
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	mov	r3, r1
	str	r2, [sp]
	movw	r1, #:lower16:.LC2
	mov	r2, r0
	movt	r1, #:upper16:.LC2
	add	r0, sp, #12
	bl	sprintf
	add	r2, sp, #12
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L77
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L77:
	add	sp, sp, #112
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_ii_find, .-__built__in__sy_f_ii_find
	.align	2
	.global	__built__in__sy_f_if_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_if_set, %function
__built__in__sy_f_if_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s0
	mov	r3, r1
	push	{r4, lr}
	mov	r2, r0
	vpush.64	{d8}
	movw	r1, #:lower16:.LC3
	movt	r1, #:upper16:.LC3
	sub	sp, sp, #112
	vmov.f32	s16, s1
	add	r0, sp, #12
	vstr.64	d16, [sp]
	bl	sprintf
	add	r0, sp, #12
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #12
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #112
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_if_set, .-__built__in__sy_f_if_set
	.align	2
	.global	__built__in__sy_f_if_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_if_find, %function
__built__in__sy_f_if_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r3, r1
	push	{r4, lr}
	sub	sp, sp, #112
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	mov	r2, r0
	movw	r1, #:lower16:.LC3
	add	r0, sp, #12
	movt	r1, #:upper16:.LC3
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #12
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L84
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L84:
	add	sp, sp, #112
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_if_find, .-__built__in__sy_f_if_find
	.align	2
	.global	__built__in__sy_f_fi_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_fi_set, %function
__built__in__sy_f_fi_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s0
	mov	r2, r0
	push	{r4, lr}
	vpush.64	{d8}
	sub	sp, sp, #120
	vmov.f32	s16, s1
	add	r0, sp, #20
	vstr.64	d16, [sp]
	str	r1, [sp, #8]
	movw	r1, #:lower16:.LC4
	movt	r1, #:upper16:.LC4
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #120
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_fi_set, .-__built__in__sy_f_fi_set
	.align	2
	.global	__built__in__sy_f_fi_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_fi_find, %function
__built__in__sy_f_fi_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	str	r1, [sp, #8]
	add	r0, sp, #20
	movw	r1, #:lower16:.LC4
	movt	r1, #:upper16:.LC4
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L91
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L91:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_fi_find, .-__built__in__sy_f_fi_find
	.align	2
	.global	__built__in__sy_f_ff_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_ff_set, %function
__built__in__sy_f_ff_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	movw	r1, #:lower16:.LC5
	vpush.64	{d8}
	movt	r1, #:upper16:.LC5
	vcvt.f64.f32	d0, s0
	sub	sp, sp, #120
	add	r0, sp, #20
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	vmov.f32	s16, s2
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #120
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_ff_set, .-__built__in__sy_f_ff_set
	.align	2
	.global	__built__in__sy_f_ff_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_ff_find, %function
__built__in__sy_f_ff_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	movw	r1, #:lower16:.LC5
	add	r0, sp, #20
	movt	r1, #:upper16:.LC5
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L98
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L98:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_ff_find, .-__built__in__sy_f_ff_find
	.align	2
	.global	__built__in__sy_f_iii_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_iii_set, %function
__built__in__sy_f_iii_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	vpush.64	{d8}
	vmov.f32	s16, s0
	sub	sp, sp, #112
	strd	r2, [sp]
	mov	r3, r1
	mov	r2, r0
	movw	r1, #:lower16:.LC6
	add	r0, sp, #12
	movt	r1, #:upper16:.LC6
	bl	sprintf
	add	r0, sp, #12
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #12
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #112
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_iii_set, .-__built__in__sy_f_iii_set
	.align	2
	.global	__built__in__sy_f_iii_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_iii_find, %function
__built__in__sy_f_iii_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #112
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	strd	r2, [sp]
	mov	r3, r1
	mov	r2, r0
	movw	r1, #:lower16:.LC6
	add	r0, sp, #12
	movt	r1, #:upper16:.LC6
	bl	sprintf
	add	r2, sp, #12
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L105
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L105:
	add	sp, sp, #112
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_iii_find, .-__built__in__sy_f_iii_find
	.align	2
	.global	__built__in__sy_f_iif_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_iif_set, %function
__built__in__sy_f_iif_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s0
	mov	r3, r1
	push	{r4, lr}
	movw	r1, #:lower16:.LC7
	vpush.64	{d8}
	movt	r1, #:upper16:.LC7
	sub	sp, sp, #120
	vmov.f32	s16, s1
	vstr.64	d16, [sp, #8]
	str	r2, [sp]
	mov	r2, r0
	add	r0, sp, #20
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #120
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_iif_set, .-__built__in__sy_f_iif_set
	.align	2
	.global	__built__in__sy_f_iif_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_iif_find, %function
__built__in__sy_f_iif_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r3, r1
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	str	r2, [sp]
	movw	r1, #:lower16:.LC7
	mov	r2, r0
	movt	r1, #:upper16:.LC7
	add	r0, sp, #20
	vstr.64	d0, [sp, #8]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L112
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L112:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_iif_find, .-__built__in__sy_f_iif_find
	.align	2
	.global	__built__in__sy_f_ifi_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_ifi_set, %function
__built__in__sy_f_ifi_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s0
	mov	r3, r1
	push	{r4, lr}
	movw	r1, #:lower16:.LC8
	vpush.64	{d8}
	movt	r1, #:upper16:.LC8
	sub	sp, sp, #120
	vmov.f32	s16, s1
	vstr.64	d16, [sp]
	str	r2, [sp, #8]
	mov	r2, r0
	add	r0, sp, #20
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #120
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_ifi_set, .-__built__in__sy_f_ifi_set
	.align	2
	.global	__built__in__sy_f_ifi_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_ifi_find, %function
__built__in__sy_f_ifi_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r3, r1
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	str	r2, [sp, #8]
	movw	r1, #:lower16:.LC8
	mov	r2, r0
	movt	r1, #:upper16:.LC8
	add	r0, sp, #20
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L119
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L119:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_ifi_find, .-__built__in__sy_f_ifi_find
	.align	2
	.global	__built__in__sy_f_iff_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_iff_set, %function
__built__in__sy_f_iff_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r3, r1
	push	{r4, lr}
	mov	r2, r0
	vpush.64	{d8}
	movw	r1, #:lower16:.LC9
	movt	r1, #:upper16:.LC9
	vcvt.f64.f32	d0, s0
	sub	sp, sp, #120
	add	r0, sp, #20
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	vmov.f32	s16, s2
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #120
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_iff_set, .-__built__in__sy_f_iff_set
	.align	2
	.global	__built__in__sy_f_iff_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_iff_find, %function
__built__in__sy_f_iff_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r3, r1
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	mov	r2, r0
	movw	r1, #:lower16:.LC9
	add	r0, sp, #20
	movt	r1, #:upper16:.LC9
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L126
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L126:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_iff_find, .-__built__in__sy_f_iff_find
	.align	2
	.global	__built__in__sy_f_fii_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_fii_set, %function
__built__in__sy_f_fii_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s0
	push	{r4, lr}
	vpush.64	{d8}
	sub	sp, sp, #120
	vmov.f32	s16, s1
	vstr.64	d16, [sp]
	str	r2, [sp, #12]
	mov	r2, r0
	str	r1, [sp, #8]
	add	r0, sp, #20
	movw	r1, #:lower16:.LC10
	movt	r1, #:upper16:.LC10
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #120
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_fii_set, .-__built__in__sy_f_fii_set
	.align	2
	.global	__built__in__sy_f_fii_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_fii_find, %function
__built__in__sy_f_fii_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	str	r2, [sp, #12]
	mov	r2, r0
	str	r1, [sp, #8]
	add	r0, sp, #20
	movw	r1, #:lower16:.LC10
	movt	r1, #:upper16:.LC10
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L133
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L133:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_fii_find, .-__built__in__sy_f_fii_find
	.align	2
	.global	__built__in__sy_f_fif_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_fif_set, %function
__built__in__sy_f_fif_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	vpush.64	{d8}
	vcvt.f64.f32	d0, s0
	sub	sp, sp, #128
	add	r0, sp, #28
	vstr.64	d16, [sp, #16]
	str	r1, [sp, #8]
	movw	r1, #:lower16:.LC11
	movt	r1, #:upper16:.LC11
	vstr.64	d0, [sp]
	vmov.f32	s16, s2
	bl	sprintf
	add	r0, sp, #28
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #28
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #128
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_fif_set, .-__built__in__sy_f_fif_set
	.align	2
	.global	__built__in__sy_f_fif_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_fif_find, %function
__built__in__sy_f_fif_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #128
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	str	r1, [sp, #8]
	add	r0, sp, #28
	movw	r1, #:lower16:.LC11
	movt	r1, #:upper16:.LC11
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #16]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #28
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L140
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L140:
	add	sp, sp, #128
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_fif_find, .-__built__in__sy_f_fif_find
	.align	2
	.global	__built__in__sy_f_ffi_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_ffi_set, %function
__built__in__sy_f_ffi_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	vpush.64	{d8}
	vcvt.f64.f32	d0, s0
	sub	sp, sp, #128
	add	r0, sp, #28
	vstr.64	d16, [sp, #8]
	str	r1, [sp, #16]
	movw	r1, #:lower16:.LC12
	movt	r1, #:upper16:.LC12
	vstr.64	d0, [sp]
	vmov.f32	s16, s2
	bl	sprintf
	add	r0, sp, #28
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #28
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #128
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_ffi_set, .-__built__in__sy_f_ffi_set
	.align	2
	.global	__built__in__sy_f_ffi_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_ffi_find, %function
__built__in__sy_f_ffi_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #128
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	str	r1, [sp, #16]
	add	r0, sp, #28
	movw	r1, #:lower16:.LC12
	movt	r1, #:upper16:.LC12
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #28
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L147
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L147:
	add	sp, sp, #128
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_ffi_find, .-__built__in__sy_f_ffi_find
	.align	2
	.global	__built__in__sy_f_fff_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_fff_set, %function
__built__in__sy_f_fff_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	movw	r1, #:lower16:.LC13
	vpush.64	{d8}
	movt	r1, #:upper16:.LC13
	vcvt.f64.f32	d17, s2
	sub	sp, sp, #128
	add	r0, sp, #28
	vstr.64	d16, [sp, #8]
	vcvt.f64.f32	d0, s0
	vstr.64	d17, [sp, #16]
	vstr.64	d0, [sp]
	vmov.f32	s16, s3
	bl	sprintf
	add	r0, sp, #28
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #28
	bl	memcpy
	vmov	ip, s16
	movw	r2, #:lower16:.LANCHOR0
	movt	r2, #:upper16:.LANCHOR0
	mov	r3, #4
	mov	r1, r0
	mov	r0, r2
	str	ip, [r2, #16]!	@ float
	bl	map_set_
	add	sp, sp, #128
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, pc}
	.size	__built__in__sy_f_fff_set, .-__built__in__sy_f_fff_set
	.align	2
	.global	__built__in__sy_f_fff_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_f_fff_find, %function
__built__in__sy_f_fff_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #128
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	movw	r1, #:lower16:.LC13
	add	r0, sp, #28
	movt	r1, #:upper16:.LC13
	vcvt.f64.f32	d1, s2
	vstr.64	d16, [sp, #8]
	vcvt.f64.f32	d0, s0
	vstr.64	d1, [sp, #16]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #28
	add	r1, r4, #4
	mov	r0, r4
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #12]
	beq	.L154
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #12]
	ldrne	r3, [r0]	@ float
	movne	r0, #1
	strne	r3, [r4, #20]	@ float
.L154:
	add	sp, sp, #128
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_f_fff_find, .-__built__in__sy_f_fff_find
	.align	2
	.global	__built__in__sy_i_init
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_init, %function
__built__in__sy_i_init:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L160
	vmov.i32	q8, #0  @ v16qi
	vst1.8	{q8}, [r3]
	vstr	d16, [r3, #12]
	bx	lr
.L161:
	.align	2
.L160:
	.word	.LANCHOR0+24
	.size	__built__in__sy_i_init, .-__built__in__sy_i_init
	.align	2
	.global	__built__in__sy_i_get
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_get, %function
__built__in__sy_i_get:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movw	r3, #:lower16:.LANCHOR0
	movt	r3, #:upper16:.LANCHOR0
	ldr	r0, [r3, #44]
	bx	lr
	.size	__built__in__sy_i_get, .-__built__in__sy_i_get
	.align	2
	.global	__built__in__sy_i_i_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_i_set, %function
__built__in__sy_i_i_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #108
	mov	r3, r1
	mov	r5, r2
	movw	r1, #:lower16:.LC0
	mov	r2, r0
	movt	r1, #:upper16:.LC0
	add	r0, sp, #4
	bl	sprintf
	add	r0, sp, #4
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #4
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #108
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_i_set, .-__built__in__sy_i_i_set
	.align	2
	.global	__built__in__sy_i_i_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_i_find, %function
__built__in__sy_i_i_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #104
	mov	r3, r1
	mov	r2, r0
	movw	r1, #:lower16:.LC0
	add	r0, sp, #4
	movt	r1, #:upper16:.LC0
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	bl	sprintf
	add	r2, sp, #4
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L165
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L165:
	add	sp, sp, #104
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_i_find, .-__built__in__sy_i_i_find
	.align	2
	.global	__built__in__sy_i_f_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_f_set, %function
__built__in__sy_i_f_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r2, r0
	push	{r4, r5, lr}
	sub	sp, sp, #116
	mov	r5, r1
	add	r0, sp, #12
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #12
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #12
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #116
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_f_set, .-__built__in__sy_i_f_set
	.align	2
	.global	__built__in__sy_i_f_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_f_find, %function
__built__in__sy_i_f_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #112
	movw	r1, #:lower16:.LC1
	add	r0, sp, #12
	movt	r1, #:upper16:.LC1
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #12
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L172
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L172:
	add	sp, sp, #112
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_f_find, .-__built__in__sy_i_f_find
	.align	2
	.global	__built__in__sy_i_ii_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_ii_set, %function
__built__in__sy_i_ii_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #116
	mov	r5, r3
	mov	r3, r1
	str	r2, [sp]
	movw	r1, #:lower16:.LC2
	mov	r2, r0
	movt	r1, #:upper16:.LC2
	add	r0, sp, #12
	bl	sprintf
	add	r0, sp, #12
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #12
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #116
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_ii_set, .-__built__in__sy_i_ii_set
	.align	2
	.global	__built__in__sy_i_ii_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_ii_find, %function
__built__in__sy_i_ii_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #112
	mov	r3, r1
	movw	r4, #:lower16:.LANCHOR0
	str	r2, [sp]
	movt	r4, #:upper16:.LANCHOR0
	mov	r2, r0
	movw	r1, #:lower16:.LC2
	add	r0, sp, #12
	movt	r1, #:upper16:.LC2
	bl	sprintf
	add	r2, sp, #12
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L179
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L179:
	add	sp, sp, #112
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_ii_find, .-__built__in__sy_i_ii_find
	.align	2
	.global	__built__in__sy_i_if_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_if_set, %function
__built__in__sy_i_if_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r3, r1
	push	{r4, r5, lr}
	sub	sp, sp, #116
	mov	r5, r2
	movw	r1, #:lower16:.LC3
	mov	r2, r0
	movt	r1, #:upper16:.LC3
	add	r0, sp, #12
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #12
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #12
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #116
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_if_set, .-__built__in__sy_i_if_set
	.align	2
	.global	__built__in__sy_i_if_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_if_find, %function
__built__in__sy_i_if_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r3, r1
	push	{r4, lr}
	sub	sp, sp, #112
	mov	r2, r0
	movw	r1, #:lower16:.LC3
	add	r0, sp, #12
	movt	r1, #:upper16:.LC3
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #12
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L186
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L186:
	add	sp, sp, #112
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_if_find, .-__built__in__sy_i_if_find
	.align	2
	.global	__built__in__sy_i_fi_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_fi_set, %function
__built__in__sy_i_fi_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	push	{r4, r5, lr}
	sub	sp, sp, #124
	mov	r5, r2
	mov	r2, r0
	str	r1, [sp, #8]
	add	r0, sp, #20
	movw	r1, #:lower16:.LC4
	movt	r1, #:upper16:.LC4
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #124
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_fi_set, .-__built__in__sy_i_fi_set
	.align	2
	.global	__built__in__sy_i_fi_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_fi_find, %function
__built__in__sy_i_fi_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #120
	add	r0, sp, #20
	movw	r4, #:lower16:.LANCHOR0
	str	r1, [sp, #8]
	movt	r4, #:upper16:.LANCHOR0
	movw	r1, #:lower16:.LC4
	movt	r1, #:upper16:.LC4
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L193
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L193:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_fi_find, .-__built__in__sy_i_fi_find
	.align	2
	.global	__built__in__sy_i_ff_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_ff_set, %function
__built__in__sy_i_ff_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, r5, lr}
	sub	sp, sp, #124
	mov	r5, r1
	add	r0, sp, #20
	movw	r1, #:lower16:.LC5
	movt	r1, #:upper16:.LC5
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #124
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_ff_set, .-__built__in__sy_i_ff_set
	.align	2
	.global	__built__in__sy_i_ff_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_ff_find, %function
__built__in__sy_i_ff_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r1, #:lower16:.LC5
	add	r0, sp, #20
	movt	r1, #:upper16:.LC5
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L200
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L200:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_ff_find, .-__built__in__sy_i_ff_find
	.align	2
	.global	__built__in__sy_i_iii_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_iii_set, %function
__built__in__sy_i_iii_set:
	@ args = 4, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #116
	strd	r2, [sp]
	mov	r3, r1
	mov	r2, r0
	movw	r1, #:lower16:.LC6
	add	r0, sp, #12
	movt	r1, #:upper16:.LC6
	ldr	r5, [sp, #128]
	bl	sprintf
	add	r0, sp, #12
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #12
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #116
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_iii_set, .-__built__in__sy_i_iii_set
	.align	2
	.global	__built__in__sy_i_iii_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_iii_find, %function
__built__in__sy_i_iii_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #112
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	strd	r2, [sp]
	mov	r3, r1
	mov	r2, r0
	movw	r1, #:lower16:.LC6
	add	r0, sp, #12
	movt	r1, #:upper16:.LC6
	bl	sprintf
	add	r2, sp, #12
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L207
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L207:
	add	sp, sp, #112
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_iii_find, .-__built__in__sy_i_iii_find
	.align	2
	.global	__built__in__sy_i_iif_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_iif_set, %function
__built__in__sy_i_iif_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	push	{r4, r5, lr}
	sub	sp, sp, #124
	mov	r5, r3
	mov	r3, r1
	str	r2, [sp]
	movw	r1, #:lower16:.LC7
	mov	r2, r0
	movt	r1, #:upper16:.LC7
	add	r0, sp, #20
	vstr.64	d0, [sp, #8]
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #124
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_iif_set, .-__built__in__sy_i_iif_set
	.align	2
	.global	__built__in__sy_i_iif_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_iif_find, %function
__built__in__sy_i_iif_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r3, r1
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r1, #:lower16:.LC7
	movw	r4, #:lower16:.LANCHOR0
	str	r2, [sp]
	movt	r4, #:upper16:.LANCHOR0
	mov	r2, r0
	movt	r1, #:upper16:.LC7
	add	r0, sp, #20
	vstr.64	d0, [sp, #8]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L214
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L214:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_iif_find, .-__built__in__sy_i_iif_find
	.align	2
	.global	__built__in__sy_i_ifi_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_ifi_set, %function
__built__in__sy_i_ifi_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	push	{r4, r5, lr}
	sub	sp, sp, #124
	mov	r5, r3
	mov	r3, r1
	str	r2, [sp, #8]
	movw	r1, #:lower16:.LC8
	mov	r2, r0
	movt	r1, #:upper16:.LC8
	add	r0, sp, #20
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #124
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_ifi_set, .-__built__in__sy_i_ifi_set
	.align	2
	.global	__built__in__sy_i_ifi_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_ifi_find, %function
__built__in__sy_i_ifi_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	mov	r3, r1
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r1, #:lower16:.LC8
	movw	r4, #:lower16:.LANCHOR0
	str	r2, [sp, #8]
	movt	r4, #:upper16:.LANCHOR0
	mov	r2, r0
	movt	r1, #:upper16:.LC8
	add	r0, sp, #20
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L221
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L221:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_ifi_find, .-__built__in__sy_i_ifi_find
	.align	2
	.global	__built__in__sy_i_iff_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_iff_set, %function
__built__in__sy_i_iff_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r3, r1
	push	{r4, r5, lr}
	sub	sp, sp, #124
	mov	r5, r2
	movw	r1, #:lower16:.LC9
	mov	r2, r0
	movt	r1, #:upper16:.LC9
	add	r0, sp, #20
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #124
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_iff_set, .-__built__in__sy_i_iff_set
	.align	2
	.global	__built__in__sy_i_iff_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_iff_find, %function
__built__in__sy_i_iff_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r3, r1
	push	{r4, lr}
	sub	sp, sp, #120
	mov	r2, r0
	movw	r1, #:lower16:.LC9
	add	r0, sp, #20
	movt	r1, #:upper16:.LC9
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L228
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L228:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_iff_find, .-__built__in__sy_i_iff_find
	.align	2
	.global	__built__in__sy_i_fii_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_fii_set, %function
__built__in__sy_i_fii_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	push	{r4, r5, lr}
	sub	sp, sp, #124
	mov	r5, r3
	str	r2, [sp, #12]
	mov	r2, r0
	str	r1, [sp, #8]
	add	r0, sp, #20
	movw	r1, #:lower16:.LC10
	movt	r1, #:upper16:.LC10
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #20
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #20
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #124
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_fii_set, .-__built__in__sy_i_fii_set
	.align	2
	.global	__built__in__sy_i_fii_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_fii_find, %function
__built__in__sy_i_fii_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d0, s0
	push	{r4, lr}
	sub	sp, sp, #120
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	str	r2, [sp, #12]
	mov	r2, r0
	str	r1, [sp, #8]
	add	r0, sp, #20
	movw	r1, #:lower16:.LC10
	movt	r1, #:upper16:.LC10
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #20
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L235
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L235:
	add	sp, sp, #120
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_fii_find, .-__built__in__sy_i_fii_find
	.align	2
	.global	__built__in__sy_i_fif_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_fif_set, %function
__built__in__sy_i_fif_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	push	{r4, r5, lr}
	sub	sp, sp, #132
	mov	r5, r2
	mov	r2, r0
	str	r1, [sp, #8]
	add	r0, sp, #28
	movw	r1, #:lower16:.LC11
	movt	r1, #:upper16:.LC11
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #16]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #28
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #28
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #132
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_fif_set, .-__built__in__sy_i_fif_set
	.align	2
	.global	__built__in__sy_i_fif_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_fif_find, %function
__built__in__sy_i_fif_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #128
	add	r0, sp, #28
	movw	r4, #:lower16:.LANCHOR0
	str	r1, [sp, #8]
	movt	r4, #:upper16:.LANCHOR0
	movw	r1, #:lower16:.LC11
	movt	r1, #:upper16:.LC11
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #16]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #28
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L242
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L242:
	add	sp, sp, #128
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_fif_find, .-__built__in__sy_i_fif_find
	.align	2
	.global	__built__in__sy_i_ffi_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_ffi_set, %function
__built__in__sy_i_ffi_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	push	{r4, r5, lr}
	sub	sp, sp, #132
	mov	r5, r2
	mov	r2, r0
	str	r1, [sp, #16]
	add	r0, sp, #28
	movw	r1, #:lower16:.LC12
	movt	r1, #:upper16:.LC12
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #28
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #28
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #132
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_ffi_set, .-__built__in__sy_i_ffi_set
	.align	2
	.global	__built__in__sy_i_ffi_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_ffi_find, %function
__built__in__sy_i_ffi_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #128
	add	r0, sp, #28
	movw	r4, #:lower16:.LANCHOR0
	str	r1, [sp, #16]
	movt	r4, #:upper16:.LANCHOR0
	movw	r1, #:lower16:.LC12
	movt	r1, #:upper16:.LC12
	vcvt.f64.f32	d0, s0
	vstr.64	d16, [sp, #8]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #28
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L249
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L249:
	add	sp, sp, #128
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_ffi_find, .-__built__in__sy_i_ffi_find
	.align	2
	.global	__built__in__sy_i_fff_set
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_fff_set, %function
__built__in__sy_i_fff_set:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, r5, lr}
	sub	sp, sp, #132
	mov	r5, r1
	add	r0, sp, #28
	movw	r1, #:lower16:.LC13
	movt	r1, #:upper16:.LC13
	vcvt.f64.f32	d1, s2
	vstr.64	d16, [sp, #8]
	vcvt.f64.f32	d0, s0
	vstr.64	d1, [sp, #16]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r0, sp, #28
	bl	strlen
	add	r4, r0, #1
	mov	r0, r4
	bl	malloc
	mov	r2, r4
	add	r1, sp, #28
	bl	memcpy
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r3, #4
	add	r2, ip, #40
	str	r5, [ip, #40]
	mov	r1, r0
	add	r0, ip, #24
	bl	map_set_
	add	sp, sp, #132
	@ sp needed
	pop	{r4, r5, pc}
	.size	__built__in__sy_i_fff_set, .-__built__in__sy_i_fff_set
	.align	2
	.global	__built__in__sy_i_fff_find
	.syntax unified
	.arm
	.fpu neon
	.type	__built__in__sy_i_fff_find, %function
__built__in__sy_i_fff_find:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	vcvt.f64.f32	d16, s1
	mov	r2, r0
	push	{r4, lr}
	sub	sp, sp, #128
	movw	r1, #:lower16:.LC13
	add	r0, sp, #28
	movt	r1, #:upper16:.LC13
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	vcvt.f64.f32	d1, s2
	vstr.64	d16, [sp, #8]
	vcvt.f64.f32	d0, s0
	vstr.64	d1, [sp, #16]
	vstr.64	d0, [sp]
	bl	sprintf
	add	r2, sp, #28
	add	r1, r4, #28
	add	r0, r4, #24
	bl	map_getref.isra.1
	cmp	r0, #0
	streq	r0, [r4, #36]
	beq	.L256
	ldr	r3, [r0]
	ldr	r0, [r3, #4]
	cmp	r0, #0
	str	r0, [r4, #36]
	ldrne	r3, [r0]
	movne	r0, #1
	strne	r3, [r4, #44]
.L256:
	add	sp, sp, #128
	@ sp needed
	pop	{r4, pc}
	.size	__built__in__sy_i_fff_find, .-__built__in__sy_i_fff_find
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	fm, %object
	.size	fm, 20
fm:
	.space	20
	.type	fm_ret, %object
	.size	fm_ret, 4
fm_ret:
	.space	4
	.type	im, %object
	.size	im, 20
im:
	.space	20
	.type	im_ret, %object
	.size	im_ret, 4
im_ret:
	.space	4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%d_%d\000"
	.space	2
.LC1:
	.ascii	"%d_%f\000"
	.space	2
.LC2:
	.ascii	"%d_%d_%d\000"
	.space	3
.LC3:
	.ascii	"%d_%d_%f\000"
	.space	3
.LC4:
	.ascii	"%d_%f_%d\000"
	.space	3
.LC5:
	.ascii	"%d_%f_%f\000"
	.space	3
.LC6:
	.ascii	"%d_%d_%d_%d\000"
.LC7:
	.ascii	"%d_%d_%d_%f\000"
.LC8:
	.ascii	"%d_%d_%f_%d\000"
.LC9:
	.ascii	"%d_%d_%f_%f\000"
.LC10:
	.ascii	"%d_%f_%d_%d\000"
.LC11:
	.ascii	"%d_%f_%d_%f\000"
.LC12:
	.ascii	"%d_%f_%f_%d\000"
.LC13:
	.ascii	"%d_%f_%f_%f\000"
	.ident	"GCC: (GNU Toolchain for the A-profile Architecture 8.2-2018.11 (arm-rel-8.26)) 8.2.1 20180802"
	.section	.note.GNU-stack,"",%progbits
