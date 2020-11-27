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

entity registerfile_tb is end reigsterfile_tb;
	
architecture registerfile_tb of registerfile_tb is 
-- Stimulated Signals
		signal writeData 		: STD_LOGIC_VECTOR(127 downto 0);   	-- rd    
		signal writeRegSel		: STD_LOGIC_VECTOR(4 downto 0);	   	-- rd
		signal writeEnable 		: STD_LOGIC; 			 			-- write enable	
		signal input 			: STD_LOGIC_VECTOR(24 downto 0);		-- 25 bit instruction to be decode
		signal clk 				: STD_LOGIC := 0 					    	-- clock  			   

--Output Signals 
		signal rs1  			: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');	-- rs1 data
		signal rs2  			: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');	-- rs2 data
		signal rs3  			: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');	-- rs3 data	 
		signal RSel1			: STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs1
		signal RSel2 			: STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs2
		signal RSel3 			: STD_LOGIC_VECTOR(4 downto 0);	   	--  output rs3
		signal RselD 			: STD_LOGIC_VECTOR(4 downto 0);   	-- output rd	 
		signal ALU_Ctrl			: STD_LOGIC_VECTOR(4 downto 0);					 
		
begin 
	UUT: entity register_file port map(
		writeData => writeData,
		writeRegSel => writeRegSel,
		writeEnable => writeEnable,
		input => input,			
		clk => clk,			 			   
		rs1  =>	rs1,		
		rs2  =>	rs2,	
		rs3  =>	rs3,		 
		RSel1 => RSel1,			
		RSel2 => RSel2,			
		RSel3 => RSel3,		
		RselD => RselD,			
		ALU_Ctrl =>	ALU_Ctrl );			 
		
		
		R3_instruction : process 
		begin 
			
			
			
			
			
			
			
			
			
				wait;
		end process;
		
		R4_instruction : process
		begin 
			
			
			
			wait;
		end process;
		
		writeRD : process
		begin
			
			
			
			wait;
		end process;

end registerfile_tb; 			