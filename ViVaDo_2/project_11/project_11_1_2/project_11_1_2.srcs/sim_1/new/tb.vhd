library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    component  right_shift_register_8_bits is
        Port ( clk, reset, load, msb_in, shift_enable : in STD_LOGIC;
               data_in : in STD_LOGIC_VECTOR (7 downto 0);
               lsb_out : out STD_LOGIC;
               q_shift : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal clk, reset, load, msb_in, shift_enable : STD_LOGIC;
    signal data_in : STD_LOGIC_VECTOR (7 downto 0);
    signal lsb_out : STD_LOGIC;
    signal q_shift : STD_LOGIC_VECTOR (7 downto 0);
    
    constant clk_period: time := 1 us;

begin

UUT: right_shift_register_8_bits Port map (clk => clk, reset => reset, load => load,
                                           msb_in => msb_in, shift_enable => shift_enable,
                                           data_in => data_in, lsb_out => lsb_out, q_shift => q_shift);
    clk_process: process
    begin   
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
    end process; --period of 100 ns


    right_shift_reg: process
    begin
        load <= '0'; 
        msb_in <= '0';
        shift_enable <= '0';
        data_in <= "00000000";
        reset <= '1'; wait for clk_period;
        
        reset <= '0'; wait for 200 ns;
        
        shift_enable <= '0'; load <= '0'; wait for 5*clk_period;
        
        load <= '1'; data_in <= "10101010"; wait for clk_period;
        
        load <= '0'; shift_enable <= '1'; msb_in <= '0'; wait for 10*clk_period;
        load <= '0'; shift_enable <= '1'; msb_in <= '1'; wait for 10*clk_period;
        
        shift_enable <= '0'; msb_in <= '0'; reset <= '1'; data_in <= "00000000"; wait for clk_period;
    
end process;
end Behavioral;
