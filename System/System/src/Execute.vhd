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
		 reg1 : in STD_LOGIC_VECTOR(127 downto 0);
		 reg2 : in STD_LOGIC_VECTOR(127 downto 0);
		 reg3 : in STD_LOGIC_VECTOR(127 downto 0);
		 forward : in STD_LOGIC_VECTOR(1 downto 0);
		 WriteValue : in STD_LOGIC_VECTOR(127 downto 0);
		 instruct : in STD_LOGIC_VECTOR(4 downto 0);
		 reg_des_in : in STD_LOGIC_VECTOR(4 downto 0);
		 rd_value : out STD_LOGIC_VECTOR(127 downto 0);
		 reg_des_out : out STD_LOGIC_VECTOR(4 downto 0);
		 valid : out STD_LOGIC
		 );
end Execute;

--}} End of automatically maintained section

architecture structural of Execute is

signal rs1_connect : STD_LOGIC_VECTOR(127 downto 0);
signal rs2_connect : STD_LOGIC_VECTOR(127 downto 0);
signal rs3_connect : STD_LOGIC_VECTOR(127 downto 0);
signal instruct_t : STD_LOGIC_VECTOR(4 downto 0);

begin

	forward_mux: entity forward_mux port map
		  (
		  rs1_m => reg1,
		  rs2_m => reg2,
		  rs3_m => reg3,
		  forward => forward,
		  WriteValue => WriteValue,
		  rs1_out => rs1_connect,
		  rs2_out => rs2_connect,
		  rs3_out => rs3_connect,
		  instruct_in => instruct,
		  instruct_out => instruct_t
		  );
		  
	Alu: entity ALU port map
		(
		rs1 => rs1_connect,
		rs2 => rs2_connect,
		rs3 => rs3_connect,
		instruct => instruct_t,
		reg_des_in => reg_des_in, 
		rd => rd_value,
		reg_des_out => reg_des_out,
		valid => valid
		);
		  

end structural;
