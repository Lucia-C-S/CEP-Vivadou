library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PS2_operating_unit is
    Port (
        -- Señales globales
        clk                 : in  STD_LOGIC;
        reset               : in  STD_LOGIC;

        -- Señales procedentes del teclado PS/2
        kbclk               : in  STD_LOGIC;
        kbdata              : in  STD_LOGIC;

        -- Señales de control procedentes de la CU
        shift_en            : in  STD_LOGIC;
        count_en            : in  STD_LOGIC;
        count_clr           : in  STD_LOGIC;
        load_data           : in  STD_LOGIC;
        load_parity_error   : in  STD_LOGIC;

        -- Señales enviadas hacia la CU
        kbclk_falling_edge  : out STD_LOGIC;
        end_count           : out STD_LOGIC;

        -- Resultados de la unidad operativa
        data_received       : out STD_LOGIC_VECTOR(7 downto 0);
        parity_error        : out STD_LOGIC
    );
end PS2_operating_unit;

architecture Structural of PS2_operating_unit is

    ----------------------------------------------------------------
    -- Señales internas
    ----------------------------------------------------------------

    signal arriving_bits       : STD_LOGIC_VECTOR(10 downto 0);
    signal bit_count           : STD_LOGIC_VECTOR(3 downto 0);

    signal parity_error_comb   : STD_LOGIC;
    signal parity_error_reg    : STD_LOGIC;

begin

    ----------------------------------------------------------------
    -- 1. Detector síncrono de flanco de bajada de KBCLK
    ----------------------------------------------------------------
    KBCLK_FE_DETECTOR_INST : entity work.kblck_fe_detector
        port map (
            clk      => clk,
            reset    => reset,
            kbclk    => kbclk,
            kbclk_fe => kbclk_falling_edge
        );

    ----------------------------------------------------------------
    -- 2. Registro de desplazamiento de 11 bits
    ----------------------------------------------------------------
    SHIFT_REGISTER_INST : entity work.sr_11_arriving_bits
        port map (
            clk      => clk,
            reset    => reset,
            shift_en => shift_en,
            kbdata   => kbdata,
            bits_out => arriving_bits
        );

    ----------------------------------------------------------------
    -- 3. Contador de bits recibidos
    ----------------------------------------------------------------
    COUNTER_INST : entity work.c_4_arrived_bits
        port map (
            clk       => clk,
            reset     => reset,
            count_en  => count_en,
            count_clr => count_clr,
            count     => bit_count,
            end_count => end_count
        );

    ----------------------------------------------------------------
    -- 4. Comprobador combinacional de paridad impar
    ----------------------------------------------------------------
    PARITY_CHECK_INST : entity work.parity_check
        port map (
            arriving_bits => arriving_bits,
            parity_error  => parity_error_comb
        );

    ----------------------------------------------------------------
    -- 5. Flip-flop para almacenar el error de paridad
    ----------------------------------------------------------------
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

    ----------------------------------------------------------------
    -- 6. Registro paralelo para almacenar el byte recibido
    ----------------------------------------------------------------
    DATA_REGISTER_INST : entity work.pr_8_data_received
        port map (
            clk           => clk,
            reset         => reset,
            load_data     => load_data,
            arriving_bits => arriving_bits,
            data_received => data_received
        );

end Structural;