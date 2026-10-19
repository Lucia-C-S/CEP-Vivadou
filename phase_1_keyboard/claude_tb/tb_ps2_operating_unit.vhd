library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ps2_tb_pkg.all;

entity tb_ps2_operating_unit is
end tb_ps2_operating_unit;

architecture sim of tb_ps2_operating_unit is
    constant PC_DATA  : std_logic_vector(7 downto 0) := x"11";  -- 11 for PC1, 22 for PC2, ...
    constant ERR_DATA : std_logic_vector(7 downto 0) := not PC_DATA;

    signal clk, reset : std_logic := '0';
    signal kbclk      : std_logic := '1';
    signal kbdata     : std_logic := '1';
    signal shift_en, count_en, count_clr   : std_logic := '0';
    signal load_data, load_parity_error    : std_logic := '0';
    signal kbclk_falling_edge, end_count   : std_logic;
    signal parity_error                    : std_logic;
    signal data_received                   : std_logic_vector(7 downto 0);

    signal test_data : std_logic_vector(10 downto 0) := (others => '1');
    signal exp_data  : std_logic_vector(7 downto 0)  := (others => '0');
    signal exp_perr  : std_logic := '0';
begin

    DUT : entity work.PS2_operating_unit
        port map (
            clk => clk, reset => reset,
            kbclk => kbclk, kbdata => kbdata,
            shift_en => shift_en, count_en => count_en, count_clr => count_clr,
            load_data => load_data, load_parity_error => load_parity_error,
            kbclk_falling_edge => kbclk_falling_edge, end_count => end_count,
            data_received => data_received, parity_error => parity_error);

    clk <= not clk after CLK_PERIOD/2;

    -- Stand-in for the control unit, one-clock pulses after each kbclk falling edge
    mock_cu : process
    begin
        loop
            wait until rising_edge(clk) and kbclk_falling_edge = '1';
            wait until rising_edge(clk);
            shift_en <= '1'; count_en <= '1';
            wait until rising_edge(clk);
            shift_en <= '0'; count_en <= '0';
            wait until rising_edge(clk);
            wait until rising_edge(clk);
            if end_count = '1' then
                load_data <= '1'; load_parity_error <= '1';
                wait until rising_edge(clk);
                load_data <= '0'; load_parity_error <= '0';
                count_clr <= '1';
                wait until rising_edge(clk);
                count_clr <= '0';
                wait until rising_edge(clk);
                assert data_received = exp_data
                    report "data_received mismatch" severity error;
                assert parity_error = exp_perr
                    report "parity_error mismatch" severity error;
            end if;
        end loop;
    end process;

    stim : process
    begin
        reset <= '1';
        wait for 10 * CLK_PERIOD;
        reset <= '0';
        wait for 10 * CLK_PERIOD;

        -- 1: correct parity
        exp_data <= PC_DATA;  exp_perr <= '0';
        test_data <= make_frame(PC_DATA, false);
        send_frame(make_frame(PC_DATA, false), kbclk, kbdata);
        wait for 2 * KBCLK_T;

        -- 2: parity error (different data, so a stale register cannot pass)
        exp_data <= ERR_DATA; exp_perr <= '1';
        test_data <= make_frame(ERR_DATA, true);
        send_frame(make_frame(ERR_DATA, true), kbclk, kbdata);
        wait for 2 * KBCLK_T;

        -- 3: correct again, F0 (release code), error flag must clear
        exp_data <= x"F0";    exp_perr <= '0';
        test_data <= make_frame(x"F0", false);
        send_frame(make_frame(x"F0", false), kbclk, kbdata);
        wait for 2 * KBCLK_T;

        report "tb_ps2_operating_unit finished" severity note;
        wait;
    end process;

end sim;
