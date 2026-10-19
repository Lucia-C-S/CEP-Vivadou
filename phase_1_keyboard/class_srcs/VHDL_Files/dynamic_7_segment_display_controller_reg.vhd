--------------------------------------------------------------------------------------
-- dynamic_7_segment_display_controller_reg 
--
-- This circuit controls the dynamic 8-digit 7-segment display on the Nexys 4 DDR board
-- Its main inputs are:
    -- The 8-bit vectors that indicate the active segments and the decimal point for each digit of the display (digit0_D, digit1_D, digit2_D, digit3_D digit4_D, digit5_D, digit6_D, digit7_D,)
    -- The enabling signals for the registers that are connected to the individual digits (en_digit0, en_digit1, en_digit2, en_digit3, en_digit4, en_digit5, en_digit6, en_digit7) and the whole display (en_display)
-- On the Nexys 4 DDR board both anodes and cathodes are active low  
-------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dynamic_7_segment_display_controller_reg is
    Port (
           ------------------- ENTRADAS 
           reset : in std_logic;    -- Puesta en estado inicial de todo el circuito
		   clk : in std_logic;      -- Reloj global
		   ce_1kHz : in std_logic;   -- Señal de habilitación que controla la frecuencia de barrido de los dígitos
		   -- Valores de los segmentos, activos a nivel uno, en orden A,B,C,D,E,F,G,DP
		   digit0_D : in std_logic_vector(7 downto 0); -- Segmentos correspondientes al dí­gito 0 (menor peso)
           digit1_D : in std_logic_vector(7 downto 0); -- Segmentos correspondientes al dí­gito 1
           digit2_D : in std_logic_vector(7 downto 0); -- Segmentos correspondientes al dí­gito 2
		   digit3_D : in std_logic_vector(7 downto 0); -- Segmentos correspondientes al dí­gito 3
		   digit4_D : in std_logic_vector(7 downto 0); -- Segmentos correspondientes al dí­gito 4
           digit5_D : in std_logic_vector(7 downto 0); -- Segmentos correspondientes al dí­gito 5
           digit6_D : in std_logic_vector(7 downto 0); -- Segmentos correspondientes al dí­gito 6
		   digit7_D : in std_logic_vector(7 downto 0); -- Segmentos correspondientes al dí­gito 7 (mayor peso)			  
			         -- Habilitaciones de los visualizadores
           en_display : in std_logic;  -- Habilitación global del visualizador de 4 dí­gitos
           en_digit0 : in std_logic; -- Habilitación del dígito 0 (menor peso)
           en_digit1 : in std_logic; -- Habilitación del dígito 1
           en_digit2 : in std_logic; -- Habilitación del dígito 2
           en_digit3 : in std_logic; -- Habilitación del dígito 3
           en_digit4 : in std_logic; -- Habilitación del dígito 4
           en_digit5 : in std_logic; -- Habilitación del dígito 5
           en_digit6 : in std_logic; -- Habilitación del dígito 6
           en_digit7 : in std_logic; -- Habilitación del dígito 7 (mayor peso)			  
			  ------------------- SALIDAS 
           an0 : out std_logic; -- Anodo del visualizador 0 (menor peso)
           an1 : out std_logic; -- Anodo del visualizador 1
           an2 : out std_logic; -- Anodo del visualizador 2
           an3 : out std_logic; -- Anodo del visualizador 3
           an4 : out std_logic; -- Anodo del visualizador 4
           an5 : out std_logic; -- Anodo del visualizador 5
           an6 : out std_logic; -- Anodo del visualizador 6
           an7 : out std_logic; -- Anodo del visualizador 7 (mayor peso)			  
			         -- Segmentos comunes a los cuatro dí­gitos del visualizador
           A : out std_logic;
           B : out std_logic;
           C : out std_logic;
           D : out std_logic;
           E : out std_logic;
           F : out std_logic;
           G : out std_logic;
           DP : out std_logic
			  );
end dynamic_7_segment_display_controller_reg;



architecture Behavioral of dynamic_7_segment_display_controller_reg is

-- Señal del contador que selecciona el visualizador activo
signal counter_digit	: std_logic_vector (2 downto 0):=(others =>'0');

-- Salida del multiplexor que selecciona el dato de entrada a visualizar
signal mux_digit	: std_logic_vector (7 downto 0):=(others =>'0');

-- Vector de activacion de ánodo en función del visualizador activo
signal anodes	: std_logic_vector (7 downto 0):=(others =>'0');

-- salidas de los registros que almacenan los valores de los dígitos a visualizar
signal digit0_D_reg : std_logic_vector(7 downto 0):=(others =>'0');
signal digit1_D_reg : std_logic_vector(7 downto 0):=(others =>'0');
signal digit2_D_reg : std_logic_vector(7 downto 0):=(others =>'0');
signal digit3_D_reg : std_logic_vector(7 downto 0):=(others =>'0');
signal digit4_D_reg : std_logic_vector(7 downto 0):=(others =>'0');
signal digit5_D_reg : std_logic_vector(7 downto 0):=(others =>'0');
signal digit6_D_reg : std_logic_vector(7 downto 0):=(others =>'0');
signal digit7_D_reg : std_logic_vector(7 downto 0):=(others =>'0');

