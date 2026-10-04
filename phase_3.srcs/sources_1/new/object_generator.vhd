library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity objects_generator is
    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        hctr         : in  STD_LOGIC_VECTOR(9 downto 0);
        vctr         : in  STD_LOGIC_VECTOR(9 downto 0);
        re_vsyc, fe_vsync        : in  STD_LOGIC := '0';
        blank: in std_logic;
        object_1_hposition, object_1_vposition, object_2_hposition, object_2_vposition, object_3_hposition, object_3_vposition     : in  STD_LOGIC_VECTOR(9 downto 0);
        pixel_colour : out STD_LOGIC_VECTOR(11 downto 0)
    );
end objects_generator;

architecture Behavioral of objects_generator is

    component object_1
        Port ( clk : in std_logic;
           reset : in std_logic;
           hctr : in STD_LOGIC_VECTOR(9 downto 0);
           vctr : in STD_LOGIC_VECTOR(9 downto 0);
           
           object_1_hposition : in STD_LOGIC_VECTOR(9 downto 0);
           object_1_vposition : in STD_LOGIC_VECTOR(9 downto 0);
           
           object_1_colour : out std_logic_vector(11 downto 0) := "000000000011";  
           object_1_on : out std_logic); 
    end component;
    
    

    component object_2
        Port (
        hctr     : in  STD_LOGIC_VECTOR(9 downto 0);
        vctr     : in  STD_LOGIC_VECTOR(9 downto 0);

        object_2_hposition : in std_logic_vector(9 downto 0);
        object_2_vposition : in std_logic_vector(9 downto 0);

        object_2_on  : out STD_LOGIC;
        object_2_colour : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    component colour_multiplexer
        Port (
        clk             : in  STD_LOGIC;
        reset           : in  STD_LOGIC;

        blank           : in  STD_LOGIC;

        object_1_colour : in  STD_LOGIC_VECTOR(11 downto 0);
        object_1_on     : in  STD_LOGIC;

        object_2_colour : in  STD_LOGIC_VECTOR(11 downto 0);
        object_2_on     : in  STD_LOGIC;

        object_3_colour : in  STD_LOGIC_VECTOR(11 downto 0);
        object_3_on     : in  STD_LOGIC;

        pixel_colour    : out STD_LOGIC_VECTOR(11 downto 0)
    );
    end component;

    signal object_1_on  : STD_LOGIC;
    signal object_2_on  : STD_LOGIC;
    signal object_3_on  : STD_LOGIC;


    signal object_1_colour : STD_LOGIC_VECTOR(11 downto 0);
    signal object_2_colour : STD_LOGIC_VECTOR(11 downto 0);
    signal object_3_colour : STD_LOGIC_VECTOR(11 downto 0);

    signal video_on: std_logic ;

begin
    video_on <= not blank;
    
    object_1_inst: object_1
   port map (
      clk                            => clk,                          
      reset                          => reset,                        
      hctr(9 downto 0)               => hctr(9 downto 0),             
      object_1_hposition(9 downto 0) => object_1_hposition(9 downto 0),
      object_1_vposition(9 downto 0) => object_1_vposition(9 downto 0),
      vctr(9 downto 0)               => vctr(9 downto 0),             
      object_1_on                    => object_1_on,                  
      object_1_colour(11 downto 0)   => object_1_colour(11 downto 0) 
   );


    object_2_inst : object_2
        port map (
      hctr(9 downto 0)               => hctr(9 downto 0),             
      object_2_hposition(9 downto 0) => object_1_hposition(9 downto 0),
      object_2_vposition(9 downto 0) => object_1_vposition(9 downto 0),
      vctr(9 downto 0)               => vctr(9 downto 0),             
      object_2_on                    => object_1_on,                  
      object_2_colour(11 downto 0)   => object_1_colour(11 downto 0)
        );

    mux_inst : colour_multiplexer
        port map (
      clk                            => clk,                          
      reset                          => reset,                        
      blank                          => blank,             
      object_1_colour  => object_1_colour,
      object_1_on => object_1_on,
      object_2_colour  => object_1_colour,
      object_2_on => object_1_on,
      
      object_3_colour  => object_1_colour,
      object_3_on => object_1_on,
      pixel_colour => pixel_colour
   );

end Behavioral;