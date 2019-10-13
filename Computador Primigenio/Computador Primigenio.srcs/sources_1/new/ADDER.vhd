----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2019 21:33:08
-- Design Name: 
-- Module Name: ADDER - Behavioral
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

entity ADDER is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           ci : in STD_LOGIC := '0'; -- el primer carry para el primer FA es 0
           s : out STD_LOGIC_VECTOR (15 downto 0);
           c : out STD_LOGIC);
end ADDER;

architecture Behavioral of ADDER is

component FA
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           ci : in STD_LOGIC;
           s : out STD_LOGIC;
           c : out STD_LOGIC);
    end component; 
    
signal c1 : std_logic;
signal c2 : std_logic;
signal c3 : std_logic;
signal c4 : std_logic;
signal c5 : std_logic;
signal c6 : std_logic;
signal c7 : std_logic;
signal c8 : std_logic;
signal c9 : std_logic;
signal c10 : std_logic;
signal c11 : std_logic;
signal c12 : std_logic;
signal c13 : std_logic;
signal c14 : std_logic;
signal c15 : std_logic;

begin

inst_FA: FA port map(
        a      =>a(0),
        b      =>b(0), --que pasa con ci? RESOLVER
        ci     =>ci, -- el primer carry para el primer FA es 0
        s      =>s(0),
        c      =>c1
    );
    
inst_FA2: FA port map(
        a      =>a(1),
        b      =>b(1), 
        ci     =>c1,
        s      =>s(1),
        c      =>c2
    );
    
inst_FA3: FA port map(
        a      =>a(2),
        b      =>b(2), 
        ci     =>c2,
        s      =>s(2),
        c      =>c3
    );
    
inst_FA4: FA port map(
        a      =>a(3),
        b      =>b(3), 
        ci     =>c3,
        s      =>s(3),
        c      =>c4
    );

inst_FA5: FA port map(
        a      =>a(4),
        b      =>b(4), 
        ci     =>c4,
        s      =>s(4),
        c      =>c5
    );
    
inst_FA6: FA port map(
        a      =>a(5),
        b      =>b(5), 
        ci     =>c5,
        s      =>s(5),
        c      =>c6
    );
    
inst_FA7: FA port map(
        a      =>a(6),
        b      =>b(6), 
        ci     =>c6,
        s      =>s(6),
        c      =>c7
    );

inst_FA8: FA port map(
        a      =>a(7),
        b      =>b(7), 
        ci     =>c7,
        s      =>s(7),
        c      =>c8
    );
    
inst_FA9: FA port map(
        a      =>a(8),
        b      =>b(8), 
        ci     =>c8,
        s      =>s(8),
        c      =>c9
    );
    
inst_FA10: FA port map(
        a      =>a(9),
        b      =>b(9), 
        ci     =>c9,
        s      =>s(9),
        c      =>c10
    );
    
inst_FA11: FA port map(
        a      =>a(10),
        b      =>b(10), 
        ci     =>c10,
        s      =>s(10),
        c      =>c11
    );
    
inst_FA12: FA port map(
        a      =>a(11),
        b      =>b(11), 
        ci     =>c11,
        s      =>s(11),
        c      =>c12
    );
    
inst_FA13: FA port map(
        a      =>a(12),
        b      =>b(12), 
        ci     =>c12,
        s      =>s(12),
        c      =>c13
    );
   
inst_FA14: FA port map(
        a      =>a(13),
        b      =>b(13), 
        ci     =>c13,
        s      =>s(13),
        c      =>c14
    );
    
inst_FA15: FA port map(
        a      =>a(14),
        b      =>b(14), 
        ci     =>c14,
        s      =>s(14),
        c      =>c15
    );
    
 inst_FA16: FA port map(
        a      =>a(15),
        b      =>b(15), 
        ci     =>c15,
        s      =>s(15),
        c      =>c
    );

end Behavioral;
