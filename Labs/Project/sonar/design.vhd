library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sonar is

  port(
    clk_i      :  IN   STD_LOGIC;
    srst_i     :  IN   STD_LOGIC;                     
    trig       :  OUT   STD_LOGIC;                   
    echo       :  IN  STD_LOGIC;
    data 		: OUT unsigned(8 downto 0) := "000000000"
    );
    
end sonar;

architecture behavior of sonar is
	type state_type is (trigger, echolocation);
    signal state: state_type;
    
    signal count : unsigned (3 downto 0) := "0000";
    
    constant SEC10: unsigned(3 downto 0) := "1010";
    
  begin
  
    process(clk_i)
    
    variable echo_time : INTEGER := 0;
    
    begin
    if rising_edge(clk_i) then
    	if srst_i = '0' then
        	trig <= '0';
            data <= "000000000";
            echo_time := 0;
            state <= trigger;
        else 
            	case state is
                  when trigger =>
                      if count < SEC10 then
                          state <= trigger;
                          trig <= '1';
                          count <= count + "0001";
                      else 
                          state <= echolocation;
                          trig <= '0';
                          count <= x"0";
                      end if;
                  when echolocation =>
                      if(echo = '1') then 
                          state <= echolocation;
                          echo_time := echo_time + 1; 
                      else 
                      	  if(echo_time > 450) then
                          	data <= unsigned(to_unsigned(450,data'length));
                          else 
                          	data <= unsigned(to_unsigned(echo_time,data'length));
                          end if;
                          echo_time := 0;
                          state <= trigger;
                      end if;
                  when others => state <= trigger;
          		 end case;
           end if;
        end if; 
     end process;
  
 end behavior;
