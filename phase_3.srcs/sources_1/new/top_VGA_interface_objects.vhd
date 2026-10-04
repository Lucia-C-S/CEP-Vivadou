library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top_board_VGA_interface_phase_1 is
    Port ( clk : in STD_LOGIC;
           CPU_RESETN : in STD_LOGIC;
           --SW15 : in STD_LOGIC; PHASE 2
           --SW14 : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (3 downto 0); -- SW(3:0) PIXEL COLOUR -- phase 2 update
          -- LED : out STD_LOGIC_VECTOR (9 downto 0); --LED(9 downto 0) = CONTROL STATE
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

-- PHASE 2 
component FMS_VGA
   port (
      clk           :  in  std_logic;
      reset         :  in  std_logic;
      sw1           :  in  std_logic;
      sw2           :  in  std_logic;
      sw3           :  in  std_logic;
      colour_scheme :  out  std_logic_vector(2 downto 0)
   );
   end component;
   
   component colour_generator
    Port (
        clk           : in  STD_LOGIC;
        reset         : in  STD_LOGIC;
        black_on      : in  STD_LOGIC;
        colour_scheme : in  STD_LOGIC_VECTOR(2 downto 0);
        hctr          : in  STD_LOGIC_VECTOR(9 downto 0);
        vctr          : in  STD_LOGIC_VECTOR(9 downto 0);
        pixel_colour  : out STD_LOGIC_VECTOR(11 downto 0)
    );
    end component;
   
   --------------
   
    signal reset: std_logic;
    signal ce_25MHz : std_logic;
    signal hctr_int : std_logic_vector(9 downto 0);
    signal vctr_int : std_logic_vector(9 downto 0);
    signal hsync_int : std_logic;
    signal vsync_int : std_logic;
    --PHASE 2
    signal colour_scheme : std_logic_vector(2 downto 0);
    signal pixel_colour_int : std_logic_vector(11 downto 0);
begin
    reset <= not CPU_RESETN;
    
    CE_generator_25MHz_inst: CE_generator_25MHz
   port map (
      clk_100MHz => clk,
      reset      => reset,    
      ce_25MHz   => ce_25MHz 
   );

   
   VGA : vga_interface
    port map (
        clk          => clk,
        reset        => reset,
        ce_25MHz     => ce_25MHz,
        pixel_colour => pixel_colour_int,

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
  
  
  --PHASE 2
  
FMS_VGA_inst: FMS_VGA
   port map (
      clk                       => clk,                     
      reset                     => reset,                   
      sw1                       => SW(1),                     
      sw2                       => SW(2),                     
      sw3                       => SW(3),                     
      colour_scheme => colour_scheme
   );
   
colour_scheme_inst: colour_generator
    port map (
        clk           => clk,
        reset         => reset,
        black_on      => SW(0),
        colour_scheme => colour_scheme,
        hctr          => hctr_int,
        vctr          => vctr_int,
        pixel_colour  => pixel_colour_int
    );

end Behavioral;
