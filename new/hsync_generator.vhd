library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hsync_generator is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        ce_25MHz : in  STD_LOGIC;
        hctr     : in  STD_LOGIC_VECTOR(9 downto 0);
        hsync    : out STD_LOGIC
    );
end hsync_generator;

architecture Behavioral of hsync_generator is
begin

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then
                hsync <= '1';

            elsif ce_25MHz = '1' then

                if (unsigned(hctr) >= 664) and
                   (unsigned(hctr) <= 759) then
                    hsync <= '0';
                else
                    hsync <= '1';
                end if;

            end if;
        end if;
    end process;

end Behavioral;