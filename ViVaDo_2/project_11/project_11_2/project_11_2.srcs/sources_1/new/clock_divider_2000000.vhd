library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--=============================================================
--  Frequency Divider by 1000
--  - Input clock: clkin
--  - Output clock: clkout (toggled every 500 cycles)
--  - Active-high asynchronous reset
--=============================================================
entity clock_divider_2000000 is
    Port ( 
        clk  : in  std_logic;   -- input clock (e.g., 2 MHz)
        clkout : out std_logic;   -- divided output clock
        reset  : in  std_logic    -- asynchronous reset (active high)
    );
end clock_divider_2000000;

architecture Behavioral of clock_divider_2000000 is

    -- Counter to count from 0 to 999999 (total 1000000 cycles)
    signal count      : integer range 0 to 499 := 0;

    -- Internal register for the output clock
    signal clkout_aux : std_logic := '0';

begin

    -- Drive output port with internal signal
    clkout <= clkout_aux;

    --=========================================================
    -- Main process:
    -- - Asynchronous reset
    -- - Rising edge triggered clock divider
    --=========================================================
    process (clk, reset)
    begin

        -- Asynchronous reset: forces output low and count to 0
        if reset = '1' then
            clkout_aux <= '0';
            count      <= 0;

        -- Synchronous logic on rising edge of input clock
        elsif rising_edge(clk) then
            
            -- When count reaches 999999:
            --   → toggle clkout_aux
            --   → reset counter
            if count = 999999 then
                clkout_aux <= not clkout_aux;  -- toggle => divide frequency
                count      <= 0;

            -- Otherwise continue incrementing counter
            else
                count <= count + 1;
            end if;

        end if;
    end process;

end Behavioral;

