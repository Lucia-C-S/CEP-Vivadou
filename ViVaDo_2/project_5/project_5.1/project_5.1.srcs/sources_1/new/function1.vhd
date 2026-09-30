--This circuit must activate the output 'f1' when the four input variables 'a(3:0)' present a number
--divisible by 2. Using LOGIC GATES

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity function1 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           f1 : out STD_LOGIC);
end function1;

architecture Behavioral of function1 is

begin


--    f1<= (a(3) or a(2) or a(1)) and (not a(0));
-- better version and more compressed

process (a)
 begin
    case a is
        when "0010" | "0100" | "0110" | "1000"  => f1 <= '1';
        when others => f1 <= '0';
   end case;
 end process;

end Behavioral;
