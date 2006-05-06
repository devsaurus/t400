-------------------------------------------------------------------------------
--
-- $Id: t400_core_comp_pack-p.vhd,v 1.1.1.1 2006-05-06 01:56:44 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.t400_opt_pack.all;

package t400_core_comp_pack is

  component t400_core
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
  end component;

end t400_core_comp_pack;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
