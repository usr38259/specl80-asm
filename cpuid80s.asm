
;CPUID for 8080/8085/z80 and compatibles, Version 1.6r
;Ivan Gorodetsky 20.01.2014, 08.01.2022
;Adapted for "Specialist" retro PC / Syabr (by lexarr, 06.23)
;
;Used some code and ideas from Ermolaev Sergey (SES), Perlin Vitaly (PPC),
; Slavinsky Vjacheslav (svofski)
;
;Compile with Turbo Assembler (TASM) using MACROS80.INC, tlink and exe2bin.

include macros80.inc

putstr	EQU	0C438h

	lxi 	h, msg_cpu
	call 	putstr
	call 	cpudetect
	call	putstr
	ret

cpudetect:
	sub	a
	jpo	difz80
	push	psw
	pop	h
	mov	e, l
	mvi	a, 00100010b
	xra	l
	mov	l, a
	push	h
	pop	psw
	push	psw
	pop	h
	mov	a,l
	xra	e
	jz	dif8080
	lxi	h, msg_8085
	rpe
	lxi	h, msg_vm1
	ret
dif8080:
	ani	00001000b
	daa
	lxi	h, msg_amd8080
	rz
	lxi	h, msg_i8080
	ret
difz80:
	mvi	e,1
	mov	l,e
	db	0EDh, 0D9h		;mulub a,e for r800 / nop for z80
	ora	l
	lxi	h, msg_r800
	rz
	lxi	h, msg_z80
	ret

msg_cpu		db	0Ah, "CPU: ", 0
msg_z80		db	"Z80", 0Ah, 0
msg_r800	db	"R800", 0Ah, 0
msg_i8080	db	"I8080", 0Ah, 0
msg_amd8080	db	"AMD8080", 0Ah, 0
msg_8085	db	"8085", 0Ah, 0
msg_vm1		db	"580VM1", 0Ah, 0

ENDALL
