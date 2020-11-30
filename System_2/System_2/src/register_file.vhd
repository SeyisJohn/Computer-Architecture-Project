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
use ieee.numeric_std.all;

entity register_file is
	 port(
		 rs1  					: out STD_LOGIC_VECTOR(127 downto 0);	-- rs1
		 rs2  					: out STD_LOGIC_VECTOR(127 downto 0);	-- rs2
		 rs3  					: out STD_LOGIC_VECTOR(127 downto 0);	-- rs3
		 writeData 				: in STD_LOGIC_VECTOR(127 downto 0);   	-- rd   
		 RSel1					: out STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs1
		 RSel2 					: out STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs2
		 RSel3 					: out STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs3
		 RSelD 					: out STD_LOGIC_VECTOR(4 downto 0);   -- output rd
		 
		 writeRegSel			: in STD_LOGIC_VECTOR(4 downto 0);	   	-- rd
		 writeEnable 			: in STD_LOGIC; 			 			-- write enable	
		 input 					: in STD_LOGIC_VECTOR(24 downto 0);		-- 25 bit instruction to be decoded
		 ALU_Ctrl				: out STD_LOGIC_VECTOR(4 downto 0);     -- ALU control signal
		 vRSel1                 : out STD_LOGIC;  --Specify if the rs1 output is a valid register for forwarding
		 vRSel2                 : out STD_LOGIC;  --Specify if the rs2 output is a valid register for forwarding
		 vRSel3                 : out STD_LOGIC	  --Specify if the rs3 output is a valid register for forwarding
	     );
end register_file;

--}} End of automatically maintained section

architecture behavioral of register_file is
	type registerFile is array(0 to 31) of STD_LOGIC_VECTOR(127 downto 0); 
	signal reg_array : registerFile	  := (
							x"00000000000000000000000000000000",   	-- zero 
							x"11111111111111111111111111111111",	-- $at
							x"22222222222222222222222222222222",	-- $v0
							x"33333333333333333333333333333333",	-- $v1
							x"44444444444444444444444444444444",	-- $a0
							x"55555555555555555555555555555555",	-- $a1 
							x"66666666666666666666666666666666",	-- $a2
							x"77777777777777777777777777777777",	-- $a3
							x"88888888888888888888888888888888",	-- $t0
							x"99999999999999999999999999999999",	-- $t1
							x"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",	-- $t2
							x"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",	-- $t3
							x"cccccccccccccccccccccccccccccccc",	-- $t4
							x"dddddddddddddddddddddddddddddddd",	-- $t5
							x"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",	-- $t6
							x"ffffffffffffffffffffffffffffffff",	-- $t7
							x"00000000000000000000000000000000",	-- $s0
							x"11111111111111111111111111111111",	-- $s1
							x"22222222222222222222222222222222",	-- $s2
							x"33333333333333333333333333333333",	-- $s3
							x"44444444444444444444444444444444",	-- $s4
							x"55555555555555555555555555555555",	-- $s5
							x"66666666666666666666666666666666",   	-- $s6
							x"77777777777777777777777777777777",	-- $s7
							x"88888888888888888888888888888888",	-- $t8
							x"99999999999999999999999999999999",	-- $t9
							x"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",	-- $k0
							x"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",	-- $k1 
							x"10008000100080001000800010008000",	-- $gp
							x"7ffff1ec7ffff1ec7ffff1ec7ffff1ec",	-- $sp
							x"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",	-- $fp
							x"ffffffffffffffffffffffffffffffff"		-- $ra											
							);
											
function R4_Instruction(instruction : STD_LOGIC_VECTOR(24 downto 0)) return STD_LOGIC_VECTOR is
	variable result : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
begin	 
	result(2 downto 0) := instruction(22 downto 20);
    return result;
		
end R4_Instruction;

function R3_Instruction(instruction : STD_LOGIC_VECTOR(24 downto 0)) return STD_LOGIC_VECTOR is
	variable result : STD_LOGIC_VECTOR(4 downto 0);
begin	
	if instruction(18 downto 15) = "0000" then		--nop
		result := "11000";
	elsif instruction(18 downto 15) = "0001" then	--AU: add word unsigned
		result := "01000";
	elsif instruction(18 downto 15) = "0010" then	--ABSDB
		result := "01001";
	elsif instruction(18 downto 15) = "0011" then	 --AHU
		result := "01010";
	elsif instruction(18 downto 15) = "0100" then	  --AHS
		result := "01011";
	elsif instruction(18 downto 15) = "0101" then	   --AND
		result := "01100";
	elsif instruction(18 downto 15) = "0110" then	  --BCW
		result := "01101";
	elsif instruction(18 downto 15) = "0111" then	   --MAXWS
		result := "01110";
	elsif instruction(18 downto 15) = "1000" then	   --MINWS			
		result := "01111";	
	elsif instruction(18 downto 15) = "1001" then	   --MLHU		 
		result := "10000";
	elsif instruction(18 downto 15) = "1010" then	   --MUL LOW			
		result := "10001";
	elsif instruction(18 downto 15) = "1011" then	   	--OR		
		result := "10010";
	elsif instruction(18 downto 15) = "1100" then	   --PCNTW			
		result := "10011";
	elsif instruction(18 downto 15) = "1101" then	   --ROTW			
		result := "10100";
	elsif instruction(18 downto 15) = "1110" then	   --SFHS		
		result := "10101";
	elsif instruction(18 downto 15) = "1111" then	   	--SFW		
		result := "10110";
	end if;
	
	return result;
