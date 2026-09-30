----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2026.09.14 09:42:03
-- Design Name: 
-- Module Name:
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY testbench_counter_8_bits_lesson_0 IS
END testbench_counter_8_bits_lesson_0;
 
ARCHITECTURE behavior OF testbench_counter_8_bits_lesson_0 IS 
 
   -- Component Declaration for the Unit Under Test (UUT)
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
   
      
   -- Inputs
   signal ce    :  std_logic := '0';
   signal clk   :  std_logic := '0';
   signal load  :  std_logic := '0';
   signal reset :  std_logic := '0';
   signal din   :  std_logic_vector(7 downto 0) := (others => '0');
      
   -- Outputs
   signal tc    :  std_logic;  
   signal q     :  std_logic_vector(7 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN
   
   -- Instantiate the Unit Under Test (UUT)
   counter_8_bits_lesson_0_inst: counter_8_bits_lesson_0
   port map (
      ce              => ce,            
      clk             => clk,           
      load            => load,          
      reset           => reset,         
      din(7 downto 0) => din(7 downto 0),
      tc              => tc,            
      q(7 downto 0)   => q(7 downto 0) 
   );    
   
   edge_detector_inst: edge_detector
   port map (
      clk                => clk,              
      input              => input,            
      reset              => reset,            
      input_falling_edge => input_falling_edge,
      input_rising_edge  => input_rising_edge,
      input_sync         => input_sync       
   ); 
   
   -- Clock process definitions
   clk_process :process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;
         
   -- Stimulus process
   stim_proc: process
   BEGIN
      -- initial conditions
     reset<= '1';
     ce<= '0';
     din <= x"00";
     load <= '0';
     wait for clk_period;
     
     reset <='0';
      -- Wait 200 ns for global reset to finish
      wait for 200 ns;
     
     ce <='1';
     wait for 300*clk_period;
     
     din <= x"99";
     load <= '1';
      -- This command stops simulation when "run all" is executed
      -- assert (false) report "Simulation stop" severity FAILURE;
    
   END PROCESS;
    
END;
