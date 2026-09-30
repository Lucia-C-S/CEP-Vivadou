library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component number_detection_circuit is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
             f1, f2, f3 : out STD_LOGIC);
    end component;

    signal t_a: std_logic_vector(3 downto 0);
    signal t_f1,t_f2,t_f3: std_logic;
    
begin

    --INSTACIATION
    RES: number_detection_circuit port map (a=> t_a, f1=> t_f1,f2=> t_f2, f3=> t_f3);
                            
    --STIMULI
    process 
    begin
        -- El bucle FOR permite la simulacion Exahustiva.
        for i in 0 to 15 loop
            t_a<= std_logic_vector(TO_UNSIGNED(i,4));  
            wait for 1 us;
        end loop;
    end process;
      

end Behavioral;
