	.intel_syntax noprefix		# using Intel-style syntax
        .text                           # starting the section
        .globl  A                       # declaring and exporting outside the "A" symbol
        .bss                            # memory allocation section
        .align 32                       # stack alignment
        .type   A, @object              # type of the A is the object
        .size   A, 400                  # size of the B equals 400 bytes
A:
	.zero	400			# generating four hundred spaces
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
        .string "w"                     # mark for "w"
.LC2:
        .string "%u"                    # mark for "%u"
.LC3:
	.string	"Elapsed: %ld ns\n"
	.text				# code section
        .globl  main                    # declaring and exporting outside "main" symbol
        .type   main, @function         # type of the main is the function
main:
	push	rbp			# save stack pointer
        mov     rbp, rsp                # move stack pointer to the new position
	sub	rsp, 80			# reserve 80 bytes on stack
	mov	r12d, edi		# r12d := edi - getting 1st argument argc
	mov	QWORD PTR -80[rbp], rsi	# rbp[-80] := rsi - getting 2nd argument argv
	mov	rax, QWORD PTR -80[rbp]	# rax := argv
	add	rax, 8			# rax += 8 - &argv[1]
	mov	rax, QWORD PTR [rax]	# rax := argv[1]
	lea	rdx, .LC0[rip]		# rdx := rip[.LC0] = "r"
	mov	rsi, rdx		# rsi := rdx - putting in the 2nd argument "r"
	mov	rdi, rax		# rdi := rax - putting in the 1st argument argv[1]
	call	fopen@PLT		# call fopen(rdi, rsi) ~~ fopen(argv[1], "r")
	mov	QWORD PTR -8[rbp], rax	# rbp[-8] := rax - saving
	mov	rax, QWORD PTR -80[rbp]	# rax := argv
	add	rax, 16			# rax += 16 ~~ &argv[2]
	mov	rax, QWORD PTR [rax]	# rax := argv[2]
	lea	rdx, .LC1[rip]		# rdx := rip[.LC1] = "w"
	mov	rsi, rdx		# rsi := rdx - putting in the 2nd argument "w"
	mov	rdi, rax		# rdi := rax - putting in the 1st argument argv[2]
	call	fopen@PLT		# call fopen(rdi, rsi) ~~ fopen(argv[2], "w")
	mov	QWORD PTR -16[rbp], rax	# rbp[-16] := rax
	cmp	r12d, 4			# comparison of r12d and 4 ~~ argc and 4
	jne	.L2			# if argc != 4 jump to .L2
	lea	rax, -28[rbp]		# rax := rbp[-28] = n
	mov	rsi, rax		# rsi := rax = n - putting in the 2nd argument &n
	lea	rax, .LC2[rip]		# rax := rip[.LC2] = "%u"
	mov	rdi, rax		# rdi := rax = "%u" - putting in the 1st argument "%u"
	mov	eax, 0			# eax := 0 - zeroing out rax
	call	scanf@PLT		# call scanf(rdi, rsi) ~~ scanf("%u", &n)
	mov	eax, DWORD PTR -28[rbp]	# eax := rbp[-28] = n
	mov	edi, eax		# edi := eax = n - putting in the argument n
	call	random_read@PLT		# call random_read(edi) ~~ random_read(n)
	jmp	.L3			# jump to .L3
.L2:
	lea	rdx, -28[rbp]		# rdx := rbp[-28] = n
	mov	rax, QWORD PTR -8[rbp]	# rax := rbp[-8] - backup
	lea	rcx, .LC2[rip]		# rcx := rip[.LC2] = "%u"
	mov	rsi, rcx		# rsi := rcx = "%u" - putting in the 2nd argument "%u"
	mov	rdi, rax		# rdi := rax = argv[1] - putting in th2 1st argument argv[1]
	mov	eax, 0			# eax := 0 - zeroing out rax
	call	fscanf@PLT		# call fscanf(rdi, rsi, rdx) ~~ fscanf(argv[1], "%u", &n)
	mov	edx, DWORD PTR -28[rbp]	# edx := rbp[-28] = n
	mov	rax, QWORD PTR -8[rbp]	# rax := rbp[-8] = argv[1]
	mov	esi, edx		# esi := edx = n - putting in the 2nd argument n
	mov	rdi, rax		# rsi := rax = argv[1] - putting in the 1st argument argv[1]
	call	read@PLT		# call read(rdi, esi) ~~ read(argv[1], n)
.L3:
	lea	rax, -48[rbp]		# rax := rbp[-48] = &start
	mov	rsi, rax		# rsi := rax - putting in the 2nd argument &start
	mov	edi, 1			# edi := 1 - putting in the 1st argument 1
	call	clock_gettime@PLT	# call clock_gettime(edi, rsi) ~~ clock_gettime(1, &start)
	mov	eax, DWORD PTR -28[rbp]	# eax := rbp[-28] = n
	mov	edi, eax		# edi := eax = n - putting in the argument n
	call	func@PLT		# call func(edi) ~~ func(n)
	lea	rax, -64[rbp]		# rax := rbp[-64] = &end
	mov	rsi, rax		# rsi := rax = &end - putting in the 2nd argument &end
	mov	edi, 1			# edi := 1 - putting in the 1st argument 1
	call	clock_gettime@PLT	# call clock_gettime(edi, rsi) ~~ clock_gettime(1, &end)
	mov	rax, QWORD PTR -48[rbp]	# rax := rbp[-48]
	mov	rdx, QWORD PTR -40[rbp]	# rdx := rbp[-40]
	mov	rdi, QWORD PTR -64[rbp]	# rdi := rbp[-64] = &end
	mov	rsi, QWORD PTR -56[rbp]	# rsi := rbp[-56] = &start
	mov	rcx, rdx		# rcx := rdx
	mov	rdx, rax		# rdx := rax
	call	time_dif@PLT		# call time_dif(rdi, rsi) ~~ time_dif(&end, &start)
	mov	QWORD PTR -24[rbp], rax	# rbp[-24] := rax
	mov	rax, QWORD PTR -24[rbp]	# rax := rbp[-24]
	mov	rsi, rax		# rsi := rax = time_dif
	lea	rax, .LC3[rip]		# rax := rip[.LC3] = "Elapsed: %ld ns\n"
	mov	rdi, rax		# putting string in the 1st argument
	mov	eax, 0			# eax := 0 - zeroing out rax
	call	printf@PLT		# call printf(rdi, rsi) ~~ printf("Elapsed: %ld ns", n)
	mov	edx, DWORD PTR -28[rbp]	# edx := rbp[-28] = n
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = argv[2]
	mov	esi, edx		# esi := edx = n - putting in the 2nd argument n
	mov	rdi, rax		# rdi := rax = argv[2] - putting in the 1st argument argv[2]
	call	print@PLT		# call print(rdi, esi) ~~ print(argv[2], n)
	mov	eax, 0			# eax := 0 - zeroing out rax
	leave				# leave the function
	ret				# return 0;
