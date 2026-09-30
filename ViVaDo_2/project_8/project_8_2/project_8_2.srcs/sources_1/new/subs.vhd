library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity subs is
    Port ( a,b : in STD_LOGIC_VECTOR (3 downto 0);
           res_subs : out STD_LOGIC_VECTOR (4 downto 0));
end subs;

architecture Behavioral of subs is
begin
res_subs <= ((a(3) & a) - (b(3) & b));

end Behavioral;
