-------------------------------------------------------------------------------
--
-- Title       : ALU_tb
-- Design      : Multimedia ALU
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\ALU\Multimedia ALU\src\ALU_tb.vhd
-- Generated   : Mon Nov 23 23:45:10 2020
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
--{entity {ALU_tb} architecture {ALU_tb}}

library IEEE;
use IEEE.std_logic_1164.all;

use ieee.numeric_std.all;
library work;
use work.all;

entity ALU_tb is
end ALU_tb;

--}} End of automatically maintained section

architecture ALU_tb of ALU_tb is
	
	-- Stimulus signals
	signal rs1 : SIGNED(127 downto 0);
	signal rs2 : SIGNED(127 downto 0);
	signal rs3 : SIGNED(127 downto 0);
	signal instruct : STD_LOGIC_VECTOR(4 downto 0);
	
	-- Observed signals
	signal rd : SIGNED(127 downto 0);
	
	
	-- Temporary signals
	
begin

	UUT : entity ALU port map (
		rs1 => rs1,
		rs2 => rs2,
		rs3 => rs3,
		instruct => instruct,
		rd => rd
		);
		
		
	-- Testing each instruction in ALU
	

end ALU_tb;
