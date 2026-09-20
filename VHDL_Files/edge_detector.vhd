-- Edge Detector
-- Its outputs are active one clock cycle when the input
-- has a rising edge or a falling edge

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity edge_detector is
    Port ( input : in std_logic;
           clk : in std_logic;
           reset : in std_logic;
           input_rising_edge : out std_logic; -- rising edge detection
           input_falling_edge : out std_logic; -- falling edge detection
           input_sync : out std_logic); -- synchronized input
end edge_detector;

architecture Behavioral of edge_detector is
signal input_t_1: std_logic:='0';
signal input_sync_aux: std_logic:='0';
begin

input_sync <= input_sync_aux;

process (reset,clk,input_sync_aux,input_t_1)
begin
	if reset = '1' then 	input_sync_aux <= '0';
								input_t_1 <= '0';
	elsif clk = '1' and clk'event then  input_t_1 <= input_sync_aux;
													input_sync_aux <= input;
	end if;

	input_rising_edge <= input_sync_aux and not input_t_1;
	input_falling_edge <= not input_sync_aux and input_t_1;

end process;

end Behavioral;
