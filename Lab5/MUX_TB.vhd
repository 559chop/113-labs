library ieee;
use ieee.std_logic_1164.all;

entity MUX_TB is
end MUX_TB;

architecture TB of MUX_TB is

   component MUX_gate is
   port( a: in std_logic;
         b: in std_logic;
		 c: in std_logic;
		 d: in std_logic;
		 selone: in std_logic;
		 seltwo: in std_logic;
         result: out std_logic
        );
   end component;

   signal a, b, c, d, selone, seltwo, result: std_logic;

   begin

      test_MUX_TB: MUX_gate port map (a, b, c, d, selone, seltwo,result);

   process 
      begin
         --case1
         a <= '1';
         b <= '0';
		 c <= '0';
		 d <= '0';
		 selone <= '0';
		 seltwo <= '0';
         wait for 10 ns;
         assert(result='0') --desired output value
		 report "case 1 failed" severity error; --if not desired output
		 
         --case2
         a <= '0';
         b <= '1';
		 c <= '0';
		 d <= '0';
		 selone <= '0';
		 seltwo <= '0';
         wait for 10 ns;
         assert(result='0') --desired output value
		 report "case 1 failed" severity error; --if not desired output
		 
		 --case3
         a <= '0';
         b <= '0';
		 c <= '1';
		 d <= '0';
		 selone <= '0';
		 seltwo <= '0';
         wait for 10 ns;
         assert(result='0') --desired output value
		 report "case 1 failed" severity error; --if not desired output
		 
		 --case4
         a <= '0';
         b <= '0';
		 c <= '0';
		 d <= '1';
		 selone <= '1';
		 seltwo <= '1';
         wait for 10 ns;
         assert(result='0') --desired output value
		 report "case 1 failed" severity error; --if not desired output
		 
		 
         
         wait;
   end process;

end TB;

configuration CFG_TB of MUX_TB is 
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)


