library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component keypad_control_unit is
        Port ( clk, reset : in STD_LOGIC;
               row1, row2, row3, row4 : in STD_LOGIC;
               en_count_col, en_reg_column, en_reg_row : out STD_LOGIC;
               active_row : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    constant clk_cycle: time := 1us;
    
    signal t_clk, t_reset, t_row1, t_row2, t_row3, t_row4,  en_count_col, en_reg_column, en_reg_row: std_logic;
    signal                active_row :  STD_LOGIC_VECTOR (1 downto 0);

begin

    UUT: keypad_control_unit Port map (clk => t_clk, reset => t_reset, 
                                       row1 => t_row1,
                                       row2 => t_row2,
                                       row3 => t_row3,
                                       row4 => t_row4,
                                       en_count_col => en_count_col,
                                       en_reg_column =>en_reg_column,
                                       en_reg_row=> en_reg_row,
                                       active_row => active_row);
clk_process: process
    begin
    t_clk <= '0';
    wait for clk_cycle/2;
    t_clk <= '1';
    wait for clk_cycle/2;
end process;

keypad_process:process
begin
    -- TEST 1 -- Activo Reset y todas las filas.
	    t_reset <= '1';
		t_row1 <= '1';
        t_row2 <= '1';
        t_row3 <= '1';
        t_row4 <= '1';
		wait for clk_cycle;
		  
		  
    -- TEST 2 -- deactivate reset
        t_reset <= '0';
        wait for 10*clk_cycle;
        
    -- TEST 3 --  deactivate row 1 and wait
        t_row1 <= '0';
        wait for 10*clk_cycle;
        
    -- TEST 4 -- activate roww 1 and deactivate row2
		t_row1 <= '1';
		t_row2 <= '0';
		wait for 8*clk_cycle;

     -- TEST 5 -- Activo la 2 Fila y Desactivo la 3 Fila
		t_row2 <= '1';
		t_row3 <= '0';
		wait for 6*clk_cycle;		 
		
	-- TEST 6 -- Activo la 3 Fila y Desactivo la 4 Fila
		t_row3 <= '1';
		t_row4 <= '0';
		wait;	
		
	-- TEST 7 -- Reset inicial a todo
--		t_reset <= '1';
--		wait for 2*clk_cycle;
end process;
    

end Behavioral;
