library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and2 is
    Port ( a, b: in STD_LOGIC_VECTOR (3 downto 0);
           res_and : out STD_LOGIC_VECTOR (3 downto 0));
end and2;

architecture Behavioral of and2 is
    
begin
    res_and <= (a and b);
end Behavioral;
