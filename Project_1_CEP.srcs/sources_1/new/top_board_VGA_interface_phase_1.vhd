library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top_board_VGA_interface_phase_1 is
    Port ( clk : in STD_LOGIC;
           CPU_RESETN : in STD_LOGIC;
           SW15 : in STD_LOGIC;
           SW14 : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (11 downto 0); -- SW(11:0) PIXEL COLOUR
           LED : out STD_LOGIC_VECTOR (9 downto 0); --LED(9 downto 0) = CONTROL STATE
           vsync_led : out STD_LOGIC; --LED 15)
           vsync_os : out STD_LOGIC;--JB(1)
           hsync_os : out STD_LOGIC;--JB(2)
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
   
   component CE_generator_50Hz
    Port ( clk_100MHz : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ce_50Hz : out  STD_LOGIC);
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

component vga_interface
    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        ce_25MHz     : in  STD_LOGIC;
        pixel_colour : in  STD_LOGIC_VECTOR(11 downto 0);

        hctr         : out STD_LOGIC_VECTOR(9 downto 0);
        vctr         : out STD_LOGIC_VECTOR(9 downto 0);

        hsync        : out STD_LOGIC;
        vsync        : out STD_LOGIC;

        R            : out STD_LOGIC_VECTOR(3 downto 0);
        G            : out STD_LOGIC_VECTOR(3 downto 0);
        B            : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;
   
    signal reset: std_logic;
    signal ce_vga, ce_25MHz, ce_50Hz : std_logic;
    signal led_counter : std_logic_vector(9 downto 0);
    signal hctr_int : std_logic_vector(9 downto 0);
    signal vctr_int : std_logic_vector(9 downto 0);
    signal hsync_int : std_logic;
signal vsync_int : std_logic;
begin
    reset <= not CPU_RESETN;
    
    mux_ce_inst : mux_1bit_ce
    port map (
        sel      => SW14,
        ce_50Hz  => ce_50Hz,
        ce_25MHz => ce_25MHz,
        ce_vga   => ce_vga
    );

mux_counter_inst : mux_10bit_counter
    port map (
        sel         => SW15,
        hctr        => hctr_int,
        vctr        => vctr_int,
        counter_out => led_counter
    );
    
    LED <= led_counter;
    -- 1-bit mux: select VGA clock enable
    --ce_vga <= ce_50Hz when SW14 = '0' else ce_25MHz;

    -- 10-bit mux: select counter displayed on LEDs
    --led_counter <= hctr when SW15 = '0' else vctr;

    -- Connect selected counter to LED0-LED9
   -- LED(9 downto 0) <= led_counter;

    
    CE_generator_25MHz_inst: CE_generator_25MHz
   port map (
      clk_100MHz => clk,
      reset      => reset,    
      ce_25MHz   => ce_25MHz 
   );
   
   CE_generator_50Hz_inst: CE_generator_50Hz
    port map (
           clk_100MHz => clk,
           reset => reset,
           ce_50Hz => ce_50Hz
    );
   
   VGA : vga_interface
    port map (
        clk          => clk,
        reset        => reset,
        ce_25MHz     => ce_vga,
        pixel_colour => SW,

        hctr         => hctr_int,
        vctr         => vctr_int,

        hsync        => hsync_os,
        vsync        => vsync_os,

        R            => VGA_R,
        G            => VGA_G,
        B            => VGA_B
    ); 
    
    hsync_os  <= hsync_int;
vsync_os  <= vsync_int;
VGA_hsync <= hsync_int;
VGA_vsync <= vsync_int;
vsync_led <= vsync_int;
  

end Behavioral;
