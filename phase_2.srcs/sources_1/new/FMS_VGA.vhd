library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FMS_VGA is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw1, sw2, sw3 : in STD_LOGIC;
           colour_scheme: out std_logic_vector(2 downto 0));
end FMS_VGA;

architecture Behavioral of FMS_VGA is
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
        CONSTANT S9: std_logic_vector(3 downto 0) := "1001";
        CONSTANT S10: std_logic_vector(3 downto 0) := "1010";
        CONSTANT S11: std_logic_vector(3 downto 0) := "1011";
        CONSTANT S12: std_logic_vector(3 downto 0) := "1100";
        CONSTANT S13: std_logic_vector(3 downto 0) := "1101";
        CONSTANT S14: std_logic_vector(3 downto 0) := "1110";
        CONSTANT S15: std_logic_vector(3 downto 0) := "1111";

begin
--state register
state_register: process (clk, reset, sw1, sw2, sw3)
begin
    if reset = '1' then
        C_S <= S0;
    elsif (rising_edge(clk)) then
        C_S <= N_S;
    end if;
end process state_register;

state_change: process (C_S, sw1, sw2, sw3)
begin

-- Default: remain in current state
    N_S <= C_S;
    
    case C_S is
    ------------------------------------------------------- 
    -- INITIAL STATE
        when S0 =>
            if (sw1 = '1') then
                N_S <= S1;
            elsif ((sw2 = '1') and (sw1 = '0')) then
                N_S <= S2;
            elsif ((sw3 = '1') and (sw1 = '0') and (sw2 = '0')) then
                N_S <= S3;
            else 
                N_S <= s0;
            end if;
            
        -------------------------------------------------------- 
        -- FIRST SWITCH = SW1
        --for S1 path
        when S1 =>
            if (sw2 = '1') then
                N_S <= S4;
                if (sw3 = '1') then
                    N_S <= S5;
                elsif ((sw3 = '0') and (sw1 = '0') and (sw2 = '0')) then
                    N_S <= S0; 
                end if;
            
            elsif ((sw2 = '0') and (sw3 = '1')) then
                N_S <= S6;
                if (sw3 = '1') then
                    N_S <= S7;
                elsif ((sw3 = '0') and (sw1 = '0') and (sw2 = '0')) then
                    N_S <= S0; 
                end if;
                
            else --DEFAULT
                N_S <= S1;
            end if;
           
--------------------------------------------------------
-- second SWITCH = SW2
        when S2 =>
           if (sw1 = '1') then
                N_S <= S8;
            
           elsif ((sw1 = '0') and (sw3 = '1')) then
                N_S <= S10;
                
            else
                N_S <= S2;
            end if;
            
-------------------------------------------------------- 
-- THIRD SWITCH = SW3        
         when S3 =>
            if (sw1 = '1') then
                N_S <= S12;
                if (sw3 = '1') then
                    N_S <= S13;
                elsif ((sw3 = '0') and (sw1 = '0') and (sw2 = '0')) then
                    N_S <= S0; 
                end if;
            
            elsif ((sw1 = '0') and (sw2 = '1')) then
                N_S <= S14;
                if (sw1 = '1') then
                    N_S <= S15;
                elsif ((sw3 = '0') and (sw1 = '0') and (sw2 = '0')) then
                    N_S <= S0; 
                end if;
 
            else --DEFAULT
                N_S <= S3;
            end if;
         
         --------------------------------------------------------
         -- SW1 -> SW2
         when S4 => 
            if sw3 = '1' then 
                N_S <= S5;
            elsif (sw1 = '0' and sw2 = '0' and sw3 = '0') then
                    N_S <= S0;
             else
                N_S <= S4;
                
             end if; 
             -------------------------------------------------------
             -- SW1 -> SW2 -> SW3 -- COLOUR SCHEME 1
             when S5 =>
                if (sw1 = '0' and sw2 = '0' and sw3 = '0') then 
                    N_S <= S0;
                else
                   N_S <= S5;
                end if; 
      --------------------------------------------------------
      -- SW1 -> SW3
      when S6 =>
        if sw2 = '1' then
            N_S <= S7;
        elsif (sw1 = '0' and sw2 = '0' and sw3 = '0') then
                    N_S <= S0; 
        else N_S <= S6;
        end if; 
    -------------------------------------------------------- 
    -- SW1 -> SW3 -> SW2 -- COLOUR SCHEME 2
    when S7 => 
        if (sw1 = '0' and sw2 = '0' and sw3 = '0')then
            N_S <= S0;
        else
            N_S <= S7;
    end if; 
    --------------------------------------------------------
    -- SW2 -> SW1
    when S8 =>
         if sw3 = '1' then
             N_S <= S9;
         elsif (sw1 = '0' and sw2 = '0' and sw3 = '0')then
            N_S <= S0;
         else N_S <= S8; end if;
      -------------------------------------------------------
      -- SW2 -> SW1 -> SW3 -- COLOUR SCHEME 3
      when S9 =>
        if (sw1 = '0' and sw2 = '0' and sw3 = '0') then
                 N_S <= S0;
         else
            N_S <= S9;
         end if;
      --------------------------------------------------------
      -- SW2 -> SW3
      when S10 => 
        if sw1 = '1' then
            N_S <= S11;
        elsif (sw1 = '0' and sw2 = '0' and sw3 = '0')
            then N_S <= S0;
        else N_S <= S10;
        end if; 
        --------------------------------------------------
        -- SW2 -> SW3 -> SW1 -- COLOUR SCHEME 4
       when S11 =>
        if (sw1 = '0' and sw2 = '0' and sw3 = '0') then
            N_S <= S0;
       else N_S <= S11;
       end if; 
       --------------------------------------------------------
       -- SW3 -> SW1
       when S12 =>
        if sw2 = '1' then
            N_S <= S13;
        elsif (sw1 = '0' and sw2 = '0' and sw3 = '0') then
            N_S <= S0;
        else
            N_S <= S12; end if; 
        --------------------------------------------------------
        -- SW3 -> SW1 -> SW2 -- COLOUR SCHEME 5
        when S13 => 
        if (sw1 = '0' and sw2 = '0' and sw3 = '0') then
            N_S <= S0;
        else N_S <= S13; 
        end if;
        --------------------------------------------------------
        -- SW3 -> SW2
        when S14 =>
            if sw1 = '1' then
                N_S <= S15;
            elsif (sw1 = '0' and sw2 = '0' and sw3 = '0') then 
                N_S <= S0; 
                
                else N_S <= S14; end if;
          --------------------------------------------------------
          -- SW3 -> SW2 -> SW1 -- COLOUR SCHEME 6
          when S15 =>
            if (sw1 = '0' and sw2 = '0' and sw3 = '0') then
                N_S <= S0;
            else N_S <= S15; end if; 
            
          --------------------------------------------------------
        when others => N_S <= S0;
--            elsif ((sw3 = '0') and (sw1 = '0') and (sw2 = '0')) then
--                    N_S <= S0;
    end case;               
end process state_change;

-- Combinational that generates the outputs
-- based on the current state
outputs: process (C_S)
begin
    case C_s is
        when S5 => colour_scheme <= "001";
        when S7 => colour_scheme <= "010";
        when S9 => colour_scheme <= "011";
        when S11 => colour_scheme <= "100";
        when S13 => colour_scheme <= "101";
        when S15 => colour_scheme <= "110";

        when others => colour_scheme <= "000";

    end case;
   end process outputs;
end Behavioral;
