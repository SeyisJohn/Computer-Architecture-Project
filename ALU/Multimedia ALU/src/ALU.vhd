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
		 rs1 : in SIGNED(127 downto 0);
		 rs2 : in SIGNED(127 downto 0);
		 rs3 : in SIGNED(127 downto 0);
		 instruct : in STD_LOGIC_VECTOR(4 downto 0);
		 rd : out SIGNED(127 downto 0) := (others => '0');
		 valid : out STD_LOGIC := '0'
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU of ALU is
	
	function signed_int_multiply_add ( -- Test this
	multiplicand, multiplicator: SIGNED(15 downto 0);
	add_value : SIGNED(31 downto 0)) 
		return SIGNED is 
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
		
		return value;	
	
	end signed_int_multiply_add;	
	
	
	function signed_long_multiply_add ( -- Test this
	multiplicand, multiplicator: SIGNED(31 downto 0);
	add_value : SIGNED(63 downto 0)) 
		return SIGNED is 
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
		
		return value;	
	
	end signed_long_multiply_add;
	
	
	function MAX(LEFT, RIGHT: SIGNED(31 downto 0)) return SIGNED is
	begin
		if LEFT > RIGHT then return LEFT;
		
		else return RIGHT;
		end if;
	end;
	
	
	function MIN(LEFT, RIGHT: SIGNED(31 downto 0)) return SIGNED is
	begin
		if LEFT < RIGHT then return LEFT;
		
		else return RIGHT;
		end if;
	end;
	
	
	function count_ones_words (
	input : SIGNED(31 downto 0))
		return SIGNED is 
		variable count : SIGNED(31 downto 0) := (others => '0');
	begin
		for i in 0 to 31 loop
			if(input(i) = '1') then
				count := count + 1;
			else
				null;
			end if;
		end loop;
		
		return count;
		
	end count_ones_words;
	
	
	function add_word_saturated (
	input1, input2 : SIGNED(15 downto 0))
		return SIGNED is
		variable result : SIGNED(15 downto 0);
	begin
		
		result := input1 + input2;
		
		if (input1 > 0 and input2 > 0 and (result < input1 or result < input2)) then
			result := X"7FFF";
		elsif (input1 < 0 and input2 < 0 and (result > input1 or result > input2)) then
			result := X"8000";
		else
			null;
		end if;			
		
		return result;
	end add_word_saturated;	

