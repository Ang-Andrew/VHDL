---------------------------------------------------------------------------------- 
-- Engineer: 
-- Create Date: 22.09.2018
-- Design Name: lfsr
-- Module Name: lfsr - Behavioral
-- Description: 
-- 32 bit LFSR with register taps taken from Xilinx XAPP052 page 5
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr is
    Port ( 
        clock               : in std_logic;
        reset               : in std_logic;
        i_enable            : in std_logic;
        i_seed		    : in std_logic_vector(31 downto 0);    
        i_seed_valid        : in std_logic;
        o_lfsr_data         : out std_logic_vector(31 downto 0);
        o_lfsr_valid        : out std_logic
    );
end lfsr;

architecture Behavioral of lfsr is
    
    signal s_lfsr   : std_logic_vector(31 downto 0);
    signal s_xnor   : std_logic;

begin
   
    process(clock,reset) is
    begin
        if(rising_edge(clock)) then
            if reset = '1' then
                s_lfsr <= (others => '0');
                o_lfsr_valid <= '0';
            elsif i_enable = '1' then
                if i_seed_valid = '1' then
                    s_lfsr <= i_seed;
                else
                    s_lfsr <= s_lfsr(31 downto 1) & s_xnor;
                    o_lfsr_data <= s_lfsr;
                    o_lfsr_valid <= '1';
                end if;
            end if;
        end if;
    end process;
    
    -- xnor calculation based on Xilinx's Linear feedback shift register taps XAPP052 page 5
    s_xnor <= s_lfsr(31) xnor s_lfsr(21) xnor s_lfsr(1) xnor s_lfsr(0);
    
end Behavioral;
