-------------------------------------------------------------------------------
--
-- Title       : register_file
-- Design      : Register_File
-- Author      : Kevin Mathew
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\RegisterFile\Register_File\src\Register_File.vhd
-- Generated   : Thu Oct 29 22:43:35 2020
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
--{entity {register_file} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity register_file is
	 port(
		 outA : in STD_LOGIC_VECTOR(127 downto 0);
		 outB : out STD_LOGIC_VECTOR(127 downto 0);
		 input : in STD_LOGIC_VECTOR(127 downto 0);
		 writeEnable : in std_logic; 
	     );
end register_file;

--}} End of automatically maintained section

architecture behavioral of register_file is
begin
	  type registerFile is array(0 to 31) of STD_LOGIC_VECTOR(127 downto 0); 
	 -- enter your statements here --

end behavioral;
