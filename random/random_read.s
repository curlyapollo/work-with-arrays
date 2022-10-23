	.intel_syntax noprefix		# using Intel-style syntax
        .text                           # starting the section
        .section        .rodata         # section .rodata
.LC0:
	.string	"%d\n"			# mark for "%d/n"
	.text				# code section
	.globl	random_read		# declaration and exporting outside "random_read" symbol
	.type	random_read, @function	# type of the random read is the function
random_read:
	push	rbp			# save stack pointer
        mov     rbp, rsp                # move stack pointer to the new position
        sub     rsp, 32                 # reserve 32 bytes on stack
	mov	DWORD PTR -20[rbp], edi	# getting the n from the argument edi
	mov	edi, 1			# edi := 1 - seed
	call	srand@PLT		# call srand(1) - set seed
	mov	r12d, 0			# r12d = 0 ~~ i = 0
	jmp	.L2			# jump to mark .L2
.L3:
	call	rand@PLT		# call rand()
	movsx	rdx, eax		# cast eax to rdx
	imul	rdx, rdx, 1374389535	# rdx := rdx * integer
	shr	rdx, 32			# rdx >> 32
	sar	edx, 5			# edx << 5
	mov	ecx, eax		# ecx := eax
	sar	ecx, 31			# ecx << 31
	sub	edx, ecx		# edx -= ecx
	imul	ecx, edx, 100		# ecx := edx * 100
	sub	eax, ecx		# reserve
	mov	edx, eax		# edx := eax
	mov	eax, r12d		# eax := r12d
	cdqe				# cast
	lea	rcx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, A[rip]		# rax := &rip[A] - address of the beginning of the array
	mov	DWORD PTR [rcx+rax], edx# A[i] = edx = num % 100
	mov	eax, r12d		# eax := i
	cdqe				# cast to rax
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
        lea     rax, A[rip]             # rax := &rip[A] - address of the beginning of the array
	mov	eax, DWORD PTR [rdx+rax]# eax := A[i]
	mov	esi, eax		# esi := eax - putting in the 2nd argument A[i]
	lea	rax, .LC0[rip]		# rax := rip[.LC0] = "%u\n"
	mov	rdi, rax		# rdi := rax - putting in the 1st argument "%u\n"
	mov	eax, 0			# eax := 0 - zeroing out rax
	call	printf@PLT		# call printf(rdi, esi) ~~ printf("%u\n", A[i])
	add	r12d, 1			# i++
.L2:
	mov	eax, r12d		# eax := r12d = i
	cmp	DWORD PTR -20[rbp], eax	# comparison of n and i
	ja	.L3			# if n > i jump to mark .L3
	leave				# else leave the function
	ret				# return;
