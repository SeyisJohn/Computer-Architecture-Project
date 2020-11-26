-------------------------------------------------------------------------------
--
-- Title       : Execute
-- Design      : Execute
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Exceute_Stage\Execute\src\Execute.vhd
-- Generated   : Thu Nov 26 12:27:04 2020
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
--{entity {Execute} architecture {structural}}

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;


entity Execute is
	port (
		 rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3 : in STD_LOGIC_VECTOR(127 downto 0);
		 WriteMode : in STD_LOGIC_VECTOR(1 downto 0);
		 WriteValue : in STD_LOGIC_VECTOR(127 downto 0);
		 instruct : in STD_LOGIC_VECTOR(4 downto 0);
		 reg_des_in : in STD_LOGIC_VECTOR(4 downto 0);
		 Output : out STD_LOGIC_VECTOR(127 downto 0);
		 reg_des_out : out STD_LOGIC_VECTOR(4 downto 0);
		 valid : out STD_LOGIC
		 );
end Execute;

--}} End of automatically maintained section

architecture structural of Execute is

signal rs1_out : STD_LOGIC_VECTOR(127 downto 0);
signal rs2_out : STD_LOGIC_VECTOR(127 downto 0);
signal rs3_out : STD_LOGIC_VECTOR(127 downto 0);

begin

	forward_mux: entity forward_mux port map
		  (
		  rs1 => rs1,
		  rs2 => rs2,
		  rs3 => rs3,
		  WriteMode => WriteMode,
		  WriteValue => WriteValue,
		  rs1_out => rs1_out,
		  rs2_out => rs2_out,
		  rs3_out => rs3_out
		  );
		  
	Alu: entity ALU port map
		(
		rs1 => SIGNED(rs1_out),
		rs2 => SIGNED(rs2_out),
		rs3 => SIGNED(rs3_out),
		instruct => instruct,
		reg_des_in => reg_des_in, 
		STD_LOGIC_VECTOR(rd) => Output,
		reg_des_out => reg_des_out,
		valid => valid
		);
		  

end structural;
