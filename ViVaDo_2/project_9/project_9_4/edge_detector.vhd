-- Edge detector, which activates its outputs for a cycle when
-- the input goes high (ea), goes low (ed) o any of them (e)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
    Port ( input : in std_logic;
           clk : in std_logic;
           reset : in std_logic;
           ea_input : out std_logic; -- rising_edge
           ed_input : out std_logic; -- falling_edge
           e_input : out std_logic;  -- any edge
           input_s : out std_logic); -- synchronized signal 
end edge_detector;

architecture Behavioral of edge_detector is
signal input_t_1: std_logic;
signal ea_input_aux : std_logic; -- rising_edge
signal ed_input_aux : std_logic; -- falling_edge
signal input_s_aux : std_logic; -- synchronized signal
begin
ea_input <= ea_input_aux;
ed_input <= ed_input_aux;
input_s <= input_s_aux;

process (reset,clk,input_s_aux,input_t_1)
begin
   if reset='1' then input_s_aux<='0';input_t_1 <= '0';
   elsif rising_edge(clk) then input_t_1<= input_s_aux;
					    input_s_aux <= input;
   end if;

   ea_input_aux <= input_s_aux and not input_t_1;
   ed_input_aux <= not input_s_aux and input_t_1;
   e_input <= ea_input_aux or ed_input_aux;
end process;
end Behavioral;
