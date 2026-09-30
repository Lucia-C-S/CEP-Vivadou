library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity JK_flipflop is
    Port ( reset, ce, J, K, clk : in STD_LOGIC;
           Q : out STD_LOGIC);
end JK_flipflop;

architecture Behavioral of JK_flipflop is
    signal Qaux: std_logic;
    signal JK: std_logic_vector(1 downto 0);
begin
JK <= J&K;
process (clk, reset)
--For sequential logic, the process sensitivity list should only include clk and asynchronous signals (like reset).
--Including ce, JK, or Qaux is incorrect - that would make it behave partly combinational.

begin

if (clk'event and clk = '1') then
               
        if (reset = '1') then Qaux <= '0';
                
        elsif (ce = '1') then --clock enable
        case (JK) is
           when "00" => Qaux <= Qaux; --no change
           when "01" => Qaux <= '0';  --reset
           when "10" => Qaux <= '1';  --set
           when "11" => Qaux <= not Qaux; ---toggle
           when others => Qaux <= '0';
        end case;
    elsif (ce = '0') then Qaux <= Qaux;
    else Qaux <= '0';
    end if;
end if;

end process;  
Q <= Qaux;

end Behavioral;
