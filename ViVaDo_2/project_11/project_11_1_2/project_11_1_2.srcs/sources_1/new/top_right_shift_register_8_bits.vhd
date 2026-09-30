library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_right_shift_register_8_bits is
    Port ( clk, reset, load, msb_in, shift_enable: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           lsb_out : out STD_LOGIC;
           q_shift : out STD_LOGIC_VECTOR (7 downto 0));
end top_right_shift_register_8_bits;

architecture Behavioral of top_right_shift_register_8_bits is


    component right_shift_register_8_bits is
        Port ( clk, reset, load, msb_in, shift_enable : in STD_LOGIC;
               data_in : in STD_LOGIC_VECTOR (7 downto 0);
               lsb_out : out STD_LOGIC;
               q_shift : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    
    component edge_detector is
        Port ( input : in std_logic;
               clk : in std_logic;
               reset : in std_logic;
               ea_input : out std_logic; -- pulse when input rises / rising_edge
               ed_input : out std_logic; -- pulse when input falls / falling_edge
               e_input : out std_logic;  -- pulse when any edge / any edge
               input_s : out std_logic); -- synchronized version of input / synchronized signal 
    end component;
    
    signal s_shift_enable: std_logic;
begin

shift_reg: right_shift_register_8_bits Port map(clk => clk, reset => reset, load => load, msb_in => msb_in,
                                                shift_enable => s_shift_enable, data_in => data_in,
                                                lsb_out => lsb_out, q_shift => q_shift);
                                                
edge_det: edge_detector Port map (clk => clk, reset => reset, input => shift_enable, ea_input => s_shift_enable);


end Behavioral;
