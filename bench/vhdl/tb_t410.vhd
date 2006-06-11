-------------------------------------------------------------------------------
--
-- Testbench for the T410 system toplevel.
--
-- $Id: tb_t410.vhd,v 1.1 2006-06-11 22:19:32 arniml Exp $
--
-- Copyright (c) 2006 Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--      http://www.opencores.org/cvsweb.shtml/t400/
--
-------------------------------------------------------------------------------

entity tb_t410 is

end tb_t410;


library ieee;
use ieee.std_logic_1164.all;

use work.t400_system_comp_pack.t410;
use work.tb_pack.tb_elems;
use work.t400_opt_pack.all;

architecture behav of tb_t410 is

  -- 210.4 kHz clock
  constant period_c : time := 4.75 us;
  signal   ck_s     : std_logic;

  signal reset_n_s  : std_logic;

  signal io_l_s     : std_logic_vector(7 downto 0);
  signal io_d_s     : std_logic_vector(3 downto 0);
  signal io_g_s     : std_logic_vector(3 downto 0);

  signal si_s,
         so_s,
         sk_s       : std_logic;

  signal vdd_s      : std_logic;

begin


  vdd_s     <= '1';
  reset_n_s <= '1';

  -----------------------------------------------------------------------------
  -- DUT
  -----------------------------------------------------------------------------
  t410_b : t410
    generic map (
      opt_ck_div_g => t400_opt_ck_div_8_c
    )
    port map (
      ck_i      => ck_s,
      ck_en_i   => vdd_s,
      reset_n_i => reset_n_s,
      si_i      => si_s,
      so_o      => so_s,
      sk_o      => sk_s,
      io_l_b    => io_l_s,
      io_d_o    => io_d_s,
      io_g_b    => io_g_s
    );

  io_l_s <= (others => 'H');
  io_d_s <= (others => 'H');
  io_g_s <= (others => 'H');


  -----------------------------------------------------------------------------
  -- Testbench elements
  -----------------------------------------------------------------------------
  tb_elems_b : tb_elems
    generic map (
      period_g  => period_c,
      d_width_g => 4,
      g_width_g => 4
    )
    port map (
      io_l_i  => io_l_s,
      io_d_i  => io_d_s,
      io_g_i  => io_g_s,
      io_in_o => open,
      so_i    => so_s,
      si_o    => si_s,
      sk_i    => sk_s,
      ck_o    => ck_s
    );

end behav;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.6  2006/06/05 18:50:45  arniml
-- remove obsolete en_clk_s
--
-- Revision 1.5  2006/05/27 19:10:12  arniml
-- explicitly select clock divider 8
--
-- Revision 1.4  2006/05/23 01:18:26  arniml
-- consider IN port
--
-- Revision 1.3  2006/05/15 21:56:02  arniml
-- moved elements to separate design unit tb_elems
--
-- Revision 1.2  2006/05/06 13:34:25  arniml
-- remove delta cycle filter on sk_s
--
-- Revision 1.1.1.1  2006/05/06 01:56:44  arniml
-- import from local CVS repository, LOC_CVS_0_1
--
-------------------------------------------------------------------------------
