library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity register_bank_8bit is
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        load_data : in  std_logic;
        d_in      : in  std_logic_vector(7 downto 0);
        d_out     : out std_logic_vector(7 downto 0)
    );
end register_bank_8bit;

architecture Behavioral of register_bank_8bit is
    signal q : std_logic_vector(7 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                q <= (others => '0');
            elsif load_data = '1' then
                q <= d_in;
            end if;
        end if;
    end process;

    d_out <= q;
end Behavioral;
