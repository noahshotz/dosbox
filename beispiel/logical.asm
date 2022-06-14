org 100h
section .text
start:	
	; UND-Operation ab
	mov ax, [a]
	and ax, [b]
	; ODER-Operation a + b 
	mov ax, [a]
	or ax, [b]
	; EXCLUSIV-ODER-Operation a XOR b
	mov ax, [a]
	xor ax, [b]

	;Bitshift um drei nach links
	mov ax, [a]
	shl ax, 3

	;Bitshift um um zwei nach rechts
	shr ax, 2
	
	
section .data
	a: dw 5, '$'
	b: dw 3, '$'
	
