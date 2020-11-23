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
begin

	store_instruct: process(Clk, WriteMode)
	begin
		if (WriteMode = '1') then 
			
		end if;
	end process;

end Instruct_Buffer;
