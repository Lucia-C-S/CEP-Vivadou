-- S.S.S. descrito mediante tres procesos y codificación automática,
-- que depende de las opciones de implementación posteriores,
-- lo que impide ver el estado en la simulación.
-- La salida es combinacional.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_Template is
port (
		clk, reset, input_1 : IN std_logic;
		output_1, output_2 : OUT std_logic
);
end FSM_Template;

architecture Behavioral of FSM_Template is
type state_type is (s1,s2,s3,s4);
signal state, next_state: state_type;

begin

-- Proceso secuencial que define el registro de estado
process1: process (clk, reset)
begin
	if (reset ='1') then
		state <= s1;
	elsif (clk = '1' and clk'Event) then
		state <= next_state;
	end if;
end process;

-- Proceso combinacional que describe las transiciones entre estados
process2: process (state, input_1)
begin
		case state is
			when s1 =>
				if input_1='1' then
					next_state <= s2;
				else
					next_state <= s3;
				end if;
			when s2 => next_state <= s4;
			when s3 => next_state <= s4;
			when s4 => next_state <= s1;
			when others => next_state <= s1;
		end case;
end process;

-- Ecuaciones combinacionales que calculan los valores de las salidas
output_1 <= '1' when (state = s1 or state = s2) else '0';
output_2 <= '1' when (state = s3 or state = s4) else '0';

end Behavioral;
