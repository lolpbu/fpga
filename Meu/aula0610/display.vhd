library IEEE;
use IEEE.std_logic_1164.all;

entity display is
port(
	res_in: in std_logic_vector(3 downto 0);
	disp_out: out std_logic_vector(7 downto 0));
end display;

architecture disp of display is
begin
		with res_in select
			disp_out <= "11000000" when "0000",
			        "11111001" when "0001",
					  "10100100" when "0010",
					  "10110000" when "0011",
					  "10011001" when "0100",
					  "10010010" when "0101",
					  "10000010" when "0110",
					  "11111000" when "0111",
					  "10000000" when "1000",
					  "10010000" when "1001",
					  "10001000" when "1010",
					  "10000011" when "1011",
					  "11000110" when "1100",
					  "10100001" when "1101",
					  "10000110" when "1110",
					  "10001110" when "1111";
end disp;