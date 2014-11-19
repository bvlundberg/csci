library ieee;
use ieee.std_logic_1164.all;

entity ALU8 is
port( op: in std_logic_vector(1 downto 0);
      a: in std_logic_vector(7 downto 0);
      b: in std_logic_vector(7 downto 0);
      binv: in std_logic;
      cout: out std_logic;
      result: out std_logic_vector(7 downto 0);
      overflow: out std_logic
      );
end ALU8;

architecture struct of ALU8 is
   component ALU1 is
   port( op: in std_logic_vector(1 downto 0);
      a: in std_logic;
      b: in std_logic;
      binv: in std_logic;
      cin: in std_logic;
      cout: out std_logic;
      result: out std_logic
      );
      end component;

   component ALU1OVF is
   port( op: in std_logic_vector(1 downto 0);
      a: in std_logic;
      b: in std_logic;
      binv: in std_logic;
      cin: in std_logic;
      cout: out std_logic;
      result: out std_logic;
      overflow: out std_logic
      );
      end component;

   signal cout0: std_logic;
   signal cout1: std_logic;
   signal cout2: std_logic;
   signal cout3: std_logic;
   signal cout4: std_logic;
   signal cout5: std_logic;
   signal cout6: std_logic;
   signal cout7: std_logic;

begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_ALU0: ALU1 port map (op, a(0), b(0), binv, binv, cout0, result(0));
   map_ALU1: ALU1 port map (op, a(1), b(1), binv, cout0, cout1, result(1));
   map_ALU2: ALU1 port map (op, a(2), b(2), binv, cout1, cout2, result(2));
   map_ALU3: ALU1 port map (op, a(3), b(3), binv, cout2, cout3, result(3));
   map_ALU4: ALU1 port map (op, a(4), b(4), binv, cout3, cout4, result(4));
   map_ALU5: ALU1 port map (op, a(5), b(5), binv, cout4, cout5, result(5));
   map_ALU6: ALU1 port map (op, a(6), b(6), binv, cout5, cout6, result(6));
   map_ALU7: ALU1OVF port map (op, a(7), b(7), binv, cout6, cout, result(7), overflow);
     
end struct;