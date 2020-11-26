-------------------------------------------------------------------------------
--
-- Title       : EX_WB_Reg
-- Design      : EX_WB_Register
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\EX_WB_Register\EX_WB_Register\src\EX_WB_Reg.vhd
-- Generated   : Wed Nov 25 19:39:04 2020
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
--{entity {EX_WB_Reg} architecture {EX_WB_Reg}}

library IEEE;
use IEEE.std_logic_1164.all;

entity EX_WB_Reg is
	 port(
		 Clk : in STD_LOGIC;
		 Input : in STD_LOGIC_VECTOR(127 downto 0);
		 Reg_Num_in : in STD_LOGIC_VECTOR(4 downto 0);
		 Output : out STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
		 Reg_Num_out : out STD_LOGIC_VECTOR(4 downto 0)	:= (others => '0')
	     );
end EX_WB_Reg;

--}} End of automatically maintained section

architecture EX_WB_Reg of EX_WB_Reg is		

signal reg_holder : STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
signal reg_num_holder : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

begin

	read: process(Clk)
	begin
		if(rising_edge(Clk)) then
			reg_holder <= Input;
			reg_num_holder <= Reg_Num_in;
		end if;
	end process;
	
	write: process(Clk)
	begin
		if (rising_edge(Clk)) then
			Output <= reg_holder;
			Reg_Num_out <= reg_num_holder;
		else
			null;
		end if;
	end process;
	
end EX_WB_Reg;
