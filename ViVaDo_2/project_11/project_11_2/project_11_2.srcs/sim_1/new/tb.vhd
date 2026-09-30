library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component stepper_motor_sss is
        Port ( reset, clk, run, direction : in STD_LOGIC;
               A, B, C, D : out STD_LOGIC);
    end component;
    constant clk_period: time:= 1 us;
    
    signal reset, clk, run, direction, A, B, C, D: std_logic;
begin
UUT: stepper_motor_sss Port map (reset => reset, clk => clk, run => run, direction => direction,
                                 A => A, B => B, C => C, D => D);

clk_process: process
    begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
    end process; --period of 100 ns

stepper_motor: process
begin
    reset <= '1';
    run <= '0';
    direction <= '0';
    wait for clk_period;
    
    reset <= '0';
    wait for 200 ns;
    --s1 path
    run <= '1'; direction <= '1'; wait for 2*clk_period;
    run <= '0'; direction <= '1'; wait for 2*clk_period;
    --s5 path
    run <= '1'; direction <= '0'; wait for 2*clk_period;
    run <= '0'; direction <= '0'; wait for 2*clk_period;
    
end process stepper_motor;

end Behavioral;
