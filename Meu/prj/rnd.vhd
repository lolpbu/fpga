library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity rnd_2b_gen is
port(
	clk: in std_logic;
    bits: out std_logic_vector(1 downto 0)
);
end rnd_2b_gen;

architecture gen of rnd_2b_gen is
begin
	process(clk) is
    	variable seed1, seed2: positive := 1;
        variable genned: real;
    begin
    	if rising_edge(clk) then
        	uniform(seed1, seed2, genned);
            if genned < 0.25 then
            	bits <= "00";
            elsif genned > 0.25 and genned < 0.5 then
            	bits <= "01";
            elsif genned > 0.5 and genned < 0.75 then
            	bits <= "10";
            else
            	bits <= "11";
            end if;
        end if;
    end process;
end gen;
