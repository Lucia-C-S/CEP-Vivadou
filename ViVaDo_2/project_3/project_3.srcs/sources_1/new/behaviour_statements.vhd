--HEADER
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ENTITY
entity behaviour_statements is --name of the entity
   port (a , b, c, d: in STD_LOGIC; --inputs of mu function -- A is the msb 
        Y: out STD_LOGIC);      -- outputs of my function
end behaviour_statements;

--ARCHITECTURE
architecture Behavioral of behaviour_statements is
    --declaration zone
    signal vector:STD_LOGIC_VECTOR(3 downto 0); --this way A remains as the MSB 
begin
   
    vector <= a&b&c&d; -- create a vector with scalar types, it cant be conmutative
                -- bc the more to the left, the more significant it is
          with vector select Y <= --we have not defined any process yet
            '1' when "0000",
            '1' when X"2",
            '1' when X"4" |  X"5" | X"6", -- we use the or symbol   
            '1' when X"9" |  X"A" | X"D"| X"F", -- we use the or symbol     
            '0' when others; --the rest of the truth table has output 0
 -------------------------------------------------------------------------------------
 process (vector) -- SENSITIVITY LIST: signal (array in this case (process(a,b,c,d))) 
 --for which we execute the process on each of the components (signals) when they change
 begin 
   case vector is 
    -- when-- allows us to use the OR operator/verical bar/ |
    when X"0" | X"2" | X"4" | X"5" => Y <= '1'; --whats next is the function assigned a one, => means "THEN"
    -- it also can mean the higher or equal for a boolean: if ( A => B) ....
    when X"6" => Y <= '1';
    when X"9" | X"A"| X"D"| X"F" => Y <= '1';
    when others => Y <= '0';
   end case;
end process;
-------------------------------------------------------------------------------------------
                
process (vector)
    begin
        if vector = X"0" then Y <= '1';
        elsif vector = X"2" then  Y <= '1';
        elsif vector = X"4" then  Y <= '1';
        elsif vector = X"5" then  Y <= '1';
        elsif vector = X"6" then  Y <= '1';
        elsif vector = X"9" then  Y <= '1';
        elsif vector = X"A" then  Y <= '1';
        elsif vector = X"D" then  Y <= '1';
        elsif vector = X"F" then  Y <= '1';
        else Y <= '0';
        end if;       
end process;   
-----------------------------------------------------------------------------------------
--proposed homework asssigntment is use when-else statement as well
  Y <=   '1' when vector = "0000" else --THOSE WHICH HAVE OUTPUT 1 IN THE TRUTH TABLE
         '1' when vector = X"2" else    -- X TO SAY ITS HEXADECIMAL, it is 1011 translated
         '1' when vector = X"4" else
         '1' when vector = X"5" else
         '1' when vector = X"6" else -- 14 in hexadecimal
         '1' when vector = X"9" else
         '1' when vector = X"A" else
         '1' when vector = X"D" else
         '1' when vector = X"F" else
         '0'; --the rest of the truth table has output 0
        end Behavioral;
