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
		 Opcode_in : in STD_LOGIC_VECTOR(24 downto 0);
	 
		 PC : out STD_LOGIC_VECTOR(5 downto 0);
		 Out_Instruct: out STD_LOGIC_VECTOR(24 downto 0);
		 In_RegFile: out STD_LOGIC_VECTOR(24 downto 0);
		 
		 Out_RegFile_R1 : out STD_LOGIC_VECTOR(127 downto 0);
		 Out_RegFile_R2 : out STD_LOGIC_VECTOR(127 downto 0);
		 Out_RegFile_R3 : out STD_LOGIC_VECTOR(127 downto 0);
		 Out_RegFile_RSel1 : out STD_LOGIC_VECTOR(4 downto 0); 
		 Out_RegFile_RSel2 : out STD_LOGIC_VECTOR(4 downto 0);
		 Out_RegFile_RSel3 : out STD_LOGIC_VECTOR(4 downto 0);
		 Out_RegFile_RSelD : out STD_LOGIC_VECTOR(4 downto 0);
		 Out_RegFile_ALU_Ctrl : out STD_LOGIC_VECTOR(4 downto 0);
		 
		 In_ALU_R1 : out STD_LOGIC_VECTOR(127 downto 0); 
		 In_ALU_R2 : out STD_LOGIC_VECTOR(127 downto 0);
		 In_ALU_R3 : out STD_LOGIC_VECTOR(127 downto 0);
		 In_ALU_Ctrl : out STD_LOGIC_VECTOR(4 downto 0);
		 In_ALU_RDest : out STD_LOGIC_VECTOR(4 downto 0);
		 
		 Out_ALU_RD : out STD_LOGIC_VECTOR(127 downto 0);
		 Out_ALU_RDest : out STD_LOGIC_VECTOR(4 downto 0);
		 Out_ALU_Valid : out STD_LOGIC;
		 
		 Out_WB_Value : out STD_LOGIC_VECTOR(127 downto 0);
		 Out_WB_RDest : out STD_LOGIC_VECTOR(4 downto 0);
		 Out_WB_RWrite : out STD_LOGIC; --Register Write Signal
--		 
--		 In_DataForward_R1_num : out STD_LOGIC_VECTOR(4 downto 0);
--		 In_DataForward_R2_num : out STD_LOGIC_VECTOR(4 downto 0);
--		 In_DataForward_R3_num : out STD_LOGIC_VECTOR(4 downto 0);
--		 In_DataForward_Rd : out STD_LOGIC_VECTOR(127 downto 0);
--		 In_DataForward_Rd_num : out STD_LOGIC_VECTOR(4 downto 0);	 
--	 
		 Out_DataForward_Rd	: out STD_LOGIC_VECTOR(127 downto 0);
		 Out_DataForward_MuxSel : out STD_LOGIC_VECTOR(1 downto 0)
		 );
end System;

--}} End of automatically maintained section

