library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dynamic_display_controller is
    Port ( vis0_D, vis1_D, vis2_D, vis3_D : in STD_LOGIC_VECTOR (3 downto 0); --entrada del mux
           clk, reset, dp0, dp1, dp2, dp3: std_logic;                           -- entrada del circuito logico
           dp: out std_logic;                          -- salida de punto decimal
           an: out std_logic_vector(3 downto 0);       -- salida de vector que maneja os leds de pantalla
           abcdefg : out STD_LOGIC_VECTOR (6 downto 0)); -- Salida del vector ABCDEFG
end dynamic_display_controller;

architecture Behavioral of dynamic_display_controller is
    component mux_4c_4b is
         Port (sel : in STD_LOGIC_VECTOR (1 downto 0);
               channel_0_mux, channel_1_mux, channel_2_mux, channel_3_mux : in STD_LOGIC_VECTOR (3 downto 0);
               mux_out : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component bin_to_7_seg_anode is
    Port ( EN : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (3 downto 0);
           dp_in : in STD_LOGIC;
           DISPLAY : out STD_LOGIC_VECTOR (6 downto 0);
           DP : out STD_LOGIC);
    end component;
    
    component two_to_4_decoder is
        Port ( d : in STD_LOGIC_VECTOR (1 downto 0);
                g : in std_logic;
                q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component ctr_2_bits is
    Port ( reset, load, ce, clk : in STD_LOGIC;
           d: in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (1 downto 0);
           ceo, tc: out std_logic);
    end component;
    
    component divider1000 is
    Port ( 
        clk  : in  std_logic;   -- input clock (e.g., 100 MHz)
        clkout : out std_logic;   -- divided output clock
        reset  : in  std_logic    -- asynchronous reset (active high)
    );
    end component;

signal s_dp_in, anode0, anode1, anode2, anode3, and0, and1, and2, and3, clkout: std_logic;
signal mux_vis: std_logic_vector (3 downto 0);
signal sel : STD_LOGIC_VECTOR (1 downto 0);     --entrada del mux y del decoder

begin

mux4ch: mux_4c_4b Port map(sel => sel, channel_0_mux => vis0_D, channel_1_mux => vis1_D,
                           channel_2_mux => vis2_D , channel_3_mux => vis3_D, mux_out => mux_vis);
                           
bin7seg: bin_to_7_seg_anode Port map (EN => '1', Din => mux_vis, dp_in => s_dp_in,
                                      DISPLAY=> abcdefg, DP => dp);

two4dec: two_to_4_decoder Port map (d(0) => sel(0), d(1) => sel(1), g => '1',
                                     q(0) => anode0, q(1) => anode1, q(2) => anode2, q(3) => anode3);

divider: divider1000 Port map (clk => clk, clkout => clkout, reset => reset);

ctr2bit: ctr_2_bits Port map (reset => reset, load => '0', ce => '1', clk => clkout,
                             d => "00", q => sel);
                                     
    and0<= not(anode0) and dp0;   
    and1<= not(anode1) and dp1;
    and2<= not(anode2) and dp2;
    and3<= not(anode3) and dp3;

s_dp_in <= and0 or and1 or and2 or and3;

an(0) <= anode0;
an(1) <= anode1;
an(2) <= anode2;
an(3) <= anode3;

end Behavioral;
