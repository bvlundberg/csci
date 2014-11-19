library ieee;
use ieee.std_logic_1164.all;

entity decoder_2 is
port( op: in std_logic_vector(1 downto 0);
      a:  out std_logic;
      b:  out std_logic;
      c:  out std_logic;
      d:  out std_logic
      );
end decoder_2;

architecture struct of decoder_2 is
   component AND_gate is
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
   
   signal not0: std_logic; --output of a xor b
   signal not1: std_logic; --output of a and b

begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_NOT_gate1: NOT_gate port map (op(0), not0);
   map_NOT_gate2: NOT_gate port map (op(1), not1); 
   map_AND_gate1: AND_gate port map (not0, not1, a);
   map_AND_gate2: AND_gate port map (op(0), not1, b);
   map_AND_gate3: AND_gate port map (not0, op(1), c);
   map_AND_gate4: AND_gate port map (op(0), op(1), d);

end struct;
