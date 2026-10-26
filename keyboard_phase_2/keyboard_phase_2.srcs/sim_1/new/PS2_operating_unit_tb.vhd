library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PS2_operating_unit_tb is
end PS2_operating_unit_tb;

architecture Behavioral of PS2_operating_unit_tb is

    ----------------------------------------------------------------
    -- Constantes de temporización
    ----------------------------------------------------------------

    -- Reloj global de la Nexys 4 DDR: 100 MHz
    constant CLK_PERIOD : time := 10 ns;

    -- KBCLK = 25 kHz
    -- Periodo = 40 us
    constant KBCLK_HALF_PERIOD : time := 20 us;

    ----------------------------------------------------------------
    -- Señales globales
    ----------------------------------------------------------------

    signal clk   : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '1';

    ----------------------------------------------------------------
    -- Señales PS/2
    ----------------------------------------------------------------

    signal kbclk  : STD_LOGIC := '1';
    signal kbdata : STD_LOGIC := '1';

    ----------------------------------------------------------------
    -- Señales de control de la OU
    ----------------------------------------------------------------

    signal shift_en          : STD_LOGIC := '0';
    signal count_en          : STD_LOGIC := '0';
    signal count_clr         : STD_LOGIC := '0';
    signal load_data         : STD_LOGIC := '0';
    signal load_parity_error : STD_LOGIC := '0';

    ----------------------------------------------------------------
    -- Señales de salida de la OU
    ----------------------------------------------------------------

    signal kbclk_falling_edge : STD_LOGIC;
    signal end_count          : STD_LOGIC;

    signal data_received : STD_LOGIC_VECTOR(7 downto 0);
    signal parity_error  : STD_LOGIC;

    ----------------------------------------------------------------
    -- Procedimiento para enviar un bit PS/2
    ----------------------------------------------------------------

    procedure send_ps2_bit (
        signal kbclk_signal  : out STD_LOGIC;
        signal kbdata_signal : out STD_LOGIC;
        constant bit_value   : in  STD_LOGIC
    ) is
    begin

        -- El dato cambia mientras KBCLK está a nivel alto.
        kbdata_signal <= bit_value;

        wait for KBCLK_HALF_PERIOD;

        -- Flanco de bajada: el receptor captura el bit.
        kbclk_signal <= '0';

        wait for KBCLK_HALF_PERIOD;

        -- Flanco de subida.
        kbclk_signal <= '1';

    end procedure;

    ----------------------------------------------------------------
    -- Procedimiento para enviar una trama PS/2 completa
    ----------------------------------------------------------------

    procedure send_ps2_frame (
        signal kbclk_signal  : out STD_LOGIC;
        signal kbdata_signal : out STD_LOGIC;
        constant data_value  : in  STD_LOGIC_VECTOR(7 downto 0);
        constant parity_bit  : in  STD_LOGIC
    ) is
    begin

        ------------------------------------------------------------
        -- Bit de inicio: siempre 0
        ------------------------------------------------------------

        send_ps2_bit(
            kbclk_signal,
            kbdata_signal,
            '0'
        );

        ------------------------------------------------------------
        -- Ocho bits de datos enviados LSB primero
        ------------------------------------------------------------

        for i in 0 to 7 loop
            send_ps2_bit(
                kbclk_signal,
                kbdata_signal,
                data_value(i)
            );
        end loop;

        ------------------------------------------------------------
        -- Bit de paridad
        ------------------------------------------------------------

        send_ps2_bit(
            kbclk_signal,
            kbdata_signal,
            parity_bit
        );

        ------------------------------------------------------------
        -- Bit de parada: siempre 1
        ------------------------------------------------------------

        send_ps2_bit(
            kbclk_signal,
            kbdata_signal,
            '1'
        );

        ------------------------------------------------------------
        -- Estado de reposo del bus PS/2
        ------------------------------------------------------------

        kbclk_signal  <= '1';
        kbdata_signal <= '1';

    end procedure;

