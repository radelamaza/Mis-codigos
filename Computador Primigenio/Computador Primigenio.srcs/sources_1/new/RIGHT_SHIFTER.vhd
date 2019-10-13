----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2019 00:29:57
-- Design Name: 
-- Module Name: RIGHT_SHIFTER - Behavioral
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

entity RIGHT_SHIFTER is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           z : in STD_LOGIC := '0';
           rsa : out STD_LOGIC_VECTOR (15 downto 0);
           rsc : out STD_LOGIC);
end RIGHT_SHIFTER;

architecture Behavioral of RIGHT_SHIFTER is

begin

rsc <= a(0);
rsa(0) <= a(1); --se hace right shift de la variable de input de 16 bits
rsa(1) <= a(2);
rsa(2) <= a(3);
rsa(3) <= a(4);
rsa(4) <= a(5);
rsa(5) <= a(6);
rsa(6) <= a(7);
rsa(7) <= a(8);
rsa(8) <= a(9);
rsa(9) <= a(10);
rsa(10) <= a(11);
rsa(11) <= a(12);
rsa(12) <= a(13);
rsa(13) <= a(14);
rsa(14) <= a(15);
rsa(15) <= z;


end Behavioral;
