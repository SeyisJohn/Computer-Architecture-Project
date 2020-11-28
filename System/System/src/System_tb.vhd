-------------------------------------------------------------------------------
--
-- Title       : System_tb
-- Design      : System
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\System\System\src\System_tb.vhd
-- Generated   : Thu Nov 26 22:08:18 2020
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
--{entity {System_tb} architecture {System_tb}}

	library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;


entity System_tb is
end System_tb;

--}} End of automatically maintained section

architecture System_tb of System_tb is

	-- Observed Signals
	signal WriteMode : STD_LOGIC;
	signal Rst : STD_LOGIC;
	signal Set : STD_LOGIC;
	signal Clk : STD_LOGIC := '0';
	signal Opcode : STD_LOGIC_VECTOR(24 downto 0);
	signal PC_new : STD_LOGIC_VECTOR(5 downto 0);
begin
	
	UUT: entity System port map
		(
		Clk => Clk,
		Rst => Rst,
		Set => Set,
		WriteMode => WriteMode,
		PC_new => PC_new,
		Opcode => Opcode
		);
	
	clock:process
	begin 
		wait for 200 ns;
		for i in 0 to 63 loop
			wait for 25 ns;
			Clk <= not Clk;
		end loop;
		wait;
	end process;
	
	
	testing: process
	begin
		
		
		WriteMode <= '1';
		Set <= '1';
		
		PC_new <= "000000";
		Opcode <= "1000000100000100000110000";
		
		wait for 25 ns;
		
		PC_new <= "000001";		
		Opcode <= "1010000100000100000110000";
		
		wait for 25 ns;
		
		PC_new <= "000010";	 
		Opcode <= "1010110000000100000101000";
		
--		wait for 25 ns;
--		
--		PC_new <= "000011";	 
--		Opcode <= "1100000000000000000000000";		
		
		wait for 50 ns;
		
		Set <= '0';
		WriteMode <= '0';
		Rst <= '1';
				
		wait for 50 ns;
		Rst <= '0';
		
	
		
		
		wait;
	end process;
		

end System_tb;
