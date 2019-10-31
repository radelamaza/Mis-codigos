library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( a        : in  std_logic_vector (11 downto 0);   -- Primer operando.
           b        : in  std_logic_vector (11 downto 0);   -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);    -- Selector de la operaci�n.
           c        : out std_logic;                        -- Se�al de 'carry'.
           z        : out std_logic;                        -- Se�al de 'zero'.
           n        : out std_logic;                        -- Se�al de 'nagative'.
           o        : out std_logic;
           result   : out std_logic_vector (11 downto 0));  -- Resultado de la operaci�n.
end ALU;

architecture Behavioral of ALU is

component AddSu12 
    Port ( a        : in  std_logic_vector (11 downto 0);
           b        : in  std_logic_vector (11 downto 0);
           ci       : in  std_logic;
           sub      : in  std_logic;
           s        : out std_logic_vector (11 downto 0);
           co       : out std_logic);
    end component;

signal suma : std_logic_vector(11 downto 0);
signal alu_result   : std_logic_vector(11 downto 0);
signal sub          : std_logic;
signal adi          : std_logic;
signal co           : std_logic;
signal c1           : std_logic;
signal c2           : std_logic;
signal c3           : std_logic;
signal c4           : std_logic;
signal p1           : std_logic;
signal p2           : std_logic;
signal p3           : std_logic;
signal p4           : std_logic;

begin

sub <= not sop(2) and not sop(1) and sop(0);
adi <= not sop(2) and not sop(1) and not sop(0);
          
with sop select
  alu_result <= suma when "000",
                suma when "001",
                a and b when "010",
                a or  b when "011",
                a xor b when "100",
                not a when "101",
                '0' & a(11 downto 1) when "110",
                a(10 downto 0) & '0' when "111";

with sop select
     c      <=  co when "000",
                co when "001",
                a(0) when "110",
                a(11)when "111",
                '0' when others;

with alu_result select
     z      <=  '1' when "000000000000",
                '0' when others;                

with sub select
     n      <=  not co when '1',
                '0' when others;  

p1 <= not a(11) and not b(11) and alu_result(11);
p2 <=  a(11) and b(11) and not alu_result(11);
p3 <= not a(11) and b(11) and alu_result(11);
p4 <=  a(11) and not b(11) and not alu_result(11);

c1 <= p1 and adi;
c2 <= p2 and adi;
c3 <= p3 and sub;
c4 <= p4 and sub;

o <= c1 or c2 or c3 or c4;

result <= alu_result;

inst_AddSu12: AddSu12 port map(
        a      =>a,
        b      =>b,
        ci     =>sub,
        sub    =>sub,
        s      =>suma,
        co     =>co
    );
    
end Behavioral;
