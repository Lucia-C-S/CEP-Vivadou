library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Converts PS/2 Set-2 scan-code bytes into ASCII.
-- Only key presses generate ascii_valid. F0 release sequences are ignored.
-- E0 extended sequences are ignored by this simple extra-credit converter.
entity ps2_set2_to_ascii is
    port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        scan_valid  : in  std_logic;
        scan_code   : in  std_logic_vector(7 downto 0);
        ascii_code  : out std_logic_vector(7 downto 0);
        ascii_valid : out std_logic
    );
end ps2_set2_to_ascii;

architecture Behavioral of ps2_set2_to_ascii is
    signal break_pending    : std_logic := '0';
    signal extended_pending : std_logic := '0';

    function convert_set2(code : std_logic_vector(7 downto 0)) --se utiliza una funcion para su reutilizacion en un futuro
        return std_logic_vector is
    begin
        case code is
            -- solo ASCII en mayusculas
            when x"1C" => return x"41"; -- A
            when x"32" => return x"42"; -- B
            when x"21" => return x"43"; -- C
            when x"23" => return x"44"; -- D
            when x"24" => return x"45"; -- E
            when x"2B" => return x"46"; -- F
            when x"34" => return x"47"; -- G
            when x"33" => return x"48"; -- H
            when x"43" => return x"49"; -- I
            when x"3B" => return x"4A"; -- J
            when x"42" => return x"4B"; -- K
            when x"4B" => return x"4C"; -- L
            when x"3A" => return x"4D"; -- M
            when x"31" => return x"4E"; -- N
            when x"44" => return x"4F"; -- O
            when x"4D" => return x"50"; -- P
            when x"15" => return x"51"; -- Q
            when x"2D" => return x"52"; -- R
            when x"1B" => return x"53"; -- S
            when x"2C" => return x"54"; -- T
            when x"3C" => return x"55"; -- U
            when x"2A" => return x"56"; -- V
            when x"1D" => return x"57"; -- W
            when x"22" => return x"58"; -- X
            when x"35" => return x"59"; -- Y
            when x"1A" => return x"5A"; -- Z

            -- Number row, unshifted
            when x"45" => return x"30"; -- 0
            when x"16" => return x"31"; -- 1
            when x"1E" => return x"32"; -- 2
            when x"26" => return x"33"; -- 3
            when x"25" => return x"34"; -- 4
            when x"2E" => return x"35"; -- 5
            when x"36" => return x"36"; -- 6
            when x"3D" => return x"37"; -- 7
            when x"3E" => return x"38"; -- 8
            when x"46" => return x"39"; -- 9

            when x"29" => return x"20"; -- Space
            when x"5A" => return x"0D"; -- Enter / carriage return
            when x"66" => return x"08"; -- Backspace
            when others => return x"00"; -- Unsupported
        end case;
    end function;
begin
    process(clk)
        variable converted : std_logic_vector(7 downto 0);
    begin
        if rising_edge(clk) then
            ascii_valid <= '0';

            if reset = '1' then
                break_pending    <= '0';
                extended_pending <= '0';
                ascii_code       <= (others => '0');
            elsif scan_valid = '1' then
                if scan_code = x"F0" then
                    break_pending <= '1';
                elsif scan_code = x"E0" then
                    extended_pending <= '1';
                elsif break_pending = '1' then
                    -- This is the released key's code. Do not store it.
                    break_pending    <= '0';
                    extended_pending <= '0';
                elsif extended_pending = '1' then
                    -- Ignore simple E0 make sequences in this version.
                    extended_pending <= '0';
                else
                    converted := convert_set2(scan_code);
                    if converted /= x"00" then
                        ascii_code  <= converted;
                        ascii_valid <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
