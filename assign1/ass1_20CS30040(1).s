	.file	"ass1_20CS30040.c" #Name of file
	.text
	.section	.rodata #read-only data section
	.align 8 #align with 8-byte boundary
.LC0: #Label of first string first printf
	.string	"Enter the string (all lower case): "
.LC1: #label for first scanf
	.string	"%s"
.LC2: #label for second printf
	.string	"Length of the string: %d\n"
	.align 8
.LC3: #label for third printf
	.string	"The string in descending order: %s\n"
	.text #code starts
	.globl	main #main is a global name
	.type	main, @function #main is a function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp  #Save old base pointers
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp #move the current stack frame pointer to base pointer register which enables us to access local variable and arguments 
	.cfi_def_cfa_register 6
	subq	$80, %rsp #allocate space(80 byte) for local variables
	movq	%fs:40, %rax #Segment addressing
	movq	%rax, -8(%rbp) 
	xorl	%eax, %eax #clear eax register
	#First printf
	leaq	.LC0(%rip), %rdi #move the address of .LC0 to rdi (Will be used as first argument to printf
	movl	$0, %eax #eax->0 
	call	printf@PLT #call first printf and will print "Enter the string (all lower case): "
	#First Scanf
	leaq	-64(%rbp), %rax #rax ->(rbp-64) load string to rax(will be used as second argument to scanf)
	movq	%rax, %rsi #move rax to rsi(seond argument of scanf function)
	leaq	.LC1(%rip), %rdi #load the LC1 label string in rdi(first argument to scanf)
	movl	$0, %eax #eax->0
	call	__isoc99_scanf@PLT #call first scanf
	#Calling len function
	leaq	-64(%rbp), %rax #rax->rbp-64 
	movq	%rax, %rdi #move rax to rdi (first argument of length subroutine)
	call	length #call length subroutine
	#Second printf
	movl	%eax, -68(%rbp) #length is stored in eax, now load it at rbp-64 address
	movl	-68(%rbp), %eax #eax->rbp-68
	movl	%eax, %esi #move the value in eax to esi(second argument to printf)
	leaq	.LC2(%rip), %rdi #Load the string in label LC2 to rdi(first argument to printf)
	movl	$0, %eax #eax->0
	call	printf@PLT #call printf
	#calling sort function
	leaq	-32(%rbp), %rdx #load the dest variable(declared in source code) to rdx(third argument to sort)
	movl	-68(%rbp), %ecx #move the len variable(declared in source code) to ecx register
	leaq	-64(%rbp), %rax #load the str variable  to rax register
	movl	%ecx, %esi  #esi->ecx move the exc's value(len) to esi register (second argument to sort)
	movq	%rax, %rdi #rdi->rax rdi will store the value of rax and it will be used as first argument to sort
	call	sort #call sort function
	#call third printf
	leaq	-32(%rbp), %rax #load  the dest variable(declared in source code to rax register
	movq	%rax, %rsi #move the rax's value to rsi(second argument to printf)
	leaq	.LC3(%rip), %rdi #Load the LC3 label string to rdi(first argument to printf)
	movl	$0, %eax #eax->0
	call	printf@PLT #call printf
	#something related to stack check(to do)
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L3
	call	__stack_chk_fail@PLT
.L3: #main subroutine ends
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	length
	.type	length, @function
#Length subroutine
length:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp #dave old base pointers
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp #move the current stack frame pointer to base pointer register which enables us to access local variable and arguments 
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)  #move the string address(first argument) in physical memory of subroutine
	movl	$0, -4(%rbp) #sets i(declared in source code) to 0
	jmp	.L5
#first  for loop in length subroutine
.L6: #increment label
	addl	$1, -4(%rbp)
.L5: 
	movl	-4(%rbp), %eax #eax->i
	movslq	%eax, %rdx #rdx->eax move the 32 bit source to 64 bit destination with sign extension
	movq	-24(%rbp), %rax #rax->string(first argument)
	addq	%rdx, %rax #move rdx to to rax
	movzbl	(%rax), %eax #move value of rax to eax i.e eax->*(str+i)
	testb	%al, %al #Bitwise and of least significant byte of eax and set zero flag to 1 if its zero
	jne	.L6 #jump to L6 if zero flag is not zero
	movl	-4(%rbp), %eax #Move the value rbp-4 to eax
	popq	%rbp #pop back old  stack pointer
	.cfi_def_cfa 7, 8
	ret   #return from the subroutine
	.cfi_endproc
.LFE1:
	.size	length, .-length  
	.globl	sort    #sort is global 
	.type	sort, @function #sort is function
sort: 
.LFB2:
	.cfi_startproc
	endbr64 #end branch 64 bit
	pushq	%rbp #push the old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp #move the current stack pointer to base pointer register
	.cfi_def_cfa_register 6
	subq	$48, %rsp #allocate them 48 byte storage for local variables
	movq	%rdi, -24(%rbp) #rbp-24->rdi(first argument to the function which holds the str)
	movl	%esi, -28(%rbp) #rbp-28->esi(second argument to the function which store len)
	movq	%rdx, -40(%rbp) #rbp-40->rdx(third argument to the function whicj store dest)
	movl	$0, -8(%rbp) #rbp-8->0 initialises i to 0
	jmp	.L9 #jump to label 9
