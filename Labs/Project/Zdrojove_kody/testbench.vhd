library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture tb of testbench is
	component top is
    port(
    	clk_i      :  IN   STD_LOGIC;
        srst_i     :  IN   STD_LOGIC; 

        echo	   :  IN STD_LOGIC;
        trig	   :  OUT STD_LOGIC;

        dig_o    : OUT unsigned(3 downto 0);
        seg_o    : OUT unsigned(6 downto 0);
        dp_o    : OUT STD_LOGIC
    );
    end component;
    
    --Inputs
    signal s_clk_i : std_logic :='0';
    signal s_srst_i :std_logic :='1';
    
    signal s_echo :std_logic :='0';
    signal s_trig :std_logic;
    
    --Outputs
    signal s_dig_o : unsigned(3 downto 0);
    signal s_seg_o : unsigned(6 downto 0);
    signal s_dp_o  : std_logic;
    
    begin    
    uut: top port map(
    	clk_i => s_clk_i,
        srst_i => s_srst_i,
        
        trig => s_trig,
        echo => s_echo,
        
        dig_o => s_dig_o,
    	seg_o => s_seg_o,
    	dp_o => s_dp_o
    );
    
   	Clk_gen: process	
  	begin
    	while Now < 6 uS loop
      		s_clk_i <= '0';
      		wait for 0.5 NS;
      		s_clk_i <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;

    -- Stimulus process
    stim_proc: process
    begin	
   		wait until rising_edge(s_clk_i);	
        s_srst_i <= '0';
        wait for 50 NS;
    	s_srst_i <= '1';

       wait until falling_edge(s_trig);	
             s_echo <= '1';
             wait for 100 NS;
             s_echo <= '0';
             
        wait until falling_edge(s_trig);	
             s_echo <= '1';
             wait for 247 NS;
             s_echo <= '0';
       wait;
    
    end process;        
end tb;
