library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity twos_comp is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           res_twos : out STD_LOGIC_VECTOR (4 downto 0));
end twos_comp;

architecture Behavioral of twos_comp is
begin
-- Sign extension of the 4-bit input to 8 bits

    -- Two's complement
    res_twos <= - (a(3) & a);
end Behavioral;