#first for and inner for loop in sort subroutine
.L13:
	movl	$0, -4(%rbp) #j->0
	jmp	.L10 #jump to L10 label
.L12:
	movl	-8(%rbp), %eax #eax->rbp-8 move the i to eax
	movslq	%eax, %rdx #rdx->eax with sign bit extension rdx->i
	movq	-24(%rbp), %rax #rax->rbp-24 move the str to rax register
	addq	%rdx, %rax #rax+=rdx, rax=&str[i]
	movzbl	(%rax), %edx #edx->str[i]
	movl	-4(%rbp), %eax #eax->rbp-4 move j to eax
	movslq	%eax, %rcx #rcx->eax wtih sign bit extension, rcx->j
	movq	-24(%rbp), %rax #rax->rbp-24 move address of first character of str to rax
	addq	%rcx, %rax#rax+=rcx, rcx=&str[j]
	movzbl	(%rax), %eax #eax->str[j]
	cmpb	%al, %dl #if(edx>=eax i.e. str[i]>=str[j] in c code) then jump to L11 else skip to next instruction
	jge	.L11
	movl	-8(%rbp), %eax #eax->rbp-8 move i to eax
	movslq	%eax, %rdx #rdx->eax move i to rdx
	movq	-24(%rbp), %rax #rax->rbp-24 move address of str to rax
	addq	%rdx, %rax #rax+=rdx, rdx=&str[i]
	movzbl	(%rax), %eax #eax->str[i]
	movb	%al, -9(%rbp) #rbp-9->str[i]
	movl	-4(%rbp), %eax #eax->rbp-4 move j to eax
	movslq	%eax, %rdx #rdx->eax move j to rdx
	movq	-24(%rbp), %rax #rax->rbp-24 move address of str to rax
	addq	%rdx, %rax#rax+=rdx, rax=&str[j]
	movl	-8(%rbp), %edx #edx->rbp-8 move i to edx
	movslq	%edx, %rcx#rcx->i
	movq	-24(%rbp), %rdx #rdx->rbp-24 move address of str to rdx
	addq	%rcx, %rdx #rdx+=rcx, rdx=&str[i]
	movzbl	(%rax), %eax #eax->str[i]
	movb	%al, (%rdx) #str[i]=str[j]
	movl	-4(%rbp), %eax #eax->rbp-4 move j to eax
	movslq	%eax, %rdx #rdx->eax move j to rdx
	movq	-24(%rbp), %rax #rax->rbp-24 move address of str to rax
	addq	%rax, %rdx #rdx+=rax, rdx=&str[j]
	movzbl	-9(%rbp), %eax #eax->rbp-9 move str[i](temp) to eax
	movb	%al, (%rdx) #str[j]=str[i](temp)
.L11:
	addl	$1, -4(%rbp) #rbp-4->rbp-4+1, j++
.L10:
	movl	-4(%rbp), %eax #eax->rbp-4 move j to eax
	cmpl	-28(%rbp), %eax #if(len>j) then jump to L12 else skip to next instruction
	jl	.L12
	addl	$1, -8(%rbp) #rbp-8->rbp-8+1, i++
.L9:
	movl	-8(%rbp), %eax #move the i to eax register
	cmpl	-28(%rbp), %eax #if eax<*(rbp-28) then jump to L13 label i<len
	jl	.L13
	#calling reverse subroutine
	movq	-40(%rbp), %rdx  #rdx->rbp-40 move the dest to rdx register(3rd argument to reverse function)
	movl	-28(%rbp), %ecx #ecx->rbp-28 move the len to ecx register
	movq	-24(%rbp), %rax #rax->rbp-24 move the str to rax register
	movl	%ecx, %esi #esi->ecx move the len to esi(second argument)
	movq	%rax, %rdi #rdi->rax move the str to rax register(first argument to reverse call)
	call	reverse #call reverse 
	nop
	leave
	.cfi_def_cfa 7, 8
	ret #return from sort subroutine
	.cfi_endproc
.LFE2:
	.size	sort, .-sort #size of sort subroutine
	.globl	reverse 
	.type	reverse, @function #reverse subroutine
reverse:
.LFB3:
	.cfi_startproc 
	endbr64 
	pushq	%rbp #push rbp (old base pointer) to stack
	.cfi_def_cfa_offset 16 
	.cfi_offset 6, -16
	movq	%rsp, %rbp #rbp->rsp, sets the current stack pointer as base pointer
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp) #rbp-24->rdi, move the str to rbp-24
	movl	%esi, -28(%rbp) #rbp-28->esi, move the len to rbp-28
	movq	%rdx, -40(%rbp) #rbp-40->rdx, move the dest to rbp-40
	movl	$0, -8(%rbp) #rbp-8->0, i->0
	jmp	.L15 #jump to L15 label
