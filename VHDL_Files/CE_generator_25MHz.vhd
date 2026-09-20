-------------------------------------------------------------------------------------- 
-- This circuit generates a clock enable signal working at 25 MHz from a 100 MHz clock signal
-- The "ce_25MHz" signal is activated 1 clock cycle every time
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CE_generator_25MHz is
    Port ( clk_100MHz : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ce_25MHz : out  STD_LOGIC);
end CE_generator_25MHz;

architecture Behavioral of CE_generator_25MHz is

-- Clock cycle counter
signal count: integer range 0 to 3:=0;

begin

process(clk_100MHz)
		begin
			if (clk_100MHz'event and clk_100MHz='1') then
					if count=3 then
						count <= 0;
						ce_25MHz <= '1';
					else
						count <= count + 1;
						ce_25MHz <= '0';
					end if;
			end if;
end process;

end Behavioral;

