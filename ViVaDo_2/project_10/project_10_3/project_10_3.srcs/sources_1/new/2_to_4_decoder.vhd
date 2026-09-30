library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity two_to_4_decoder is
    Port ( d : in STD_LOGIC_VECTOR (1 downto 0);
           g : in std_logic;
           q : out STD_LOGIC_VECTOR (3 downto 0));
end two_to_4_decoder;

architecture Behavioral of two_to_4_decoder is
begin
process (d,g)
begin 

if g = '0' then q <= "1111"; --bc we are working in common anode, that is equal to nothing, 0
else
    case d is
        when "00" => q <= "1110";
        when "01" => q <= "1101";
        when "10" => q <= "1011";
        when "11" => q <= "0111";
        when others => q <= "1111";
    end case;
end if;
end process;

end Behavioral;
