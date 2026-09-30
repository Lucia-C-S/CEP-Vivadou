--HEADER
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ENTITY
entity detection_digital_ones is --name of the entity
    port (d,c,b,a: in STD_LOGIC; --inputs of mu function
        F: out STD_LOGIC);      -- outputs of my function
    end;
    
--ARCHITECTURE
architecture Behavioral of detection_digital_ones is --architecture always related to a function
    signal inputs : STD_LOGIC_VECTOR (3 downto 0);     --doesnt matter UPPERCASE or lowercase

begin
    inputs <= d&c&b&a; -- create a vector with scalar types, it cant be conmutative
                -- bc the more to the left, the more significant is
    f <= '1' when inputs = "0111" else --THOSE WHICH HAVE OUTPUT 1 IN THE TRUTH TABLE
         '1' when inputs = X"B" else    -- X TO SAY ITS HEXADECIMAL, it is 1011 translated
         '1' when inputs = "1101" else
         '1' when inputs = "1110" else
         '1' when inputs = X"E" else -- 14 in hexadecimal
         '0'; --the rest of the truth table has output 0
end;
