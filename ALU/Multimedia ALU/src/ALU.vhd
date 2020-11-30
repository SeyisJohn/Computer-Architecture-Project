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
		 rs1_in : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2_in : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3_in : in STD_LOGIC_VECTOR(127 downto 0);
		 ALU_instruct : in STD_LOGIC_VECTOR(4 downto 0);
		 reg_des_in : in STD_LOGIC_VECTOR(4 downto 0);
		 rd : out STD_LOGIC_VECTOR(127 downto 0);
		 valid : out STD_LOGIC;
		 reg_des_out : out STD_LOGIC_VECTOR(4 downto 0)
		 
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU of ALU is
	
	function signed_int_multiply_add ( -- Test this
	multiplicand, multiplicator: STD_LOGIC_VECTOR(15 downto 0);
	add_value : STD_LOGIC_VECTOR(31 downto 0)) 
		return STD_LOGIC_VECTOR is 
		variable value, product : SIGNED(31 downto 0) := (others => '0');
	begin
		
		product := SIGNED(multiplicand)	* SIGNED(multiplicator); 
		
		value := product + SIGNED(add_value);
		
		 if (product > 0 and SIGNED(add_value) > 0 and value < product) then
			 value := X"7FFF_FFFF";
		 elsif (product < 0 and SIGNED(add_value) < 0 and value > product) then
			 value := X"8000_0000";
		 else
			 null;
		 end if;	
		
		return STD_LOGIC_VECTOR(value);	
	
	end signed_int_multiply_add;	
	
	function signed_int_multiply_subtract ( -- Test this
	multiplicand, multiplicator: STD_LOGIC_VECTOR(15 downto 0);
	add_value : STD_LOGIC_VECTOR(31 downto 0)) 
		return STD_LOGIC_VECTOR is 
		variable value, product : SIGNED(31 downto 0) := (others => '0');
	begin
		
		product := SIGNED(multiplicand)	* SIGNED(multiplicator); 
		
		value := product - SIGNED(add_value);
		
		 if (product > 0 and SIGNED(add_value) > 0 and value < product) then
			 value := X"7FFF_FFFF";
		 elsif (product < 0 and SIGNED(add_value) < 0 and value > product) then
			 value := X"8000_0000";
		 else
			 null;
		 end if;	
		
		return STD_LOGIC_VECTOR(value);	
	
	end signed_int_multiply_subtract;
	
	
	function signed_long_multiply_add ( -- Test this
	multiplicand, multiplicator: STD_LOGIC_VECTOR(31 downto 0);
	add_value : STD_LOGIC_VECTOR(63 downto 0)) 
		return STD_LOGIC_VECTOR is 
		variable value, product : SIGNED(63 downto 0) := (others => '0');
	begin
		
		product := SIGNED(multiplicand)	* SIGNED(multiplicator); 
		
		value := product + SIGNED(add_value);
		
		if (product > 0 and SIGNED(add_value) > 0 and value < product) then
			value := X"7FFF_FFFF_FFFF_FFFF";
		elsif (product < 0 and SIGNED(add_value) < 0 and value > product) then
			value := X"8000_0000_0000_0000";
		else
			null;
		end if;	
		
		return STD_LOGIC_VECTOR(value);	
	
	end signed_long_multiply_add;
	
	
	function signed_long_multiply_subtract ( -- Test this
	multiplicand, multiplicator: STD_LOGIC_VECTOR(31 downto 0);
	add_value : STD_LOGIC_VECTOR(63 downto 0)) 
		return STD_LOGIC_VECTOR is 
		variable value, product : SIGNED(63 downto 0) := (others => '0');
	begin
		
		product := SIGNED(multiplicand)	* SIGNED(multiplicator); 
		
		value := product - SIGNED(add_value);
		
		if (product > 0 and SIGNED(add_value) > 0 and value < product) then
			value := X"7FFF_FFFF_FFFF_FFFF";
		elsif (product < 0 and SIGNED(add_value) < 0 and value > product) then
			value := X"8000_0000_0000_0000";
		else
			null;
		end if;	
		
		return STD_LOGIC_VECTOR(value);	
	
	end signed_long_multiply_subtract;
	
	
	function MAX(LEFT, RIGHT: STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is
	begin
		if (SIGNED(LEFT) > SIGNED(RIGHT)) then return LEFT;
		
		else return RIGHT;
		end if;
	end;
	
	
	function MIN(LEFT, RIGHT: STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is
	begin
		if (SIGNED(LEFT) < SIGNED(RIGHT)) then return LEFT;
		
		else return RIGHT;
		end if;
	end;
	
	
	function count_ones_words (
	input : STD_LOGIC_VECTOR(31 downto 0))
		return STD_LOGIC_VECTOR is 
		variable count : SIGNED(31 downto 0) := (others => '0');
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
	input1, input2 : STD_LOGIC_VECTOR(15 downto 0))
		return STD_LOGIC_VECTOR is
		variable result : SIGNED(15 downto 0);
	begin
		
		result := SIGNED(input1) + SIGNED(input2);
		
		if SIGNED(input1) > 0 and SIGNED(input2) > 0 and (result < SIGNED(input1) or result < SIGNED(input2)) then
			result := X"7FFF";
		elsif (SIGNED(input1) < 0 and SIGNED(input2) < 0) and (result > SIGNED(input1) or result > SIGNED(input2)) then
			result := X"8000";
		else
			null;
		end if;			
		
		return STD_LOGIC_VECTOR(result);
	end add_word_saturated;	

begin
	
	
	process (ALU_instruct, rs1_in, rs2_in, rs3_in)
	variable reg_for_load : STD_LOGIC_VECTOR(127 downto 0) := rs1_in;
	begin
		
		-- Signed Integer Multiply-Add Low with Saturation
		if (ALU_instruct = "00000") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE  
									rs3_in(15 downto 0), 
									rs2_in(15 downto 0), 
									rs1_in(31 downto 0)
									);
			valid <= '1';				
									
									
		-- Signed Integer Multiply-Add High with Saturation
		elsif (ALU_instruct = "00001") then
			rd(31 downto 0) <= signed_int_multiply_add(	-- No idea if this is SYNTHESIZABLE
									rs3_in(31 downto 16), 
									rs2_in(31 downto 16), 
									rs1_in(31 downto 0)
									);
			valid <= '1';						
									
		-- Signed Integer Multiply-Subtract Low with Saturation
		elsif (ALU_instruct = "00010") then
			rd(31 downto 0) <= signed_int_multiply_subtract(	-- No idea if this is SYNTHESIZABLE  
									rs3_in(15 downto 0), 
									rs2_in(15 downto 0), 
									rs1_in(31 downto 0) --Check if this works
									);
		    valid <= '1';							
									
		-- Signed Integer Multiply-Subtract High with Saturation
		elsif (ALU_instruct = "00011") then
			rd(31 downto 0) <= signed_int_multiply_subtract(	-- No idea if this is SYNTHESIZABLE
									rs3_in(31 downto 16), 
									rs2_in(31 downto 16), 
									rs1_in(31 downto 0) -- Check if this works
									);
			valid <= '1';						
									
		-- Signed Long Integer Multiply-Add Low with Saturation
		elsif (ALU_instruct = "00100") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									rs3_in(31 downto 0),
									rs2_in(31 downto 0),
									rs1_in(63 downto 0)
									);
			valid <= '1';						
									
		-- Signed Long Integer Multiply-Add High with Saturation
		elsif (ALU_instruct = "00101") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									rs3_in(63 downto 32),
									rs2_in(63 downto 32),
									rs1_in(63 downto 0)
									);
			valid <= '1';						
									
		-- Signed Long Integer Multiply-Subtract Low with Saturation
		elsif (ALU_instruct = "00110") then
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									rs3_in(31 downto 0),
									rs2_in(31 downto 0),
									rs1_in(63 downto 0)	-- Check if this works
									);
			valid <= '1';						
									
		-- Signed Long Integer Multiply-Subtract High with Saturation
		elsif (ALU_instruct = "00111") then 
			rd(63 downto 0) <= signed_long_multiply_add( -- No idea if this is SYNTHESIZABLE
									rs3_in(63 downto 32),
									rs2_in(63 downto 32),
									rs1_in(63 downto 0)
									);
			valid <= '1';						
									
		-- AU: add word unsigned
		elsif (ALU_instruct = "01000") then 		
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(31 downto 0)) + UNSIGNED(rs2_in(31 downto 0)));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(63 downto 32)) + UNSIGNED(rs2_in(63 downto 32)));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(95 downto 64)) + UNSIGNED(rs2_in(95 downto 64)));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(127 downto 96)) + UNSIGNED(rs2_in(127 downto 96)));	
			
			valid <= '1';
		
		-- ABSDB: absolute difference of bytes	
		elsif (ALU_instruct = "01001") then
			for j in 0 to 15 loop
				rd((7+(8 * j)) downto (j*8)) <= STD_LOGIC_VECTOR(abs(SIGNED(rs2_in((7+(8 * j)) downto (j*8))) - SIGNED(rs1_in((7+(8 * j)) downto (j*8)))));
			end loop;
		
			valid <= '1';
			
		-- AHU: add halfword unsigned	
		elsif (ALU_instruct = "01010") then
			for k in 0 to 7 loop
				rd((15+(16*k)) downto (16*k)) <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in((15+(16*k)) downto (16*k))) + UNSIGNED(rs2_in((15+(16*k)) downto (16*k))));
			end loop;
			
			valid <= '1';
		
		-- AHS: add halfword saturated
		elsif (ALU_instruct = "01011") then
			for x in 0 to 7 loop
				rd((15+(16*x)) downto (16*x)) <=  STD_LOGIC_VECTOR(SIGNED(rs1_in((15+(16*x)) downto (16*x))) + SIGNED(rs2_in((15+(16*x)) downto (16*x)))); 
			end loop;			
		
			valid <= '1';
			
		-- AND: bitwise logical and 
		elsif (ALU_instruct = "01100") then
			rd <= rs1_in and rs2_in;
		
			valid <= '1';
		
		-- BCW: broadcast word
		elsif (ALU_instruct = "01101") then
			rd(31 downto 0)   <= rs1_in(31 downto 0);
			rd(63 downto 32)  <= rs1_in(31 downto 0);
			rd(95 downto 64)  <= rs1_in(31 downto 0);
			rd(127 downto 96) <= rs1_in(31 downto 0);
		
			valid <= '1';
		
		-- MAXWS: max signed word
		elsif (ALU_instruct = "01110") then
			rd(31 downto 0)   <= MAX(rs1_in(31 downto 0), rs2_in(31 downto 0));
			rd(63 downto 32)  <= MAX(rs1_in(63 downto 32), rs2_in(63 downto 32));
			rd(95 downto 64)  <= MAX(rs1_in(95 downto 64), rs2_in(95 downto 64));
			rd(127 downto 96) <= MAX(rs1_in(127 downto 96), rs2_in(127 downto 96));	
		
			valid <= '1';
		
		-- MINWS: min signed word
		elsif (ALU_instruct = "01111") then
			rd(31 downto 0)   <= MIN(rs1_in(31 downto 0), rs2_in(31 downto 0));
			rd(63 downto 32)  <= MIN(rs1_in(63 downto 32), rs2_in(63 downto 32));
			rd(95 downto 64)  <= MIN(rs1_in(95 downto 64), rs2_in(95 downto 64));
			rd(127 downto 96) <= MIN(rs1_in(127 downto 96), rs2_in(127 downto 96));		
		
			valid <= '1';
		
		-- MLHU: multiply low unsigned
		elsif (ALU_instruct = "10000") then
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(15 downto 0)) * UNSIGNED(rs2_in(15 downto 0)));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(47 downto 32)) * UNSIGNED(rs2_in(47 downto 32)));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(79 downto 64)) * UNSIGNED(rs2_in(79 downto 64)));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(111 downto 96)) * UNSIGNED(rs2_in(111 downto 96)));	
		
			valid <= '1';
		
		-- multiply low by constant unsigned
		elsif (ALU_instruct = "10001") then
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(15 downto 0)) * UNSIGNED(rs2_in(15 downto 0)));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(47 downto 32)) * UNSIGNED(rs2_in(15 downto 0)));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(79 downto 64)) * UNSIGNED(rs2_in(15 downto 0)));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs1_in(111 downto 96)) * UNSIGNED(rs2_in(15 downto 0)));

			valid <= '1';
			
		-- OR: bitwise logical or
		elsif (ALU_instruct = "10010") then
			rd <= rs1_in or rs2_in;
			
			valid <= '1';
		
		-- PCNTW: count ones in words
		elsif (ALU_instruct = "10011") then
			rd(31 downto 0)   <= count_ones_words(rs1_in(31 downto 0));
			rd(63 downto 32)  <= count_ones_words(rs1_in(63 downto 32));
			rd(95 downto 64)  <= count_ones_words(rs1_in(95 downto 64));
			rd(127 downto 96) <= count_ones_words(rs1_in(127 downto 96));
		
			valid <= '1';
		
		-- ROTW: rotate bits in word
		elsif (ALU_instruct = "10100") then			
			rd(31 downto 0) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1_in(31 downto 0)), to_integer(UNSIGNED(rs2_in(4 downto 0)))));
			rd(63 downto 32) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1_in(63 downto 32)), to_integer(UNSIGNED(rs2_in(4 downto 0)))));
			rd(95 downto 64) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1_in(95 downto 64)), to_integer(UNSIGNED(rs2_in(4 downto 0)))));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1_in(127 downto 96)), to_integer(UNSIGNED(rs2_in(4 downto 0)))));
		
			valid <= '1';
			
		-- SFHS: subtract from halfword saturated
		elsif (ALU_instruct = "10101") then
			for y in 0 to 7 loop
				rd((15+(16*y)) downto (16*y)) <=  STD_LOGIC_VECTOR(SIGNED(rs2_in((15+(16*y)) downto (16*y))) - SIGNED(rs1_in((15+(16*y)) downto (16*y)))); 
			end loop;
		
			valid <= '1';
			
		-- SFW: subtract from word unsigned:
		elsif (ALU_instruct = "10110") then
			rd(31 downto 0)   <= STD_LOGIC_VECTOR(UNSIGNED(rs2_in(31 downto 0)) - UNSIGNED(rs1_in(31 downto 0)));
			rd(63 downto 32)  <= STD_LOGIC_VECTOR(UNSIGNED(rs2_in(63 downto 32)) - UNSIGNED(rs1_in(63 downto 32)));
			rd(95 downto 64)  <= STD_LOGIC_VECTOR(UNSIGNED(rs2_in(95 downto 64)) - UNSIGNED(rs1_in(95 downto 64)));
			rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs2_in(127 downto 96)) - UNSIGNED(rs1_in(127 downto 96)));		
		
			valid <= '1';
		
		-- li: Load a 16-bit Immediate value from the [20:5] ALU_instruction field into the 16-bit field specified by the Load Index field [23:21] of the 128-bit register rd.
		-- rs1_in will be specified register(rd)
		-- rs2_in will have the 16-bit immediate
		-- rs3_in will have the load index 
		-- The write-back stage will write the output(rd) register back into the specific register
		elsif (ALU_instruct = "10111") then 
			
			reg_for_load := rs1_in;
			
			if (rs3_in(2 downto 0) = "000") then
				reg_for_load(15 downto 0) := rs2_in(15 downto 0);
			
			elsif (rs3_in(2 downto 0) = "001") then
				reg_for_load(31 downto 16) := rs2_in(15 downto 0);
			
			elsif (rs3_in(2 downto 0) = "010") then 
				reg_for_load(47 downto 32) := rs2_in(15 downto 0);
				
			elsif (rs3_in(2 downto 0) = "011") then
				reg_for_load(63 downto 48) := rs2_in(15 downto 0);
			
			elsif (rs3_in(2 downto 0) = "100") then 
				reg_for_load(79 downto 64) := rs2_in(15 downto 0);
				
			elsif (rs3_in(2 downto 0) = "101") then
				reg_for_load(95 downto 80) := rs2_in(15 downto 0);
			
			elsif (rs3_in(2 downto 0) = "110") then
				reg_for_load(111 downto 96) := rs2_in(15 downto 0);
				
			elsif (rs3_in(2 downto 0) = "111") then
				reg_for_load(127 downto 112) := rs2_in(15 downto 0);
			else
				null;
			
			end if;
			
			rd <= reg_for_load;
			
			valid <= '1';
		else
			
			valid <= '0';
			-- null;
		
		end if;

	end process;
	
	reg_des_out <= reg_des_in;
	
end ALU;
