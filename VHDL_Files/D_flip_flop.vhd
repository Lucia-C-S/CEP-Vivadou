----------------------------------------------------------------------------------
-- Company: University of Vigo
-- Engineer: Luis Jacobo Alvarez Ruiz de Ojeda
-- 
-- Create Date:    16/11/2015 
-- Module Name:    D_flip_flop_preset_reset - Behavioral 
-- Target Devices: all
-- Tool versions: all
-- Description: D_flip_flop with CE, synchronous reset ("sync_reset") and synchronous preset ("sync_preset")
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity D_flip_flop is
	 Generic ( initial_state: std_logic:='0'
	         );
    Port ( clk : in  STD_LOGIC; -- global clock
           sync_reset : in  STD_LOGIC; -- synchronous reset
           sync_preset : in  STD_LOGIC; -- synchronous preset
           ce : in  STD_LOGIC; -- clock enable
           d : in std_logic; -- data input
           q : out std_logic -- data output
				);
end D_flip_flop;

architecture Behavioral of D_flip_flop is

signal q_aux: std_logic:= initial_state;

begin

q <= q_aux;

process (clk, ce, sync_reset, sync_preset, d)
begin
   if (clk'event and clk='1') then
	   if sync_preset='1' then
             q_aux <= '1'; -- Synchronous preset
	   elsif sync_reset='1' then
             q_aux <= '0'; -- Synchronous reset
		elsif ce = '1' then
              q_aux <= d;		-- Synchronous input
    	   end if;
   end if;
end process;


end Behavioral;

