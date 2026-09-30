--HEADER
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--NECESSARY LINE FOR THE FOR LOOP
use IEEE.NUMERIC_STD.ALL;

entity tb is --self-contained entity
end tb;
-- ARCHITECTURE
architecture Behavioral of tb is
    component behaviour_statements 
        port (a , b, c, d: in STD_LOGIC; --inputs of mu function -- A is the msb 
        Y: out STD_LOGIC);      -- outputs of my function
    end component;
    
    signal Ta, Tb, Tc, Td : std_logic;
    signal  Tvector : STD_LOGIC_VECTOR (3 downto 0);
    signal  TY : std_logic;
     
begin
   -- Tvector <= Ta&Tb&Tc&Td; 
    UUT: behaviour_statements port map (a => Ta , b => Tb , c => Tc , d => Td , Y => TY);
    
    process
    begin  
        for i in 0 to 15 loop   
                    Tvector <= std_logic_vector (to_unsigned(i,4));
                    wait for 1 us;
                    end loop;
    end process;

    Ta <= Tvector(3); Tb <= Tvector(2); Tc <= Tvector(1); Td <= Tvector(0);

end Behavioral;
