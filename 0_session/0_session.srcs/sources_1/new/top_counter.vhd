library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_counter is
    Port ( clk : in STD_LOGIC;
           CPU_RESETN : in STD_LOGIC;
           ce : in std_logic;
           load : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (7 downto 0);
           q : out STD_LOGIC_VECTOR (7 downto 0);
           tc : out STD_LOGIC);
end top_counter;

architecture Behavioral of top_counter is

component pushbutton
   port (
      BTND       :  in  std_logic;
      clk        :  in  std_logic;
      reset      :  in  std_logic;
      sync_reset :  in  std_logic;
      BTNC_input :  out  std_logic
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
   
  signal reset : std_logic;
  signal ce_out : std_logic;

begin

    reset <= not CPU_RESETN; -- we make conversion exact as diapos bc
    -- physical active-low reset button, whereas your circuit
    -- apparently wants an internal active-high reset
  
  pushbutton_inst: pushbutton
   port map (
      BTND       => ce,     
      clk        => clk,      
      reset      => reset,    
      sync_reset => reset,
      BTNC_input => ce_out
   );
   
   counter_8_bits_lesson_0_inst: counter_8_bits_lesson_0
   port map (
      ce              => ce_out,            
      clk             => clk,           
      load            => load,          
      reset           => reset,         
      din(7 downto 0) => din(7 downto 0),
      tc              => tc,            
      q(7 downto 0)   => q(7 downto 0) 
   );
   
   
end Behavioral;
