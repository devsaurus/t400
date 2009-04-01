-------------------------------------------------------------------------------
--
-- T410 ROM wrapper for lpm_rom.
--
-- $Id$
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t410_rom_struct_c0 of t410_rom is

  for lpm

    for rom_b: lpm_rom
      use configuration work.lpm_rom_c0;
    end for;

  end for;

end t410_rom_struct_c0;
