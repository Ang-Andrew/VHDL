----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.10.2018 21:15:16
-- Design Name: 
-- Module Name: vga_controller_tb - Behavioral
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

entity vga_controller_tb is
end vga_controller_tb;

architecture Behavioral of vga_controller_tb is
    
    component vga_controller is
        Port ( 
            clock           : in std_logic; --25MHz for 640*480 @ 60fps
            reset           : in std_logic;
            o_vsync         : out std_logic;
            o_hsync         : out std_logic;
            o_vga_enable    : out std_logic
        );
    end component vga_controller;
    
    signal tb_clock     : std_logic;
    signal tb_reset     : std_logic;
    signal tb_o_vsync   : std_logic;
    signal tb_o_hsync   : std_logic;
    signal tb_o_vga_enable : std_logic;
    
    constant clk_period : time :=  40ns;  
    
    
begin

    
    clk_process : process
    begin
        tb_clock <= '0';
        wait for clk_period/2;
        tb_clock <= '1';
        wait for clk_period/2;
    end process;
    
    dut: vga_controller port map(
        clock           => tb_clock,
        reset           => tb_reset,
        o_vsync         => tb_o_vsync,
        o_hsync         => tb_o_hsync,
        o_vga_enable    => tb_o_vga_enable
    );


    
    
         

end Behavioral;
