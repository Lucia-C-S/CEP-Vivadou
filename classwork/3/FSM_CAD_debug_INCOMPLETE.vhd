-- State Machine Skeleton
-- with one-hot encoding
-- to be able to see the state during simulations
-- The outputs are combinational

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_CAD_debug is
port (
		clk, reset, eoc_s, tc_ctr  : IN std_logic;
		ce_ctr, reset_ctr, we_ram, end_process : OUT std_logic;
		state_debug: out std_logic_vector (5 downto 0)
);
end FSM_CAD_debug;

architecture Behavioral of FSM_CAD_debug is

constant s1: std_logic_vector (5 downto 0):="000001";
constant s2: std_logic_vector (5 downto 0):="000010";
constant s3: std_logic_vector (5 downto 0):="000100";
constant s4: std_logic_vector (5 downto 0):="001000";
constant s5: std_logic_vector (5 downto 0):="010000";
constant s6: std_logic_vector (5 downto 0):="100000";

signal state, next_state: std_logic_vector (5 downto 0):=(others => '0');

begin

-- Debug outputs
state_debug <= state;

-- Sequential process that describes the state register
process1: process (clk, reset)
begin
    if (clk = '1' and clk'Event) then
        	if (reset ='1') then
		      state <= s1;
	        else
		      state <= next_state;
		    end if;
	end if;
end process;

-- Combinational process that describes the transitions between states

process2: process (state, eoc_s, tc_ctr)
begin
		case state is
			when s1 =>
				if eoc_s='1' then
					next_state <= s2;
				else
					next_state <= s1;
				end if;

			when s2 => next_state <= s3;

			when s3 => 
			 if tc_ctr = '1' then
			     next_state <= s6;
			 else
			     next_state <= s4;
			 end if;

			when s4 =>
			  next_state <= s4;
             
			when s5 =>			
                if eoc_S = '0' then next_state <= s1;
                else next_state <= s5;
                end if;
                
			when s6 => 
                next_state <= s1;
			when others => next_state <= s1;
		end case;
end process;

-- Combinational equations for the outputs

ce_ctr <= '1' when (state = s4) else '0';
we_ram <= '1' when (state = s2) else '0';
end_process <= '1' when (state = s6) else '0';
reset_ctr <= '1' when (state = s6) else '0';

end Behavioral;
