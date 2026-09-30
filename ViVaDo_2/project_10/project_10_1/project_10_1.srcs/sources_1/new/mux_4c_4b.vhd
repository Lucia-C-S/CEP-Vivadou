library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4c_4b is
    Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);
           channel_0_mux, channel_1_mux, channel_2_mux, channel_3_mux : in STD_LOGIC_VECTOR (3 downto 0);
           mux_out : out STD_LOGIC_VECTOR (3 downto 0));
end mux_4c_4b;

architecture Behavioral of mux_4c_4b is
begin
process (sel, channel_0_mux, channel_1_mux, channel_2_mux, channel_3_mux)
begin
case sel is
    when  "00" => mux_out <= channel_0_mux;
    when  "01" => mux_out <= channel_1_mux;
    when  "10" => mux_out <= channel_2_mux;
    when  "11" => mux_out <= channel_3_mux;
    when others => mux_out <= (others => '0');
end case;
end process;

end Behavioral;
