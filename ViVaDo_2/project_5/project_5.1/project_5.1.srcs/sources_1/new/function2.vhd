--This circuit must activate the output 'f2' when the four input variables 'a(3:0)' present a number
--ranging from 1 to 4 (both included). using a IF THEN

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity function2 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           f2 : out STD_LOGIC);
end function2;

architecture Behavioral of function2 is

begin

process (a)
begin
    if a = X"1" then f2 <= '1';
    elsif a= X"2" then f2 <= '1';
    elsif a = X"3" then f2 <= '1';
    elsif a = X"4" then f2 <= '1';
    else f2 <= '0';
    end if;
end process;

end Behavioral;
