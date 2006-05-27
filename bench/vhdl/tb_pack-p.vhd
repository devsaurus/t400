-------------------------------------------------------------------------------
--
-- $Id: tb_pack-p.vhd,v 1.3 2006-05-27 19:09:29 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.t400_pack.pc_t;

package tb_pack is

  component tb_elems
    generic (
      period_g  : time := 4.75 us;
      d_width_g : integer := 4;
      g_width_g : integer := 4
    );
    port (
      io_l_i  : in  std_logic_vector(7 downto 0);
      io_d_i  : in  std_logic_vector(d_width_g-1 downto 0);
      io_g_i  : in  std_logic_vector(g_width_g-1 downto 0);
      io_in_o : out std_logic_vector(g_width_g-1 downto 0);
      so_i    : in  std_logic;
      si_o    : out std_logic;
      sk_i    : in  std_logic;
      ck_o    : out std_logic
    );
  end component;

  signal tb_pc_s : pc_t;
  signal tb_sa_s : pc_t;

end tb_pack;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.2  2006/05/23 01:17:25  arniml
-- drive IN port
--
-- Revision 1.1  2006/05/15 21:55:27  arniml
-- initial check-in
--
-------------------------------------------------------------------------------
