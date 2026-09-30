library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity signed_multiplier_4_bits is
    Port ( a, b: in STD_LOGIC_VECTOR (3 downto 0);
           product : out STD_LOGIC_VECTOR (7 downto 0));
end signed_multiplier_4_bits;

architecture Behavioral of signed_multiplier_4_bits is
begin
    product <= (a * b);
end Behavioral;
