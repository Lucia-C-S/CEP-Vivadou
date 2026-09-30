library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

component signed_multiplier_4_bits is
    Port ( a, b: in STD_LOGIC_VECTOR (3 downto 0);
           product : out STD_LOGIC_VECTOR (7 downto 0));
end component;

     signal a: std_logic_vector(3 downto 0);
    signal b: std_logic_vector(3 downto 0);
    signal product: std_logic_vector(7 downto 0);
    
begin

    UUT: signed_multiplier_4_bits Port map(a=>a, b=>b, product=>product);

    process
    begin
        a<="0101";
        for I in 0 to 15 loop
            b<=std_logic_vector(TO_UNSIGNED(I, 4));
            wait for 1 us;
        end loop;
        b<="1010";
        for I in 0 to 15 loop
            a<=std_logic_vector(TO_UNSIGNED(I, 4));
            wait for 1 us;
        end loop;
    end process;

  

end Behavioral;
