-------------------------------------------------------------------------------
--
-- Title       : data_forward_tb
-- Design      : Data_forward
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Data_Forwarding\Data_forward\src\data_forward_tb.vhd
-- Generated   : Mon Nov 30 12:49:43 2020
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
--{entity {data_forward_tb} architecture {data_forward_tb}}

library IEEE;
use IEEE.std_logic_1164.all;

use ieee.numeric_std.all;
library work;
use work.all;


entity data_forward_tb is
end data_forward_tb;

--}} End of automatically maintained section

architecture data_forward_tb of data_forward_tb is

	-- Stimulus signals
	signal valid_rs1 : STD_LOGIC;
	signal valid_rs2 : STD_LOGIC;
	signal valid_rs3 : STD_LOGIC;
	signal In_Value : STD_LOGIC_VECTOR(127 downto 0);
	signal In_reg_num : STD_LOGIC_VECTOR(4 downto 0);
	signal reg1_num : STD_LOGIC_VECTOR(4 downto 0);	
	signal reg2_num : STD_LOGIC_VECTOR(4 downto 0);
	signal reg3_num : STD_LOGIC_VECTOR(4 downto 0);
	signal valid : STD_LOGIC;
	
	
	-- Observed signals
	signal Out_Value : STD_LOGIC_VECTOR(127 downto 0);
	signal forward : STD_LOGIC_VECTOR(1 downto 0);
	
	signal PERIOD : time := 50 ns;

begin
	
	UUT : entity data_forward port map (
		valid_rs1 => valid_rs1,
		valid_rs2 => valid_rs2,
		valid_rs3 => valid_rs3,
		In_Value => In_Value,
		In_reg_num => In_reg_num,
		reg1_num => reg1_num,
		reg2_num => reg2_num,
		reg3_num => reg3_num,
		valid => valid,
		Out_Value => Out_Value,
		forward => forward
		);

	test: process
	variable vector : STD_LOGIC_VECTOR(127 downto 0);
	begin
		for i in 0 to 127 loop
			
			vector := STD_LOGIC_VECTOR(TO_UNSIGNED(i, 128));
			In_Value <= vector;
			In_reg_num <= vector(4 downto 0);
			reg1_num <= vector(4 downto 0);
			reg2_num <= vector(4 downto 0);
			reg3_num <= vector(4 downto 0);
			valid <= vector(4);
			valid_rs1 <= vector(3);
			valid_rs2 <= vector(2);
			valid_rs3 <= vector(1);
			
			WAIT FOR PERIOD;
		end loop;
		wait;
	end process;

end data_forward_tb;
