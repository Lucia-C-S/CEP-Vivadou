library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity complete_circuit is
    Port ( A: in std_logic_vector(3 downto 0);
          F: out std_logic_vector(2 downto 0));
end complete_circuit;

architecture Behavioral of complete_circuit is
    component ADDER2 is
        Port ( AB : in STD_LOGIC_VECTOR (3 downto 0);
              RESULT : out STD_LOGIC_VECTOR (2 downto 0));
    end component;

    component comparator is
        Port (A: in std_logic_vector (2 downto 0);
              F: out std_logic_vector (2 downto 0));
    end component;
    
    signal SUM: std_logic_vector (2 downto 0);
begin
    AD : ADDER2 port map (AB => A, RESULT  => SUM); --port connected to port / port to signal (both from adder)
    COMCOMP : comparator port map (A => SUM, F => F);
    -- we connect from component adder to entity complete_circuit
    -- we connect

end Behavioral;
