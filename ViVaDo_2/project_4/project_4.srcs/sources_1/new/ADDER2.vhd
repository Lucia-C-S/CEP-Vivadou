library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ADDER2 is
    Port ( AB : in STD_LOGIC_VECTOR (3 downto 0);
           RESULT : out STD_LOGIC_VECTOR (2 downto 0));
end ADDER2;

architecture Behavioral of ADDER2 is
    
begin
    with AB select RESULT <= --with the inputs (read) select output (assign, write)
        O"0" when X"0",
        O"1" when X"1" | X"4", -- result in octal -- INPUTS in hexadecimal
        O"2" when X"2" | X"5" | X"8",
        O"3" when X"3" | X"6" | X"9" | X"C",
        O"4" when X"7" | X"A" | X"D",
        O"5" when X"B" | X"E",
        O"6" when X"F",
        "000" when others; -- remember zeros otherwisE!!!
end Behavioral;
