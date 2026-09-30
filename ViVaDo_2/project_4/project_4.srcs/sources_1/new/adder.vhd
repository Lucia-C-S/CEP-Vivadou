-- HEADER
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
    port (a, b: in std_logic_vector(1 downto 0) ; --a is the MSB 
    Y:out std_logic_vector (2 downto 0)  ); 
end adder;

--ARCHITECTURE
architecture Behavioral of adder is
    --declaration zone
    signal vector:STD_LOGIC_VECTOR(2 downto 0); --this way A remains as the MSB 
begin
   
    vector <= a&b; -- create a vector with scalar types, it cant be conmutative
                -- bc the more to the left, the more significant it is
          with vector select Y <= --we have not defined any process yet
            '1' when "0000",

end Behavioral;
