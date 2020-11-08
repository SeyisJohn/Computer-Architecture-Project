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

	 output <= signed_multiply(SIGNED(rs1), SIGNED(rs2));

end ALU;
