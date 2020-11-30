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
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;  

library work;
use work.all;

entity registerfile_tb is end registerfile_tb;
	
architecture registerfile_tb of registerfile_tb is 
--Stimulated Signals
signal		 writeData 				: STD_LOGIC_VECTOR(127 downto 0);  	-- rd   
signal		 writeRegSel			: STD_LOGIC_VECTOR(4 downto 0);	   	-- rd
signal		 writeEnable 			: STD_LOGIC; 			 			-- write enable	
signal		 input 					: STD_LOGIC_VECTOR(24 downto 0);	-- 25 bit instruction to be decoded
--Output Signals		 
signal		 ALU_Ctrl				: STD_LOGIC_VECTOR(4 downto 0);     -- ALU control signal
signal		 vRSel1                 : STD_LOGIC;  						--Specify if the rs1 output is a valid register for forwarding
signal		 vRSel2                 : STD_LOGIC;  						--Specify if the rs2 output is a valid register for forwarding
signal		 vRSel3                 : STD_LOGIC;	  						--Specify if the rs3 output is a valid register for forwarding
signal		 RSel1					: STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs1
signal		 RSel2 					: STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs2
signal		 RSel3 					: STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs3
signal		 RSelD 					: STD_LOGIC_VECTOR(4 downto 0);    	-- output rd
signal		 rs1  					: STD_LOGIC_VECTOR(127 downto 0);	-- rs1
signal		 rs2  					: STD_LOGIC_VECTOR(127 downto 0);	-- rs2
signal		 rs3  					: STD_LOGIC_VECTOR(127 downto 0);	-- rs3

begin 
	UUT: entity register_file port map(
		writeData => writeData,
		writeRegSel => writeRegSel,
		writeEnable => writeEnable,
		input => input,			
		ALU_Ctrl =>	ALU_Ctrl,
		vRSel1 => vRSel1,
		vRSel2 => vRSel2,
		vRSel3 => vRSel3,
		RSel1 => RSel1,			
		RSel2 => RSel2,			
		RSel3 => RSel3,		 			   
		RselD => RselD,
		rs1  =>	rs1,		
		rs2  =>	rs2,	
		rs3  =>	rs3		 
	);			 
		
		
		Instructions : process 
		begin  
			input <= "1100000001010110111011110";
			wait for 600ns;
			input <= "1000010110010100010100010";
			wait for 600ns;
			input <= "0011000000000000111001110";
		 	wait for 600ns;
			wait;
		end process;
	
		writeRD : process
		begin 
			writeEnable <= '0';
			wait for 1200ns;
			writeEnable <= '1';
			writeData <= x"bbbbcbbbbbbbbbbbbbbbbbbbbbbbbbab";
			writeRegSel <= "00110";
			wait;
		end process;

end registerfile_tb; 			