	.intel_syntax noprefix		# using Intel-style syntax
        .text                           # starting the section
	.section	.rodata		# section .rodata
.LC0:
	.string	"%d\n"			# mark for "%d\n"
	.text				# code section
	.globl	print			# declaring and exporting outside "print" symbol
	.type	print, @function	# type of the print is the function
print:
	push	rbp			# save stack pointer
        mov     rbp, rsp                # move stack pointer to the new position
        sub     rsp, 32                 # reserve 32 bytes on stack
	mov	QWORD PTR -24[rbp], rdi	# getting the &output from the argument rdi
	mov	DWORD PTR -28[rbp], esi	# getting the n from the argument esi
	mov	r12d, 0			# r12d := 0 ~~ i = 0
	jmp	.L2			# jump to the mark .L2
.L3:
	mov	eax, r12d		# eax := r12d = i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
        lea     rax, B[rip]             # rax := &rip[B] - address of the beginning of the array
        mov     edx, DWORD PTR [rdx+rax]# edx := &B[i]
	mov	rax, QWORD PTR -24[rbp]	# rax := rbp[-24] = &output
	lea	rcx, .LC0[rip]		# rcx := rip[.LC0] = "%d\n"
	mov	rsi, rcx		# rsi := rcx = "%d\n" - putting in the 2nd argument "%d\n"
	mov	rdi, rax		# rdi := rax = &output - putting in the 1st argument &output
	mov	eax, 0			# eax := 0 - zeroing out rax
	call	fprintf@PLT		# call fprintf(rdi, rsi, edx) ~~ fprint(&output, "%d\n", &B[i])
	add	r12d, 1			# r12d += 1 ~~ i++
.L2:
	mov	eax, r12d		# eax := r12d = i
	cmp	DWORD PTR -28[rbp], eax	# comparison rbp[-28] and eax ~~ n and i
	ja	.L3			# jump in mark .L3 if n > i
	leave				# else leave the function
	ret				# return;
