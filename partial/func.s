	.intel_syntax noprefix          # using Intel-style syntax
        .text                           # starting the section
	.globl	func			# declaring and exporting outside the "func" symbol
	.type	func, @function		# type of the func is the function
func:
        push    rbp                     # save stack pointer
        mov     rbp, rsp                # move stack pointer to the new position
	mov	DWORD PTR -20[rbp], edi	# getting the n from the argument edi from rbp[-20]
	mov	r12d, 0			# r12d = 0 ~~ j = 0
	mov	r13d, 0			# r13d = 0 ~~ i = 0
	jmp	.L2			# jump to mark .L2
.L5:
	mov	eax, r13d		# eax := r13d = i
	and	eax, 1			# eax := eax & 1 ~~ i % 2
	test	eax, eax		# eax & eax ?
	jne	.L3			# jump to .L3 if eax % eax != 0 (so eax != 0) ~~ i % 2 != 0
	mov	eax, r13d		# eax := r13d = i
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, A[rip]		# rax := &rip[A] - address of the beginning of the array A
	mov	eax, DWORD PTR [rdx+rax]# eax := &A[i]
	mov	edx, r12d		# edx := r12d = j
	movsx	rdx, edx		# analogue of cdqe
        lea     rcx, 0[0+rdx*4]         # calculating the address (rdx*4)[0], which is equal to rdx*4
        lea     rdx, B[rip]             # rdx := &rip[B] - address of the beginning of the array B
        mov     DWORD PTR [rcx+rdx], eax# [rcx+rdx] := eax ~~ B[i] = A[i]
	jmp	.L4			# jump to mark .L4
.L3:
	mov	edx, DWORD PTR -20[rbp]	# edx := n
	mov	eax, r13d		# eax := r13 = i
	add	eax, edx		# eax := eax + edx
	shr	eax			# eax >> 1 ~~ eax /= 2 ~~ (i + n) / 2
	mov	ecx, eax		# ecx := eax
	mov	eax, r13d		# eax := r13d = i
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
        lea     rax, A[rip]             # rax := &rip[A] - address of the beginning og the array A
	mov	eax, DWORD PTR [rdx+rax]# eax := &A[i]
	mov	edx, ecx		# edx := ecx
	lea	rcx, 0[0+rdx*4]		# rcx := rdx[0] cast
	lea	rdx, B[rip]		# rdx := &rip[B]
	mov	DWORD PTR [rcx+rdx], eax# [rcx+rdx] := eax ~~ B[(n + i) / 2] = A[i]
	add	r12d, 1			# r12d += 1 ~~ j++
.L4:
	add	r13d, 1			# r13d += 1 ~~ i++
.L2:
	mov	eax, r13d		# eax := r13d = i
	cmp	eax, DWORD PTR -20[rbp]	# comparison of i and n
	jb	.L5			# jump to mark .L11 if i < n
	pop	rbp			# return previous stack pointer
        ret                             # return to call function
