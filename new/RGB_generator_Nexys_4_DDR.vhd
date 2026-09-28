library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RGB_generator_Nexys_4_DDR is
    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        ce_25MHz     : in  STD_LOGIC;
        blank        : in  STD_LOGIC;
        pixel_colour : in  STD_LOGIC_VECTOR(11 downto 0);

        R : out STD_LOGIC_VECTOR(3 downto 0);
        G : out STD_LOGIC_VECTOR(3 downto 0);
        B : out STD_LOGIC_VECTOR(3 downto 0)
    );
end RGB_generator_Nexys_4_DDR;

architecture Behavioral of RGB_generator_Nexys_4_DDR is

    signal red   : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal green : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal blue  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then

                red   <= (others => '0');
                green <= (others => '0');
                blue  <= (others => '0');

            elsif ce_25MHz = '1' then

                if blank = '1' then
                    red   <= pixel_colour(11 downto 8);
                    green <= pixel_colour(7 downto 4);
                    blue  <= pixel_colour(3 downto 0);
                else
                    red   <= (others => '0');
                    green <= (others => '0');
                    blue  <= (others => '0');
                end if;

            end if;

        end if;
    end process;

    R <= red;
    G <= green;
    B <= blue;

end Behavioral;