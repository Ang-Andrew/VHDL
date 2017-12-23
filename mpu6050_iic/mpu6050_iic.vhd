library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity mpu6050_iic is
    Port ( i_clk    : in STD_LOGIC;
           i_reset  : in std_logic;
           o_scl    : out STD_LOGIC;
           o_sda    : out STD_LOGIC);
end mpu6050_iic;

architecture Behavioral of mpu6050_iic is
    
    type states is (start_sda,
                    waiting,
                    start_scl,
                    addr_write,
                    reg_write,
                    addr_read,
                    data_1,
                    data_2,
                    send_nack,
                    stop_scl,
                    stop_sda,
                    idle);
    
    signal current_state    : states                        := idle;
    signal r_counter        : integer range 0 to 124        := 0;
    signal r_scl            : std_logic                     := '0';

begin
    
    clk_div : process(i_clk)
    begin
        if(rising_edge(i_clk) then
            if(current_state = addr_write or current_state = reg_write or current_state = addr_read or current_state = data_1 or current_state = data_2) then
                if(r_counter = 124) then
                    r_scl <= not r_scl;
                    r_counter <= 0;
                else
                    r_counter <= r_counter+1;
            else
                r_counter <= 0;
            end if;
        end if;
    end process clk_div; 
    

end Behavioral;
