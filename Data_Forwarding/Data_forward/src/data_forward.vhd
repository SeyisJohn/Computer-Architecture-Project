-------------------------------------------------------------------------------
--
-- Title       : data_forward
-- Design      : Data_forward
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Data_Forwarding\Data_forward\src\data_forward.vhd
-- Generated   : Wed Nov 25 22:40:33 2020
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
--{entity {data_forward} architecture {data_forward}}

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_forward is
	 port(
	 	 Out_Value : out STD_LOGIC_VECTOR(127 downto 0);
	 	 WriteMode : out STD_LOGIC_VECTOR(1 downto 0) := "00";
		 In_Value : in STD_LOGIC_VECTOR(127 downto 0);
		 In_reg_num : in STD_LOGIC_VECTOR(4 downto 0);
		 reg1_num : in STD_LOGIC_VECTOR(4 downto 0);
		 reg2_num : in STD_LOGIC_VECTOR(4 downto 0);
		 reg3_num : in STD_LOGIC_VECTOR(4 downto 0)
	     );
end data_forward;

--}} End of automatically maintained section

architecture data_forward of data_forward is
begin

	process(In_reg_num, reg1_num, reg2_num, reg3_num)
	begin
		if (In_reg_num = reg1_num) then
			WriteMode <= "01";
			Out_value <= In_value;
		
		elsif (In_reg_num = reg2_num) then
			WriteMode <= "10";
			Out_value <= In_value;
			
		elsif (In_reg_num = reg3_num) then
			WriteMode <= "11";
			Out_value <= In_value;
			
		else
			WriteMode <= "00";
		end if;
	end process;

end data_forward;
