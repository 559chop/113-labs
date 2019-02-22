library ieee;
use ieee.std_logic_1164.all;

entity MUX_TB is
end MUX_TB;

architecture TB of MUX_TB is

   component MUX_gate is
   port( a: in std_logic;
         b: in std_logic;
		 sel: in std_logic;
         z: out std_logic
        );
   end component;

   signal a, b, sel, z: std_logic;

   begin

      test_MUX_TB: MUX_gate port map (a, b, sel, z);

   process 
      begin
         --case1
         a <= '0';
         b <= '0';
		 sel <= '0';
         wait for 10 ns;
         assert(z='0') --desired output value
		 report "case 1 failed" severity error; --if not desired output
		 
         --case2
         a <= '0';
         b <= '0';
		 sel <= '1';
         wait for 10 ns;
         assert(z='0') --desired output value
		 report "case 2 failed" severity error; --if not desired output

         --case3
         a <= '0';
         b <= '1';
		 sel <= '0';
         wait for 10 ns;
         assert(z='0') --desired output value
		 report "case 3 failed" severity error; --if not desired output
         
         --case4
         a <= '0';
         b <= '1';
		 sel <= '1';
         wait for 10 ns;
         assert(z='1') --desired output value
		 report "case 4 failed" severity error; --if not desired output
		 
         --case5
         a <= '1';
         b <= '0';
		 sel <= '0';
         wait for 10 ns;
         assert(z='1') --desired output value
		 report "case 5 failed" severity error; --if not desired output
		 
         --case6
         a <= '1';
         b <= '0';
		 sel <= '1';
         wait for 10 ns;
         assert(z='0') --desired output value
		 report "case 6 failed" severity error; --if not desired output

         --case7
         a <= '1';
         b <= '1';
		 sel <= '0';
         wait for 10 ns;
         assert(z='1') --desired output value
		 report "case 7 failed" severity error; --if not desired output
         
         --case8
         a <= '1';
         b <= '1';
		 sel <= '1';
         wait for 10 ns;
         assert(z='1') --desired output value
		 report "case 8 failed" severity error; --if not desired output
         
         wait;
   end process;

end TB;

configuration CFG_TB of MUX_TB is 
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)


