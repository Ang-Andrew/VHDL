library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity freq_divider_tb is
end freq_divider_tb;

architecture Behavioral of freq_divider_tb is
    
    component freq_divider is
        port(
                clk_in          :   in  std_logic;
                clk_out         :   out std_logic;  
                counter_out     :   out std_logic_vector(4 downto 0)   
        );
    end component freq_divider;
    
    signal  r_clk_in        :   std_logic   :=  '0';
    signal  r_clk_out       :   std_logic;
    signal  r_counter_out   :   std_logic_vector(4 downto 0);
    
begin
    
    freq_divider_uut : freq_divider
        port map(
            clk_in      =>      r_clk_in,
            clk_out     =>      r_clk_out,
            counter_out =>      r_counter_out
        );
    
    
    
    r_clk_in <= not r_clk_in after 10 ns;
    


end Behavioral;
