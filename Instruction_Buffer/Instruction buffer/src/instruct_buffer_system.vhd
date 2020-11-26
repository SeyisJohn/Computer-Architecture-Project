-------------------------------------------------------------------------------
--
-- Title       : instruct_buffer_system
-- Design      : Instruction buffer
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Instruction_Buffer\Instruction buffer\src\instruct_buffer_system.vhd
-- Generated   : Wed Nov 25 18:26:25 2020
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
--{entity {instruct_buffer_system} architecture {instruct_buffer_system}}

library IEEE;
use IEEE.std_logic_1164.all;

use ieee.numeric_std.all;
library work;
use work.all;


entity instruct_buffer_system is
	 port(
		 Clk : in STD_LOGIC;
		 Rst : in STD_LOGIC;
		 Set : in STD_LOGIC;
		 WriteMode : in STD_LOGIC;
		 PC_new : in STD_LOGIC_VECTOR(5 downto 0);
		 Opcode : in STD_LOGIC_VECTOR(24 downto 0);
		 Instruct : out STD_LOGIC_VECTOR(24 downto 0)
	     );
end instruct_buffer_system;

--}} End of automatically maintained section

architecture instruct_buffer_system of instruct_buffer_system is

	signal PC_out : STD_LOGIC_VECTOR(5 downto 0);

begin

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
		

end instruct_buffer_system;
