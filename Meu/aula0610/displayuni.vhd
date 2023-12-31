library IEEE;
use IEEE.std_logic_1164.all;

entity display_uni is
port(
	res_in: in std_logic_vector(4 downto 0);
	disp_out: out std_logic_vector(7 downto 0));
end display_uni;

architecture disp of display_uni is
begin
		with res_in select
			disp_out <= "11000000" when "00000",--0
			        "11111001" when "00001",--1 
					  "10100100" when "00010",--2
					  "10110000" when "00011",--3
					  "10011001" when "00100",--4
					  "10010010" when "00101",--5
					  "10000010" when "00110",--6
					  "11111000" when "00111",--7
					  "10000000" when "01000",--8
					  "10010000" when "01001",--9
					  "11000000" when "01010",--10
					  "11111001" when "01011",--11
					  "10100100" when "01100",--12
					  "10110000" when "01101",--13
					  "10011001" when "01110",--14
					  "10010010" when "01111",--15
					  "10000010" when "10000",--16
					  "11111000" when "10001",--17
					  "10000000" when "10010",--18
					  "10010000" when "10011",--19
					  "11000000" when "10100",--20
					  "11111001" when "10101",--21
					  "10100100" when "10110",--22
					  "10110000" when "10111",--23
					  "10011001" when "11000",--24
					  "10010010" when "11001",--25
					  "10000010" when "11010",--26
					  "11111000" when "11011",--27
					  "10000000" when "11100",--28
					  "10010000" when "11101",--29
					  "11000000" when "11110",--30
					  "11111001" when "11111";--31
end disp;