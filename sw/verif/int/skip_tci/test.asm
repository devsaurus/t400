	;; *******************************************************************
	;; $Id: test.asm,v 1.1 2006-06-05 02:12:36 arniml Exp $
	;;
	;; Checks interrupt on a skipped "transfer of control" instruction.
	;;

	;; the cpu type is defined on asl's command line

	include	"int_macros.inc"

	org	0x00
	clra

	int_flag_clear
	lei	0x02
	jp	int_mark

	org	0x030
int_mark:
	nop
	nop
int_instr:
	jsr	jsr_target
	jmp	fail		; this one is skipped, but interrupted
ret_instr:
	int_flag_check
	jmp	pass


	org	0x080
jsr_target:
	retsk



	;; *******************************************************************
	;; Interrupt routine
	;;
	org	0x0fd
	jmp	fail
int_routine:
	nop
	save_a_m_c
	int_flag_set
	check_sa	ret_instr
	restore_c_m_a
	ret


	org	0x200
	include	"int_pass_fail.asm"
