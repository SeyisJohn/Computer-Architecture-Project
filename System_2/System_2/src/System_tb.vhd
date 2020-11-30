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
	signal WriteMode : STD_LOGIC; 	-- Signal to the instruction buffer to write value
	signal Rst : STD_LOGIC;		  	-- Signal to PC to reset counter
	signal Set : STD_LOGIC;		  	-- Signal to PC to set counter to PC_new 
	signal Clk : STD_LOGIC := '0';	-- Signal Clock
	signal PC_new : STD_LOGIC_VECTOR(5 downto 0); 				-- New PC value. Used for writing into instruction buffer
	signal Opcode : STD_LOGIC_VECTOR(24 downto 0); 				-- Instruction value that is written into instruction buffer
	
	signal PC : STD_LOGIC_VECTOR(5 downto 0);		 			-- PC 
	signal Out_Instruct: STD_LOGIC_VECTOR(24 downto 0);			-- Instruction value that comes out of the instruction buffer
	signal In_RegFile: STD_LOGIC_VECTOR(24 downto 0);  			-- Instruction value that goes into Register File 
		 
	signal Out_RegFile_R1 : STD_LOGIC_VECTOR(127 downto 0);		-- rs1 value that comes out of the register file
	signal Out_RegFile_R2 : STD_LOGIC_VECTOR(127 downto 0);		-- rs2 "									   "
	signal Out_RegFile_R3 : STD_LOGIC_VECTOR(127 downto 0);		-- rs3 "									   "
	signal Out_RegFile_RSel1 : STD_LOGIC_VECTOR(4 downto 0); 	-- register 1 number out of 32 registers that comes out of register file
	signal Out_RegFile_RSel2 : STD_LOGIC_VECTOR(4 downto 0);    -- register 2 "														   "
	signal Out_RegFile_RSel3 : STD_LOGIC_VECTOR(4 downto 0);	-- register 3 "														   "
	signal Out_RegFile_RSelD : STD_LOGIC_VECTOR(4 downto 0);	-- register destination "											   "
	signal Out_RegFile_ALU_Ctrl :  STD_LOGIC_VECTOR(4 downto 0);-- Specify the operation that the Alu will perform, output of register file
		 
	signal In_ALU_R1 : STD_LOGIC_VECTOR(127 downto 0); 			-- Input of rs1 in ALU
	signal In_ALU_R2 : STD_LOGIC_VECTOR(127 downto 0);			-- "			" rs2 "	   "
	signal In_ALU_R3 : STD_LOGIC_VECTOR(127 downto 0);			-- "		    " rs3 "    "
	signal In_ALU_Ctrl : STD_LOGIC_VECTOR(4 downto 0);		    -- Input of the ALU. Specify the operation that the ALU will perform
	signal In_ALU_RDest : STD_LOGIC_VECTOR(4 downto 0);		    -- Input of the ALU. Specify the register number that will be written to
	 
	signal Out_ALU_RD : STD_LOGIC_VECTOR(127 downto 0);			-- Output of ALU. The output value(rd) of the ALU
	signal Out_ALU_RDest : STD_LOGIC_VECTOR(4 downto 0);		-- Output of ALU. Specify the register number that (rd) will be written to 
	signal Out_ALU_Valid : STD_LOGIC;							-- Output of ALU. Determines if the Output value of the ALU is a vaild result
		 
	signal Out_WB_Value : STD_LOGIC_VECTOR(127 downto 0);		-- Output of EX/WB Register. The value that is to be written back into the register file
	signal Out_WB_RDest : STD_LOGIC_VECTOR(4 downto 0);			-- Output of EX/WB Register. The register number for the value
	signal Out_WB_RWrite : STD_LOGIC; --Register Write Signal	   Output of EX/WB Register. Determines if the value should be written into the register file
		 
