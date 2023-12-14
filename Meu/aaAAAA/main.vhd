library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cronometro is
port(
	clk: in std_logic; -- clock de 50Mhz
    enable: in std_logic; -- comeca a contagem do tempo
    min_sec: in std_logic; -- 0: seleciona em segundos, 1: seleciona em minutos
    timer_in: in std_logic_vector(5 downto 0); -- bits para selecao do tempo

    -- lcd
    LCD_EN: out std_logic; -- enable
    LCD_RW: out std_logic; -- read/write
    LCD_RS: out std_logic; -- command/data select
    LCD_DB: out std_logic_vector(7 downto 0); -- data BUS

    done: out std_logic_vector(9 downto 0) := "0000000000"
);
end cronometro;

architecture aaa of cronometro is

    component LCD is
    port(
        clk: in std_logic;
    
        hour: in std_logic_vector(5 downto 0);
        min : in std_logic_vector(5 downto 0);
        sec : in std_logic_vector(5 downto 0);
        
        LCD_EN: out std_logic;
        LCD_RW: out std_logic;
        LCD_RS: out std_Logic;
        LCD_DB: out std_logic_vector(7 downto 0)
    );
    end component;

	signal clk_1hz: std_logic; -- clock de 1hz
    signal h, m, s: integer range 0 to 63 := 0;
    signal hour, min, sec: std_logic_vector(5 downto 0);
    
begin

	--clock de 1hz
	process(clk) is
     	variable cnt: integer := 1;
    begin
     	if rising_edge(clk) then
         	cnt := cnt + 1;
             if cnt < 50000000 then
             	clk_1hz <= '0';
             elsif cnt >= 50000000 and cnt < 100000000 then
             	clk_1hz <= '1';
             else
             	cnt := 1;
             end if;
          end if;
     end process;

		  
     process(clk_1hz, enable) is
     begin
        
        	if enable = '0' then
            	if min_sec = '0' then -- segundos
                	h <= 0;
                    m <= to_integer(unsigned(timer_in)) / 60;
                    s <= to_integer(unsigned(timer_in)) - (m * 60);
                else -- minutos
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
     
    done <= "1111111111" when (s = 0 and m = 0 and h = 0) else "0000000000";

    hour <= std_logic_vector(to_unsigned(h, hour'length));
    min  <= std_logic_vector(to_unsigned(m, min'length));
    sec  <= std_logic_vector(to_unsigned(s, sec'length));

    LCDDUT: LCD port map(clk, hour, min, sec, LCD_EN, LCD_RW, LCD_RS, LCD_DB);
end aaa;
