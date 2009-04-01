-------------------------------------------------------------------------------
--
-- Testbench for interrupt evaluation.
--
-- $Id$
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
