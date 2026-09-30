library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_Std.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component mux_4c_4b is
       Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);
              channel_0_mux, channel_1_mux, channel_2_mux, channel_3_mux : in STD_LOGIC_VECTOR (3 downto 0);
              mux_out : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
 
    signal sel: std_logic_vector(1 downto 0);
    signal channel_0_mux, channel_1_mux, channel_2_mux, channel_3_mux : STD_LOGIC_VECTOR (3 downto 0);
    signal mux_out : STD_LOGIC_VECTOR (3 downto 0);
begin

UUT: mux_4c_4b Port map (sel => sel, channel_0_mux => channel_0_mux,
                         channel_1_mux => channel_1_mux, channel_2_mux => channel_2_mux,
                         channel_3_mux => channel_3_mux, mux_out => mux_out);
                     
process
begin
    channel_0_mux <= "0001";
    channel_1_mux <= "0010";
    channel_2_mux <= "0100";
    channel_3_mux <= "1000";
    wait for 10 ns;
    
for i in 0 to 3 loop
    sel <= std_logic_vector (to_unsigned(i, 2));
wait for 40 ns;  -- observe mux_out
    end loop;

    -- Optional: dynamic change of channels
    channel_0_mux <= "1111";
    channel_1_mux <= "0000";
    channel_2_mux <= "1010";
    channel_3_mux <= "0101";
    wait for 10 ns;

end process;        

end Behavioral;
