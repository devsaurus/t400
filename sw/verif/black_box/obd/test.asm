	;; *******************************************************************
	;; $Id: test.asm,v 1.2 2006-05-18 00:22:43 arniml Exp $
	;;
	;; Checks the OBD instruction.
	;;

	;; the cpu type is defined on asl's command line

	org	0x00
	clra

	;; output 1 on D
	aisc	0x1
	cab
	obd

	;; output 2 on D
	aisc	0x1
	cab
	obd

	;; output 4 on D
	;; note: last action on COP411L
	aisc	0x2
	cab
	obd

	;; output 8 on D
	aisc	0x4
	cab
	obd

	;; output 0xf on D
	aisc	0x7
	cab
	obd

	jmp	fail

	org	0x100
	include	"pass_fail.asm"
