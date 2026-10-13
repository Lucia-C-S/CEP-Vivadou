library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_10_bits_hposition_object_2 is
    Port (
        ce    : in  STD_LOGIC;
        clk   : in  STD_LOGIC;
        d     : in  STD_LOGIC_VECTOR(9 downto 0);
        reset : in  STD_LOGIC;
        q     : out STD_LOGIC_VECTOR(9 downto 0)
    );
end register_10_bits_hposition_object_2;

architecture Behavioral of register_10_bits_hposition_object_2 is
    signal q_reg : STD_LOGIC_VECTOR(9 downto 0);
begin

    process(clk, reset)
    begin
        if reset = '1' then
            q_reg <= (others => '0');
        elsif rising_edge(clk) then
            if ce = '1' then
                q_reg <= d;
            end if;
        end if;
    end process;

    q <= q_reg;

end Behavioral;