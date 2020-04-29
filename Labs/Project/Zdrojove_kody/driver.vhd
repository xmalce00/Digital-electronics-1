library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity driver is

  port(
  	clk_i      :  IN   STD_LOGIC;
  	srst_i     :  IN   STD_LOGIC; 
    clk_en     :  IN   STD_LOGIC;
    
    data_i 		: IN unsigned(8 downto 0);
    
    data0_o    : OUT unsigned(3 downto 0);
    data1_o    : OUT unsigned(3 downto 0);
    data2_o    : OUT unsigned(3 downto 0);
    data3_o    : OUT unsigned(3 downto 0)
    );
    
end driver;

architecture behavior of driver is

    signal s_data_i : integer := 0;
    
    signal s_data0_o : integer := 0;
    signal s_data1_o : integer := 0;
    signal s_data2_o : integer := 0;
    signal s_data3_o : integer := 0;
    
    signal s0 : integer := 0;
    signal s1 : integer := 0;
    signal s2 : integer := 0;
    signal s3 : integer := 0;
    
  begin
  
    split: process(clk_i)
    
    begin
    
    if rising_edge(clk_i) then
    	s_data_i <= to_integer(data_i);
    	if srst_i = '0' then
            s_data_i <= 0;
            
            s_data0_o <= 0;
            s_data1_o <= 0;
            s_data2_o <= 0;
            s_data3_o <= 0;
        elsif clk_en = '1' then
        	s_data0_o <= s_data_i mod 10;
            s0 <= s_data_i/10;
            
            s_data1_o <= s0 mod 10;
            s1 <= s0/10;
            
            s_data2_o <= s1 mod 10;
            s2 <= s1/10;
            
            s_data3_o <= s2 mod 10;
        end if;
      end if; 
    end process;
    
    update: process(clk_i)
    	begin
    	if(rising_edge(clk_i)) then
          data0_o <= to_unsigned(s_data0_o,4);
          data1_o <= to_unsigned(s_data1_o,4);
          data2_o <= to_unsigned(s_data2_o,4);
          data3_o <= to_unsigned(s_data3_o,4);
        end if;
    end process;
  
 end behavior;