-- 
-- VHDL Test Bench for module: dynamic_7_segment_display_controller_reg
-- 
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Testbench_dynamic_7_segment_display_controller_reg IS
END Testbench_dynamic_7_segment_display_controller_reg;
 
ARCHITECTURE behavior OF Testbench_dynamic_7_segment_display_controller_reg IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
component dynamic_7_segment_display_controller_reg
   port (
      ce_1kHz    :  in  std_logic;
      clk        :  in  std_logic;
      en_digit0  :  in  std_logic;
      en_digit1  :  in  std_logic;
      en_digit2  :  in  std_logic;
      en_digit3  :  in  std_logic;
      en_digit4  :  in  std_logic;
      en_digit5  :  in  std_logic;
      en_digit6  :  in  std_logic;
      en_digit7  :  in  std_logic;
      en_display :  in  std_logic;
      reset      :  in  std_logic;
      digit0_D   :  in  std_logic_vector(7 downto 0);
      digit1_D   :  in  std_logic_vector(7 downto 0);
      digit2_D   :  in  std_logic_vector(7 downto 0);
      digit3_D   :  in  std_logic_vector(7 downto 0);
      digit4_D   :  in  std_logic_vector(7 downto 0);
      digit5_D   :  in  std_logic_vector(7 downto 0);
      digit6_D   :  in  std_logic_vector(7 downto 0);
      digit7_D   :  in  std_logic_vector(7 downto 0);
      A          :  out  std_logic;
      an0        :  out  std_logic;
      an1        :  out  std_logic;
      an2        :  out  std_logic;
      an3        :  out  std_logic;
      an4        :  out  std_logic;
      an5        :  out  std_logic;
      an6        :  out  std_logic;
      an7        :  out  std_logic;
      B          :  out  std_logic;
      C          :  out  std_logic;
      D          :  out  std_logic;
      DP         :  out  std_logic;
      E          :  out  std_logic;
      F          :  out  std_logic;
      G          :  out  std_logic
   );
   end component;

   

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal ce_1kHz : std_logic := '0';
   signal vis0_D : std_logic_vector(7 downto 0) := (others => '0');
   signal vis1_D : std_logic_vector(7 downto 0) := (others => '0');
   signal vis2_D : std_logic_vector(7 downto 0) := (others => '0');
   signal vis3_D : std_logic_vector(7 downto 0) := (others => '0');
   signal vis4_D : std_logic_vector(7 downto 0) := (others => '0');
   signal vis5_D : std_logic_vector(7 downto 0) := (others => '0');
   signal vis6_D : std_logic_vector(7 downto 0) := (others => '0');
   signal vis7_D : std_logic_vector(7 downto 0) := (others => '0');
   signal gvis : std_logic := '0';
   signal gvis0 : std_logic := '0';
   signal gvis1 : std_logic := '0';
   signal gvis2 : std_logic := '0';
   signal gvis3 : std_logic := '0';
   signal gvis4 : std_logic := '0';
   signal gvis5 : std_logic := '0';
   signal gvis6 : std_logic := '0';
   signal gvis7 : std_logic := '0';

 	--Outputs
   signal an0 : std_logic;
   signal an1 : std_logic;
   signal an2 : std_logic;
   signal an3 : std_logic;
   signal an4 : std_logic;
   signal an5 : std_logic;
   signal an6 : std_logic;
   signal an7 : std_logic;
   signal A : std_logic;
   signal B : std_logic;
   signal C : std_logic;
   signal D : std_logic;
   signal E : std_logic;
   signal F : std_logic;
   signal G : std_logic;
   signal DP : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns; -- reloj principal de 100MHz
   constant clk_en_period : time := 1 us; -- Para acelerar simulación establecemos 1MHz como frecuencia de barrido de los dígitos 
														 -- Normalmente en la placa usaremos 1 kHz
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
-- 8-digit 7-segment display component instantiation
dynamic_7_segment_display_controller_reg_inst: dynamic_7_segment_display_controller_reg
   port map (
      ce_1kHz              => ce_1kHz,            
      clk                  => clk,                
      en_digit0            => gvis0,          
      en_digit1            => gvis1,          
      en_digit2            => gvis2,          
      en_digit3            => gvis3,          
      en_digit4            => gvis4,          
      en_digit5            => gvis5,          
      en_digit6            => gvis6,          
      en_digit7            => gvis7,          
      en_display           => gvis,         
      reset                => reset,              
      digit0_D(7 downto 0) => vis0_D,
      digit1_D(7 downto 0) => vis1_D,
      digit2_D(7 downto 0) => vis2_D,
      digit3_D(7 downto 0) => vis3_D,
      digit4_D(7 downto 0) => vis4_D,
      digit5_D(7 downto 0) => vis5_D,
      digit6_D(7 downto 0) => vis6_D,
      digit7_D(7 downto 0) => vis7_D,
      A                    => A,                  
      an0                  => an0,                
      an1                  => an1,                
      an2                  => an2,                
      an3                  => an3,                
      an4                  => an4,                
      an5                  => an5,                
      an6                  => an6,                
      an7                  => an7,                
      B                    => B,                  
      C                    => C,                  
      D                    => D,                  
      DP                   => DP,                 
      E                    => E,                  
      F                    => F,                  
      G                    => G                  
   );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   clk_en_process :process
   begin
		ce_1kHz <= '0';
		wait for clk_en_period/2;
		ce_1kHz <= '1';
		wait for clk_period;
		ce_1kHz <= '0';
		wait for clk_en_period/2;
   end process;
 

   -- Proceso de generación de estímulos
   stim_proc: process
   begin	
          reset <= '1';
          vis7_D <= x"00";
          vis6_D <= x"00";
          vis5_D <= x"00";
          vis4_D <= x"00";
          vis3_D <= x"00";
          vis2_D <= x"00";
          vis1_D <= x"00";
          vis0_D <= x"00";
			 
          gvis <= '0';
          gvis7 <= '0';
          gvis6 <= '0';
          gvis5 <= '0';
          gvis4 <= '0';
          gvis3 <= '0';
          gvis2 <= '0';
          gvis1 <= '0';
          gvis0 <= '0';
      
		-- mantener reset durante 100 ns.
      wait for 100 ns;	
          reset <= '0';
	
      wait for clk_en_period;
 
          vis7_D <= x"0D";
          vis6_D <= x"0C";
          vis5_D <= x"0B";
          vis4_D <= x"0A";
          vis3_D <= x"08";
          vis2_D <= x"04";
          vis1_D <= x"02";
          vis0_D <= x"01";

          gvis <= '1';
          gvis7 <= '1';
          gvis6 <= '1';
          gvis5 <= '1';
          gvis4 <= '1';
          gvis3 <= '1';
          gvis2 <= '1';
          gvis1 <= '1';
          gvis0 <= '1';


      wait for clk_en_period*20;


	-- La simulación finaliza cuando se ejecuta la opción "run -all"  
	assert (false) report "Fin simulacion. NO es un error" severity FAILURE; 

      wait;
   end process;

END;
