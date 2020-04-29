library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is

  port(
  	clk_i      :  IN   STD_LOGIC;
  	srst_i     :  IN   STD_LOGIC; 
    
    echo	   :  IN STD_LOGIC;
    trig	   :  OUT STD_LOGIC;
    
    dig_o    : OUT unsigned(3 downto 0);
    seg_o    : OUT unsigned(6 downto 0);
    dp_o    : OUT STD_LOGIC
    );
    
end top;

architecture top of top is

	signal s_clk_en         :std_logic;

    signal s_data0			:unsigned(3 downto 0);
    signal s_data1			:unsigned(3 downto 0);
    signal s_data2			:unsigned(3 downto 0);
    signal s_data3			:unsigned(3 downto 0);
    
    signal s_data		:unsigned(8 downto 0);
  
	begin  
    
    clock_en : entity work.clock_enable
    generic map(
			g_NPERIOD => x"0028"
	)
    port map (
    	clk_i => clk_i,
        srst_n_i => srst_i,
        clock_enable_o => s_clk_en
    );
    
    sonar : entity work.sonar
    port map (
  		clk_i => clk_i,
		srst_i => srst_i,
        clk_en => s_clk_en,
        echo => echo,
		trig => trig,
		data => s_data
    );
    
    driver : entity work.driver
    port map (
		clk_i => clk_i,
        srst_i => srst_i,
        clk_en => s_clk_en,
        
		data_i => s_data,
        
        data0_o => s_data0,
        data1_o => s_data1,
        data2_o => s_data2,
        data3_o => s_data3
    );
    
    driver_7seg : entity work.driver_7seg
    port map (
		clk_i => clk_i,
        srst_n_i => srst_i,
        clk_en => s_clk_en,
        
        data0_i => s_data0, 
        data1_i => s_data1, 
        data2_i => s_data2, 
        data3_i => s_data3, 
        
        dp_i => "0000",

        dp_o => dp_o,
        seg_o => seg_o,
        dig_o => dig_o
    );
  
 end top;
