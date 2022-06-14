org 100h
section .text
start:	
	mov ax, [dividend]
	mov bx, [divisor]
	div bx
	mov [quotient], ax
section .data
	dividend: dw 12, '$'
	divisor: dw 4, '$'
	quotient : dw 0, '$'
