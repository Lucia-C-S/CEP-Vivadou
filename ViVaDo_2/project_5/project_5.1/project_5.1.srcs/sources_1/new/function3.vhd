--This circuit must activate the output 'f3' when the four input variables 'a(3:0)' present a number
--divisible by 4. USING A WHEN ELSE

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity function3 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           f3 : out STD_LOGIC);
end function3;

architecture Behavioral of function3 is

begin
f3 <= '1' when a = X"4" else
      '1' when a = X"8" else
      '0';

end Behavioral;
