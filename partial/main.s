        .intel_syntax noprefix          # using Intel-style syntax
        .text                           # starting the section
        .globl  A                       # declaring and exporting outside the "A" symbol
        .bss                            # memory allocation section
        .align 32                       # stack alignment
        .type   A, @object              # type of the A is the object
        .size   A, 400                  # size of the B equals 400 bytes
A:
        .zero   400                     # generating four hundred spaces
        .globl  B                       # declaring and exporting outside the "B" symbol
        .align 32                       # stack alignment
        .type   B, @object              # type of the B is the object
        .size   B, 400                  # size of the B equals 400 bytes
B:
        .zero   400                     # generating four hundred spaces
        .section        .rodata         # section .rodata
.LC0:
	.string	"r"			# mark for "r"
.LC1:
	.string	"w"			# mark for "w"
.LC2:
	.string	"%u"			# mark for "%u"
	.text				# code section
        .globl  main                    # declaring and exporting outside "main" symbol
        .type   main, @function         # type of the main is the function
main:
	push	rbp			# save stack pointer
        mov     rbp, rsp                # move stack pointer to the new position
	sub	rsp, 48			# reserve 48 bytes on stack
	mov     DWORD PTR -36[rbp], edi	# getting argc
        mov     QWORD PTR -48[rbp], rsi	# getting argv
	mov	rax, QWORD PTR -48[rbp]	# rax := argv
	add 	rax, 8			# rax += 8 ~~ &argv[1]
	mov 	rax, QWORD PTR [rax]	# rax := argv[1]
	lea	rdx, .LC0[rip]		# rdx := rip[.LC0] = "r"
	mov	rsi, rdx		# rsi := rdx = "r" - putting in the 2nd argument "r"
	mov	rdi, rax		# rdi := rax = argv[1] - putting in the 1st argument argv[2]
	call	fopen@PLT		# call fopen(rdi, rsi) ~~ fopen(argv[1], "r")
	mov	QWORD PTR -8[rbp], rax	# rbp[-8] := rax - saving rbp[-8] = &input
	mov     rax, QWORD PTR -48[rbp]	# rax := argv
        add     rax, 16			# rax += 16 ~~ &argv[2]
        mov     rax, QWORD PTR [rax]	# rax := argv[2]
        lea     rdx, .LC1[rip]		# rdx := "w"
        mov     rsi, rdx		# rsi := rdx - putting in the 2nd argument "w"
        mov     rdi, rax		# rdi := rax - putting in the 1st argument argv[2]
	call	fopen@PLT		# call fopen(rdi, rsi) ~~ fopen(argv[2], "w")
	mov	QWORD PTR -16[rbp], rax	# rbp[-16] = rax - saving the rax - &output
	lea	rdx, -20[rbp]		# rdx := rbp[-20]
	mov	rax, QWORD PTR -8[rbp]	# rax := rbp[-8] = &input
	lea	rcx, .LC2[rip]		# rcx := rip[.LC4] = "%u"
	mov	rsi, rcx		# rsi := rcx = "%u" - putting in 2nd argument "%u"
	mov	rdi, rax		# rdi := rax = &n - putting in 1st argument &input
	mov	eax, 0			# eax := 0 - zeroing out rax
	call	fscanf@PLT		# call fscanf(rdi, rsi) ~~ fscanf("%u", &n)
	mov	edx, DWORD PTR -20[rbp]	# edx := rbp[-20] = n
	mov	rax, QWORD PTR -8[rbp]	# rax := rbp[-8] = &input
	mov	esi, edx		# esi := edx - putting in 2nd argument n
	mov	rdi, rax		# rdi := rax - putting in 1st argument input
	call	read@PLT		# call read(rdi, rsi) ~~ read(input, n)
	mov	eax, DWORD PTR -20[rbp]	# eax := rbp[-20] = n
	mov	edi, eax		# edi := eax = n
	call	func@PLT		# call func(edi) ~~ func(n)
	mov	edx, DWORD PTR -20[rbp]	# edx := rbp[-20]
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16]
	mov	esi, edx		# putting in 2nd argument n
	mov	rdi, rax		# putting in 1st argument &output
	call	print@PLT		# call print(rdi, esi) ~~ print(output, n)
	mov	eax, 0			# eax := 0 - zeroing out rax
	leave				# leave function
	ret				# return 0
