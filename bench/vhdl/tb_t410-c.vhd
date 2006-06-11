-------------------------------------------------------------------------------
--
-- Testbench for the T410 system toplevel.
--
-- $Id: tb_t410-c.vhd,v 1.1 2006-06-11 22:19:32 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t410_behav_c0 of tb_t410 is

  for behav

    for t410_b: t410
      use configuration work.t410_struct_c0;
    end for;

    for tb_elems_b: tb_elems
      use configuration work.tb_elems_behav_c0;
    end for;

  end for;

end tb_t410_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
