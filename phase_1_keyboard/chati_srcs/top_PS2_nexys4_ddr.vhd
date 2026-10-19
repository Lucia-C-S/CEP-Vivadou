library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Physical-board wrapper for the Nexys 4 DDR Rev. C.
-- Set this entity as the Vivado design top when using PS2_Nexys4_DDR_Master.xdc.
entity top_PS2_nexys4_ddr is
    port (
        CLK100MHZ : in  std_logic;
        CPU_RESETN: in  std_logic;
        kbclk   : in  std_logic;
        kbdata  : in  std_logic;
        LED       : out std_logic_vector(9 downto 0)
    );
end entity;

architecture Structural of top_PS2_nexys4_ddr is
    signal reset_active_high : std_logic;
    signal data_received     : std_logic_vector(7 downto 0);
    signal parity_error      : std_logic;
    signal end_data          : std_logic;
begin
    -- CPU_RESETN is low when pressed; the core reset is active high.
    reset_active_high <= not CPU_RESETN;

    PS2_INTERFACE_INST : entity work.PS2_basic_interface
        port map (
            clk           => CLK100MHZ,
            reset         => reset_active_high,
            kbclk         => kbclk,
            kbdata        => kbdata,
            data_received => data_received,
            parity_error  => parity_error,
            end_data      => end_data
        );

    -- LED[7:0] displays the received scan-code byte.
    LED(7 downto 0) <= data_received;
    LED(8)          <= end_data;
    LED(9)          <= parity_error;
end architecture;
