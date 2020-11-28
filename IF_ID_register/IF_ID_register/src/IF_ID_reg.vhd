-------------------------------------------------------------------------------
--
-- Title       : IF_ID_reg
-- Design      : IF_ID_register
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\Users\Seyi Olajuyi\Documents\my_designs\IF_ID_register\IF_ID_register\src\IF_ID_reg.vhd
-- Generated   : Wed Nov 25 19:10:28 2020
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
--{entity {IF_ID_reg} architecture {IF_ID_reg}}

library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity IF_ID_reg is
	port(
		 Clk : in STD_LOGIC;
		 Instruct_in : in STD_LOGIC_VECTOR(24 downto 0);
		 Instruct_out : out STD_LOGIC_VECTOR(24 downto 0)
	     );
end IF_ID_reg;

--}} End of automatically maintained section

architecture IF_ID_reg of IF_ID_reg is
	signal temporary_holder : STD_LOGIC_VECTOR(24 downto 0);

begin

	write: process(Clk)
	begin
		if(rising_edge(Clk)) then
			temporary_holder <= Instruct_in;	
		end if;
	end process;
	
	read: process(Clk) 
	begin
		if (rising_edge(Clk)) then
			Instruct_out <= temporary_holder;
		else
			null;
		end if;
	end process;

end IF_ID_reg;
