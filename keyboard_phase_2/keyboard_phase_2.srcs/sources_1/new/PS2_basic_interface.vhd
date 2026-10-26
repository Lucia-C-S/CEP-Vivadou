library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PS2_basic_interface is
    port (
        clk           : in  std_logic;
        reset         : in  std_logic;
        kbclk         : in  std_logic;
        kbdata        : in  std_logic;
        data_received : out std_logic_vector(7 downto 0);
        parity_error  : out std_logic;
        end_data      : out std_logic
    );
end entity;

architecture Structural of PS2_basic_interface is
    signal shift_en            : std_logic;
    signal count_en            : std_logic;
    signal count_clr           : std_logic;
    signal load_data           : std_logic;
    signal load_parity_error   : std_logic;
    signal kbclk_falling_edge  : std_logic;
    signal end_count           : std_logic;
begin
    OU_INST : entity work.PS2_operating_unit
        port map (
            clk                => clk,
            reset              => reset,
            kbclk              => kbclk,
            kbdata             => kbdata,
            shift_en           => shift_en,
            count_en           => count_en,
            count_clr          => count_clr,
            load_data          => load_data,
            load_parity_error  => load_parity_error,
            kbclk_falling_edge => kbclk_falling_edge,
            end_count          => end_count,
            data_received      => data_received,
            parity_error       => parity_error
        );

    CU_INST : entity work.PS2_basic_fsm
        port map (
            clk                => clk,
            reset              => reset,
            kbclk_falling_edge => kbclk_falling_edge,
            end_count          => end_count,
            shift_en           => shift_en,
            count_en           => count_en,
            count_clr          => count_clr,
            load_data          => load_data,
            load_parity_error  => load_parity_error,
            end_data           => end_data
        );
end architecture;
