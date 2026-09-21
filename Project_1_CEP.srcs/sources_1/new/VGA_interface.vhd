library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_interface is
    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        ce_25MHz     : in  STD_LOGIC;
        pixel_colour : in  STD_LOGIC_VECTOR(11 downto 0);

        hctr         : out STD_LOGIC_VECTOR(9 downto 0);
        vctr         : out STD_LOGIC_VECTOR(9 downto 0);

        hsync        : out STD_LOGIC;
        vsync        : out STD_LOGIC;

        R            : out STD_LOGIC_VECTOR(3 downto 0);
        G            : out STD_LOGIC_VECTOR(3 downto 0);
        B            : out STD_LOGIC_VECTOR(3 downto 0)
    );
end vga_interface;


architecture Structural of vga_interface is

    ----------------------------------------------------------------
    -- COMPONENT DECLARATIONS
    ----------------------------------------------------------------

    component horizontal_ctr
        Port (
            ce_25MHz : in  STD_LOGIC;
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            hctr     : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;


    component vertical_ctr
        Port (
            re_hsync : in  STD_LOGIC;
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            vctr     : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;


    component hsync_generator
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            ce_25MHz : in  STD_LOGIC;
            hctr     : in  STD_LOGIC_VECTOR(9 downto 0);
            hsync    : out STD_LOGIC
        );
    end component;


    component vsync_generator
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            ce_25MHz : in  STD_LOGIC;
            vctr     : in  STD_LOGIC_VECTOR(9 downto 0);
            vsync    : out STD_LOGIC
        );
    end component;


    component edge_detector
        Port (
            input              : in  STD_LOGIC;
            clk                : in  STD_LOGIC;
            reset              : in  STD_LOGIC;
            input_rising_edge  : out STD_LOGIC;
            input_falling_edge : out STD_LOGIC;
            input_sync         : out STD_LOGIC
        );
    end component;


    component blank_generator
        Port (
            hctr  : in  STD_LOGIC_VECTOR(9 downto 0);
            vctr  : in  STD_LOGIC_VECTOR(9 downto 0);
            blank : out STD_LOGIC
        );
    end component;


    component RGB_generator_Nexys_4_DDR
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
    end component;


    ----------------------------------------------------------------
    -- INTERNAL SIGNALS
    ----------------------------------------------------------------

    signal hctr_int : STD_LOGIC_VECTOR(9 downto 0);
    signal vctr_int : STD_LOGIC_VECTOR(9 downto 0);

    signal hsync_int : STD_LOGIC;
    signal vsync_int : STD_LOGIC;

    signal hsync_rising_edge : STD_LOGIC;

    signal hsync_falling_edge : STD_LOGIC;

    signal hsync_sync : STD_LOGIC;

    signal blank_int : STD_LOGIC;


begin

    ----------------------------------------------------------------
    -- HORIZONTAL COUNTER
    -- Counts from 0 to 799
    ----------------------------------------------------------------

    HORIZONTAL_COUNTER_INST : horizontal_ctr
        port map (
            ce_25MHz => ce_25MHz,
            clk      => clk,
            reset    => reset,
            hctr     => hctr_int
        );


    ----------------------------------------------------------------
    -- HORIZONTAL SYNC GENERATOR
    ----------------------------------------------------------------

    HSYNC_GENERATOR_INST : hsync_generator
        port map (
            clk      => clk,
            reset    => reset,
            ce_25MHz => ce_25MHz,
            hctr     => hctr_int,
            hsync    => hsync_int
        );


    ----------------------------------------------------------------
    -- EDGE DETECTOR
    --
    -- Detects the rising edge of HSYNC.
    -- This rising edge is used to advance the vertical counter.
    ----------------------------------------------------------------

    EDGE_DETECTOR_INST : edge_detector
        port map (
            input              => hsync_int,
            clk                => clk,
            reset              => reset,
            input_rising_edge  => hsync_rising_edge,
            input_falling_edge => hsync_falling_edge,
            input_sync         => hsync_sync
        );


    ----------------------------------------------------------------
    -- VERTICAL COUNTER
    -- Counts from 0 to 524.
    -- Advances on the rising edge of HSYNC.
    ----------------------------------------------------------------

    VERTICAL_COUNTER_INST : vertical_ctr
        port map (
            re_hsync => hsync_rising_edge,
            clk      => clk,
            reset    => reset,
            vctr     => vctr_int
        );


    ----------------------------------------------------------------
    -- VERTICAL SYNC GENERATOR
    ----------------------------------------------------------------

    VSYNC_GENERATOR_INST : vsync_generator
        port map (
            clk      => clk,
            reset    => reset,
            ce_25MHz => ce_25MHz,
            vctr     => vctr_int,
            vsync    => vsync_int
        );


    ----------------------------------------------------------------
    -- BLANK GENERATOR
    ----------------------------------------------------------------

    BLANK_GENERATOR_INST : blank_generator
        port map (
            hctr  => hctr_int,
            vctr  => vctr_int,
            blank => blank_int
        );


    ----------------------------------------------------------------
    -- RGB GENERATOR
    ----------------------------------------------------------------

    RGB_GENERATOR_INST : RGB_generator_Nexys_4_DDR
        port map (
            clk          => clk,
            reset        => reset,
            ce_25MHz     => ce_25MHz,
            blank        => blank_int,
            pixel_colour => pixel_colour,

            R => R,
            G => G,
            B => B
        );


    ----------------------------------------------------------------
    -- OUTPUT CONNECTIONS
    ----------------------------------------------------------------

    hctr  <= hctr_int;
    vctr  <= vctr_int;

    hsync <= hsync_int;
    vsync <= vsync_int;

end Structural;
