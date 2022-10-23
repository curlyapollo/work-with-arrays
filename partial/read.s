        .intel_syntax noprefix          # using Intel-style syntax
        .text                           # starting the section
        .section        .rodata         # section .rodata
.LC0:
	.string	"%d"			# mark for the "%d"
	.text				# code section
	.globl	read			# declaring and exporting outside "read" symbol
	.type	read, @function		# type of the read is the function
read:
	push	rbp			# save stack pointer
        mov     rbp, rsp                # move stack pointer to the new position
        sub     rsp, 32                 # reserve 32 bytes on stack
        mov     QWORD PTR -24[rbp], rdi # getting the &input from the argument rdi
        mov     DWORD PTR -28[rbp], esi # getting the n from the argument esi
	mov	r12d, 0			# r12d := 0 ~~ i = 0
	jmp	.L2			# jump to mark .L2
.L3:
	mov	eax, r12d		# eax := r12d = i
	cdqe				# cast eax (int i) to rax (long long i)
        lea     rdx, 0[0+rax*4]         # calculating the address (rax*4)[0], which is equal to rax*4
        lea     rax, A[rip]             # rax := &rip[A] - address of the beginning of the array
	add	rdx, rax		# rdx := rdx + rax - getting &A[i]
	mov	rax, QWORD PTR -24[rbp]	# rax := rbp[-24] = &input
	lea	rcx, .LC0[rip]		# rcx := rip[.LC0] = "%d"
	mov	rsi, rcx		# rsi := rcx - putting in the 2nd argument "%d"
	mov	rdi, rax		# rdi := rax - putting in the 1st argument &input
	mov	eax, 0			# eax := 0 - zeroing out rax
	call	fscanf@PLT		# call fscanf(rdi, rsi) ~~ fscanf(input, "%d", &n)
	add	r12d, 1			# r12d += 1 ~~ i++
.L2:
	mov	eax, r12d		# eax := r12d = i
	cmp	DWORD PTR -28[rbp], eax	# comparison of n and i
	ja	.L3			# if n > i jump in .L3
	leave				# else leave the function
	ret				# return;
