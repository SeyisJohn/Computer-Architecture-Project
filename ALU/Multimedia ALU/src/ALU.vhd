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
		 rd : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU of ALU is
	
	function signed_int_multiply_add ( -- Test this
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
	
	
	function signed_long_multiply_add ( -- Test this
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
	
	
	function MAX(LEFT, RIGHT: SIGNED(31 downto 0)) return SIGNED is
	begin
		if LEFT > RIGHT then return LEFT;
		
		else return RIGHT;
		end if;
	end;
	
	
	function MIN(LEFT, RIGHT: SIGNED(31 downto 0)) return SIGNED is
	begin
		if LEFT > RIGHT then return LEFT;
		
		else return RIGHT;
		end if;
	end;
	
	
	function count_ones_words (
	input : STD_LOGIC_VECTOR(31 downto 0))
		return STD_LOGIC_VECTOR is 
		variable count : UNSIGNED(31 downto 0) := (others => '0');
	begin
		for i in 0 to 31 loop
			if(input(i) = '1') then
				count := count + 1;
			else
				null;
			end if;
		end loop;
		
		return STD_LOGIC_VECTOR(count);
		
	end count_ones_words;
	
	function add_word_saturated (
	input1, input2 : SIGNED(15 downto 0))
		return STD_LOGIC_VECTOR is
		variable result : SIGNED(15 downto 0);
	begin
		
		result := input1 + input2;
		-- Fix it  
		
		return STD_LOGIC_VECTOR(result);
	end add_word_saturated;	

begin

	process (instruct, rs1, rs2, rs3)
	begin
		
		-- Signed Integer Multiply-Add Low with Saturation
		if (instruct = "00000") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE  
									SIGNED(rs3(15 downto 0)), 
									SIGNED(rs2(15 downto 0)), 
									SIGNED(rs1(31 downto 0))
									);
									
		-- Signed Integer Multiply-Add High with Saturation
		elsif (instruct = "00001") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(31 downto 16)), 
									SIGNED(rs2(31 downto 16)), 
									SIGNED(rs1(31 downto 0))
									);
									
		-- Signed Integer Multiply-Subtract Low with Saturation
		elsif (instruct = "00010") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE  
									SIGNED(rs3(15 downto 0)), 
									SIGNED(rs2(15 downto 0)), 
									(-SIGNED(rs1(31 downto 0))) --Check if this works
									);
									
		-- Signed Integer Multiply-Subtract High with Saturation
		elsif (instruct = "00011") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(31 downto 16)), 
									SIGNED(rs2(31 downto 16)), 
									(-SIGNED(rs1(31 downto 0))) -- Check if this works
									);
									
		-- Signed Long Integer Multiply-Add Low with Saturation
		elsif (instruct = "00100") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(31 downto 0)),
									SIGNED(rs2(31 downto 0)),
									SIGNED(rs1(63 downto 0))
									);
									
		-- Signed Long Integer Multiply-Add High with Saturation
		elsif (instruct = "00101") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(63 downto 32)),
									SIGNED(rs2(63 downto 32)),
									SIGNED(rs1(63 downto 0))
									);
									
		-- Signed Long Integer Multiply-Subtract Low with Saturation
		elsif (instruct = "00110") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(31 downto 0)),
									SIGNED(rs2(31 downto 0)),
									(-SIGNED(rs1(63 downto 0)))	-- Check if this works
									);
									
		-- Signed Long Integer Multiply-Subtract High with Saturation
		elsif (instruct = "00111") then 
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									SIGNED(rs3(63 downto 32)),
									SIGNED(rs2(63 downto 32)),
									(-SIGNED(rs1(63 downto 0)))
									);
									
		-- AU: add word unsigned
		elsif (instruct = "01000") then 		
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(UNSIGNED(rs1(31 downto 0)) + UNSIGNED(rs2(31 downto 0)));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1(63 downto 32)) + UNSIGNED(rs2(63 downto 32)));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1(95 downto 64)) + UNSIGNED(rs2(95 downto 64)));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(127 downto 96)) + UNSIGNED(rs2(127 downto 96)));	
			
		-- ABSDB: absolute difference of bytes	
		elsif (instruct = "01001") then
			for j in 0 to 15 loop
				
				rd((7+(8 * j)) downto (j*8)) <= STD_LOGIC_VECTOR(abs(SIGNED(rs2((7+(8 * j)) downto (j*8))) - SIGNED(rs1((7+(8 * j)) downto (j*8)))));
				
			end loop;
			-- rd(7 downto 0)   <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(7 downto 0)) + SIGNED(rs2(7 downto 0))));
			-- rd(15 downto 8)  <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(15 downto 8)) + SIGNED(rs2(15 downto 8))));
			-- rd(23 downto 16)  <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(23 downto 16)) + SIGNED(rs2(23 downto 16))));
			-- rd(31 downto 24) <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(31 downto 24)) + SIGNED(rs2(31 downto 24))));
			
			-- rd(39 downto 32)   <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(39 downto 32)) + SIGNED(rs2(39 downto 32))));
			-- rd(47 downto 40)  <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(47 downto 40)) + SIGNED(rs2(47 downto 40))));
			-- rd(55 downto 48)  <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(55 downto 48)) + SIGNED(rs2(55 downto 48))));
			-- rd(63 downto 56) <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(63 downto 56)) + SIGNED(rs2(63 downto 56))));	 
			
			-- rd(71 downto 64)   <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(71 downto 64)) + SIGNED(rs2(71 downto 64))));
			-- rd(79 downto 72)  <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(79 downto 72)) + SIGNED(rs2(79 downto 72))));
			-- rd(87 downto 80)  <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(87 downto 80)) + SIGNED(rs2(87 downto 80))));
			-- rd(95 downto 88) <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(95 downto 88)) + SIGNED(rs2(95 downto 88))));	
			
			-- rd(103 downto 96)   <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(103 downto 96)) + SIGNED(rs2(103 downto 96))));
			-- rd(111 downto 104)  <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(111 downto 104)) + SIGNED(rs2(111 downto 104))));
			-- rd(119 downto 112)  <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(119 downto 112)) + SIGNED(rs2(119 downto 112))));
			-- rd(127 downto 120) <= STD_LOGIC_VECTOR(abs(-SIGNED(rs1(127 downto 120)) + SIGNED(rs2(127 downto 120))));
			
		-- AHU: add halfword unsigned	
		elsif (instruct = "01010") then
			for k in 0 to 7 loop
				
				rd((15+(16 * k)) downto (16*k)) <= STD_LOGIC_VECTOR(UNSIGNED(rs1((15+(16 * k)) downto (16*k))) + UNSIGNED(rs2((15+(16 * k)) downto (16*k))));
				
			end loop;
		
			-- rd(15 downto 0)   <= STD_LOGIC_VECTOR(UNSIGNED(rs1(15 downto 0)) + UNSIGNED(rs2(15 downto 0)));
			-- rd(31 downto 16)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1(31 downto 16)) + UNSIGNED(rs2(31 downto 16)));
			-- rd(47 downto 32)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1(47 downto 32)) + UNSIGNED(rs2(47 downto 32)));
			-- rd(63 downto 48) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(63 downto 48)) + UNSIGNED(rs2(63 downto 48)));	

			-- rd(79 downto 64)   <= STD_LOGIC_VECTOR(UNSIGNED(rs1(79 downto 64)) + UNSIGNED(rs2(79 downto 64)));
			-- rd(95 downto 80)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1(95 downto 80)) + UNSIGNED(rs2(95 downto 80)));
			-- rd(111 downto 96)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1(111 downto 96)) + UNSIGNED(rs2(111 downto 96)));
			-- rd(127 downto 112) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(127 downto 112)) + UNSIGNED(rs2(127 downto 112)));	
			
		elsif (instruct = "01011") then
		
			-- add halfword saturated 
		
		-- AND: bitwise logical and 
		elsif (instruct = "01100") then
			rd <= rs1 and rs2;
		
		-- BCW: broadcast word
		elsif (instruct = "01101") then
			rd(31 downto 0)   <= rs1(31 downto 0);
			rd(63 downto 32)  <= rs1(31 downto 0);
			rd(95 downto 64)  <= rs1(31 downto 0);
			rd(127 downto 96) <= rs1(31 downto 0);
		
		-- MAXWS: max signed word
		elsif (instruct = "01110") then
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(MAX(SIGNED(rs1(31 downto 0)), SIGNED(rs2(31 downto 0))));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(MAX(SIGNED(rs1(63 downto 32)), SIGNED(rs2(63 downto 32))));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(MAX(SIGNED(rs1(95 downto 64)), SIGNED(rs2(95 downto 64))));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(MAX(SIGNED(rs1(127 downto 96)), SIGNED(rs2(127 downto 96))));	
		
		-- MINWS: min signed word
		elsif (instruct = "01111") then
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(MIN(SIGNED(rs1(31 downto 0)), SIGNED(rs2(31 downto 0))));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(MIN(SIGNED(rs1(63 downto 32)), SIGNED(rs2(63 downto 32))));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(MIN(SIGNED(rs1(95 downto 64)), SIGNED(rs2(95 downto 64))));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(MIN(SIGNED(rs1(127 downto 96)), SIGNED(rs2(127 downto 96))));		
		
		-- MLHU: multiply low unsigned
		elsif (instruct = "10000") then
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(UNSIGNED(rs1(15 downto 0)) * UNSIGNED(rs2(15 downto 0)));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1(47 downto 32)) * UNSIGNED(rs2(47 downto 32)));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1(79 downto 64)) * UNSIGNED(rs2(79 downto 64)));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(111 downto 96)) * UNSIGNED(rs2(111 downto 96)));	
		
		-- multiply low by constant unsigned
		elsif (instruct = "10001") then
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(SIGNED(rs1(15 downto 0)) * SIGNED(rs2(15 downto 0)));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(SIGNED(rs1(47 downto 32)) * SIGNED(rs2(15 downto 0)));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(SIGNED(rs1(79 downto 64)) * SIGNED(rs2(15 downto 0)));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(SIGNED(rs1(111 downto 96)) * SIGNED(rs2(15 downto 0)));

		-- OR: bitwise logical or
		elsif (instruct = "10010") then
			rd <= rs1 or rs2;
		
		-- PCNTW: count ones in words
		elsif (instruct = "10011") then
			rd(31 downto 0)   <= count_ones_words(rs1(31 downto 0));
			rd(63 downto 32)  <= count_ones_words(rs1(63 downto 32));
			rd(95 downto 64)  <= count_ones_words(rs1(95 downto 64));
			rd(127 downto 96) <= count_ones_words(rs1(127 downto 96));
		
		-- ROTW: rotate bits in word
		elsif (instruct = "10100") then			--Fix this
--			rd(31 downto 0) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1(31 downto 0)), UNSIGNED(rs2(4 downto 0))));
--			rd(63 downto 32) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1(63 downto 32)), UNSIGNED(rs2(4 downto 0))));
--			rd(95 downto 64) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1(95 downto 64)), UNSIGNED(rs2(4 downto 0))));
--			rd(127 downto 96) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1(127 downto 96)), UNSIGNED(rs2(4 downto 0))));
		
		
		-- SFHS: subtract from halfword saturated
		elsif (instruct = "10101") then
		
			-- subtract from halfword saturated
		
		
		-- SFW: subtract from word unsigned:
		elsif (instruct = "10110") then
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(UNSIGNED(rs2(31 downto 0)) - UNSIGNED(rs1(31 downto 0)));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(UNSIGNED(rs2(63 downto 32)) - UNSIGNED(rs1(63 downto 32)));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(UNSIGNED(rs2(95 downto 64)) - UNSIGNED(rs1(95 downto 64)));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs2(127 downto 96)) - UNSIGNED(rs1(127 downto 96)));		
		
		else
			null;
		
		end if;

	end process;
	
end ALU;
