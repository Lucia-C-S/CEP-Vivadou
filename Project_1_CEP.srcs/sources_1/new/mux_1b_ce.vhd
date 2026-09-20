library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_1bit_ce is
    Port (
        sel      : in  std_logic;
        ce_50Hz  : in  std_logic;
        ce_25MHz : in  std_logic;
        ce_vga   : out std_logic
    );
end mux_1bit_ce;

architecture Behavioral of mux_1bit_ce is
begin

    ce_vga <= ce_50Hz when sel = '0' else ce_25MHz;

end Behavioral;