--	signal In_DataForward_R1_num : STD_LOGIC_VECTOR(4 downto 0);  
--	signal In_DataForward_R2_num : STD_LOGIC_VECTOR(4 downto 0);
--	signal In_DataForward_R3_num : STD_LOGIC_VECTOR(4 downto 0);
--	signal In_DataForward_Rd : STD_LOGIC_VECTOR(127 downto 0);
--	signal In_DataForward_Rd_num : STD_LOGIC_VECTOR(4 downto 0);	 
		 
	signal Out_DataForward_Rd	: STD_LOGIC_VECTOR(127 downto 0); -- Output of Data Forwarding. Value that will be forwarded
	signal Out_DataForward_MuxSel : STD_LOGIC_VECTOR(1 downto 0); -- Ouput of Data Forwarding. Specify which registers should be forwarded
	
	signal start_clk : STD_LOGIC := '0'; -- Determines the start time for the program
	signal end_clk : STD_LOGIC := '1';
	signal PERIOD : time := 50 ns;
	 
begin
	
	UUT: entity System port map
		(
		Clk => Clk,
		Rst => Rst,
		Set => Set,
		WriteMode => WriteMode,
		PC_new => PC_new,
		Opcode_in => Opcode,
		PC => PC,
		Out_Instruct => Out_Instruct,
		In_RegFile => In_RegFile,
		Out_RegFile_R1 => Out_RegFile_R1,
		Out_RegFile_R2 => Out_RegFile_R2,
		Out_RegFile_R3 => Out_RegFile_R3,
		Out_RegFile_RSel1 => Out_RegFile_RSel1,
		Out_RegFile_RSel2 => Out_RegFile_RSel2,
		Out_RegFile_RSel3 => Out_RegFile_RSel3,
		Out_RegFile_RSelD => Out_RegFile_RSelD,
		Out_RegFile_ALU_Ctrl => Out_RegFile_ALU_Ctrl,
		Out_DataForward_Rd => Out_DataForward_Rd,
		Out_DataForward_MuxSel => Out_DataForward_MuxSel,
		In_ALU_R1 => In_ALU_R1,
		In_ALU_R2 => In_ALU_R2,
		In_ALU_R3 => In_ALU_R3,
		In_ALU_Ctrl => In_ALU_Ctrl,
		In_ALU_RDest => In_ALU_RDest,
		Out_ALU_RD => Out_ALU_RD,
		Out_ALU_RDest => Out_ALU_RDest,
		Out_ALU_Valid => Out_ALU_Valid,
		Out_WB_Value => Out_WB_Value,
		Out_WB_RDest => Out_WB_RDest,
		Out_WB_RWrite => Out_WB_RWrite
		);
	
	clock:process
	begin 
		wait until start_clk = '1';  -- Start the clock once the instructions are all loaded
		for i in 0 to 63 loop
			Clk <= (not Clk) and (end_clk);
			wait for PERIOD/2;
		end loop;
		wait;
	end process;
	

	
	reading_file: process
	variable PC_counter : UNSIGNED(5 downto 0) := (others => '0');
	variable line_v : line;
    file read_file : text; 
	variable instruct_opcode: STD_LOGIC_VECTOR(24 downto 0);
	
	begin
		
		file_open(read_file, "Opcode.txt",  read_mode);
		
		WriteMode <= '1';
		Set <= '1';
		
		wait for PERIOD/4;
		
