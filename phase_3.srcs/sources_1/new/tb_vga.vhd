library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_objects_generator is
end tb_objects_generator;

architecture Behavioral of tb_objects_generator is

    ----------------------------------------------------------------
    -- Component under test
    ----------------------------------------------------------------
    component objects_generator
        Port (
            clk          : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            hctr         : in  STD_LOGIC_VECTOR(9 downto 0);
            vctr         : in  STD_LOGIC_VECTOR(9 downto 0);
            blank        : in  STD_LOGIC;
            wall_x       : in  STD_LOGIC_VECTOR(9 downto 0);
            pixel_colour : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;


    ----------------------------------------------------------------
    -- Signals
    ----------------------------------------------------------------
    signal clk          : STD_LOGIC := '0';
    signal reset        : STD_LOGIC := '1';

    signal hctr         : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal vctr         : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');

    signal blank        : STD_LOGIC := '1';

    signal wall_x       : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');

    signal pixel_colour : STD_LOGIC_VECTOR(11 downto 0);


begin

    ----------------------------------------------------------------
    -- DUT
    ----------------------------------------------------------------
    DUT : objects_generator
        port map (
            clk          => clk,
            reset        => reset,
            hctr         => hctr,
            vctr         => vctr,
            blank        => blank,
            wall_x       => wall_x,
            pixel_colour => pixel_colour
        );


    ----------------------------------------------------------------
    -- 100 MHz clock
    -- Period = 10 ns
    ----------------------------------------------------------------
    clk_process : process
    begin
        while true loop

            clk <= '0';
            wait for 5 ns;

            clk <= '1';
            wait for 5 ns;

        end loop;
    end process;


    ----------------------------------------------------------------
    -- TEST STIMULUS
    ----------------------------------------------------------------
    stimulus : process
    begin

        ------------------------------------------------------------
        -- RESET
        ------------------------------------------------------------
        reset <= '1';
        blank <= '1';

        hctr <= std_logic_vector(to_unsigned(0, 10));
        vctr <= std_logic_vector(to_unsigned(0, 10));

        wall_x <= std_logic_vector(to_unsigned(100, 10));

        wait for 100 ns;


        ------------------------------------------------------------
        -- RELEASE RESET
        ------------------------------------------------------------
        reset <= '0';

        wait for 20 ns;


        ------------------------------------------------------------
        -- TEST 1: BLANKING
        --
        -- During blanking pixel_colour should be black.
        ------------------------------------------------------------
        blank <= '1';

        hctr <= std_logic_vector(to_unsigned(100, 10));
        vctr <= std_logic_vector(to_unsigned(500, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- TEST 2: BACKGROUND
        --
        -- Visible area, but outside all objects.
        ------------------------------------------------------------
        blank <= '0';

        hctr <= std_logic_vector(to_unsigned(500, 10));
        vctr <= std_logic_vector(to_unsigned(300, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- TEST 3: WALL
        --
        -- Wall starts at wall_x.
        --
        -- wall = 10 pixels wide
        -- wall = 25 pixels high
        --
        -- Put the current pixel inside the wall.
        ------------------------------------------------------------
        hctr <= std_logic_vector(to_unsigned(100, 10));
        vctr <= std_logic_vector(to_unsigned(500, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- TEST 4: WALL - OTHER PIXEL
        --
        -- Another pixel inside the wall.
        ------------------------------------------------------------
        hctr <= std_logic_vector(to_unsigned(105, 10));
        vctr <= std_logic_vector(to_unsigned(510, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- TEST 5: OUTSIDE WALL
        --
        -- One pixel horizontally outside the wall.
        ------------------------------------------------------------
        hctr <= std_logic_vector(to_unsigned(110, 10));
        vctr <= std_logic_vector(to_unsigned(510, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- TEST 6: BALL
        --
        -- Put the scan position where your ball is defined.
        --
        -- CHANGE these coordinates to the coordinates
        -- used in your object_2 generator.
        ------------------------------------------------------------
        hctr <= std_logic_vector(to_unsigned(400, 10));
        vctr <= std_logic_vector(to_unsigned(300, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- TEST 7: MOVE AROUND BALL
        ------------------------------------------------------------
        hctr <= std_logic_vector(to_unsigned(403, 10));
        vctr <= std_logic_vector(to_unsigned(303, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- TEST 8: TEST DIFFERENT WALL POSITION
        ------------------------------------------------------------
        wall_x <= std_logic_vector(to_unsigned(200, 10));

        hctr <= std_logic_vector(to_unsigned(200, 10));
        vctr <= std_logic_vector(to_unsigned(500, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- TEST 9: PIXEL JUST OUTSIDE WALL
        ------------------------------------------------------------
        hctr <= std_logic_vector(to_unsigned(210, 10));
        vctr <= std_logic_vector(to_unsigned(500, 10));

        wait for 50 ns;


        ------------------------------------------------------------
        -- END SIMULATION
        ------------------------------------------------------------
        wait;

    end process;

end Behavioral;