--********************************************************************************************************************--
--! @file
--! @brief File Description
--! Copyright&copy - YOUR COMPANY NAME
--********************************************************************************************************************--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


--! Entity/Package Description
entity tmds_encoder is
   port (
        clock           : in std_logic;
        i_data_in         : in std_logic_vector(7 downto 0);
        i_data_enable     : in std_logic;
        o_data_out        : out std_logic_vector(9 downto 0)
   );
end entity tmds_encoder;

architecture Behavioral of tmds_encoder is
    
    signal s_num_ones_din   : integer range 0 to 8 := 0;
    signal reg_data_in      : std_logic_vector(7 downto 0);
    signal s_q_m_xnor       : std_logic_vector(8 downto 0);
    signal s_q_m_xor        : std_logic_vector(8 downto 0);
    signal s_q_m_xnor_reg_1 : std_logic_vector(8 downto 0);
    signal s_q_m_xor_reg_1  : std_logic_vector(8 downto 0);
    signal s_q_m            : std_logic_vector(8 downto 0);
    signal s_disparity      : integer range -16 to 15 := 0;
   

begin
    
       ---------------------------------------------------------------------------------------------------
   --! clock data in if data_enable is high
   ---------------------------------------------------------------------------------------------------
   process(clock)
   begin
      if (rising_edge(clock) and i_data_enable = '1') then
        reg_data_in <= i_data_in;
      end if;
   end process;

    
   ---------------------------------------------------------------------------------------------------
   --! count the number of ones in data in
   ---------------------------------------------------------------------------------------------------
    count_ones_din : process(clock)
        variable temp : Integer range 0 to 8 := 0;
    begin
        if(rising_edge(clock)) then
            if i_data_enable = '1' then
                temp := 0;
                for i in 0 to 7 loop
                    if(reg_data_in(i) = '1') then
                        temp := temp + 1;
                    end if;
                end loop;
                s_num_ones_din <= temp;
            end if;
        end if;
    end process;
    
       ---------------------------------------------------------------------------------------------------
   --! XNOR
   ---------------------------------------------------------------------------------------------------
    
    s_q_m_xnor(0) <= reg_data_in(0);
    s_q_m_xnor(1) <= s_q_m_xnor(0) XNOR reg_data_in(1);
    s_q_m_xnor(2) <= s_q_m_xnor(1) XNOR reg_data_in(2);
    s_q_m_xnor(3) <= s_q_m_xnor(2) XNOR reg_data_in(3);
    s_q_m_xnor(4) <= s_q_m_xnor(3) XNOR reg_data_in(4);
    s_q_m_xnor(5) <= s_q_m_xnor(4) XNOR reg_data_in(5);
    s_q_m_xnor(6) <= s_q_m_xnor(5) XNOR reg_data_in(6);
    s_q_m_xnor(7) <= s_q_m_xnor(6) XNOR reg_data_in(7);
    s_q_m_xnor(8) <= '0';
    
   ---------------------------------------------------------------------------------------------------
   --! XOR
   ---------------------------------------------------------------------------------------------------
    
    s_q_m_xor(0) <= reg_data_in(0);
    s_q_m_xor(1) <= s_q_m_xor(0) XOR reg_data_in(1);
    s_q_m_xor(2) <= s_q_m_xor(1) XOR reg_data_in(2);
    s_q_m_xor(3) <= s_q_m_xor(2) XOR reg_data_in(3);
    s_q_m_xor(4) <= s_q_m_xor(3) XOR reg_data_in(4);
    s_q_m_xor(5) <= s_q_m_xor(4) XOR reg_data_in(5);
    s_q_m_xor(6) <= s_q_m_xor(5) XOR reg_data_in(6);
    s_q_m_xor(7) <= s_q_m_xor(6) XOR reg_data_in(7);
    s_q_m_xor(8) <= '0';
   
       ---------------------------------------------------------------------------------------------------
   --! minimising transitions based on number of ones counted in the input data
   ---------------------------------------------------------------------------------------------------
    minimise_transitions : process(clock)
    begin
        if (rising_edge(clock) and i_data_enable = '1') then
            if(s_num_ones_din > 4 or (s_num_ones_din = 4 and reg_data_in(0) = '0')) then
                s_q_m <= s_q_m_xor_reg_1;
            else    
                s_q_m <= s_q_m_xnor_reg_1;
            end if;
        end if;
    end process;
    
       ---------------------------------------------------------------------------------------------------
   --! determine output and compute disparity
   ---------------------------------------------------------------------------------------------------
   output_process : process(clock)
    begin
        if (rising_edge(clock)) then
            if(s_disparity = 0 or s_num_ones_din = 4) then
                if(s_q_m(8) = '1') then
                    o_data_out <= not s_q_m(8) & s_q_m(8) & not s_q_m(7 downto 0);
                    s_disparity <= s_disparity + (8 - s_num_ones_din);
                else
                    o_data_out <= not s_q_m(8) & s_q_m(8) & s_q_m(7 downto 0);
                    s_disparity <= s_disparity + (8 - s_num_ones_din);                    
                end if;
            else
                if((s_disparity > 0 and s_num_ones_din > 4) or (s_disparity < 0 and s_num_ones_din < 4)) then
                    o_data_out <= '1' & s_q_m(8) & not s_q_m(7 downto 0);
                    if(s_q_m(8) = '0') then
                        s_disparity <= s_disparity - (8 - s_num_ones_din);
                    else
                        s_disparity <= s_disparity - (8 - s_num_ones_din) + 2;
                    end if;
                else
                    o_data_out <= '0' & s_q_m(8) & s_q_m(7 downto 0);
                    if(s_q_m(8) = '0') then
                        s_disparity <= s_disparity - (8 - s_num_ones_din) - 2;
                    else
                        s_disparity <= s_disparity + (8 - s_num_ones_din);
                    end if;
                end if;
            end if;
        end if;
    end process;

    
       ---------------------------------------------------------------------------------------------------
   --! pipeline process
   ---------------------------------------------------------------------------------------------------
    pipeline : process(clock)
    begin
        if (rising_edge(clock)) then
            if(i_data_enable = '1') then
                s_q_m_xnor_reg_1 <= s_q_m_xnor;
                s_q_m_xor_reg_1 <= s_q_m_xor;
            end if;
        end if;
    end process;



    

end Behavioral;