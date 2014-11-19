library ieee;
use ieee.std_logic_1164.all;

entity MUX_4x1 is
port( op: in std_logic_vector(1 downto 0);
      a: in std_logic;
      b: in std_logic;
      c: in std_logic;
      d: in std_logic;
      z: out std_logic
      );
end MUX_4x1;

architecture struct of MUX_4x1 is
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
      component decoder_2 is
      port( op: in std_logic_vector(1 downto 0);
      a:  out std_logic;
      b:  out std_logic;
      c:  out std_logic;
      d:  out std_logic
      );
   end component;
   signal decA: std_logic;
   signal decB: std_logic;
   signal decC: std_logic;
   signal decD: std_logic;
   signal and1: std_logic; 
   signal and2: std_logic; 
   signal and3: std_logic; 
   signal and4: std_logic; 
   signal or1: std_logic; 
   signal or2: std_logic; 
begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_DECODER: decoder_2 port map (op, decA, decB, decC, decD);
   map_AND_gate1: AND_gate port map (a, decA, and1);
   map_AND_gate2: AND_gate port map (b, decB, and2);
   map_AND_gate3: AND_gate port map (c, decC, and3);
   map_AND_gate4: AND_gate port map (d, decD, and4);
   map_OR_gate1: OR_gate port map (and1, and2, or1);
   map_OR_gate2: OR_gate port map (and3, and4, or2);
   map_OR_gate3: OR_gate port map (or1, or2, z);


end struct;
