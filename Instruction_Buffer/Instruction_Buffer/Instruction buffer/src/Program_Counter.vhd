-------------------------------------------------------------------------------
--
-- Title       : Program_Counter
-- Design      : Instruction buffer
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Instruction_Buffer\Instruction_Buffer\Instruction buffer\src\Program_Counter.vhd
-- Generated   : Sun Nov 22 19:58:10 2020
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
--{entity {Program_Counter} architecture {Program_Counter}}

library IEEE;
use IEEE.std_logic_1164.all;

entity Program_Counter is
	 port(
		 Rst : in STD_LOGIC;
		 PC_new : in STD_LOGIC_VECTOR(5 downto 0);
		 PC_out : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end Program_Counter;

--}} End of automatically maintained section

architecture Program_Counter of Program_Counter is
begin

	 -- enter your statements here --

end Program_Counter;
