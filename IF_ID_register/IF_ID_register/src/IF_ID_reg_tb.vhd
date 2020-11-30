	  --
-- Title       : IF_ID_reg_tb
-- Design      : IF_ID_reg_tb
-- Author      : Kevin Mathew
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\IF_ID_reg_tb\IF_ID_reg_tb\src\IF_ID_reg_tb.vhd
-- Generated   : Thu Oct 29 22:43:35 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;  

library work;
use work.all;

entity IF_ID_reg_tb is end IF_ID_reg_tb;
	
architecture IF_ID_reg_tb of IF_ID_reg_tb is 
-- Stimulated Signals
		signal Clk  : STD_LOGIC := '0';
		signal Input : STD_LOGIC_VECTOR(24 downto 0);

-- Output Signals
		signal Output : STD_LOGIC_VECTOR(24 downto 0); 

begin 
	UUT: entity IF_ID_reg port map(
		Clk => Clk,
		Input => Input,
		Output => Output
		);
	
	test : process
	begin	
		wait for 200ns;
		input <= "1100000001010110111011110";
		for i in 0 to 64 loop
			Clk <= not Clk;
			wait for 500ns;
		end loop;
		wait;
	end process;
	
end IF_ID_reg_tb;