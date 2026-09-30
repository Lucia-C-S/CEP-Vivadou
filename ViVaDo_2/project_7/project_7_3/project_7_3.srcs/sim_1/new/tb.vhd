library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component signed_adder_4_bits is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           sum : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    
    signal t_a, t_b: std_logic_vector (3 downto 0);
    signal t_sum: std_logic_vector (4 downto 0);
begin

UUT: signed_adder_4_bits Port map (a => t_a, b=> t_b, sum => t_sum);

process 
begin
    
        t_a <= "0111";
        for j in 0 to 15 loop
            t_b <= std_logic_vector (to_unsigned(j, 4));
            wait for 1 us;
        end loop;
        
        t_b <= "1110";
        for i in 0 to 15 loop
            t_a <= std_logic_vector (to_unsigned(i, 4));
            wait for 1 us;
        end loop;
    
end process;

end Behavioral;
