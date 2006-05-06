-------------------------------------------------------------------------------
--
-- Testbench for the T411 system toplevel.
--
-- $Id: tb_t411-c.vhd,v 1.1.1.1 2006-05-06 01:56:44 arniml Exp $
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

  end for;

end tb_t411_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
