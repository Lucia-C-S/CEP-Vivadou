----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.09.2026 10:51:42
-- Design Name: 
-- Module Name: vertical_ctr - Behavioral
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


entity vertical_ctr is
    Port ( re_hsync : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           vctr : out STD_LOGIC_VECTOR (9 downto 0));
end vertical_ctr;

architecture Behavioral of vertical_ctr is
      signal s_vctr : unsigned(9 downto 0); 
begin
    process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            s_vctr <= (others => '0');
        elsif s_vctr = 524 then
            s_vctr <= (others => '0');
        else
            s_vctr <= s_vctr + 1;
        end if;
    end if;
    
    vctr <= std_logic_vector(s_vctr);
end process;