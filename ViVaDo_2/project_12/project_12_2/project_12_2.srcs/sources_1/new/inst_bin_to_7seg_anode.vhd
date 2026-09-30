library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin_to_7_seg_anode is
    Port ( EN : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (3 downto 0);
           dp_in : in STD_LOGIC;
           abcdefg : out STD_LOGIC_VECTOR (6 downto 0);
           DP : out STD_LOGIC);
           --an0, an1, an2, an3 : out STD_LOGIC);
end bin_to_7_seg_anode;

architecture Behavioral of bin_to_7_seg_anode is
    signal out_display : std_logic_vector (6 downto 0); 
    -- Create a vector to store the values of A, B, C, D, E, F, G.
    -- This is used to give it a default value.
    
begin
    --an0 <= '0';
    --an1 <= '1';
    --an2 <= '1';
    --an3 <= '1';
    
    --we obtain DP value depending on EN
    with EN select 
        DP <= '1' when '0',
               not dp_in when '1',
               '1' when others; 
               
    with Din select 
    out_display <=
        "0000001" when X"0",
        "1001111" when X"1",
        "0010010" when X"2",
        "0000110" when X"3",
        "1001100" when X"4",
        "0100100" when X"5",
        "0100000" when X"6",
        "0001111" when X"7",
        "0000000" when X"8",
        "0000100" when X"9",
        "0001000" when X"A",
        "1100000" when X"B",
        "0110001" when X"C",
        "1000010" when X"D",
        "0110000" when X"E",
        "0111000" when X"F",
        "1111111" when others;
           
        --now we obtain value of display depeding on EN
        with EN select
            abcdefg <= out_display when '1',
                       "1111111" when others;
        
end Behavioral;

