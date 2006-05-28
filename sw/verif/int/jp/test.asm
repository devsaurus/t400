	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2006-05-28 13:19:04 arniml Exp $
	;;
	;; Checks interrupt on JP.
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
	jp	+


	org	0x3c
	jmp	fail
	org	0x3e
+	aisc	0xf
ret_instr:
	jmp	pass


	org	0x0fd
	jmp	fail
int_routine:
	nop
	save_m_c
	check_sa	ret_instr
	restore_c_m
	ret


	org	0x200
	include	"int_pass_fail.asm"
