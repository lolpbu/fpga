library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all ;
use ieee.std_logic_unsigned.all;

entity tb is
end tb;

architecture bhv of tb is

	component main is
	port(
        a_in: in std_logic;
	b_in: in std_logic;
    
    pnt1_disp: out std_logic_vector(7 downto 0);
    pnt2_disp: out std_logic_vector(7 downto 0);
    signals_word: out std_logic_vector(3 downto 0)
      	--clk_rnd_in: in std_logic_vector(1 downto 0)
    );
	end component;
    
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

	signal a_in, b_in: std_logic;
    signal pnt1_disp, pnt2_disp: std_logic_vector(7 downto 0);
    signal signals_word: std_logic_vector(3 downto 0);
    
	signal clk_rnd_in: std_logic_vector(1 downto 0);
    signal pnt1, pnt2: std_logic_vector(3 downto 0) := "0000";

	begin
    	MAINDUT: main port map(a_in, b_in);
        RANDDUT: rnd_2b_gen port map(1, 1, clk_rnd_in);
        DISP1DUT: display port map(pnt1, pnt1_disp);
        DISP2DUT: display port map(pnt2, pnt2_disp);
        
		process
        begin
        	a_in <= '0';
          	b_in <= '0';
          	wait for 1 ns;
          	
          	a_in <= '1';
          	b_in <= '0';
          	wait for 1 ns;
          
          	a_in <= '0';
          	b_in <= '1';
          	wait for 1 ns;
          
          	a_in <= '1';
          	b_in <= '1';
          	wait for 1 ns;
          
          	a_in <= '1';
          	b_in <= '0';
          	wait for 1 ns;
          
          	a_in <= '1';
          	b_in <= '1';
          	wait for 1 ns;
          
          	a_in <= '0';
          	b_in <= '1';
          	wait for 1 ns;
          
          	a_in <= '0';
          	b_in <= '0';
          	wait for 1 ns;
          
          	wait;
        end process;
        
end bhv;
