--********************************************************************************************************************--
--! @file
--! @brief File Description
--! Copyright&copy - YOUR COMPANY NAME
--********************************************************************************************************************--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! Entity/Package Description
entity uart_tx_hello_world is
    port (
        clock               : in std_logic;
        reset               : in std_logic;
        i_start             : in std_logic;
        o_done              : out std_logic;
        o_serial_out        : out std_logic;
        o_busy              : out std_logic
    );
end entity uart_tx_hello_world;

architecture Behavioral of uart_tx_hello_world is

    component uart_tx is
    generic(
        cycles_per_bit  : integer := 868
    );
    Port ( 
        clock               : in std_logic;
        reset               : in std_logic;
        i_data_in           : in std_logic_vector(7 downto 0);
        i_data_valid        : in std_logic;
        o_data_done         : out std_logic;
        o_serial_out        : out std_logic;
        o_busy              : out std_logic
    );
    end component;
    
    signal s_data_in       : std_logic_vector(7 downto 0);
    signal s_data_valid    : std_logic := '1';
    signal s_data_done     : std_logic;
    signal s_serial_out    : std_logic;
    signal s_busy          : std_logic;
    
    signal s_byte_counter         : integer range 0 to 14 := 0;
    
begin
    
    uart_tx_1 : component uart_tx
    port map(
        clock           => clock,
        reset           => reset,
        i_data_in       => s_data_in,
        i_data_valid    => s_data_valid,
        o_data_done     => s_data_done,
        o_serial_out    => s_serial_out,
        o_busy          => s_busy
    );
    
    --send hello world
    process(clock,reset)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                s_byte_counter <= 0;
                s_data_valid <= '0';
                o_done <= '0';
            else
                case s_byte_counter is
                    when 0 =>
                        if(i_start = '1') then
                            s_byte_counter <= 1;
                            o_done <= '0';
                        end if;
                    when 1 =>
                        s_data_in <= x"68";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 2 =>
                        s_data_in <= x"65";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 3 =>
                        s_data_in <= x"6c";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 4 =>
                        s_data_in <= x"6c";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 5 =>
                        s_data_in <= x"6f";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 6 =>
                        s_data_in <= x"20";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 7 =>
                        s_data_in <= x"77";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 8 =>
                        s_data_in <= x"6f";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 9 =>
                        s_data_in <= x"72";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 10 =>
                        s_data_in <= x"6c";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 11 =>
                        s_data_in <= x"64";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 12 =>
                        s_data_in <= x"0d";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 13 =>
                        s_data_in <= x"0a";
                        s_data_valid <= '1';
                        if(s_data_done = '1') then
                            s_byte_counter <= s_byte_counter + 1;
                        end if;
                    when 14 =>
                        o_done <= '1';
                        s_data_valid <= '0';
                        s_byte_counter <= 0;
                    when others =>
                        s_byte_counter <= 0;
                end case;
            end if;
        end if;
    end process;
    
    o_serial_out        <= s_serial_out;
    o_busy              <= s_busy;
    



end architecture Behavioral;