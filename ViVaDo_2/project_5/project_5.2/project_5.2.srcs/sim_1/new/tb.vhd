
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component decoder_1_to_8 is
        Port ( d : in STD_LOGIC_VECTOR (2 downto 0);
               q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal td: STD_LOGIC_VECTOR (2 downto 0);
    signal tq: STD_LOGIC_VECTOR (7 downto 0);
begin
    
    UUT: decoder_1_to_8 port map (d => td, q => tq); 
    
  process
        begin
            -- Bucle que se encargara de hacer las diferentes variaciones al vector d
            for i in 0 to 7 loop
                td <= STD_LOGIC_VECTOR(TO_UNSIGNED(i,3)); -- Convierto el valor I a un vector 000 que ira variando su valor
                wait for 1 us;
            end loop;
            
    end process;
  
end Behavioral;
