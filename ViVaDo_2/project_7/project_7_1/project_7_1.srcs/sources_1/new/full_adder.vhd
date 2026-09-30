library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity full_adder is
    Port ( abc : in STD_LOGIC_VECTOR (2 downto 0);
           cs : out STD_LOGIC_VECTOR (1 downto 0));
end full_adder;

architecture Behavioral of full_adder is

begin
 process (abc)
 begin
    case abc is
        when "000" => cs <= "00";
        when "001" => cs <= "01";
        when "010" => cs <= "01";
        when "011" => cs <= "10";
        when "100" => cs <= "01";
        when "101" => cs <= "10";
        when "110" => cs <= "10";
        when "111" => cs <= "11";
        when others => cs <= "00";
     end case;
  end process;  

end Behavioral;
