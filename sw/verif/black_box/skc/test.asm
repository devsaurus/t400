	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
	;;
	;; Checks the SKC instruction.
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

	skc
	jmp	ok_no_c
	jmp	fail

ok_no_c:
	sc
	skc
	jmp	fail

	jmp	pass


	org	0x100
	include	"pass_fail.asm"
