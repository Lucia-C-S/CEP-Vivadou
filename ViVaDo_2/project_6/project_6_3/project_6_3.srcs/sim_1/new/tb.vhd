library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component bin_to_7_seg_anode is
    Port ( EN : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (3 downto 0);
           dp_in : in STD_LOGIC;
           DISPLAY : out STD_LOGIC_VECTOR (6 downto 0);
           DP : out STD_LOGIC;
           an0, an1, an2, an3 : out STD_LOGIC);
    end component;
    
    signal t_EN, t_dp_in, t_DP, t_an0, t_an1, t_an2, t_an3 : std_logic;
    signal t_Din: std_logic_vector (3 downto 0);
    signal t_DISPLAY : STD_LOGIC_VECTOR (6 downto 0);    
begin

UUT: bin_to_7_seg_anode port map (EN => t_EN, Din => t_Din, dp_in => t_dp_in, DISPLAY => t_DISPLAY,
                                  DP => t_DP, an0 => t_an0, an1 => t_an1, an2 => t_an2, an3 => t_an3);
process
begin

    t_EN <= '0'; t_dp_in <= '0';    
    for i in 0 to 15 loop
        t_Din <= std_logic_vector (to_unsigned(i,4));
        wait for 1 us;
     end loop;
     
     t_EN <= '0'; t_dp_in <= '1';
     for i in 0 to 15 loop
        t_Din <= std_logic_vector (to_unsigned(i,4));
        wait for 1 us;
     end loop;
     
     t_EN <= '1'; t_dp_in <= '0';
     for i in 0 to 15 loop
        t_Din <= std_logic_vector (to_unsigned(i,4));
        wait for 1 us;
     end loop;
     
     t_EN <= '1'; t_dp_in <= '1';
     for i in 0 to 15 loop
        t_Din <= std_logic_vector (to_unsigned(i,4));
        wait for 1 us;
     end loop;
     
end process;

end Behavioral;
