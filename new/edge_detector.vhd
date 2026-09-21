library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
    Port (
        input              : in  STD_LOGIC;
        clk                : in  STD_LOGIC;
        reset              : in  STD_LOGIC;
        input_rising_edge  : out STD_LOGIC;
        input_falling_edge : out STD_LOGIC;
        input_sync         : out STD_LOGIC
    );
end edge_detector;

architecture Behavioral of edge_detector is

    signal input_sync_aux : STD_LOGIC := '0';
    signal input_t_1      : STD_LOGIC := '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then
                input_sync_aux <= '0';
                input_t_1      <= '0';

            else
                input_t_1      <= input_sync_aux;
                input_sync_aux <= input;

            end if;

        end if;
    end process;

    -- Input sincronizado
    input_sync <= input_sync_aux;

    -- Deteccion de flancos
    input_rising_edge  <= input_sync_aux and (not input_t_1);
    input_falling_edge <= (not input_sync_aux) and input_t_1;

end Behavioral;