library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
 end tb;

architecture Behavioral of tb is
component decoder_1_to_4 is
    Port ( G: in std_logic;
           d : in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end component;
        
       signal tg : std_logic;
       signal td : STD_LOGIC_VECTOR (1 downto 0);
       signal tq :  STD_LOGIC_VECTOR (3 downto 0);
begin
    UUT : decoder_1_to_4 port map (G => tg, d => td , q => tq);
    
        
    process
    begin
        -- El bucle FOR permite la simulacion Exahustiva.
        for i in 0 to 3 loop
            tg <= '0';
            td <= std_logic_vector(TO_UNSIGNED(i,2));  
            wait for 1 us;
        end loop;
    
        -- El bucle FOR permite la simulacion Exahustiva.
        for i in 0 to 3 loop
            tg <= '1'; 

            td <= std_logic_vector(TO_UNSIGNED(i,2));  
            wait for 1 us;
        end loop;
    end process;

end Behavioral;
