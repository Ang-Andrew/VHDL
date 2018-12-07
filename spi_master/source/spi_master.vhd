--********************************************************************************************************************--
--! @file
--! @brief File Description
--! Copyright&copy - YOUR COMPANY NAME
--********************************************************************************************************************--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! Entity/Package Description
entity spi_master is
    port (
        clock       : in std_logic;
        reset       : in std_logic;
        o_sclk      : out std_logic;
        o_mosi      : out std_logic;
        i_miso      : in std_logic;
        o_cs        : out std_logic    
    );
end entity spi_master;

architecture Behavioral of spi_master is
    
    signal s_sclk_counter          : integer range 0 to 31 := 0;
    signal s_sclk_reg              : std_logic := '1';
    
    
begin
    
    
    process(clock,reset)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                s_sclk_counter <= 0;
            else
                if(s_sclk_counter = 31) then
                    s_sclk_counter <= 0;
                else
                    s_sclk_counter <= s_sclk_counter + 1;
                end if;
            end if;
        end if;
    end process;
    
    s_sclk_reg <= not s_sclk_reg when s_sclk_counter = 31;
    o_sclk <= s_sclk_reg;
    

end architecture Behavioral;