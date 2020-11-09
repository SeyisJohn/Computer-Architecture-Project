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
--		 rs1 : in STD_LOGIC_VECTOR(127 downto 0);
--		 rs2 : in STD_LOGIC_VECTOR(127 downto 0);
--		 rs3 : in STD_LOGIC_VECTOR(127 downto 0);
--		 instruct : in STD_LOGIC_VECTOR(4 downto 0);
--		 output : out STD_LOGIC_VECTOR(127 downto 0)
		 rs1 : in STD_LOGIC_VECTOR(15 downto 0);
		 rs2 : in STD_LOGIC_VECTOR(15 downto 0);
		 rs3 : in STD_LOGIC_VECTOR(15 downto 0);
		 instruct : in STD_LOGIC_VECTOR(4 downto 0);
		 output : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU of ALU is
	
-- This multiply is performed with saturated rounding
-- This means that instead of over/underflow wrapping, the max/min values are used.
-- This is booth's algorithm
	function signed_int_multiply (
		multiplicand, multiplicator: SIGNED(15 downto 0)) 
		return STD_LOGIC_VECTOR is 
		variable neg_multiplicand : SIGNED(15 downto 0); 
		variable c_bits : STD_LOGIC_VECTOR(1 downto 0);
		variable product : SIGNED(31 downto 0) := (others => '0');
	begin
		
		-- Start with point being zero
		product(15 downto 0) := SIGNED(multiplicator);
		neg_multiplicand := (not(multiplicand) + '1');
		c_bits(0) := '0';
		c_bits(1) := product(1);
		
		
		if (c_bits = "10") then
			product(31 downto 16) := product(31 downto 16) + neg_multiplicand;
			product := shift_right(signed(product), 1);
			c_bits(0) := c_bits(1);
			c_bits(1) := product(0);
		elsif (c_bits = "01") then
			product(31 downto 16) := product(31 downto 16) + multiplicand;
			product := shift_right(signed(product), 1);
			c_bits(0) := c_bits(1);
			c_bits(1) := product(0);
		else
			product := shift_right(signed(product), 1);
			c_bits(0) := c_bits(1);
			c_bits(1) := product(0);
		end if;
		
		
		for i in 14 downto 0 loop
			if (c_bits = "10") then
				product(31 downto 16) := product(31 downto 16) + neg_multiplicand;
				product := shift_right(signed(product), 1);
				c_bits(0) := c_bits(1);
				c_bits(1) := product(0);
			elsif (c_bits = "01") then
				product(31 downto 16) := product(31 downto 16) + multiplicand;
				product := shift_right(signed(product), 1);
				c_bits(0) := c_bits(1);
				c_bits(1) := product(0);
			else
				product := shift_right(signed(product), 1);
				c_bits(0) := c_bits(1);
				c_bits(1) := product(0);
			end if;
		end loop; 
		
		return STD_LOGIC_VECTOR(product);	
	
	end signed_int_multiply;
		
		

begin

	process (instruct, rs1, rs2, rs3)
	begin
		
		if (instruct = X"00") then
			-- Signed Integer Multiply-Add Low with Saturation
		elsif (instruct = X"01") then
			-- Signed Integer Multiply-Add High with Saturation
		elsif (instruct = X"02") then
			-- Signed Integer Multiply-Subtract Low with Saturation
		elsif (instruct = X"03") then
			-- Signed Integer Multiply-Subtract High with Saturation
		elsif (instruct = X"04") then
			-- Signed Long Integer Multiply-Add Low with Saturation
		elsif (instruct = X"05") then
			-- Signed Long Integer Multiply-Add High with Saturation
		elsif (instruct = X"06") then
			-- Signed Long Integer Multiply-Subtract Low with Saturation
		elsif (instruct = X"07") then 
			-- Signed Long Integer Multiply-Subtract High with Saturation
		elsif (instruct = X"08") then 
			-- add word unsigned
		elsif (instruct = X"09") then
			-- absolute difference of bytes
		elsif (instruct = X"0A") then
			-- add halfword unsigned
		elsif (instruct = X"0B") then
			-- add halfword saturated 
		elsif (instruct = X"0C") then
			output <= rs1 and rs2;
		elsif (instruct = X"0D") then
			-- broadcast word 
		elsif (instruct = X"0E") then
			-- max signed word
		elsif (instruct = X"10") then
			-- min signed word
		elsif (instruct = X"11") then
			-- multiply low unsigned
		elsif (instruct = X"12") then
			-- multiply low by constant unsigned
		elsif (instruct = X"13") then
			output <= rs1 or rs2;
		elsif (instruct = X"14") then
			-- count ones in words
		elsif (instruct = X"15") then
			-- rotate bits in word
		elsif (instruct = X"16") then
			-- subtract from halfword saturated
		elsif (instruct = X"17") then
			-- subtract from word unsigned			
		else
			--NOP
		end if;
			
	output <= signed_int_multiply(SIGNED(rs1), SIGNED(rs2));

end ALU;
