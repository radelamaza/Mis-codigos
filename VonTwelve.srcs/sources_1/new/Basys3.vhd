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
        datain      : in    std_logic_vector (11 downto 0);
        dataout     : out   std_logic_vector (11 downto 0)
          );
    end component;

component PC 
    Port (  
        clock       : in    std_logic;
        load        : in    std_logic;
        stalling    : in    std_logic;
        datain      : in    std_logic_vector (11 downto 0);
        dataout     : out   std_logic_vector (11 downto 0)
          );
    end component;
 
 component Status
        Port (  
            clock       : in    std_logic;
            c           : in    std_logic;
            z           : in    std_logic;
            n           : in    std_logic;
            o           : in    std_logic;
            dataout     : out   std_logic_vector (3 downto 0)
              );
        end component;
 
 component SP 
       Port ( 
            clock    : in  std_logic;
            load     : in  std_logic;                       
            up       : in  std_logic;
            down     : in  std_logic;
            datain   : in  std_logic_vector (11 downto 0);
            dataout  : out std_logic_vector (11 downto 0)
              );
      end component;

 component BP 
       Port ( 
            clock    : in  std_logic;
            load       : in  std_logic;
            datain   : in  std_logic_vector (11 downto 0);  
            dataout  : out std_logic_vector (11 downto 0)
              );
      end component;

 component RegisterCU 
       Port ( clock    : in  std_logic;                        -- Se�al del clock (reducido).
            datain   : in  std_logic_vector (11 downto 0);   -- Se�ales de entrada de datos.
            dataout  : out std_logic_vector (11 downto 0);
            lit : out std_logic_vector (11 downto 0);
            selAddSec      : out std_logic;
            stalling      : out std_logic);  
      end component;

component ALU 
    Port (  
        a        : in  std_logic_vector (11 downto 0);   -- Primer operando.
        b        : in  std_logic_vector (11 downto 0);   -- Segundo operando.
        sop      : in  std_logic_vector (2 downto 0);    
        c        : out std_logic;                        -- Señal de 'carry'.
        z        : out std_logic;                        -- Señal de 'zero'.
        n        : out std_logic;                        -- Señal de 'nagative'.
        o        : out std_logic;
        result   : out std_logic_vector (11 downto 0)
          );
    end component;

component MainMemory
    Port (
    clock       : in   std_logic;
    write       : in   std_logic;
    address     : in   std_logic_vector (11 downto 0);
    datain      : in   std_logic_vector (11 downto 0);
    dataout     : out  std_logic_vector (11 downto 0)
      );
end component;

component CU
    Port (
    op           : in   std_logic_vector (11 downto 0);
    status       : in   std_logic_vector (3 downto 0);
    load_a       : out  std_logic;
    load_b       : out  std_logic;
    mux_a        : out  std_logic_vector (1 downto 0);
    mux_b        : out  std_logic_vector (1 downto 0);
    load_pc      : out  std_logic;
    alu_sop      : out  std_logic_vector (2 downto 0);
    write_memo   : out  std_logic;
    sp_up        : out  std_logic; 
    sp_down      : out  std_logic; 
    load_sp      : out  std_logic;
    sub_bp       : out  std_logic;
    mux_datain   : out  std_logic_vector (1 downto 0);
    mux_address  : out  std_logic_vector (3 downto 0);
    load_bp      : out  std_logic;
    mux_bp       : out  std_logic
          );
end component;

component AddSu12 
    Port ( a        : in  std_logic_vector (11 downto 0);
           b        : in  std_logic_vector (11 downto 0);
           ci       : in  std_logic;
           sub      : in  std_logic;
           s        : out std_logic_vector (11 downto 0);
           co       : out std_logic);
    end component;


-- Fin de la declaraciÃ³n de los componentes.

-- Inicio de la declaraciÃ³n de seÃ±ales.

