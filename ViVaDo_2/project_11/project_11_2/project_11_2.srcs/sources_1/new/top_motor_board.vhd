library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_motor_board is
    Port ( clk, run, reset, direction : in STD_LOGIC;
           clk_50_Hz, Vis_run, Vis_reset, Vis_direction, A, B, C, D: out STD_LOGIC;
           state: out std_logic_vector(3 downto 0));
end top_motor_board;

architecture Behavioral of top_motor_board is
    component stepper_motor_sss is
        Port ( reset, clk, run, direction : in STD_LOGIC;
               A, B, C, D : out STD_LOGIC;
               state: out std_logic_vector(3 downto 0));

    end component;
    
    component clock_divider_2000000 is
        Port ( 
            clk  : in  std_logic;   -- input clock (e.g., 2 MHz)
            clkout : out std_logic;   -- divided output clock
            reset  : in  std_logic    -- asynchronous reset (active high)
        );
    end component;
    
    signal s_clk_50_Hz: std_logic;
begin
stepper: stepper_motor_sss Port map (clk => s_clk_50_Hz, reset => reset, run => run, direction => direction,
                                     A => A, B => B, C => C, D => D, state =>  state);
divider: clock_divider_2000000 Port map (clk => clk, reset => '0', clkout => s_clk_50_Hz);

-- SALIDAS ADICIONALES DEL CHIP GENERAL
clk_50_Hz <= s_clk_50_Hz;
Vis_run <= run;
Vis_reset <= reset;
Vis_direction <= direction;

end Behavioral;
