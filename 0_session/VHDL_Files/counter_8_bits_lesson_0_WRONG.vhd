----------------------------------------------------------------------------------
-- Company: University of Vigo
-- Engineer: Luis Jacobo Alvarez Ruiz de Ojeda
-- 
-- Create Date:    29/08/2025 
-- Design Name: 
-- Module Name:    counter_8_bits_lesson_0 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 8-bit ascending counter with synchronous reset and parallel load
--
----------------------------------------------------------------------------------

-- INCOMPLETE INCORRECT CIRCUIT
-- First stage: 
	-- Sequential process WITHOUT "clk" in the sensitivity list (analyse synthesis report for "missing signals in the sensitivity list warnings". Behavioural simulation to see it malfunction)
	-- Combinational "tc" output WITHOUT final "else" sentence (analyse synthesis report for "inferred latches" warnings. Behavioural simulation to see it malfunction)
-- Second stage: sequential process WITH "clk" in the sensitivity list (check that the counter counts)
-- Third stage: combinational "tc" output WITH final "else" sentence (check that everything is correct)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter_8_bits_lesson_0 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ce : in  STD_LOGIC;
			  load : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           q : out  STD_LOGIC_VECTOR (7 downto 0);
           tc : out  STD_LOGIC);
end counter_8_bits_lesson_0;

architecture Behavioral of counter_8_bits_lesson_0 is

signal temp: std_logic_vector (7 downto 0):= (others => '0');

begin

process (clk, reset, temp)
begin
	if (clk'event and clk='1') then
		if reset ='1' then
		-- Initialisation of the counter
		temp <= x"00";
	
		elsif load ='1' then
			-- Parallel load
			temp <= din;
		else
			if ce ='1' then
				-- Last state of the counter
				if temp = "11111111" then
					temp <= x"00";	-- It goes back to state 0 (cyclic counter)
				-- It increments the counter
				else temp <= temp + 1;
				end if;
			end if;
	     end if;
	end if;

	-- The "tc" output indicates that the counter has reached its last state
	-- If we want the "tc" signal to change when the counter changes from the last state to the initial state,
	-- it is enough with delaying this combinational signal by using a D-type flip-flop
	if temp = "11111111" then tc <= '1'; -- State 255. It is possible to use another state as the last state, if necessary
    else tc <= '0';
	end if;

end process;

q <= temp;

end Behavioral;

