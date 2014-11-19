library ieee;
use ieee.std_logic_1164.all;

entity ALU1OVF is
port( op: in std_logic_vector(1 downto 0);
      a: in std_logic;
      b: in std_logic;
      binv: in std_logic;
      cin: in std_logic;
      cout: out std_logic;
      result: out std_logic;
      overflow: out std_logic
      );
end ALU1OVF;

architecture struct of ALU1OVF is
   component AND_gate is
   port( x: in std_logic;
         y: in std_logic;
         z: out std_logic
        );
   end component;
   component OR_gate is
   port( x: in std_logic;
         y: in std_logic;
         z: out std_logic
       ); 
   end component;
   component MUX_4x1 is
   port( op: in std_logic_vector(1 downto 0);
      a: in std_logic;
      b: in std_logic;
      c: in std_logic;
      d: in std_logic;
      z: out std_logic
      );
      end component;
   component Full_Adder1 is
   port( a: in std_logic;
      b: in std_logic;
      cin: in std_logic;
      sum:  out std_logic;
      cout:  out std_logic
      );
   end component;
   component MUX_2x1 is
   port( a: in std_logic;
      b: in std_logic;
      s: in std_logic;
      z: out std_logic
      );
   end component;

   component XOR_gate is
   port( a: in std_logic;
      b: in std_logic;
      c:  out std_logic
      );
      end component;

   component NOT_gate is
   port( x: in std_logic;
      z: out std_logic
     );
      end component;

   signal and1: std_logic;
   signal or1: std_logic;
   signal mux1: std_logic;
   signal addSum: std_logic;
   signal temp: std_logic;
   signal xor1: std_logic;
   signal xor2: std_logic;
   signal not1: std_logic;
   signal not2: std_logic;
begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_NOT_gate: NOT_gate port map (b, not1);
   map_MUX_2x1: MUX_2x1 port map (b, not1, binv, mux1);
   map_AND_gate1: AND_gate port map (a, mux1, and1);
   map_OR_gate1: OR_gate port map (a, mux1, or1);
   map_Adder1: Full_Adder1 port map (a, mux1, cin, addSum, cout);
   map_MUX_4x1: MUX_4x1 port map (op, and1, or1, addSum, '0', result);
   map_XOR1: XOR_gate port map (a, mux1, xor1);
   map_XOR2: XOR_gate port map (a, addSum, xor2);
   map_NOT1: NOT_gate port map (xor1, not2);
   map_AND_gate2: AND_gate port map (not2, xor2, overflow);
     
end struct;