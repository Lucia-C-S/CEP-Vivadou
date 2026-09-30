library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity right_shift_register_8_bits is
    Port ( clk, reset, load, msb_in, shift_enable : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           lsb_out : out STD_LOGIC;
           q_shift : out STD_LOGIC_VECTOR (7 downto 0));
end right_shift_register_8_bits;

architecture Behavioral of right_shift_register_8_bits is
component edge_detector is
    Port ( input : in std_logic;
           clk : in std_logic;
           reset : in std_logic;
           ea_input : out std_logic; -- rising_edge
           ed_input : out std_logic; -- falling_edge
           e_input : out std_logic;  -- any edge
           input_s : out std_logic); -- synchronized signal 
end component;


signal q_shift_aux : std_logic_vector(7 downto 0);

begin
process (clk)
begin
 if (rising_edge (clk)) then
    if reset = '1' then
         q_shift_aux <= (others => '0');
    elsif load = '1' then
         q_shift_aux <=  data_in;
    elsif shift_enable = '0' then
         q_shift_aux <= q_shift_aux;
    else
         q_shift_aux <= msb_in & q_shift_aux(7 downto 1);
     end if;            
 end if;
 end process;

 q_shift <= q_shift_aux;
 lsb_out <= q_shift_aux(0);

end Behavioral;
