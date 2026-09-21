library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_board_VGA_interface_phase_1 is
end tb_top_board_VGA_interface_phase_1;


architecture Behavioral of tb_top_board_VGA_interface_phase_1 is

    -- Component under test
    component top_board_VGA_interface_phase_1
        Port (
            clk        : in  STD_LOGIC;
            CPU_RESETN : in  STD_LOGIC;
            SW15       : in  STD_LOGIC;
            SW14       : in  STD_LOGIC;
            SW         : in  STD_LOGIC_VECTOR(11 downto 0);

            LED        : out STD_LOGIC_VECTOR(9 downto 0);

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


    -- Inputs
    signal clk        : STD_LOGIC := '0';
    signal CPU_RESETN : STD_LOGIC := '0';
    signal SW15       : STD_LOGIC := '0';
    signal SW14       : STD_LOGIC := '0';
    signal SW         : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');


    -- Outputs
    signal LED        : STD_LOGIC_VECTOR(9 downto 0);
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

    DUT : top_board_VGA_interface_phase_1
        port map (
            clk        => clk,
            CPU_RESETN => CPU_RESETN,
            SW15       => SW15,
            SW14       => SW14,
            SW         => SW,

            LED        => LED,

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
    -- STIMULUS
    ----------------------------------------------------------------

    stimulus : process
    begin

        ------------------------------------------------------------
        -- RESET
        -- CPU_RESETN is ACTIVE LOW
        ------------------------------------------------------------

        CPU_RESETN <= '0';

        SW14 <= '0';
        SW15 <= '0';

        SW <= x"000";

        wait for 100 ns;


        ------------------------------------------------------------
        -- RELEASE RESET
        ------------------------------------------------------------

        CPU_RESETN <= '1';

        wait for 1 us;


        ------------------------------------------------------------
        -- TEST SW14
        --
        -- SW14 = 0 -> ce_50Hz
        -- SW14 = 1 -> ce_25MHz
        ------------------------------------------------------------

        SW14 <= '0';

        wait for 1 us;

        SW14 <= '1';

        wait for 1 us;


        ------------------------------------------------------------
        -- TEST SW15
        --
        -- SW15 = 0 -> horizontal counter
        -- SW15 = 1 -> vertical counter
        ------------------------------------------------------------

        SW15 <= '0';

        wait for 1 us;

        SW15 <= '1';

        wait for 1 us;


        ------------------------------------------------------------
        -- TEST PIXEL COLOUR
        --
        -- SW(11:8) = Red
        -- SW(7:4)  = Green
        -- SW(3:0)  = Blue
        ------------------------------------------------------------

        -- Black
        SW <= x"000";
        wait for 1 us;

        -- Red
        SW <= x"F00";
        wait for 1 us;

        -- Green
        SW <= x"0F0";
        wait for 1 us;

        -- Blue
        SW <= x"00F";
        wait for 1 us;

        -- White
        SW <= x"FFF";
        wait for 1 us;

        -- Yellow
        SW <= x"FF0";
        wait for 1 us;

        -- Cyan
        SW <= x"0FF";
        wait for 1 us;

        -- Magenta
        SW <= x"F0F";
        wait for 1 us;


        ------------------------------------------------------------
        -- FINISH
        ------------------------------------------------------------

        wait;

    end process;

end Behavioral;
