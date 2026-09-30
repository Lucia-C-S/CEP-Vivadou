library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stepper_motor_sss is
    Port ( reset, clk, run, direction : in STD_LOGIC;
           A, B, C, D : out STD_LOGIC;
           state: out std_logic_vector(3 downto 0));
end stepper_motor_sss;

architecture Behavioral of stepper_motor_sss is
    -- Type declaration
        --TYPE state IS (S0,S1,S2,S3, S4, S5, S6, S7, S8);
    -- State signals declaration
        --signal C_S, N_S : state;
        --OR explicictly declare the state encoding
        --state signals declaration
        signal C_S, N_S: std_logic_vector(3 downto 0);
        --constants declaration to define the names and encoding
        CONSTANT S0: std_logic_vector(3 downto 0) := "0000";
        CONSTANT S1: std_logic_vector(3 downto 0) := "0001";
        CONSTANT S2: std_logic_vector(3 downto 0) := "0010";
        CONSTANT S3: std_logic_vector(3 downto 0) := "0011";
        CONSTANT S4: std_logic_vector(3 downto 0) := "0100";
        CONSTANT S5: std_logic_vector(3 downto 0) := "0101";
        CONSTANT S6: std_logic_vector(3 downto 0) := "0110";
        CONSTANT S7: std_logic_vector(3 downto 0) := "0111";
        CONSTANT S8: std_logic_vector(3 downto 0) := "1000";

begin
--state register
state_register: process (clk, reset, run, direction)
begin
    if reset = '1' then
        C_S <= S0;
    elsif (rising_edge(clk)) then
        C_S <= N_S;
    end if;
    state <= C_S;
end process state_register;

state_change: process (C_S, run, direction)
begin
    case C_S is
        when S0 =>
            if ((run = '1') and (direction = '0')) then
                N_S <= S1;
            else 
                N_S <= S5;
            end if;
            
        --for S1 path
        when S1 =>
            N_S <= S2;
        when S2 =>
            N_S <= S3;
        when S3 =>
            N_S <= S4;
        when S4 =>
            if run = '1' then N_S <= S1;
            else N_S <= S0;
            end if;
         --for S5 path
        when S5 =>
            N_S <= S6;
        when S6 =>
            N_S <= S7;
        when S7 =>
            N_S <= S8;
        when S8 =>
            if run = '1' then N_S <= S5;
            else N_S <= S0;
            end if;
         
        when others => N_S <= S0;
    end case;               
end process state_change;

-- Combinational that generates the outputs
-- based on the current state
outputs: process (C_S)
begin
    case C_S is
        when S0 => A <= '0'; B <= '0'; C <= '0'; D <= '0';
        when S1 => A <= '1'; B <= '0'; C <= '0'; D <= '0';
        when S2 => A <= '0'; B <= '0'; C <= '1'; D <= '0';
        when S3 => A <= '0'; B <= '1'; C <= '0'; D <= '0';
        when S4 => A <= '0'; B <= '0'; C <= '0'; D <= '1';
        when S5 => A <= '0'; B <= '0'; C <= '0'; D <= '1';
        when S6 => A <= '0'; B <= '1'; C <= '0'; D <= '0';
        when S7 => A <= '0'; B <= '0'; C <= '1'; D <= '0';
        when S8 => A <= '1'; B <= '0'; C <= '0'; D <= '0';
        when others => A <= '0'; B <= '0'; C <= '0'; D <= '0';
    end case;
   end process outputs;
end Behavioral;
