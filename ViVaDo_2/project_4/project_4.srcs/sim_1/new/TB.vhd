library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- for function tounsigned

entity TB is
--  Port ( );
end TB;

architecture Behavioral of TB is
    --copy entity from ADDER2 and paste here changing entity by COMPONENT
    component complete_circuit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           F : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    --signal definitions:
    signal TA: STD_LOGIC_VECTOR (3 downto 0);
    signal TF: STD_LOGIC_VECTOR (2 downto 0);
begin
    --FIRST: instantiation -- assign port to signals
    UUT: complete_circuit port map (A => TA , F => TF);
    --sensitivity list process
    process
    begin -- a process is separated by that
        for i in 0 to 15 loop 
            TA <= std_logic_vector (to_unsigned(i, 4)); --converts i into binary withb 4 bits
                wait for 1 us; -- we need 16 microseconds to carry out all the similation
        end loop;
     end process;

end Behavioral;

--run simulation > scope > window objets UUT > add sources SUM