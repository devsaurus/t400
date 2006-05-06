-------------------------------------------------------------------------------
--
-- The decoder unit.
-- Implements the instruction opcodes and controls all units of the T400 core.
--
-- $Id: t400_decoder-c.vhd,v 1.1.1.1 2006-05-06 01:56:44 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t400_decoder_rtl_c0 of t400_decoder is

  for rtl

    for opc_table_b: t400_opc_table
      use configuration work.t400_opc_table_rtl_c0;
    end for;

  end for;

end t400_decoder_rtl_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
