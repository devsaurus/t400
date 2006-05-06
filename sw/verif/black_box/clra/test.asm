	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
	;;
	;; Checks the CLRA instruction.
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

	;; preload M0 with 0x0
	rmb	0x3
	rmb	0x2
	rmb	0x1
	rmb	0x0

	;; test for initial 0 in a
	ske
	jmp	fail

	;; test for clearing all bits in a
	aisc	0xf
	clra
	ske
	jmp	fail

	jmp	pass

	org	0x100
	include	"pass_fail.asm"
