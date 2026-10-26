library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PS2_advanced_interface is
    port (
        clk          : in  STD_LOGIC;
        kbclk        : in  STD_LOGIC;
        kbdata       : in  STD_LOGIC;
        reset        : in  STD_LOGIC;

        data         : out STD_LOGIC_VECTOR(7 downto 0);
        end_key      : out STD_LOGIC;
        key          : out STD_LOGIC_VECTOR(7 downto 0);
        new_data     : out STD_LOGIC;
        new_key      : out STD_LOGIC;
        parity_error : out STD_LOGIC
    );
end PS2_advanced_interface;

architecture Behavioral of PS2_advanced_interface is
    component PS2_basic_interface
   port (
      clk           :  in  std_logic;
      kbclk         :  in  std_logic;
      kbdata        :  in  std_logic;
      reset         :  in  std_logic;
      end_data      :  out  std_logic;
      parity_error  :  out  std_logic;
      data_received :  out  std_logic_vector(7 downto 0)
   );
   end component;
   
   component PS2_advanced_fsm
   port (
      clk        :  in  std_logic;
      data_eq_F0 :  in  std_logic;
      end_data   :  in  std_logic;
      reset      :  in  std_logic;
      ce_key     :  out  std_logic;
      end_key    :  out  std_logic;
      new_key    :  out  std_logic
   );
   end component;
   
   component comparator_8_bits
   port (
      a      :  in  std_logic_vector(7 downto 0);
      b      :  in  std_logic_vector(7 downto 0);
      a_eq_b :  out  std_logic;
      a_gt_b :  out  std_logic;
      a_lt_b :  out  std_logic
   );
   end component;
   
   component register_8_bits
   port (
      ce    :  in  std_logic;
      clk   :  in  std_logic;
      reset :  in  std_logic;
      d     :  in  std_logic_vector(7 downto 0);
      q     :  out  std_logic_vector(7 downto 0)
   );
   end component;   
   

signal data_internal : std_logic_vector(7 downto 0);
signal key_register : std_logic_vector(7 downto 0);
 signal ce_key : std_logic;
 signal b : std_logic_vector(7 downto 0) := "11110000";
   signal data_eq_F0 : std_logic;
signal end_data_int : std_logic;

 begin

PS2_basic_interface_inst: PS2_basic_interface
   port map (
      clk                       => clk,                     
      kbclk                     => kbclk,                   
      kbdata                    => kbdata,                  
      reset                     => reset,                   
      end_data                  => end_data_int,                
      parity_error              => parity_error,            
      data_received(7 downto 0) => data_internal(7 downto 0)
   );
   
   comparator_8_bits_inst: comparator_8_bits
   port map (
      a(7 downto 0) => data_internal(7 downto 0),
      b(7 downto 0) => b,
      a_eq_b        => data_eq_F0      
   );
   
   PS2_advanced_fsm_inst: PS2_advanced_fsm
   port map (
      clk        => clk,      
      data_eq_F0 => data_eq_F0,
      end_data   => end_data_int, 
      reset      => reset,    
      ce_key     => ce_key,   
      end_key    => end_key,  
      new_key    => new_key  
   );
   
   register_8_bits_inst: register_8_bits
   port map (
      ce            => ce_key,          
      clk           => clk,         
      reset         => reset,       
      d(7 downto 0) => data_internal(7 downto 0),
      q(7 downto 0) => key_register(7 downto 0)
   );

data <= data_internal;
key <= key_register;
new_data <= end_data_int;

end Behavioral;
