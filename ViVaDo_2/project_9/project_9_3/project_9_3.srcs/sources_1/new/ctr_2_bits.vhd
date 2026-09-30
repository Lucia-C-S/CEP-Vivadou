library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ctr_2_bits is
    Port ( reset, load, ce, clk : in STD_LOGIC;
           d: in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (1 downto 0);
           ceo, tc: out std_logic);
end ctr_2_bits;

architecture Behavioral of ctr_2_bits is
signal Qaux: integer range 0 to 3;
begin

process (clk) 
begin

if (rising_edge(clk)) then
    if (reset = '1') then Qaux <= 0;
    elsif (load = '1') then Qaux <= to_integer(unsigned(d));
   -- Si esta habilitado el contador, comenzamos con la cuenta.		
        elsif (ce = '1') then
		
		  -- Si llegamos al final de la cuenta, q_aux pasa a valer 0 de nuevo
		  if (Qaux = 3) then
		      Qaux <= 0;
		      
		     
	       -- Si no hemos llegado al final, sumamos una unidad al contador.
		  else
			 Qaux <= (Qaux + 1);
		  end if;
		  
	    else
	       -- Si reset vale 0, el valor de la salida se mantiene.
	       Qaux <= Qaux;
    end if;
  end if;
  end process;
  -- Una vez descrito el funcionamiento del contador, definimos los valores de salida.
	q <= STD_LOGIC_VECTOR(TO_UNSIGNED(Qaux,2));    -- Convierto de Decimal a Binario con esta linea.
	
	process(Qaux, ce) --can be done with a when else
	begin
	   if Qaux = 3 then tc <= '1';
	   else tc<= '0';
	   end if;          -- Comprobamos si hemos llegado al final para indicarlo en tc
	
	--  Carry enable out (only when counting and at terminal count)
	   if (Qaux = 3 and ce = '1') then
	           ceo <= '1';
	   else  ceo <= '0'; -- En caso de que llegasemos al final y el contaje
	   -- este habilitado, habilitamos ceo.
	   end if;
	end process;
	
end Behavioral;