signal clock            : std_logic := '0';                     -- SeÃ±al del clock reducido.         
        
            
signal dis_a            : std_logic_vector(3 downto 0) := (others => '0');  -- SeÃ±ales de salida al display A.    
signal dis_b            : std_logic_vector(3 downto 0) := (others => '0');  -- SeÃ±ales de salida al display B.     
signal dis_c            : std_logic_vector(3 downto 0) := (others => '0');  -- SeÃ±ales de salida al display C.    
signal dis_d            : std_logic_vector(3 downto 0) := (others => '0');  -- SeÃ±ales de salida al display D.  

signal d_btn            : std_logic_vector(4 downto 0) := (others => '0');  -- SeÃ±ales de botones con antirrebote.

signal load_a           : std_logic;
signal load_b           : std_logic;
signal reg_a            : std_logic_vector(11 downto 0);
signal reg_b            : std_logic_vector(11 downto 0);

signal mux_select_a     : std_logic_vector(1 downto 0);
signal mux_select_b     : std_logic_vector(1 downto 0);
signal mux_a            : std_logic_vector(11 downto 0);
signal mux_b            : std_logic_vector(11 downto 0);

signal alu_sop          : std_logic_vector(2 downto 0);
signal alu_result       : std_logic_vector(11 downto 0);
signal alu_c            : std_logic;
signal alu_z            : std_logic;
signal alu_n            : std_logic;
signal alu_o            : std_logic;

signal load_pc          : std_logic;
signal pc_out           : std_logic_vector(11 downto 0);
signal pc_plus           : std_logic_vector(11 downto 0);
signal st_pc            : std_logic;
signal pc_datain        : std_logic_vector(11 downto 0);
signal rom_address      : std_logic_vector(11 downto 0);
signal word             : std_logic_vector(11 downto 0);

signal mux_mem_address  : std_logic_vector(3 downto 0);
signal mux_mem_datain   : std_logic_vector(1 downto 0);
signal mem_address      : std_logic_vector(11 downto 0);
signal write_mem        : std_logic;
signal mem_datain       : std_logic_vector(11 downto 0);
signal mem_dataout      : std_logic_vector(11 downto 0);

signal status_dataout   : std_logic_vector(3 downto 0);

signal sp_up            : std_logic;
signal sp_load            : std_logic;
signal sp_down          : std_logic;
signal sp_datain       : std_logic_vector(11 downto 0);
signal sp_dataout       : std_logic_vector(11 downto 0);
signal bp_load            : std_logic;
signal bp_sub            : std_logic;
signal bp_datain       : std_logic_vector(11 downto 0);
signal bp_dataout       : std_logic_vector(11 downto 0);
signal mux_bp : std_logic;
signal r_cu_dataout       : std_logic_vector(11 downto 0);
signal bp_lit       : std_logic_vector(11 downto 0);

signal liter : std_logic_vector(11 downto 0) := (others => '0'); 
signal muxaddtwo : std_logic;
signal muxadd_out : std_logic_vector(11 downto 0);
signal mux_see : std_logic_vector(15 downto 0);
signal regular : std_logic_vector(1 downto 0);
signal sw_see : std_logic_vector(1 downto 0);
signal co_o : std_logic;
signal co_i : std_logic;


-- Fin de la declaraciÃ³n de los seÃ±ales.

begin


-- Inicio de declaraciÃ³n de comportadmientos.

dis_a  <= mux_see(15 downto 12);
dis_b  <= mux_see(11 downto 8);
dis_c  <= mux_see(7 downto 4);
dis_d  <= mux_see(3 downto 0);

with sw_see select
    mux_see <=   reg_a(7 downto 0) & reg_b(7 downto 0) when "00",
                pc_out(7 downto 0) & mem_address(7 downto 0)  when "01",
                mem_dataout(7 downto 0)  & alu_result(7 downto 0)  when "10",
                bp_dataout(7 downto 0)  & sp_dataout(7 downto 0)  when others ;

regular <= sw(1 downto 0);

sw_see <= sw(3 downto 2);
led(3) <= clock;

led(15) <= status_dataout(0);
led(14) <= status_dataout(1);
led(13) <= status_dataout(2);
led(11) <= alu_z;
led(10) <= alu_n;
led(9) <= alu_c;


