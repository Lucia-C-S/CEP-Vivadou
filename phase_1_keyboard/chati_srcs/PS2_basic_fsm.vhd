library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PS2_basic_fsm is
    port (
        clk                : in  STD_LOGIC;
        reset              : in  STD_LOGIC;
        kbclk_falling_edge : in  STD_LOGIC;
        end_count          : in  STD_LOGIC;
        shift_en           : out STD_LOGIC;
        count_en           : out STD_LOGIC;
        count_clr          : out STD_LOGIC;
        load_data          : out STD_LOGIC;
        load_parity_error  : out STD_LOGIC;
        end_data           : out STD_LOGIC
    );
end PS2_basic_fsm;

architecture Behavioral of PS2_basic_fsm is

    type state_type is (
        IDLE_STATE,
        SHIFT_STATE,
        SAVE_STATE,
        PULSE_END,
        RESET_COUNTER
    );

    signal current_state : state_type := IDLE_STATE;
    signal next_state    : state_type := IDLE_STATE;

begin

    -- State register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE_STATE;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next-state logic
    process(current_state, kbclk_falling_edge, end_count)
begin
    next_state <= current_state;

    case current_state is
        when IDLE_STATE =>
            if end_count = '1' then
                next_state <= SAVE_STATE;
            elsif kbclk_falling_edge = '1' then
                next_state <= SHIFT_STATE;
            end if;

        when SHIFT_STATE =>
            next_state <= IDLE_STATE;

        when SAVE_STATE =>
            next_state <= PULSE_END;

        when PULSE_END =>
            next_state <= RESET_COUNTER;

        when RESET_COUNTER =>
            next_state <= IDLE_STATE;

        when others =>
            next_state <= IDLE_STATE;
    end case;
end process;

    -- Output logic
    shift_en          <= '1' when current_state = SHIFT_STATE else '0';
    count_en          <= '1' when current_state = SHIFT_STATE else '0';
    count_clr         <= '1' when current_state = RESET_COUNTER else '0';
    load_data         <= '1' when current_state = SAVE_STATE else '0';
    load_parity_error <= '1' when current_state = SAVE_STATE else '0';
    end_data          <= '1' when current_state = PULSE_END else '0';

end Behavioral;