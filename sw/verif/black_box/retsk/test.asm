	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
	;;
	;; Checks the RETSK instruction.
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

page_0:
	jsr	target
	jmp	fail
	jmp	page_1

	org	0x045 - 2
	jmp	fail
page_1:
	jsr	target
	jmp	fail
	jmp	page_2

	org	0x09a - 2
	jmp	fail
page_2:
	jsr	target
	jmp	fail
	jmp	page_3

	org	0x0dd - 2
	jmp	fail
page_3:
	jsr	target
	jmp	fail
	jmp	page_4

	org	0x130 - 2
	jmp	fail
page_4:
	jsr	target
	jmp	fail
	jmp	page_5

	org	0x164 - 2
	jmp	fail
page_5:
	jsr	target
	jmp	fail
	jmp	page_6

	org	0x1ac - 2
	jmp	fail
page_6:
	jsr	target
	jmp	fail
	jmp	page_7

	org	0x1e1 - 2
	jmp	fail
page_7:
	jsr	target
	jmp	fail
	IF	MOMCPUNAME <> "COP410"
	jmp	page_8
	ELSEIF
	jmp	pass
	ENDIF


	;; *******************************************************************
	;; Subroutine target, execute RET
	;; 
	org	0x012 - 2
	jmp	fail
target:
	retsk
	;;
	;; *******************************************************************

	include	"pass_fail.asm"


	IF	MOMCPUNAME <> "COP410"

	org	0x205 - 2
	jmp	fail
page_8:
	jsr	target
	jmp	fail
	jmp	page_9

	org	0x246 - 2
	jmp	fail
page_9:
	jsr	target
	jmp	fail
	jmp	page_a

	org	0x270 - 2
	jmp	fail
page_a:
	jsr	target
	jmp	fail
	jmp	page_b

	org	0x2f0 - 2
	jmp	fail
page_b:
	jsr	target
	jmp	fail
	jmp	page_c

	org	0x311 - 2
	jmp	fail
page_c:
	jsr	target
	jmp	fail
	jmp	page_d

	org	0x35c - 2
	jmp	fail
page_d:
	jsr	target
	jmp	fail
	jmp	page_e

	org	0x3b3 - 2
	jmp	fail
page_e:
	jsr	target
	jmp	fail
	jmp	page_f

	org	0x3c8 - 2
	jmp	fail
page_f:
	jsr	target
	jmp	fail
	jmp	pass

	ENDIF