with mux_select_a select
    mux_a <=    reg_a when "01",
                "000000000000" when "00",
                "000000000001"  when "11", 
                sp_dataout when "10" ;

with mux_select_b select
    mux_b <=    reg_b when "01",
                liter when "10",
                mem_dataout when "11",
                "000000000000" when "00" ;
                
with mux_bp select
    bp_datain <= mem_dataout when '0',
                 sp_dataout when '1';
                 
with mux_mem_datain select
    mem_datain <=    alu_result when "00",
                     bp_dataout when "10",
                     pc_plus when "01",
                     pc_out when "11" ;

with mux_mem_address select
     mem_address <= pc_out when "0000",
                    sp_dataout when "0001",
                    bp_lit when "0010",
                    liter when "0011",
                    reg_b when "0100",
                   "000000000000" when others; 

-- Inicio de declaraciÃ³n de instancias.

inst_Clock_Divider: Clock_Divider port map( -- No Tocar - Intancia de Clock_Divider.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    speed       => regular, -- Selector de velocidad: "00" full, "01" fast, "10" normal y "11" slow. 
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


-- Ejemplo de instancia, no esta correcto

inst_Reg_A: Reg port map(
    clock       => clock,
    load        => load_a,
    up          => '0',
    down        => '0',
    datain      => alu_result,
    dataout     => reg_a
    ); 

inst_Reg_B: Reg port map(
    clock       => clock,
    load        => load_b,
    up          => '0',
    down        => '0',
    datain      => alu_result,
    dataout     => reg_b
    );  
 
inst_RegCU: RegisterCU port map(
        clock       => clock,
        datain      => mem_dataout,
        dataout     => r_cu_dataout,
        lit => liter,
        selAddSec => muxaddtwo,
        stalling    => st_pc
        );  

inst_ALU: ALU port map(
    a           => mux_a,
    b           => mux_b,
    sop         => alu_sop,
    c           => alu_c,
    n           => alu_n,
    z           => alu_z,
    o           => alu_o,
    result      => alu_result
    );
    
inst_PC: PC port map(
    clock       => clock,
    load        => load_pc,
    stalling    => st_pc,
    datain      => pc_datain,
    dataout     => pc_out
    );

inst_MainMemory: MainMemory port map(
    clock       => clock,
    write       => write_mem,
    address     => mem_address,
    datain      => mem_datain,
    dataout     => mem_dataout
    );

inst_Status: Status port map(
    clock       => clock,
    c           => alu_c,
    z           => alu_z,
    n           => alu_n,
    o           => alu_o,
    dataout     => status_dataout
    );

inst_SP: SP port map(
    clock       => clock,
    load        => sp_load,
    up          => sp_up,
    down        => sp_down,
    datain      => alu_result,
    dataout     => sp_dataout
    );  

inst_BP: BP port map(
    clock       => clock,
    load        => bp_load,
    datain      => bp_datain,
    dataout     => bp_dataout
    ); 
 

inst_CU: CU port map(
    op         =>  r_cu_dataout,
    status       => status_dataout,
    load_a       => load_a,
    load_b       => load_b,
    mux_a        => mux_select_a,
    mux_b        => mux_select_b,
    load_pc      => load_pc, 
    alu_sop      => alu_sop,
    write_memo   => write_mem,
    sp_up         => sp_up, 
    sp_down       => sp_down,
    load_sp      => sp_load, 
    sub_bp       => bp_sub,
    mux_datain   => mux_mem_datain,
    mux_address  => mux_mem_address,
    load_bp      => bp_load,
    mux_bp     => mux_bp
    ); 

inst_AddSu_PC: AddSu12 port map(
        a      => "000000000010",
        b      => pc_out,
        ci     => '0' ,
        sub    => '0',
        s      => pc_plus,
        co     => co_o
    );

inst_AddSu_BP: AddSu12 port map(
        a      => bp_dataout,
        b      => liter,
        ci     => bp_sub,
        sub    => bp_sub,
        s      => bp_lit,
        co     => co_i
    );

-- Fin de declaraciÃ³n de instancias.

-- Fin de declaraciÃ³n de comportamientos.
  
end Behavioral;

