	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
	;;
	;; Checks the CASC instruction.
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

	;; preload M0 with 0xa
	smb	0x3
	rmb	0x2
	smb	0x1
	rmb	0x0

	rc
	asc	0xf
	;; test a15 + m5 + c0
	casc
	jmp	ok_a15_m5_c0_carry
	jmp	fail
ok_a15_m5_c0_carry:
	skc
	jmp	ok_a15_m5_c0_c
	jmp	fail
ok_a15_m5_c0_c:
	ske
	jmp	fail


	jmp	pass

	org	0x100
	include	"pass_fail.asm"
