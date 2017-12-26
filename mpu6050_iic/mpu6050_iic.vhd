library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity mpu6050_iic is
    Port (     
        i_enable : in std_logic;
        i_clk    : in STD_LOGIC;
        i_reset  : in std_logic;
        o_scl    : inout STD_LOGIC;
        o_sda    : inout STD_LOGIC;
        o_data   : out std_logic_vector(7 downto 0));
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
    signal r_sda            : std_logic                     := '0';
    signal r_waiter         : integer range 0 to 59         := 0;
    signal r_wait_done      : std_logic                     := '0';
    signal r_iic_addr       : std_logic_vector(6 downto 0)  := "1101000";
    signal r_bit_counter    : integer range 1 to 9          := 1;
    signal r_iic_addr_bit   : integer range 0 to 6          := 6;
    signal r_iic_data_bit   : integer range 0 to 7          := 7;
    signal r_addr_written   : std_logic                     := '0';
    signal r_stop           : std_logic                     := '0'; --for wait state to transtion to stop sda        
    signal r_temp_h_addr    : std_logic_vector(5 downto 0)  := "101001";
    signal r_temp_l_addr    : std_logic_vector(5 downto 0)  := "101010";
    signal r_data_1         : std_logic_vector(7 downto 0);
    signal r_data_2         : std_logic_vector(7 downto 0);

begin   

    o_sda <= r_sda;
    o_scl <= r_scl;

    iic_state_machine : process(i_clk)
    begin
        if rising_edge(i_clk) then  
            if i_reset = '1' then  
                current_state <= idle;
            else 
                case(current_state) is 
                    when idle => --wait for i_enable to go high
                        if(i_enable = '1') then
                            current_state <= start_sda;
                        end if;
                    when start_sda =>
                        r_sda <= '0';
                        r_scl <= '1';
                        current_state <= waiting;
                    when waiting =>
                        if(r_wait_done = '1') then
                            r_wait_done <= '0';
                            if(r_stop = '1') then
                                r_stop <= '1';
                                current_state <= stop_sda;
                            else
                                current_state <= start_scl;
                            end if;
                        else
                            current_state <= waiting;
                        end if;
                    when start_scl =>
                        r_scl <= '0';
                        if(r_addr_written = '1') then
                            r_addr_written <= '0';
                            current_state <= addr_read;
                        else
                            current_state <=  addr_write;
                        end if;
                    when addr_write =>
                        if(rising_edge(r_scl)) then
                            if r_bit_counter < 8 then  
                                r_sda <= r_iic_addr(r_iic_addr_bit);
                                r_iic_addr <=  r_iic_addr - 1;
                                r_bit_counter <= r_bit_counter + 1;
                            elsif r_bit_counter = 8 then 
                                r_sda <= '0'; --write bit
                                r_bit_counter <= r_bit_counter + 1;
                            else
                                if r_sda = '0' then --ack from slave to master
                                    r_bit_counter <= 1;
                                    r_iic_addr_bit <= 6; 
                                    current_state <= reg_write;
                                end if ;
                            end if ;
                        end if;
                    when reg_write =>
                        if(rising_edge(r_scl)) then
                            if r_bit_counter < 7 then  
                                r_sda <= r_temp_h_addr(r_iic_addr_bit);
                                r_iic_addr <=  r_iic_addr - 1;
                                r_bit_counter <= r_bit_counter + 1;
                            else
                                if r_sda = '0' then --ack from slave to master
                                    r_bit_counter <= 1;
                                    r_iic_addr_bit <= 6; 
                                    r_addr_written <= '1'; -- for second start condition required for burst read
                                    current_state <= start_sda;
                                end if ;
                            end if ;
                        end if;
                    when addr_read =>
                        if(rising_edge(r_scl)) then
                            if r_bit_counter < 8 then  
                                r_sda <= r_iic_addr(r_iic_addr_bit);
                                r_iic_addr <=  r_iic_addr - 1;
                                r_bit_counter <= r_bit_counter + 1;
                            elsif r_bit_counter = 8 then 
                                r_sda <= '1'; --read bit
                                r_bit_counter <= r_bit_counter + 1;
                            else
                                if r_sda = '0' then --ack from slave to master
                                    r_bit_counter <= 1;
                                    r_iic_addr_bit <= 6; 
                                    current_state <= data_1;
                                end if ;
                            end if ;
                        end if;

                    when data_1 =>
                        if(rising_edge(r_scl)) then
                            if r_bit_counter < 9 then  
                                r_data_1(r_iic_data_bit) <= r_sda;
                                r_iic_data_bit <= r_iic_data_bit - 1;
                                r_bit_counter <= r_bit_counter + 1;
                            else
                                r_sda <= '0'; -- ack from master to slave
                                r_bit_counter <= 0;
                                o_data <= r_data_1; --output data 1
                                current_state <= data_2;
                            end if ;
                        end if;
                    when data_2 =>
                        if(rising_edge(r_scl)) then
                            if r_bit_counter < 9 then  
                                r_data_2(r_iic_data_bit) <= r_sda;
                                r_iic_data_bit <= r_iic_data_bit - 1;
                                r_bit_counter <= r_bit_counter + 1;
                            else
                                r_sda <= '0'; -- ack from master to slave
                                r_bit_counter <= 0;
                                o_data <= r_data_2; --output data 2
                                current_state <= send_nack;
                            end if ;
                        end if;
                    when send_nack =>
                       if(rising_edge(r_scl)) then
                            r_sda <= '1';
                            current_state <= stop_scl;
                        end if;
                    when stop_scl =>
                        r_scl <= '1';
                        r_stop <= '1';
                        current_state <= waiting;
                    when stop_sda =>
                        r_sda <= '1';
                        current_state <= idle;
                    when others => 
                        current_state <= idle;
                    end case;
            end if ;
        end if ;
    end process;
    
    clk_div : process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            if(current_state = addr_write or current_state = reg_write or current_state = addr_read or current_state = data_1 or current_state = data_2 or current_state = send_nack) then
                if(r_counter = 124) then
                    r_scl <= not r_scl;
                    r_counter <= 0;
                else
                    r_counter <= r_counter+1;
                end if;
            else
                r_counter <= 0;
            end if;
        end if;
    end process; 
    
    waiting_state : process(i_clk)
    begin
        if(rising_edge(i_clk) then
            if(current_state = waiting) then
                if(r_waiter = 59) then
                    r_wait_done <= '1';
                    r_waiter <= 0;
                else 
                    r_waiter <= r_waiter + 1;
            end if;
        end if;
    end process;

end Behavioral;
