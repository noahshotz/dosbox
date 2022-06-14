org 100h
section .text
start:	
	mov ax, [summand1]
	mov bx, [summand1]
	mov cx, [summand1]
	mov dx, [summand1]
	mov [summe], ax
section .data
	summand1: dw 3, '$'
	summand2: dw 4, '$'
	summe : dw 0, $
