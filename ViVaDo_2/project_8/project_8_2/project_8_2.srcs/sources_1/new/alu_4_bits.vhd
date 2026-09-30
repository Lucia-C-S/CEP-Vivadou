library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity alu_4_bits is
    Port ( a,b : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           result : out STD_LOGIC_VECTOR (7 downto 0));
end alu_4_bits;

architecture Behavioral of alu_4_bits is

component and2 is
    Port ( a, b: in STD_LOGIC_VECTOR (3 downto 0);
           res_and : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component twos_comp is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           res_twos : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component subs is
    Port ( a,b : in STD_LOGIC_VECTOR (3 downto 0);
           res_subs : out STD_LOGIC_VECTOR (4 downto 0));
end component; 

component mult is
    Port ( a,b : in STD_LOGIC_VECTOR (3 downto 0);
           res_mult : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component mux_4_channels is
    Port ( ch1, ch2, ch3, ch4 : in STD_LOGIC_VECTOR (7 downto 0);
            sel: in std_logic_vector(1 downto 0);
           result_mux : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- Señales para manejar los datos de las lineas de resultado
signal res_and : STD_LOGIC_VECTOR (3 downto 0);
signal res_subs, res_twos : STD_LOGIC_VECTOR (4 downto 0);
signal res_mult : STD_LOGIC_VECTOR (7 downto 0);

signal res_and_aux, res_subs_aux, res_twos_aux : std_logic_vector(7 downto 0);

begin

F_AND2: and2 Port map (a => a, b => b, res_and => res_and);
F_TWOS: twos_comp Port map (a => a, res_twos => res_twos);
F_SUBS: subs Port map (a => a, b => b, res_subs => res_subs);
F_MULT: mult Port Map (a=> a, b=> b, res_mult => res_mult);

process(res_and, res_subs, res_twos)
begin
    -- Extend res_and to 8 bits
    res_and_aux <= "0000" & res_and;

    -- Sign-extend res_subs (5 bits -> 8 bits)
    if res_subs(4) = '1' then
        res_subs_aux <= "111" & res_subs;
    else
        res_subs_aux <= "000" & res_subs;
    end if;

    -- Sign-extend res_twos (5 bits -> 8 bits)
    if res_twos(4) = '1' then
        res_twos_aux <= "111" & res_twos;
    else
        res_twos_aux <= "000" & res_twos;
    end if;
end process;
 
 MUX_UUT: mux_4_channels Port map (ch1 => res_and_aux,
                                   ch2 => res_twos_aux,
                                   ch3 => res_subs_aux,
                                   ch4 => res_mult,  
                                   sel => sel,
                                   result_mux => result);
    
 end Behavioral;