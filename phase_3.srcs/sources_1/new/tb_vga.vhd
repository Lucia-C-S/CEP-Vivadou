library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_VGA_interface_objects is
end tb_top_VGA_interface_objects;

architecture Behavioral of tb_top_VGA_interface_objects is

    ----------------------------------------------------------------
    -- COMPONENT UNDER TEST
    ----------------------------------------------------------------
    component top_VGA_interface_objects
        Port (
            clk        : in  STD_LOGIC;
            CPU_RESETN : in  STD_LOGIC;

            SW         : in  STD_LOGIC_VECTOR(9 downto 0);

            vsync_led  : out STD_LOGIC;
            vsync_os   : out STD_LOGIC;
            hsync_os   : out STD_LOGIC;

            VGA_hsync : out STD_LOGIC;
            VGA_vsync : out STD_LOGIC;

            VGA_R     : out STD_LOGIC_VECTOR(3 downto 0);
            VGA_G     : out STD_LOGIC_VECTOR(3 downto 0);
            VGA_B     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;


    ----------------------------------------------------------------
    -- INPUTS
    ----------------------------------------------------------------

    signal clk        : STD_LOGIC := '0';
    signal CPU_RESETN : STD_LOGIC := '0';

    -- SW(9 downto 0) controls horizontal position of wall
    signal SW         : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');


    ----------------------------------------------------------------
    -- OUTPUTS
    ----------------------------------------------------------------

    signal vsync_led  : STD_LOGIC;
    signal vsync_os   : STD_LOGIC;
    signal hsync_os   : STD_LOGIC;

    signal VGA_hsync : STD_LOGIC;
    signal VGA_vsync : STD_LOGIC;

    signal VGA_R : STD_LOGIC_VECTOR(3 downto 0);
    signal VGA_G : STD_LOGIC_VECTOR(3 downto 0);
    signal VGA_B : STD_LOGIC_VECTOR(3 downto 0);


begin

    ----------------------------------------------------------------
    -- DEVICE UNDER TEST
    ----------------------------------------------------------------

    DUT : top_VGA_interface_objects
        port map (
            clk        => clk,
            CPU_RESETN => CPU_RESETN,

            SW         => SW,

            vsync_led  => vsync_led,
            vsync_os   => vsync_os,
            hsync_os   => hsync_os,

            VGA_hsync => VGA_hsync,
            VGA_vsync => VGA_vsync,

            VGA_R     => VGA_R,
            VGA_G     => VGA_G,
            VGA_B     => VGA_B
        );


    ----------------------------------------------------------------
    -- 100 MHz CLOCK
    -- 10 ns period
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
    -- STIMULUS
    ----------------------------------------------------------------

    stimulus : process
    begin

        ------------------------------------------------------------
        -- RESET
        --
        -- CPU_RESETN is ACTIVE LOW
        ------------------------------------------------------------

        CPU_RESETN <= '0';

        SW <= (others => '0');

        wait for 200 ns;


        ------------------------------------------------------------
        -- RELEASE RESET
        ------------------------------------------------------------

        CPU_RESETN <= '1';

        wait for 1 us;


        ------------------------------------------------------------
        -- WALL POSITION TEST
        --
        -- SW(9 downto 0) = horizontal position of wall
        ------------------------------------------------------------

        -- Wall at x = 0
        SW <= std_logic_vector(to_unsigned(0, 10));

        wait for 5 us;


        -- Wall at x = 100
        SW <= std_logic_vector(to_unsigned(100, 10));

        wait for 5 us;


        -- Wall at x = 200
        SW <= std_logic_vector(to_unsigned(200, 10));

        wait for 5 us;


        -- Wall at x = 400
        SW <= std_logic_vector(to_unsigned(400, 10));

        wait for 5 us;


        -- Wall at x = 600
        SW <= std_logic_vector(to_unsigned(600, 10));

        wait for 5 us;


        -- Wall near right side
        SW <= std_logic_vector(to_unsigned(790, 10));

        wait for 5 us;


        ------------------------------------------------------------
        -- RETURN WALL TO LEFT SIDE
        ------------------------------------------------------------

        SW <= std_logic_vector(to_unsigned(50, 10));

        wait for 5 us;


        ------------------------------------------------------------
        -- END SIMULATION
        ------------------------------------------------------------

        wait;

    end process;

end Behavioral;