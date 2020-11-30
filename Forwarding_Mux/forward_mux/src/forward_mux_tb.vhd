-------------------------------------------------------------------------------
--
-- Title       : forward_mux_tb
-- Design      : forward_mux
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Forwarding_Mux\forward_mux\src\forward_mux_tb.vhd
-- Generated   : Mon Nov 30 13:39:05 2020
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
--{entity {forward_mux_tb} architecture {forward_mux_tb}}


library IEEE;
use IEEE.std_logic_1164.all;

use ieee.numeric_std.all;
library work;
use work.all;

entity forward_mux_tb is
end forward_mux_tb;

--}} End of automatically maintained section

architecture forward_mux_tb of forward_mux_tb is

	-- Stumulus signals
	signal rs1_m : STD_LOGIC_VECTOR(127 downto 0);
	signal rs2_m : STD_LOGIC_VECTOR(127 downto 0);
	signal rs3_m : STD_LOGIC_VECTOR(127 downto 0); 
	signal forward : STD_LOGIC_VECTOR(1 downto 0);
	signal  WriteValue : STD_LOGIC_VECTOR(127 downto 0);
	signal ALU_instruct_in : STD_LOGIC_VECTOR(4 downto 0); 
	
	
	-- Observed signals
	signal rs1_out_m : STD_LOGIC_VECTOR(127 downto 0);
	signal rs2_out_m : STD_LOGIC_VECTOR(127 downto 0);
	signal rs3_out_m : STD_LOGIC_VECTOR(127 downto 0);
	signal ALU_instruct_out : STD_LOGIC_VECTOR(4 downto 0);
	
	signal PERIOD : time := 200 ns;

begin

	UUT: entity forward_mux port map (
		rs1_m => rs1_m,
		rs2_m => rs2_m,
		rs3_m => rs3_m,
		forward => forward,
		WriteValue => WriteValue,
		ALU_instruct_in => ALU_instruct_in,
		rs1_out_m => rs1_out_m,
		rs2_out_m => rs2_out_m,
		rs3_out_m => rs3_out_m,
		ALU_instruct_out => ALU_instruct_out
		);
		
		
		testing: process
		variable vector : STD_LOGIC_VECTOR(127 downto 0);
		begin
			
			for i in 0 to 127 loop
				vector := STD_LOGIC_VECTOR(TO_UNSIGNED(i, 128));
				ALU_instruct_in <= vector(4 downto 0);
				WriteValue <= vector;
				forward <= vector(1 downto 0);
				
				WAIT FOR PERIOD;
			end loop;
			wait;
		end process;
		
		
		input1: process
		begin
			for j in 0 to 127 loop
				rs1_m <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 128));
				WAIT FOR PERIOD/2;
			end loop;
			wait;
		end process; 
		
		
		input2: process
		begin
			for j in 0 to 127 loop
				rs2_m <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 128));
				WAIT FOR PERIOD/4;
			end loop;
			wait;
		end process; 
		
		
		input3: process
		begin
			for j in 0 to 127 loop
				rs3_m <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 128));
				WAIT FOR PERIOD/8;
			end loop;
			wait;
		end process;
		
		

end forward_mux_tb;
