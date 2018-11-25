----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.09.2018 14:42:31
-- Design Name: 
-- Module Name: uart_rx_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx_tb is
end uart_tx_tb;

architecture Behavioral of uart_tx_tb is
    
    component uart_tx is
    port(
        clock               : in std_logic;
        reset               : in std_logic;
        i_data_in           : in std_logic_vector(7 downto 0);
        i_data_valid        : in std_logic;
        o_data_done         : out std_logic;
        o_serial_out        : out std_logic;
        o_busy              : out std_logic 
    );
    end component uart_tx;
    
    signal tb_clock             : std_logic;
    signal tb_reset             : std_logic;
    signal tb_serial_out        : std_logic;
    signal tb_data_in           : std_logic_vector(7 downto 0);
    signal tb_data_valid        : std_logic := '0';
    signal tb_data_done         : std_logic;
    signal tb_busy              : std_logic;
    
    
    constant clk_period : time := 10ns;

begin
    
    uut: uart_tx port map(
        clock           => tb_clock,
        reset           => tb_reset,
        i_data_in       => tb_data_in,
        i_data_valid    => tb_data_valid,
        o_data_done     => tb_data_done,
        o_serial_out    => tb_serial_out,
        o_busy          => tb_busy
    );
    
    clk_process :process
    begin
         tb_clock <= '1';
         wait for clk_period/2;
         tb_clock <= '0';
         wait for clk_period/2;
    end process;
    
    stim_proc: process
    begin
        --h
        wait for clk_period*2;
        tb_data_in <= x"68";
        tb_data_valid <= '1';
        --e
        wait until tb_busy = '0';
        tb_data_in <= x"65";
        --l
        wait until tb_busy = '0';
        tb_data_in <= x"6c";
        --l
        wait until tb_busy = '0';
        tb_data_in <= x"6c";
        --o
        wait until tb_busy = '0';
        tb_data_in <= x"6f";
        --[space]
        wait until tb_busy = '0';
        tb_data_in <= x"20";
        --w
        wait until tb_busy = '0';
        tb_data_in <= x"77";
        --o
        wait until tb_busy = '0';
        tb_data_in <= x"6f";
        --r
        wait until tb_busy = '0';
        tb_data_in <= x"72";
        --l
        wait until tb_busy = '0';
        tb_data_in <= x"6c";
        --d
        wait until tb_busy = '0';
        tb_data_in <= x"64";
        --\n
        wait until tb_busy = '0';
        tb_data_in <= x"0A";
        wait;
                
        
    end process;


end Behavioral;
