library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ball_movement is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        re_vsync  : in  STD_LOGIC;
        fe_vsync  : in  STD_LOGIC;

        hposition : out STD_LOGIC_VECTOR(9 downto 0);
        vposition : out STD_LOGIC_VECTOR(9 downto 0)
    );
end ball_movement;

architecture Structural of ball_movement is

    constant BALL_SIZE : integer := 16;
    constant DX        : integer := 4;
    constant DY        : integer := 3;

    constant MAX_H : integer := 640 - BALL_SIZE;
    constant MAX_V : integer := 480 - BALL_SIZE;

    signal hposition_next : STD_LOGIC_VECTOR(9 downto 0);
    signal vposition_next : STD_LOGIC_VECTOR(9 downto 0);

    signal hposition_aux : STD_LOGIC_VECTOR(9 downto 0);
    signal vposition_aux : STD_LOGIC_VECTOR(9 downto 0);

    signal hposition_reg : STD_LOGIC_VECTOR(9 downto 0);
    signal vposition_reg : STD_LOGIC_VECTOR(9 downto 0);

    signal dir_h : STD_LOGIC := '1';
    signal dir_v : STD_LOGIC := '1';

    signal next_dir_h : STD_LOGIC;
    signal next_dir_v : STD_LOGIC;

    signal next_h : integer range 0 to MAX_H;
    signal next_v : integer range 0 to MAX_V;

begin

    -------------------------------------------------------
    -- Calculate the next ball position
    -------------------------------------------------------
    process(hposition_reg, vposition_reg, dir_h, dir_v)
        variable x : integer;
        variable y : integer;
    begin
        x := to_integer(unsigned(hposition_reg));
        y := to_integer(unsigned(vposition_reg));

        -- Horizontal movement and bouncing
        if dir_h = '1' then
            if x + DX >= MAX_H then
                next_h <= MAX_H;
                next_dir_h <= '0';
            else
                next_h <= x + DX;
                next_dir_h <= '1';
            end if;
        else
            if x <= DX then
                next_h <= 0;
                next_dir_h <= '1';
            else
                next_h <= x - DX;
                next_dir_h <= '0';
            end if;
        end if;

        -- Vertical movement and bouncing
        if dir_v = '1' then
            if y + DY >= MAX_V then
                next_v <= MAX_V;
                next_dir_v <= '0';
            else
                next_v <= y + DY;
                next_dir_v <= '1';
            end if;
        else
            if y <= DY then
                next_v <= 0;
                next_dir_v <= '1';
            else
                next_v <= y - DY;
                next_dir_v <= '0';
            end if;
        end if;
    end process;

    -------------------------------------------------------
    -- Stage 1: auxiliary registers
    -- Capture the next position on rising VSYNC
    -------------------------------------------------------
    HPOSITION_AUX_REG_INST :
        entity work.register_10_bits_hposition_object_2_aux
        port map (
            clk   => clk,
            reset => reset,
            ce    => re_vsync,
            d     => hposition_next,
            q     => hposition_aux
        );

    VPOSITION_AUX_REG_INST :
        entity work.register_10_bits_vposition_object_2_aux
        port map (
            clk   => clk,
            reset => reset,
            ce    => re_vsync,
            d     => vposition_next,
            q     => vposition_aux
        );

    -------------------------------------------------------
    -- Stage 2: displayed-position registers
    -- Capture the auxiliary values on falling VSYNC
    -------------------------------------------------------
    HPOSITION_REG_INST :
        entity work.register_10_bits_hposition_object_2
        port map (
            clk   => clk,
            reset => reset,
            ce    => fe_vsync,
            d     => hposition_aux,
            q     => hposition_reg
        );

    VPOSITION_REG_INST :
        entity work.register_10_bits_vposition_object_2
        port map (
            clk   => clk,
            reset => reset,
            ce    => fe_vsync,
            d     => vposition_aux,
            q     => vposition_reg
        );

    -------------------------------------------------------
    -- Update movement direction at rising VSYNC
    -------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            dir_h <= '1';
            dir_v <= '1';
        elsif rising_edge(clk) then
            if re_vsync = '1' then
                dir_h <= next_dir_h;
                dir_v <= next_dir_v;
            end if;
        end if;
    end process;

    -------------------------------------------------------
    -- Convert calculated coordinates to 10-bit vectors
    -------------------------------------------------------
    hposition_next <= std_logic_vector(to_unsigned(next_h, 10));
    vposition_next <= std_logic_vector(to_unsigned(next_v, 10));

    -------------------------------------------------------
    -- Outputs: displayed position, not auxiliary position
    -------------------------------------------------------
    hposition <= hposition_reg;
    vposition <= vposition_reg;

end Structural;