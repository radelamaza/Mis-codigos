
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CUT is
    Port ( entrada : in STD_LOGIC_VECTOR (16 DOWNTO 0);
           status : in STD_LOGIC_VECTOR (2 DOWNTO 0);
           enable_a : out STD_LOGIC;
           enable_b : out STD_LOGIC;
           sel_a : out STD_LOGIC_VECTOR (1 DOWNTO 0);
           sel_b : out STD_LOGIC_VECTOR (1 DOWNTO 0);
           loadPC : out STD_LOGIC;
           selALU :  out STD_LOGIC_VECTOR (2 DOWNTO 0);
           W : out STD_LOGIC);      
end CUT;

architecture Behavioral of CUT is

signal salida : STD_LOGIC_VECTOR(10 DOWNTO 0);
signal jeq :  STD_LOGIC_VECTOR(10 DOWNTO 0);
signal jne :  STD_LOGIC_VECTOR(10 DOWNTO 0);
signal jgt :  STD_LOGIC_VECTOR(10 DOWNTO 0);
signal jge :  STD_LOGIC_VECTOR(10 DOWNTO 0);
signal jlt :  STD_LOGIC_VECTOR(10 DOWNTO 0);
signal jle :  STD_LOGIC_VECTOR(10 DOWNTO 0);
signal jcr :  STD_LOGIC_VECTOR(10 DOWNTO 0);

begin

with status select 
    jeq <= 
        "00001110000" when "010",
        "00001110000" when "110",
        "00001110000" when "011",
        "00001110000" when "111",
        "00000000000" when others;
with status select 
    jne <= 
        "00001110000" when "000",
        "00001110000" when "100",
        "00001110000" when "001",
        "00001110000" when "101",
        "00000000000" when others;
with status select 
    jgt <= 
        "00001110000" when "000",
        "00001110000" when "100",
        "00000000000" when others;
with status select 
    jlt <= 
        "00001110000" when "001",
        "00001110000" when "101",
        "00001110000" when "011",
        "00001110000" when "111",
        "00000000000" when others;
with status select 
    jge <= 
        "00001110000" when "000",
        "00001110000" when "100",
        "00001110000" when "010",
        "00001110000" when "110",
        "00000000000" when others;
with status select 
    jle <= 
        "00001110000" when "011",
        "00001110000" when "111",
        "00001110000" when "101",
        "00001110000" when "110",
        "00001110000" when "001",
        "00001110000" when "010",
        "00000000000" when others;
with status select 
    jcr <= 
        "00001110000" when "100",
        "00001110000" when "101",
        "00001110000" when "110",
        "00001110000" when "111",
        "00000000000" when others;
        

with entrada(5 downto 0) select

    salida <=  --mov
     "10000100010" when "000001",
     "01010000010" when "000010",
     "10001000010" when "000011",
     "01001000010" when "000100",
     "10001100010" when "000101",
     "01001100010" when "000110",
     "00010000011" when "000111",
     "00000100011" when "001000",
    --add
     "10010100010" when "001001",
     "01010100010" when "001010",
     "10011000010" when "001011",
     "01011000010" when "001100",
     "10011100010" when "001101",
     "01011100010" when "001110",
     "00010100011" when "001111",
     --sub
     "10010100100" when "010000",
     "01010100100" when "010001",
     "10011000100" when "010010",
     "01011000100" when "010011",
     "10011100100" when "010100",
     "01011100100" when "010101",
     "00010100101" when "010110",
     --and
     "10010100110" when "010111",
     "01010100110" when "011000",
     "10011000110" when "011001",
     "01011000110" when "011010",
     "10011100110" when "011011",
     "01011100110" when "011100",
     "00010100111" when "011101",
     --or
     "10010100000" when "011110",
     "01010100000" when "011111",
     "10011000000" when "100000",
     "01011000000" when "100001",
     "10011100000" when "100010",
     "01011100000" when "100011",
     "00010100001" when "100100",
     --xor
     "10010101000" when "100101",
     "01010101000" when "100110",
     "10011001000" when "100111",
     "01011001000" when "101000",
     "10011101000" when "101001",
     "01011101000" when "101010",
     "00010101001" when "101011",
     --not
     "10010001100" when "101100",
     "01010001100" when "101101",
     "00010001101" when "101110",
     --shl
     "10010001010" when "101111",
     "01010001010" when "110000",
     "00010001011" when "110001",
     --shr
     "10010001110" when "110010",
     "01010001110" when "110011",
     "00010001111" when "110100",
     --nop
     "00000000000" when "000000",
     --inc
     "01110100010" when "110101",
     --cmp
     "00010100100" when "110110",
     "00011000100" when "110111",
     --js
     "00001110000" when "111000",--jmp
     jeq when "111001",--jeq
     jne when "111010",--jne
     jgt when "111011",--jgt
     jge when "111100",--jge
     jlt when "111101",--jlt
     jle when "111110",--jle
     jcr when "111111";--jcr

enable_a <= salida(10);
enable_b <= salida(9);
sel_a <= salida(8 downto 7);
sel_b <= salida(6 downto 5);
loadPC <= salida(4);
selALU <= salida(3 downto 1);
W <= salida (0);
end Behavioral;
