----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2019 00:15:01
-- Design Name: 
-- Module Name: LEFT_SHIFTER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LEFT_SHIFTER is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           z : in STD_LOGIC := '0'; --variable inicializada como 0
           lsa : out STD_LOGIC_VECTOR (15 downto 0);
           lsc : out STD_LOGIC);
end LEFT_SHIFTER;

architecture Behavioral of LEFT_SHIFTER is

begin

lsa(0) <= z; --se hace left shift de la variable de input de 16 bits
lsa(1) <= a(0);
lsa(2) <= a(1);
lsa(3) <= a(2);
lsa(4) <= a(3);
lsa(5) <= a(4);
lsa(6) <= a(5);
lsa(7) <= a(6);
lsa(8) <= a(7);
lsa(9) <= a(8);
lsa(10) <= a(9);
lsa(11) <= a(10);
lsa(12) <= a(11);
lsa(13) <= a(12);
lsa(14) <= a(13);
lsa(15) <= a(14);
lsc <= a(15);


end Behavioral;
