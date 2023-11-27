library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all ;
use ieee.std_logic_unsigned.all;

entity main is
port(
	a_in: in std_logic;
	b_in: in std_logic;
    
    pnt1_disp: out std_logic_vector(7 downto 0);
    pnt2_disp: out std_logic_vector(7 downto 0);
    
    signals_word: out std_logic_vector(3 downto 0)
    
	);
end main;

architecture bhv of main is

	component rnd_2b_gen is
    port(
    	seed1, seed2: in positive;
    	bits: out std_logic_vector(1 downto 0)
    );
    end component;
    
    component display is
    	port(
        	bin_in: in std_logic_vector(3 downto 0);
            disp_out: out std_logic_vector(7 downto 0)
         );
    end component; 

	signal pnt1, pnt2: std_logic_vector(3 downto 0) := "0000";
    signal clk_rnd_in: std_logic_vector(1 downto 0);

	begin
    	RANDDUT: rnd_2b_gen port map(1, 1, clk_rnd_in);
        DISP1DUT: display port map(pnt1, pnt1_disp);
        DISP2DUT: display port map(pnt2, pnt2_disp);
        
        process(clk_rnd_in) is
        begin
        	with clk_rnd_in select
            	signals_word <= "0001" when "00",
                				"0010" when "01",
                                "0100" when "10",
                                "1000" when "11",
                                "0001" when others;
        end process;
        
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
            	if a_in = '1' and pnt1 > "0000" then
                	pnt1 <= pnt1 - 1;
                end if;
                if b_in = '1' and pnt2 > "0000" then
                	pnt2 <= pnt2 - 1;
                end if;
            end if;
            
            if pnt1 = "1001" or pnt2 = "1001" then
            	pnt1 <= "0000";
                pnt2 <= "0000";
            end if;
        end process;
        
end bhv;
