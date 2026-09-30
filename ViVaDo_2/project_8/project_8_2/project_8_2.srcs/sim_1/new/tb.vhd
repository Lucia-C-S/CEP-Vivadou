library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity tb is
end tb;

architecture Behavioral of tb is
component alu_4_bits is
    Port ( a,b : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           result : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal t_a,t_b: std_logic_vector (3 downto 0);
signal t_res :  STD_LOGIC_VECTOR (7 downto 0);
signal t_sel :  STD_LOGIC_VECTOR (1 downto 0);

begin

UUT: alu_4_bits Port map (a => t_a, b => t_b, result => t_res, sel => t_sel);

process
begin
--and
t_sel <= "00";
t_a <= "0000"; t_b <= "1111";
wait for 1 us;

t_a <= "1010"; t_b <= "0101";
wait for 1 us;

t_a <= "1111"; t_b <= "1111";
wait for 1 us;

--twos complement
t_sel <= "01";
for i in 0 to 7 loop
    t_a <= std_logic_vector(to_unsigned(i, 4));
    wait for 1 us;
end loop;

--subs
t_sel <= "10";

t_a <= "0011";
for j in 0 to 4 loop
    t_b <= std_logic_vector(to_unsigned(j, 4));
    wait for 1 us;
end loop;

t_b <= "1001";
for i in 0 to 7 loop
    t_a <= std_logic_vector(to_unsigned(i, 4));
    wait for 1 us;
end loop;

--product
t_sel <= "11";

t_a <= "0101";
for j in 0 to 4 loop
    t_b <= std_logic_vector(to_unsigned(j, 4));
    wait for 1 us;
end loop;

t_b <= "1010";
for i in 0 to 7 loop
    t_a <= std_logic_vector(to_unsigned(i, 4));
    wait for 1 us;
end loop;

end process;
end Behavioral;
