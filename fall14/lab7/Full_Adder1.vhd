library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder1 is
port( a: in std_logic;
      b: in std_logic;
      cin: in std_logic;
      sum:  out std_logic;
      cout:  out std_logic
      );
end Full_Adder1;

architecture struct of Full_Adder1 is

   --use previously designed subcomponent
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
   component XOR_gate is
   port( a: in std_logic;
   	 b: in std_logic;
   	 c: out std_logic
       );
   end component;
   
   signal xor1: std_logic; --output of a xor b
   signal and1: std_logic; --output of a and b
   signal and2: std_logic; --output of xor1 and cin

begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_XOR_gate1: XOR_gate port map (a, b, xor1);
   map_AND_gate1: AND_gate port map (a, b, and1);
   map_AND_gate2: AND_gate port map (cin, xor1, and2);
   map_OR_gate: OR_gate port map (and1, and2, cout);
   map_XOR_gate2: XOR_gate port map (xor1, cin, sum);

end struct;