.L20:
	movl	-28(%rbp), %eax #eax->rbp-28 move the len to eax register
	subl	-8(%rbp), %eax #eax-=rbp-8, eax=len-i
	subl	$1, %eax #eax-=1, eax=len-i-1
	movl	%eax, -4(%rbp) #rbp-4->eax, move the len-i-1 to rbp-4 j=len-i-1
	nop 
	movl	-28(%rbp), %eax #eax->rbp-28 move the len to eax register
	movl	%eax, %edx #edx->eax move the len to edx
	shrl	$31, %edx #edx>>31, edx=len>>31
	addl	%edx, %eax #eax+=edx #adding sign bit to len(if len is negative then eax=-len)
	sarl	%eax #eax->len/2
	cmpl	%eax, -4(%rbp) #if(j<len2) then jump to L18 else skip to next instruction
	jl	.L18
	movl	-8(%rbp), %eax #eax->rbp-8 move the i to eax register
	cmpl	-4(%rbp), %eax #will set flags after caculating i-j
	je	.L23 #if(i==j) then jump to L23 label
	movl	-8(%rbp), %eax #eax->rbp-8 move the i to eax register
	movslq	%eax, %rdx #rdx->eax move i to rdx
	movq	-24(%rbp), %rax #rax->rbp-24 move the str to rax register
	addq	%rdx, %rax #rax+=rdx, rax=&str[i]
	movzbl	(%rax), %eax #eax->str[i]
	movb	%al, -9(%rbp) #rbp-9->str[j] temp=str[i]
	movl	-4(%rbp), %eax #eax->rbp-4 move j to eax
	movslq	%eax, %rdx #rdx->eax move j to rdx
	movq	-24(%rbp), %rax #rax->rbp-24 move the str to rax register
	addq	%rdx, %rax #rax+=rdx, rax=&str[j]
	movl	-8(%rbp), %edx #edx->rbp-8 move the i to edx register
	movslq	%edx, %rcx #rcx->edx move i to rcx
	movq	-24(%rbp), %rdx #rdx->rbp-24 move the str to rdx register
	addq	%rcx, %rdx #rdx+=rcx, rdx=&str[i]
	movzbl	(%rax), %eax #eax->str[j]
	movb	%al, (%rdx) #str[i]=str[j]
	movl	-4(%rbp), %eax #eax->rbp-4 move j to eax
	movslq	%eax, %rdx #rdx->eax move j to rdx
	movq	-24(%rbp), %rax #rax->rbp-24 move the str to rax register
	addq	%rax, %rdx #rdx+=rax, rdx=&str[j]
	movzbl	-9(%rbp), %eax #eax->rbp-9 move the temp to eax i.e. str[j]=temp
	movb	%al, (%rdx) #break
	jmp	.L18 #jump to L18 label
.L23:
	nop #do nothing 
.L18:
	addl	$1, -8(%rbp) #rbp-8+=1, i++
.L15:
	movl	-28(%rbp), %eax #eax->rbp-28 move the len to eax register
	movl	%eax, %edx #edx->eax move the len to edx
	shrl	$31, %edx #edx>>31, edx=len>>31
	addl	%edx, %eax #eax+=edx #adding sign bit to len(if len is negative then eax=-len)
	sarl	%eax #eax->len/2
	cmpl	%eax, -8(%rbp) #if(i<len/2) then jump to L20 else skip to next instruction
	jl	.L20
	movl	$0, -8(%rbp) #rbp-8->0, i->0(for the last loop in reverse function)
	jmp	.L21 #jump to L21 label
.L22:
	movl	-8(%rbp), %eax #eax->rbp-8 move the i to eax register
	movslq	%eax, %rdx #rdx->eax move i to rdx
	movq	-24(%rbp), %rax #rax->rbp-24 move the str to rax register
	addq	%rdx, %rax #rax+=rdx, rax=&str[i]
	movl	-8(%rbp), %edx #edx->rbp-8 move the i to edx register
	movslq	%edx, %rcx 	#rcx->edx move i to rcx
	movq	-40(%rbp), %rdx #rdx->rbp-40 move the dest to rdx
	addq	%rcx, %rdx #rdx+=rcx, rdx=&dest[i]
	movzbl	(%rax), %eax #eax->str[i]
	movb	%al, (%rdx) #dest[i]=str[i]
	addl	$1, -8(%rbp) #rbp-8+=1, i++
.L21:
	movl	-8(%rbp), %eax #eax->rbp-8 move the i to eax register
	cmpl	-28(%rbp), %eax #if(i<len) then jump to L22 else skip to next instruction
	jl	.L22
	nop
	nop
	popq	%rbp #rbp->rbp, restore the old value of rbp
	.cfi_def_cfa 7, 8 
	ret #return to caller
	.cfi_endproc
.LFE3:
	.size	reverse, .-reverse
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
