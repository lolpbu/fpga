library IEEe;
use IEEE.std_logic_1164.all;

-- entidade que gera 2 bits pseudo-aleatorios
-- utilizando um circuito LFSR
entity rnd is
port(
	clk, reset: in std_logic; -- clock para a geracao dos bits e reset 
   genned: out  std_logic_vector(1 downto 0) -- saida para os 2 bits gerados
);
end rnd;

architecture gen of rnd is

	signal count_i: std_logic_vector(3 downto 0); -- sinal para saida
   signal fb: std_logic;                         -- sinal de feedback
	
begin
	fb <= (not count_i(3)) xor count_i(2);
    
   process(clk, reset) is
   begin
		if reset = '1' then
			count_i <= (others=>'0');
		elsif rising_edge(clk) then
			count_i <= count_i(2 downto 0) & fb;
		end if;
	end process;
    
   genned(1) <= count_i(2);
   genned(0) <= count_i(1);
    
end gen;
