library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity mpu6050_iic_tb is
end mpu6050_iic_tb;

architecture Behavioral of mpu6050_iic_tb is
	
	component mpu6050_iic is
		 Port (     
        	i_enable : in std_logic;
	        i_clk    : in STD_LOGIC;
	        i_reset  : in std_logic;
	        o_scl    : inout STD_LOGIC;
	        o_sda    : inout STD_LOGIC;
	        o_data   : out std_logic_vector(7 downto 0);
	        o_waiter : out std_logic_vector(7 downto 0));
	end component mpu6050_iic;

	signal r_enable		: std_logic := '0';
	signal r_clk 		: std_logic := '0';
	signal r_reset		: std_logic := '0';
	signal r_scl		: std_logic;
	signal r_sda		: std_logic;
	signal r_data		: std_logic_vector(7 downto 0);
	signal r_waiter 	: std_logic_vector(7 downto 0);

	constant clk_period : time	:= 10 ns;


	begin

	uut : mpu6050_iic
		port map(
			i_enable 	=> r_enable,
			i_clk		=> r_clk,
			i_reset		=> r_reset,
			o_scl		=> r_scl,
			o_sda		=> r_sda,
			o_data		=> r_data,
			o_waiter	=> r_waiter
		);

	r_clk <= not r_clk after clk_period/2;

	p_test : process is
		variable counter : unsigned (7 downto 0) := (others => '0');
	begin
		wait for clk_period * 20;

		r_enable <= '1';

		wait for clk_period * 60;


	end process;




end Behavioral;