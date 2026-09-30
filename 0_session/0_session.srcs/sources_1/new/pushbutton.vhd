library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pushbutton is
    Port ( BTND : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           BTNC_input : out STD_LOGIC;
           sync_reset : in STD_LOGIC);
end pushbutton;

architecture Behavioral of pushbutton is
 component CE_generator_1kHz
   port (
      clk     :  in  std_logic;
      reset   :  in  std_logic;
      ce_1kHz :  out  std_logic
   );
   end component;
   
   component D_flip_flop
   port (
      async_reset :  in  std_logic;
      ce          :  in  std_logic;
      clk         :  in  std_logic;
      d           :  in  std_logic;
      sync_reset  :  in  std_logic;
      q           :  out  std_logic
   );
   end component;
   
   component edge_detector
   port (
      clk                :  in  std_logic;    
      input              :  in  std_logic;    
      reset              :  in  std_logic;    
      input_falling_edge :  out  std_logic;   
      input_rising_edge  :  out  std_logic;   
      input_sync         :  out  std_logic   
   );
   end component;

component counter_8_bits_lesson_0
   port (
      ce    :  in  std_logic;
      clk   :  in  std_logic;
      load  :  in  std_logic;
      reset :  in  std_logic;
      din   :  in  std_logic_vector(7 downto 0);
      tc    :  out  std_logic;
      q     :  out  std_logic_vector(7 downto 0)
   );
   end component;

signal ce    : STD_LOGIC;
signal button_edge : STD_LOGIC;
signal input : STD_LOGIC;

begin
--PORT MAPS GO NOW
 CE_generator_1kHz_inst: CE_generator_1kHz
    port map ( 
        clk => clk,
        reset => reset,
        ce_1kHz => ce
    );

D_flip_flop_inst: D_flip_flop
   port map (
      async_reset => '0',
      ce          => ce,        
      clk         => clk,       
      d           => BTND,         
      sync_reset  => sync_reset,
      q           => input        
   );
   
   edge_detector_inst: edge_detector
   port map (
      clk                => clk,              
      input              => input,            
      reset              => reset,            
      input_falling_edge => open,
      input_rising_edge  => button_edge,
      input_sync         => open      
   );
   

end Behavioral;
