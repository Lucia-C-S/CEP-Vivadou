library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_display_PS2_ascii_interface is
end tb_top_display_PS2_ascii_interface;

architecture Simulation of tb_top_display_PS2_ascii_interface is
    constant CLK_PERIOD : time := 10 ns;
    constant HALF_PS2   : time := 25 us;
    signal clk100mhz : std_logic := '0';
    signal cpu_resetn : std_logic := '0';
    signal kbclk, kbdata : std_logic := '1';
    signal led : std_logic_vector(15 downto 0);
    signal an : std_logic_vector(7 downto 0);
    signal ca, cb, cc, cd, ce, cf, cg, dp : std_logic;

    procedure send_ps2_byte(
        signal ps2_clk : out std_logic;
        signal ps2_data : out std_logic;
        constant value : in std_logic_vector(7 downto 0)
    ) is
        variable parity_bit : std_logic := '1';
        variable frame : std_logic_vector(10 downto 0);
    begin
        for i in 0 to 7 loop
            parity_bit := parity_bit xor value(i);
        end loop;
        frame(0) := '0';
        for i in 0 to 7 loop frame(i+1) := value(i); end loop;
        frame(9) := parity_bit;
        frame(10) := '1';
        for i in 0 to 10 loop
            ps2_data <= frame(i); wait for HALF_PS2;
            ps2_clk <= '0'; wait for HALF_PS2;
            ps2_clk <= '1';
        end loop;
        ps2_data <= '1'; wait for 100 us;
    end procedure;

    procedure press_release(
        signal ps2_clk : out std_logic;
        signal ps2_data : out std_logic;
        constant code : in std_logic_vector(7 downto 0)
    ) is
    begin
        send_ps2_byte(ps2_clk, ps2_data, code);
        send_ps2_byte(ps2_clk, ps2_data, x"F0");
        send_ps2_byte(ps2_clk, ps2_data, code);
    end procedure;
begin
    clk100mhz <= not clk100mhz after CLK_PERIOD/2;

    DUT : entity work.top_display_PS2_ascii_interface
        port map (
            CLK100MHZ => clk100mhz, CPU_RESETN => cpu_resetn,
            kbclk => kbclk, kbdata => kbdata, LED => led, AN => an,
            CA => ca, CB => cb, CC => cc, CD => cd,
            CE => ce, CF => cf, CG => cg, DP => dp
        );

    stimulus : process
    begin
        cpu_resetn <= '0'; wait for 200 ns;
        wait until rising_edge(clk100mhz); cpu_resetn <= '1';
        wait for 10 us;

        -- Six different key presses. Releases must not enter the history.
        press_release(kbclk, kbdata, x"1C"); -- A -> 41
        press_release(kbclk, kbdata, x"32"); -- B -> 42
        press_release(kbclk, kbdata, x"21"); -- C -> 43
        press_release(kbclk, kbdata, x"23"); -- D -> 44
        press_release(kbclk, kbdata, x"24"); -- E -> 45
        press_release(kbclk, kbdata, x"2B"); -- F -> 46
        wait for 200 us;

        -- r6=A (41), r5=B (42), so LED(high:low)=4142.
        assert led = x"4142"
            report "FAIL: expected LED=4142. ASCII history or break filtering is wrong."
            severity error;
        report "PASS: ASCII top-level test completed; LED=4142" severity note;
        wait;
    end process;
end Simulation;
