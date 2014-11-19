library ieee;
use ieee.std_logic_1164.all;

entity NOT_gate is
port( x: in std_logic;
      z: out std_logic
     );
end NOT_gate;

architecture behav of NOT_gate is
begin

   process(x)
   begin
      if (x='0') then
         z <= '1';
      else
         z <= '0';
      end if;
   end process;
end behav;
