library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity object_2 is
    Port (
        hctr     : in  STD_LOGIC_VECTOR(9 downto 0);
        vctr     : in  STD_LOGIC_VECTOR(9 downto 0);

        object_2_hposition : in std_logic_vector(9 downto 0);
        object_2_vposition : in std_logic_vector(9 downto 0);

        object_2_on  : out STD_LOGIC;
        object_2_colour : out STD_LOGIC_VECTOR(11 downto 0)
    );
end object_2;

architecture Behavioral of object_2 is

    constant BALL_X : integer := 400;
    constant BALL_Y : integer := 300;

begin

    process(hctr, vctr)
        variable x : integer;
        variable y : integer;
    begin

        x := to_integer(unsigned(hctr));
        y := to_integer(unsigned(vctr));

        object_2_on <= '0';

        if (x >= BALL_X) and
           (x < BALL_X + 6) and
           (y >= BALL_Y) and
           (y < BALL_Y + 7) then

            object_2_on <= '1';

        end if;

        -- Example ball colour: blue
        object_2_colour <= x"00F";

    end process;

end Behavioral;