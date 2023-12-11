library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cronometro is
port(
	clk: in std_logic;
    enable: in std_logic;
    min_sec: in std_logic;
    timer_in: in std_logic_vector(5 downto 0);
    
    hour, min, sec: out std_logic_vector(5 downto 0);
    done: out std_logic := '0'
);
end cronometro;

architecture bhv of cronometro is

	signal clk_1hz: std_logic;
    signal h, m, s: integer range 0 to 63 := 0;
    
begin

	--1 hz clk def
	process(clk) is
--     	variable cnt: integer := 1;
    begin
    	clk_1hz <= clk;
--     	if rising_edge(clk) then
--         	cnt := cnt + 1;
--             -- 50MHz -> 50 * 10^6 = 50 000 000
--             -- 50 000 000 
--             if cnt < 25000000 then
--             	clk_1hz <= '0';
--             elsif cnt > 25000000 and cnt < 50000000 then
--             	clk_1hz <= '1';
--             else
--             	cnt := 1;
--             end if;
--          end if;
     end process;
     
     process(clk_1hz, enable) is
     begin
        
        	if enable = '0' then
            	if min_sec = '0' then -- sec
                	h <= 0;
                    m <= to_integer(unsigned(timer_in)) / 60;
                    s <= to_integer(unsigned(timer_in)) - (m * 60);
                else -- min
                	h <= to_integer(unsigned(timer_in)) / 60;
                    m <= to_integer(unsigned(timer_in)) - (h * 60);
                    s <= 0;
            	end if;
            elsif rising_edge(clk_1hz) then
            	if s /= 0 then
                	s <= s - 1;
                else
                	if m /= 0 then
                    	s <= 59;
                    	m <= m - 1;
                    else 
                    	if h /= 0 then
                        	m <= 59;
                            s <= 59;
                            h <= h - 1;
                        end if;
                    end if;
                end if;
                
            end if;
     
     end process;
     
     done <= '1' when (s = 0 and m = 0 and h = 0) else '0';
     
     hour <= std_logic_vector(to_unsigned(h, hour'length));
     min  <= std_logic_vector(to_unsigned(m, min'length));
     sec  <= std_logic_vector(to_unsigned(s, sec'length));
end bhv;
