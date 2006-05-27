	;; *******************************************************************
	;; $Id: test.asm,v 1.1 2006-05-27 19:05:42 arniml Exp $
	;;
	;; Pass interrupt test.
	;; Always finds the pass mark when there's an interrupt
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

	lei	0x02
	jp	int_mark

	org	0x030
int_mark:
	nop
	nop
	nop
	jmp	fail


	org	0x0ff
	nop
	jmp	pass


	org	0x200
	include	"int_pass_fail.asm"
