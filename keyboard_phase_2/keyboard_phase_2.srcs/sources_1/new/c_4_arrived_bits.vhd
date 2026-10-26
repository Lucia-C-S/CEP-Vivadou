library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity c_4_arrived_bits is
    Port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        count_en   : in  STD_LOGIC;
        count_clr  : in  STD_LOGIC;
        
        count      : out STD_LOGIC_VECTOR(3 downto 0);
        end_count  : out STD_LOGIC
    );
end c_4_arrived_bits;

architecture Behavioral of c_4_arrived_bits is

    signal count_reg : UNSIGNED(3 downto 0);
begin

    process(clk, reset)
    begin
        if reset = '1' then
            count_reg <= (others => '0');

        elsif rising_edge(clk) then
        
            if count_clr = '1' then --Reset asincrono 
                count_reg <= (others => '0');

            elsif count_en = '1' then --count_en se activa con kbclk_fe=1 y su respectivo FSM
            
                if count_reg < 11 then --Mirar aqui tambien 10 o 11
                    count_reg <= count_reg + 1;
                end if;
                
            end if;
        end if;
    end process;

    count <= STD_LOGIC_VECTOR(count_reg);

    -- Indica que se estan recibiendo los 11 bits 
    --En caso de no funcionar cambiar a count_reg = 10
    end_count <= '1' when count_reg = 11 else '0';

end Behavioral;