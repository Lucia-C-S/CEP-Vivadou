library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity blank_generator is
    Port (
        hctr  : in  STD_LOGIC_VECTOR(9 downto 0);
        vctr  : in  STD_LOGIC_VECTOR(9 downto 0);
        blank : out STD_LOGIC
    );
end blank_generator;

architecture Behavioral of blank_generator is
begin

    process(hctr, vctr)
    begin

        if (unsigned(hctr) >= 640) or
           (unsigned(vctr) >= 480) then
            blank <= '0';
        else
            blank <= '1';
        end if;

    end process;

end Behavioral; 