
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

entity mi_circuito is
    Port ( entrada7 : in  STD_LOGIC;
           entrada0 : in  STD_LOGIC;
           entrada1 : in  STD_LOGIC;
           entrada2 : in  STD_LOGIC;
           entrada3 : in  STD_LOGIC;
           entrada4 : in  STD_LOGIC;
           mis_entradas : in  STD_LOGIC_VECTOR (3 downto 0);
           entrada5 : in  STD_LOGIC;
           entrada6 : in  STD_LOGIC;
           mis_salidas : out  STD_LOGIC_VECTOR (3 downto 0);
			  salida1: out  STD_LOGIC;
           mis_otras_salidas : out  STD_LOGIC_VECTOR (6 downto 0);
           salida2 : out  STD_LOGIC);
end mi_circuito;

architecture Behavioral of mi_circuito is

	signal internas_A: std_logic_vector (3 downto 0):= (others=>'0');
	signal internas_B: std_logic_vector (4 downto 0);
	signal interna_A: std_logic:='0';	

begin

	mis_salidas <= internas_A;

internas_B <= (entrada5 & internas_A);

	With internas_B select

	mis_otras_salidas <= "1000000" when "10000",
					 "1111001" when "10001",
					 "0100100" when "10010",
					 "0110000" when "10011",
					 "0011001" when "10100",
					 "0010010" when "10101",
					 "0000010" when "10110",
					 "1111000" when "10111",
					 "0000000" when "11000",
					 "0010000" when "11001",
					 "0001000" when "11010",
					 "0000011" when "11011",
					 "1000110" when "11100",
					 "0100001" when "11101",
					 "0000110" when "11110",
					 "0001110" when "11111",
					 "1111111" when others;

salida2 <= ((entrada5 AND (NOT entrada6)) OR (NOT entrada5));


   FDCPE_inst : FDCPE
   generic map (
      INIT => '0') 
   port map (
      Q => interna_A,
      C => entrada7,
      CE => '1',
      CLR => entrada0,
      D => entrada3,
      PRE => '0'
   );

process (entrada7, entrada2, entrada0, entrada1, entrada4, internas_A)
begin
   if (entrada0'event and entrada0='1') then
		internas_A <= "0000";
   elsif (entrada7'event and entrada7='1') then
	   if entrada1='1' then
			internas_A <= "0000";
		elsif entrada3='1' then
         internas_A <= mis_entradas;
      else
         if entrada2='1' then
            if entrada4='1' then
					if internas_A = "1111" then
						internas_A <= "0000";
					else
						internas_A <= internas_A + 1;
					end if;
            else
					if internas_A = "0000" then
						internas_A <= "1111";
					else
						internas_A <= internas_A - 1;
					end if;				
            end if;
         end if;
      end if;
	end if;

	if (((internas_A = "1111") and entrada4 = '1') or ((internas_A = "0000") and entrada4 = '0')) then salida1 <= '1';
	else salida1 <= '0';
	end if;
end process;


end Behavioral;
