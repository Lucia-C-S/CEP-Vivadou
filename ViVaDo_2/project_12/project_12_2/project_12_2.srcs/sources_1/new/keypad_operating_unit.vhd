library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity keypad_operating_unit is
    Port ( clk,reset : in STD_LOGIC;
           active_row : in STD_LOGIC_VECTOR (1 downto 0);
           en_count_col, en_reg_col, en_reg_row : in STD_LOGIC;
           abcdefg : out STD_LOGIC_VECTOR (6 downto 0);
           an0, an1, an2, an3, dp : out STD_LOGIC;
           col1, col2, col3, col4 : out STD_LOGIC);
end keypad_operating_unit;

architecture Behavioral of keypad_operating_unit is
    component inst_ctr_2_bits is
        Port ( reset, load, ce, clk : in STD_LOGIC;
               d: in STD_LOGIC_VECTOR (1 downto 0);
               q : out STD_LOGIC_VECTOR (1 downto 0);
               ceo, tc: out std_logic);
    end component;
        
     component inst_reg_2_bits_row is
        Port ( reset, ce, clk : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR (1 downto 0);
               q_row : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    component inst_reg_2_bits_col is
        Port ( reset, ce, clk : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR (1 downto 0);
               q_col : out STD_LOGIC_VECTOR (1 downto 0));
    end component;

    component inst_code_converter is
        Port ( column, row : in STD_LOGIC_VECTOR (1 downto 0);
               binary : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component bin_to_7_seg_anode is
        Port ( EN : in STD_LOGIC;
               Din : in STD_LOGIC_VECTOR (3 downto 0);
               dp_in : in STD_LOGIC;
               abcdefg : out STD_LOGIC_VECTOR (6 downto 0);
               DP : out STD_LOGIC);
    end component;
    
    component two_to_4_decoder is
        Port ( d : in STD_LOGIC_VECTOR (1 downto 0);
               g : in std_logic;
               q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

signal q_aux: std_logic_vector(1 downto 0);
signal row_aux, col_aux: std_logic_vector(1 downto 0);
signal bin_aux: std_logic_vector (3 downto 0);

begin

ctr: inst_ctr_2_bits Port map (reset => reset, load => '0', d => "00", ce => en_count_col,
                               clk => clk, q => q_aux);
                               
row: inst_reg_2_bits_row Port map (reset => reset, ce => en_reg_row, clk => clk, d => active_row,
                                   q_row => row_aux);
                                   
col: inst_reg_2_bits_col Port map (reset => reset, ce => en_reg_col, clk => clk, d => q_aux,
                                   q_col => col_aux);

conv: inst_code_converter Port map (column => col_aux, row => row_aux, binary => bin_aux);

seg7: bin_to_7_seg_anode Port map (EN => '1', dp_in => '0', Din => bin_aux,  abcdefg => abcdefg, dp => dp);

dec:  two_to_4_decoder Port map (d => q_aux, g => '1', q(0) => col1,
                                                       q(1) => col2,
                                                       q(2) => col3,
                                                       q(3) => col4);

an0 <= '0';
an1 <= '1';
an2 <= '1';
an3 <= '1';
end Behavioral;
