library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_10bit_counter is
    Port (
        sel         : in  std_logic;
        hctr        : in  std_logic_vector(9 downto 0);
        vctr        : in  std_logic_vector(9 downto 0);
        counter_out : out std_logic_vector(9 downto 0)
    );
end mux_10bit_counter;

architecture Behavioral of mux_10bit_counter is
begin

    counter_out <= hctr when sel = '0' else vctr;

end Behavioral;