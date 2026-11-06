library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ps2_set2_to_ascii is
end tb_ps2_set2_to_ascii;

architecture Simulation of tb_ps2_set2_to_ascii is
    constant CLK_PERIOD : time := 10 ns;
    signal clk, reset, scan_valid, ascii_valid : std_logic := '0';
    signal scan_code, ascii_code : std_logic_vector(7 downto 0) := (others => '0');

    procedure send_byte(
        signal clk_s       : in  std_logic;
        signal valid_s     : out std_logic;
        signal scan_s      : out std_logic_vector(7 downto 0);
        constant value     : in  std_logic_vector(7 downto 0)
    ) is
    begin
        scan_s  <= value;
        valid_s <= '1';
        wait until rising_edge(clk_s);
        valid_s <= '0';
        wait until rising_edge(clk_s);
    end procedure;

    procedure expect_ascii(
        signal valid_s : in std_logic;
        signal ascii_s : in std_logic_vector(7 downto 0);
        constant expected : in std_logic_vector(7 downto 0);
        constant label_text : in string
    ) is
    begin
        assert valid_s = '1'
            report "FAIL: ascii_valid was not asserted for " & label_text
            severity error;
        assert ascii_s = expected
            report "FAIL: wrong ASCII value for " & label_text
            severity error;
    end procedure;
begin
    clk <= not clk after CLK_PERIOD/2;

    DUT : entity work.ps2_set2_to_ascii
        port map (
            clk => clk, reset => reset, scan_valid => scan_valid,
            scan_code => scan_code, ascii_code => ascii_code,
            ascii_valid => ascii_valid
        );

    stimulus : process
    begin
        reset <= '1';
        wait for 3 * CLK_PERIOD;
        wait until falling_edge(clk);
        reset <= '0';

        -- A make: Set-2 1C -> ASCII 41.
        scan_code <= x"1C"; scan_valid <= '1';
        wait until rising_edge(clk); wait for 1 ns;
        expect_ascii(ascii_valid, ascii_code, x"41", "A make");
        scan_valid <= '0'; wait until rising_edge(clk); wait for 1 ns;

        -- A break: F0 1C must produce no additional ASCII value.
        send_byte(clk, scan_valid, scan_code, x"F0");
        assert ascii_valid = '0' report "FAIL: F0 produced ASCII" severity error;
        send_byte(clk, scan_valid, scan_code, x"1C");
        assert ascii_valid = '0' report "FAIL: released A produced ASCII" severity error;

        -- B make: 32 -> 42.
        scan_code <= x"32"; scan_valid <= '1';
        wait until rising_edge(clk); wait for 1 ns;
        expect_ascii(ascii_valid, ascii_code, x"42", "B make");
        scan_valid <= '0'; wait until rising_edge(clk); wait for 1 ns;

        -- Number 1: 16 -> 31.
        scan_code <= x"16"; scan_valid <= '1';
        wait until rising_edge(clk); wait for 1 ns;
        expect_ascii(ascii_valid, ascii_code, x"31", "number 1 make");
        scan_valid <= '0'; wait until rising_edge(clk); wait for 1 ns;

        -- Unsupported code must not assert ascii_valid.
        send_byte(clk, scan_valid, scan_code, x"76"); -- Escape unsupported
        assert ascii_valid = '0' report "FAIL: unsupported code produced ASCII" severity error;

        report "PASS: Set-2 to ASCII converter test completed" severity note;
        wait;
    end process;
end Simulation;
