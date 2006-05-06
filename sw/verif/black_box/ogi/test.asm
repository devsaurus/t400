	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
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

	;; output 0 on G
	ogi     0x0

	;; output 8 on G
	ogi	0x8

	;; output 0 on G
	ogi	0x0

	jmp	fail

	org	0x100
	include	"pass_fail.asm"
