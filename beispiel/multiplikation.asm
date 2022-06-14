; http://www.i8086.de/asm/8086-88-asm-mul.html

org 100h
section .text
start:	
	mov ax, [faktor1]
	mov bx, [faktor2]
	mul bx
	mov [produkt], ax
section .data
	faktor1: dw 3, '$'
	faktor2: dw 4, '$'
	produkt : dw 0, '$'
