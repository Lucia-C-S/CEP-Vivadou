library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parity_check is
    Port (
        arriving_bits : in  STD_LOGIC_VECTOR(10 downto 0);
        parity_error  : out STD_LOGIC
    );
end parity_check;

architecture Behavioral of parity_check is

    signal parity_result : STD_LOGIC;

begin

    -- XOR de los 8 bits de datos y del bit de paridad.
    -- En PS/2 se utiliza paridad impar.
    parity_result <= arriving_bits(1) xor
                     arriving_bits(2) xor
                     arriving_bits(3) xor
                     arriving_bits(4) xor
                     arriving_bits(5) xor
                     arriving_bits(6) xor
                     arriving_bits(7) xor
                     arriving_bits(8) xor
                     arriving_bits(9);

    -- Una paridad impar correcta produce un resultado igual a '1'.
    parity_error <= not parity_result;
    --si parity_error = 1 entonces hubo un error

end Behavioral;