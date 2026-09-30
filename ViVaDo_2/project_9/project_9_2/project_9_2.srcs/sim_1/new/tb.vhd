library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
 component register_4_bits is
    Port ( reset, ce, clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (3 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal tres, tce, tclk: std_logic;
signal td, tQ: std_logic_vector (3 downto 0);

constant clk_period: time := 1 us;

begin

UUT: register_4_bits Port map (reset => tres, ce => tce, d => td, clk => tclk, q => tQ);

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
tres <= '1'; tce <= '0'; td <= "0000"; wait for clk_period; --one clock cycle

tres <= '0'; wait for 200 ns;

--check that with ce disbled output does not change
        -- CE disabled: output should NOT change
tce <= '0';
for i in 0 to 15 loop
    td <= std_logic_vector (to_unsigned(i, 4));
    wait for clk_period;
end loop;

--reset low & ce high
        -- Enable CE and test all JK combinations
tce <= '1';
for i in 0 to 15 loop
    td <= std_logic_vector (to_unsigned(i, 4));
    wait for clk_period;
end loop;

--ce high & active high reset
        -- Active reset again
td <= "0000"; tce <= '1'; --disable all
tres <= '1'; wait for 5*clk_period;


end process;
end Behavioral;