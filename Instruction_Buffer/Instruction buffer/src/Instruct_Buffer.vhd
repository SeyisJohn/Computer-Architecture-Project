-------------------------------------------------------------------------------
--
-- Title       : Instruct_Buffer
-- Design      : Instruction buffer
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Instruction_Buffer\Instruction_Buffer\Instruction buffer\src\Instruct_Buffer.vhd
-- Generated   : Sun Nov 22 17:56:06 2020
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
--{entity {Instruct_Buffer} architecture {Instruct_Buffer}}

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Instruct_Buffer is
	 port(
		 PC : in STD_LOGIC_VECTOR(5 downto 0);
		 WriteMode : in STD_LOGIC;
		 Opcode : in STD_LOGIC_VECTOR(24 downto 0);
		 Clk : in STD_LOGIC;
		 Instruct : out STD_LOGIC_VECTOR(24 downto 0)
	     );
end Instruct_Buffer;

--}} End of automatically maintained section

architecture Instruct_Buffer of Instruct_Buffer is

type Instruction_table is array (0 to 63) of STD_LOGIC_VECTOR(24 downto 0);  

signal instruct_buffer : Instruction_table;
begin

	store_instruct: process(WriteMode, PC)
	begin
		if (WriteMode = '1') then 
			instruct_buffer(to_integer(UNSIGNED(PC))) <= Opcode;
		end if;
	end process; 
	
	
	read_instruct: process(Clk)
	begin
		if(rising_edge(Clk) and WriteMode = '0') then
			Instruct <= instruct_buffer(to_integer(UNSIGNED(PC)));
		else
			null;
		end if;
	end process;
	
end Instruct_Buffer;
