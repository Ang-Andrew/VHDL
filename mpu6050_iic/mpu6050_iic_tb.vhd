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
	        o_data   : out std_logic_vector(7 downto 0));
	end component mpu6050_iic;

	signal r_enable		: std_logic;
	signal r_clk 		: std_logic;
	signal r_reset		: std_logic;
	signal r_scl		: std_logic;
	signal r_sda		: std_logic;
	signal r_data		: std_logic;
	signal r_clk		: std_logic;
	signal r_data		: std_logic_vector(7 downto 0);


	begin

	uut : mpu6050_iic is
		port map(
			i_enable 	=> r_enable,
			i_clk		=> r_clk,
			i_reset		=> r_reset,
			o_scl		=> r_scl,
			o_sda		=> r_sda,
			o_data		=> r_data
		);

	r_clk <= not r_clk after 10 ns;

	p_test : process is
	begin

	end process;




end Behavioral;