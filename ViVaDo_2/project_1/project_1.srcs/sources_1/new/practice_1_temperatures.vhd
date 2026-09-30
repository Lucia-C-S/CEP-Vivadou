----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.09.2025 11:33:18
-- Design Name: 
-- Module Name: practice_1_temperatures - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity practice_1_temperatures is
  Port (T3: in std_logic; 
        T2: in std_logic; 
        T1: in std_logic;
        f: out std_logic );
end practice_1_temperatures;

architecture Behavioral of practice_1_temperatures is

signal t3_out: std_logic ;
signal t12_out: std_logic ;

begin
t3_out<= not T3;
t12_out<= not (T1 xor T2); 

f<= t3_out nand t12_out;

end Behavioral;
