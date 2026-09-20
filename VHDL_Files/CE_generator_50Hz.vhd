-------------------------------------------------------------------------------------- 
-- This circuit generates a clock enable signal working at 50 Hz from a 100 MHz clock signal
-- The "ce_50Hz" signal is activated 1 clock cycle every time
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CE_generator_50Hz is
    Port ( clk_100MHz : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ce_50Hz : out  STD_LOGIC);
end CE_generator_50Hz;

architecture Behavioral of CE_generator_50Hz is

-- Clock cycle counter
signal count: integer range 0 to 2000000:=0;

begin

process(clk_100MHz)
		begin
			if (clk_100MHz'event and clk_100MHz='1') then
					if count=1999999 then
						count <= 0;
						ce_50Hz <= '1';
					else
						count <= count + 1;
						ce_50Hz <= '0';
					end if;
			end if;
end process;

end Behavioral;