begin

    ----------------------------------------------------------------
    -- Generación del reloj global de 100 MHz
    ----------------------------------------------------------------

    clk <= not clk after CLK_PERIOD / 2;

    ----------------------------------------------------------------
    -- Instancia de PS2_operating_unit
    ----------------------------------------------------------------

    DUT : entity work.PS2_operating_unit
        port map (
            clk                => clk,
            reset              => reset,

            kbclk              => kbclk,
            kbdata             => kbdata,

            shift_en           => shift_en,
            count_en           => count_en,
            count_clr          => count_clr,
            load_data          => load_data,
            load_parity_error  => load_parity_error,

            kbclk_falling_edge => kbclk_falling_edge,
            end_count          => end_count,

            data_received      => data_received,
            parity_error       => parity_error
        );

    ----------------------------------------------------------------
    -- Simulación provisional de la Unidad de Control
    ----------------------------------------------------------------
    --
    -- Cuando se detecta un flanco de bajada de KBCLK:
    --   - desplaza un bit
    --   - incrementa el contador
    --
    -- Cuando se han recibido los 11 bits:
    --   - almacena el byte
    --   - almacena el error de paridad
    --   - reinicia el contador
    ----------------------------------------------------------------

    CONTROL_SIMULATION : process(clk, reset)
    begin
        if reset = '1' then

            shift_en          <= '0';
            count_en          <= '0';
            count_clr         <= '0';
            load_data         <= '0';
            load_parity_error <= '0';

        elsif rising_edge(clk) then

            -- Valores predeterminados:
            -- todas las órdenes duran un solo ciclo.
            shift_en          <= '0';
            count_en          <= '0';
            count_clr         <= '0';
            load_data         <= '0';
            load_parity_error <= '0';

            if kbclk_falling_edge = '1' then

                shift_en <= '1';
                count_en <= '1';

            elsif end_count = '1' then

                load_data         <= '1';
                load_parity_error <= '1';
                count_clr         <= '1';

            end if;

        end if;
    end process;

    ----------------------------------------------------------------
    -- Proceso de estímulos
    ----------------------------------------------------------------

    STIMULUS : process
    begin

        ------------------------------------------------------------
        -- Estado inicial
        ------------------------------------------------------------

        reset  <= '1';
        kbclk  <= '1';
        kbdata <= '1';

        wait for 100 ns;

        ------------------------------------------------------------
        -- Desactivar RESET
        ------------------------------------------------------------

        reset <= '0';

        wait for 1 us;

        ------------------------------------------------------------
        -- Trama 1: 0x11 con paridad correcta
        --
        -- 0x11 = 00010001
        -- Tiene dos unos.
        -- Para paridad impar, parity_bit debe ser 1.
        ------------------------------------------------------------

        report "Enviando 0x11 con paridad correcta";

        send_ps2_frame(
            kbclk,
            kbdata,
            x"11",
            '1'
        );

        -- Tiempo para que se almacenen las salidas.
        wait for 2 us;

        ------------------------------------------------------------
        -- Comprobaciones automáticas de la primera trama
        ------------------------------------------------------------

        assert data_received = x"11"
            report "ERROR: El dato recibido no es 0x11"
            severity error;

        assert parity_error = '0'
            report "ERROR: Se ha detectado error de paridad en una trama correcta"
            severity error;

        report "Trama 0x11 recibida correctamente";

        ------------------------------------------------------------
        -- Separación entre las dos tramas
        ------------------------------------------------------------

        wait for 500 us;

        ------------------------------------------------------------
        -- Trama 2: 0x22 con paridad incorrecta
        --
        -- 0x22 = 00100010
        -- Tiene dos unos.
        -- La paridad correcta sería 1.
        -- Se envía 0 para provocar un error.
        ------------------------------------------------------------

        report "Enviando 0x22 con paridad incorrecta";

        send_ps2_frame(
            kbclk,
            kbdata,
            x"22",
            '0'
        );

        wait for 2 us;

        ------------------------------------------------------------
        -- Comprobaciones automáticas de la segunda trama
        ------------------------------------------------------------

        assert data_received = x"22"
            report "ERROR: El dato recibido no es 0x22"
            severity error;

        assert parity_error = '1'
            report "ERROR: No se ha detectado el error de paridad"
            severity error;

        report "Trama 0x22 recibida y error de paridad detectado";

        ------------------------------------------------------------
        -- Fin de la simulación
        ------------------------------------------------------------

        report "SIMULACION COMPLETADA CORRECTAMENTE"
            severity note;

        wait;

    end process;

end Behavioral;