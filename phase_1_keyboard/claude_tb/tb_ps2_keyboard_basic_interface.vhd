library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ps2_tb_pkg.all;

entity tb_ps2_keyboard_basic_interface is
end tb_ps2_keyboard_basic_interface;

architecture sim of tb_ps2_keyboard_basic_interface is
    constant PC_DATA  : std_logic_vector(7 downto 0) := x"11";  -- 11 for PC1, 22 for PC2, ...
    constant ERR_DATA : std_logic_vector(7 downto 0) := not PC_DATA;

    signal clk, reset : std_logic := '0';
    signal kbclk      : std_logic := '1';
    signal kbdata     : std_logic := '1';
    signal data       : std_logic_vector(7 downto 0);
    signal end_data, parity_error : std_logic;

    signal test_data : std_logic_vector(10 downto 0) := (others => '1');
    signal exp_data  : std_logic_vector(7 downto 0)  := (others => '0');
    signal exp_perr  : std_logic := '0';
    signal n_pulses  : integer := 0;
begin

    DUT : entity work.ps2_keyboard_basic_interface
        port map (clk => clk, kbclk => kbclk, kbdata => kbdata, reset => reset,
                  data => data, end_data => end_data, parity_error => parity_error);

    clk <= not clk after CLK_PERIOD/2;

    -- Checks: end_data is one clk wide, and data/parity_error are already valid
    -- in the middle of the end_data pulse
    checker : process
        variable t0 : time;
    begin
        wait until rising_edge(end_data);
        t0 := now;
        wait for CLK_PERIOD/2;
        assert data = exp_data
            report "data not valid while end_data is high" severity error;
        assert parity_error = exp_perr
            report "parity_error mismatch while end_data is high" severity error;
        wait until falling_edge(end_data);
        assert abs((now - t0) - CLK_PERIOD) < 1 ns
            report "end_data is not one clock period wide" severity error;
        n_pulses <= n_pulses + 1;
    end process;

    stim : process
    begin
        reset <= '1';
        wait for 10 * CLK_PERIOD;
        reset <= '0';
        wait for 10 * CLK_PERIOD;

        exp_data <= PC_DATA;  exp_perr <= '0';
        test_data <= make_frame(PC_DATA, false);
        send_frame(make_frame(PC_DATA, false), kbclk, kbdata);
        wait for 2 * KBCLK_T;

        exp_data <= ERR_DATA; exp_perr <= '1';
        test_data <= make_frame(ERR_DATA, true);
        send_frame(make_frame(ERR_DATA, true), kbclk, kbdata);
        wait for 2 * KBCLK_T;

        exp_data <= x"F0";    exp_perr <= '0';
        test_data <= make_frame(x"F0", false);
        send_frame(make_frame(x"F0", false), kbclk, kbdata);
        wait for 2 * KBCLK_T;

        assert n_pulses = 3 report "expected exactly 3 end_data pulses" severity error;
        assert data = x"F0" and parity_error = '0'
            report "outputs not stable after last frame" severity error;
        report "tb_ps2_keyboard_basic_interface finished" severity note;
        wait;
    end process;

end sim;
