library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (15 downto 0);  -- SeÃ±ales de entrada de los interruptores -- Arriba   = '1'   -- Los 3 swiches de la derecha: 2, 1 y 0.
        btn         : in   std_logic_vector (4 downto 0);  -- SeÃ±ales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (15 downto 0);  -- SeÃ±ales de salida  a  los leds          -- Prendido = '1'   -- Los 4 leds de la derecha: 3, 2, 1 y 0.
        clk         : in   std_logic;                      -- No Tocar - SeÃ±al de entrada del clock   -- Frecuencia = 100Mhz.
        seg         : out  std_logic_vector (7 downto 0);  -- No Tocar - Salida de las seÃ±ales de segmentos.
        an          : out  std_logic_vector (3 downto 0)   -- No Tocar - Salida del selector de diplay.
          );
end Basys3;

architecture Behavioral of Basys3 is

-- Inicio de la declaración de los componentes.

component Clock_Divider -- No Tocar
    Port (
        clk         : in    std_logic;
        speed       : in    std_logic_vector (1 downto 0);
        clock       : out   std_logic
          );
    end component;
    
component Display_Controller  -- No Tocar
    Port (  
        dis_a       : in    std_logic_vector (3 downto 0);
        dis_b       : in    std_logic_vector (3 downto 0);
        dis_c       : in    std_logic_vector (3 downto 0);
        dis_d       : in    std_logic_vector (3 downto 0);
        clk         : in    std_logic;
        seg         : out   std_logic_vector (7 downto 0);
        an          : out   std_logic_vector (3 downto 0)
          );
    end component;

component Debouncer  -- No Tocar
    Port (
        clk         : in    std_logic;
        datain      : in    std_logic_vector (4 downto 0);
        dataout     : out   std_logic_vector (4 downto 0));
    end component;

component Reg
    Port (
        clock       : in    std_logic;
        load        : in    std_logic;
        up          : in    std_logic;
        down        : in    std_logic;
        datain      : in    std_logic_vector (15 downto 0);
        dataout     : out   std_logic_vector (15 downto 0)
          );
    end component;

component ALU
    Port (
         a        : in  std_logic_vector (15 downto 0);   -- Primer operando.
         b        : in  std_logic_vector (15 downto 0);   -- Segundo operando.
         sop      : in  std_logic_vector (2 downto 0);    -- Selector de la operaci�n.
         c        : out std_logic;                        -- Se�al de 'carry'.
         z        : out std_logic;                        -- Se�al de 'zero'.
         n        : out std_logic;                        -- Se�al de 'nagative'.
         result   : out std_logic_vector (15 downto 0));  -- Resultado de la operaci�n.
    end component;
    
component PC 
    Port (  
        clock       : in    std_logic;
        load        : in    std_logic;
        datain      : in    std_logic_vector (11 downto 0);
        dataout     : out   std_logic_vector (11 downto 0)
          );
    end component;

component ROM
    Port (  
        address     : in    std_logic_vector (11 downto 0);
        dataout     : out   std_logic_vector (32 downto 0)
          );
    end component;

component RAM
    Port (  
        clock       : in    std_logic;
        write       : in    std_logic;
        address     : in    std_logic_vector (11 downto 0);
        datain      : in    std_logic_vector (15 downto 0);
        dataout     : out   std_logic_vector (15 downto 0)
          );
    end component;
 
 component Status
        Port (  
            clock       : in    std_logic;
            c           : in    std_logic;
            z           : in    std_logic;
            n           : in    std_logic;
            dataout     : out   std_logic_vector (2 downto 0)
              );
        end component;
 component CUT 
    Port ( entrada : in STD_LOGIC_VECTOR(16 DOWNTO 0);
           status: in STD_LOGIC_VECTOR(2 DOWNTO 0);
           enable_a : out STD_LOGIC;
           enable_b : out STD_LOGIC;
           sel_a: out STD_LOGIC_VECTOR (1 DOWNTO 0);
           sel_b : out STD_LOGIC_VECTOR (1 DOWNTO 0);
           loadPC : out STD_LOGIC;
           selALU :  out STD_LOGIC_VECTOR (2 DOWNTO 0);
           W : out STD_LOGIC);      
end component;

component MB
    Port ( cero : in STD_LOGIC_VECTOR (15 downto 0);  --  0's
           ram : in STD_LOGIC_VECTOR (15 downto 0);   --  memoria RAM
           sel_b : in STD_LOGIC_VECTOR (1 downto 0);   -- proviende de la control unit
           lit : in STD_LOGIC_VECTOR (15 downto 0);   -- Entrada  desde la ROM
           regB : in STD_LOGIC_VECTOR (15 downto 0);    --  registro B
           muxb : out STD_LOGIC_VECTOR (15 downto 0)); -- Salida 
end component;

component MA is
    Port ( regA : in STD_LOGIC_VECTOR (15 downto 0);
           cero : in STD_LOGIC_VECTOR (15 downto 0);
           uno : in STD_LOGIC_VECTOR (15 downto 0);
           sel_a : in STD_LOGIC_VECTOR (1 downto 0); 
           muxa : out STD_LOGIC_VECTOR (15 downto 0));
end component;
-- Fin de la declaraciÃ³n de los componentes.

-- Inicio de la declaraciÃ³n de seÃ±ales.

signal clock            : std_logic := '0';                     -- SeÃ±al del clock reducido.                 
            
