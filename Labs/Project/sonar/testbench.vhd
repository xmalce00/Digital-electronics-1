library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture tb of testbench is
	component sonar is
    port(
    	clk_i      :  IN   STD_LOGIC;
      	srst_i     :  IN   STD_LOGIC;                     
      	trig       :  OUT   STD_LOGIC;                   
    	echo       :  IN  STD_LOGIC;
        data		: OUT unsigned(8 downto 0)
    );
    end component;
    
    --Inputs
    signal s_clk_i : std_logic :='0';
    signal s_srst_i :std_logic :='1';
    signal s_echo  :std_logic:='0';
    
    --Outputs
    signal s_trig :std_logic :='0';
    signal s_data : unsigned(8 downto 0);
    
    begin    
    uut: sonar port map(
    	clk_i => s_clk_i,
        srst_i => s_srst_i,
        echo => s_echo,
        
        trig => s_trig,
        
        data => s_data
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
 	
    while 1 = 1 loop
       wait until falling_edge(s_trig);	
             s_echo <= '1';
             wait for 100 NS;
             s_echo <= '0';
       wait until falling_edge(s_trig);	
             s_echo <= '1';
             wait for 200 NS;
             s_echo <= '0';
        wait until falling_edge(s_trig);	
             s_echo <= '1';
             wait for 460 NS;
             s_echo <= '0';
       end loop;
       wait;
    
    end process;        
end tb;
