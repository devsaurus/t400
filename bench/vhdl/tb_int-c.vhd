-------------------------------------------------------------------------------
--
-- Testbench for interrupt evaluation.
--
-- $Id: tb_int-c.vhd,v 1.2 2006-06-05 14:42:50 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_int_behav_c0 of tb_int is

  for behav

    for t420_b: t420
      use configuration work.t420_struct_c0;
    end for;

    for tb_elems_b: tb_elems
      use configuration work.tb_elems_behav_c0;
    end for;

  end for;

end tb_int_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.1  2006/05/27 19:08:21  arniml
-- initial check-in
--
-------------------------------------------------------------------------------
