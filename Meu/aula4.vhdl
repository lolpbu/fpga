library IEEE;
use IEEE.std_logic_1164.all;

entity gatinho is
port(
  miau: in std_logic_vector(3 downto 0);
  w: out std_logic_vector(7 downto 0));
end gatinho;

architecture rtl of gatinho is
begin
  --process(miau) is
  --begin
    with miau select
	 w <= "11000000" when "0000", --0
		"11111001" when "0001",--1
		"10100100" when "0010",--2
		"10110000" when "0011",--3
		"10011001" when "0100",--4
		"10010010" when "0101",--5
		"10000010" when "0110",--6
		"11111000" when "0111",--7
		"10000000" when "1000",--8
		"10011000" when "1001",--9
		"10001000" when "1010",--10
		"10000011" when "1011",--11
		"11000110" when "1100",--11
		"10100001" when "1101",--11
		"10000110" when "1110",--1
		"10001110" when "1111";--1
  --end process;
end rtl;
