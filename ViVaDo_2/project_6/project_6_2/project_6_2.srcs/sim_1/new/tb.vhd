library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component mux_1_bit_4_channel is
     Port ( d : in STD_LOGIC_VECTOR (3 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0);
           G : in STD_LOGIC;
           Q : out STD_LOGIC);
    end component;
    
    signal t_d: std_logic_vector (3 downto 0);
    signal t_s: std_logic_vector (1 downto 0);
    signal t_G, t_Q: STD_LOGIC;
begin
    UUT: mux_1_bit_4_channel port map (d => t_d, s => t_s, G => t_G, Q => t_Q);
    
    process
    
     begin
        t_G <= '0';
        for i in 0 to 4 loop
            t_s <= std_logic_vector(to_unsigned(i, 2));
            
            for j in 0 to 15 loop
                t_d <= std_logic_vector(to_unsigned (j, 4));
                wait for 10 us;
            end loop;
        end loop;
        
        t_G <= '1';
        for i in 0 to 4 loop
            t_s <= std_logic_vector(to_unsigned(i, 2));
            
            for j in 0 to 15 loop
                t_d <= std_logic_vector(to_unsigned (j, 4));
                wait for 10 us;
            end loop;
        end loop;     
            
    end process;

end Behavioral;
