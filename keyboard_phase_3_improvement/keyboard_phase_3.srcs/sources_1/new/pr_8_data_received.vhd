library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pr_8_data_received is
    Port (
        clk           : in  STD_LOGIC;
        reset         : in  STD_LOGIC;
        load_data     : in  STD_LOGIC;
        arriving_bits : in  STD_LOGIC_VECTOR(10 downto 0);
        
        data_received : out STD_LOGIC_VECTOR(7 downto 0)
    );
end pr_8_data_received;

architecture Behavioral of pr_8_data_received is

    signal data_reg : STD_LOGIC_VECTOR(7 downto 0);

begin

    process(clk, reset)
    begin
        if reset = '1' then
            data_reg <= (others => '0');

        elsif rising_edge(clk) then
            if load_data = '1' then
                data_reg <= arriving_bits(8 downto 1);
            end if;
        end if;
    end process;

    data_received <= data_reg;

end Behavioral;