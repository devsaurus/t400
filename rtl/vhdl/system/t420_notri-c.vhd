-------------------------------------------------------------------------------
--
-- T420/421 controller toplevel without tri-states.
--
-- $Id: t420_notri-c.vhd,v 1.2 2006-06-05 20:03:11 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t420_notri_struct_c0 of t420_notri is

  for struct

    for core_b: t400_core
      use configuration work.t400_core_struct_c0;
    end for;

    for pmem_b: t420_rom
      use configuration work.t420_rom_struct_c0;
    end for;

    for dmem_b: generic_ram_ena
      use configuration work.generic_ram_ena_rtl_c0;
    end for;

    for por_b: t400_por
      use configuration work.t400_por_rtl_c0;
    end for;

  end for;

end t420_notri_struct_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.1  2006/05/14 22:29:01  arniml
-- initial check-in
--
-------------------------------------------------------------------------------
