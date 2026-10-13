library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity colour_multiplexer is
    Port (
        clk             : in  STD_LOGIC;
        reset           : in  STD_LOGIC;

        blank           : in  STD_LOGIC;

        object_1_colour : in  STD_LOGIC_VECTOR(11 downto 0);
        object_1_on     : in  STD_LOGIC;

        object_2_colour : in  STD_LOGIC_VECTOR(11 downto 0);
        object_2_on     : in  STD_LOGIC;

        object_3_colour : in  STD_LOGIC_VECTOR(11 downto 0);
        object_3_on     : in  STD_LOGIC;

        pixel_colour    : out STD_LOGIC_VECTOR(11 downto 0)
    );
end colour_multiplexer;

architecture Behavioral of colour_multiplexer is

begin

    process(blank,
            object_1_on, object_1_colour,
            object_2_on, object_2_colour,
            object_3_on, object_3_colour)
    begin

        -- Blank intervals
        if blank = '0' then

            pixel_colour <= x"000";-- blac

        -- Object 1 has highest priority  -- the wall has the highest prioritygraph_rgb <= wall_rgb;
        elsif object_1_on = '1' then

            pixel_colour <= object_1_colour; 

        -- Object 2 has second priority
        elsif object_2_on = '1' then -- then the bar (racket)

            pixel_colour <= object_2_colour;

        -- Object 3 has lowest priority
        elsif object_3_on = '1' then -- the ball has the lowest prioritygraph_rgb <= ball_rgb;

            pixel_colour <= object_3_colour;

        -- Background
        else

            pixel_colour <= x"660"; -- the background is yellowend if;

        end if;

    end process;

end Behavioral;

--    process (video_on, wall_on, bar_on, sq_ball_on, wall_rgb, bar_rgb, ball_rgb)
--        begin
--        if video_on = '0' then -- blank intervals
--            graph_rgb <= "000"; -- black
--            else
--        if wall_on = '1' then -- the wall has the highest prioritygraph_rgb <= wall_rgb;
--        elsif bar_on = '1' then -- then the bar (racket)
--            graph_rgb <= bar_rgb;
--        elsif sq_ball_on = '1' then -- the ball has the lowest prioritygraph_rgb <= ball_rgb;
--        else
--            graph_rgb <= "110"; -- the background is yellowend if;
--        end if;
--end process;

