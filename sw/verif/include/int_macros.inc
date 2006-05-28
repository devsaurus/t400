	;; *******************************************************************
	;; $Id: int_macros.inc,v 1.1 2006-05-28 02:49:30 arniml Exp $
	;;
	;; Defines macros for interrupt tests.
	;;

check_sa	MACRO	addr
	lbi	3, 15
	;; request nibble 0 of SA
	ogi	0x0
	inl
	;; check this nibble
	x	0
	clra
	IF	addr & 0xf <> 0
	aisc	addr & 0xf
	ENDIF
	ske
	jmp	fail

	;; request nibble 1 of SA
	ogi	0x1
	inl
	;; check this nibble
	x	0
	clra
	IF	addr & 0x0f0 <> 0
	aisc	(addr >> 4) & 0xf
	ENDIF
	ske
	jmp	fail

	;; request nibble 2 of SA
	ogi	0x2
	inl
	;; check this nibble
	x	0
	clra
	IF	addr & 0xf00 <> 0
	aisc	(addr >> 8) & 0xf
	ENDIF
	ske
	jmp	fail

	ENDM
