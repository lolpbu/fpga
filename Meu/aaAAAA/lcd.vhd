library ieee;
use ieee.std_logic_1164.all;

entity lcd is
port(
	clk: in std_logic;
    
    hour, min, sec: in std_logic_vector(5 downto 0);
    
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
                    s24, s25, s26, s27, s28, s29, s30, s31,
                    s32, s33, s34, s35, s36, s37, s38, s39,
                    sIdle);
    
    signal stt: state := s0;
    signal hour_c, min1_c, min2_c, sec1_c, sec2_c: std_logic_vector(7 downto 0);

begin

	with hour select
    	hour1_c <= x"30" when x"0",
                   x"31" when others;
    
    min1_c <= x"30" when (min < x"a"),
              x"31" when (min > x"9" and min < x"14"),
              x"32" when (min > )

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
                        
                    -------- H --------
                   when s9 =>
                		stt <= s10;
                        
                        with hour select
                        	LCD_DB <= x"30" when "000000",
                            		  x"31" when others;
                        
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';
                    when s10 =>
                    	stt <= s11;
                        LCD_DB <= "00000001";
                        LCD_EN <= '1';
                        LCD_RW <= '0';
                        LCD_RS <= '1';


-------------------Write 'P'-------------------				
			 when S9 =>
				current_state <= S10;			

				LCD_DATA		<= x"50";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		
				
			 when S10 =>
				current_state <= S11;

				LCD_DATA		<= x"50";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		
				
-------------------WRITE 'Y'-------------------						
			 when S11 =>
				current_state <= S12;				

				LCD_DATA		<= X"59";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
						
			 when S12 =>
				current_state <= S13;	
				
				LCD_DATA		<= X"59";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';						
				
-------------------WRITE 'R'-------------------						
			 when S13 =>
				current_state <= S14;				
				LCD_DATA		<= X"52";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		
				
			 when S14 =>
				current_state <= S15;
				LCD_DATA		<= X"52";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		

-------------------WRITE 'O'-------------------							
			 when S15 =>
				current_state <= S16;
				LCD_DATA		<= X"4F";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';		
				
			 when S16 =>
				current_state <= S17;
				LCD_DATA		<= X"4F";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
-------------------WRITE 'E'-------------------					
			 when S17 =>
				current_state <= S18;	
				LCD_DATA		<= X"45";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S18 =>
				current_state <= S19;
				LCD_DATA		<= X"45";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'L'-------------------					
			 when S19 =>
				current_state <= S20;	
				LCD_DATA		<= X"4C";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S20 =>
				current_state <= S21;
				LCD_DATA		<= X"4C";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'E'-------------------					
			 when S21 =>
				current_state <= S22;	
				LCD_DATA		<= X"45";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S22 =>
				current_state <= S23;
				LCD_DATA		<= X"45";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'C'-------------------					
			 when S23 =>
				current_state <= S24;	
				LCD_DATA		<= X"43";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S24 =>
				current_state <= S25;
				LCD_DATA		<= X"43";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'T'-------------------					
			 when S25 =>
				current_state <= S26;	
				LCD_DATA		<= X"54";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S26 =>
				current_state <= S27;
				LCD_DATA		<= X"54";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'R'-------------------					
			 when S27 =>
				current_state <= S28;	
				LCD_DATA		<= X"52";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S28 =>
				current_state <= S29;
				LCD_DATA		<= X"52";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'O'-------------------					
			 when S29 =>
				current_state <= S30;	
				LCD_DATA		<= X"4F";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S30 =>
				current_state <= S31;
				LCD_DATA		<= X"4F";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE '.'-------------------					
			 when S31 =>
				current_state <= S32;	
				LCD_DATA		<= X"2E";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S32 =>
				current_state <= S33;
				LCD_DATA		<= X"2E";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
		
-------------------WRITE 'c'-------------------					
			 when S33 =>
				current_state <= S34;	
				LCD_DATA		<= X"63";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S34 =>
				current_state <= S35;
				LCD_DATA		<= X"63";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	

-------------------WRITE 'o'-------------------					
			 when S35 =>
				current_state <= S36;	
				LCD_DATA		<= X"6F";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S36 =>
				current_state <= S37;
				LCD_DATA		<= X"6F";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			

-------------------WRITE 'm'-------------------					
			 when S37 =>
				current_state <= S38;	
				LCD_DATA		<= X"6D";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
				
			 when S38 =>
				current_state <= S39;
				LCD_DATA		<= X"6D";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
		
			 when S39 =>
				current_state <= IDLE;				
				
			 when IDLE	=>
				current_state <= IDLE;
				
		    when others =>
				current_state <= IDLE;		 
	
		end case;	

	END IF;
	
END PROCESS;

END behavior;
