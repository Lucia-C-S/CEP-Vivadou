library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
   component dynamic_display_controller is
       Port ( vis0_D, vis1_D, vis2_D, vis3_D : in STD_LOGIC_VECTOR (3 downto 0);
               clk, reset, dp0, dp1, dp2, dp3 : in STD_LOGIC;
               dp : out STD_LOGIC;
               an: out STD_LOGIC_VECTOR (3 downto 0);                -- Vector que maneja los leds de la pantalla.
               GFEDCBA : out STD_LOGIC_VECTOR (6 downto 0)           -- Salida del vector GFEDCBA
               );
    end component;
    signal S_vis0_D, S_vis1_D, S_vis2_D, S_vis3_D : STD_LOGIC_VECTOR (3 downto 0);
    signal t_clk, t_reset, t_dp0, t_dp1, t_dp2, t_dp3 : STD_LOGIC := '0';
    signal O_dp : STD_LOGIC;
    signal O_an : STD_LOGIC_VECTOR (3 downto 0);
    signal O_GFEDCBA : STD_LOGIC_VECTOR (6 downto 0);
    signal t_dp : std_logic_vector (3 downto 0) := "0000";
    constant clk_period : time := 1 us;
    

begin

    ETIQ: control_visualizador_dinamico PORT MAP (vis0_D => S_vis0_D,
                                                  vis1_D => S_vis1_D,
                                                  vis2_D => S_vis2_D,
                                                  vis3_D => S_vis3_D,
                                                  dp0 => t_dp0,
                                                  dp1 => t_dp1,
                                                  dp2 => t_dp2,
                                                  dp3 => t_dp3,
                                                  dp => O_dp,
                                                  an => O_an,
                                                  GFEDCBA => O_GFEDCBA,
                                                  clk => t_clk,
                                                  reset => t_reset);
    
    
    process
        begin
            t_clk <= '0';
            wait for clk_period/2;
            t_clk <= '1';
            wait for clk_period/2;
    end process;
    S_vis0_D <= "1000";
    S_vis1_D <= "0100";
    S_vis2_D <= "0010";
    S_vis3_D <= "0001";
    
    process
    begin
        t_reset <= '1';
        wait for clk_period;
        
        t_reset <= '0';
        wait for clk_period;
        
        for I in 0 to 16 loop
            t_dp <= STD_LOGIC_VECTOR(TO_UNSIGNED(I,4));
            t_dp0 <= t_dp(0);
            t_dp1 <= t_dp(1);
            t_dp2 <= t_dp(2);
            t_dp3 <= t_dp(3);
            wait for clk_period;
        end loop;
        
        assert(false) report "End simulation" severity FAILURE;
        wait;
    end process;

end Behavioral;

