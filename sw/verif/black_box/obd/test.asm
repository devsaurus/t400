	;; *******************************************************************
	;; $Id: test.asm,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
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

	;; output 0 on D
	clra
	cab
	obd

	;; output 4 on D
	aisc	0x4
	cab
	obd

	;; output 8 on D
	aisc	0x4
	cab
	obd

	jmp	fail

	org	0x100
	include	"pass_fail.asm"
