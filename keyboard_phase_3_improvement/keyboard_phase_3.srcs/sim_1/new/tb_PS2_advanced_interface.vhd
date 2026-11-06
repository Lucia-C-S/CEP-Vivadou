library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_PS2_advanced_interface is
end tb_PS2_advanced_interface;

architecture sim of tb_PS2_advanced_interface is

    signal clk          : std_logic := '0';
    signal reset        : std_logic := '1';
    signal kbclk        : std_logic := '1';
    signal kbdata       : std_logic := '1';

    signal data          : std_logic_vector(7 downto 0);
    signal key           : std_logic_vector(7 downto 0);
    signal end_key       : std_logic;
    signal new_data      : std_logic;
    signal new_key       : std_logic;
    signal parity_error  : std_logic;

    constant CLK_PERIOD : time := 10 ns;

    -- Send one PS/2 bit.
    procedure send_bit(
        signal ps2_clk  : out std_logic;
        signal ps2_data : out std_logic;
        constant b     : in std_logic
    ) is
    begin
        ps2_data <= b;
        wait for 20 us;

        ps2_clk <= '0';
        wait for 20 us;

        ps2_clk <= '1';
        wait for 20 us;
    end procedure;

    -- Send a complete PS/2 frame:
    -- start, 8 data bits (LSB first), odd parity, stop.
    procedure send_byte(
        signal ps2_clk  : out std_logic;
        signal ps2_data : out std_logic;
        constant value  : in std_logic_vector(7 downto 0)
    ) is
        variable ones  : integer := 0;
        variable parity : std_logic;
    begin
        -- Calculate odd parity.
        ones := 0;
        for i in 0 to 7 loop
            if value(i) = '1' then
                ones := ones + 1;
            end if;
        end loop;

        if (ones mod 2) = 0 then
            parity := '1';
        else
            parity := '0';
        end if;

        send_bit(ps2_clk, ps2_data, '0'); -- Start

        for i in 0 to 7 loop
            send_bit(ps2_clk, ps2_data, value(i));
        end loop;

        send_bit(ps2_clk, ps2_data, parity);
        send_bit(ps2_clk, ps2_data, '1'); -- Stop

        ps2_data <= '1';
        ps2_clk  <= '1';
        wait for 100 us;
    end procedure;

begin

    -- 100 MHz system clock.
    clk <= not clk after CLK_PERIOD / 2;

    DUT : entity work.PS2_advanced_interface
        port map (
            clk          => clk,
            kbclk        => kbclk,
            kbdata       => kbdata,
            reset        => reset,
            data         => data,
            end_key      => end_key,
            key          => key,
            new_data     => new_data,
            new_key      => new_key,
            parity_error => parity_error
        );

    STIMULUS : process
    begin
        -- Reset.
        reset <= '1';
        kbclk <= '1';
        kbdata <= '1';
        wait for 200 ns;
        reset <= '0';

        wait for 100 us;

        -- First key press.
        send_byte(kbclk, kbdata, x"1C");

        -- Release prefix and release scan code.
        send_byte(kbclk, kbdata, x"F0");
        send_byte(kbclk, kbdata, x"1C");

        -- Second key press.
        send_byte(kbclk, kbdata, x"32");

        -- Release the second key.
        send_byte(kbclk, kbdata, x"F0");
        send_byte(kbclk, kbdata, x"32");

        wait for 500 us;
        report "Simulation finished" severity note;
        wait;
    end process;

end sim;