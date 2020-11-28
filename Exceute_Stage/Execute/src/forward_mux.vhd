-------------------------------------------------------------------------------
--
-- Title       : forward_mux
-- Design      : forward_mux
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\Forwarding_Mux\Forwarding_Mux\forward_mux\src\forward_mux.vhd
-- Generated   : Tue Nov 24 21:14:19 2020
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
--{entity {forward_mux} architecture {forward_mux}}

library IEEE;
use IEEE.std_logic_1164.all;

entity forward_mux is
	 port(
		 rs1_m : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2_m : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3_m : in STD_LOGIC_VECTOR(127 downto 0);
		 rs1_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs2_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs3_out : out STD_LOGIC_VECTOR(127 downto 0);
		 forward : in STD_LOGIC_VECTOR(1 downto 0);
		 WriteValue : in STD_LOGIC_VECTOR(127 downto 0);
		 instruct_in : in STD_LOGIC_VECTOR(4 downto 0);
		 instruct_out : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end forward_mux;

--}} End of automatically maintained section

architecture forward_mux of forward_mux is
begin

	process(rs1_m, rs2_m, rs3_m, forward)
	begin
		
		case forward is 
			when "00" =>
				rs1_out <= rs1_m;
				rs2_out <= rs2_m;
				rs3_out <= rs3_m;
				
			when "01" =>
				rs1_out <= WriteValue;
				rs2_out <= rs2_m;
				rs3_out <= rs3_m;
				
			when "10" =>			
				rs1_out <= rs1_m;
				rs2_out <= WriteValue;
				rs3_out <= rs3_m;
				
			when "11" => 
				rs1_out <= rs1_m;
				rs2_out <= rs2_m;
				rs3_out <= WriteValue;
			
			when others =>
				null;
		
		end case; 
	end process;
	
	instruct_out <= instruct_in;
		

end forward_mux;



