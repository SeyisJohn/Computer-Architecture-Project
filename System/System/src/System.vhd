-------------------------------------------------------------------------------
--
-- Title       : System
-- Design      : System
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\System\System\src\System.vhd
-- Generated   : Thu Nov 26 17:55:08 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {System} architecture {structural}}

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;

entity System is
	 port(
		 Clk : in STD_LOGIC;
		 Rst : in STD_LOGIC;
		 Set : in STD_LOGIC;
		 WriteMode : in STD_LOGIC;
		 PC_new : in STD_LOGIC_VECTOR(5 downto 0);
		 Opcode : in STD_LOGIC_VECTOR(24 downto 0)
	     );
end System;

--}} End of automatically maintained section

architecture structural of System is   

 signal Instruct : STD_LOGIC_VECTOR(24 downto 0); -- opcode value from the instruct buffer before it enters IF/ID reg
 signal Instruct_out : STD_LOGIC_VECTOR(24 downto 0); --opcode value that exits the IF/ID reg		


 signal rs1_t : STD_LOGIC_VECTOR(127 downto 0); -- rs1 value before it enters the ID_EX reg
 signal rs2_t : STD_LOGIC_VECTOR(127 downto 0); -- rs2 value before it enters the ID_EX reg	
 signal rs3_t : STD_LOGIC_VECTOR(127 downto 0); -- rs3 value before it enters the ID_EX reg
 
 signal rs1_o : STD_LOGIC_VECTOR(127 downto 0); -- rs1 value that exits the ID_EX reg
 signal rs2_o : STD_LOGIC_VECTOR(127 downto 0); -- rs2 value that exits the ID_EX reg	
 signal rs3_o : STD_LOGIC_VECTOR(127 downto 0); -- rs3 value that exits the ID_EX reg
 
 signal RSel1 : STD_LOGIC_VECTOR(4 downto 0);	-- Stores the number for the reg_1 out of the 32 registers, Value before it enters the ID_Ex reg   
 signal RSel2 : STD_LOGIC_VECTOR(4 downto 0);	--     	
 signal RSel3 : STD_LOGIC_VECTOR(4 downto 0);	   	
 signal RselD : STD_LOGIC_VECTOR(4 downto 0);   -- Store the number for the destination register to be written to, Value before it enters the ID_EX reg 
 
 signal ALU_Ctrl  : STD_LOGIC_VECTOR(4 downto 0);	-- Stores the ALU Control function code, Value before it enters the ID_EX reg
  	  
 signal RSel1_o : STD_LOGIC_VECTOR(4 downto 0);	 -- Stores the number for the reg_1 out of the 32 registers, Value after it exits the ID_Ex reg  
 signal RSel2_o : STD_LOGIC_VECTOR(4 downto 0);	   	
 signal RSel3_o : STD_LOGIC_VECTOR(4 downto 0);	   	
 signal RselD_o : STD_LOGIC_VECTOR(4 downto 0);  -- Store the number for the destination register to be written to, Value after it exits the ID_EX reg 
 signal RselD_o_2 : STD_LOGIC_VECTOR(4 downto 0);  -- Store the number for the destination register to be written to, Value after it exits the ALU		
 
 signal ALU_Ctrl_o  : STD_LOGIC_VECTOR(4 downto 0);	-- Stores the ALU Control function code, Value after it exits the ID_EX reg
 
 
 signal writeData : STD_LOGIC_VECTOR(127 downto 0);  -- Data that is written to a register
 signal writeRegSel : STD_LOGIC_VECTOR(4 downto 0);	 -- Determines the register that should be written to
 signal writeEnable	: STD_LOGIC;  -- Determines if a register should have data be written to
 
 
 signal WriteValue : STD_LOGIC_VECTOR(127 downto 0);
 
 
 signal ALU_out : STD_LOGIC_VECTOR(127 downto 0); -- Stores the value that comes out of the ALU
 signal valid : STD_LOGIC; -- Determines if the value that came out of the ALU should be written back into a register 
 signal Select_M : STD_LOGIC_VECTOR(1 downto 0); --Determines which register should be forwarded to.
 
 



begin

	instruct_buffer: entity instruct_fetch port map
		(
		Clk => Clk,
		Rst => Rst,
		Set => Set,
		WriteMode => WriteMode,
		PC_new => PC_new,
		Opcode => Opcode,
		Instruct => Instruct
		);
	
		
	IF_ID_Register: entity IF_ID_reg port map
		(
		Clk => Clk,
		Instruct_in => Instruct,
		Instruct_out => Instruct_out
		);
		
	Register_file : entity register_file port map
		(
		Clk => Clk,
		input => Instruct_out,
		writeEnable => writeEnable,
		writeRegSel => writeRegSel,
		writeData => writeData,
		rs1 => rs1_t,
		rs2 => rs2_t,
		rs3 => rs3_t,
		RSel1 => RSel1,
		RSel2 => RSel2,
		RSel3 => RSel3,
		RSelD => RSelD,
		ALU_Ctrl => ALU_Ctrl
		);
		
	ID_EX_Register: entity ID_EX_Reg port map
		(
		Clk => Clk,
		rs1_id => rs1_t,
		rs2_id => rs2_t,
		rs3_id => rs3_t,
		rs1_num => RSel1,
		rs2_num => RSel2,
		rs3_num => RSel3,
		rd_num => RSelD,
		ALU_Ctrl => ALU_Ctrl,
		rs1_out => rs1_o,
		rs2_out => rs2_o,
		rs3_out => rs3_o,
		rs1_num_out => RSel1_o,
		rs2_num_out => RSel2_o,
		rs3_num_out => RSel3_o,
		rd_num_out => RSelD_o,
		ALU_Ctrl_out => ALU_Ctrl_o
		);
		
		
	Execute_Stage: entity Execute port map
		(
		reg1 => rs1_o,
		reg2 => rs2_o,
		reg3 => rs3_o,
		forward => Select_M,
		WriteValue => WriteValue,
		instruct => ALU_Ctrl_o,
		reg_des_in => RSelD_o,
		rd_value => ALU_out,
		reg_des_out => RSelD_o_2,
		valid => valid
		);
		
		
	EX_WB_Register: entity EX_WB_Reg port map
		(
		Clk => Clk,
		Input => ALU_out,
		Reg_Num_in => RSelD_o_2,
		Valid => valid,
		Output => writeData,
		Reg_Num_out => writeRegSel,
		Valid_out => writeEnable
		); 
		
		
	Data_forward: entity data_forward port map
		(
		valid => valid,
		valid_2 => writeEnable,
		reg3_num => RSel3_o,
		reg2_num => RSel2_o,
		reg1_num => RSel1_o,
		In_reg_num => RSelD_o_2,
		In_reg_num_2 => writeRegSel,
		In_value => ALU_out,
		In_value_2 => writeData,
		forward => Select_M,
		Out_Value => WriteValue
		);
	
	
		
		
		
end structural;
