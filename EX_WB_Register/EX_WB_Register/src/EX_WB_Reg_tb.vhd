	  --
-- Title       : EX_WB_Reg_tb
-- Design      : EX_WB_Reg_tb
-- Author      : Kevin Mathew
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\EX_WB_Reg_tb\EX_WB_Reg_tb\src\EX_WB_Reg_tb.vhd
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

entity EX_WB_Reg_tb is end EX_WB_Reg_tb;
	
architecture EX_WB_Reg_tb of EX_WB_Reg_tb is 
-- Stimulated Signals
Signal Clk : STD_LOGIC := '0';
Signal Input : STD_LOGIC_VECTOR(127 downto 0);
Signal Reg_Num_in : STD_LOGIC_VECTOR(4 downto 0);	
Signal Valid : STD_LOGIC;
-- Output Signals		 
Signal Output : STD_LOGIC_VECTOR(127 downto 0);
Signal Reg_Num_out : STD_LOGIC_VECTOR(4 downto 0);
Signal Valid_out : STD_LOGIC;

begin 
	UUT: entity EX_WB_Reg port map(		
		Clk	=> Clk,		 
		Input => Input,
		Reg_Num_in => Reg_Num_in ,
		Valid => Valid ,
		Output => Output ,
		Reg_Num_out => Reg_Num_out,
		Valid_out => Valid_out
		);
		
test : process
begin 
	wait for 200ns; 	
		 Input <= x"77777777777777777777777777777777";
		 Reg_Num_in <= "10011";
		 Valid <= '1';
		 for i in 0 to 64 loop
			Clk <= not Clk;
			wait for 200ns;
		end loop;
		wait;
	end process;
	
end EX_WB_Reg_tb;
	
	
	
	
	
	