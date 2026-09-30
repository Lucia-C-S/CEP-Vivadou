library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_ctr_2_bits is
    Port (ce, clk, load, reset: in std_logic;
          din: in std_logic_vector(1 downto 0);
          ceo, tc: out std_logic;
          q: out std_logic_vector(1 downto 0));
end top_ctr_2_bits;

architecture Behavioral of top_ctr_2_bits is
    component edge_detector is
    Port ( input : in std_logic;
           clk : in std_logic;
           reset : in std_logic;
           ea_input : out std_logic; -- pulse when input rises / rising_edge
           ed_input : out std_logic; -- pulse when input falls / falling_edge
           e_input : out std_logic;  -- pulse when any edge / any edge
           input_s : out std_logic); -- synchronized version of input / synchronized signal 
end component;

component ctr_2_bits is
    Port ( reset, load, ce, clk : in STD_LOGIC;
           d: in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (1 downto 0);
           ceo, tc: out std_logic);
end component;

signal  t_ea_input: std_logic;
begin

F_EDGE: edge_detector Port map (input => ce, clk => clk, reset => reset, ea_input => t_ea_input);

F_CTR_2_BITS: ctr_2_bits Port map (reset => reset, load => load, ce => t_ea_input, clk => clk, 
                                    d => din, q => q, ceo => ceo, tc => tc);
                                
end Behavioral;
