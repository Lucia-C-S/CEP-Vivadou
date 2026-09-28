library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vsync_generator is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        ce_25MHz : in  STD_LOGIC;
        vctr     : in  STD_LOGIC_VECTOR(9 downto 0);
        vsync    : out STD_LOGIC
    );
end vsync_generator;

architecture Behavioral of vsync_generator is
begin

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then
                vsync <= '1';

            elsif ce_25MHz = '1' then

                -- VSYNC activo en bajo entre las líneas 493 y 496
                if (unsigned(vctr) >= 493) and
                   (unsigned(vctr) <= 496) then
                    vsync <= '0';
                else
                    vsync <= '1';
                end if;

            end if;

        end if;
    end process;

end Behavioral;