----------------------------------------------------------------------------------
-- Company: Universidad de Vigo
-- Engineer: Luis Jacobo Alvarez Ruiz de Ojeda
-- 
-- Create Date:    12:43:45 11/04/2009 
-- Module Name:   dec_bin_to_7_seg  - Behavioral 
-- Target Devices: all
-- Tool versions: all
-- Description: Decodificador de binario a 7 segmentos con salidas activas a nivel uno
-- El orden de los segmentos es A, B, C, D, E, F, G
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dec_bin_to_7_seg is
    Port ( en : in  STD_LOGIC;
           binary_inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seven_segment_outputs : out  STD_LOGIC_VECTOR (7 downto 0));
end dec_bin_to_7_seg;

architecture Behavioral of dec_bin_to_7_seg is

signal entradas_dec: std_logic_vector (4 downto 0);

begin

-- El orden de los segmentos es A, B, C, D, E, F, G, DP
	entradas_dec <= (en & binary_inputs);
		With entradas_dec select
		seven_segment_outputs   <=
						 "11111100" when "10000",   --0
						 "01100000" when "10001",   --1
						 "11011010" when "10010",	--2
						 "11110010" when "10011",	--3
						 "01100110" when "10100",	--4
						 "10110110" when "10101",	--5
						 "10111110" when "10110",	--6
						 "11100000" when "10111",	--7
						 "11111110" when "11000",	--8
						 "11110110" when "11001",	--9
						 "11101110" when "11010",	--A
						 "00111110" when "11011",	--b
						 "10011100" when "11100",	--C
						 "01111010" when "11101",	--d
						 "10011110" when "11110",	--E
						 "10001110" when "11111",	--F
						 "00000000" when others;	-- Todos los segmentos apagados

end Behavioral;

