library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PS2_operating_unit is
    port (
        -- Global signals
        clk                 : in  std_logic;
        reset               : in  std_logic;

        -- Signals from the PS/2 keyboard
        kbclk               : in  std_logic;
        kbdata              : in  std_logic;

        -- Control signals from the control unit (CU)
        shift_en            : in  std_logic;
        count_en            : in  std_logic;
        count_clr           : in  std_logic;
        load_data           : in  std_logic;
        load_parity_error   : in  std_logic;

        -- Status signals to the CU
        kbclk_falling_edge  : out std_logic;
        end_count           : out std_logic;

        -- Results of the operating unit
        data_received       : out std_logic_vector(7 downto 0);
        parity_error        : out std_logic
    );
end entity;

architecture Structural of PS2_operating_unit is
    signal arriving_bits     : std_logic_vector(10 downto 0);
    signal bit_count         : std_logic_vector(3 downto 0);
    signal parity_error_comb : std_logic;
    signal parity_error_reg  : std_logic;
begin
    -- The falling-edge pulse leaves the operating unit and is used by the CU.
    -- It is deliberately not connected to any datapath block inside this unit.
    KBCLK_FE_DETECTOR_INST : entity work.kblck_fe_detector
        port map (
            clk      => clk,
            reset    => reset,
            kbclk    => kbclk,
            kbclk_fe => kbclk_falling_edge
        );

    SHIFT_REGISTER_INST : entity work.sr_11_arriving_bits
        port map (
            clk      => clk,
            reset    => reset,
            shift_en => shift_en,
            kbdata   => kbdata,
            bits_out => arriving_bits
        );

    COUNTER_INST : entity work.c_4_arrived_bits
        port map (
            clk       => clk,
            reset     => reset,
            count_en  => count_en,
            count_clr => count_clr,
            count     => bit_count,
            end_count => end_count
        );

    PARITY_CHECK_INST : entity work.parity_check
        port map (
            arriving_bits => arriving_bits,
            parity_error  => parity_error_comb
        );

    process(clk, reset)
    begin
        if reset = '1' then
            parity_error_reg <= '0';
        elsif rising_edge(clk) then
            if load_parity_error = '1' then
                parity_error_reg <= parity_error_comb;
            end if;
        end if;
    end process;

    parity_error <= parity_error_reg;

    DATA_REGISTER_INST : entity work.pr_8_data_received
        port map (
            clk           => clk,
            reset         => reset,
            load_data     => load_data,
            arriving_bits => arriving_bits,
            data_received => data_received
        );
end architecture;
