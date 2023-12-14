library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all ;

-- entidade principal
entity projeto is
port(
	-- entrada do clock de 50MHz e o pino de reset
	clk, reset: in std_logic := '0';
	
	-- entradas para os jogadores
	a_in, b_in: in std_logic := '0'; 
    
	-- saida contendo os sinais para os pinos GPIO,
	-- o ultimo bit signals_out(3) contem o sinal correto
	signals_out: out std_logic_vector(3 downto 0) := "0000";
	
	-- saida para os displays de 8 segmentos, demonstrando a pontuacao de cada jogador
   pntA_disp: out std_logic_vector(7 downto 0) := "00000000";
   pntB_disp: out std_logic_vector(7 downto 0) := "00000000"
);
end projeto;

architecture bhv of projeto is
	
	-- componente para os displays
	component display is
  	port(
    	bin_in: in std_logic_vector(3 downto 0) := "0000";
      disp_out: out std_logic_vector(7 downto 0) := "00000000"
  	);
  	end component;
	
	-- componente gerador de 2 bits aleatorios
	component rnd is
	port(
		clk, reset: in std_logic;
		genned: out  std_logic_vector(1 downto 0)
	);
	end component;
 
	signal clk_rnd: std_logic := '0';                     -- clock de 1Hz
   signal sgn_rnd: std_logic_vector(1 downto 0) := "00"; -- 2 bits responsaveis pelos sinais aleatorios, gerado usando o clock de 1Hz
    
	signal a_db, b_db: std_logic := '0'; -- debouncer simples para cada entrada de jogador
	
	-- pontuacao de cada jogador
   signal pnt_a: std_logic_vector(3 downto 0) := "0000";
   signal pnt_b: std_logic_vector(3 downto 0) := "0000";
	
	-- pontuacao anterior de cada jogador
   signal prv_a: std_logic_vector(3 downto 0) := "0000";
   signal prv_b: std_logic_vector(3 downto 0) := "0000";
	 
begin
	-- ligacao para o componente gerador de 2 bits aleatorio
	RND_DUT: rnd port map(clk_rnd, reset, sgn_rnd);
	
	-- processo de conversao do clock de 50MHz para o clock de 1Hz
	process(clk) is
		variable clk_count: integer := 0;
	begin
		if rising_edge(clk) then
			clk_count := clk_count + 1;
			if clk_count < 50000000 then
				clk_rnd <= '1';
			elsif clk_count >= 50000000 and clk_count < 100000000  then
				clk_rnd <= '0';
			else
				clk_count := 0;
			end if;
		end if;
	end process;
		
	-- processo pincipal, responsavel pelo controle e checagem de pontuacao
	process(clk, reset) is
	begin
		if reset = '1' then
			-- reseta as pontuacoes
			pnt_a <= "0000";
			pnt_b <= "0000";
			prv_a <= "0000";
			prv_b <= "0000";
		elsif rising_edge(clk) then
			
			-- checagem do botao de cada jogador, com um debouncer simples
			
			-- jogador 1
			if a_in = '1' and a_db = '0' then
				if sgn_rnd = "11" then 
					-- sinal   correto, incrementa a pontuacao
					pnt_a <= std_logic_vector(unsigned(prv_a) + 1);
					prv_a <= pnt_a;
				else 
					-- sinal incorreto, decrementa a pontuacao
					if pnt_a /= "0000" then
						pnt_a <= std_logic_vector(unsigned(prv_a) - 1);
						prv_a <= pnt_a;
					end if;
				end if;
			end if;
			
			-- jogador 2
			if b_in = '1' and b_db = '0' then
				if sgn_rnd = "11" then
					-- sinal   correto, incrementa a pontuacao
					pnt_b <= std_logic_vector(unsigned(prv_b) + 1);
					prv_b <= pnt_b;
				else
					-- sinal incorreto, decrementa a pontuacao
					if pnt_b /= "0000" then
						pnt_b <= std_logic_vector(unsigned(prv_b) - 1);
						prv_b <= pnt_b;
					end if;
				end if;
			end if;
			
			a_db <= a_in;
			b_db <= b_in;
			
			-- caso uma pontuacao ultrapasse o valor maximo,
			-- as pontuacoes sao resetadas
			if pnt_a = "1010" or pnt_b = "1010" then
				pnt_a <= "0000";
				pnt_b <= "0000";
				prv_a <= "0000";
				prv_b <= "0000";
			end if;
			
		end if;
	end process;
    
	-- conexoes entre as pontuacoes e seus displays 
   DISPA_DUT: display port map(pnt_a, pntA_disp);
   DISPB_DUT: display port map(pnt_b, pntB_disp);
	 
	-- definindo os sinais para os pinos GPIO de acordo com os 2 bits aleatorios
	with sgn_rnd select
		signals_out <= "0001" when "00",
						   "0010" when "01",
						   "0100" when "10",
						   "1000" when "11";
end bhv;
