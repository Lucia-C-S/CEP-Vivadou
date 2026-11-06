library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_PS2_nexys4_ddr is
    port (
        CLK100MHZ : in  STD_LOGIC;
        CPU_RESETN : in STD_LOGIC;
        kbclk   : in  STD_LOGIC;
        kbdata  : in  STD_LOGIC;
        LED       : out STD_LOGIC_VECTOR(15 downto 0)
    );
end top_PS2_nexys4_ddr;

architecture Structural of top_PS2_nexys4_ddr is

    signal reset_int     : STD_LOGIC;
    signal data_int      : STD_LOGIC_VECTOR(7 downto 0);
    signal key_int       : STD_LOGIC_VECTOR(7 downto 0);
    signal end_key_int   : STD_LOGIC;
    signal new_data_int  : STD_LOGIC;
    signal new_key_int   : STD_LOGIC;
    signal parity_error_int : STD_LOGIC;

begin

    -- CPU_RESETN is active-low; the design reset is active-high.
    reset_int <= not CPU_RESETN;

    PS2_INST : entity work.PS2_advanced_interface
        port map (
            clk          => CLK100MHZ,
            kbclk        => kbclk,
            kbdata       => kbdata,
            reset        => reset_int,
            data         => data_int,
            end_key      => end_key_int,
            key          => key_int,
            new_data     => new_data_int,
            new_key      => new_key_int,
            parity_error => parity_error_int
        );

    -- Show the latest received byte and latest pressed key.
    LED(7 downto 0)  <= data_int;
    LED(15 downto 8) <= key_int;

end Structural;