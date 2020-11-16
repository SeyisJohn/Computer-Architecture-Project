-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : Multimedia ALU
-- Author      : Aldec, Inc.
-- Company     : Aldec, Inc.
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\ALU\Multimedia ALU\src\ALU.vhd
-- Generated   : Sat Nov  7 13:39:41 2020
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
--{entity {ALU} architecture {ALU}}

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
	 port(
		 rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3 : in STD_LOGIC_VECTOR(127 downto 0);
		 instruct : in STD_LOGIC_VECTOR(4 downto 0);
		 output : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU of ALU is
	
	function signed_int_multiply_add (
	multiplicand, multiplicator: SIGNED(15 downto 0);
	add_value : SIGNED(31 downto 0)) 
		return STD_LOGIC_VECTOR is 
		variable value, product : SIGNED(31 downto 0) := (others => '0');
	begin
		
		product := multiplicand	* multiplicator; 
		
		value := product + add_value;
		
		if (product > 0 and add_value > 0 and value < product) then
			value := X"7FFF_FFFF";
		elsif (product < 0 and add_value < 0 and value > product) then
			value := X"8000_0000";
		else
			null;
		end if;	
		
		return STD_LOGIC_VECTOR(value);	
	
	end signed_int_multiply_add;	
	
	
	function signed_long_multiply_add (
	multiplicand, multiplicator: SIGNED(31 downto 0);
	add_value : SIGNED(63 downto 0)) 
		return STD_LOGIC_VECTOR is 
		variable value, product : SIGNED(63 downto 0) := (others => '0');
	begin
		
		product := multiplicand	* multiplicator; 
		
		value := product + add_value;
		
		if (product > 0 and add_value > 0 and value < product) then
			value := X"7FFF_FFFF_FFFF_FFFF";
		elsif (product < 0 and add_value < 0 and value > product) then
			value := X"8000_0000_0000_0000";
		else
			null;
		end if;	
		
		return STD_LOGIC_VECTOR(value);	
	
	end signed_long_multiply_add;
		
		

begin

--	process (instruct, rs1, rs2, rs3)
--	begin
--		
--		if (instruct = X"00") then
--			-- Signed Integer Multiply-Add Low with Saturation
--		elsif (instruct = X"01") then
--			-- Signed Integer Multiply-Add High with Saturation
--		elsif (instruct = X"02") then
--			-- Signed Integer Multiply-Subtract Low with Saturation
--		elsif (instruct = X"03") then
--			-- Signed Integer Multiply-Subtract High with Saturation
--		elsif (instruct = X"04") then
--			-- Signed Long Integer Multiply-Add Low with Saturation
--		elsif (instruct = X"05") then
--			-- Signed Long Integer Multiply-Add High with Saturation
--		elsif (instruct = X"06") then
--			-- Signed Long Integer Multiply-Subtract Low with Saturation
--		elsif (instruct = X"07") then 
--			-- Signed Long Integer Multiply-Subtract High with Saturation
--		elsif (instruct = X"08") then 
--			-- add word unsigned
--		elsif (instruct = X"09") then
--			-- absolute difference of bytes
--		elsif (instruct = X"0A") then
--			-- add halfword unsigned
--		elsif (instruct = X"0B") then
--			-- add halfword saturated 
--		elsif (instruct = X"0C") then
--			output <= rs1 and rs2;
--		elsif (instruct = X"0D") then
--			-- broadcast word 
--		elsif (instruct = X"0E") then
--			-- max signed word
--		elsif (instruct = X"10") then
--			-- min signed word
--		elsif (instruct = X"11") then
--			-- multiply low unsigned
--		elsif (instruct = X"12") then
--			-- multiply low by constant unsigned
--		elsif (instruct = X"13") then
--			output <= rs1 or rs2;
--		elsif (instruct = X"14") then
--			-- count ones in words
--		elsif (instruct = X"15") then
--			-- rotate bits in word
--		elsif (instruct = X"16") then
--			-- subtract from halfword saturated
--		elsif (instruct = X"17") then
--			-- subtract from word unsigned			
--		else
--			--NOP
--		end if;
--
--	end process;

	output(31 downto 0) <= signed_int_multiply(SIGNED(rs1(15 downto 0)), SIGNED(rs2(15 downto 0)));
	
end ALU;
