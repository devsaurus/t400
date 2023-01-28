-------------------------------------------------------------------------------
--
-- The timer unit.
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
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.t400_pack.all;

entity t400_timer is

  port (
    -- System Interface -------------------------------------------------------
    ck_i      : in  std_logic;
    ck_en_i   : in  boolean;
    por_i     : in  boolean;
    icyc_en_i : in  boolean;
    -- Skip Interface ---------------------------------------------------------
    op_i      : in  skip_op_t;
    c_o       : out boolean
  );

end t400_timer;


library ieee;
use ieee.numeric_std.all;

architecture rtl of t400_timer is

  signal cnt_q : unsigned(9 downto 0);
  signal c_q   : boolean;

begin

  -----------------------------------------------------------------------------
  -- Process seq
  --
  -- Purpose:
  --   Implements the sequential elements:
  --   * timer counter
  --   * carry (underflow) marker flag
  --
  seq: process (ck_i, por_i)
  begin
    if por_i then
      cnt_q <= (others => '1');
      c_q   <= false;

    elsif ck_i'event and ck_i = '1' then
      if icyc_en_i then
        if cnt_q = 0 then
          -- counter underflow:
          -- * reload counter
          -- * set marker flag
          cnt_q <= (others => '1');
          c_q   <= true;
        else
          cnt_q <= cnt_q - 1;
        end if;
      end if;

      if ck_en_i and op_i = SKIP_TIMER then
        c_q <= false;
      end if;
    end if;
  end process seq;
  --
  -----------------------------------------------------------------------------


  c_o <= c_q;

end rtl;
