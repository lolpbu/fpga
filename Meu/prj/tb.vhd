-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end tb;

architecture a of tb is

component main is
port(
	clk, reset: in std_logic;
    a_in,b_in: in std_logic; 
    --sgn: out std_logic_vector(1 downto 0) := "00";
    --w: out std_logic;
--     pnt_a: out std_logic_vector(3 downto 0) := "0000";
--     pnt_b: out std_logic_vector(3 downto 0) := "0000";
    pnt_a_disp: out std_logic_vector(7 downto 0) ;
    pnt_b_disp: out std_logic_vector(7 downto 0) 
    );
end component;

component rnd is
    port(
        clk, reset: in std_logic;
        genned: out  std_logic_vector(1 downto 0)
    );
    end component;

component display is
  	port(
    	bin_in: in std_logic_vector(3 downto 0) := "0000";
      	disp_out: out std_logic_vector(7 downto 0)
  	);
  	end component;

signal a,b, clk, res: std_logic;
--signal sgn: std_logic_vector(1 downto 0);
signal p1, p2: std_logic_vector(3 downto 0);
signal disp1, disp2: std_logic_vector(7 downto 0) ;

begin
	m: main port map(clk, res, a,b, disp1, disp2);
    --DISPA_DUT: display port map(p1, disp1);
--     DISPB_DUT: display port map(p2, disp2);
    
    process
    begin
    	clk <= '0';
        res <= '0';
        a <= '0';
        b <= '0';
        wait for 5 ns;
        
        clk <= not clk; -- 01
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; -- 01
        wait for 5 ns;
        
        clk <= not clk; -- 10
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; --10
        wait for 5 ns;
        
        clk <= not clk; --11
        a <= '1';
        wait for 5 ns;
        
        clk <= not clk; --11
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; -- 00
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; -- 00
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; -- 01
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; -- 01
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; --10
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; --10
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; --11
        a <= '1';
        wait for 5 ns;
        
        clk <= not clk; --11
        a <= '1';
        wait for 5 ns;
        
        clk <= not clk; -- 00
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; -- 00
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; -- 01
        a <= '1';
        wait for 5 ns;
        
        clk <= not clk; -- 01
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; --10
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; --10
        a <= '0';
        wait for 5 ns;
        
        clk <= not clk; --11
        a <= '1';
        wait for 5 ns;
        
        clk <= not clk; --11
        a <= '0';
        wait for 5 ns;
        
        
        wait;
        
    end process;

end a;
