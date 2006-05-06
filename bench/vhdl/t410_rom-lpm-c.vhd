-------------------------------------------------------------------------------
--
-- T410 ROM wrapper for lpm_rom.
--
-- $Id: t410_rom-lpm-c.vhd,v 1.1.1.1 2006-05-06 01:56:44 arniml Exp $
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


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
