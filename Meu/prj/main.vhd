
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all ;

entity projeto is
port(
	clk, reset: in std_logic := '0';
	a_in, b_in: in std_logic := '0';
    --sgn: out std_logic_vector(1 downto 0) := "00";
    
    --pnt_a: out std_logic_vector(3 downto 0) := "0000";
    --pnt_b: out std_logic_vector(3 downto 0) := "0000";
    
	 signs_word: out std_logic_vector(3 downto 0) := "0000";
	 clk_led: out std_logic := '0';
	 
	 pntA_word: out std_logic_vector(3 downto 0);
	 
    pnt_a_disp: out std_logic_vector(7 downto 0) := "00000000";
    pnt_b_disp: out std_logic_vector(7 downto 0) := "00000000"
    );
end projeto;

architecture bhv of projeto is
	
    component display is
  	port(
    	bin_in: in std_logic_vector(3 downto 0) := "0000";
      	disp_out: out std_logic_vector(7 downto 0) := "00000000"
  	);
  	end component;
    
    component rnd is
    port(
        clk, reset: in std_logic := '0';
        genned: out  std_logic_vector(1 downto 0) := "00"
    );
    end component;
    
	 signal clk_rnd: std_logic := '0';
    signal sgn_rnd: std_logic_vector(1 downto 0) := "00";
    
    signal pnt_a: std_logic_vector(3 downto 0) := "0000";
    signal pnt_b: std_logic_vector(3 downto 0) := "0000";
    
    signal prv_a: std_logic_vector(3 downto 0) := "0000";
    signal prv_b: std_logic_vector(3 downto 0) := "0000";
	 
    
begin
	--RND_DUT: rnd port map(clk, reset, sgn_rnd);
	
	process(clk) is
		variable clk_count: integer := 0;
	begin
		if rising_edge(clk) then
			clk_count := clk_count + 1;
			if clk_count < 50000000 then
				clk_rnd <= '1';
			elsif clk_count >= 50000000 AND clk_count < 100000000  then
				clk_rnd <= '0';
			else
				clk_count := 0;
			end if;
		end if;
	end process;
	
	process(clk_rnd)
		begin
			if clk_rnd'event and clk_rnd = '1' then
				if sgn_rnd = "00" then
					sgn_rnd <= "01";
				elsif sgn_rnd = "01" then
					sgn_rnd <= "10";
				elsif sgn_rnd = "10" then
					sgn_rnd <= "11";
				elsif sgn_rnd = "11" then
					sgn_rnd <= "00";
				end if;
			end if;
		end process;
			
	

	process(sgn_rnd, a_in, b_in) is
    begin
    	if sgn_rnd = "11" then
			if a_in = '0'	then
				pnt_a <= std_logic_vector(unsigned(prv_a) + 1);
				prv_a <= pnt_a;
			end if;
            
			if b_in = '0' then
          	pnt_b <= std_logic_vector(unsigned(prv_b) + 1);
            prv_b <= pnt_b;
			end if;
      else
        	if a_in = '0' and pnt_a /= "0000" then
            pnt_a <= std_logic_vector(unsigned(prv_a) - 1);
            prv_a <= pnt_a;
         end if;
            
         if b_in = '0' and pnt_b /= "0000" then
           	pnt_b <= std_logic_vector(unsigned(prv_b) - 1);
            prv_b <= pnt_b;
         end if;
      end if;
    end process;
    
    DISPA_DUT: display port map(pnt_a, pnt_a_disp);
    DISPB_DUT: display port map(pnt_b, pnt_b_disp);
	 
	 clk_led <= clk_rnd;
	 pntA_word <= pnt_a;
	 
	 with sgn_rnd select
		signs_word <= "0001" when "00",
						  "0010" when "01",
						  "0100" when "10",
						  "1000" when "11";
--     with pnt_a select
-- 		pnt_a_disp <= "11000000" when "0000", --0
-- 			        "11111001" when "0001", --1
-- 					"10100100" when "0010", --2
-- 					"10110000" when "0011", --3
-- 				    "10011001" when "0100", --4
-- 				    "10010010" when "0101", --5
-- 				    "10000010" when "0110", --6
-- 				    "11111000" when "0111", --7
-- 				    "10000000" when "1000", --8
-- 				    "10010000" when "1001", --9 
-- 				    "00000000" when others;
    
end bhv;
