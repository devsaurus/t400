-------------------------------------------------------------------------------
--
-- T410/411 controller toplevel without tri-states.
--
-- $Id: t410_notri-c.vhd,v 1.1.1.1 2006-05-06 01:56:45 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t410_notri_struct_c0 of t410_notri is

  for struct

    for core_b: t400_core
      use configuration work.t400_core_struct_c0;
    end for;

    for pmem_b: t410_rom
      use configuration work.t410_rom_struct_c0;
    end for;

    for dmem_b: generic_ram
      use configuration work.generic_ram_rtl_c0;
    end for;

    for por_b: t400_por
      use configuration work.t400_por_cyclone_c0;
    end for;

  end for;

end t410_notri_struct_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