--		report "WriteMode: " & to_string(WriteMode);
		
		while not endfile(read_file) loop
			readline(read_file, line_v);
			read(line_v, instruct_opcode);
			
			PC_new <= STD_LOGIC_VECTOR(PC_counter);
			Opcode <= instruct_opcode;
			
			report "Line: " & to_string(instruct_opcode);
			report "PC : " & to_string(PC_counter);
			
			
			PC_counter := PC_counter + 1;
			
			wait for PERIOD/4;
			
		end loop;	
		
		WriteMode <= '0';
		PC_new <= "000000";
		
		wait for PERIOD/4;
		
		Set <= '0';
		
		wait for PERIOD/4;
		
		file_close(read_file); 
		
		start_clk <= '1';
		
		wait;
	end process;
	
	
	
	testing: process
	
	file write_file : text open write_mode is "Results.txt";
	variable line_v : line;
	variable count_down_to_end : integer := 3; 
	variable start_count_down : STD_LOGIC := '0';
	
	begin
		wait until start_clk = '1';
		
		while (count_down_to_end > 0) loop
			
			if (Out_Instruct = "1111110000000000000000000") then
				start_count_down := '1';
			end if;
			
			if(start_count_down = '1') then
			    count_down_to_end := count_down_to_end - 1;
			end if;
			
		--while not (Out_Instruct = "1111110000000000000000000")  loop
			write(line_v, string'("PC: "));
			write(line_v, PC);
			writeline(write_file, line_v);
			
			write(line_v, string'("Instruction: "));
			Hwrite(line_v, Out_Instruct);
			writeline(write_file, line_v);
			
			write(line_v, string'("Input into register File: "));
			Hwrite(line_v, In_RegFile);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of register File (rs1): "));
			Hwrite(line_v, Out_RegFile_R1);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of register File (rs2): "));
			Hwrite(line_v, Out_RegFile_R2);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of register File (rs3): "));
			Hwrite(line_v, Out_RegFile_R3);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of register File (Register 1 number): "));
			Hwrite(line_v, Out_RegFile_RSel1);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of register File (Register 2 number): "));
			Hwrite(line_v, Out_RegFile_RSel2);
			writeline(write_file, line_v);	
			
			write(line_v, string'("Output of register File (Register 3 number): "));
			Hwrite(line_v, Out_RegFile_RSel3);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of register File (Register destination number): "));
			Hwrite(line_v, Out_RegFile_RSelD);
			writeline(write_file, line_v); 
			
			write(line_v, string'("Output of register File (ALU Control number): "));
			Hwrite(line_v, Out_RegFile_ALU_Ctrl);
			writeline(write_file, line_v); 
			
			write(line_v, string'("Output of Data Forwarding Selector: "));
			Hwrite(line_v, Out_DataForward_MuxSel);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of Data Forwarding Value: "));
			Hwrite(line_v, Out_DataForward_Rd);
			writeline(write_file, line_v); 
			
			write(line_v, string'("Input of ALU (rs1): "));
			Hwrite(line_v, In_ALU_R1);
			writeline(write_file, line_v);
			
			write(line_v, string'("Input of ALU (rs2): "));
			Hwrite(line_v, In_ALU_R2);
			writeline(write_file, line_v);
			
			write(line_v, string'("Input of ALU (rs3): "));
			Hwrite(line_v, In_ALU_R3);
			writeline(write_file, line_v);
			
			write(line_v, string'("Input of ALU (ALU Control): "));
			Hwrite(line_v, In_ALU_Ctrl);
			writeline(write_file, line_v); 
			
			write(line_v, string'("Input of ALU (Rd destination): "));
			Hwrite(line_v, In_ALU_RDest);
			writeline(write_file, line_v);	 
			
			write(line_v, string'("Output of ALU (rd): "));
			Hwrite(line_v, Out_ALU_RD);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of ALU (rd destination): "));
			Hwrite(line_v, Out_ALU_RDest);
			writeline(write_file, line_v); 
			
			write(line_v, string'("Output of ALU (rd valid/WriteEnable for Register): "));
			write(line_v, Out_ALU_Valid);
			writeline(write_file, line_v); 
										------
			write(line_v, string'("Output of EX/WB Register (WriteData to RegisterFile): "));
			Hwrite(line_v, Out_WB_Value);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of EX/WB Register (Select Register to write): "));
			Hwrite(line_v, Out_WB_RDest);
			writeline(write_file, line_v);
			
			write(line_v, string'("Output of EX/WB Register (WriteEnable for RegisterFile): "));
			write(line_v, Out_WB_RWrite);
			writeline(write_file, line_v);
			
			
			write(line_v, string'(" "));
			writeline(write_file, line_v);
			
			wait for PERIOD;
		end loop;
		
		wait for PERIOD/4;
		
		end_clk <= '0';
		file_close(write_file);
	wait;
	end process;

end System_tb;
