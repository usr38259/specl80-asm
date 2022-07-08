include macros80.inc

FONT	EQU	0C3FFH
DELAYB	EQU	0C190H
DLY	EQU	0

	CALL	0C010H
STRT:	LXI	D, 0
	LXI	H, STR
SCRL:	PUSH	D
	PUSH	H
	MVI	B, 2FH
	MVI	H, 8FH
	MVI	D, 90H
NXB:	MVI	E, 5CH
	MOV	L, E
	MVI	C, 48H
	INR	D
	INR	H
LNX:	LDAX	D
	MOV	M, A
	INR	E
	INR	L
	DCR	C
	JNZ	LNX
	DCR	B
	JNZ	NXB
SE:	POP	H
	POP	D
	MOV	A, D
	ORA	A
	JNZ	SKLD
	MOV	A, M
	INX	H
	ORA	A
	JZ	STRT
	MOV	E, A
	MVI	A, 40H
SKLD:	RAR
	MOV	D, A
	PUSH	D
	PUSH	H
	MVI	H, 0
	MOV	L, E
	MOV	B, D
	DAD	H
	DAD	H
	DAD	H
	LXI	D, FONT
	DAD	D
	MVI	D, 09H
	MVI	C, 5CH
NXL:	MVI	E, 08H
	MOV	A, M
	INX	H
	PUSH	H
	PUSH	B
	MVI	H, 0BFH
	MOV	L, C
	ANA	B
	LXI	B, C0
	JZ	NC1
	LXI	B, C1
NC1:	LDAX	B
	MOV	M, A
	INR	L
	INX	B
	DCR	E
	JNZ	NC1
	POP	B
	MOV	C, L
	POP	H
	DCR	D
	JNZ	NXL
DLYA:	MVI	A, DLY
	MOV	B, A
	ORA	A
	CNZ	DELAYB
	POP	H
	POP	D
	JMP	SCRL

C0	DB	55H, 0AAH, 55H, 0AAH
	DB	55H, 0AAH, 55H, 0AAH
C1	DB	00H, 3CH, 7EH, 7EH
	DB	7EH, 7EH, 3CH, 00H

STR	DB	'specialist ZX-PK.RU ', 0

	ENDALL
