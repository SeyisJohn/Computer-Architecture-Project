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
	signal rs1 : SIGNED(127 downto 0) := (others => '0');
	signal rs2 : SIGNED(127 downto 0) := (others => '0');
	signal rs3 : SIGNED(127 downto 0) := (others => '0');
	signal instruct : STD_LOGIC_VECTOR(4 downto 0) := (others => '1');
	
	-- Observed signals
	signal rd : SIGNED(127 downto 0);
	
	
	-- Temporary signals
	
begin

	UUT : entity ALU port map (
		rs1 => rs1,
		rs2 => rs2,
		rs3 => rs3,
		instruct => instruct,
		rd => rd
		);
		
		
	-- Testing each instruction in ALU
	
	instruct_loop: process
	begin
		for i in 0 to 31 loop
			instruct <= STD_LOGIC_VECTOR(to_unsigned(i, 5)); 
			wait for 200 ns;
			
		end loop;
		wait;
	end process;
	
	
	-- Does not currently work
	testing: process(instruct)
	begin
		if(instruct = "00000") then
			
			rs1(31 downto 0) <= X"7FFF_FFFF";
			rs2(15 downto 0) <= X"7FFF";
			rs3(15 downto 0) <= X"7FFF";
			assert (rd(31 downto 0) = X"7FFF_FFFF") report "Upper limit incorrect " & integer'image(to_integer(signed(rd))) severity error;		
			
			rs1(31 downto 0) <= X"8000_0000";
			rs2(15 downto 0) <= X"8000";
			rs3(15 downto 0) <= X"7FFF";
			assert (rd(31 downto 0) = X"8000_0000") report "Lower limit incorrect" severity error;
			
		elsif (instruct = "00001") then
			
			rs1(31 downto 0) <= X"7FFF_FFFF";
			rs2(31 downto 16) <= X"7FFF";
			rs3(31 downto 16) <= X"7FFF";
			assert (rd(31 downto 0) = X"7FFF_FFFF") report "Upper limit incorrect" severity error;
			
			
			rs1(31 downto 0) <= X"8000_0000";
			rs2(31 downto 16) <= X"8000";
			rs3(31 downto 16) <= X"7FFF";
			assert (rd(31 downto 0) = X"8000_0000") report "Lower limit incorrect" severity error;
			
		elsif (instruct = "00010") then

			rs1(31 downto 0) <= X"8000_0001";
			rs2(15 downto 0) <= X"7FFF";
			rs3(15 downto 0) <= X"7FFF";
			assert (rd(31 downto 0) = X"7FFF_FFFF") report "Upper limit incorrect" severity error;
			
			
			rs1(31 downto 0) <= X"7FFF_FFFF";
			rs2(15 downto 0) <= X"8000";
			rs3(15 downto 0) <= X"7FFF";
			assert (rd(31 downto 0) = X"8000_0000") report "Lower limit incorrect" severity error;
			
		elsif (instruct = "00011") then
			
			rs1(31 downto 0) <= X"8000_0001";
			rs2(31 downto 16) <= X"7FFF";
			rs3(31 downto 16) <= X"7FFF";
			assert (rd(31 downto 0) = X"7FFF_FFFF") report "Upper limit incorrect" severity error;
			
			
			rs1(31 downto 0) <= X"7FFF_FFFF";
			rs2(31 downto 16) <= X"8000";
			rs3(31 downto 16) <= X"7FFF";
			assert (rd(31 downto 0) = X"8000_0000") report "Lower limit incorrect" severity error;
			
		elsif (instruct = "00100") then 
			
			rs1(63 downto 0) <= X"7FFF_FFFF_FFFF_FFFF";
			rs2(31 downto 0) <= X"7FFF_FFFF";
			rs3(31 downto 0) <= X"7FFF_FFFF";
			assert (rd(63 downto 0) = X"7FFF_FFFF_FFFF_FFFF") report "Upper limit incorrect" severity error;
			
			rs1(63 downto 0) <= X"8000_0000_0000_0000";
			rs2(31 downto 0) <= X"8000_0000";
			rs3(31 downto 0) <= X"7FFF_FFFF";
			assert (rd(31 downto 0) = X"8000_0000_0000_0000") report "Lower limit incorrect" severity error;
		end if;
		
	end process;
	

end ALU_tb;
