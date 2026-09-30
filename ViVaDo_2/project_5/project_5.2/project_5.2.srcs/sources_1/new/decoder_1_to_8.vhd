library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_1_to_8 is
    Port ( d : in STD_LOGIC_VECTOR (2 downto 0);
           q : out STD_LOGIC_VECTOR (7 downto 0));
end decoder_1_to_8;

architecture Behavioral of decoder_1_to_8 is
    
begin
  process (d)
        begin       
        -- CASE-WHEN with the different options
        case(d) is        
            when "000" => q <= "00000001";  -- FIRST LINE OF TABLE
            when "001" => q <= "00000010";
            when "010" => q <= "00000100";
            when "011" => q <= "00001000";
            when "100" => q <= "00010000";
            when "101" => q <= "00100000";
            when "110" => q <= "01000000";
            when "111" => q <= "10000000";
            when others => q <= "00000000";
            
        end case;
    end process;
     
end Behavioral;