begin

---------- REGISTROS DE ALMACENAMIENTO DE DÍGITOS  ----------------------
-- Registros de 8 bits con habilitación                  -- 
-------------------------------------------------------------------------

	process (reset, clk, en_digit0, en_digit1, en_digit2, en_digit3, en_digit4, en_digit5, en_digit6, en_digit7, digit0_D, digit1_D, digit2_D, digit3_D, digit4_D, digit5_D, digit6_D, digit7_D )
	begin
		if reset ='1' then
			digit0_D_reg <= x"00";
			digit1_D_reg <= x"00";
			digit2_D_reg <= x"00";
			digit3_D_reg <= x"00";
			digit4_D_reg <= x"00";
			digit5_D_reg <= x"00";
			digit6_D_reg <= x"00";
			digit7_D_reg <= x"00";
		elsif (clk ='1' and clk'event) then
			if en_digit0 ='1' then
				digit0_D_reg <= digit0_D;
			end if;
			if en_digit1 ='1' then
				digit1_D_reg <= digit1_D;
			end if;
			if en_digit2 ='1' then
				digit2_D_reg <= digit2_D;
			end if;
			if en_digit3 ='1' then
				digit3_D_reg <= digit3_D;
			end if;
			if en_digit4 ='1' then
				digit4_D_reg <= digit4_D;
			end if;
			if en_digit5 ='1' then
				digit5_D_reg <= digit5_D;
			end if;
			if en_digit6 ='1' then
				digit6_D_reg <= digit6_D;
			end if;
			if en_digit7 ='1' then
				digit7_D_reg <= digit7_D;
			end if;

		end if;
	end process;



---------- SELECCION DEL VISUALIZADOR ACTIVO  ---------------------------
-- Contador de 3 bits con habilitación de contaje que                  -- 
-- indica el visualizador que está activo en cada instante				  --
-------------------------------------------------------------------------

	process (reset, clk)
	begin
		if reset ='1' then counter_digit <= "000";
		elsif (clk ='1' and clk'event) then
			if ce_1kHz ='1' then
				if counter_digit = "111" then counter_digit <= "000";
				else counter_digit <= counter_digit + 1;
				end if;
			end if;
		end if;
	end process;
	


---------- ACTIVACION DE LOS ANODOS  ------------------------------------
-- Decodificador 1 entre 8 para seleccion del ánodo activo             -- 
-- en cada instante							                                --
-------------------------------------------------------------------------	

	anodes <= 	"00000001" when counter_digit = "000" else
			    "00000010" when counter_digit = "001" else
			    "00000100" when counter_digit = "010" else
			    "00001000" when counter_digit = "011" else
			    "00010000" when counter_digit = "100" else
			    "00100000" when counter_digit = "101" else
			    "01000000" when counter_digit = "110" else
			    "10000000" when counter_digit = "111" else
			    "00000000";


---------- SELECCIÓN DEL DATO A VISUALIZAR  -----------------------------
-- Multiplexor de ocho canales para la seleccion del                 -- 
-- dato a visualizar, correspondiente al digito del visualizador		  --
-- seleccionado en cada instante							                    --					                                
-------------------------------------------------------------------------

	mux_digit <=  digit0_D_reg when counter_digit = "000" else 
			      digit1_D_reg when counter_digit = "001" else 
			      digit2_D_reg when counter_digit = "010" else 
			      digit3_D_reg when counter_digit = "011" else 
				  digit4_D_reg when counter_digit = "100" else 
			      digit5_D_reg when counter_digit = "101" else 
			      digit6_D_reg when counter_digit = "110" else 
			      digit7_D_reg when counter_digit = "111" else
			      X"00";

					
-- Anodos de cada digito con habilitacion del visualizador
	an7 <= not(en_display and anodes(7)); -- Visualizador de mayor peso
	an6 <= not(en_display and anodes(6));
	an5 <= not(en_display and anodes(5));
	an4 <= not(en_display and anodes(4));
	an3 <= not(en_display and anodes(3));
	an2 <= not(en_display and anodes(2));
	an1 <= not(en_display and anodes(1));
	an0 <= not(en_display and anodes(0)); -- Visualizador de menor peso

-- Catodos comunes a todos los dígitos, activos a nivel bajo
	A <= not mux_digit(7);
	B <= not mux_digit(6);
	C <= not mux_digit(5);
	D <= not mux_digit(4);
	E <= not mux_digit(3);
	F <= not mux_digit(2);
	G <= not mux_digit(1);

-- Catodo correspondiente al punto decimal, activo a nivel bajo
	DP <= not mux_digit(0);


end Behavioral;

