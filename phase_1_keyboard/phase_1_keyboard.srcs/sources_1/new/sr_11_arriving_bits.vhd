library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_11_arriving_bits is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        shift_en    : in  STD_LOGIC; --Viene de la FSM
        kbdata      : in  STD_LOGIC;
        bits_out    : out STD_LOGIC_VECTOR(10 downto 0)
    );
end sr_11_arriving_bits;

architecture Behavioral of sr_11_arriving_bits is

    signal shift_reg : STD_LOGIC_VECTOR(10 downto 0);
begin

    process(clk, reset)
    begin
        if reset = '1' then
            shift_reg <= (others => '0');


        elsif rising_edge(clk) then
        
            if shift_en = '1' then --Esta señal viene de la FSM cuando kblck_fe sea 1
                shift_reg <= kbdata & shift_reg(10 downto 1);
            end if;
            
        end if;
    end process;

    bits_out <= shift_reg;
end Behavioral;