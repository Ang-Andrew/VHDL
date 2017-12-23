library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity freq_divider is
    Port ( clk          :   in STD_LOGIC;
           clk_out      :   out STD_LOGIC;
           count_out    :   out std_logic_vector(4 downto 0));
end freq_divider;

architecture Behavioral of freq_divider is

    signal counter : std_logic_vector(4 downto 0) := (others => '0');

begin
    
    clk_out <= not counter(4);
    count_out <= counter;
    clk_div : process(clk)
    begin
        if(rising_edge(clk)) then
            counter <= counter + 1;
        end if;
    end process;

end Behavioral;
