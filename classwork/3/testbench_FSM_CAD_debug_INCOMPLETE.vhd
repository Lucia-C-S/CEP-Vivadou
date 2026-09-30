library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY testbench_FSM_CAD_debug IS
END testbench_FSM_CAD_debug;
 
ARCHITECTURE behavior OF testbench_FSM_CAD_debug IS 
 
   -- Component Declaration for the Unit Under Test (UUT)
   component FSM_CAD_debug
   port (
      clk         :  in  std_logic;
      eoc_s       :  in  std_logic;
      reset       :  in  std_logic;
      tc_ctr      :  in  std_logic;
      ce_ctr      :  out  std_logic;
      end_process :  out  std_logic;
      reset_ctr   :  out  std_logic;
      we_ram      :  out  std_logic;
      state_debug :  out  std_logic_vector(5 downto 0)
   );
   end component;    
   
      
   -- Inputs
   signal clk         :  std_logic := '0'; 
   signal eoc_s       :  std_logic := '0'; 
   signal reset       :  std_logic := '0'; 
   signal tc_ctr      :  std_logic := '0'; 
      
   -- Outputs
   signal ce_ctr      :  std_logic;        
   signal end_process :  std_logic;        
   signal reset_ctr   :  std_logic;        
   signal we_ram      :  std_logic;        
   signal state_debug :  std_logic_vector(5 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN
   
   -- Instantiate the Unit Under Test (UUT)
   FSM_CAD_debug_inst: FSM_CAD_debug
   port map (
      clk                     => clk,                   
      eoc_s                   => eoc_s,                 
      reset                   => reset,                 
      tc_ctr                  => tc_ctr,                
      ce_ctr                  => ce_ctr,                
      end_process             => end_process,           
      reset_ctr               => reset_ctr,             
      we_ram                  => we_ram,                
      state_debug(5 downto 0) => state_debug(5 downto 0)
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
      reset <= '1';
      eoc_s <= '0';
      -- Wait 200 ns for global reset to finish
      wait for 200 ns;
      reset <= '0';
      wait for clk_period;

-- Receive 16 values. 

--YOU MUST COMPLETE THIS PART
--YOU MUST REPEAT 16 TIMES THE FOLLOWING ACTIONS:
--	- ACTIVATE THE INPUT "eoc_s" FOR 1 CLOCK CYCLE
--	- DEACTIVATE THE INPUT "eoc_s" FOR 10 CLOCK CYCLES
    
    for i in 0 to 16 loop
        eoc_s <= '1';
      wait for clk_period;
         eoc_s <= '0';
      wait for 10*clk_period;
    end loop;


      wait for 100 ns;
     
      -- This command stops simulation when "run all" is executed
      assert (false) report "Simulation stop" severity FAILURE;
    
   END PROCESS;
    
END;
