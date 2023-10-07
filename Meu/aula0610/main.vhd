library IEEE;
use IEEE.std_logic_1164.all;

entity main is
port(
	a_in: in std_logic_vector(3 downto 0);
	b_in: in std_logic_vector(3 downto 0);
	s1_out: out std_logic_vector(7 downto 0);
	s2_out: out std_logic_vector(7 downto 0);

	c_out: out std_logic
	);
end main;

architecture bhv of main is
	component soma is
	port ( 
		a   : in  STD_LOGIC_VECTOR (3 downto 0);
		b   : in  STD_LOGIC_VECTOR (3 downto 0);
		cin : in  STD_LOGIC;
      s   : out  STD_LOGIC_VECTOR (3 downto 0);
      cout: out  STD_LOGIC
	);
	end component;
	
	component display_uni is
	port(
		res_in: in std_logic_vector(4 downto 0);
		disp_out: out std_logic_vector(7 downto 0)
	);
	end component;
	
	component display_dez is
	port(
		res_in: in std_logic_vector(4 downto 0);
		disp_out: out std_logic_vector(7 downto 0)
	);
	end component;

	signal s_res: std_logic_vector(3 downto 0);
	signal d_res: std_logic_vector(4 downto 0);
	begin
		DUT1: soma port map(a_in, b_in, '0', s_res, d_res(4));
		d_res(3) <= s_res(3);
		d_res(2) <= s_res(2);
		d_res(1) <= s_res(1);
		d_res(0) <= s_res(0);
		DUT2: display_uni port map(d_res, s1_out);
		DUT3: display_dez port map(d_res, s2_out);
		
end bhv;
