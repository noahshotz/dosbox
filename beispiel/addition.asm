org 100h
section .text
start:	
	mov ax, [summand1]
	add ax, [summand2]
	mov [summe], ax
section .data
	summand1: dw 3, '$'
	summand2: dw 4, '$'
	summe : dw 0, '$'
