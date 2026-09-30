library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--for second part of the exercise
entity comparator is
    Port (A: in std_logic_vector (2 downto 0);
          F: out std_logic_vector (2 downto 0));
end comparator;

architecture Behavioral of comparator is
    constant B : std_logic_vector(2 downto 0):= "011";
begin
    F <= "100" when A > B else  --when-else no process / if-then inside a process
         "010" when A = B else
         "001" when A < B else 
         "000";
 
end Behavioral;
