-------------------------------------------------------------------------------
--
-- The opcode decoder table.
-- Maps the binary opcodes to the mnemonic type.
--
-- $Id: t400_opc_table.vhd,v 1.1.1.1 2006-05-06 01:56:44 arniml Exp $
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

library ieee;
use ieee.std_logic_1164.all;

use work.t400_opt_pack.all;
use work.t400_pack.all;

entity t400_opc_table is

  generic (
    opt_type_g   : integer := t400_opt_type_420_c
  );
  port (
    opcode_i     : in  byte_t;
    mnemonic_o   : out mnemonic_t;
    multi_byte_o : out boolean
  );

end t400_opc_table;


architecture rtl of t400_opc_table is

begin

  -----------------------------------------------------------------------------
  -- Process opc_decode
  --
  -- Purpose:
  --   Decodes the opcode to the set of mnemonics.
  --
  opc_decode: process (opcode_i)
    variable t41x_type_v : boolean;
  begin
    -- default assignment
    mnemonic_o   <= MN_NOP;
    multi_byte_o <= false;
    -- determine type
    t41x_type_v  := opt_type_g = t400_opt_type_410_c;

    case opcode_i is
      -- Mnemonic ASC----------------------------------------------------------
      when "00110000" =>
        mnemonic_o   <= MN_ASC;

      -- Mnemonic ADD ---------------------------------------------------------
      when "00110001" =>
        mnemonic_o   <= MN_ADD;

      -- Mnemonic ADT ---------------------------------------------------------
      when "01001010" =>
        if not t41x_type_v then
          mnemonic_o <= MN_ADT;
        end if;

      -- Mnemonic AISC --------------------------------------------------------
      when "01010001" | "01010010" | "01010011" |
           "01010100" | "01010101" | "01010110" | "01010111" |
           "01011000" | "01011001" | "01011010" | "01011011" |
           "01011100" | "01011101" | "01011110" | "01011111" =>
        mnemonic_o   <= MN_AISC;

      -- Mnemonic CASC --------------------------------------------------------
      when "00010000" =>
        if not t41x_type_v then
          mnemonic_o <= MN_CASC;
        end if;

      -- Mnemonic CLRA --------------------------------------------------------
      when "00000000" =>
        mnemonic_o   <= MN_CLRA;

      -- Mnemonic COMP --------------------------------------------------------
      when "01000000" =>
        mnemonic_o   <= MN_COMP;

      -- Mnemonic NOP ---------------------------------------------------------
      when "01000100" =>
        mnemonic_o   <= MN_NOP;

      -- Mnemonic C -----------------------------------------------------------
      when "00110010" |                                         -- RC
           "00100010" =>                                        -- SC
        mnemonic_o   <= MN_C;

      -- Mnemonic XOR ---------------------------------------------------------
      when "00000010" =>
        mnemonic_o   <= MN_XOR;

      -- Mnemonic JID ---------------------------------------------------------
      when "11111111" =>
        mnemonic_o   <= MN_JID;

      -- Mnemonic JMP ---------------------------------------------------------
      when "01100000" | "01100001" | "01100010" | "01100011" =>
        mnemonic_o   <= MN_JMP;
        multi_byte_o <= true;

      -- Mnemonic JP_JSRP -----------------------------------------------------
      when "10000000" | "10000001" | "10000010" | "10000011" |
           "10000100" | "10000101" | "10000110" | "10000111" |
           "10001000" | "10001001" | "10001010" | "10001011" |
           "10001100" | "10001101" | "10001110" | "10001111" |
           "10010000" | "10010001" | "10010010" | "10010011" |
           "10010100" | "10010101" | "10010110" | "10010111" |
           "10011000" | "10011001" | "10011010" | "10011011" |
           "10011100" | "10011101" | "10011110" | "10011111" |
           "10100000" | "10100001" | "10100010" | "10100011" |
           "10100100" | "10100101" | "10100110" | "10100111" |
           "10101000" | "10101001" | "10101010" | "10101011" |
           "10101100" | "10101101" | "10101110" | "10101111" |
           "10110000" | "10110001" | "10110010" | "10110011" |
           "10110100" | "10110101" | "10110110" | "10110111" |
           "10111000" | "10111001" | "10111010" | "10111011" |
           "10111100" | "10111101" | "10111110" |
           "11000000" | "11000001" | "11000010" | "11000011" |
           "11000100" | "11000101" | "11000110" | "11000111" |
           "11001000" | "11001001" | "11001010" | "11001011" |
           "11001100" | "11001101" | "11001110" | "11001111" |
           "11010000" | "11010001" | "11010010" | "11010011" |
           "11010100" | "11010101" | "11010110" | "11010111" |
           "11011000" | "11011001" | "11011010" | "11011011" |
           "11011100" | "11011101" | "11011110" | "11011111" |
           "11100000" | "11100001" | "11100010" | "11100011" |
           "11100100" | "11100101" | "11100110" | "11100111" |
           "11101000" | "11101001" | "11101010" | "11101011" |
           "11101100" | "11101101" | "11101110" | "11101111" |
           "11110000" | "11110001" | "11110010" | "11110011" |
           "11110100" | "11110101" | "11110110" | "11110111" |
           "11111000" | "11111001" | "11111010" | "11111011" |
           "11111100" | "11111101" | "11111110" =>
        mnemonic_o   <= MN_JP_JSRP;

      -- Mnemonic JSR ---------------------------------------------------------
      when "01101000" | "01101001" | "01101010" | "01101011" =>
        mnemonic_o   <= MN_JSR;
        multi_byte_o <= true;

      -- Mnemonic RET ---------------------------------------------------------
      when "01001000" =>
        mnemonic_o   <= MN_RET;

      -- Mnemonic RETSK -------------------------------------------------------
      when "01001001" =>
        mnemonic_o   <= MN_RETSK;

      -- Mnemonic LD ----------------------------------------------------------
      when "00000101" | "00010101" | "00100101" | "00110101" =>
        mnemonic_o   <= MN_LD;

      -- Mnemonic LDD_XAD -----------------------------------------------------
      when "00100011" =>
        mnemonic_o   <= MN_LDD_XAD;
        multi_byte_o <= true;

      -- Mnemonic LQID --------------------------------------------------------
      when "10111111" =>
        mnemonic_o   <= MN_LQID;

      -- Mnemonic RMB ---------------------------------------------------------
      when "01001100" | "01000101" | "01000010" | "01000011" =>
        mnemonic_o   <= MN_RMB;

      -- Mnemonic SMB ---------------------------------------------------------
      when "01001101" | "01000111" | "01000110" | "01001011" =>
        mnemonic_o   <= MN_SMB;

      -- Mnemonic STII --------------------------------------------------------
      when "01110000" | "01110001" | "01110010" | "01110011" |
           "01110100" | "01110101" | "01110110" | "01110111" |
           "01111000" | "01111001" | "01111010" | "01111011" |
           "01111100" | "01111101" | "01111110" | "01111111" =>
        mnemonic_o   <= MN_STII;

      -- Mnemonic X -----------------------------------------------------------
      when "00000110" | "00010110" | "00100110" | "00110110" =>
        mnemonic_o   <= MN_X;

      -- Mnemonic XDS ---------------------------------------------------------
      when "00000111" | "00010111" | "00100111" | "00110111" =>
        mnemonic_o   <= MN_XDS;

      -- Mnemonic XIS ---------------------------------------------------------
      when "00000100" | "00010100" | "00100100" | "00110100" =>
        mnemonic_o   <= MN_XIS;

      -- Mnemonic CAB ---------------------------------------------------------
      when "01010000" =>
        mnemonic_o   <= MN_CAB;

      -- Mnemonic CBA ---------------------------------------------------------
      when "01001110" =>
        mnemonic_o   <= MN_CBA;

      -- Mnemonic LBI ---------------------------------------------------------
      when "00001000" | "00001001" | "00001010" | "00001011" |
           "00001100" | "00001101" | "00001110" | "00001111" |
           "00011000" | "00011001" | "00011010" | "00011011" |
           "00011100" | "00011101" | "00011110" | "00011111" |
           "00101000" | "00101001" | "00101010" | "00101011" |
           "00101100" | "00101101" | "00101110" | "00101111" |
           "00111000" | "00111001" | "00111010" | "00111011" |
           "00111100" | "00111101" | "00111110" | "00111111" =>
        mnemonic_o   <= MN_LBI;

      -- Mnemonic XABR --------------------------------------------------------
      when "00010010" =>
        if not t41x_type_v then
          mnemonic_o <= MN_XABR;
        end if;

      -- Mnemonic SKC ---------------------------------------------------------
      when "00100000" =>
        mnemonic_o   <= MN_SKC;

      -- Mnemonic SKE ---------------------------------------------------------
      when "00100001" =>
        mnemonic_o   <= MN_SKE;

      -- Mnemonic SKMBZ -------------------------------------------------------
      when "00000001" | "00010001" | "00000011" | "00010011" =>
        mnemonic_o   <= MN_SKMBZ;

      -- Mnemonic SKT ---------------------------------------------------------
      when "01000001" =>
        if not t41x_type_v then
          mnemonic_o <= MN_SKT;
        end if;

      -- Mnemonic XAS ---------------------------------------------------------
      when "01001111" =>
        mnemonic_o   <= MN_XAS;

      -- Mnemonic EXT ---------------------------------------------------------
      when "00110011" =>
        mnemonic_o   <= MN_EXT;
        multi_byte_o <= true;


      when others =>
        null;
    end case;
  end process opc_decode;
  --
  -----------------------------------------------------------------------------

end rtl;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