architecture structural of System is   

 signal Instruct : STD_LOGIC_VECTOR(24 downto 0); -- opcode value from the instruct buffer before it enters IF/ID reg
 signal Instruct_out : STD_LOGIC_VECTOR(24 downto 0); --opcode value that exits the IF/ID reg		


 signal rs1 : STD_LOGIC_VECTOR(127 downto 0); -- rs1 value before it enters the ID_EX reg
 signal rs2 : STD_LOGIC_VECTOR(127 downto 0); -- rs2 value before it enters the ID_EX reg	
 signal rs3 : STD_LOGIC_VECTOR(127 downto 0); -- rs3 value before it enters the ID_EX reg
 
 signal rs1_o : STD_LOGIC_VECTOR(127 downto 0); -- rs1 value that exits the ID_EX reg
 signal rs2_o : STD_LOGIC_VECTOR(127 downto 0); -- rs2 value that exits the ID_EX reg	
 signal rs3_o : STD_LOGIC_VECTOR(127 downto 0); -- rs3 value that exits the ID_EX reg
 
 signal RSel1 : STD_LOGIC_VECTOR(4 downto 0);	-- Stores the number for the reg_1 out of the 32 registers, Value before it enters the ID_Ex reg   
 signal RSel2 : STD_LOGIC_VECTOR(4 downto 0);	--     	
 signal RSel3 : STD_LOGIC_VECTOR(4 downto 0);	   	
 signal RSelD : STD_LOGIC_VECTOR(4 downto 0);   -- Store the number for the destination register to be written to, Value before it enters the ID_EX reg 
 
 signal ALU_Ctrl  : STD_LOGIC_VECTOR(4 downto 0);	-- Stores the ALU Control function code, Value before it enters the ID_EX reg
  	  
 signal RSel1_o : STD_LOGIC_VECTOR(4 downto 0);	 -- Stores the number for the reg_1 out of the 32 registers, Value after it exits the ID_Ex reg  
 signal RSel2_o : STD_LOGIC_VECTOR(4 downto 0);	   	
 signal RSel3_o : STD_LOGIC_VECTOR(4 downto 0);	   	
 signal RselD_o : STD_LOGIC_VECTOR(4 downto 0);  -- Store the number for the destination register to be written to, Value after it exits the ID_EX reg 	
 
 signal ALU_Ctrl_out  : STD_LOGIC_VECTOR(4 downto 0);	-- Stores the ALU Control function code, Value after it exits the ID_EX reg
 
 
 signal writeData : STD_LOGIC_VECTOR(127 downto 0);  -- Data that is written to a register
 signal writeRegSel : STD_LOGIC_VECTOR(4 downto 0);	 -- Determines the register that should be written to
 signal writeEnable	: STD_LOGIC;  -- Determines if a register should have data be written to
 
 
 signal WriteValue : STD_LOGIC_VECTOR(127 downto 0);
 
 
 signal rd_out : STD_LOGIC_VECTOR(127 downto 0); -- Stores the value that comes out of the ALU
 signal valid : STD_LOGIC; -- Determines if the value that came out of the ALU should be written back into a register 
 signal Select_M : STD_LOGIC_VECTOR(1 downto 0); --Determines which register should be forwarded to.
 signal valid_rs1 : STD_LOGIC;	-- Specify if rs1 is valid for data forwarding
 signal valid_rs2 : STD_LOGIC;
 signal valid_rs3 : STD_LOGIC;
 
 signal rs1_out_m : STD_LOGIC_VECTOR(127 downto 0);
 signal rs2_out_m : STD_LOGIC_VECTOR(127 downto 0);
 signal rs3_out_m : STD_LOGIC_VECTOR(127 downto 0);
 signal reg_des_out : STD_LOGIC_VECTOR(4 downto 0);
 signal instruct_t : STD_LOGIC_VECTOR(4 downto 0);
 signal valid_rs1_in : STD_LOGIC;
 signal valid_rs2_in : STD_LOGIC;
 signal valid_rs3_in : STD_LOGIC;


begin
	
--Outputs:	  

	--Output from Instruct buffer
	Out_Instruct <= Instruct;
	
	-- Input into register file & Output from IF/ID Reg
	In_RegFile <= Instruct_out;

	-- Output of RegFile & Input to ID/EX reg
	Out_RegFile_R1 <= rs1; 
	Out_RegFile_R2 <= rs2;
	Out_RegFile_R3 <= rs3;
	Out_RegFile_RSel1 <= RSel1;
	Out_RegFile_RSel2 <= RSel2;
	Out_RegFile_RSel3 <= RSel3;	
	Out_RegFile_RSelD <= RSelD;
    Out_RegFile_ALU_Ctrl <= ALU_Ctrl;


	-- Input into ALU
	In_ALU_R1 <= rs1_out_m;
	In_ALU_R2 <= rs2_out_m;
    In_ALU_R3 <= rs3_out_m;
    In_ALU_Ctrl	<= instruct_t;
    In_ALU_RDest <= RSelD_o;


	-- Output of ALU & Input to EX/WB Reg
    Out_ALU_RD <= rd_out; 
    Out_ALU_RDest <= reg_des_out;
    Out_ALU_Valid <= valid;


	-- Output of EX/WB Reg
    Out_WB_Value <=	writeData;
    Out_WB_RDest <=	writeRegSel;
    Out_WB_RWrite <= writeEnable; 
