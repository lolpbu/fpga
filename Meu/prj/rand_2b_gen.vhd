library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity rnd_2b_gen is
port(
	seed1, seed2: in positive;
	bits: out std_logic_vector(1 downto 0)
);
end rnd_2b_gen;

architecture gen of rnd_2b_gen is
begin
    process
      	variable seed_1: positive := seed1;
      	variable seed_2: positive := seed2;
      	variable re1: integer;
		variable re2: real;
    begin  
		uniform(seed_1, seed_2, re2);
       	re1 := integer (re2 * real(2**2 - 1));  
    	bits <= std_logic_vector(to_unsigned(re1, 2));
      	wait for 1 ns;
      	if Now > 50 ns then
        	wait;
      	end if;
    end process;
    
end gen;
