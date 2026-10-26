library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PS2_advanced_fsm is
    port (
        clk         : in  STD_LOGIC;
        data_eq_F0  : in  STD_LOGIC;
        end_data    : in  STD_LOGIC;
        reset       : in  STD_LOGIC;

        ce_key      : out STD_LOGIC;
        end_key     : out STD_LOGIC;
        new_key     : out STD_LOGIC
    );
end PS2_advanced_fsm;

architecture Behavioral of PS2_advanced_fsm is

    type state_type is (
        WAIT_DATA,
        RELEASE_PENDING,
        PRESS_EVENT,
        RELEASE_EVENT
    );
    -- WAIT_DATA distinguishes a normal byte from the F0 prefix
    -- RELEASE_PENDING remembers the prefix until the released key's code arrives
    -- PRESS_EVENT asserts ce_key and new_key for one clock period
    -- RELEASE_EVENT asserts end_key for one clock period

    signal current_state : state_type := WAIT_DATA;
    signal next_state    : state_type := WAIT_DATA;

begin

    -- State register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= WAIT_DATA;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next-state logic
    process(current_state, end_data, data_eq_F0)
    begin
        next_state <= current_state;

        case current_state is

            when WAIT_DATA =>
                if end_data = '1' then
                    if data_eq_F0 = '1' then
                        next_state <= RELEASE_PENDING;
                    else
                        next_state <= PRESS_EVENT;
                    end if;
                end if;

            when RELEASE_PENDING =>
                if end_data = '1' then
                    if data_eq_F0 = '0' then
                        next_state <= RELEASE_EVENT;
                    end if;
                end if;

            when PRESS_EVENT =>
                next_state <= WAIT_DATA;

            when RELEASE_EVENT =>
                next_state <= WAIT_DATA;

            when others =>
                next_state <= WAIT_DATA;

        end case;
    end process;

    -- Moore outputs: each event lasts one clock cycle
    ce_key  <= '1' when current_state = PRESS_EVENT else '0';
    new_key <= '1' when current_state = PRESS_EVENT else '0';
    end_key <= '1' when current_state = RELEASE_EVENT else '0';

end Behavioral;
