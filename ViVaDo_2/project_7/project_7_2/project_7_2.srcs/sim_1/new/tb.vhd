library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component comparator_4_bits is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           a_equals_b : out STD_LOGIC := '0';
           a_greater_than_b : out STD_LOGIC := '0';
           a_less_than_b : out STD_LOGIC :='0');
    end component;
    
    signal t_a_equals_b, t_a_greater_than_b, t_a_less_than_b: std_logic;
    signal t_a, t_b : STD_LOGIC_VECTOR (3 downto 0);
begin
    
    UUT: comparator_4_bits Port map (a => t_a, b=> t_b, a_equals_b => t_a_equals_b,
         a_greater_than_b => t_a_greater_than_b, a_less_than_b => t_a_less_than_b);
         
    process
    begin
        for i in 0 to 15 loop
           t_a <= std_logic_vector(to_unsigned(i, 4));
           for j in 0 to 15 loop
                t_b <= std_logic_vector(to_unsigned(j,4));
                wait for 1 us;
            end loop;
        end loop;
    end process;
    
end Behavioral;
