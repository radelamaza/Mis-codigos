library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( a        : in  std_logic_vector (15 downto 0);   -- Primer operando.
           b        : in  std_logic_vector (15 downto 0);   -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);    -- Selector de la operación.
           c        : out std_logic;                        -- Señal de 'carry'.
           z        : out std_logic;                        -- Señal de 'zero'.
           n        : out std_logic;                        -- Señal de 'nagative'.
           result   : out std_logic_vector (15 downto 0));  -- Resultado de la operación.
end ALU;

architecture Behavioral of ALU is

component ADDER --componente que hace la suma entre las 2 palabras de 16 bits
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           ci : in STD_LOGIC := '0'; -- el primer carry para el primer FA es 0
           s : out STD_LOGIC_VECTOR (15 downto 0);
           c : out STD_LOGIC);
    end component;
    
component SUBSTRACTOR --componente que hace la resta entre las 2 palabras de 16 bits
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           ci : in STD_LOGIC := '0'; -- el primer carry para el primer FA es 0
           s : out STD_LOGIC_VECTOR (15 downto 0);
           c : out STD_LOGIC);
    end component;
    
component LEFT_SHIFTER --componente que hace shift left de la palabra de 16 bits
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           z : in STD_LOGIC := '0'; --variable inicializada como 0
           lsa : out STD_LOGIC_VECTOR (15 downto 0);
           lsc : out STD_LOGIC);
    end component;
    
component RIGHT_SHIFTER --componente que hace shift right de la palabra de 16 bits
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           z : in STD_LOGIC := '0';
           rsa : out STD_LOGIC_VECTOR (15 downto 0);
           rsc : out STD_LOGIC);
    end component;

signal aux_result : std_logic_vector (15 downto 0); --señal auxiliar intermedia entre salida de componentes y 'result'

signal suma : std_logic_vector (15 downto 0); --señales para conectar el resultado de ADDER con las salidas de la ALU
signal c_suma : std_logic; 

signal resta : std_logic_vector (15 downto 0); --señales para conectar el resultado de SUBSTRACTOR con las salidas de la ALU
signal c_resta : std_logic;

signal lshift : std_logic_vector (15 downto 0); --señal para conectar el resultado de LEFT_SHIFTER con las salidas de la ALU
signal c_lshift : std_logic;

signal rshift : std_logic_vector (15 downto 0); --señal para conectar el resultado de RIGHT_SHIFTER con las salidas de la ALU
signal c_rshift : std_logic;

begin

inst_ADDER: ADDER port map(
           a         => a, --a de la ALU
           b         => b, --b de la ALU
           ci        => '0', --NO SE SI ES VALIDO
           s         => suma, --señal suma para conectar con 'aux_result'
           c         => c_suma --señal para el carry de la ALU
     );
     
inst_SUBSTRACTOR: SUBSTRACTOR port map(
           a         => a, --a de la ALU
           b         => b, --b de la ALU
           ci        => '0', 
           s         => resta, --señal resta para conectar con 'aux_result'
           c         => c_resta --señal para el carry de la ALU
     );
     
inst_LSHIFTER: LEFT_SHIFTER port map(
           a         => a, --a de la ALU
           z         => '0', 
           lsa       => lshift, --señal lshift para conectar con 'aux_result'
           lsc       => c_lshift
     );
     
inst_RSHIFTER: RIGHT_SHIFTER port map(
           a         => a, --a de la ALU
           z         => '0',
           rsa       => rshift, --señal rshift para conectar con 'aux_result'
           rsc       => c_rshift
     );

with sop select --REVISAR COMO HACER PARA LAS INSTANCIAS DE LOS COMPONENTES (CUAL USAR EN QUE MOMENTO)
    aux_result <= a and b when "011", --se define el resultado de aux_result dependiendo de la operación deseada
              a xor b when "100",
              not a when "110",
              a or b when "000",
              suma when "001",
              resta when "010",
              lshift when "101",
              rshift when "111";
              
with sop select --se define el carry de la ALU a partir de la operación deseada
    c <= '0' when "011",
         '0' when "100",
         '0' when "110",
         '0' when "000",
         c_suma when "001",
         c_resta when "010",
         c_lshift when "101",
         c_rshift when "111";
         
with aux_result select --se define el zero flag a partir del valor de la señal 'aux_result'
    z <= '1' when "0000000000000000",
         '0' when others;
         
n <= aux_result(15); 

result <= aux_result; --el resultado va a ser 'aux_result' después de todas las operaciones hechas
           
    
end Behavioral;
