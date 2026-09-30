library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inst_reg_2_bits_col is
    Port ( reset, ce, clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (1 downto 0);
           q_col : out STD_LOGIC_VECTOR (1 downto 0));
end inst_reg_2_bits_col;

architecture Behavioral of inst_reg_2_bits_col is
    signal Qaux: std_logic_vector (1 downto 0);
begin

process (clk, reset)

begin
if (reset = '1') then Qaux <= "00";     
end if;

if (rising_edge(clk)) then
               
        if (ce = '1') then Qaux <= d;
        else Qaux <= Qaux; --no change --(ce = '0')
        end if;
 end if;

end process;  
q_col <= Qaux;

end Behavioral;