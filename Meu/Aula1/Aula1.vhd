-- Simple OR gate design
library IEEE;
use IEEE.std_logic_1164.all;

entity aula1 is
port(
  a: in std_logic;
  b: in std_logic;
  c: in std_logic;
  d: in std_logic;
  e: in std_logic;
  q: out std_logic);
end aula1;

architecture rtl of aula1 is
begin
  process(a, b, c, d, e) is
  begin
    q <= (a or b) and c and (d or e);
  end process;
end rtl;
