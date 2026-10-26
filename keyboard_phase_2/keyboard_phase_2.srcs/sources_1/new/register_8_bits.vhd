-- 8 bits synchronous register, with synchronous reset and clock enable
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_8_bits is
    Port ( clk : in std_logic;
           reset : in std_logic;
           d : in std_logic_vector (7 downto 0);
           ce : in std_logic;
           q : out std_logic_vector (7 downto 0)
			  );
end register_8_bits;

architecture Behavioral of register_8_bits is

begin

process (clk, ce, reset)
begin

   if (clk'event and clk='1') then
   	if reset='1' then
         q <= "00000000";  	-- Puesta a cero síncrona
	elsif ce = '1' then
         q <= d;		-- Entrada síncrona
    	end if;
   end if;
end process;

end Behavioral;
