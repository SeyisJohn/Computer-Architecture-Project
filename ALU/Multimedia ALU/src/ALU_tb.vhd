-------------------------------------------------------------------------------
--
-- Title       : ALU_tb
-- Design      : Multimedia ALU
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\ALU\Multimedia ALU\src\ALU_tb.vhd
-- Generated   : Mon Nov 23 23:45:10 2020
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
--{entity {ALU_tb} architecture {ALU_tb}}

library IEEE;
use IEEE.std_logic_1164.all;

use ieee.numeric_std.all;
library work;
use work.all;

entity ALU_tb is
end ALU_tb;

--}} End of automatically maintained section

architecture ALU_tb of ALU_tb is


	-- Stimulus signals
	signal rs1_in  : STD_LOGIC_VECTOR(127 downto 0);
	signal rs2_in : STD_LOGIC_VECTOR(127 downto 0);
	signal rs3_in : STD_LOGIC_VECTOR(127 downto 0);
	signal ALU_instruct : STD_LOGIC_VECTOR(4 downto 0);
	signal reg_des_in : STD_LOGIC_VECTOR(4 downto 0);

	-- Observed signals
	signal rd : STD_LOGIC_VECTOR(127 downto 0);
	signal reg_des_out : STD_LOGIC_VECTOR(4 downto 0); 
	signal valid : STD_LOGIC;  
	
	signal PERIOD : time := 200 ns;
	
begin

	UUT : entity ALU port map (
		rs1_in  => rs1_in ,
		rs2_in => rs2_in,
		rs3_in => rs3_in,
		ALU_instruct => ALU_instruct,
		reg_des_in => reg_des_in,
		rd => rd,
		valid => valid,
		reg_des_out => reg_des_out
		);
		
	
	instruct_loop: process
	begin
		wait for PERIOD/2;
		for i in 0 to 31 loop
			ALU_instruct <= STD_LOGIC_VECTOR(to_unsigned(i, 5)); 
			wait for PERIOD;
			
		end loop;
		wait;
	end process;
	
	
	testing: process
	begin
		
		for i in 0 to 31 loop
--			wait for PERIOD/2;
			if(ALU_instruct = "00000") then
				
				rs1_in  <= (31 downto 0 => X"7FFF_FFFF", others => '0');
				rs2_in <= (15 downto 0 => X"7FFF", others => '0');
				rs3_in <= (15 downto 0 => X"7FFF", others => '0');
				
				wait for PERIOD;		
				
				rs1_in  <= (31 downto 0 => X"8000_0000", others => '0');
				rs2_in <= (15 downto 0 => X"8000", others => '0');
				rs3_in <= (15 downto 0 => X"7FFF", others => '0');
				
--				wait for PERIOD;
				
			elsif (ALU_instruct = "00001") then
				
				rs1_in <= (31 downto 0 => X"7FFF_FFFF", others => '0');
				rs2_in <= (31 downto 16 => X"7FFF", others => '0');
				rs3_in <= (31 downto 16 => X"7FFF", others => '0');
				
				wait for PERIOD;
				
				rs1_in <= (31 downto 0 => X"8000_0000", others => '0');
				rs2_in <= (31 downto 16 => X"8000", others => '0');
				rs3_in <= (31 downto 16 => X"7FFF", others => '0');
				
--				wait for PERIOD;
				
			elsif (ALU_instruct = "00010") then

				rs1_in <= (31 downto 0 => X"8000_0001", others => '0');
				rs2_in <= (15 downto 0 => X"7FFF", others => '0');
				rs3_in <= (15 downto 0 => X"7FFF", others => '0');
				
				wait for PERIOD;
				
				rs1_in <= (31 downto 0 => X"7FFF_FFFF", others => '0');
				rs2_in <= (15 downto 0 => X"8000", others => '0');
				rs3_in <= (15 downto 0 => X"7FFF", others => '0');
				
--				wait for PERIOD; 
				
			elsif (ALU_instruct = "00011") then
				
				rs1_in <= (31 downto 0 => X"8000_0001", others => '0');
				rs2_in <= (31 downto 16 => X"7FFF", others => '0');
				rs3_in <= (31 downto 16 => X"7FFF", others => '0');
				
				wait for PERIOD;
				
				rs1_in <= (31 downto 0 => X"7FFF_FFFF", others => '0');
				rs2_in <= (31 downto 16 => X"8000", others => '0');
				rs3_in <= (31 downto 16 => X"7FFF", others => '0');
				
--				wait for PERIOD;
				
			elsif (ALU_instruct = "00100") then 
				
				rs1_in <= (63 downto 0 => X"7FFF_FFFF_FFFF_FFFF", others => '0');
				rs2_in <= (31 downto 0 => X"7FFF_FFFF", others => '0');
				rs3_in <= (31 downto 0 => X"7FFF_FFFF", others => '0');
				
				wait for PERIOD;
				
				rs1_in <= (63 downto 0 => X"8000_0000_0000_0000", others => '0');
				rs2_in <= (31 downto 0 => X"8000_0000", others => '0');
				rs3_in <= (31 downto 0 => X"7FFF_FFFF", others => '0'); 
				
--				wait for PERIOD;
				
			elsif (ALU_instruct = "00101") then
				
				rs1_in <= (63 downto 0 => X"7FFF_FFFF_FFFF_FFFF", others => '0');
				rs2_in <= (63 downto 32 => X"7FFF_FFFF", others => '0');
				rs3_in <= (63 downto 32 => X"7FFF_FFFF", others => '0');
				
				wait for PERIOD;
				
				rs1_in <= (63 downto 0 => X"8000_0000_0000_0000", others => '0');
				rs2_in <= (63 downto 32 => X"8000_0000", others => '0');
				rs3_in <= (63 downto 32 => X"7FFF_FFFF", others => '0'); 
				
--				wait for PERIOD;
				
			elsif (ALU_instruct = "00110") then 
				
				rs1_in <= (63 downto 0 => X"8000_0000_0000_0001", others => '0');
				rs2_in <= (31 downto 0 => X"7FFF_FFFF", others => '0');
				rs3_in <= (31 downto 0 => X"7FFF_FFFF", others => '0');
				
				wait for PERIOD;
				
				rs1_in <= (63 downto 0 => X"7FFF_FFFF_FFFF_FFFF", others => '0');
				rs2_in <= (31 downto 0 => X"8000_0000", others => '0');
				rs3_in <= (31 downto 0 => X"7FFF_FFFF", others => '0'); 
				
--				wait for PERIOD;
				
			elsif (ALU_instruct = "00111") then 
				
				rs1_in <= (63 downto 0 => X"8000_0000_0000_0001", others => '0');
				rs2_in <= (63 downto 32 => X"7FFF_FFFF", others => '0');
				rs3_in <= (63 downto 32 => X"7FFF_FFFF", others => '0');
				
				wait for PERIOD;
				
				rs1_in <= (63 downto 0 => X"7FFF_FFFF_FFFF_FFFF", others => '0');
				rs2_in <= (63 downto 32 => X"8000_0000", others => '0');
				rs3_in <= (63 downto 32 => X"7FFF_FFFF", others => '0'); 
				
--				wait for PERIOD; 	
			end if;
			
			WAIT for PERIOD;
			-- Every instruct onward are using the previous values as inputs
			
		end loop;
		
		wait;
	end process;
	

end ALU_tb;
