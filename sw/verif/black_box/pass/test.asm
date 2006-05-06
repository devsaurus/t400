	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
	;;
	;; Pass test.
	;; Always finds the pass mark.
	;;

	CPU	COP410

	org	0x00
	clra

	jmp	pass


	org	0x0c0
	include	"pass_fail.asm"
