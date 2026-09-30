library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_1_bit_4_channel is
    Port ( d : in STD_LOGIC_VECTOR (3 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0);
           G : in STD_LOGIC;
           Q : out STD_LOGIC);
end mux_1_bit_4_channel;

architecture Behavioral of mux_1_bit_4_channel is
begin
    
    process (G, s, d) -- SENSITIVITY LIST: signal (array in this case (process(g, s, d))) 
 --for which we execute the process on each of the components (signals) when they change
 begin 
   case G is 
    -- when-- allows us to use the OR operator/verical bar/ |
    when '0'  => Q <= '0'; --whats next is the function assigned a one, => means "THEN"

    when '1' =>
        case s is  
            when "00" => Q <= d(0);
            when "01" => Q <= d(1);
            when "10" => Q <= d(2);
            when "11" => Q <= d(3);
            
            when others => Q <= '0';
        end case;
   when others => Q <= '0';
  end case; 

end process;

end Behavioral;
