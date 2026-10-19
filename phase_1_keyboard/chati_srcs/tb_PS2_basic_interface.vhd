library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.all;

entity tb_PS2_basic_interface is
end entity;

architecture sim of tb_PS2_basic_interface is
    signal clk           : std_logic := '0';
    signal reset         : std_logic := '1';
    signal kbclk         : std_logic := '1';
    signal kbdata        : std_logic := '1';
    signal data_received : std_logic_vector(7 downto 0);
    signal parity_error  : std_logic;
    signal end_data      : std_logic;

    type frame_bits_t is array (0 to 10) of std_logic;

    procedure send_frame(
        signal serial_clk  : out std_logic;
        signal serial_data : out std_logic;
        constant payload  : in  std_logic_vector(7 downto 0);
        constant corrupt_parity : in boolean
    ) is
        variable frame_value   : frame_bits_t;
        variable parity_value : std_logic;
    begin
        frame_value(0) := '0'; -- Start bit.
        for i in 0 to 7 loop
            frame_value(i + 1) := payload(i); -- LSB first.
        end loop;

        parity_value := '0';
        for i in 0 to 7 loop
            parity_value := parity_value xor payload(i);
        end loop;
        parity_value := not parity_value; -- Odd total parity.
        if corrupt_parity then
            parity_value := not parity_value;
        end if;
        frame_value(9)  := parity_value;
        frame_value(10) := '1'; -- Stop bit.

        for i in frame_value'range loop
            -- Data is established while KBCLK is high and remains stable
            -- across its falling edge, as required by the lab handout.
            serial_data <= frame_value(i);
            serial_clk  <= '1';
            wait for 20 us;
            serial_clk  <= '0';
            wait for 20 us;
        end loop;

        serial_clk  <= '1';
        serial_data <= '1';
        wait for 100 us;
    end procedure;
begin
    DUT : entity work.PS2_basic_interface
        port map (
            clk           => clk,
            reset         => reset,
            kbclk         => kbclk,
            kbdata        => kbdata,
            data_received => data_received,
            parity_error  => parity_error,
            end_data      => end_data
        );

    -- Nexys 4 DDR system clock: 100 MHz (10 ns period).
    clk <= not clk after 5 ns;

    reset_process : process
    begin
        reset <= '1';
        kbclk <= '1';
        kbdata <= '1';
        wait for 200 ns;
        wait until rising_edge(clk);
        reset <= '0';
        wait;
    end process;

    stimulus : process
    begin
        wait until reset = '0';
        wait for 5 us;

        -- Required case 1: scan code 0x11 with correct odd parity.
        send_frame(kbclk, kbdata, x"11", false);

        -- Required case 2: scan code 0x22 with deliberately inverted parity.
        send_frame(kbclk, kbdata, x"22", true);

        wait;
    end process;

    checker : process
        variable pulse_start : time;
    begin
        wait until reset = '0';

        wait until end_data = '1';
        pulse_start := now;
        wait for 1 ns;
        assert data_received = x"11"
            report "First frame: expected data_received = 0x11" severity error;
        assert parity_error = '0'
            report "First frame: expected parity_error = 0" severity error;
        wait until end_data = '0';
        assert now - pulse_start = 10 ns
            report "First end_data pulse was not exactly one clk period" severity error;

        wait until end_data = '1';
        pulse_start := now;
        wait for 1 ns;
        assert data_received = x"22"
            report "Second frame: expected data_received = 0x22" severity error;
        assert parity_error = '1'
            report "Second frame: expected parity_error = 1" severity error;
        wait until end_data = '0';
        assert now - pulse_start = 10 ns
            report "Second end_data pulse was not exactly one clk period" severity error;

        report "PASS: two PS/2 frames checked (valid and parity-error cases)." severity note;
        stop;
        wait;
    end process;

    watchdog : process
    begin
        wait for 3 ms;
        assert false report "TIMEOUT: did not observe both PS/2 frames" severity failure;
        wait;
    end process;
end architecture;
