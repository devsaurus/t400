	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
	;;
	;; Checks the COMP instruction.
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

	;; preload M0 with 0x8
	smb	0x3
	rmb	0x2
	rmb	0x1
	rmb	0x0

	ld	0x0
	;; test for 8 in a
	ske
	jmp	fail

	;; test for complementing all bits in a
	comp
	aisc	0x1
	ske
	jmp	fail

	jmp	pass

	org	0x100
	include	"pass_fail.asm"
