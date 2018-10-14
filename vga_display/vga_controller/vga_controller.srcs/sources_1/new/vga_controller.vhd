----------------------------------------------------------------------------------
-- Engineer: Andrew Ang
-- Create Date: 13.10.2018 18:16:00
-- Design Name: VGA controller 
-- Module Name: vga_controller - Behavioral
-- Project Name: vga_countroller 
-- Tool Versions: Vivado 2018.2
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity vga_controller is
    Port ( 
        clock           : in std_logic; --25MHz for 640*480 @ 60fps
        reset           : in std_logic;
        o_vsync         : out std_logic;
        o_hsync         : out std_logic;
        o_vga_enable    : out std_logic;
        o_pixel_x       : out std_logic_vector(9 downto 0);
        o_pixel_y       : out std_logic_vector(9 downto 0)
    );
end vga_controller;

architecture Behavioral of vga_controller is
        
        signal s_v_counter     : unsigned(9 downto 0) := (others => '0');
        signal s_h_counter     : unsigned(9 downto 0) := (others => '0');
        signal s_h_done        : std_logic;
        signal s_v_done        : std_logic;
        signal s_frame_counter   : integer range 0 to 60 := 0;
        
begin
    
    -- horizontal counter
    process(clock,reset) is
    begin 
        if(rising_edge(clock)) then
            if(s_h_done = '1') then
                s_h_counter <= (others => '0');
            else
                s_h_counter <= s_h_counter + 1;
            end if;        
        end if;
    end process;
    
    -- vertical counter
    process(clock,s_v_done,s_h_done,s_v_counter) is
    begin
        if(rising_edge(clock) and s_h_done = '1') then
            if(s_v_done = '1') then 
                s_v_counter <= (others => '0');
            else 
                s_v_counter <= s_v_counter + 1;
            end if;
        end if;
    end process;
    
    -- synchronous reset
--    process(clock,reset) is
--    begin
--        if(rising_edge(clock)) then
--            if(reset = '1') then
--                s_v_counter <= (others => '0');
--                s_h_counter <= (others => '0');
--            end if;
--        end if;
--    end process;
    
    -- combinatorial logic
    
    s_v_done <= '1' when s_v_counter = 524 and s_h_counter = 799 else '0';
    s_h_done <= '1' when s_h_counter = 799 else '0';
    o_hsync <= '1' when (s_h_counter < 656 or s_h_counter > 750) else '0';
    o_vsync <= '1' when (s_v_counter < 490 or s_v_counter > 490) else '0';
    o_vga_enable <= '1' when (s_v_counter < 640 and s_h_counter < 480) else '0';
    o_pixel_x <= std_logic_vector(s_h_counter);
    o_pixel_y <= std_logic_vector(s_v_counter);
    
end Behavioral;
