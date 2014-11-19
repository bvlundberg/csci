library ieee;
use ieee.std_logic_1164.all;

entity XOR_gate is
port( a: in std_logic;
      b: in std_logic;
      c:  out std_logic
      );
end XOR_gate;

architecture struct of XOR_gate is

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
   component NOT_gate is
   port( x: in std_logic;
   	 z: out std_logic
       );
   end component;

   signal not1: std_logic; --to store the output of the first negation
   signal not2: std_logic; --to store the output of the second negation
   signal temp1: std_logic;
   signal temp2: std_logic;
begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_NOT_gate1: NOT_gate port map (b, not2);
   map_NOT_gate2: NOT_gate port map (a, not1);
   map_AND_gate1: AND_gate port map (a, not2, temp1); --then, temp1 is passed to the 2nd AND as an input
   map_AND_gate2: AND_gate port map (not1, b, temp2);                                          --output of the 2nd AND becomes the output(y) of Two_ANDS
   map_OR_gate: OR_gate port map (temp1, temp2, c);
end struct;
