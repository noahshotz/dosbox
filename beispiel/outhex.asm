;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Startadresse f�r kleine MSDOS-Programme (.com)
	org 100h

	; Programm startet hier

	; Datenzugriff �ber Datensegmentregister vorbereiten
	mov AX, CS
	mov DS, AX

	; Sprung zum Hauptprogramm
	jmp start


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Datenbereich

	; ein paar Beispieltexte mit Zeilenwechseln,
	; terminiert mit '$' zur Ausgabe mit DOS-Funktion 9
hello	db 'Moin',13,10,'$'
bye	db 'Bye',13,10,'$'
newline	db 13,10,'$'

	; ein paar Zahlenwerte f�r Beispielberechnungen
a	db 23h
b	db 85h
w	dw 89ABh


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hauptprogramm
; Konvention zur Parameter�bergabe (Subroutinen s.u.) in diesem Programm:
; Register AX bzw. AL f�r Daten (Zahlenwerte)
; Register DX f�r Adressen
start:
	; Gru� ausgeben
	mov DX, hello
	call outstring

	; Hex-Wort ausgeben
	mov AX, 1234h
	call outhexword
	call outnewline

	; Hex-Wort aus Speicher-Variable laden und ausgeben
	mov AX, [w]
	call outhexword
	call outnewline

	mov AL, [a]
	add AL, [b]
	call outhexbyte
	call outnewline

	; print Bye
	mov DX, bye
	call outstring

finish:	; terminate program
	mov AH, 4Ch
	int 21h


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Subroutinen (Unterprogramme)
; Konvention zur Parameter�bergabe in diesem Programm:
; Register AX bzw. AL f�r Daten (Zahlenwerte)
; Register DX f�r Adressen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Textausgabe

; outnewline: Zeilenwechsel ausgeben (CR and LF)
outnewline:
	mov DX, newline
	; fall-through
	; v
	; v
; outstring: Textstring ausgeben, terminiert mit '$'
; DX: Adresse des Strings
outstring:
	mov AH, 9	; DOS-Funktion 9: '$'-terminierten String ausgeben
	int 21h		; DOS aufrufen
	ret

; outchar: Zeichen ausgeben
; AL: Code des Zeichens
outchar:
	mov DL, AL
	mov AH, 2	; DOS-Funktion 2: Zeichen aus DL ausgeben
	int 21h		; DOS aufrufen
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Routinen zur Zahlenausgabe

; outhexword: Wort (16 Bit) hexadezimal ausgeben (4 Ziffern)
; AX: Ausgabewert
outhexword:
	push AX		; zweites Byte retten
	mov AL, AH	; erstes Byte als Parameter bereitstellen
	call outhexbyte	; erstes Byte ausgeben
	pop AX		; zweites Byte zur�ckholen
	call outhexbyte	; zweites Byte ausgeben
	ret

; outhexbyte: Byte (8 Bit) hexadezimal ausgeben (2 Ziffern)
; AL: Ausgabewert
outhexbyte:
	push AX		; zweite Ziffer retten
	shr AL, 4	; erste Ziffer (Halbbyte) zurechtschieben
	call outhexdigit
	pop AX		; zweite Ziffer zur�ckholen
	call outhexdigit
	ret

; outhexdigit: Halbbyte (4 Bit) hexadezimal ausgeben (1 Ziffer)
; AL (bits 3..0): Ausgabewert
outhexdigit:
	and AL, 0Fh	; maskieren: obere 4 Bits auf 0000 setzen
	cmp AL, 10	; pr�fen ob dezimal (< 10)
	jl outhexdigit_1	; falls ja, Hexadezimalanpassung �berspringen
	add AL, 'A'-10-'0'	; addiere zus�tzlichen Offset f�r Hex-Ziffern
outhexdigit_1:
	add AL, '0'	; addiere Offset f�r ASCII Ziffern-Zeichen
	jmp outchar	; Zeichen ausgeben (return von outchar)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ende der �bersetzung
	end
