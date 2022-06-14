; Quelle: 
; https://de.wikibooks.org/wiki/Assembler-Programmierung_f%C3%BCr_x86-Prozessoren/_Spr%C3%BCnge_und_Schleifen

org 100h
 start:
   mov cx, 7
   mov ax, 1
   mov bx, 1
 schleife:
   mul bx
   inc bx
   loop schleife
   mov ah, 4Ch
   int 21h