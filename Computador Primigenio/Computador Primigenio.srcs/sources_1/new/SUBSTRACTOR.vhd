----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2019 23:14:03
-- Design Name: 
-- Module Name: SUBSTRACTOR - Behavioral
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

entity SUBSTRACTOR is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           ci : in STD_LOGIC := '0'; -- el primer carry para el primer FA es 0
           s : out STD_LOGIC_VECTOR (15 downto 0);
           c : out STD_LOGIC);
end SUBSTRACTOR;

architecture Behavioral of SUBSTRACTOR is

component NOT_GATE
    Port ( a : in STD_LOGIC;
           na : out STD_LOGIC);
    end component;

component FA
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           ci : in STD_LOGIC;
           s : out STD_LOGIC;
           c : out STD_LOGIC);
    end component; 

signal n1 : std_logic; --conexiones con negaciones
signal n2 : std_logic;    
signal n3 : std_logic;    
signal n4 : std_logic;    
signal n5 : std_logic;    
signal n6 : std_logic;    
signal n7 : std_logic;    
signal n8 : std_logic;    
signal n9 : std_logic;    
signal n10 : std_logic;    
signal n11 : std_logic;    
signal n12 : std_logic;    
signal n13 : std_logic;    
signal n14 : std_logic;    
signal n15 : std_logic;    
signal n16 : std_logic;    
    
signal c1 : std_logic; --conexiones entre FAs (carry)
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

inst_NOT: NOT_GATE port map(
        a      =>b(0),
        na     =>n1
    );

inst_FA: FA port map(
        a      =>a(0),
        b      =>n1, 
        ci     =>ci, --que pasa con ci? RESOLVER -- el primer carry para el primer FA es 0
        s      =>s(0),
        c      =>c1
    );
 
inst_NOT2: NOT_GATE port map(
        a      =>b(1),
        na     =>n2
    );

    
inst_FA2: FA port map(
        a      =>a(1),
        b      =>n2, 
        ci     =>c1,
        s      =>s(1),
        c      =>c2
    );
    
inst_NOT3: NOT_GATE port map(
        a      =>b(2),
        na     =>n3
    );

    
inst_FA3: FA port map(
        a      =>a(2),
        b      =>n3, 
        ci     =>c2,
        s      =>s(2),
        c      =>c3
    );

inst_NOT4: NOT_GATE port map(
        a      =>b(3),
        na     =>n4
    );

    
inst_FA4: FA port map(
        a      =>a(3),
        b      =>n4, 
        ci     =>c3,
        s      =>s(3),
        c      =>c4
    );
    
inst_NOT5: NOT_GATE port map(
        a      =>b(4),
        na     =>n5
    );


inst_FA5: FA port map(
        a      =>a(4),
        b      =>n5, 
        ci     =>c4,
        s      =>s(4),
        c      =>c5
    );
    
inst_NOT6: NOT_GATE port map(
        a      =>b(5),
        na     =>n6
    );

    
inst_FA6: FA port map(
        a      =>a(5),
        b      =>n6, 
        ci     =>c5,
        s      =>s(5),
        c      =>c6
    );
    
inst_NOT7: NOT_GATE port map(
        a      =>b(6),
        na     =>n7
    );

    
inst_FA7: FA port map(
        a      =>a(6),
        b      =>n7, 
        ci     =>c6,
        s      =>s(6),
        c      =>c7
    );
    
inst_NOT8: NOT_GATE port map(
        a      =>b(7),
        na     =>n8
    );


inst_FA8: FA port map(
        a      =>a(7),
        b      =>n8, 
        ci     =>c7,
        s      =>s(7),
        c      =>c8
    );
    
inst_NOT9: NOT_GATE port map(
        a      =>b(8),
        na     =>n9
    );

    
inst_FA9: FA port map(
        a      =>a(8),
        b      =>n9, 
        ci     =>c8,
        s      =>s(8),
        c      =>c9
    );
    
inst_NOT10: NOT_GATE port map(
        a      =>b(9),
        na     =>n10
    );

    
inst_FA10: FA port map(
        a      =>a(9),
        b      =>n10, 
        ci     =>c9,
        s      =>s(9),
        c      =>c10
    );
    
inst_NOT11: NOT_GATE port map(
        a      =>b(10),
        na     =>n11
    );

    
inst_FA11: FA port map(
        a      =>a(10),
        b      =>n11, 
        ci     =>c10,
        s      =>s(10),
        c      =>c11
    );
    
inst_NOT12: NOT_GATE port map(
        a      =>b(11),
        na     =>n12
    );

    
inst_FA12: FA port map(
        a      =>a(11),
        b      =>n12, 
        ci     =>c11,
        s      =>s(11),
        c      =>c12
    );
    
inst_NOT13: NOT_GATE port map(
        a      =>b(12),
        na     =>n13
    );

    
inst_FA13: FA port map(
        a      =>a(12),
        b      =>n13, 
        ci     =>c12,
        s      =>s(12),
        c      =>c13
    );
    
inst_NOT14: NOT_GATE port map(
        a      =>b(13),
        na     =>n14
    );

   
inst_FA14: FA port map(
        a      =>a(13),
        b      =>n14, 
        ci     =>c13,
        s      =>s(13),
        c      =>c14
    );
    
inst_NOT15: NOT_GATE port map(
        a      =>b(14),
        na     =>n15
    );

    
inst_FA15: FA port map(
        a      =>a(14),
        b      =>n15, 
        ci     =>c14,
        s      =>s(14),
        c      =>c15
    );
    
inst_NOT16: NOT_GATE port map(
        a      =>b(15),
        na     =>n16
    );

    
 inst_FA16: FA port map(
        a      =>a(15),
        b      =>n16, 
        ci     =>c15,
        s      =>s(15),
        c      =>c
    );


end Behavioral;
