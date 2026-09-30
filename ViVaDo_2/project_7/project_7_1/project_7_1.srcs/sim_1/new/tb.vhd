library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component full_adder is
       Port ( abc : in STD_LOGIC_VECTOR (2 downto 0);
               cs : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
 signal t_abc : std_logic_vector(2 downto 0);
 signal t_cs: STD_LOGIC_VECTOR (1 downto 0);
begin

UUT: full_adder Port map (abc => t_abc, cs => t_cs);
 process
 begin
    for i in 0 to 7 loop
        t_abc <= std_logic_vector(to_unsigned(i, 3));
        wait for 1 us;
    end loop;
 end process;
 end Behavioral;
