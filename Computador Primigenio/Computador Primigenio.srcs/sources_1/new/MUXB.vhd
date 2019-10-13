library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MB is
    Port ( cero : in STD_LOGIC_VECTOR (15 downto 0);  --  0's
           ram : in STD_LOGIC_VECTOR (15 downto 0);   --  memoria RAM
           sel_b : in STD_LOGIC_VECTOR (1 downto 0);   -- proviende de la control unit
           lit : in STD_LOGIC_VECTOR (15 downto 0);   -- Entrada  desde la ROM
           regB : in STD_LOGIC_VECTOR (15 downto 0);    --  registro B
           muxb : out STD_LOGIC_VECTOR (15 downto 0)); -- Salida 
end MB;

architecture Behavioral of MB is

begin

-- Elijo la salida del  mux
with sel_b select
    muxb <= cero when "00", 
            ram  when "11", 
            regB   when "01", 
            lit  when "10"; 


end Behavioral;
