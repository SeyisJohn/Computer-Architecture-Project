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
use IEEE.numeric_std.all;

entity Program_Counter is
	 port(
		 Clk : in STD_LOGIC;
		 Rst : in STD_LOGIC;
		 Set : in STD_LOGIC;
		 PC_new : in STD_LOGIC_VECTOR(5 downto 0);
		 PC_out : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end Program_Counter;

--}} End of automatically maintained section

architecture Program_Counter of Program_Counter is
	
	signal current_pc : STD_LOGIC_VECTOR(5 downto 0) := "000000";
begin

	process(Clk, Rst, Set, PC_new)
	begin
		-- This should be an implied D-Flip Flop that stores the current_pc counter
		if (Rst = '1') then
			current_pc <= "000000";
		elsif (Set = '1') then
			current_pc <= PC_new;
		elsif (rising_edge(clk)) then
			current_pc <= STD_LOGIC_VECTOR(UNSIGNED(current_pc) + 1);
		end if;
		
	end process;
	
	-- This sends out the current program counter value
	PC_out <= current_pc;

end Program_Counter;
