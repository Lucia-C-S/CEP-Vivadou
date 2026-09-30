library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity comparator_4_bits is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           a_equals_b : out STD_LOGIC := '0';
           a_greater_than_b : out STD_LOGIC := '0';
           a_less_than_b : out STD_LOGIC :='0');
end comparator_4_bits;

architecture Behavioral of comparator_4_bits is
    signal result: std_logic_vector (2 downto 0);
begin
process (a,b)
    begin
        if (a > b) then  result <= "100";
        elsif (a < b) then result <= "010";
        elsif (a = b) then result <= "001";
        else result <= "000";
        end if;
    end process;

    a_greater_than_b <= result(2);
    a_less_than_b <= result(1);
    a_equals_b <= result(0);
    
end Behavioral;
