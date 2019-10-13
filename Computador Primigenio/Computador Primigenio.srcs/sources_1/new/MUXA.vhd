----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2019 14:33:29
-- Design Name: 
-- Module Name: MUXA - Behavioral
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

entity MA is
    Port ( regA : in STD_LOGIC_VECTOR (15 downto 0);
           cero : in STD_LOGIC_VECTOR (15 downto 0);
           uno : in STD_LOGIC_VECTOR (15 downto 0);
           sel_a : in STD_LOGIC_VECTOR (1 downto 0); 
           muxa : out STD_LOGIC_VECTOR (15 downto 0));
end MA;

architecture Behavioral of MA is

begin

-- Elijo la salida del  mux
with sel_a select
    muxa <= cero when "00", -- Cuando la control unit envía "00" la salida es el bus de datos con solo 0's
            regA   when "01", -- Cuando la control unit envía "10" la salida es el valor del registro B
            uno  when "11", -- Cuando la control unit envía "11" la salida es el valor del literal que entró desde la ROM
            "0000000000000000" when "10";

end Behavioral;
