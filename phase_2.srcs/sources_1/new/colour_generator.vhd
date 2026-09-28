library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity colour_generator is
    Port (
        clk           : in  STD_LOGIC;
        reset         : in  STD_LOGIC;
        black_on      : in  STD_LOGIC;
        colour_scheme : in  STD_LOGIC_VECTOR(2 downto 0);
        hctr          : in  STD_LOGIC_VECTOR(9 downto 0);
        vctr          : in  STD_LOGIC_VECTOR(9 downto 0);
        pixel_colour  : out STD_LOGIC_VECTOR(11 downto 0)
    );
end colour_generator;

architecture Behavioral of colour_generator is

    signal R, G, B : STD_LOGIC_VECTOR(3 downto 0);
    signal pixel_colour_internal : STD_LOGIC_VECTOR(11 downto 0);

begin


    R <= colour_scheme & '0';

    G <= hctr(9 downto 6);

    B <= vctr(9 downto 6);

    pixel_colour_internal <= R & G & B
                             when black_on = '0'
                             else (others => '0');

    process(clk, reset) --Syncing
    begin
        if reset = '1' then
            pixel_colour <= (others => '0');

        elsif rising_edge(clk) then
            pixel_colour <= pixel_colour_internal;
        end if;
    end process;