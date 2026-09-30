------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_4_channels is
    Port ( ch1, ch2, ch3, ch4 : in STD_LOGIC_VECTOR (7 downto 0);
            sel: in std_logic_vector(1 downto 0);
           result_mux : out STD_LOGIC_VECTOR (7 downto 0));
end mux_4_channels;

architecture Behavioral of mux_4_channels is

begin
    process (sel, ch1, ch2, ch3, ch4)
     begin 
        case sel is
            when "00" => result_mux <= ch1;
            when "01" => result_mux <= ch2;
            when "10" => result_mux <= ch3;
            when "11" => result_mux <= ch4;
            when others => result_mux <= (others => '0');
        end case;
     end process;


end Behavioral;
