bits 64
;       (d*a)/((a+b)*c)+(d+b)/(e-a)
section .data
res:
        dq      0
a:
        dd      30
b:
        dw      20
c:
        dd      2
d:
        dw      10
e:
        dq      60
section .text
global  _start
_start:
        movzx   eax, word[d]
        mov     ebx, dword[a]
	mul	ebx
	movzx	edx, word[b]
	add	ebx, edx
	mov	rdi, rax
	mov	eax, dword[c]
	mul	ebx
	mov	ebx, eax
	mov	rax, rdi
	cmp	ebx, 0
	je	division_by_zero
	div	ebx
	mov	ebx, eax
	movzx	edx, word[b]
	movzx	eax, word[d]
	add	eax, edx
	mov	edx, dword[a]
	mov	rsi, qword[e]
	cmp	rsi, rdx
        jb      is_not_subtracted
	sub	rsi, rdx
	cmp	rsi, 0
	je	division_by_zero
	xor	rdx, rdx
	div	rsi
	add	rax, rbx
        mov     [res], rax
        mov     rax, 60
        mov     rdi, 0
        syscall
division_by_zero:
        mov     rax, 60
        mov     rdi, 1
        syscall
is_not_subtracted:
        mov     rax, 60
        mov     rdi, 2
        syscall
