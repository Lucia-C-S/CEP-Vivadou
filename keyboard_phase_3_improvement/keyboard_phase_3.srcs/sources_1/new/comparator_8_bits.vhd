------------------------------------------------------------------
-- comparator_8_bits.vhd -- file description
-- 8 bits magnitude and identity comparator
------------------------------------------------------------------
-- Luis Jacobo Alvarez Ruiz de Ojeda
-- Dpto. Tecnologia Electronica
-- University of Vigo
-- 9, May, 2006 
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comparator_8_bits is
    Port ( a : in std_logic_vector(7 downto 0);
           b : in std_logic_vector(7 downto 0);
			  a_eq_b : out std_logic; -- a equal to b
           a_gt_b : out std_logic; -- a greater than b
           a_lt_b : out std_logic -- a less than b
			  );
end comparator_8_bits;

architecture Behavioral of comparator_8_bits is

begin

a_eq_b <= '1' when a = b else '0';
a_gt_b <= '1' when a > b else '0';
a_lt_b <= '1' when a < b else '0';

-- If you need the three comparator outputs, the resultant circuit is simplified
-- if you obtain the third signal from the other two, as follows:
-- a_lt_b <= not a_eq_b_aux and not a_gt_b_aux;
-- It uses 4 "slices" less than the original circuit, in an XC2S200E-PQ208-6 FPGA, but the third output
-- has an additional delay of 2'5 ns
-- You must also define the new signals "a_eq_b_aux" and "a_gt_b_aux" to use them in the equation

end Behavioral;
