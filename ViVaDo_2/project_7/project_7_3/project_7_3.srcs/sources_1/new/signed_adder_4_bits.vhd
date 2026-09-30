library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity signed_adder_4_bits is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           sum : out STD_LOGIC_VECTOR (4 downto 0));
end signed_adder_4_bits;

architecture Behavioral of signed_adder_4_bits is
    signal a_extended, b_extended: std_logic_vector(4 downto 0);
begin

process (a)
begin   
    if (a(3) = '0') then
        a_extended <= '0' & a;
    else a_extended <= '1' & a;
    end if;
end process;

process (b)
begin
    if (b(3) = '0') then
        b_extended <= '0' & b;
    else b_extended <= '1' & b;
    end if;
end process;
 
    sum <= a_extended + b_extended ;

end Behavioral;
