----------------------------------------------------------------------------------
-- Engineer: Andrew Ang
-- Create Date: 13.10.2018 21:15:16
-- Design Name: vga_controller_tb
-- Module Name: vga_controller_tb - Behavioral
-- Project Name: VGA controller
-- Tool Versions: Vivado 2018.2
-- Description: Testbench for VGA controller
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_controller_tb is
end vga_controller_tb;

architecture Behavioral of vga_controller_tb is
    
    component vga_controller is
        Port ( 
            clock           : in std_logic; --25MHz for 640*480 @ 60fps
            reset           : in std_logic;
            o_vsync         : out std_logic;
            o_hsync         : out std_logic;
            o_vga_enable    : out std_logic;
            o_pixel_x       : out std_logic_vector(9 downto 0);
            o_pixel_y       : out std_logic_vector(9 downto 0)
        );
    end component vga_controller;
    
    signal tb_clock     : std_logic;
    signal tb_reset     : std_logic := '0';
    signal tb_o_vsync   : std_logic;
    signal tb_o_hsync   : std_logic;
    signal tb_o_vga_enable : std_logic;
    signal tb_o_pixel_x : std_logic_vector(9 downto 0);
    signal tb_o_pixel_y : std_logic_vector(9 downto 0);
    
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
        o_vga_enable    => tb_o_vga_enable,
        o_pixel_x       => tb_o_pixel_x,
        o_pixel_y       => tb_o_pixel_y
    );


    
    
         

end Behavioral;
