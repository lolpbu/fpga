library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all ;
use ieee.std_logic_unsigned.all;

entity main is
port(
	a_in: in std_logic;
	b_in: in std_logic;
    
    clk_rnd_in: in std_logic_vector(1 downto 0)
	);
end main;

architecture bhv of main is

	signal pnt1, pnt2: std_logic_vector(3 downto 0) := "0000";

	begin
    
		process(clk_rnd_in, a_in, b_in) is
        begin
        	if clk_rnd_in = "11" then
            	if a_in = '1' then
                	pnt1 <= pnt1 + 1;
                end if;
                if b_in = '1' then
                	pnt2 <= pnt2 + 1;
                end if;
            else
            	if a_in = '1' and not pnt1 = "0000" then
                	pnt1 <= pnt1 - 1;
                end if;
                if b_in = '1' and not pnt2 = "0000" then
                	pnt2 <= pnt2 - 1;
                end if;
            end if;
            
            if pnt1 = "1001" or pnt2 = "1001" then
            	pnt1 <= "0000";
                pnt2 <= "0000";
            end if;
        end process;
        
end bhv;
