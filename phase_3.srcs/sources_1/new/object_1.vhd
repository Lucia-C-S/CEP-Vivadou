library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity object_1 is
    Port ( clk : in std_logic;
           reset : in std_logic;
           hctr : in STD_LOGIC_VECTOR(9 downto 0);
           vctr : in STD_LOGIC_VECTOR(9 downto 0);
           
           object_1_hposition : in STD_LOGIC_VECTOR(9 downto 0);
           object_1_vposition : in STD_LOGIC_VECTOR(9 downto 0);
           
           object_1_colour : out std_logic_vector(11 downto 0) := "000000000011";  
           object_1_on : out std_logic); 
end object_1;

architecture Behavioral of object_1 is

constant OBJECT_WIDTH : natural := 10;
constant OBJECT_HEIGHT : natural := 25;
 
constant SCREEN_HEIGHT : natural := 480;
constant OBJECT_TOP : natural := SCREEN_HEIGHT - OBJECT_HEIGHT;
 
constant WALL_COLOUR : std_logic_vector(11 downto 0) := x"0F0"; --Color verde
 
begin

object_generation : process (hctr,vctr,object_1_hposition,reset)

variable pixel_x : unsigned(9 downto 0);
variable pixel_y : unsigned(9 downto 0);
variable wall_x : unsigned(9 downto 0);

begin

pixel_x := unsigned(hctr);
pixel_y := unsigned(vctr);
wall_x := unsigned(object_1_hposition);
 
object_1_on <= '0';
object_1_colour <= (others => '0');
 
if reset = '0' then
    if (pixel_x >= wall_x) and
        ((pixel_x - wall_x) < to_unsigned(OBJECT_WIDTH, 10)) and
        (pixel_y >= to_unsigned(OBJECT_TOP, 10)) and
        (pixel_y < to_unsigned(SCREEN_HEIGHT, 10)) then
 
        object_1_on <= '1';
        object_1_colour <= WALL_COLOUR;
    end if;
end if;

end process object_generation;

end Behavioral;