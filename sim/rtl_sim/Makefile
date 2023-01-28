##############################################################################
#
# Makefile for the T400 Core project.
#
# $Id$
#
# The dependencies for all VHDL source files are stored here.
#
# Copyright (c) 2006, Arnim Laeuger (arnim.laeuger@gmx.net)
#
# All rights reserved
#
##############################################################################


PROJECT_DIR = ../..
RTL_DIR     = $(PROJECT_DIR)/rtl/vhdl
TECH_DIR    = $(PROJECT_DIR)/rtl/tech/cyclone
GTECH_DIR   = $(PROJECT_DIR)/rtl/tech/generic
SYSTEM_DIR  = $(RTL_DIR)/system
BENCH_DIR   = $(PROJECT_DIR)/bench/vhdl

COMMONDEP=work
WORKDIR=--workdir=work

ELABORATE = ghdl -m $(WORKDIR)

.PHONY: all
all: work
	$(ELABORATE) tb_t410_behav_c0
	$(ELABORATE) tb_t411_behav_c0
	$(ELABORATE) tb_t420_behav_c0
	$(ELABORATE) tb_t421_behav_c0
	$(ELABORATE) tb_int_behav_c0
	$(ELABORATE) tb_microbus_behav_c0
	$(ELABORATE) tb_prod_behav_c0

.PHONY: clean
clean:
	ghdl --clean $(WORKDIR)
	rm -f *~ *.ghw *.hex

.PHONY: veryclean
veryclean: clean
	rm -rf work


.PHONY: run_behav
run_rom: $(COMMONDEP) work intel
	ghdl -m $(WORKDIR) tb_rom behav
	./tb_rom-behav --wave=tbrom.ghw

work:
	make import

.PHONY: import
import:
	mkdir -p work
	ghdl -i $(WORKDIR) $(TECH_DIR)/../*.vhd
	ghdl -i $(WORKDIR) $(TECH_DIR)/*.vhd
	ghdl -i $(WORKDIR) $(GTECH_DIR)/*.vhd
	ghdl -i $(WORKDIR) $(RTL_DIR)/*.vhd
	ghdl -i $(WORKDIR) $(SYSTEM_DIR)/*.vhd
	ghdl -i $(WORKDIR) $(BENCH_DIR)/*.vhd
