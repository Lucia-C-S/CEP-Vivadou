library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package ps2_tb_pkg is
    constant CLK_PERIOD : time := 10 ns;   -- 100 MHz system clock
    constant KBCLK_T    : time := 40 us;   -- 25 kHz, inside the required 10-50 kHz

    -- frame(0) is the first bit sent: start, D0..D7, parity, stop
    function make_frame(d : std_logic_vector(7 downto 0); bad_parity : boolean)
        return std_logic_vector;

    -- kbdata changes with the rising edge of kbclk, so it is stable at the falling edge
    procedure send_frame(frame : in std_logic_vector(10 downto 0);
                         signal kbclk, kbdata : out std_logic);
end package;

package body ps2_tb_pkg is

    function make_frame(d : std_logic_vector(7 downto 0); bad_parity : boolean)
        return std_logic_vector is
        variable x : std_logic := '0';
        variable p : std_logic;
        variable f : std_logic_vector(10 downto 0);
    begin
        for i in 0 to 7 loop
            x := x xor d(i);
        end loop;
        p := not x;                       -- odd parity: total number of ones odd
        if bad_parity then
            p := not p;
        end if;
        f(0)          := '0';             -- start
        f(8 downto 1) := d;               -- D0 first
        f(9)          := p;
        f(10)         := '1';             -- stop
        return f;
    end function;

    procedure send_frame(frame : in std_logic_vector(10 downto 0);
                         signal kbclk, kbdata : out std_logic) is
    begin
        for i in 0 to 10 loop
            kbdata <= frame(i);
            wait for KBCLK_T/2;
            kbclk  <= '0';
            wait for KBCLK_T/2;
            kbclk  <= '1';
        end loop;
        kbdata <= '1';
    end procedure;

end package body;
