----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2026 22:54:24
-- Design Name: 
-- Module Name: top_board_VGA_interface_phase_1 - Behavioral
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


entity top_board_VGA_interface_phase_1 is
    Port ( clk : in STD_LOGIC;
           CPU_RESETN : in STD_LOGIC;
           ctr_sel : in STD_LOGIC;
           ce_sel : in STD_LOGIC;
           pixel_colour : in STD_LOGIC_VECTOR (11 downto 0);
           ctr_state : out STD_LOGIC_VECTOR (9 downto 0);
           vsync_led : out STD_LOGIC;
           vsync_os : out STD_LOGIC;
           hsync_os : out STD_LOGIC;
           VGA_hsync : out STD_LOGIC;
           VGA_vsync : out STD_LOGIC;
           VGA_R : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_G : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_B : out STD_LOGIC_VECTOR (3 downto 0));
end top_board_VGA_interface_phase_1;

architecture Behavioral of top_board_VGA_interface_phase_1 is

begin


end Behavioral;
