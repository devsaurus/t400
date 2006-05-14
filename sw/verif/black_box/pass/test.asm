	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2006-05-14 22:32:37 arniml Exp $
	;;
	;; Pass test.
	;; Always finds the pass mark.
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

	jmp	pass


	org	0x0c0
	include	"pass_fail.asm"
