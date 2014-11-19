library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder1_TB is
end Full_Adder1_TB;

architecture TB of  Full_Adder1_TB is

   component Full_Adder1 is
   port( 
      a: in std_logic;
      b: in std_logic;
      cin: in std_logic;
      sum: out std_logic;
      cout: out std_logic
        );
   end component;

   signal a, b, cin, sum, cout: std_logic;

   begin

      test_Full_Adder1_gate: Full_Adder1 port map (a, b, cin, sum, cout);

   process 
      begin
         --case1
         a <= '0';
	 b <= '0';
	 cin <= '0';
         wait for 10 ns;
         
         --case2
         a <= '0';
	 b <= '0';
	 cin <= '1';
         wait for 10 ns;

         --case3
         a <= '0';
	 b <= '1';
	 cin <= '0';
         wait for 10 ns;
         
         --case4
         a <= '0';
	 b <= '1';
	 cin <= '1';
         wait for 10 ns;

	 --case5
         a <= '1';
	 b <= '0';
	 cin <= '0';
         wait for 10 ns;

	 --case6
         a <= '1';
	 b <= '0';
	 cin <= '1';
         wait for 10 ns;

	 --case7
         a <= '1';
	 b <= '1';
	 cin <= '0';
         wait for 10 ns;

	 --case8
         a <= '1';
	 b <= '1';
	 cin <= '1';
         wait for 10 ns;
         
         wait;
   end process;

end TB;

configuration CFG_TB of FULL_ADDER1_TB is 
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)
