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

	process (instruct, rs1, rs2, rs3)
	begin
		
		if (instruct = "00000") then
			output(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE  
									SIGNED(rs3(15 downto 0)), 
									SIGNED(rs2(15 downto 0)), 
									SIGNED(rs1(31 downto 0))
									);
		elsif (instruct = "00001") then
			output(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(31 downto 16)), 
									SIGNED(rs2(31 downto 16)), 
									SIGNED(rs1(31 downto 0))
									);
		elsif (instruct = "00010") then
			output(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE  
									SIGNED(rs3(15 downto 0)), 
									SIGNED(rs2(15 downto 0)), 
									(-SIGNED(rs1(31 downto 0))) --Check if this works
									);
		elsif (instruct = "00011") then
			output(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(31 downto 16)), 
									SIGNED(rs2(31 downto 16)), 
									(-SIGNED(rs1(31 downto 0))) -- Check if this works
									);
		elsif (instruct = "00100") then
			output(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(31 downto 0)),
									SIGNED(rs2(31 downto 0)),
									SIGNED(rs1(63 downto 0))
									);
		elsif (instruct = "00101") then
			output(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(63 downto 32)),
									SIGNED(rs2(63 downto 32)),
									SIGNED(rs1(63 downto 0))
									);
		elsif (instruct = "00110") then
			output(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(31 downto 0)),
									SIGNED(rs2(31 downto 0)),
									(-SIGNED(rs1(63 downto 0)))	-- Check if this works
									);
		elsif (instruct = "00111") then 
			output(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(63 downto 32)),
									SIGNED(rs2(63 downto 32)),
									(-SIGNED(rs1(63 downto 0)))
									);
		elsif (instruct = "01000") then 
			-- add word unsigned
		elsif (instruct = "01001") then
			-- absolute difference of bytes
		elsif (instruct = "01010") then
			-- add halfword unsigned
		elsif (instruct = "01011") then
			-- add halfword saturated 
		elsif (instruct = "01100") then
			output <= rs1 and rs2;
		elsif (instruct = "01101") then
			-- broadcast word 
		elsif (instruct = "01110") then
			-- max signed word
		elsif (instruct = "01111") then
			-- min signed word
		elsif (instruct = "10000") then
			-- multiply low unsigned
		elsif (instruct = "10001") then
			-- multiply low by constant unsigned
		elsif (instruct = "10010") then
			output <= rs1 or rs2;
		elsif (instruct = "10011") then
			-- count ones in words
		elsif (instruct = "10100") then
			-- rotate bits in word
		elsif (instruct = "10101") then
			-- subtract from halfword saturated
		elsif (instruct = "10110") then
			-- subtract from word unsigned			
		else
			null;
		end if;

	end process;
	
end ALU;
