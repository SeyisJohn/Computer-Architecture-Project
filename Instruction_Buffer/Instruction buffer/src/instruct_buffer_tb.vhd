-------------------------------------------------------------------------------
--
-- Title       : instruct_buffer_tb
-- Design      : Instruction buffer
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Instruction_Buffer\Instruction buffer\src\instruct_buffer_tb.vhd
-- Generated   : Wed Nov 25 17:25:31 2020
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
--{entity {instruct_buffer_tb} architecture {instruct_buffer_tb}}

library IEEE;
use IEEE.std_logic_1164.all;

use ieee.numeric_std.all;
library work;
use work.all;

entity instruct_buffer_tb is
end instruct_buffer_tb;

--}} End of automatically maintained section

architecture instruct_buffer_tb of instruct_buffer_tb is

	--Sitmulated signals
	signal PC : STD_LOGIC_VECTOR(5 downto 0);
	signal WriteMode : STD_LOGIC;
	signal Opcode : STD_LOGIC_VECTOR(24 downto 0);
	signal Clk : STD_LOGIC := '0';
	
	-- Observed Signals
	Signal Instruct : STD_LOGIC_VECTOR(24 downto 0);
	


begin

	UUT: entity Instruct_Buffer port map (
		PC => PC,
		WriteMode => WriteMode,
		Opcode => Opcode,
		Clk => Clk,
		Instruct => Instruct
		);
		
	counter: process
	begin
		for i in 0 to 63 loop
			PC <= STD_LOGIC_VECTOR(to_unsigned(i, 6));
			wait for 100 ns;
		end loop;
		
		for j in 0 to 63 loop 
			Clk <= not Clk;
			PC <= STD_LOGIC_VECTOR(to_unsigned(j, 6));
			wait for 100 ns;
		end loop;
		
		wait;
	end process;
	
	testing: process
	begin
	
		WriteMode <= '1';
		
		for k in 0 to 63 loop
			Opcode <= STD_LOGIC_VECTOR(to_unsigned(k, 25));
			wait for 100 ns;
		end loop;
		
		WriteMode <= '0';  
		wait;
	end process;

end instruct_buffer_tb;
