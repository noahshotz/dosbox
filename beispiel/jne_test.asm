org 100h
 start:
   mov dx,meldung1
   mov ah,9h
   int 021h
   mov ah, 01h    ;Wert über die Tastatur einlesen
   int 021h
   cmp al, '5'
   jne fehler
   mov dx,meldung2
   mov ah,9h
   int 021h
   call ende
 fehler:
   mov dx,meldung3
   mov ah,9h
   int 21h
 ende:   
   mov ah,4Ch
   int 21h
 section .data
   meldung1: db 'Bitte geben Sie Ihre Glueckzahl ein:', 13, 10, '$'
   meldung2: db 13, 10, 'Volltreffer! Sie haben gewonnen :)', 13, 10, '$'
   meldung3: db 13, 10, 'Ja mei. Leider de foische Zoi. Versuchens halt noamoal :(', 13, 10, '$'
