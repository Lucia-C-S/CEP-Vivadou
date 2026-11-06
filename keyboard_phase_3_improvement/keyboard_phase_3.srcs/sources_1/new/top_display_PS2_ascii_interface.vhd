library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Extra-credit Phase 3 top: stores ASCII values rather than raw PS/2 bytes.
entity top_display_PS2_ascii_interface is
    port (
        CLK100MHZ  : in  std_logic;
        CPU_RESETN : in  std_logic;
        kbclk      : in  std_logic;
        kbdata     : in  std_logic;
        LED        : out std_logic_vector(15 downto 0);
        AN         : out std_logic_vector(7 downto 0);
        CA, CB, CC, CD, CE, CF, CG, DP : out std_logic
    );
end top_display_PS2_ascii_interface;

architecture Structural of top_display_PS2_ascii_interface is
    signal reset_int, end_key_int, new_data_int, new_key_int : std_logic;
    signal parity_error_int : std_logic;
    signal data_int, key_int : std_logic_vector(7 downto 0);
    signal ascii_int : std_logic_vector(7 downto 0);
    signal ascii_valid_int : std_logic;
    signal r1, r2, r3, r4, r5, r6 : std_logic_vector(7 downto 0);
    signal seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7 : std_logic_vector(7 downto 0);
    signal ce_1kHz_int, display_load : std_logic := '0';
begin
    reset_int <= not CPU_RESETN;

    PS2_INST : entity work.PS2_advanced_interface
        port map (
            clk => CLK100MHZ, kbclk => kbclk, kbdata => kbdata,
            reset => reset_int, data => data_int, end_key => end_key_int,
            key => key_int, new_data => new_data_int, new_key => new_key_int,
            parity_error => parity_error_int
        );

    ASCII_INST : entity work.ps2_set2_to_ascii
        port map (
            clk => CLK100MHZ, reset => reset_int,
            scan_valid => new_data_int, scan_code => data_int,
            ascii_code => ascii_int, ascii_valid => ascii_valid_int
        );

    -- Shift only valid ASCII key presses. F0 and release bytes are not stored.
    REG1 : entity work.register_bank_8bit port map
        (CLK100MHZ, reset_int, ascii_valid_int, ascii_int, r1);
    REG2 : entity work.register_bank_8bit port map
        (CLK100MHZ, reset_int, ascii_valid_int, r1, r2);
    REG3 : entity work.register_bank_8bit port map
        (CLK100MHZ, reset_int, ascii_valid_int, r2, r3);
    REG4 : entity work.register_bank_8bit port map
        (CLK100MHZ, reset_int, ascii_valid_int, r3, r4);
    REG5 : entity work.register_bank_8bit port map
        (CLK100MHZ, reset_int, ascii_valid_int, r4, r5);
    REG6 : entity work.register_bank_8bit port map
        (CLK100MHZ, reset_int, ascii_valid_int, r5, r6);

    LED(7 downto 0)  <= r5;
    LED(15 downto 8) <= r6;

    DEC0 : entity work.dec_bin_to_7_seg port map ('1', r1(3 downto 0), seg0);
    DEC1 : entity work.dec_bin_to_7_seg port map ('1', r1(7 downto 4), seg1);
    DEC2 : entity work.dec_bin_to_7_seg port map ('1', r2(3 downto 0), seg2);
    DEC3 : entity work.dec_bin_to_7_seg port map ('1', r2(7 downto 4), seg3);
    DEC4 : entity work.dec_bin_to_7_seg port map ('1', r3(3 downto 0), seg4);
    DEC5 : entity work.dec_bin_to_7_seg port map ('1', r3(7 downto 4), seg5);
    DEC6 : entity work.dec_bin_to_7_seg port map ('1', r4(3 downto 0), seg6);
    DEC7 : entity work.dec_bin_to_7_seg port map ('1', r4(7 downto 4), seg7);

    CE_INST : entity work.CE_generator_1kHz
        port map (clk => CLK100MHZ, reset => reset_int, ce_1kHz => ce_1kHz_int);

    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            if reset_int = '1' then
                display_load <= '0';
            else
                display_load <= ascii_valid_int;
            end if;
        end if;
    end process;

    DISPLAY_INST : entity work.dynamic_7_segment_display_controller_reg
        port map (
            reset => reset_int, clk => CLK100MHZ, ce_1kHz => ce_1kHz_int,
            digit0_D => seg0, digit1_D => seg1, digit2_D => seg2, digit3_D => seg3,
            digit4_D => seg4, digit5_D => seg5, digit6_D => seg6, digit7_D => seg7,
            en_display => '1',
            en_digit0 => display_load, en_digit1 => display_load,
            en_digit2 => display_load, en_digit3 => display_load,
            en_digit4 => display_load, en_digit5 => display_load,
            en_digit6 => display_load, en_digit7 => display_load,
            an0 => AN(0), an1 => AN(1), an2 => AN(2), an3 => AN(3),
            an4 => AN(4), an5 => AN(5), an6 => AN(6), an7 => AN(7),
            A => CA, B => CB, C => CC, D => CD, E => CE, F => CF, G => CG, DP => DP
        );
end Structural;
