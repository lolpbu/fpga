library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity smc is
	port(a, b, c_in : in std_logic;
	     s, c_out : out std_logic);
end smc;

architecture bhv of smc is
begin
	s <= a xor b xor c_in;
	c_out <= ( (a xor b) and c_in ) or (a and b);
end bhv;