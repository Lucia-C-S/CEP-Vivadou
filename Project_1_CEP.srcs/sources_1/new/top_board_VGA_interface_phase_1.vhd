library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top_board_VGA_interface_phase_1 is
    Port ( clk : in STD_LOGIC;
           CPU_RESETN : in STD_LOGIC;
           SW15 : in STD_LOGIC;
           SW14 : in STD_LOGIC;
           pixel_colour : in STD_LOGIC_VECTOR (11 downto 0); -- SW(11:0):
           LED : out STD_LOGIC_VECTOR (9 downto 0); --LED(9 downto 0) = CONTROL STATE
           vsync_led : out STD_LOGIC; --JB(1)
           vsync_os : out STD_LOGIC;--JB(2)
           hsync_os : out STD_LOGIC;
           VGA_hsync : out STD_LOGIC;
           VGA_vsync : out STD_LOGIC;
           VGA_R : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_G : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_B : out STD_LOGIC_VECTOR (3 downto 0));
end top_board_VGA_interface_phase_1;

architecture Behavioral of top_board_VGA_interface_phase_1 is

component CE_generator_25MHz
   port (
      clk_100MHz :  in  std_logic;
      reset      :  in  std_logic;
      ce_25MHz   :  out  std_logic
   );
   end component;
   
   component mux_1bit_ce
    Port (
        sel      : in  std_logic;
        ce_50Hz  : in  std_logic;
        ce_25MHz : in  std_logic;
        ce_vga   : out std_logic
    );
end component;

component mux_10bit_counter
    Port (
        sel         : in  std_logic;
        hctr        : in  std_logic_vector(9 downto 0);
        vctr        : in  std_logic_vector(9 downto 0);
        counter_out : out std_logic_vector(9 downto 0)
    );
end component;
   
    signal reset: std_logic;
    signal ce_vga, clk_100MHz, ce_25MHz, ce_50Hz : std_logic;
    signal led_counter : std_logic_vector(9 downto 0);
begin
    reset <= not CPU_RESETN;
    
    mux_ce_inst : mux_1bit_ce
    port map (
        sel      => SW14,
        ce_50Hz  => ce_50Hz,
        ce_25MHz => ce_25MHz,
        ce_vga   => ce_vga
    );

--mux_counter_inst : mux_10bit_counter
--    port map (
--        sel         => SW15,
--        hctr        => hctr,
--        vctr        => vctr,
--        counter_out => counter_out
--    );
    
    --LED(9 downto 0) <= counter_out;
    -- 1-bit mux: select VGA clock enable
    --ce_vga <= ce_50Hz when SW14 = '0' else ce_25MHz;

    -- 10-bit mux: select counter displayed on LEDs
    --led_counter <= hctr when SW15 = '0' else vctr;

    -- Connect selected counter to LED0-LED9
   -- LED(9 downto 0) <= led_counter;

    
    CE_generator_25MHz_inst: CE_generator_25MHz
   port map (
      clk_100MHz => clk_100MHz,
      reset      => reset,    
      ce_25MHz   => ce_25MHz 
   );
   

    

end Behavioral;
