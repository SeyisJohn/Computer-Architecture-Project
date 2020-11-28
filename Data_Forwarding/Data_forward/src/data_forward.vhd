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
	 	 forward : out STD_LOGIC_VECTOR(1 downto 0);
		 In_Value : in STD_LOGIC_VECTOR(127 downto 0);
		 In_Value_2 : in STD_LOGIC_VECTOR(127 downto 0);
		 In_reg_num : in STD_LOGIC_VECTOR(4 downto 0);
		 In_reg_num_2 : in STD_LOGIC_VECTOR(4 downto 0);
		 reg1_num : in STD_LOGIC_VECTOR(4 downto 0);
		 reg2_num : in STD_LOGIC_VECTOR(4 downto 0);
		 reg3_num : in STD_LOGIC_VECTOR(4 downto 0);
		 valid : in STD_LOGIC;
		 valid_2 : in STD_LOGIC
	     );
end data_forward;

--}} End of automatically maintained section

architecture data_forward of data_forward is
begin

	process(In_reg_num, In_reg_num_2, reg1_num, reg2_num, reg3_num, In_Value, In_Value_2, valid, valid_2)
	begin
		if (In_reg_num = reg1_num and valid = '1') then
			forward <= "01";
			Out_value <= In_value;
		
		elsif (In_reg_num = reg2_num and valid = '1') then
			forward <= "10";
			Out_value <= In_value;
			
		elsif (In_reg_num = reg3_num and valid = '1') then
			forward <= "11";
			Out_value <= In_value;
		
		elsif (In_reg_num_2 = reg1_num and valid_2 = '1') then
			forward <= "01";
			Out_value <= In_value_2;
			
		elsif (In_reg_num_2 = reg2_num and valid_2 = '1') then
			forward <= "10";
			Out_value <= In_value_2;
			
		elsif (In_reg_num_2 = reg3_num and valid_2 = '1') then
			forward <= "11";
			Out_value <= In_value_2;			
		else
			forward <= "00";
		end if;
	end process;

end data_forward;
