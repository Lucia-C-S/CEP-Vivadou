library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity keypad_control_unit is
    Port ( clk, reset : in STD_LOGIC;
           row1, row2, row3, row4 : in STD_LOGIC;
           en_count_col, en_reg_column, en_reg_row : out STD_LOGIC;
           active_row : out STD_LOGIC_VECTOR (1 downto 0));
end keypad_control_unit;

architecture Behavioral of keypad_control_unit is
    --type declaration
    TYPE state is (s0, s1, s2, s3, s4, s1to5, s2to5, s3to5, s4to5, up_col);
    --state signals declarations
    signal C_S, N_S: state;
    signal s_en_count_col : std_logic := '0';
    --integer range 0 to 255 := 0; --counter until 256 clock cycles
begin
--state register
state_register: process (clk, reset)
begin
    if reset = '1' then
        C_S <= s0;
    elsif (rising_edge(clk)) then
        C_S <= N_S;
    end if;
end process;

--combinational that generates the next state based on the inputs and current state
state_change: process (row1, row2, row3, row4, C_S, N_S)
begin
    case C_S is
        -- Si el estado es el 0, pasamos al estado 1
            when s0 => N_S <= s1;
            
            -- Definimos lo que puede suceder en el estado 0 de la maquina.
            when s1 =>
                
                -- Comprobamos si la columna correspondiente esta activada o no.
				if (row1 = '0') then N_S <= s1to5;
				else N_S <= s2;
				end if;
			
			when s2 =>
			
				if (row2 = '0') then N_S <= s2to5;
				else N_S <= s3;
				end if;
				
			when s3 =>
				
				if (row3 = '0') then N_S <= s3to5;
				else N_S <= s4;
				end if;
						
			when s4 =>
			
				if (row4 = '0') then N_S <= s4to5;
				else N_S <= up_col;  -- Si llegamos al estado 4 y lo pasamos, saltamos de columna
				end if;
			
			-- Si hemos llegado al estaso inc_col, tenemos que saltar OJO al estado 1 para seguir comprobando las distintas rows.
			when up_col => N_S <= s1;
								
			-- Cualquier otro caso, regresamos al estado inicial s0.
			when others => N_S <= s0;
        end case;
     end process;

--combinational that generates the outputs based on current state
outputs: process(C_S)
    begin
    -- DEFAULT SAFE VALUES (avoid latches)
    en_count_col  <= '0';
    en_reg_column <= '0';
    en_reg_row    <= '0';
    active_row    <= "00";
    
        case C_S is           
            -- Definimos los valores de los diferentes estados.
            when s1to5 => en_count_col <='0'; en_reg_column <='1'; en_reg_row <='1'; active_row <="00";
            when s2to5 => en_count_col <='0'; en_reg_column <='1'; en_reg_row <='1'; active_row <="01";
            when s3to5 => en_count_col <='0'; en_reg_column <='1'; en_reg_row <='1'; active_row <="10";
			when s4to5 => en_count_col <='0'; en_reg_column <='1'; en_reg_row <='1'; active_row <="11";
			
			when up_col =>    en_count_col <='1'; en_reg_column <='0'; en_reg_row <='0';
			when others =>    en_count_col <='0'; en_reg_column <='0'; en_reg_row <='0';
	   
         end case;
end process;

end Behavioral;
