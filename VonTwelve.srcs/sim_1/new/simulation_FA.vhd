library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity simulation_FA is
--  Port ( );
end simulation_FA;

architecture Behavioral of simulation_FA is

component FA
    Port (
         a : in STD_LOGIC;
              b : in STD_LOGIC;
              ci : in STD_LOGIC;
              s : out STD_LOGIC;
              c : out STD_LOGIC
          );
    end component;
 
signal test            : std_logic_vector(2 downto 0);
signal out1            : std_logic;
signal out2            : std_logic;

begin

process 
begin
    test <= "100";
    wait for 100 ns;
    test <= "001";
    wait for 100 ns;
    test <= "010";
    wait for 100 ns;
    wait;

end process;

inst_FA: FA port map(
    a => test(0),
    b => test(1),
    ci => test(2),
    s => out1,
    c => out2
    );


end Behavioral;
