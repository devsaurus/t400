	;; *******************************************************************
	;; $Id: test.asm,v 1.1 2006-05-28 02:44:27 arniml Exp $
	;;
	;; Checks interrupt on NOP.
	;;

	;; the cpu type is defined on asl's command line

	include	"int_macros.inc"

	org	0x00
	clra

	lei	0x02
	jp	int_mark

	org	0x030
int_mark:
	nop
	nop
int_instr:
	nop
ret_instr:
	jmp	pass


	org	0x0fd
	jmp	fail
int_routine:
	nop
	check_sa	ret_instr
	ret


	org	0x200
	include	"int_pass_fail.asm"
