	.intel_syntax noprefix		# using Intel-style syntax
        .text                           # starting the section
	.globl	time_dif		# declaration and exporting outside "time_dif" symbol
	.type	time_dif, @function	# type of the time_dif is the function
time_dif:
	push	rbp			# save stack pointer
        mov     rbp, rsp                # move stack pointer to the new position
	mov	rax, rsi		# getting arguments of function
	mov	r8, rdi			# --||--
	mov	rsi, r8			# --||--
	mov	rdi, r9			# --||--
	mov	rdi, rax		# --||--
	mov	QWORD PTR -32[rbp], rsi	# rbp[-32] = timeB
	mov	QWORD PTR -24[rbp], rdi	# rbp[-24] = timeA
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp] # rax := nsecA
	mov	QWORD PTR -8[rbp], rax	# --||--
	mov	rax, QWORD PTR -8[rbp]	# --||--
	imul	rax, rax, 1000000000	# rax *= 1000000000 - nsecA
	mov	QWORD PTR -8[rbp], rax	# rbp[-8] = nsecA
	mov	rax, QWORD PTR -24[rbp]	# rax := timeA
	add	QWORD PTR -8[rbp], rax	# nsecA += timeA
	mov	rax, QWORD PTR -48[rbp]	# rax := nsecB
	mov	QWORD PTR -16[rbp], rax	# --||--
	mov	rax, QWORD PTR -16[rbp]	# --||--
	imul	rax, rax, 1000000000	# rax := rax * 1000000000
	mov	QWORD PTR -16[rbp], rax	# rbp[-16] = nsecB
	mov	rax, QWORD PTR -40[rbp]	# rax := timeB
	add	QWORD PTR -16[rbp], rax	# nsecB += timeB
	mov	rax, QWORD PTR -8[rbp]	# rax := nsecA
	sub	rax, QWORD PTR -16[rbp]	# rax -= rbp[-16] ~~ nsecA - nsecB
	pop	rbp			# return previous stack pointer
	ret				# return rax;
