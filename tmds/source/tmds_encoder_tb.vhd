--********************************************************************************************************************--
--! @file
--! @brief File Description
--! Copyright&copy - YOUR COMPANY NAME
--********************************************************************************************************************--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! Local libraries
library work;

--! Entity/Package Description
entity tmds_encoder_tb is
end entity tmds_encoder_tb;

architecture Behavioral of tmds_encoder_tb is

    component tmds_encoder is
        port (
            clock             : in std_logic;
            i_data_in         : in std_logic_vector(7 downto 0);
            i_data_enable     : in std_logic;
            o_data_out        : out std_logic_vector(9 downto 0)
        );
    end component tmds_encoder;
    
    constant clk_period     : time      := 10 ns;
    signal tb_clock         : std_logic;
    signal tb_i_data_in     : std_logic_vector(7 downto 0);
    signal tb_i_data_enable : std_logic;
    signal tb_o_data_out    : std_logic_vector(9 downto 0);    
    

begin
    
    clk_process :process
    begin
        tb_clock <= '1';
        wait for clk_period/2;
        tb_clock <= '0';
        wait for clk_period/2;
    end process;
    
    uut:tmds_encoder port map(
        clock               => tb_clock,
        i_data_in           => tb_i_data_in,
        i_data_enable       => tb_i_data_enable,
        o_data_out          => tb_o_data_out
    );
    
    stim_proc: process
    begin
        wait for clk_period;
        tb_i_data_enable <= '1';
        tb_i_data_in <= "00000000";
        wait for clk_period;
        tb_i_data_in <= "11111111";
        wait for clk_period;
        tb_i_data_in <= "01010101";
        wait for clk_period;
        tb_i_data_in <= "10101010";
        wait for clk_period;
        tb_i_data_in <= "01010000";
        wait for clk_period;
        tb_i_data_in <= "10101111";
        wait;
    end process;

end Behavioral;