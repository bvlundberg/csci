library ieee;
use ieee.std_logic_1164.all;

entity ALU_TB is
end ALU_TB;

architecture TB of  ALU_TB is

   component ALU1 is
   port( op: in std_logic_vector(1 downto 0);
      a: in std_logic;
      b: in std_logic;
      cin: in std_logic;
      cout: out std_logic;
      result: out std_logic
      );
   end component;

   signal a, b, cin, cout, result: std_logic;
   signal op: std_logic_vector (1 downto 0);
   
   begin

      test_ALU_TB: ALU1 port map (op, a, b, cin, cout, result);

   process 
      begin
         --case1
         a <= '0';
	       b <= '0';
	       cin <= '0';
	       op <= "00";
         wait for 10 ns;
         
         --case2
         a <= '0';
	       b <= '0';
	       cin <= '0';
	       op <= "01";
         wait for 10 ns;

         --case3
         a <= '0';
	       b <= '0';
	       cin <= '0';
	       op <= "10";
         wait for 10 ns;
         
         --case4
         a <= '0';
	       b <= '0';
	       cin <= '0';
	       op <= "11";
         wait for 10 ns;
         
         --case5
         a <= '0';
	       b <= '0';
	       cin <= '1';
	       op <= "00";
         wait for 10 ns;
         
         --case6
         a <= '0';
	       b <= '0';
	       cin <= '1';
	       op <= "01";
         wait for 10 ns;

         --case7
         a <= '0';
	       b <= '0';
	       cin <= '1';
	       op <= "10";
         wait for 10 ns;
         
         --case8
         a <= '0';
	       b <= '0';
	       cin <= '1';
	       op <= "11";
         wait for 10 ns;
         
         --case9
         a <= '0';
	       b <= '1';
	       cin <= '0';
	       op <= "00";
         wait for 10 ns;
         
         --case10
         a <= '0';
	       b <= '1';
	       cin <= '0';
	       op <= "01";
         wait for 10 ns;

         --case11
         a <= '0';
	       b <= '1';
	       cin <= '0';
	       op <= "10";
         wait for 10 ns;
         
         --case12
         a <= '0';
	       b <= '1';
	       cin <= '0';
	       op <= "11";
	       
	       --case13
         a <= '0';
	       b <= '1';
	       cin <= '1';
	       op <= "00";
         wait for 10 ns;
         
         --case14
         a <= '0';
	       b <= '1';
	       cin <= '1';
	       op <= "01";
         wait for 10 ns;

         --case15
         a <= '0';
	       b <= '1';
	       cin <= '1';
	       op <= "10";
         wait for 10 ns;
         
         --case16
         a <= '0';
	       b <= '1';
	       cin <= '1';
	       op <= "11";
         wait for 10 ns;
         
         --case17
         a <= '1';
	       b <= '0';
	       cin <= '0';
	       op <= "00";
         wait for 10 ns;
         
         --case18
         a <= '1';
	       b <= '0';
	       cin <= '0';
	       op <= "01";
         wait for 10 ns;

         --case19
         a <= '1';
	       b <= '0';
	       cin <= '0';
	       op <= "10";
         wait for 10 ns;
         
         --case20
         a <= '1';
	       b <= '0';
	       cin <= '0';
	       op <= "11";
	       wait for 10 ns;
	       

	       --case21
         a <= '1';
	       b <= '0';
	       cin <= '1';
	       op <= "00";
         wait for 10 ns;
         
         --case22
         a <= '1';
	       b <= '0';
	       cin <= '1';
	       op <= "01";
         wait for 10 ns;

         --case23
         a <= '1';
	       b <= '0';
	       cin <= '1';
	       op <= "10";
         wait for 10 ns;
         
         --case24
         a <= '1';
	       b <= '0';
	       cin <= '1';
	       op <= "11";
	       wait for 10 ns;
	       
	       --case25
         a <= '1';
	       b <= '1';
	       cin <= '0';
	       op <= "00";
         wait for 10 ns;
         
         --case26
         a <= '1';
	       b <= '1';
	       cin <= '0';
	       op <= "01";
         wait for 10 ns;

         --case27
         a <= '1';
	       b <= '1';
	       cin <= '0';
	       op <= "10";
         wait for 10 ns;
         
         --case28
         a <= '1';
	       b <= '1';
	       cin <= '0';
	       op <= "11";
	       wait for 10 ns;
	       
	       --case29
         a <= '1';
	       b <= '1';
	       cin <= '1';
	       op <= "00";
         wait for 10 ns;
         
         --case30
         a <= '1';
	       b <= '1';
	       cin <= '1';
	       op <= "01";
         wait for 10 ns;

         --case31
         a <= '1';
	       b <= '1';
	       cin <= '1';
	       op <= "10";
         wait for 10 ns;
         
         --case32
         a <= '1';
	       b <= '1';
	       cin <= '1';
	       op <= "11";
	       wait for 10 ns;

	       
         wait;
   end process;

end TB;

configuration CFG_TB of ALU_TB is 
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)
