library IEEE;
use IEEE.std_logic_1164.all;

-- entidade para decodificacao dos valores de pontuacao
-- de 4 btis para os displays LED de 8 segmentos
entity display is
port(
	bin_in: in std_logic_vector(3 downto 0);   -- entrada de 4 bits
	disp_out: out std_logic_vector(7 downto 0) -- bits decodificados 
);
end display;

architecture disp of display is
begin
	with bin_in select
		disp_out <= "11000000" when "0000", --0
			         "11111001" when "0001", --1
					   "10100100" when "0010", --2
					   "10110000" when "0011", --3
				      "10011001" when "0100", --4
				      "10010010" when "0101", --5
				      "10000010" when "0110", --6
				      "11111000" when "0111", --7
				      "10000000" when "1000", --8
				      "10010000" when "1001", --9 
				      "10111111" when others;
end disp;