--
--
--	--Input of Data forwarding
--	In_DataForward_R1_num <= RSel1_o;
--	In_DataForward_R2_num <= RSel2_o;
--	In_DataForward_R3_num <= RSel3_o;
--	In_DataForward_Rd <= WriteValue;
--	In_DataForward_Rd_num <= writeRegSel;


	--Output of Data Forwarding
	Out_DataForward_Rd <= WriteValue;
	Out_DataForward_MuxSel <= Select_M;


	
	instruct_buffer: entity instruct_fetch port map
		(
		Clk => Clk,
		Rst => Rst,
		Set => Set,
		WriteMode => WriteMode,
		PC_new => PC_new,
		Opcode => Opcode_in,
		Instruct => Instruct,
		PC_value => PC
		);
	
		
	IF_ID_Register: entity IF_ID_reg port map
		(
		Clk => Clk,
		Instruct_in => Instruct,
		Instruct_out => Instruct_out
		);
		
	Register_file : entity register_file port map
		(
--		Clk => Clk,
		input => Instruct_out,
		writeEnable => writeEnable,
		writeRegSel => writeRegSel,
		writeData => writeData,
		rs1 => rs1,
		rs2 => rs2,
		rs3 => rs3,
		RSel1 => RSel1,
		RSel2 => RSel2,
		RSel3 => RSel3,
		RSelD => RSelD,
		ALU_Ctrl => ALU_Ctrl,
		vRSel1 => valid_rs1_in,
		vRSel2 => valid_rs2_in,
		vRSel3 => valid_rs3_in
		);
		
	ID_EX_Register: entity ID_EX_Reg port map
		(
		Clk => Clk,
		rs1_id => rs1,
		rs2_id => rs2,
		rs3_id => rs3,
		rs1_num => RSel1,
		rs2_num => RSel2,
		rs3_num => RSel3,
		rd_num => RSelD,
		ALU_Ctrl => ALU_Ctrl,
		valid_rs1_in => valid_rs1_in,
		valid_rs2_in => valid_rs2_in,
		valid_rs3_in => valid_rs3_in,
		rs1_out => rs1_o,
		rs2_out => rs2_o,
		rs3_out => rs3_o,
		rs1_num_out => RSel1_o,
		rs2_num_out => RSel2_o,
		rs3_num_out => RSel3_o,
		rd_num_out => RSelD_o,
		ALU_Ctrl_out => ALU_Ctrl_out,
		valid_rs1_out => valid_rs1,
		valid_rs2_out => valid_rs2,
		valid_rs3_out => valid_rs3
		);
		
		
	forward_mux: entity forward_mux port map
		  (
		  rs1_m => rs1_o,
		  rs2_m => rs2_o,
		  rs3_m => rs3_o,
		  forward => Select_M,
		  WriteValue => WriteValue,
		  rs1_out_m => rs1_out_m,
		  rs2_out_m => rs2_out_m,
		  rs3_out_m => rs3_out_m,
		  ALU_instruct_in => ALU_Ctrl_out,
		  ALU_instruct_out => instruct_t
		  );
		  
	Alu: entity ALU port map
		(
		rs1_in => rs1_out_m,
		rs2_in => rs2_out_m,
		rs3_in => rs3_out_m,
		ALU_instruct => instruct_t,
		reg_des_in => RSelD_o, 
		rd => rd_out,
		reg_des_out => reg_des_out,
		valid => valid
		);	
		
		
	EX_WB_Register: entity EX_WB_Reg port map
		(
		Clk => Clk,
		Input => rd_out,
		Reg_Num_in => reg_des_out,
		Valid => valid,
		Output => writeData,
		Reg_Num_out => writeRegSel,
		Valid_out => writeEnable
		); 
		
		
	Data_forward: entity data_forward port map
		(
		valid => writeEnable,
		reg3_num => RSel3_o,
		reg2_num => RSel2_o,
		reg1_num => RSel1_o,
		In_reg_num => writeRegSel,
		In_value => writeData,
		valid_rs1 => valid_rs1,
		valid_rs2 => valid_rs2,
		valid_rs3 => valid_rs3,
		forward => Select_M,
		Out_Value => WriteValue
		);
	
	
		
		
		
end structural;
