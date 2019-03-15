library ieee;
use ieee.std_logic_1164.all;

entity MUX_TB is
end MUX_TB;

architecture TB of MUX_TB is

   component MUX_gate is
   port(  a: in std_logic;
		  b: in std_logic;
		  cin: in std_logic;
		  op1: in std_logic;
		  op2: in std_logic;
		  cout: out std_logic;
		  result: out std_logic
        );
   end component;

   signal a, b, cin, op1, op2, cout, result: std_logic;

   begin

      test_MUX_TB: MUX_gate port map (a, b, c, d, selone, seltwo,result);

   process 
      begin
         --case1
         a <= '1';
         b <= '0';
		 cin <= '0';
		 op1 <= '0';
		 op2 <= '0';
         wait for 10 ns;
         assert(result='1') --desired output value
		 report "case 1 failed" severity error; --if not desired output
		 
		 
		 
		 
		 
         
         wait;
   end process;

end TB;

configuration CFG_TB of MUX_TB is 
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)


