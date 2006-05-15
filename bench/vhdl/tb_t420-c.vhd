-------------------------------------------------------------------------------
--
-- Testbench for the T420 system toplevel.
--
-- $Id: tb_t420-c.vhd,v 1.1 2006-05-15 22:21:59 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t420_behav_c0 of tb_t420 is

  for behav

    for t420_b: t420
      use configuration work.t420_struct_c0;
    end for;

    for tb_elems_b: tb_elems
      use configuration work.tb_elems_behav_c0;
    end for;

  end for;

end tb_t420_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
