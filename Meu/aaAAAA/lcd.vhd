library ieee;
use ieee.std_logic_1164.all;

-- entidade do LCD 
entity lcd is
port(
	clk: in std_logic;
    
    hour: in std_logic_vector(5 downto 0);
    min : in std_logic_vector(5 downto 0);
    sec : in std_logic_vector(5 downto 0);
    
    LCD_EN: out std_logic;
    LCD_RW: out std_logic;
    LCD_RS: out std_Logic;
    LCD_DB: out std_logic_vector(7 downto 0)
);
end lcd;

architecture bhv of lcd is
	type state is (  s0,  s1,  s2,  s3,  s4,  s5,  s6,  s7,
    				 s8,  s9, s10, s11, s12, s13, s14, s15,
                    s16, s17, s18, s19, s20, s21, s22, s23,
                    s24, s25, sIdle
                );
    
    signal stt: state := s0;
    signal hour_c, min1_c, min2_c, sec1_c, sec2_c: std_logic_vector(7 downto 0);

begin

	with hour select
    	hour_c <= x"30" when "000000",
                  x"31" when others;
    -- convertendo os 6 bits para seus valores ascii das dezenas e unidades
    with min select
        min1_c <= x"30" when "000000",--0
                  x"30" when "000001",--1 
                  x"30" when "000010",--2
                  x"30" when "000011",--3
                  x"30" when "000100",--4
                  x"30" when "000101",--5
                  x"30" when "000110",--6
                  x"30" when "000111",--7
                  x"30" when "001000",--8
                  x"30" when "001001",--9
                  x"31" when "001010",--10
                  x"31" when "001011",--11
                  x"31" when "001100",--12
                  x"31" when "001101",--13
                  x"31" when "001110",--14
                  x"31" when "001111",--15
                  x"31" when "010000",--16
                  x"31" when "010001",--17
                  x"31" when "010010",--18
                  x"31" when "010011",--19
                  x"32" when "010100",--20
                  x"32" when "010101",--21
                  x"32" when "010110",--22
                  x"32" when "010111",--23
                  x"32" when "011000",--24
                  x"32" when "011001",--25
                  x"32" when "011010",--26
                  x"32" when "011011",--27
                  x"32" when "011100",--28
                  x"32" when "011101",--29
                  x"33" when "011110",--30
                  x"33" when "011111",--31
                  x"33" when "100000",--32
                  x"33" when "100001",--33 
                  x"33" when "100010",--34
                  x"33" when "100011",--35
                  x"33" when "100100",--36
                  x"33" when "100101",--37
                  x"33" when "100110",--38
                  x"33" when "100111",--39
                  x"34" when "101000",--40
                  x"34" when "101001",--41
                  x"34" when "101010",--42
                  x"34" when "101011",--43
                  x"34" when "101100",--44
                  x"34" when "101101",--45
                  x"34" when "101110",--46
                  x"34" when "101111",--47
                  x"34" when "110000",--48
                  x"34" when "110001",--49
                  x"35" when "110010",--50
                  x"35" when "110011",--51
                  x"35" when "110100",--52
                  x"35" when "110101",--53
                  x"35" when "110110",--54
                  x"35" when "110111",--55
                  x"35" when "111000",--56
                  x"35" when "111001",--57
                  x"35" when "111010",--58
                  x"35" when "111011",--59
                  x"30" when others;
        
    with min select
        min2_c <= x"30" when "000000",--0
                  x"31" when "000001",--1 
                  x"32" when "000010",--2
                  x"33" when "000011",--3
                  x"34" when "000100",--4
                  x"35" when "000101",--5
                  x"36" when "000110",--6
                  x"37" when "000111",--7
                  x"38" when "001000",--8
                  x"39" when "001001",--9
                  x"30" when "001010",--10
                  x"31" when "001011",--11
                  x"32" when "001100",--12
                  x"33" when "001101",--13
                  x"34" when "001110",--14
                  x"35" when "001111",--15
                  x"36" when "010000",--16
                  x"37" when "010001",--17
                  x"38" when "010010",--18
                  x"39" when "010011",--19
                  x"30" when "010100",--20
                  x"31" when "010101",--21
                  x"32" when "010110",--22
                  x"33" when "010111",--23
                  x"34" when "011000",--24
                  x"35" when "011001",--25
                  x"36" when "011010",--26
                  x"37" when "011011",--27
                  x"38" when "011100",--28
                  x"39" when "011101",--29
                  x"30" when "011110",--30
                  x"31" when "011111",--31
                  x"32" when "100000",--32
                  x"33" when "100001",--33 
                  x"34" when "100010",--34
                  x"35" when "100011",--35
                  x"36" when "100100",--36
                  x"37" when "100101",--37
                  x"38" when "100110",--38
                  x"39" when "100111",--39
                  x"30" when "101000",--40
                  x"31" when "101001",--41
                  x"32" when "101010",--42
                  x"33" when "101011",--43
                  x"34" when "101100",--44
                  x"35" when "101101",--45
                  x"36" when "101110",--46
                  x"37" when "101111",--47
                  x"38" when "110000",--48
                  x"39" when "110001",--49
                  x"30" when "110010",--50
                  x"31" when "110011",--51
                  x"32" when "110100",--52
                  x"33" when "110101",--53
                  x"34" when "110110",--54
                  x"35" when "110111",--55
                  x"36" when "111000",--56
                  x"37" when "111001",--57
                  x"38" when "111010",--58
                  x"39" when "111011",--59
                  x"30" when others;

    with sec select
        sec1_c <= x"30" when "000000",--0
                  x"30" when "000001",--1 
                  x"30" when "000010",--2
                  x"30" when "000011",--3
                  x"30" when "000100",--4
                  x"30" when "000101",--5
                  x"30" when "000110",--6
                  x"30" when "000111",--7
                  x"30" when "001000",--8
                  x"30" when "001001",--9
                  x"31" when "001010",--10
                  x"31" when "001011",--11
                  x"31" when "001100",--12
                  x"31" when "001101",--13
                  x"31" when "001110",--14
                  x"31" when "001111",--15
                  x"31" when "010000",--16
                  x"31" when "010001",--17
                  x"31" when "010010",--18
                  x"31" when "010011",--19
                  x"32" when "010100",--20
                  x"32" when "010101",--21
                  x"32" when "010110",--22
                  x"32" when "010111",--23
                  x"32" when "011000",--24
                  x"32" when "011001",--25
                  x"32" when "011010",--26
                  x"32" when "011011",--27
                  x"32" when "011100",--28
                  x"32" when "011101",--29
                  x"33" when "011110",--30
                  x"33" when "011111",--31
                  x"33" when "100000",--32
                  x"33" when "100001",--33 
                  x"33" when "100010",--34
                  x"33" when "100011",--35
                  x"33" when "100100",--36
                  x"33" when "100101",--37
                  x"33" when "100110",--38
                  x"33" when "100111",--39
                  x"34" when "101000",--40
                  x"34" when "101001",--41
                  x"34" when "101010",--42
                  x"34" when "101011",--43
                  x"34" when "101100",--44
                  x"34" when "101101",--45
                  x"34" when "101110",--46
                  x"34" when "101111",--47
                  x"34" when "110000",--48
                  x"34" when "110001",--49
                  x"35" when "110010",--50
                  x"35" when "110011",--51
                  x"35" when "110100",--52
                  x"35" when "110101",--53
                  x"35" when "110110",--54
                  x"35" when "110111",--55
                  x"35" when "111000",--56
                  x"35" when "111001",--57
                  x"35" when "111010",--58
                  x"35" when "111011",--59
                  x"30" when others;
        
    with sec select
        sec2_c <= x"30" when "000000",--0
                  x"31" when "000001",--1 
                  x"32" when "000010",--2
                  x"33" when "000011",--3
                  x"34" when "000100",--4
                  x"35" when "000101",--5
                  x"36" when "000110",--6
                  x"37" when "000111",--7
                  x"38" when "001000",--8
                  x"39" when "001001",--9
                  x"30" when "001010",--10
                  x"31" when "001011",--11
                  x"32" when "001100",--12
                  x"33" when "001101",--13
                  x"34" when "001110",--14
                  x"35" when "001111",--15
                  x"36" when "010000",--16
                  x"37" when "010001",--17
                  x"38" when "010010",--18
                  x"39" when "010011",--19
                  x"30" when "010100",--20
                  x"31" when "010101",--21
                  x"32" when "010110",--22
                  x"33" when "010111",--23
                  x"34" when "011000",--24
                  x"35" when "011001",--25
                  x"36" when "011010",--26
                  x"37" when "011011",--27
                  x"38" when "011100",--28
                  x"39" when "011101",--29
                  x"30" when "011110",--30
                  x"31" when "011111",--31
                  x"32" when "100000",--32
                  x"33" when "100001",--33 
                  x"34" when "100010",--34
                  x"35" when "100011",--35
                  x"36" when "100100",--36
                  x"37" when "100101",--37
                  x"38" when "100110",--38
                  x"39" when "100111",--39
                  x"30" when "101000",--40
                  x"31" when "101001",--41
                  x"32" when "101010",--42
                  x"33" when "101011",--43
                  x"34" when "101100",--44
                  x"35" when "101101",--45
                  x"36" when "101110",--46
                  x"37" when "101111",--47
                  x"38" when "110000",--48
                  x"39" when "110001",--49
                  x"30" when "110010",--50
                  x"31" when "110011",--51
                  x"32" when "110100",--52
                  x"33" when "110101",--53
                  x"34" when "110110",--54
                  x"35" when "110111",--55
                  x"36" when "111000",--56
                  x"37" when "111001",--57
                  x"38" when "111010",--58
                  x"39" when "111011",--59
                  x"30" when others;




	process(clk) is
    	variable cnt: integer range 0 to 1750000 := 0;
    begin
    	if rising_edge(clk) then
        	if cnt = 1750000 then
            	cnt := 0;
            else
            	cnt := cnt + 1;
            end if;
            
            if cnt = 1500000 then
            	case stt is
                	------- set -------
                	when s0 =>
                		stt <= s1;
                        LCD_DB <= "00110000";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '0';
                    when s1 =>
                    	stt <= s2;
                        LCD_DB <= "00110000";
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '0';
                    when s2 =>
                    	stt <= s3;
                        LCD_DB <= "00110000";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '0';
                        
                   ------ reset ------
                   when s3 =>
                		stt <= s4;
                        LCD_DB <= "00000001";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '0';
                    when s4 =>
                    	stt <= s5;
                        LCD_DB <= "00000001";
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '0';
                    when s5 =>
                    	stt <= s6;
                        LCD_DB <= "00000001";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '0';
                        
                    ------- on  -------
                    when s6 =>
                		stt <= s7;
                        LCD_DB <= "00001110";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '0';
                    when s7 =>
                    	stt <= s8;
                        LCD_DB <= "00001110";
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '0';
                    when s8 =>
                    	stt <= s9;
                        LCD_DB <= "00001110";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    
                    -------- 0 --------
                    when s9 =>
                        stt <= s10;
                        LCD_DB <= x"30";
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s10 =>
                        stt <= s11;
                        LCD_DB <= x"30";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';

                    -------- H --------
                   when s11 =>
                		stt <= s12;
                        LCD_DB <= hour_c;
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s12 =>
                    	stt <= s13;
                        LCD_DB <= hour_c;
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';

                    -------- : --------
                    when s13 =>
                        stt <= s14;
                        LCD_DB <= x"3A";
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s14 =>
                        stt <= s15;
                        LCD_DB <= x"3A";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    
                    -------- M1 --------
                    when s15 =>
                        stt <= s16;
                        LCD_DB <= min1_c;
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s16 =>
                        stt <= s17;
                        LCD_DB <= min1_c;
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    
                    -------- M2 --------
                    when s17 =>
                        stt <= s18;
                        LCD_DB <= min2_c;
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s18 =>
                        stt <= s19;
                        LCD_DB <= min2_c;
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';

                    -------- : --------
                    when s19 =>
                        stt <= s20;
                        LCD_DB <= x"3A";
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s20 =>
                        stt <= s21;
                        LCD_DB <= x"3A";
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    
                    -------- S1 --------
                    when s21 =>
                        stt <= s22;
                        LCD_DB <= sec1_c;
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s22 =>
                        stt <= s23;
                        LCD_DB <= sec1_c;
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    
                    -------- S2 --------
                    when s23 =>
                        stt <= s24;
                        LCD_DB <= sec2_c;
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s24 =>
                        stt <= s25;
                        LCD_DB <= sec2_c;
                        LCD_EN <= '0';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    
                    when s25 =>
                        stt <= s0;

                    when others =>
                        stt <= sIdle;
                end case;
            end if;
        end if;
    end process;
end bhv;