end R3_Instruction;


begin							   
	
	
	process(input)  
	  	 variable RegSel1	: STD_LOGIC_VECTOR(4 downto 0);	   	-- rs1
		 variable RegSel2 	: STD_LOGIC_VECTOR(4 downto 0);	   	-- rs2
		 variable RegSel3 	: STD_LOGIC_VECTOR(4 downto 0);	   	-- rs3
		 variable RegSelD   : STD_LOGIC_VECTOR(4 downto 0);     -- rd
	begin   
		
		 if (input = "11----0000---------------") then
			    vRSel1 <= '0';
			    vRSel2 <= '0';
			    vRSel3 <= '0'; 
				ALU_Ctrl <=	R3_Instruction(input);
		
		 elsif (input(24) = '1' and input(23) = '0') then		-- R4 - Instruction Format
				
				RegSel3 := input(19 downto 15);
				RegSel2 := input(14 downto 10);
				RegSel1 := input(9 downto 5);
				
				RSelD <= input(4 downto 0);
				

				ALU_Ctrl <= R4_Instruction(input);
				
				if (WriteEnable = '1' and writeRegSel = regSel1) then 
					rs1 <= WriteData;
					rs2 <= reg_array(to_integer(unsigned(regSel2)));
					rs3 <= reg_array(to_integer(unsigned(regSel3)));
				
				elsif (WriteEnable = '1' and writeRegSel = regSel2) then
					rs1 <= reg_array(to_integer(unsigned(regSel1)));
					rs2 <= WriteData;
					rs3 <= reg_array(to_integer(unsigned(regSel3)));
					
				elsif (WriteEnable = '1' and writeRegSel = regSel3) then
					rs1 <= reg_array(to_integer(unsigned(regSel1)));
					rs2 <= reg_array(to_integer(unsigned(regSel2)));
					rs3 <= WriteData;
				else
					rs1 <= reg_array(to_integer(unsigned(regSel1)));
					rs2 <= reg_array(to_integer(unsigned(regSel2)));
					rs3 <= reg_array(to_integer(unsigned(regSel3)));
				end if;
				
				RSel1 <= RegSel1;
				RSel2 <= RegSel2;
				RSel3 <= RegSel3;
				
			    vRSel1 <= '1';
			    vRSel2 <= '1';
			    vRSel3 <= '1';
				
			elsif (input(24) = '1' and input(23) = '1') then	-- R3- Instruction Format
				
				regSel1 := input(9 downto 5);
				regSel2 := input(14 downto 10);
				
				RselD <= input(4 downto 0);

				
				ALU_Ctrl <=	R3_Instruction(input);	
				
				if (WriteEnable = '1' and writeRegSel = regSel1) then
					rs1 <= WriteData;
					rs2 <= reg_array(to_integer(unsigned(regSel2)));
					
				elsif (WriteEnable = '1' and writeRegSel = regSel2) then
					rs1 <= reg_array(to_integer(unsigned(regSel1)));
					rs2 <= WriteData; 	
				else
					rs1 <= reg_array(to_integer(unsigned(regSel1)));
					rs2 <= reg_array(to_integer(unsigned(regSel2))); 
				end if;	
				
				RSel1 <= regSel1;
				RSel2 <= regSel2;
				
			    vRSel1 <= '1';
			    vRSel2 <= '1';
			    vRSel3 <= '0';
				
			elsif (input(24) = '0') then							-- Load Immediate
				
				rs2(15 downto 0) <= input(20 downto 5);
				rs3(2 downto 0) <= input(23 downto 21);
				ALU_Ctrl <= "10111";
				regSelD := input(4 downto 0);
				
				if (WriteEnable = '1' and writeRegSel = regSelD) then
					rs1 <= WriteData;
				else
					rs1 <= reg_array(to_integer(unsigned(input(4 downto 0))));
				end if;
				
				RSelD <= regSelD;
				
			 vRSel1 <= '1';
			 vRSel2 <= '0';
			 vRSel3 <= '0';
			else  
				
			  vRSel1 <= '0';
			  vRSel2 <= '0';
			  vRSel3 <= '0';
			end if;
			
	end process;
	
	
	
	process(WriteEnable, writeRegSel, WriteData)
	begin	
		if (WriteEnable = '1') then
			reg_array(to_integer(unsigned(writeRegSel))) <= WriteData;
		end if;
	end process;
	
	
end behavioral; 	