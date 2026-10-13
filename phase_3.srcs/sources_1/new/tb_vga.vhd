library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_board_VGA_interface_objects is
end tb_top_board_VGA_interface_objects;

architecture Behavioral of tb_top_board_VGA_interface_objects is

    component top_VGA_interface_objects
        Port (
            clk        : in  STD_LOGIC;
            CPU_RESETN : in  STD_LOGIC;
            SW         : in  STD_LOGIC_VECTOR(9 downto 0);

            vsync_led  : out STD_LOGIC;
            vsync_os   : out STD_LOGIC;
            hsync_os   : out STD_LOGIC;
            VGA_hsync  : out STD_LOGIC;
            VGA_vsync  : out STD_LOGIC;
            VGA_R      : out STD_LOGIC_VECTOR(3 downto 0);
            VGA_G      : out STD_LOGIC_VECTOR(3 downto 0);
            VGA_B      : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Inputs
    signal clk        : STD_LOGIC := '0';
    signal CPU_RESETN : STD_LOGIC := '0';
    signal SW         : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');

    -- Outputs
    signal vsync_led : STD_LOGIC;
    signal vsync_os  : STD_LOGIC;
    signal hsync_os  : STD_LOGIC;
    signal VGA_hsync : STD_LOGIC;
    signal VGA_vsync : STD_LOGIC;
    signal VGA_R     : STD_LOGIC_VECTOR(3 downto 0);
    signal VGA_G     : STD_LOGIC_VECTOR(3 downto 0);
    signal VGA_B     : STD_LOGIC_VECTOR(3 downto 0);

begin

    DUT : tb_top_board_VGA_interface_objects
        port map (
            clk        => clk,
            CPU_RESETN => CPU_RESETN,
            SW         => SW,

            vsync_led  => vsync_led,
            vsync_os   => vsync_os,
            hsync_os   => hsync_os,
            VGA_hsync  => VGA_hsync,
            VGA_vsync  => VGA_vsync,
            VGA_R      => VGA_R,
            VGA_G      => VGA_G,
            VGA_B      => VGA_B
        );

    -- 100 MHz clock: 10 ns period
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stimulus : process
    begin
        -- Assert active-low board reset
        CPU_RESETN <= '0';
        SW <= std_logic_vector(to_unsigned(300, SW'length));
        wait for 200 ns;

        -- Release reset
        CPU_RESETN <= '1';

        -- Allow the VGA counters and synchronisation to run
        wait for 100 us;

        -- Move the wall horizontally to x = 100
        SW <= std_logic_vector(to_unsigned(100, SW'length));
        wait for 100 us;

        -- Move the wall horizontally to x = 600
        SW <= std_logic_vector(to_unsigned(600, SW'length));
        wait for 100 us;

        -- Return the wall to x = 300
        SW <= std_logic_vector(to_unsigned(300, SW'length));
        wait for 100 us;

        -- End stimulus; keep the simulation running
        wait;
    end process;

end Behavioral;