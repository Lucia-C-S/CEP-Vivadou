library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_1_to_4 is
    Port ( G: in std_logic;
           d : in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end decoder_1_to_4;

architecture Behavioral of decoder_1_to_4 is

begin
    q(3) <= not(G) or (d(0) nand d(1)) ;
    q(2) <= not(G) or (d(0) or (not d(1))) ;
    q(1) <= not(G) or (not(d(0)) or d(1));
    q(0) <= not(G) or (d(0) or d(1));

end Behavioral;
