-------------------------------------------------------------------------------
--
-- T400 Microcontroller Core
--
-- $Id: t400_core.vhd,v 1.1.1.1 2006-05-06 01:56:44 arniml Exp $
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
-- Limitations :
-- =============
--
-- Compared to the original COP400 architecture, the following limitations
-- apply:
--
--   * Features of the COP42x devices are either not yet implemented or
--     not verified.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.t400_opt_pack.all;

entity t400_core is

  generic (
    opt_type_g           : integer := t400_opt_type_420_c;
    opt_ck_div_g         : integer := t400_opt_ck_div_16_c;
    opt_cko_g            : integer := t400_opt_cko_crystal_c;
    opt_l_out_type_7_g   : integer := t400_opt_out_type_std_c;
    opt_l_out_type_6_g   : integer := t400_opt_out_type_std_c;
    opt_l_out_type_5_g   : integer := t400_opt_out_type_std_c;
    opt_l_out_type_4_g   : integer := t400_opt_out_type_std_c;
    opt_l_out_type_3_g   : integer := t400_opt_out_type_std_c;
    opt_l_out_type_2_g   : integer := t400_opt_out_type_std_c;
    opt_l_out_type_1_g   : integer := t400_opt_out_type_std_c;
    opt_l_out_type_0_g   : integer := t400_opt_out_type_std_c;
    opt_microbus_g       : integer := t400_opt_no_microbus_c;
    opt_d_out_type_3_g   : integer := t400_opt_out_type_std_c;
    opt_d_out_type_2_g   : integer := t400_opt_out_type_std_c;
    opt_d_out_type_1_g   : integer := t400_opt_out_type_std_c;
    opt_d_out_type_0_g   : integer := t400_opt_out_type_std_c;
    opt_g_out_type_3_g   : integer := t400_opt_out_type_std_c;
    opt_g_out_type_2_g   : integer := t400_opt_out_type_std_c;
    opt_g_out_type_1_g   : integer := t400_opt_out_type_std_c;
    opt_g_out_type_0_g   : integer := t400_opt_out_type_std_c;
    opt_so_output_type_g : integer := t400_opt_out_type_std_c;
    opt_sk_output_type_g : integer := t400_opt_out_type_std_c
  );
  port (
    ck_i      : in  std_logic;
    ck_en_i   : in  std_logic;
    por_n_i   : in  std_logic;
    reset_n_i : in  std_logic;
    cko_i     : in  std_logic;
    pm_addr_o : out std_logic_vector(9 downto 0);
    pm_data_i : in  std_logic_vector(7 downto 0);
    dm_addr_o : out std_logic_vector(5 downto 0);
    dm_we_o   : out std_logic;
    dm_data_o : out std_logic_vector(3 downto 0);
    dm_data_i : in  std_logic_vector(3 downto 0);
    io_l_i    : in  std_logic_vector(7 downto 0);
    io_l_o    : out std_logic_vector(7 downto 0);
    io_l_en_o : out std_logic_vector(7 downto 0);
    io_d_o    : out std_logic_vector(3 downto 0);
    io_d_en_o : out std_logic_vector(3 downto 0);
    io_g_i    : in  std_logic_vector(3 downto 0);
    io_g_o    : out std_logic_vector(3 downto 0);
    io_g_en_o : out std_logic_vector(3 downto 0);
    io_in_i   : in  std_logic_vector(3 downto 0);
    si_i      : in  std_logic;
    so_o      : out std_logic;
    so_en_o   : out std_logic;
    sk_o      : out std_logic;
    sk_en_o   : out std_logic
  );

end t400_core;


use work.t400_pack.all;
use work.t400_comp_pack.all;

architecture struct of t400_core is

  signal ck_en_s         : boolean;
  signal por_s           : boolean;
  signal res_s           : boolean;

  signal phi1_s          : std_logic;
  signal out_en_s        : boolean;
  signal in_en_s         : boolean;
  signal icyc_en_s       : boolean;

  signal pm_addr_s       : pc_t;

  signal a_s             : dw_t;
  signal dec_data_s      : dec_data_t;

  signal pc_to_stack_s,
         pc_from_stack_s : pc_t;

  signal q_s             : byte_t;
  signal b_s             : b_t;

  signal c_s,
         carry_s         : std_logic;

  signal sio_s           : dw_t;

  signal pc_op_s         : pc_op_t;
  signal stack_op_s      : stack_op_t;
  signal dmem_op_s       : dmem_op_t;
  signal b_op_s          : b_op_t;
  signal skip_op_s       : skip_op_t;
  signal alu_op_s        : alu_op_t;
  signal io_l_op_s       : io_l_op_t;
  signal io_d_op_s       : io_d_op_t;
  signal io_g_op_s       : io_g_op_t;
  signal sio_op_s        : sio_op_t;
  signal is_lbi_s        : boolean;
  signal en_s            : dw_t;

  signal skip_s,
         skip_lbi_s      : boolean;

  signal in_s,
         il_s            : dw_t;

  signal vdd_s  : std_logic;
  signal gnd4_s : dw_t;

