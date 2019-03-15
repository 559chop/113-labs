library ieee;
use ieee.std_logic_1164.all;

entity ADDER_TB is
end ADDER_TB;

architecture TB of ADDER_TB is

   component ADDER_gate is
   port( a: in std_logic;
         b: in std_logic;
		 cin: in std_logic;
		 sum: out std_logic;
         cout: out std_logic
        );
   end component;

   signal a, b, cin, cout, sum: std_logic;

   begin

      test_ADDER_TB: ADDER_gate port map (a, b, cin, cout, sum);

   process 
      begin
         --case1
         a <= '0';
         b <= '0';
		 cin <= '0';
         wait for 10 ns;
		 assert(sum ='0' and cout = '0')
		 report "case 1 failed" severity error; --if not desired output
		 
         --case2
         a <= '0';
         b <= '0';
		 cin <= '1';
         wait for 10 ns;
		 assert(sum ='1' and cout = '0')
		 report "case 2 failed" severity error; --if not desired output

         --case3
         a <= '0';
         b <= '1';
		 cin <= '0';
         wait for 10 ns;
		 assert(sum ='1' and cout = '0')
		 report "case 3 failed" severity error; --if not desired output
         
         --case4
         a <= '0';
         b <= '1';
		 cin <= '1';
         wait for 10 ns;
		 assert(sum ='0' and cout = '1')
		 report "case 4 failed" severity error; --if not desired output
		 
         --case5
         a <= '1';
         b <= '0';
		 cin <= '0';
         wait for 10 ns;
		 assert(sum ='1' and cout = '0')
		 report "case 5 failed" severity error; --if not desired output
		 
         --case6
         a <= '1';
         b <= '0';
		 cin <= '1';
         wait for 10 ns;
		 assert(sum ='0' and cout = '1')
		 report "case 6 failed" severity error; --if not desired output

         --case7
         a <= '1';
         b <= '1';
		 cin <= '0';
         wait for 10 ns;
		 assert(sum ='0' and cout = '1')
		 report "case 7 failed" severity error; --if not desired output
         
         --case8
         a <= '1';
         b <= '1';
		 cin <= '1';
         wait for 10 ns;
		 assert(sum ='1' and cout = '1')
		 report "case 8 failed" severity error; --if not desired output
         
         wait;
   end process;

end TB;

configuration CFG_TB of ADDER_TB is 
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)

