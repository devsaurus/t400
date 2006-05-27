#!/usr/bin/perl -w
#
##############################################################################
#
# run_regression.pl
#
# $Id: run_regression.pl,v 1.2 2006-05-27 22:48:52 arniml Exp $
#
# Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
#
# All rights reserved
#
# ############################################################################
#
# Purpose:
# ========
#
# Runs regression suite over all testcells found in $PROJECT_DIR/sw/verif.
#
# The testcells are identified by searching for the testbench identifiers
# as defined below for %testbenches.
# Then each testcell is built and executed with the specified testcells.
#

use strict;


my $project_dir = $ENV{'PROJECT_DIR'};
my $verif_dir   = $project_dir.'/sw/verif';
my $sim_dir     = $project_dir.'/sim/rtl_sim';

# the testbenches and their identifiers
my %testbenches = ('t41x' => './tb_t411_behav_c0',
                   't42x' => './tb_t420_behav_c0',
                   'int'  => './tb_int_behav_c0');
my ($tb_name, $tb_exec);

# identify the directories below $verif_dir containing test classes
my @classes_dirs = ('black_box', 'int');

my $dir;
my %testdirs;

# common GHDL options
my $ghdl_options = '--assert-level=error';


##############################################################################
# find all test directories for all the testbenches
#
foreach $dir (@classes_dirs) {
    $dir = $verif_dir.'/'.$dir;

    while (($tb_name, $tb_exec) = each(%testbenches)) {
        my $elem;
        my @dirs = `find $dir -type f -name $tb_name`;

        foreach $elem (@dirs) {
            $elem =~ s/\/[^\/]+$//;
            $testdirs{$elem} = 1;
        }
    }
}


##############################################################################
# run through all tests and execute the enabled testbenches
#
chdir($sim_dir);
while (($dir, $tb_exec) = each(%testdirs)) {
    # remove all previous hex files
    system('rm -f *.hex');

    chdir($dir);
    print("Building $dir\n");
    if (system('make all clean') == 0) {
        my @execute_tbs;

        # collect the testbenches to be executed
        while (($tb_name, $tb_exec) = each(%testbenches)) {
            if (-f $tb_name) {
                push(@execute_tbs, $tb_name);
            }
        }

        # and finally execute them
        chdir($sim_dir);
        foreach $tb_name (@execute_tbs) {
            print("Executing for $tb_name\n");
            system("$testbenches{$tb_name} $ghdl_options");
        }
    } else {
        print("Build failed\n");
    }
}
