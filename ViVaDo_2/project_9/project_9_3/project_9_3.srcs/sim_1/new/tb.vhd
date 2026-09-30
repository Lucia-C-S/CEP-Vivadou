library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
 component ctr_2_bits is
    Port ( reset, load, ce, clk : in STD_LOGIC;
           d: in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (1 downto 0);
           ceo, tc: out std_logic); 
 end component;
 
 signal treset, tload, tce, tclk, tceo, t_tc: std_logic;
 signal td, tq: std_logic_vector (1 downto 0);
 
 constant clk_period: time := 1 us;
begin
UUT: ctr_2_bits Port map (reset => treset, load => tload, ce => tce, clk => tclk,
                          d => td, q => tq, ceo => tceo, tc => t_tc);
                          
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
treset <= '1'; tce <= '0'; td <= "00"; tload <= '0'; wait for clk_period; --one clock cycle

treset <= '0'; wait for clk_period;

--check that with ce disbled output does not change
        -- CE disabled: output should NOT change
tce <= '0'; tload <= '0';
for i in 0 to 4 loop
    td <= std_logic_vector (to_unsigned(i, 2));
    wait for clk_period;
end loop;

--reset low & ce low & load high
        -- Load "10" in parallel
tload <= '1';
    td <= "10";
    wait for clk_period;

-- reset and load low & ce high 
        -- Apply 20 clock cycles to check that circuit behaves as described in truth table
tload <= '0'; tce <= '1'; td <= "00"; -- ce high
wait for 20*clk_period;

-- ce & reset high for 1 clock cycle
       -- deactivate remaining inputs low
treset <= '1';
wait for clk_period;

end process;
end Behavioral;
