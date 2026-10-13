library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ball_movement is
end tb_ball_movement;

architecture sim of tb_ball_movement is

    constant CLK_PERIOD : time := 10 ns;

    signal clk       : std_logic := '0';
    signal reset     : std_logic := '1';
    signal re_vsync  : std_logic := '0';
    signal fe_vsync  : std_logic := '0';

    signal hposition : std_logic_vector(9 downto 0);
    signal vposition : std_logic_vector(9 downto 0);

    constant INITIAL_H : integer := 200;
    constant INITIAL_V : integer := 250;

    constant MAX_H : integer := 624;
    constant MAX_V : integer := 464;

begin

    -- 100 MHz clock
    clk <= not clk after CLK_PERIOD / 2;

    -- Device under test
    DUT : entity work.ball_movement
        port map (
            clk       => clk,
            reset     => reset,
            re_vsync  => re_vsync,
            fe_vsync  => fe_vsync,
            hposition => hposition,
            vposition => vposition
        );

    stimulus : process

        procedure pulse(signal enable_signal : out std_logic) is
        begin
            enable_signal <= '1';
            wait until rising_edge(clk);
            wait for 1 ns;
            enable_signal <= '0';
        end procedure;

        procedure simulate_frame is
        begin
            -- Calculate and store the next position
            pulse(re_vsync);

            -- Allow time between the two enables
            wait until rising_edge(clk);
            wait until rising_edge(clk);

            -- Transfer auxiliary position to displayed position
            pulse(fe_vsync);

            wait for 1 ns;
        end procedure;

        variable h       : integer;
        variable v       : integer;
        variable prev_h  : integer;
        variable prev_v  : integer;
        variable hit_h   : boolean := false;
        variable hit_v   : boolean := false;

    begin

        report "Starting ball_movement test";

        -- Reset
        reset <= '1';
        wait for 30 ns;

        reset <= '0';
        wait until rising_edge(clk);
        wait for 1 ns;

        -- TEST 1: Initial position
        assert to_integer(unsigned(hposition)) = INITIAL_H
            report "FAIL: Initial horizontal position is incorrect"
            severity error;

        assert to_integer(unsigned(vposition)) = INITIAL_V
            report "FAIL: Initial vertical position is incorrect"
            severity error;

        report "PASS: Initial position is (200,250)";

        -- TEST 2: One frame of movement
        prev_h := to_integer(unsigned(hposition));
        prev_v := to_integer(unsigned(vposition));

        simulate_frame;

        h := to_integer(unsigned(hposition));
        v := to_integer(unsigned(vposition));

        assert h = prev_h + 4
            report "FAIL: Horizontal movement after frame 1"
            severity error;

        assert v = prev_v + 3
            report "FAIL: Vertical movement after frame 1"
            severity error;

        report "PASS: First frame moves ball to (204,253)";

        -- TEST 3: Position remains unchanged without enables
        prev_h := h;
        prev_v := v;

        for i in 1 to 5 loop
            wait until rising_edge(clk);
        end loop;

        assert to_integer(unsigned(hposition)) = prev_h
            report "FAIL: Horizontal position changed without an enable"
            severity error;

        assert to_integer(unsigned(vposition)) = prev_v
            report "FAIL: Vertical position changed without an enable"
            severity error;

        report "PASS: Position holds without VSYNC enables";

        -- TEST 4: Movement and boundary checks
        prev_h := to_integer(unsigned(hposition));
        prev_v := to_integer(unsigned(vposition));

        for i in 1 to 200 loop

            simulate_frame;

            h := to_integer(unsigned(hposition));
            v := to_integer(unsigned(vposition));

            assert h <= MAX_H
                report "FAIL: Horizontal boundary exceeded"
                severity error;

            assert v <= MAX_V
                report "FAIL: Vertical boundary exceeded"
                severity error;

            assert h >= 0 and v >= 0
                report "FAIL: Negative position"
                severity error;

            if h < prev_h then
                hit_h := true;
            end if;

            if v < prev_v then
                hit_v := true;
            end if;

            prev_h := h;
            prev_v := v;

        end loop;

        assert hit_h
            report "FAIL: Horizontal bounce was not detected"
            severity error;

        assert hit_v
            report "FAIL: Vertical bounce was not detected"
            severity error;

        report "PASS: Ball stays within bounds and bounces";

        report "ALL BALL MOVEMENT TESTS COMPLETED";

        wait;
    end process;

end sim;

