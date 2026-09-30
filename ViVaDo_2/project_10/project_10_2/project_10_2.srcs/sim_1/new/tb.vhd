library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

component dynamic_display_partial_controller is
    Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);     --entrada del mux y del decoder
           vis0_D, vis1_D, vis2_D, vis3_D : in STD_LOGIC_VECTOR (3 downto 0); --entrada del mux
           dp_in: std_logic;                           -- entrada del circuito logico
           dp: out std_logic;                          -- salida de punto decimal
           an: out std_logic_vector(3 downto 0);       -- salida de vector que maneja os leds de pantalla
           abcdefg : out STD_LOGIC_VECTOR (6 downto 0)); -- Salida del vector ABCDEFG
end component;

signal S_sel : STD_LOGIC_VECTOR (1 downto 0);
signal S_vis0_D, S_vis1_D, S_vis2_D, S_vis3_D : STD_LOGIC_VECTOR (3 downto 0);
signal S_dp_in : STD_LOGIC;
signal O_dp : STD_LOGIC;
signal O_an : STD_LOGIC_VECTOR (3 downto 0);
signal O_abcdefg : STD_LOGIC_VECTOR (6 downto 0);

begin

ETIQ: dynamic_display_partial_controller PORT MAP (sel => S_sel,
                                                      vis0_D => S_vis0_D,
                                                      vis1_D => S_vis1_D,
                                                      vis2_D => S_vis2_D,
                                                      vis3_D => S_vis3_D,
                                                      dp_in => S_dp_in,
                                                      dp => O_dp,
                                                      an => O_an,
                                                      abcdefg => O_abcdefg
                                                      );

process
    begin
        -- CASO 1
            S_sel <= "00";
            
            S_vis0_D <= "0101"; -- Valor 5
            S_vis1_D <= "0000"; -- Valor 0
            S_vis2_D <= "0000"; -- Valor 0
            S_vis3_D <= "0000"; -- Valor 0
            
            S_dp_in <= '0';
            wait for 1 us;
            
            S_vis0_D <= "0110"; -- Valor 6
            S_dp_in <= '1';
            wait for 1 us;
        
        -- CASO 2
            S_sel <= "01";
            
            S_vis1_D <= "0011"; -- Valor 3
            S_dp_in <= '0';
            wait for 1 us;
            
            S_vis1_D <= "0100"; -- Valor 4
            S_dp_in <= '1';
            wait for 1 us;
    
        -- CASO 3
            S_sel <= "10";
            
            S_vis2_D <= "1100"; -- Valor 12 - C
            S_dp_in <= '0';
            wait for 1 us;
            
            S_vis2_D <= "1010"; -- Valor 10 - A 
            S_dp_in <= '1';
            wait for 1 us; 
    
        -- CASO 4
            S_sel <= "11";
            
            S_vis3_D <= "0000"; -- Valor 0
            S_dp_in <= '0';
            wait for 1 us;
            
            S_vis3_D <= "1111"; -- Valor F
            S_dp_in <= '1';
            wait for 1 us; 
                        
            wait; -- Proceso dormido
            
    end process;

end Behavioral;
