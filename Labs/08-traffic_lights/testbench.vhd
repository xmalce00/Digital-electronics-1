library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture tb of testbench is
	component traffic is
    port(
    	clk			:in std_logic;	--clock
        reset		:in std_logic;	--sync reset
        
        lights		:out std_logic_vector(5 downto 0)
    );
    end component;
    
    --Inputs
    signal s_clk : std_logic :='0';
    signal s_reset :std_logic :='0';
    
    --Outputs
    signal s_lights : std_logic_vector(5 downto 0);
    
    begin    
    uut: traffic port map(
    	clk => s_clk,
        reset => s_reset,
        
        lights => s_lights
    );
    
   	Clk_gen: process	
  	begin
    	while Now < 6 uS loop
      		s_clk <= '0';
      		wait for 0.5 NS;
      		s_clk <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;

    -- Stimulus process
    stim_proc: process
    begin
        s_reset <= '1';
        wait until rising_edge(s_clk);	
        wait until rising_edge(s_clk);	
        s_reset <= '0';
        wait until rising_edge(s_clk);	
        wait until rising_edge(s_clk);	
        wait until rising_edge(s_clk);	
        s_reset <= '1';
        wait;
    
    end process;        
end tb;