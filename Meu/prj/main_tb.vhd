
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all ;

entity main is
port(
	clk, reset: in std_logic;
	a_in, b_in: in std_logic;
    --sgn: out std_logic_vector(1 downto 0) := "00";
    
    --pnt_a: out std_logic_vector(3 downto 0) := "0000";
    --pnt_b: out std_logic_vector(3 downto 0) := "0000";
    
    pnt_a_disp: out std_logic_vector(7 downto 0) ;
    pnt_b_disp: out std_logic_vector(7 downto 0) 
    );
end main;

architecture bhv of main is
	
    component display is
  	port(
    	bin_in: in std_logic_vector(3 downto 0) := "0000";
      	disp_out: out std_logic_vector(7 downto 0)
  	);
  	end component;
    
    component rnd is
    port(
        clk, reset: in std_logic := '0';
        genned: out  std_logic_vector(1 downto 0)
    );
    end component;
    
    signal sgn: std_logic_vector(1 downto 0) := "00";
    
    signal pnt_a: std_logic_vector(3 downto 0) := "0000";
    signal pnt_b: std_logic_vector(3 downto 0) := "0000";
    
    signal prv_a: std_logic_vector(3 downto 0) := "0000";
    signal prv_b: std_logic_vector(3 downto 0) := "0000";
    
begin
	RND_DUT: rnd port map(clk, reset, sgn);
-- 	process(clk) is
--     begin
--     	if clk'event and clk = '1' then
--         	if sgn = "00" then
--             	sgn <= "01";
--             elsif sgn = "01" then
--             	sgn <= "10";
--             elsif sgn = "10" then
--             	sgn <= "11";
--             elsif sgn = "11" then
--             	sgn <= "00";
--             end if;
--         end if;
--     end process;

	process(sgn, a_in, b_in) is
    begin
    	if sgn = "11" then
        	if a_in = '1' then
            	pnt_a <= std_logic_vector(unsigned(prv_a) + 1);
                prv_a <= pnt_a;
            end if;
            
            if b_in = '1' then
            	pnt_b <= std_logic_vector(unsigned(prv_b) + 1);
                prv_b <= pnt_b;
            end if;
        else
        	if a_in = '1' and pnt_a /= "0000" then
            	pnt_a <= std_logic_vector(unsigned(prv_a) - 1);
                prv_a <= pnt_a;
            end if;
            
            if b_in = '1' and pnt_a /= "0000" then
            	pnt_b <= std_logic_vector(unsigned(prv_b) - 1);
                prv_b <= pnt_b;
            end if;
        end if;
    end process;
    
    DISPA_DUT: display port map(pnt_a, pnt_a_disp);
    DISPB_DUT: display port map(pnt_b, pnt_b_disp);
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
