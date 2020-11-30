	  --
-- Title       : IF_ID_reg_tb
-- Design      : IF_ID_reg_tb
-- Author      : Kevin Mathew
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\IF_ID_reg_tb\IF_ID_reg_tb\src\IF_ID_reg_tb.vhd
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

entity IF_ID_reg_tb is end IF_ID_reg_tb;
	
architecture IF_ID_reg_tb of IF_ID_reg_tb is 
-- Stimulated Signals
Signal Clk : STD_LOGIC := '0';
Signal rs1_id : STD_LOGIC_VECTOR(127 downto 0);
Signal rs2_id : STD_LOGIC_VECTOR(127 downto 0);
Signal rs3_id : STD_LOGIC_VECTOR(127 downto 0);
Signal rs1_num : STD_LOGIC_VECTOR(4 downto 0);
Signal rs2_num : STD_LOGIC_VECTOR(4 downto 0);
Signal rs3_num : STD_LOGIC_VECTOR(4 downto 0);	
Signal rd_num  : STD_LOGIC_VECTOR(4 downto 0);
Signal ALU_Ctrl: STD_LOGIC_VECTOR(4 downto 0);
Signal valid_rs1_in : STD_LOGIC;
Signal valid_rs2_in : STD_LOGIC;
Signal valid_rs3_in : STD_LOGIC;
-- Output Signals 		 
Signal rs1_out : STD_LOGIC_VECTOR(127 downto 0);
Signal rs2_out : STD_LOGIC_VECTOR(127 downto 0);
Signal rs3_out : STD_LOGIC_VECTOR(127 downto 0);
Signal rs1_num_out : STD_LOGIC_VECTOR(4 downto 0);
Signal rs2_num_out : STD_LOGIC_VECTOR(4 downto 0);
Signal rs3_num_out : STD_LOGIC_VECTOR(4 downto 0);	
Signal rd_num_out : STD_LOGIC_VECTOR(4 downto 0);
Signal ALU_Ctrl_out : STD_LOGIC_VECTOR(4 downto 0);
Signal valid_rs1_out : STD_LOGIC;	
Signal valid_rs2_out : STD_LOGIC;
Signal valid_rs3_out : STD_LOGIC;

begin 
	UUT: entity ID_EX_Reg port map(
		Clk => Clk,
		rs1_id	=> rs1_id,
		rs2_id => rs2_id,
  		rs3_id => rs3_id,
		rs1_num => rs1_num,
		rs2_num => rs2_num,
		rs3_num	=> rs3_num,	
		rd_num => rd_num,
		ALU_Ctrl => ALU_Ctrl,
		valid_rs1_in => valid_rs1_in,
		valid_rs2_in => valid_rs2_in,
		valid_rs3_in => valid_rs1_in,
		rs1_out => rs1_out,
		rs2_out => rs2_out,
		rs3_out => rs3_out,
		rs1_num_out => rs1_num_out,	
		rs2_num_out => rs2_num_out,
		rs3_num_out => rs3_num_out,
		rd_num_out => rd_num_out,
		ALU_Ctrl_out => ALU_Ctrl_out,
		valid_rs1_out => valid_rs1_out,  
		valid_rs2_out => valid_rs2_out,  
		valid_rs3_out => valid_rs3_out  	
		);
	
	test : process
	begin	
		wait for 200ns;
		rs1_id <= x"55555555555555555555555555555555"; 
		rs2_id <= x"cccccccccccccccccccccccccccccccc";
		rs3_id <= x"77777777777777777777777777777777";
		rs1_num <= "10001"; --Register 17
		rs2_num <= "11001";	--Register 25
		rs3_num <= "00111";	-- Register 7
		rd_num	<= "01000";	-- Register 8	 
		ALU_Ctrl <= "00000";
		valid_rs1_in <= '1';
		valid_rs2_in <= '1';
		valid_rs3_in <= '1';
		for i in 0 to 64 loop
			Clk <= not Clk;
			wait for 500ns;
		end loop;
		wait;
	end process;
	
end IF_ID_reg_tb;