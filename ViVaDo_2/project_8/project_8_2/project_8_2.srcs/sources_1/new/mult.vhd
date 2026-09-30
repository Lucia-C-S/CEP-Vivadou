library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity mult is
    Port ( a,b : in STD_LOGIC_VECTOR (3 downto 0);
           res_mult : out STD_LOGIC_VECTOR (7 downto 0));
end mult;

architecture Behavioral of mult is

begin
res_mult <= (a * b);

end Behavioral;
