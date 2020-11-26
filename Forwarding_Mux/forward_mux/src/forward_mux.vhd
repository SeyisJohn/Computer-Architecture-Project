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
		 rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs1_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs2_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs3_out : out STD_LOGIC_VECTOR(127 downto 0);
		 WriteMode : in STD_LOGIC_VECTOR(1 downto 0);
		 WriteValue : in STD_LOGIC_VECTOR(127 downto 0)
	     );
end forward_mux;

--}} End of automatically maintained section

architecture forward_mux of forward_mux is
begin

	process(rs1, rs2, rs3, WriteMode)
	begin
		
		case WriteMode is 
			when "00" =>
				rs1_out <= rs1;
				rs2_out <= rs2;
				rs3_out <= rs3;
				
			when "01" =>
				rs1_out <= WriteValue;
				rs2_out <= rs2;
				rs3_out <= rs3;
				
			when "10" =>			
				rs1_out <= rs1;
				rs2_out <= WriteValue;
				rs3_out <= rs3;
				
			when "11" => 
				rs1_out <= rs1;
				rs2_out <= rs2;
				rs3_out <= WriteValue;
			
			when others =>
				null;
		
		end case; 
	end process;		
		

end forward_mux;
