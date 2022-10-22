	.intel_syntax noprefix		# using Intel-style syntax
	.text				# starting the section
	.globl	n			# temporary n of the size
	.bss				# memory allocation section
	.align 4			# stack alignment
	.type	n, @object		# type of the n is the object
	.size	n, 4			# size of the n equals 4 bytes
n:
	.zero	4			# generating four spaces
	.globl	A			# declaring and exporting outside the "A" symbol
	.align 32			# stack alignment
	.type	A, @object		# type of the A is the object
	.size	A, 400			# size of the B equals 400 bytes
A:
	.zero	400			# generating four hundred spaces
	.globl	B			# declaring and exporting outside the "B" symbol
	.align 32			# stack alignment
	.type	B, @object		# type of the B is the object
	.size	B, 400			# size of the B equals 400 bytes
B:
	.zero	400			# generating four hundred spaces
	.section	.rodata		# section .rodata
.LC0:
	.string	"%u"			# mark for "%u"
.LC1:
	.string	"%d"			# mark for "%d"
	.text				# code section
	.globl	read			# declaring and exporting outside "read" symbol
	.type	read, @function		# type of the read is the function
read:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	sub	rsp, 16			# reserve 16 bytes on stack
	lea	rax, n[rip]		# rax := rip[n] - our number n
	mov	rsi, rax		# rsi := rax - putting in 2nd argument n
	lea	rax, .LC0[rip]		# rax := rip[.LC0] - "%u"
	mov	rdi, rax		# rdi := rax - putting in 1st argument "%u"
	mov	eax, 0			# eax := 0 - zeroing out of rax
	call	scanf@PLT		# call scanf(rdi, rsi) ~~ scanf("%u", &n)
	mov	DWORD PTR -4[rbp], 0	# rbp[-4] := 0 - i = 0 ~~ loop counter
	jmp	.L2			# jump to mark .L2
.L3:
	mov	eax, DWORD PTR -4[rbp] 	# eax := rbp[-4] ~~ == i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, A[rip]		# rax := &rip[A] - address of the beginning of the array
	add	rax, rdx		# rax += rdx - address of A[i]
	mov	rsi, rax		# rsi := rax - putting in 2nd argument &A[i]
	lea	rax, .LC1[rip]		# rax := rip[.LC1] ~~ "%d"
	mov	rdi, rax		# rdi := rax - putting in 1st argument "%d"
	mov	eax, 0			# eax := 0 - zeroing out of rax
	call	scanf@PLT		# call scanf(rdi, rsi) ~~ scanf("%d", &A[i])
	add	DWORD PTR -4[rbp], 1	# rbp[-4] += 1 ~~ i++
.L2:
	mov	edx, DWORD PTR -4[rbp]	# edx := i
	mov	eax, DWORD PTR n[rip]	# eax := n
	cmp	edx, eax		# comparison of i and n
	jb	.L3			# jump in mark .L3 if i < n
	leave				# else leave the loop
	ret				# return to call function
	.section	.rodata
.LC2:
	.string	"%d\n"			# mark for "%d\n"
	.text
	.globl	print			# declaring and exporting outside "print" symbol
	.type	print, @function	# type of the print is the function
print:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	sub	rsp, 16			# reserve 16 bytes on stack
	mov	DWORD PTR -4[rbp], 0	# rbp[-4] := 0 ~~ i = 0
	jmp	.L5			# jump to .L5
.L6:
	mov	eax, DWORD PTR -4[rbp]	# eax := rbp[-4] = i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, B[rip]		# rax := &rip[B] - address of the beginning of the array
	mov	eax, DWORD PTR [rdx+rax]# eax := &B[i]
	mov	esi, eax		# esi := eax - putting in 2nd argument &B[i]
	lea	rax, .LC2[rip]		# rax := rip[.LC2] = "%d\n"
	mov	rdi, rax		# rdi := rax - putting in 1st argument "%d\n"
	mov	eax, 0			# rax := 0 - zeroing out of rax
	call	printf@PLT		# call printf(rdi, rsi) ~~ printf("%d\n", &B[i])
	add	DWORD PTR -4[rbp], 1	# rbp[-4] += 1 ~~ i++
.L5:
	mov	edx, DWORD PTR -4[rbp]	# edx := rbp[-4] = i
	mov	eax, DWORD PTR n[rip]	# eax := rip[n] = n
	cmp	edx, eax		# comparison of i and n
	jb	.L6			# jump in mark .L6 if i < n
	leave				# else leave the loop
	ret				# return to call function
	.globl	func
	.type	func, @function
func:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	mov	DWORD PTR -4[rbp], 0	# rbp[-4] = 0 ~~ j = 0
	mov	QWORD PTR -16[rbp], 0	# rbp[-16] = 0 ~~ i = 0
	jmp	.L8			# jump to mark .L8
.L11:
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = i
	and	eax, 1			# eax := eax & 1 ~~ i % 2
	test	rax, rax		# rax & rax ?
	jne	.L9			# jump to .L9 if rax % rax != 0 (so rax != 0) ~~ i % 2 != 0
	mov	rax, QWORD PTR -16[rbp] # rax := rbp[-16] = i
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, A[rip]		# rax := &rip[A] - address of the beginning of the array A
	mov	eax, DWORD PTR [rdx+rax]# eax := &A[i]
	mov	edx, DWORD PTR -4[rbp]	# edx := rbp[-4] = j
	movsx	rdx, edx		# analogue of cdqe
	lea	rcx, 0[0+rdx*4]		# calculating the address (rdx*4)[0], which is equal to rdx*4
	lea	rdx, B[rip]		# rdx := &rip[B] - address of the beginning of the array B
	mov	DWORD PTR [rcx+rdx], eax# [rcx+rdx] := eax ~~ B[i] = A[i]
	jmp	.L10			# jump to mark .L10
.L9:
	mov	eax, DWORD PTR n[rip]	# eax := rip[n]
	mov	edx, eax		# edx := eax
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = i
	add	rax, rdx		# rax += rdx
	shr	rax			# rax >> 1 ~~ rax /= 2 ~~ (i + n) / 2
	mov	rcx, rax		# rcx := rax
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = i
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, A[rip]		# rax := &rip[A] - address of the beginning og the array A
	mov	eax, DWORD PTR [rdx+rax]# eax := &A[i]
	sal	rcx, 2			# rcx << 2 to cast
	lea	rdx, B[rip]		# rdx := &rip[B] - address of the beginning of the array B
	mov	DWORD PTR [rcx+rdx], eax# [rcx+rdx] := eax ~~ B[(n + i) / 2] = A[i]
	add	DWORD PTR -4[rbp], 1	# rbp[-4] += 1 ~~ j++
.L10:
	add	QWORD PTR -16[rbp], 1	# rbp[-16] += 1 ~~ i++
.L8:
	mov	eax, DWORD PTR n[rip]	# eax := rip[n]
	cmp	QWORD PTR -16[rbp], rax	# comparison of rbp[-16] aka i and rax aka n
	jbe	.L11			# jump to mark .L11 if i <= n
	pop	rbp			# return previous stack pointer
	ret				# return to call function
	.globl	main
	.type	main, @function
main:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	mov	eax, 0			# eax := 0 - zeroing out of rax
	call	read			# call the function read
	mov	eax, 0			# eax := 0 - zeroing out of rax
	call	func			# call the function func
	mov	eax, 0			# eax := 0 - zeroing out of rax
	call	print			# call the function print
	mov	eax, 0			# eax := 0 - zeroing out of rax
	pop	rbp			# return previous stack pointer
	ret				# end of the program