signal dis_a            : std_logic_vector(3 downto 0) := (others => '0');  -- SeÃ±ales de salida al display A.    
signal dis_b            : std_logic_vector(3 downto 0) := (others => '0');  -- SeÃ±ales de salida al display B.     
signal dis_c            : std_logic_vector(3 downto 0) := (others => '0');  -- SeÃ±ales de salida al display C.    
signal dis_d            : std_logic_vector(3 downto 0) := (others => '0');  -- SeÃ±ales de salida al display D.  
signal enable_b         : STD_LOGIC;
signal enable_a         : STD_LOGIC;
signal W                : STD_LOGIC;
signal loadPC           : std_logic;
signal sel_a            : STD_LOGIC_VECTOR (1 downto 0);
signal sel_b            : STD_LOGIC_VECTOR (1 downto 0);
signal selALU           : STD_LOGIC_VECTOR (2 DOWNTO 0);
signal status_out       : std_logic_vector (2 downto 0);
signal rom_out          : std_logic_vector (32 downto 0);
signal smux             : std_logic_vector (15 downto 0);
signal scu              : std_logic_vector (16 downto 0);
signal ram_out          : std_logic_vector (15 downto 0);
signal pc_out           : std_logic_vector(11 downto 0);
signal d_btn            : std_logic_vector(4 downto 0) := (others => '0');  -- SeÃ±ales de botones con antirrebote.
signal resultAlU        : std_logic_vector(15 downto 0);
signal c                : std_logic;
signal z                : std_logic;
signal n                : std_logic;
signal in_pc            : std_logic_vector (11 downto 0);
signal outA             : std_logic_vector (15 downto 0);
signal outB             : std_logic_vector (15 downto 0);
signal muxa_out             :STD_LOGIC_VECTOR (15 downto 0);
signal muxb_out            :STD_LOGIC_VECTOR (15 downto 0);
-- Fin de la declaraciÃ³n de los seÃ±ales.

begin


-- Inicio de declaraciÃ³n de comportamientos.

led <= sw;
dis_a <= outB (7 downto 4);            --btn(0);
dis_b <= outB (3 downto 0);            --btn(1);
dis_c<= outA (7 downto 4);             --btn(2);
dis_d<= outA (3 downto 0);           --btn(3);
smux <= rom_out(15 downto 0);
scu <= rom_out(32 downto 16);
in_pc <= rom_out (11 downto 0);
-- Inicio de declaraciÃ³n de instancias.

inst_Clock_Divider: Clock_Divider port map( -- No Tocar - Intancia de Clock_Divider.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    speed       => "01", -- Selector de velocidad: "00" full, "01" fast, "10" normal y "11" slow. 
    clock       => clock -- No Tocar - Salida del clock reducido: 25Mhz, 8hz, 2hz y 0.5hz.
    );

inst_Display_Controller: Display_Controller port map( -- No Tocar - Intancia de Display_Controller.
    dis_a       => dis_a,-- No Tocar - Entrada de seÃ±ales para el display A.
    dis_b       => dis_b,-- No Tocar - Entrada de seÃ±ales para el display B.
    dis_c       => dis_c,-- No Tocar - Entrada de seÃ±ales para el display C.
    dis_d       => dis_d,-- No Tocar - Entrada de seÃ±ales para el display D.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    seg         => seg,  -- No Tocar - Salida de las seÃ±ales de segmentos.
    an          => an    -- No Tocar - Salida del selector de diplay.
	);

inst_Debouncer: Debouncer port map( -- No Tocar - Intancia de Debouncer.
    clk         => clk,   -- No Tocar - Entrada del clock completo (100Mhz).
    datain      => btn,   -- No Tocar - Entrada del botones con rebote.
    dataout     => d_btn  -- No Tocar - Salida de botones con antirrebote.
    );

inst_ALU: ALU port map(
         a       => muxa_out,
         b       => muxb_out,
         sop     => selALU,
         c       => c,                        -- Se�al de 'carry'.
         z       => z,                        -- Se�al de 'zero'.
         n       => n,              -- Se�al de 'nagative'.
         result  => resultALU
         );  -- Resultado de la operaci�n.

inst_RAM: RAM port map(
        clock      => clock,
        write       => W,
        address     => in_pc,
        datain     => resultALU,
        dataout    => ram_out
          );

inst_PC: PC port map(
        clock     => clock,
        load      => loadPC,
        datain    => in_pc,
        dataout   => pc_out
          );
inst_ROM: ROM port map(
        address   => pc_out,
        dataout   => rom_out
        );

inst_RegA: Reg port map(
        clock   => clock,
        load   => enable_a,
        up    => '0',
        down  => '0',
        datain  => resultAlU,
        dataout  => outA
);	
inst_RegB: Reg port map(
        clock   => clock,
        load   => enable_b,
        up    => '0',
        down  => '0',
        datain  => resultAlu,
        dataout  => outB
);	
inst_CU: CUT port map(  
           entrada => scu,
           status => status_out,
           enable_a => enable_a,
           enable_b => enable_b,
           sel_a => sel_a,
           sel_b => sel_b,
           loadPC => loadPC,
           selALU => selALU,
           W => W
           );
 
inst_MUXB: MB port map(
           cero => "0000000000000000",
           ram => ram_out,   --  memoria RAM
           sel_b => sel_b,   -- proviende de la control unit
           lit => smux,  -- Entrada  desde la ROM
           regB => outB,    --  registro B
           muxb => muxb_out
            );
inst_MUXA: MA port map(
           cero => "0000000000000000",
           uno  => "0000000000000001",
           sel_a => sel_a,   -- proviende de la control unit
           regA => outA,    --  registro B
           muxa => muxa_out
            );
inst_status: Status port map(
            clock     => clock,
            c         => c,
            z         => z,
            n         => n,
            dataout   => status_out
              );
        
-- Fin de declaraciÃ³n de instancias.

-- Fin de declaraciÃ³n de comportamientos.
  
end Behavioral;
