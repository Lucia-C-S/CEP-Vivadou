library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB is --entity testbench doesnt contain ports but signals
end TB;
--copy all entity here replacing name entity with component

architecture Beh of TB is --el nombre que quieras para la arquitecture
      -- COMPONENT
      component detection_digital_ones is
        port (d,c,b,a: in std_logic;
                F:out std_logic);
      end component;
      --SIGNALS: señales auxiliares pa la simulación (INPUTS and outputs pueden ir juntos)
      signal Td, Tc, Tb, Ta, Tf: STD_LOGIC;
      
begin
--instantiation
UUUT: detection_digital_ones port map(d => Td, c => Tc, b => Tb, a => Ta, f => Tf);
 
 --para hacerlo secuencial
 process
 begin
    Td <= '0'; Tc <= '0'; Tb <= '0'; Ta <= '0'; --do this for each combination of
        --the inputs in the truth table (0001, 0011, ...., 1111)
    wait for 1 us;
 
    Td <= '0'; Tc <= '0'; Tb <= '0'; Ta <= '1'; 
    wait for 1 us;
    
    Td <= '0'; Tc <= '0'; Tb <= '1'; Ta <= '0'; 
    wait for 1 us;
    
    Td <= '0'; Tc <= '0'; Tb <= '1'; Ta <= '1'; 
    wait for 1 us;
    
    Td <= '0'; Tc <= '1'; Tb <= '0'; Ta <= '0'; 
    wait for 1 us;
    
    Td <= '0'; Tc <= '1'; Tb <= '0'; Ta <= '1'; 
    wait for 1 us;
    
    Td <= '0'; Tc <= '1'; Tb <= '1'; Ta <= '0'; 
    wait for 1 us;
    
    Td <= '0'; Tc <= '1'; Tb <= '1'; Ta <= '1'; 
    wait for 1 us;
    
    Td <= '1'; Tc <= '0'; Tb <= '0'; Ta <= '0'; 
    wait for 1 us;
    
    Td <= '1'; Tc <= '0'; Tb <= '1'; Ta <= '1'; 
    wait for 1 us;
    
    Td <= '1'; Tc <= '0'; Tb <= '1'; Ta <= '0'; 
    wait for 1 us;
     
    Td <= '1'; Tc <= '0'; Tb <= '1'; Ta <= '1'; 
    wait for 1 us;
    
    Td <= '1'; Tc <= '1'; Tb <= '0'; Ta <= '0'; 
    wait for 1 us;
    
    Td <= '1'; Tc <= '1'; Tb <= '0'; Ta <= '1'; 
    wait for 1 us;

    Td <= '1'; Tc <= '1'; Tb <= '1'; Ta <= '0'; 
    wait for 1 us;
    
    Td <= '1'; Tc <= '1'; Tb <= '1'; Ta <= '1'; 
    wait; -- bc it is the last operation combination
    
    end process;
end;
