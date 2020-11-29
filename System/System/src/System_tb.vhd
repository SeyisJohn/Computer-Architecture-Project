-------------------------------------------------------------------------------
--
-- Title       : System_tb
-- Design      : System
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\System\System\src\System_tb.vhd
-- Generated   : Thu Nov 26 22:08:18 2020
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
--{entity {System_tb} architecture {System_tb}}

	library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;  
use STD.textio.all;
use ieee.std_logic_textio.all;	 

library work;
use work.all;


entity System_tb is
end System_tb;

--}} End of automatically maintained section

architecture System_tb of System_tb is

	-- Observed Signals
	signal WriteMode : STD_LOGIC;
	signal Rst : STD_LOGIC;
	signal Set : STD_LOGIC;
	signal Clk : STD_LOGIC := '0';
	signal PC_new : STD_LOGIC_VECTOR(5 downto 0);
	signal Opcode : STD_LOGIC_VECTOR(24 downto 0);
	
	signal PC : STD_LOGIC_VECTOR(5 downto 0);
	signal Out_Opcode: STD_LOGIC_VECTOR(24 downto 0);
	signal In_RegFile: STD_LOGIC_VECTOR(24 downto 0);
		 
	signal Out_RegFile_R1 : STD_LOGIC_VECTOR(127 downto 0);
	signal Out_RegFile_R2 : STD_LOGIC_VECTOR(127 downto 0);
	signal Out_RegFile_R3 : STD_LOGIC_VECTOR(127 downto 0);
	signal Out_RegFile_RSel1 : STD_LOGIC_VECTOR(4 downto 0); 
	signal Out_RegFile_RSel2 : STD_LOGIC_VECTOR(4 downto 0);
	signal Out_RegFile_RSel3 : STD_LOGIC_VECTOR(4 downto 0);
	signal Out_RegFile_RSelD : STD_LOGIC_VECTOR(4 downto 0);
	signal Out_RegFile_ALU_Ctrl :  STD_LOGIC_VECTOR(4 downto 0);
		 
	signal In_ALU_R1 : STD_LOGIC_VECTOR(127 downto 0); 
	signal In_ALU_R2 : STD_LOGIC_VECTOR(127 downto 0);
	signal In_ALU_R3 : STD_LOGIC_VECTOR(127 downto 0);
	signal In_ALU_Ctrl : STD_LOGIC_VECTOR(4 downto 0);
	signal In_ALU_RDest : STD_LOGIC_VECTOR(4 downto 0);
	 
	signal Out_ALU_RD : STD_LOGIC_VECTOR(127 downto 0);
	signal Out_ALU_RDest : STD_LOGIC_VECTOR(4 downto 0);
	signal Out_ALU_Valid : STD_LOGIC;
		 
	signal Out_WB_Value : STD_LOGIC_VECTOR(127 downto 0);
	signal Out_WB_RDest : STD_LOGIC_VECTOR(4 downto 0);
	signal Out_WB_RWrite : STD_LOGIC; --Register Write Signal
		 
	signal In_DataForward_R1_num : STD_LOGIC_VECTOR(4 downto 0);
	signal In_DataForward_R2_num : STD_LOGIC_VECTOR(4 downto 0);
	signal In_DataForward_R3_num : STD_LOGIC_VECTOR(4 downto 0);
	signal In_DataForward_Rd : STD_LOGIC_VECTOR(127 downto 0);
	signal In_DataForward_Rd_num : STD_LOGIC_VECTOR(4 downto 0);	 
		 
	signal Out_DataForward_Rd	: STD_LOGIC_VECTOR(127 downto 0);
	signal Out_DataForward_MuxSel : STD_LOGIC_VECTOR(1 downto 0);
		 
begin
	
	UUT: entity System port map
		(
		Clk => Clk,
		Rst => Rst,
		Set => Set,
		WriteMode => WriteMode,
		PC_new => PC_new,
		Opcode_in => Opcode,
		PC => PC
		);
	
--	clock:process
--	begin 
--		wait for 300 ns;
--		for i in 0 to 63 loop
--			wait for 25 ns;
--			Clk <= not Clk;
--		end loop;
--		wait;
--	end process;
	
	
	testing: process
	variable PC_counter : UNSIGNED(5 downto 0) := (others => '0');
	variable line_v : line;
    file read_file : text; 
	variable instruct_opcode: STD_LOGIC_VECTOR(24 downto 0);
	
	file write_file : text;
	
	
	begin
		
		file_open(read_file, "Opcode.txt",  read_mode);
		file_open(write_file, "Results.txt", write_mode);
		
		WriteMode <= '1';
		Set <= '1';
		
		wait for 10 ns;
		
--		report "WriteMode: " & to_string(WriteMode);
		
		while not endfile(read_file) loop
			readline(read_file, line_v);
			read(line_v, instruct_opcode);
			
			PC_new <= STD_LOGIC_VECTOR(PC_counter);
			Opcode <= instruct_opcode;
			
			report "Line: " & to_string(instruct_opcode);
			report "PC : " & to_string(PC_counter);
			
			
			PC_counter := PC_counter + 1;
			
			wait for 10 ns;
			
		end loop;	
		
		WriteMode <= '0';
		PC_new <= "000000";
		
		wait for 10 ns;
		
		Set <= '0';
		
		wait for 10 ns;
		
--		report "WriteMode: " & to_string(WriteMode);
		

		for i in 0 to 63 loop
			wait for 25 ns;
			Clk <= not Clk;
		end loop;
		
	
		
		
		wait;
	end process;
		

end System_tb;
