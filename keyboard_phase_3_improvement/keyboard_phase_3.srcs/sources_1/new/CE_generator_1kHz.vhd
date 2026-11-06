-------------------------------------------------------------------------------------- 
-- This circuit generates a clock enable signal working at 1 kHz from a 100 MHz clock signal
-- The "ce_1kHz" signal is activated 1 clock cycle every time
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CE_generator_1kHz is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ce_1kHz : out  STD_LOGIC);
end CE_generator_1kHz;


architecture Behavioral of CE_generator_1kHz is

-- Clock cycle counter
signal count: integer range 0 to 99999:=0;

begin

process(clk)
		begin
			if (clk'event and clk='1') then
					if count=99999 then
						count <= 0;
						ce_1kHz <= '1';
					else
						count <= count + 1;
						ce_1kHz <= '0';
					end if;
			end if;
end process;

end Behavioral;

