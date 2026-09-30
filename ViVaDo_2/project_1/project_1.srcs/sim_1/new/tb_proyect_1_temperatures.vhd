----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.09.2025 12:02:59
-- Design Name: 
-- Module Name: tb_proyect_1_temperatures - Behavioral
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

entity tb_proyect_1_temperatures is
end tb_proyect_1_temperatures;

--ARCHITECTURE
architecture Behavioral of tb_proyect_1_temperatures is

component practice_1_temperatures is
  Port (T3: in std_logic; 
        T2: in std_logic; 
        T1: in std_logic;
        f: out std_logic );
end component;

--señales auxiliares pa la simulación
--INPUTS
signal T3_s: std_logic ;
signal T2_s: std_logic ;
signal T1_s: std_logic ;
--OUTPUT
signal f_s: std_logic;

begin
--instantiation
UUT: practice_1_temperatures port map(T3 => t3_s, T2 => t2_s, T1 => t1_s, f => f_s);
 
 --para hacerlo secuencial
 process
 begin
 T3_s <= '0';
 T2_s <= '0';
 T1_s <= '0';

 wait for 10ns;
 
 T3_s <= '0';
 T2_s <= '0';
 T1_s <= '1';
 wait; 
 
 end process;

end;
