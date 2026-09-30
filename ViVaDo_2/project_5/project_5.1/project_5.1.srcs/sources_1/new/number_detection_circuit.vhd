library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity number_detection_circuit is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           f1, f2, f3 : out STD_LOGIC);
end number_detection_circuit;

architecture Behavioral of number_detection_circuit is
    component  function1 is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
              f1 : out STD_LOGIC);
    end component;
    
    component function2 is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
              f2 : out STD_LOGIC);
    end component;
    
    component function3 is
         Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               f3 : out STD_LOGIC);
    end component;
begin
    FUN1: function1 port map (a => a, f1 => f1);
    FUN2: function2 port map (a => a, f2 => f2);
    FUN3: function3 port map (a => a, f3 => f3);


end Behavioral;
