-------------------------------------------------------------------------------
--
-- Testbench for the T411 system toplevel.
--
-- $Id: tb_t411-c.vhd,v 1.2 2006-05-15 21:56:02 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t411_behav_c0 of tb_t411 is

  for behav

    for t411_b: t411
      use configuration work.t411_struct_c0;
    end for;

    for tb_elems_b: tb_elems
      use configuration work.tb_elems_behav_c0;
    end for;

  end for;

end tb_t411_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.1.1.1  2006/05/06 01:56:44  arniml
-- import from local CVS repository, LOC_CVS_0_1
--
-------------------------------------------------------------------------------
