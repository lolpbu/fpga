library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all ;
use ieee.std_logic_unsigned.all;

entity projeto is
port(

	clk: in std_Logic;
	
	a_in: in std_logic;
	b_in: in std_logic;
    
    pnt1_disp: out std_logic_vector(7 downto 0) := "11111111";
    pnt2_disp: out std_logic_vector(7 downto 0) := "11111111";
    
	 clk_led: out std_logic;
	 
    signals_word: out std_logic_vector(3 downto 0)
    
	);
end projeto;

architecture bhv of projeto is

	component rnd_2b_gen is
    port(
    	clk: in std_logic;
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
	signal clk_rnd: std_logic;
    signal sign_rnd: std_logic_vector(1 downto 0);

	begin
			--RANDDUT: rnd_2b_gen port map(clk_rnd, sign_rnd);
        
      process(clk) is
			variable count_clk_rnd: integer := 0;
		begin
			if clk'event and clk = '1' then
				count_clk_rnd := count_clk_rnd + 1;
				report "count: " & integer'image(count_clk_rnd) severity note;

			  if count_clk_rnd < 50000000 then
					clk_rnd <= '1';
			  elsif count_clk_rnd >= 50000000 AND count_clk_rnd < 100000000 then
					clk_rnd <= '0';
			  else
					count_clk_rnd := 0;
			  end if;
			end if;
      end process;
		
		process(clk_rnd)
		begin
			if clk_rnd'event and clk_rnd = '1' then
				if sign_rnd = "00" then
					sign_rnd <= "01";
				elsif sign_rnd = "01" then
					sign_rnd <= "10";
				elsif sign_rnd = "10" then
					sign_rnd <= "11";
				elsif sign_rnd = "11" then
					sign_rnd <= "00";
				end if;
			end if;
		end process;
 
		
		process(sign_rnd, a_in, b_in)
      begin
		  
        	if sign_rnd = "11" then
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
        
		  clk_led <= clk_rnd;
		  
		  with sign_rnd select
				signals_word <= "0001" when "00",
										"0010" when "01",
										"0100" when "10",
										"1000" when "11";
										
			DISP1DUT: display port map(pnt1, pnt1_disp);
			DISP2DUT: display port map(pnt2, pnt2_disp);
		  
end bhv;