begin

	process (instruct, rs1, rs2, rs3)
	begin
		
		-- Signed Integer Multiply-Add Low with Saturation
		if (instruct = "00000") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE  
									rs3(15 downto 0), 
									rs2(15 downto 0), 
									rs1(31 downto 0)
									);
			valid <= '1';				
									
									
		-- Signed Integer Multiply-Add High with Saturation
		elsif (instruct = "00001") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE
									rs3(31 downto 16), 
									rs2(31 downto 16), 
									rs1(31 downto 0)
									);
			valid <= '1';						
									
		-- Signed Integer Multiply-Subtract Low with Saturation
		elsif (instruct = "00010") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE  
									rs3(15 downto 0), 
									rs2(15 downto 0), 
									(-rs1(31 downto 0)) --Check if this works
									);
		    valid <= '1';							
									
		-- Signed Integer Multiply-Subtract High with Saturation
		elsif (instruct = "00011") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE
									rs3(31 downto 16), 
									rs2(31 downto 16), 
									(-rs1(31 downto 0)) -- Check if this works
									);
			valid <= '1';						
									
		-- Signed Long Integer Multiply-Add Low with Saturation
		elsif (instruct = "00100") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									rs3(31 downto 0),
									rs2(31 downto 0),
									rs1(63 downto 0)
									);
			valid <= '1';						
									
		-- Signed Long Integer Multiply-Add High with Saturation
		elsif (instruct = "00101") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									rs3(63 downto 32),
									rs2(63 downto 32),
									rs1(63 downto 0)
									);
			valid <= '1';						
									
		-- Signed Long Integer Multiply-Subtract Low with Saturation
		elsif (instruct = "00110") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									rs3(31 downto 0),
									rs2(31 downto 0),
									(-rs1(63 downto 0))	-- Check if this works
									);
			valid <= '1';						
									
		-- Signed Long Integer Multiply-Subtract High with Saturation
		elsif (instruct = "00111") then 
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									rs3(63 downto 32),
									rs2(63 downto 32),
									(-rs1(63 downto 0))
									);
			valid <= '1';						
									
		-- AU: add word unsigned
		elsif (instruct = "01000") then 		
			rd(31 downto 0)   <= SIGNED(UNSIGNED(rs1(31 downto 0)) + UNSIGNED(rs2(31 downto 0)));
			rd(63 downto 32)  <= SIGNED(UNSIGNED(rs1(63 downto 32)) + UNSIGNED(rs2(63 downto 32)));
			rd(95 downto 64)  <= SIGNED(UNSIGNED(rs1(95 downto 64)) + UNSIGNED(rs2(95 downto 64)));
			rd(127 downto 96) <= SIGNED(UNSIGNED(rs1(127 downto 96)) + UNSIGNED(rs2(127 downto 96)));	
			
			valid <= '1';
		
		-- ABSDB: absolute difference of bytes	
		elsif (instruct = "01001") then
			for j in 0 to 15 loop
				rd((7+(8 * j)) downto (j*8)) <= abs(rs2((7+(8 * j)) downto (j*8)) - rs1((7+(8 * j)) downto (j*8)));
			end loop;
		
			valid <= '1';
			
		-- AHU: add halfword unsigned	
		elsif (instruct = "01010") then
			for k in 0 to 7 loop
				rd((15+(16*k)) downto (16*k)) <= SIGNED(UNSIGNED(rs1((15+(16*k)) downto (16*k))) + UNSIGNED(rs2((15+(16*k)) downto (16*k))));
			end loop;
			
			valid <= '1';
		
		-- AHS: add halfword saturated
		elsif (instruct = "01011") then
			for x in 0 to 7 loop
				rd((15+(16*x)) downto (16*x)) <=  rs1((15+(16*x)) downto (16*x)) + rs2((15+(16*x)) downto (16*x)); 
			end loop;			
		
			valid <= '1';
			
		-- AND: bitwise logical and 
		elsif (instruct = "01100") then
			rd <= rs1 and rs2;
		
			valid <= '1';
		
		-- BCW: broadcast word
		elsif (instruct = "01101") then
			rd(31 downto 0)   <= rs1(31 downto 0);
			rd(63 downto 32)  <= rs1(31 downto 0);
			rd(95 downto 64)  <= rs1(31 downto 0);
			rd(127 downto 96) <= rs1(31 downto 0);
		
			valid <= '1';
		
		-- MAXWS: max signed word
		elsif (instruct = "01110") then
			rd(31 downto 0)   <= MAX(rs1(31 downto 0), rs2(31 downto 0));
			rd(63 downto 32)  <= MAX(rs1(63 downto 32), rs2(63 downto 32));
			rd(95 downto 64)  <= MAX(rs1(95 downto 64), rs2(95 downto 64));
			rd(127 downto 96) <= MAX(rs1(127 downto 96), rs2(127 downto 96));	
		
			valid <= '1';
		
		-- MINWS: min signed word
		elsif (instruct = "01111") then
			rd(31 downto 0)   <= MIN(rs1(31 downto 0), rs2(31 downto 0));
			rd(63 downto 32)  <= MIN(rs1(63 downto 32), rs2(63 downto 32));
			rd(95 downto 64)  <= MIN(rs1(95 downto 64), rs2(95 downto 64));
			rd(127 downto 96) <= MIN(rs1(127 downto 96), rs2(127 downto 96));		
		
			valid <= '1';
		
		-- MLHU: multiply low unsigned
		elsif (instruct = "10000") then
			rd(31 downto 0)   <= SIGNED(UNSIGNED(rs1(15 downto 0)) * UNSIGNED(rs2(15 downto 0)));
			rd(63 downto 32)  <= SIGNED(UNSIGNED(rs1(47 downto 32)) * UNSIGNED(rs2(47 downto 32)));
			rd(95 downto 64)  <= SIGNED(UNSIGNED(rs1(79 downto 64)) * UNSIGNED(rs2(79 downto 64)));
			rd(127 downto 96) <= SIGNED(UNSIGNED(rs1(111 downto 96)) * UNSIGNED(rs2(111 downto 96)));	
		
			valid <= '1';
		
		-- multiply low by constant unsigned
		elsif (instruct = "10001") then
			rd(31 downto 0)   <= SIGNED(UNSIGNED(rs1(15 downto 0)) * UNSIGNED(rs2(15 downto 0)));
			rd(63 downto 32)  <= SIGNED(UNSIGNED(rs1(47 downto 32)) * UNSIGNED(rs2(15 downto 0)));
			rd(95 downto 64)  <= SIGNED(UNSIGNED(rs1(79 downto 64)) * UNSIGNED(rs2(15 downto 0)));
			rd(127 downto 96) <= SIGNED(UNSIGNED(rs1(111 downto 96)) * UNSIGNED(rs2(15 downto 0)));

			valid <= '1';
			
		-- OR: bitwise logical or
		elsif (instruct = "10010") then
			rd <= rs1 or rs2;
			
			valid <= '1';
		
		-- PCNTW: count ones in words
		elsif (instruct = "10011") then
			rd(31 downto 0)   <= count_ones_words(rs1(31 downto 0));
			rd(63 downto 32)  <= count_ones_words(rs1(63 downto 32));
			rd(95 downto 64)  <= count_ones_words(rs1(95 downto 64));
			rd(127 downto 96) <= count_ones_words(rs1(127 downto 96));
		
			valid <= '1';
		
		-- ROTW: rotate bits in word
		elsif (instruct = "10100") then			
			rd(31 downto 0) <= rotate_right(rs1(31 downto 0), to_integer(rs2(4 downto 0)));
			rd(63 downto 32) <= rotate_right(rs1(63 downto 32), to_integer(rs2(4 downto 0)));
			rd(95 downto 64) <= rotate_right(rs1(95 downto 64), to_integer(rs2(4 downto 0)));
			rd(127 downto 96) <= rotate_right(rs1(127 downto 96), to_integer(rs2(4 downto 0)));
		
			valid <= '1';
			
		-- SFHS: subtract from halfword saturated
		elsif (instruct = "10101") then
			for y in 0 to 7 loop
				rd((15+(16*y)) downto (16*y)) <=  rs2((15+(16*y)) downto (16*y)) - rs1((15+(16*y)) downto (16*y)); 
			end loop;
		
			valid <= '1';
			
		-- SFW: subtract from word unsigned:
		elsif (instruct = "10110") then
			rd(31 downto 0)   <= SIGNED(UNSIGNED(rs2(31 downto 0)) - UNSIGNED(rs1(31 downto 0)));
			rd(63 downto 32)  <= SIGNED(UNSIGNED(rs2(63 downto 32)) - UNSIGNED(rs1(63 downto 32)));
			rd(95 downto 64)  <= SIGNED(UNSIGNED(rs2(95 downto 64)) - UNSIGNED(rs1(95 downto 64)));
			rd(127 downto 96) <= SIGNED(UNSIGNED(rs2(127 downto 96)) - UNSIGNED(rs1(127 downto 96)));		
		
			valid <= '1';
		
		-- li: Load a 16-bit Immediate value from the [20:5] instruction field into the 16-bit field specified by the Load Index field [23:21] of the 128-bit register rd.
		-- rs1 will be specified register(rd)
		-- rs2 will have the 16-bit immediate
		-- rs3 will have the load index 
		-- The write-back stage will write the output(rd) register back into the specific register
		elsif (instruct = "10111") then 
		
			
			if (rs3(3 downto 0) = X"0") then 
				rd(15 downto 0) <= rs2(15 downto 0);
				rd(127 downto 16) <= rs1(127 downto 16);
			
			elsif (rs3(3 downto 0) = X"1") then
				rd(31 downto 16) <= rs2(15 downto 0);
				rd(127 downto 32) <= rs1(127 downto 32);
				rd(15 downto 0) <= rs1(15 downto 0);
			
			elsif (rs3(3 downto 0) = X"2") then
				rd(47 downto 32) <= rs2(15 downto 0);
				rd(127 downto 48) <= rs1(127 downto 48);
				rd(31 downto 0) <= rs1(31 downto 0);
				
			elsif (rs3(3 downto 0) = X"3") then 
				rd(63 downto 48) <= rs2(15 downto 0);
				rd(127 downto 64) <= rs1(127 downto 64);
				rd(47 downto 0) <= rs1(47 downto 0);
			
			elsif (rs3(3 downto 0) = X"4") then
				rd(79 downto 64) <= rs2(15 downto 0);
				rd(127 downto 80) <= rs1(127 downto 80);
				rd(63 downto 0) <= rs1(63 downto 0);
				
			elsif (rs3(3 downto 0) = X"5") then
				rd(95 downto 80) <= rs2(15 downto 0);
				rd(127 downto 96) <= rs1(127 downto 96);
				rd(79 downto 0) <= rs1(79 downto 0);
			
			elsif (rs3(3 downto 0) = X"6") then
				rd(111 downto 96) <= rs2(15 downto 0);
				rd(127 downto 112) <= rs1(127 downto 112);
				rd(95 downto 0) <= rs1(95 downto 0);
				
			elsif (rs3(3 downto 0) = X"7") then
				rd(127 downto 112) <= rs2(15 downto 0);
				rd(111 downto 0) <= rs1(111 downto 0);	
			
			else
				null;
			
			end if;
			
			valid <= '1';
		else
			valid <= '0';
			-- null;
		
		end if;

	end process;
	
end ALU;