begin

  -- dummies
  vdd_s  <= '1';
  gnd4_s <= (others => '0');
  in_s   <= (others => '0');
  il_s   <= (others => '0');

  ck_en_s <= ck_en_i = '1';
  por_s   <= por_n_i  = '0';

  -----------------------------------------------------------------------------
  -- Clock generator
  -----------------------------------------------------------------------------
  clkgen_b : t400_clkgen
    generic map (
      opt_ck_div_g => opt_ck_div_g
    )
    port map (
      ck_i      => ck_i,
      ck_en_i   => ck_en_s,
      por_i     => por_s,
      phi1_o    => phi1_s,
      out_en_o  => out_en_s,
      in_en_o   => in_en_s,
      icyc_en_o => icyc_en_s
    );


  -----------------------------------------------------------------------------
  -- Reset module
  -----------------------------------------------------------------------------
  reset_b : t400_reset
    port map (
      ck_i      => ck_i,
      icyc_en_i => icyc_en_s,
      por_i     => por_s,
      reset_n_i => reset_n_i,
      res_o     => res_s
    );


  -----------------------------------------------------------------------------
  -- Program memory controller
  -----------------------------------------------------------------------------
  pmem_ctrl_b : t400_pmem_ctrl
    generic map (
      opt_type_g => opt_type_g
    )
    port map (
      ck_i       => ck_i,
      ck_en_i    => ck_en_s,
      por_i      => por_s,
      res_i      => res_s,
      a_i        => a_s,
      m_i        => dm_data_i,
      op_i       => pc_op_s,
      dec_data_i => dec_data_s,
      pc_o       => pc_to_stack_s,
      pc_i       => pc_from_stack_s,
      pm_addr_o  => pm_addr_s
    );
  --
  pm_addr_o <= std_logic_vector(pm_addr_s);


  -----------------------------------------------------------------------------
  -- Data memory controller
  -----------------------------------------------------------------------------
  dmem_ctrl_b : t400_dmem_ctrl
    generic map (
      opt_type_g => opt_type_g
    )
    port map (
      ck_i       => ck_i,
      ck_en_i    => ck_en_s,
      por_i      => por_s,
      res_i      => res_s,
      dmem_op_i  => dmem_op_s,
      b_op_i     => b_op_s,
      dec_data_i => dec_data_s,
      a_i        => a_s,
      q_high_i   => q_s(7 downto 4),
      b_o        => b_s,
      dm_addr_o  => dm_addr_o,
      dm_data_i  => dm_data_i,
      dm_data_o  => dm_data_o,
      dm_we_o    => dm_we_o
    );


  -----------------------------------------------------------------------------
  -- Decoder
  -----------------------------------------------------------------------------
  decoder_b : t400_decoder
    generic map (
      opt_type_g => opt_type_g
    )
    port map (
      ck_i       => ck_i,
      ck_en_i    => ck_en_s,
      por_i      => por_s,
      res_i      => res_s,
      out_en_i   => out_en_s,
      in_en_i    => in_en_s,
      icyc_en_i  => icyc_en_s,
      pc_op_o    => pc_op_s,
      stack_op_o => stack_op_s,
      dmem_op_o  => dmem_op_s,
      b_op_o     => b_op_s,
      skip_op_o  => skip_op_s,
      alu_op_o   => alu_op_s,
      io_l_op_o  => io_l_op_s,
      io_d_op_o  => io_d_op_s,
      io_g_op_o  => io_g_op_s,
      sio_op_o   => sio_op_s,
      dec_data_o => dec_data_s,
      is_lbi_o   => is_lbi_s,
      en_o       => en_s,
      skip_i     => skip_s,
      skip_lbi_i => skip_lbi_s,
      pm_addr_i  => pm_addr_s,
      pm_data_i  => pm_data_i
    );


  -----------------------------------------------------------------------------
  -- Skip logic
  -----------------------------------------------------------------------------
  skip_b : t400_skip
    port map (
      ck_i       => ck_i,
      ck_en_i    => ck_en_s,
      por_i      => por_s,
      res_i      => res_s,
      op_i       => skip_op_s,
      dec_data_i => dec_data_s,
      carry_i    => carry_s,
      c_i        => c_s,
      bd_i       => b_s(bd_range_t),
      is_lbi_i   => is_lbi_s,
      a_i        => a_s,
      m_i        => dm_data_i,
      g_i        => io_g_i,
      tim_c_i    => gnd4_s(0),
      skip_o     => skip_s,
      skip_lbi_o => skip_lbi_s
    );


  -----------------------------------------------------------------------------
  -- ALU
  -----------------------------------------------------------------------------
  alu_b : t400_alu
    port map (
      ck_i       => ck_i,
      ck_en_i    => ck_en_s,
      por_i      => por_s,
      res_i      => res_s,
      op_i       => alu_op_s,
      m_i        => dm_data_i,
      dec_data_i => dec_data_s,
      q_low_i    => q_s(3 downto 0),
      b_i        => b_s,
      g_i        => io_g_i,
      in_i       => in_s,
      il_i       => il_s,
      sio_i      => sio_s,
      a_o        => a_s,
      carry_o    => carry_s,
      c_o        => c_s
    );


  -----------------------------------------------------------------------------
  -- Stack module
  -----------------------------------------------------------------------------
  stack_b : t400_stack
    generic map (
      opt_type_g => opt_type_g
    )
    port map (
      ck_i    => ck_i,
      ck_en_i => ck_en_s,
      por_i   => por_s,
      op_i    => stack_op_s,
      pc_i    => pc_to_stack_s,
      pc_o    => pc_from_stack_s
    );


  -----------------------------------------------------------------------------
  -- IO L module
  -----------------------------------------------------------------------------
  io_l_b : t400_io_l
    generic map (
      opt_out_type_7_g => opt_l_out_type_7_g,
      opt_out_type_6_g => opt_l_out_type_6_g,
      opt_out_type_5_g => opt_l_out_type_5_g,
      opt_out_type_4_g => opt_l_out_type_4_g,
      opt_out_type_3_g => opt_l_out_type_3_g,
      opt_out_type_2_g => opt_l_out_type_2_g,
      opt_out_type_1_g => opt_l_out_type_1_g,
      opt_out_type_0_g => opt_l_out_type_0_g,
      opt_microbus_g   => opt_microbus_g
    )
    port map (
      ck_i      => ck_i,
      ck_en_i   => ck_en_s,
      por_i     => por_s,
      op_i      => io_l_op_s,
      en2_i     => en_s(2),
      m_i       => dm_data_i,
      a_i       => a_s,
      pm_data_i => pm_data_i,
      q_o       => q_s,
      cs_n_i    => vdd_s,
      rd_n_i    => vdd_s,
      wr_n_i    => vdd_s,
      io_l_i    => io_l_i,
      io_l_o    => io_l_o,
      io_l_en_o => io_l_en_o
    );


  -----------------------------------------------------------------------------
  -- IO D module
  -----------------------------------------------------------------------------
  io_d_b : t400_io_d
    generic map (
      opt_out_type_3_g => opt_d_out_type_3_g,
      opt_out_type_2_g => opt_d_out_type_2_g,
      opt_out_type_1_g => opt_d_out_type_1_g,
      opt_out_type_0_g => opt_d_out_type_0_g
    )
    port map (
      ck_i      => ck_i,
      ck_en_i   => ck_en_s,
      por_i     => por_s,
      res_i     => res_s,
      op_i      => io_d_op_s,
      bd_i      => b_s(bd_range_t),
      io_d_o    => io_d_o,
      io_d_en_o => io_d_en_o
    );


  -----------------------------------------------------------------------------
  -- IO G modle
  -----------------------------------------------------------------------------
  io_g_b : t400_io_g
    generic map (
      opt_out_type_3_g => opt_g_out_type_3_g,
      opt_out_type_2_g => opt_g_out_type_2_g,
      opt_out_type_1_g => opt_g_out_type_1_g,
      opt_out_type_0_g => opt_g_out_type_0_g
    )
    port map (
      ck_i       => ck_i,
      ck_en_i    => ck_en_s,
      por_i      => por_s,
      res_i      => res_s,
      op_i       => io_g_op_s,
      m_i        => dm_data_i,
      dec_data_i => dec_data_s,
      io_g_o     => io_g_o,
      io_g_en_o  => io_g_en_o
    );


  -----------------------------------------------------------------------------
  -- SIO module
  -----------------------------------------------------------------------------
  sio_b : t400_sio
    generic map (
      opt_so_output_type_g => opt_so_output_type_g,
      opt_sk_output_type_g => opt_sk_output_type_g
    )
    port map (
      ck_i       => ck_i,
      ck_en_i    => ck_en_s,
      por_i      => por_s,
      res_i      => res_s,
      phi1_i     => phi1_s,
      out_en_i   => out_en_s,
      in_en_i    => in_en_s,
      op_i       => sio_op_s,
      en0_i      => en_s(0),
      en3_i      => en_s(3),
      a_i        => a_s,
      c_i        => c_s,
      sio_o      => sio_s,
      si_i       => si_i,
      so_o       => so_o,
      so_en_o    => so_en_o,
      sk_o       => sk_o,
      sk_en_o    => sk_en_o
    );

end struct;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
