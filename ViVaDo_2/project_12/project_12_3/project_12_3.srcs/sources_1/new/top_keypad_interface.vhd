library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_keypad_interface is
    Port ( row1, row2, row3, row4 : in STD_LOGIC;
           clk, reset : in STD_LOGIC;
           abcdefg : out STD_LOGIC_VECTOR (6 downto 0);
           an0, an1, an2, an3 : out STD_LOGIC;
           dp: out std_logic;
           col1, col2, col3, col4 : out STD_LOGIC);
end top_keypad_interface;

architecture Behavioral of top_keypad_interface is
    component divider100 is
        Port ( clkin : in std_logic;
               clkout1 : out std_logic;
               reset : in std_logic);
    end component;
    
    component keypad_control_unit is
        Port ( clk, reset : in STD_LOGIC;
               row1, row2, row3, row4 : in STD_LOGIC;
               en_count_col, en_reg_column, en_reg_row : out STD_LOGIC;
               active_row : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    component keypad_operating_unit is
        Port ( clk,reset : in STD_LOGIC;
               active_row : in STD_LOGIC_VECTOR (1 downto 0);
               en_count_col, en_reg_col, en_reg_row : in STD_LOGIC;
               abcdefg : out STD_LOGIC_VECTOR (6 downto 0);
               an0, an1, an2, an3, dp : out STD_LOGIC;
               col1, col2, col3, col4 : out STD_LOGIC);
    end component;
    
signal clk_out, en_count_col, en_reg_col, en_reg_row: std_logic;
signal active_row : STD_LOGIC_VECTOR (1 downto 0);

begin
div: divider100 Port map (clkin => clk, reset => reset, clkout1 => clk_out);

control_row: keypad_control_unit Port map (clk => clk_out, reset => reset, row1 => row1,
                                           row2 => row2, row3 => row3, row4 => row4, 
                                           en_count_col => en_count_col,
                                           en_reg_column => en_reg_col,
                                           en_reg_row => en_reg_row, 
                                           active_row => active_row);
                                           
keypad_inter: keypad_operating_unit Port map (clk => clk_out, reset => reset, 
                                              active_row => active_row,
                                              en_count_col => en_count_col,
                                              en_reg_col => en_reg_col,
                                              en_reg_row => en_reg_row,
                                              abcdefg => abcdefg,
                                              dp => dp,
                                              col1 => col1, 
                                              col2 => col2, 
                                              col3 => col3, 
                                              col4 => col4, 
                                              an0 => an0,
                                              an1 => an1, 
                                              an2 => an2,
                                              an3 => an3);

end Behavioral;
