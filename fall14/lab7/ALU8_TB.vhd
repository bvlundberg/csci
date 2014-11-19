library ieee;
use ieee.std_logic_1164.all;

entity ALU8_TB is
end ALU8_TB;

architecture TB of  ALU8_TB is

   component ALU8 is
	port( op: in std_logic_vector(1 downto 0);
      a: in std_logic_vector(7 downto 0);
      b: in std_logic_vector(7 downto 0);
      binv: in std_logic;
      cout: out std_logic;
      result: out std_logic_vector(7 downto 0);
      overflow: out std_logic
      );
   end component;

   signal op: std_logic_vector (1 downto 0);
   signal a, b, result: std_logic_vector (7 downto 0);
   signal binv, cout, overflow: std_logic;
   
   
   begin

      test_ALU8_TB: ALU8 port map (op, a, b, binv, cout, result, overflow);

   process 
      begin
      --case1
      op <= "00";
      a <= "11111111";
      b <= "11111111";
      binv <= '0';

      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";

      --case2
      op <= "01";
      a <= "11111111";
      b <= "11111111";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case3
      op <= "10";
      a <= "11111111";
      b <= "11111111";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111110" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case4
      op <= "10";
      a <= "11111111";
      b <= "11111111";
      binv <= '1';
      wait for 10 ns;
      assert result = "00000000" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case5
      op <= "00";
      a <= "01111111";
      b <= "10000000";
      binv <= '0';
      wait for 10 ns;
      assert result = "00000000" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case6
      op <= "01";
      a <= "01111111";
      b <= "10000000";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case7
      op <= "10";
      a <= "01111111";
      b <= "10000000";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case8
      op <= "10";
      a <= "01111111";
      b <= "10000000";
      binv <= '1';
      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '1' report "Incorrect overflow";


      --case9
      op <= "00";
      a <= "10000000";
      b <= "01111111";
      binv <= '0';
      wait for 10 ns;
      assert result = "00000000" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case10
      op <= "01";
      a <= "10000000";
      b <= "01111111";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case11
      op <= "10";
      a <= "10000000";
      b <= "01111111";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case12
      op <= "10";
      a <= "10000000";
      b <= "01111111";
      binv <= '1';
      wait for 10 ns;
      assert result = "00000001" report "Incorrect result";
      assert overflow = '1' report "Incorrect overflow";


      --case13
      op <= "00";
      a <= "01010101";
      b <= "10101010";
      binv <= '0';
      wait for 10 ns;
      assert result = "00000000" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case14
      op <= "01";
      a <= "01010101";
      b <= "10101010";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case15
      op <= "10";
      a <= "01010101";
      b <= "10101010";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111111" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case16
      op <= "10";
      a <= "01010101";
      b <= "10101010";
      binv <= '1';
      wait for 10 ns;
      assert result = "10101011" report "Incorrect result";
      assert overflow = '1' report "Incorrect overflow";


      --case17
      op <= "00";
      a <= "11011011";
      b <= "10101010";
      binv <= '0';
      wait for 10 ns;
      assert result = "10001010" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case18
      op <= "01";
      a <= "11011011";
      b <= "10101010";
      binv <= '0';
      wait for 10 ns;
      assert result = "11111011" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case19
      op <= "10";
      a <= "11011011";
      b <= "10101010";
      binv <= '0';
      wait for 10 ns;
      assert result = "10000101" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";


      --case20
      op <= "10";
      a <= "11011011";
      b <= "10101010";
      binv <= '1';
      wait for 10 ns;
      assert result = "00110001" report "Incorrect result";
      assert overflow = '0' report "Incorrect overflow";

	       
         wait;
   end process;

end TB;

configuration CFG_TB of ALU8_TB is 
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)
