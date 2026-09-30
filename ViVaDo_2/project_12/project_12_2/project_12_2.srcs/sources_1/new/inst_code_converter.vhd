library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inst_code_converter is
    Port ( column, row : in STD_LOGIC_VECTOR (1 downto 0);
           binary : out STD_LOGIC_VECTOR (3 downto 0));
end inst_code_converter;

architecture Behavioral of inst_code_converter is

begin
process (column, row)
begin
    case row is 
        when "00" => if    column = "00" then binary <= "0001"; --1
                     elsif column = "01" then binary <= "0010"; --2
                     elsif column = "10" then binary <= "0011"; --3
                     elsif column = "11" then binary <= "1010"; --A
                     end if;
                     
        when "01" => if    column = "00" then binary <= "0100"; --4
                     elsif column = "01" then binary <= "0101"; --5
                     elsif column = "10" then binary <= "0110"; --6
                     elsif column = "11" then binary <= "1011"; --B
                     end if;
                     
        when "10" => if    column = "00" then binary <= "0111"; --7
                     elsif column = "01" then binary <= "1000"; --8
                     elsif column = "10" then binary <= "1001"; --9
                     elsif column = "11" then binary <= "1100"; --C
                     end if;
                    
        when "11" => if    column = "00" then binary <= "0000"; --0
                     elsif column = "01" then binary <= "1111"; --F
                     elsif column = "10" then binary <= "1110"; --E
                     elsif column = "11" then binary <= "1101"; --D
                     end if;
        end case;
     end process;

end Behavioral;
