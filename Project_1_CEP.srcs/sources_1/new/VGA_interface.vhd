```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_interface is
    Port (
        clk          : in  std_logic;
        reset        : in  std_logic;
        ce           : in  std_logic;
        pixel_colour : in  std_logic_vector(11 downto 0);

        hctr         : out std_logic_vector(9 downto 0);
        vctr         : out std_logic_vector(9 downto 0);

        hsync        : out std_logic;
        vsync        : out std_logic;

        R            : out std_logic_vector(3 downto 0);
        G            : out std_logic_vector(3 downto 0);
        B            : out std_logic_vector(3 downto 0)
    );
end vga_interface;


architecture Structural of vga_interface is

    signal h_count : std_logic_vector(9 downto 0);
    signal v_count : std_logic_vector(9 downto 0);

    signal h_tc : std_logic;

begin

    ----------------------------------------------------------------
    -- Horizontal counter: 0 to 799
    ----------------------------------------------------------------
    HORIZONTAL_COUNTER : entity horizontal_ctr
        port map (
            clk   => clk,
            reset => reset,
            ce    => ce,
            h_ctr => h_count,
            tc    => h_tc
        );


    ----------------------------------------------------------------
    -- Vertical counter: 0 to 524
    ----------------------------------------------------------------
    VERTICAL_COUNTER : entity vertical_ctr
        port map (
            clk   => clk,
            reset => reset,
            ce    => h_tc,
            v_ctr => v_count
        );


    ----------------------------------------------------------------
    -- Horizontal sync generator
    ----------------------------------------------------------------
    HORIZONTAL_SYNC : entity hsync_generator
        port map (
            h_ctr => h_count,
            hsync => hsync
        );


    ----------------------------------------------------------------
    -- Vertical sync generator
    ----------------------------------------------------------------
    VERTICAL_SYNC : entity vsync_generator
        port map (
            v_ctr => v_count,
            vsync => vsync
        );


    ----------------------------------------------------------------
    -- Output counters
    ----------------------------------------------------------------
    hctr <= h_count;
    vctr <= v_count;


    ----------------------------------------------------------------
    -- RGB output
    --
    -- Visible VGA region:
    --     horizontal: 0 to 639
    --     vertical:   0 to 479
    --
    -- pixel_colour:
    --     [11:8] = Red
    --     [7:4]  = Green
    --     [3:0]  = Blue
    ----------------------------------------------------------------
    R <= pixel_colour(11 downto 8)
         when (unsigned(h_count) < 640 and
               unsigned(v_count) < 480)
         else "0000";

    G <= pixel_colour(7 downto 4)
         when (unsigned(h_count) < 640 and
               unsigned(v_count) < 480)
         else "0000";

    B <= pixel_colour(3 downto 0)
         when (unsigned(h_count) < 640 and
               unsigned(v_count) < 480)
         else "0000";

end Structural;
