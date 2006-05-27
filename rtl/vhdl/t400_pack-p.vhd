-------------------------------------------------------------------------------
--
-- $Id: t400_pack-p.vhd,v 1.3 2006-05-27 19:16:52 arniml Exp $
--
-- Copyright (c) 2006, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package t400_pack is

  -- Byte ---------------------------------------------------------------------
  subtype byte_t     is std_logic_vector(7 downto 0);

  -- Data word ----------------------------------------------------------------
  subtype dw_t       is std_logic_vector(3 downto 0);

  -- Misc ranges --------------------------------------------------------------
  subtype dw_range_t is natural range dw_t'range;
  subtype b_range_t  is natural range 5 downto 0;
  subtype br_range_t is natural range 5 downto 4;
  subtype bd_range_t is natural range 3 downto 0;

  -- B address ----------------------------------------------------------------
  subtype b_t        is std_logic_vector(b_range_t);
  subtype br_t       is std_logic_vector(br_range_t);
  subtype bd_t       is std_logic_vector(bd_range_t);


  -- Program counter ----------------------------------------------------------
  subtype pc_t       is unsigned(9 downto 0);

  -- Data memory address vector -----------------------------------------------
  subtype dm_addr_t  is std_logic_vector(5 downto 0);

  -- Decoder data -------------------------------------------------------------
  subtype dec_data_t is std_logic_vector(pc_t'range);

  -- Program counter operations -----------------------------------------------
  type    pc_op_t    is (PC_NONE,
                         PC_INC_PC,
                         PC_LOAD_6, PC_LOAD_7, PC_LOAD_8, PC_LOAD,
                         PC_POP,
                         PC_LOAD_A_M,
                         PC_INT);

  -- Data memory controller operations ----------------------------------------
  type    dmem_op_t  is (DMEM_RB,
                         DMEM_WB_SRC_Q, DMEM_WB_SRC_DEC, DMEM_WB_SRC_A,
                         DMEM_RDEC,
                         DMEM_WB_SET_BIT, DMEM_WB_RES_BIT,
                         DMEM_WDEC_SRC_A);
  type    b_op_t     is (B_NONE,
                         B_SET_BD, B_SET_BR,
                         B_SET_B, B_SET_B_INC,
                         B_XOR_BR,
                         B_INC_BD,
                         B_DEC_BD);

  -- Stack operations ---------------------------------------------------------
  type    stack_op_t is (STACK_NONE,
                         STACK_PUSH,
                         STACK_POP);

  -- ALU operations -----------------------------------------------------------
  type    alu_op_t   is (ALU_NONE,
                         ALU_CLRA,
                         ALU_LOAD_M,
                         ALU_LOAD_Q, ALU_LOAD_G, ALU_LOAD_IN, ALU_LOAD_IL,
                         ALU_LOAD_BR, ALU_LOAD_BD,
                         ALU_LOAD_SIO,
                         ALU_ADD, ALU_ADD_10, ALU_ADD_C, ALU_ADD_DEC,
                         ALU_COMP,
                         ALU_RC, ALU_SC,
                         ALU_XOR);

  -- Skip operations ----------------------------------------------------------
  type    skip_op_t  is (SKIP_NONE,
                         SKIP_UPDATE,
                         SKIP_NOW,
                         SKIP_CARRY, SKIP_C,
                         SKIP_BD_UFLOW, SKIP_BD_OFLOW,
                         SKIP_LBI,
                         SKIP_A_M,
                         SKIP_G_ZERO, SKIP_G_BIT,
                         SKIP_M_BIT,
                         SKIP_TIMER,
                         SKIP_PUSH, SKIP_POP);

  -- IO L port operations -----------------------------------------------------
  type    io_l_op_t  is (IOL_NONE,
                         IOL_LOAD_AM, IOL_LOAD_PM,
                         IOL_OUTPUT_L,
                         IOL_OUTPUT_Q);

  -- IO D port operations -----------------------------------------------------
  type    io_d_op_t  is (IOD_NONE,
                         IOD_LOAD);

  -- IO G port operations -----------------------------------------------------
  type    io_g_op_t  is (IOG_NONE,
                         IOG_LOAD_M,
                         IOG_LOAD_DEC);

  -- IO IN port operations ----------------------------------------------------
  type    io_in_op_t is (IOIN_NONE,
                         IOIN_INIL,
                         IOIN_INTACK);

  -- SIO operations -----------------------------------------------------------
  type    sio_op_t   is (SIO_NONE,
                         SIO_LOAD);

  -- Mnemonics ----------------------------------------------------------------
  type    mnemonic_t is (-- Arithmetic instructions
                         MN_ASC,
                         MN_ADD,
                         MN_ADT,
                         MN_AISC,
                         MN_CASC,
                         MN_CLRA,
                         MN_COMP,
                         MN_NOP,
                         MN_C,
                         MN_XOR,
                         -- Transfer of control instructions
                         MN_JID,
                         MN_JMP,
                         MN_JP_JSRP,
                         MN_JSR,
                         MN_RET,
                         MN_RETSK,
                         -- Memory reference instructions
                         MN_LD,
                         MN_LDD_XAD,
                         MN_LQID,
                         MN_RMB,
                         MN_SMB,
                         MN_STII,
                         MN_X,
                         MN_XDS,
                         MN_XIS,
                         -- Register reference instructions
                         MN_CAB,
                         MN_CBA,
                         MN_LBI,
                         MN_XABR,
                         -- Test instructions
                         MN_SKC,
                         MN_SKE,
                         MN_SKMBZ,
                         MN_SKT,
                         -- Input/output instructions
                         MN_EXT,
                         MN_XAS);

end t400_pack;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.2  2006/05/22 00:01:21  arniml
-- operations for IN port added
--
-- Revision 1.1.1.1  2006/05/06 01:56:45  arniml
-- import from local CVS repository, LOC_CVS_0_1
--
-------------------------------------------------------------------------------
