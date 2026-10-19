library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parity_check is
    port (
        arriving_bits : in  std_logic_vector(10 downto 0);
        parity_error  : out std_logic
    );
end entity;

architecture rtl of parity_check is
begin
    process(arriving_bits)
        variable parity_xor : std_logic;
    begin
        -- With the chosen shift direction, data bits are 8..1 and the
        -- received parity bit is bit 9. Correct PS/2 odd parity has XOR=1.
        parity_xor := '0';
        for i in 1 to 9 loop
            parity_xor := parity_xor xor arriving_bits(i);
        end loop;
        parity_error <= not parity_xor;
    end process;
end architecture;
