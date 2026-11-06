library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_display_PS2_advanced_interface is
end tb_top_display_PS2_advanced_interface;

architecture Simulation of tb_top_display_PS2_advanced_interface is
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz
    constant HALF_PS2   : time := 25 us; -- 20 kHz PS/2 clock

    signal clk100mhz  : std_logic := '0';
    signal cpu_resetn : std_logic := '0';
    signal kbclk      : std_logic := '1';
    signal kbdata     : std_logic := '1';
    signal led        : std_logic_vector(15 downto 0);
    signal an         : std_logic_vector(7 downto 0);
    signal ca, cb, cc, cd, ce, cf, cg, dp : std_logic;

    procedure send_ps2_byte(
        signal ps2_clk  : out std_logic;
        signal ps2_data : out std_logic;
        constant value  : in  std_logic_vector(7 downto 0)
    ) is
        variable parity_bit : std_logic := '1';
        variable frame      : std_logic_vector(10 downto 0);
    begin
        -- Odd parity: parity_bit starts at 1 and toggles for every data '1'.
        parity_bit := '1';
        for i in 0 to 7 loop
            parity_bit := parity_bit xor value(i);
        end loop;

        frame(0)  := '0';       -- start
        frame(8 downto 1) := value; -- transmitted LSB first by loop below
        frame(9)  := parity_bit;
        frame(10) := '1';       -- stop

        ps2_clk  <= '1';
        ps2_data <= '1';
        wait for HALF_PS2;

        for i in 0 to 10 loop
            -- Data changes while clock is high and is stable at falling edge.
            ps2_data <= frame(i);
            wait for HALF_PS2;
            ps2_clk <= '0';
            wait for HALF_PS2;
            ps2_clk <= '1';
        end loop;

        ps2_data <= '1';
        ps2_clk  <= '1';
        wait for 100 us;
    end procedure;

    procedure press_and_release(
        signal ps2_clk  : out std_logic;
        signal ps2_data : out std_logic;
        constant scan_code : in std_logic_vector(7 downto 0)
    ) is
    begin
        send_ps2_byte(ps2_clk, ps2_data, scan_code); -- make
        wait for 100 us;
        send_ps2_byte(ps2_clk, ps2_data, x"F0");    -- break prefix
        send_ps2_byte(ps2_clk, ps2_data, scan_code); -- released key code
        wait for 100 us;
    end procedure;
begin
    clk100mhz <= not clk100mhz after CLK_PERIOD/2;

    DUT : entity work.top_display_PS2_advanced_interface
        port map (
            CLK100MHZ => clk100mhz, CPU_RESETN => cpu_resetn,
            kbclk => kbclk, kbdata => kbdata, LED => led, AN => an,
            CA => ca, CB => cb, CC => cc, CD => cd,
            CE => ce, CF => cf, CG => cg, DP => dp
        );

    stimulus : process
    begin
        kbclk      <= '1';
        kbdata     <= '1';
        cpu_resetn <= '0';
        wait for 200 ns;
        wait until rising_edge(clk100mhz);
        cpu_resetn <= '1';
        wait for 10 us;

        -- Four different keys: A=1C, B=32, C=21, D=23 (Set-2 scan codes).
        press_and_release(kbclk, kbdata, x"1C");
        press_and_release(kbclk, kbdata, x"32");
        press_and_release(kbclk, kbdata, x"21");
        press_and_release(kbclk, kbdata, x"23");

        wait for 200 us;

        -- Final six bytes, oldest to newest: 21 F0 21 23 F0 23.
        -- Therefore r6=21, r5=F0 and LEDs must show 21F0.
        assert led = x"21F0"
            report "FAIL: expected LED = 21F0, got a different value"
            severity error;

        report "PASS: four key press/release sequences completed; LED = 21F0"
            severity note;
        wait;
    end process;
end Simulation;
