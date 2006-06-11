-------------------------------------------------------------------------------
--
-- Testbench for the T421 system toplevel.
--
-- $Id: tb_t421-c.vhd,v 1.1 2006-06-11 13:49:50 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t421_behav_c0 of tb_t421 is

  for behav

    for t421_b: t421
      use configuration work.t421_struct_c0;
    end for;

    for tb_elems_b: tb_elems
      use configuration work.tb_elems_behav_c0;
    end for;

  end for;

end tb_t421_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
