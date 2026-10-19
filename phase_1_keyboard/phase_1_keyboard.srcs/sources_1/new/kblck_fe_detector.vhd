library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kblck_fe_detector is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        kbclk    : in  STD_LOGIC;
        kbclk_fe : out STD_LOGIC
    );
end kblck_fe_detector;

architecture Behavioral of kblck_fe_detector is

    signal kbclk_ff1 : STD_LOGIC := '1';
    signal kbclk_ff2 : STD_LOGIC := '1';
begin

    process(clk, reset)
    begin
        if reset = '1' then
        
            kbclk_ff1 <= '1';
            kbclk_ff2 <= '1';

        elsif rising_edge(clk) then
        
            kbclk_ff1 <= kbclk;
            kbclk_ff2 <= kbclk_ff1; --Doble flipflops para sincronizar la señal
            
        end if;
    end process;

    -- Detección de flanco de bajada
    kbclk_fe <= kbclk_ff2 and (not kbclk_ff1); --Salida final, sale 1 si ff2=1 y ff1=0

end Behavioral;