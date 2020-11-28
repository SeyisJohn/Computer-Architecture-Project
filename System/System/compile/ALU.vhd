-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : System
-- Author      : Seyi Olajuyi
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\System\System\compile\ALU.vhd
-- Generated   : Fri Nov 27 11:03:53 2020
-- From        : C:\Users\Seyi Olajuyi\Documents\Courses\ESE345\Projec\System\System\..\ALU.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity ALU is
  port(
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       instruct : in STD_LOGIC_VECTOR(4 downto 0);
       reg_des_in : in STD_LOGIC_VECTOR(4 downto 0);
       rd : out STD_LOGIC_VECTOR(127 downto 0);
       valid : out STD_LOGIC := '0';
       reg_des_out : out STD_LOGIC_VECTOR(4 downto 0)
  );
end ALU;

architecture ALU of ALU is

---- Architecture declarations -----
function signed_int_multiply_add (multiplicand : STD_LOGIC_VECTOR(15 downto 0);multiplicator : STD_LOGIC_VECTOR(15 downto 0);add_value : STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is 
                       variable value : SIGNED(31 downto 0) := (others => '0');
                       variable product : SIGNED(31 downto 0) := (others => '0');
                     begin
                       product := SIGNED(multiplicand) * SIGNED(multiplicator);
                       value := product + SIGNED(add_value);
                       if (product > 0 and SIGNED(add_value) > 0 and value < product) then
                          value := X"7FFF_FFFF";
                       elsif (product < 0 and SIGNED(add_value) < 0 and value > product) then
                          value := X"8000_0000";
                       else 
                          null;
                       end if;
                       return STD_LOGIC_VECTOR(value);
                     end function signed_int_multiply_add;
function signed_int_multiply_subtract (multiplicand : STD_LOGIC_VECTOR(15 downto 0);multiplicator : STD_LOGIC_VECTOR(15 downto 0);add_value : STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is 
                       variable value : SIGNED(31 downto 0) := (others => '0');
                       variable product : SIGNED(31 downto 0) := (others => '0');
                     begin
                       product := SIGNED(multiplicand) * SIGNED(multiplicator);
                       value := product - SIGNED(add_value);
                       if (product > 0 and SIGNED(add_value) > 0 and value < product) then
                          value := X"7FFF_FFFF";
                       elsif (product < 0 and SIGNED(add_value) < 0 and value > product) then
                          value := X"8000_0000";
                       else 
                          null;
                       end if;
                       return STD_LOGIC_VECTOR(value);
                     end function signed_int_multiply_subtract;
function signed_long_multiply_add (multiplicand : STD_LOGIC_VECTOR(31 downto 0);multiplicator : STD_LOGIC_VECTOR(31 downto 0);add_value : STD_LOGIC_VECTOR(63 downto 0)) return STD_LOGIC_VECTOR is 
                       variable value : SIGNED(63 downto 0) := (others => '0');
                       variable product : SIGNED(63 downto 0) := (others => '0');
                     begin
                       product := SIGNED(multiplicand) * SIGNED(multiplicator);
                       value := product + SIGNED(add_value);
                       if (product > 0 and SIGNED(add_value) > 0 and value < product) then
                          value := X"7FFF_FFFF_FFFF_FFFF";
                       elsif (product < 0 and SIGNED(add_value) < 0 and value > product) then
                          value := X"8000_0000_0000_0000";
                       else 
                          null;
                       end if;
                       return STD_LOGIC_VECTOR(value);
                     end function signed_long_multiply_add;
function signed_long_multiply_subtract (multiplicand : STD_LOGIC_VECTOR(31 downto 0);multiplicator : STD_LOGIC_VECTOR(31 downto 0);add_value : STD_LOGIC_VECTOR(63 downto 0)) return STD_LOGIC_VECTOR is 
                       variable value : SIGNED(63 downto 0) := (others => '0');
                       variable product : SIGNED(63 downto 0) := (others => '0');
                     begin
                       product := SIGNED(multiplicand) * SIGNED(multiplicator);
                       value := product - SIGNED(add_value);
                       if (product > 0 and SIGNED(add_value) > 0 and value < product) then
                          value := X"7FFF_FFFF_FFFF_FFFF";
                       elsif (product < 0 and SIGNED(add_value) < 0 and value > product) then
                          value := X"8000_0000_0000_0000";
                       else 
                          null;
                       end if;
                       return STD_LOGIC_VECTOR(value);
                     end function signed_long_multiply_subtract;
function MAX (LEFT : STD_LOGIC_VECTOR(31 downto 0);RIGHT : STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is 
                     begin
                       if (SIGNED(LEFT) > SIGNED(RIGHT)) then
                          return LEFT;
                       else 
                          return RIGHT;
                       end if;
                     end function MAX;
function MIN (LEFT : STD_LOGIC_VECTOR(31 downto 0);RIGHT : STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is 
                     begin
                       if (SIGNED(LEFT) < SIGNED(RIGHT)) then
                          return LEFT;
                       else 
                          return RIGHT;
                       end if;
                     end function MIN;
function count_ones_words (input : STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is 
                       variable count : SIGNED(31 downto 0) := (others => '0');
                     begin
                       for i in 0 to 31 loop
                           if (input(i) = '1') then
                              count := count + 1;
                           else 
                              null;
                           end if;
                       end loop;
                       return STD_LOGIC_VECTOR(count);
                     end function count_ones_words;
function add_word_saturated (input1 : STD_LOGIC_VECTOR(15 downto 0);input2 : STD_LOGIC_VECTOR(15 downto 0)) return STD_LOGIC_VECTOR is 
                       variable result : SIGNED(15 downto 0);
                     begin
                       result := SIGNED(input1) + SIGNED(input2);
                       if SIGNED(input1) > 0 and SIGNED(input2) > 0 and (result < SIGNED(input1) or result < SIGNED(input2)) then
                          result := X"7FFF";
                       elsif (SIGNED(input1) < 0 and SIGNED(input2) < 0) and (result > SIGNED(input1) or result > SIGNED(input2)) then
                          result := X"8000";
                       else 
                          null;
                       end if;
                       return STD_LOGIC_VECTOR(result);
                     end function add_word_saturated;



begin

---- Processes ----

process (instruct,rs1,rs2,rs3)
                       begin
                         if (instruct = "00000") then
                            rd(31 downto 0) <= signed_int_multiply_add(rs3(15 downto 0),rs2(15 downto 0),rs1(31 downto 0));
                            valid <= '1';
                         elsif (instruct = "00001") then
                            rd(31 downto 0) <= signed_int_multiply_add(rs3(31 downto 16),rs2(31 downto 16),rs1(31 downto 0));
                            valid <= '1';
                         elsif (instruct = "00010") then
                            rd(31 downto 0) <= signed_int_multiply_subtract(rs3(15 downto 0),rs2(15 downto 0),rs1(31 downto 0));
                            valid <= '1';
                         elsif (instruct = "00011") then
                            rd(31 downto 0) <= signed_int_multiply_subtract(rs3(31 downto 16),rs2(31 downto 16),rs1(31 downto 0));
                            valid <= '1';
                         elsif (instruct = "00100") then
                            rd(63 downto 0) <= signed_long_multiply_add(rs3(31 downto 0),rs2(31 downto 0),rs1(63 downto 0));
                            valid <= '1';
                         elsif (instruct = "00101") then
                            rd(63 downto 0) <= signed_long_multiply_add(rs3(63 downto 32),rs2(63 downto 32),rs1(63 downto 0));
                            valid <= '1';
                         elsif (instruct = "00110") then
                            rd(63 downto 0) <= signed_long_multiply_add(rs3(31 downto 0),rs2(31 downto 0),rs1(63 downto 0));
                            valid <= '1';
                         elsif (instruct = "00111") then
                            rd(63 downto 0) <= signed_long_multiply_add(rs3(63 downto 32),rs2(63 downto 32),rs1(63 downto 0));
                            valid <= '1';
                         elsif (instruct = "01000") then
                            rd(31 downto 0) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(31 downto 0)) + UNSIGNED(rs2(31 downto 0)));
                            rd(63 downto 32) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(63 downto 32)) + UNSIGNED(rs2(63 downto 32)));
                            rd(95 downto 64) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(95 downto 64)) + UNSIGNED(rs2(95 downto 64)));
                            rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(127 downto 96)) + UNSIGNED(rs2(127 downto 96)));
                            valid <= '1';
                         elsif (instruct = "01001") then
                            for j in 0 to 15 loop
                                rd((7 + (8 * j)) downto (j * 8)) <= STD_LOGIC_VECTOR(abs (SIGNED(rs2((7 + (8 * j)) downto (j * 8))) - SIGNED(rs1((7 + (8 * j)) downto (j * 8)))));
                            end loop;
                            valid <= '1';
                         elsif (instruct = "01010") then
                            for k in 0 to 7 loop
                                rd((15 + (16 * k)) downto (16 * k)) <= STD_LOGIC_VECTOR(UNSIGNED(rs1((15 + (16 * k)) downto (16 * k))) + UNSIGNED(rs2((15 + (16 * k)) downto (16 * k))));
                            end loop;
                            valid <= '1';
                         elsif (instruct = "01011") then
                            for x in 0 to 7 loop
                                rd((15 + (16 * x)) downto (16 * x)) <= STD_LOGIC_VECTOR(SIGNED(rs1((15 + (16 * x)) downto (16 * x))) + SIGNED(rs2((15 + (16 * x)) downto (16 * x))));
                            end loop;
                            valid <= '1';
                         elsif (instruct = "01100") then
                            rd <= rs1 and rs2;
                            valid <= '1';
                         elsif (instruct = "01101") then
                            rd(31 downto 0) <= rs1(31 downto 0);
                            rd(63 downto 32) <= rs1(31 downto 0);
                            rd(95 downto 64) <= rs1(31 downto 0);
                            rd(127 downto 96) <= rs1(31 downto 0);
                            valid <= '1';
                         elsif (instruct = "01110") then
                            rd(31 downto 0) <= MAX(rs1(31 downto 0),rs2(31 downto 0));
                            rd(63 downto 32) <= MAX(rs1(63 downto 32),rs2(63 downto 32));
                            rd(95 downto 64) <= MAX(rs1(95 downto 64),rs2(95 downto 64));
                            rd(127 downto 96) <= MAX(rs1(127 downto 96),rs2(127 downto 96));
                            valid <= '1';
                         elsif (instruct = "01111") then
                            rd(31 downto 0) <= MIN(rs1(31 downto 0),rs2(31 downto 0));
                            rd(63 downto 32) <= MIN(rs1(63 downto 32),rs2(63 downto 32));
                            rd(95 downto 64) <= MIN(rs1(95 downto 64),rs2(95 downto 64));
                            rd(127 downto 96) <= MIN(rs1(127 downto 96),rs2(127 downto 96));
                            valid <= '1';
                         elsif (instruct = "10000") then
                            rd(31 downto 0) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(15 downto 0)) * UNSIGNED(rs2(15 downto 0)));
                            rd(63 downto 32) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(47 downto 32)) * UNSIGNED(rs2(47 downto 32)));
                            rd(95 downto 64) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(79 downto 64)) * UNSIGNED(rs2(79 downto 64)));
                            rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(111 downto 96)) * UNSIGNED(rs2(111 downto 96)));
                            valid <= '1';
                         elsif (instruct = "10001") then
                            rd(31 downto 0) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(15 downto 0)) * UNSIGNED(rs2(15 downto 0)));
                            rd(63 downto 32) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(47 downto 32)) * UNSIGNED(rs2(15 downto 0)));
                            rd(95 downto 64) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(79 downto 64)) * UNSIGNED(rs2(15 downto 0)));
                            rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs1(111 downto 96)) * UNSIGNED(rs2(15 downto 0)));
                            valid <= '1';
                         elsif (instruct = "10010") then
                            rd <= rs1 or rs2;
                            valid <= '1';
                         elsif (instruct = "10011") then
                            rd(31 downto 0) <= count_ones_words(rs1(31 downto 0));
                            rd(63 downto 32) <= count_ones_words(rs1(63 downto 32));
                            rd(95 downto 64) <= count_ones_words(rs1(95 downto 64));
                            rd(127 downto 96) <= count_ones_words(rs1(127 downto 96));
                            valid <= '1';
                         elsif (instruct = "10100") then
                            rd(31 downto 0) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1(31 downto 0)),to_integer(UNSIGNED(rs2(4 downto 0)))));
                            rd(63 downto 32) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1(63 downto 32)),to_integer(UNSIGNED(rs2(4 downto 0)))));
                            rd(95 downto 64) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1(95 downto 64)),to_integer(UNSIGNED(rs2(4 downto 0)))));
                            rd(127 downto 96) <= STD_LOGIC_VECTOR(rotate_right(UNSIGNED(rs1(127 downto 96)),to_integer(UNSIGNED(rs2(4 downto 0)))));
                            valid <= '1';
                         elsif (instruct = "10101") then
                            for y in 0 to 7 loop
                                rd((15 + (16 * y)) downto (16 * y)) <= STD_LOGIC_VECTOR(SIGNED(rs2((15 + (16 * y)) downto (16 * y))) - SIGNED(rs1((15 + (16 * y)) downto (16 * y))));
                            end loop;
                            valid <= '1';
                         elsif (instruct = "10110") then
                            rd(31 downto 0) <= STD_LOGIC_VECTOR(UNSIGNED(rs2(31 downto 0)) - UNSIGNED(rs1(31 downto 0)));
                            rd(63 downto 32) <= STD_LOGIC_VECTOR(UNSIGNED(rs2(63 downto 32)) - UNSIGNED(rs1(63 downto 32)));
                            rd(95 downto 64) <= STD_LOGIC_VECTOR(UNSIGNED(rs2(95 downto 64)) - UNSIGNED(rs1(95 downto 64)));
                            rd(127 downto 96) <= STD_LOGIC_VECTOR(UNSIGNED(rs2(127 downto 96)) - UNSIGNED(rs1(127 downto 96)));
                            valid <= '1';
                         elsif (instruct = "10111") then
                            if (rs3(3 downto 0) = X"0") then
                               rd(15 downto 0) <= rs2(15 downto 0);
                               rd(127 downto 16) <= rs1(127 downto 16);
                            elsif (rs3(3 downto 0) = X"1") then
                               rd(31 downto 16) <= rs2(15 downto 0);
                               rd(127 downto 32) <= rs1(127 downto 32);
                               rd(15 downto 0) <= rs1(15 downto 0);
                            elsif (rs3(3 downto 0) = X"2") then
                               rd(47 downto 32) <= rs2(15 downto 0);
                               rd(127 downto 48) <= rs1(127 downto 48);
                               rd(31 downto 0) <= rs1(31 downto 0);
                            elsif (rs3(3 downto 0) = X"3") then
                               rd(63 downto 48) <= rs2(15 downto 0);
                               rd(127 downto 64) <= rs1(127 downto 64);
                               rd(47 downto 0) <= rs1(47 downto 0);
                            elsif (rs3(3 downto 0) = X"4") then
                               rd(79 downto 64) <= rs2(15 downto 0);
                               rd(127 downto 80) <= rs1(127 downto 80);
                               rd(63 downto 0) <= rs1(63 downto 0);
                            elsif (rs3(3 downto 0) = X"5") then
                               rd(95 downto 80) <= rs2(15 downto 0);
                               rd(127 downto 96) <= rs1(127 downto 96);
                               rd(79 downto 0) <= rs1(79 downto 0);
                            elsif (rs3(3 downto 0) = X"6") then
                               rd(111 downto 96) <= rs2(15 downto 0);
                               rd(127 downto 112) <= rs1(127 downto 112);
                               rd(95 downto 0) <= rs1(95 downto 0);
                            elsif (rs3(3 downto 0) = X"7") then
                               rd(127 downto 112) <= rs2(15 downto 0);
                               rd(111 downto 0) <= rs1(111 downto 0);
                            else 
                               null;
                            end if;
                            valid <= '1';
                         else 
                            valid <= '0';
                         end if;
                       end process;
                      

---- User Signal Assignments ----
reg_des_out <= reg_des_in;

end ALU;
