library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
 component JK_flipflop is
    Port ( reset, ce, J, K, clk : in STD_LOGIC;
           Q : out STD_LOGIC);
end component;

signal tres, tce, tJ, tK, tclk, tQ: std_logic;

constant clk_period: time := 1 us;

begin

UUT: JK_flipflop Port map (reset => tres, ce => tce, J => tJ, K => tK, clk => tclk, Q => tQ);

clk_process: process
begin   
        tclk <= '0';
        wait for clk_period/2;
        tclk <= '1';
        wait for clk_period/2;
end process; --period of 100 ns

tb_process: process
begin
        -- Initial reset (asynchronous)
tres <= '1'; tce <= '0'; tJ<= '0'; tK <= '0'; wait for clk_period; --one clock cycle

tres <= '0'; wait for 200 ns;

--check that with ce disbled output does not change
        -- CE disabled: output should NOT change
tJ <= '1'; wait for clk_period;
tK <= '1'; wait for clk_period;
tJ <= '0'; wait for clk_period;
tK <= '0';

--reset low & ce high
        -- Enable CE and test all JK combinations
tce <= '1';
tJ <= '1'; tK <= '0'; wait for 3*clk_period;
tJ <= '0'; tK <= '0'; wait for 3*clk_period;
tJ <= '0'; tK <= '1'; wait for 3*clk_period;
tJ <= '1'; tK <= '1'; wait for 3*clk_period;

--ce high & active high reset
        -- Active reset again
tJ <= '0'; tK <= '0'; tce <= '1'; --disable all
tres <= '1'; wait for clk_period;


end process;
end Behavioral;
