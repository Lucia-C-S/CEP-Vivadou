----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.09.2026 10:50:01
-- Design Name: 
-- Module Name: horizontal_ctr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity horizontal_ctr is
    Port ( ce_25MHz : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           hctr : out std_logic_vector(9 downto 0)); 
end horizontal_ctr;

architecture Behavioral of horizontal_ctr is
    signal s_hctr : unsigned(9 downto 0) := (others => '0');
begin

    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then
                s_hctr <= (others => '0');

            elsif ce_25MHz = '1' then

                if s_hctr = 799 then
                    s_hctr <= (others => '0');
                else
                    s_hctr <= s_hctr + 1;
                end if;

            end if;

        end if;
    end process;

    hctr <= std_logic_vector(s_hctr);

end Behavioral;