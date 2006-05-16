	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2006-05-16 22:54:07 arniml Exp $
	;;
	;; Checks the OGI instruction.
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

	;; output 1 on G
	ogi	0x1

	;; output 2 on G
	ogi	0x2

	;; output 4 on G
	ogi	0x4

	;; output 8 on G
	ogi	0x8

	;; output f on G
	ogi	0xf

	jmp	fail

	org	0x100
	include	"pass_fail.asm"
