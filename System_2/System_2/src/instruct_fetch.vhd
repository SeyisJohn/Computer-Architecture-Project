-------------------------------------------------------------------------------
--
-- Title       : instruct_fetch
-- Design      : Instruction buffer
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Instruction_Buffer\Instruction buffer\src\instruct_fetch.vhd
-- Generated   : Thu Nov 26 12:48:36 2020
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
--{entity {instruct_fetch} architecture {structural}}

library IEEE;
use IEEE.std_logic_1164.all;

use ieee.numeric_std.all;
library work;
use work.all;


entity instruct_fetch is
	port(
		 Clk : in STD_LOGIC;
		 Rst : in STD_LOGIC;
		 Set : in STD_LOGIC;
		 WriteMode : in STD_LOGIC;
		 PC_new : in STD_LOGIC_VECTOR(5 downto 0);
		 Opcode : in STD_LOGIC_VECTOR(24 downto 0);
		 Instruct : out STD_LOGIC_VECTOR(24 downto 0);
		 PC_value : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end instruct_fetch;

--}} End of automatically maintained section

architecture structural of instruct_fetch is
	signal PC_out : STD_LOGIC_VECTOR(5 downto 0);
begin
	
	PC_value <= PC_out;
	 	u1: entity program_counter port map
		(
		Clk => Clk,
		Rst => Rst,
		Set => Set,
		PC_new => PC_new,
		PC_out => PC_out
		);
		
	u2: entity instruct_buffer port map
		(
		PC => PC_out,
		WriteMode => WriteMode,
		Opcode => Opcode,
		Clk => Clk,
		Instruct => Instruct
		);	

end structural;
