library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic is
	port (clk			:in STD_LOGIC;	--clock
          reset			:in STD_LOGIC;	--sync reset
     	  lights 		:out STD_LOGIC_VECTOR(5 downto 0) 
	);
end traffic;

architecture traffic of traffic is	    
	type state_type is (RG, RY, RRmid, GR, YR, RRend);
    -- RG -- first red, second green
    -- RY
    -- RRmid
    -- GR
    -- YR
    -- RRend
    signal state: state_type;
    signal count: unsigned(3 downto 0);
    constant SEC5: unsigned(3 downto 0) := "1111";
    constant SEC1: unsigned(3 downto 0) := "0011";
    
begin
    process (clk, reset)
    begin
		if reset = '1' then
        	state <= RG;
            count <= X"0";
            
        elsif rising_edge(clk) then
        	
            case state is
            	when RG => 
                	if count < SEC5 then
                    	state <= RG;
                        count <= count + x"1";
                    else 
                    	state <= RY;
                        count <= X"0";
                    end if;
                when RY => 
                	if count < SEC1 then
                    	state <= RY;
                        count <= count + "0001";
                    else 
                    	state <= RRmid;
                        count <= X"0";
                    end if;
                when RRmid => 
                	if count < SEC1 then
                    	state <= RRmid;
                        count <= count +"0001";
                    else 
                    	state <= GR;
                        count <= X"0";
                    end if;
               when GR => 
                	if count < SEC5 then
                    	state <= GR;
                        count <= count + "0001";
                    else 
                    	state <= YR;
                        count <= X"0";
                    end if;
               when YR => 
                	if count < SEC1 then
                    	state <= YR;
                        count <= count + X"1";
                    else 
                    	state <= RRend;
                        count <= X"0";
                    end if;
               when RRend => 
                	if count < SEC1 then
                    	state <= RRend;
                        count <= count + "0001";
                    else 
                    	state <= RG;
                        count <= X"0";
                    end if;
       			when others => state <= RG;
             end case;
         end if;
    end process;
    
    C2: process(state)
    	begin
   			case state is 
            	when RG => lights <= "100001";
                when RY => lights <= "100010";
                when RRmid => lights <= "100100";
                when GR => lights <= "001100";
                when YR => lights <= "010100";
                when RRend => lights <= "100100";
                when others => lights <= "100001";
            end case;
    end process;
    
end traffic;
