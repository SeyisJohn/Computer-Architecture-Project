-------------------------------------------------------------------------------
--
-- Title       : ID_EX_Reg
-- Design      : ID_EX_Register
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\ID_EX_Reg\ID_EX_Register\src\ID_EX_Reg.vhd
-- Generated   : Thu Nov 26 00:39:42 2020
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
--{entity {ID_EX_Reg} architecture {ID_EX_Reg}}

library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX_Reg is
	port(
		 Clk : in STD_LOGIC;
		 rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs1_num : in STD_LOGIC_VECTOR(4 downto 0);
		 rs2_num : in STD_LOGIC_VECTOR(4 downto 0);
		 rs3_num : in STD_LOGIC_VECTOR(4 downto 0);
		 rd_num  : in STD_LOGIC_VECTOR(4 downto 0);
		 ALU_Ctrl: in STD_LOGIC_VECTOR(4 downto 0);
		 rs1_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs2_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs3_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs1_num_out : out STD_LOGIC_VECTOR(4 downto 0);
		 rs2_num_out : out STD_LOGIC_VECTOR(4 downto 0);
		 rs3_num_out : out STD_LOGIC_VECTOR(4 downto 0);
		 rd_num_out : out STD_LOGIC_VECTOR(4 downto 0);
		 ALU_Ctrl_out : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end ID_EX_Reg;

--}} End of automatically maintained section

architecture ID_EX_Reg of ID_EX_Reg is

signal rs1_temp : STD_LOGIC_VECTOR(127 downto 0);
signal rs2_temp : STD_LOGIC_VECTOR(127 downto 0);
signal rs3_temp : STD_LOGIC_VECTOR(127 downto 0);
signal rs1_num_temp : STD_LOGIC_VECTOR(4 downto 0);
signal rs2_num_temp : STD_LOGIC_VECTOR(4 downto 0);
signal rs3_num_temp : STD_LOGIC_VECTOR(4 downto 0);
signal rd_num_temp : STD_LOGIC_VECTOR(4 downto 0);
signal ALU_Ctrl_temp : STD_LOGIC_VECTOR(4 downto 0);

begin

	write: process(Clk)
	begin
		if(rising_edge(Clk)) then
			rs1_temp <= rs1;
			rs2_temp <= rs2;
			rs3_temp <= rs3;
			rs1_num_temp <= rs1_num;
			rs2_num_temp <= rs2_num;
			rs3_num_temp <= rs3_num;
			rd_num_temp <= rd_num;
			ALU_Ctrl_temp <= ALU_Ctrl;
		end if;
	end process;
	
	
	read: process(Clk)
	begin
		if(rising_edge(Clk)) then
			rs1_out <= rs1_temp;
			rs2_out <= rs2_temp;
			rs3_out <= rs3_temp;
			rs1_num_out <= rs1_num_temp;
			rs2_num_out <= rs2_num_temp;
			rs3_num_out <= rs3_num_temp;
			rd_num_out <= rd_num_temp;
			ALU_Ctrl_out <= ALU_Ctrl_temp;
		else
			null;
		end if;
	end process;
	

end ID_EX_Reg;
