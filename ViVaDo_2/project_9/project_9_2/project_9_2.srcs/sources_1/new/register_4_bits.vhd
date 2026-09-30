library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_4_bits is
    Port ( reset, ce, clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (3 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end register_4_bits;

architecture Behavioral of register_4_bits is
    signal Qaux: std_logic_vector (3 downto 0);
begin

process (clk, reset)

begin

if (rising_edge(clk)) then
               
        if (reset = '1') then Qaux <= "0000";     
        elsif (ce = '1') then Qaux <= d;
        else Qaux <= Qaux; --no change --(ce = '0')
        end if;
 end if;

end process;  
q <= Qaux;

end Behavioral;
