library ieee;
use ieee.std_logic_1164.all;

entity MUX_2x1 is
   port( 
         a: in std_logic;
         b: in std_logic;
         s: in std_logic;
         z: out std_logic
         );
end MUX_2x1;

architecture struct of MUX_2x1 is

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
  
   signal not1: std_logic;
   signal and1: std_logic; 
   signal and2: std_logic; 


begin
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_AND_gate1: AND_gate port map (b, s, and1);
   map_NOT_gate2: NOT_gate port map (s, not1);
   map_AND_gate2: AND_gate port map (a, not1, and2);
   map_OR_gate1: OR_gate port map (and1, and2, z);

end struct;
