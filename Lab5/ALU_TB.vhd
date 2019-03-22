

library ieee;
use ieee.std_logic_1164.all;

entity ALU_TB is
end ALU_TB;

architecture TB of ALU_TB is


   component ALU_gate is
   port(  a: in std_logic;
          b: in std_logic;
          cin: in std_logic;
          op1: in std_logic;
          op2: in std_logic;
          cout: out std_logic;
          result:  out std_logic
      );

   end component;

   signal a,b,cin,op1,op2,cout,result: std_logic;

   begin
      test_OneBitALU: ALU_gate port map (a,b,cin,op1,op2,cout,result);

   process
      begin
         --case1
           op1 <= '0';
		     op2 <= '0';
           a <= '0';
           b <= '1';
		     cin <= '0';
           wait for 10 ns;
           assert ((cout = '0') and (result = '0'))
           report "case1 failed!" severity error;


         --case2
         op1 <= '0';
         op2 <= '0';
         a <= '0';
         b <= '1';
         cin <= '1';
         wait for 10 ns;
		     assert ((cout = '1') and (result = '0'))
		     report "case2 failed!" severity error;


         --case3
         op1 <= '0';
         op2 <= '0';
         a <= '1';
         b <= '1';
		     cin <= '0';
         wait for 10 ns;
		     assert ((cout = '1') and (result = '1'))
		     report "case3 failed!" severity error;


         --case4
		   op1 <= '0';
		   op2 <= '1';
         a <= '0';
         b <= '1';
         cin <= '0';
         wait for 10 ns;
         assert ((cout = '0') and (result = '1'))
         report "case4 failed!" severity error;

		  --case5
        op1 <= '0';
        op2 <= '1';
        a <= '1';
        b <= '0';
        cin <= '1';
        wait for 10 ns;
        assert ((cout = '1') and (result = '1'))
        report "case5 failed!" severity error;


		  --case6
		 op1 <= '0';
		 op2 <= '1';
        a <= '1';
      b <= '1';
		 cin <= '0';
       wait for 10 ns;
		 assert ((cout = '1') and (result = '1'))
		 report "case6 failed!" severity error;

		   --case7
		 op1 <= '1';
		 op2 <= '0';
    a <= '0';
    b <= '0';
		 cin <= '1';
    wait for 10 ns;
		 assert ((cout = '0') and (result = '1'))
		 report "case7 failed!" severity error;


		   --case8
		   op1 <= '1';
		   op2 <= '0';
       a <= '0';
       b <= '1';
		   cin <= '0';
       wait for 10 ns;
		   assert ((cout = '0') and (result = '1'))
		   report "case8 failed!" severity error;


		   --case9
         op1 <= '1';
         op2 <= '0';
         a <= '1';
         b <= '0';
		     cin <= '1';
         wait for 10 ns;
		     assert ((cout = '1') and (result = '0'))
		     report "case9 failed!" severity error;


		   --case10
		    op1 <= '1';
		    op2 <= '0';
        a <= '1';
        b <= '1';
	    	cin <= '0';
        wait for 10 ns;
        assert ((cout = '1') and (result = '0'))
         report "case10 failed!" severity error;


		   --case11
		    op1 <= '1';
		    op2 <= '0';
        a <= '1';
        b <= '1';
		    cin <= '1';
	
        wait for 10 ns;
        assert ((cout = '1') and (result = '1'))
        report "case11 failed!" severity error;

		 --case12
         a <= '0';
         b <= '1';
         cin <= '0';
         op2 <= '0';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '0') and (result = '0')) 
         report "case12 failed!" severity error; 

         --case13
         a <= '0';
         b <= '1';
         cin <= '1';
         op2 <= '0';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '1') and (result = '0')) 
         report "case13 failed!" severity error; 

         --case14
         a <= '1';
         b <= '1';
         cin <= '0';
         op2 <= '0';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '1') and (result = '1')) 
         report "case14 failed!" severity error; 


--case15
         a <= '0';
         b <= '1';
         cin <= '0';
         op2 <= '0';
         op1 <= '1';
         wait for 10 ns;
         assert ((cout = '0') and (result = '1')) 
         report "case15 failed!" severity error; 


--case16
         a <= '1';
         b <= '0';
         cin <= '1';
         op2 <= '0';
         op1 <= '1';
         wait for 10 ns;
         assert ((cout = '1') and (result = '0')) 
         report "case16 failed!" severity error; 


--case17
         a <= '1';
         b <= '1';
         cin <= '0';
         op2 <= '0';
         op1 <= '1';
         wait for 10 ns;
         assert ((cout = '1') and (result = '0')) 
         report "case17 failed!" severity error; 


--case18
         a <= '0';
         b <= '0';
         cin <= '1';
         op2 <= '1';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '0') and (result = '0')) 
         report "case18 failed!" severity error; 


--case19
         a <= '0';
         b <= '1';
         cin <= '0';
         op2 <= '1';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '0') and (result = '1')) 
         report "case19 failed!" severity error; 


--case20
         a <= '1';
         b <= '0';
         cin <= '1';
         op2 <= '1';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '1') and (result = '1')) 
         report "case20 failed!" severity error; 


--case21
         a <= '1';
         b <= '1';
         cin <= '0';
         op2 <= '1';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '1') and (result = '1')) 
         report "case21 failed!" severity error; 


--case22
         a <= '1';
         b <= '1';
         cin <= '1';
         op2 <= '1';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '1') and (result = '1')) 
         report "case22 failed!" severity error; 


--case23
         a <= '1';
         b <= '1';
         cin <= '1';
         op2 <= '1';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '1') and (result = '1')) 
         report "case23 failed!" severity error; 

--case24
         a <= '1';
         b <= '1';
         cin <= '1';
         op2 <= '0';
         op1 <= '0';
         wait for 10 ns;
         assert ((cout = '1') and (result = '1')) 
         report "case24 failed!" severity error; 




         wait;
   end process;
end TB;

configuration CFG_TB of ALU_TB is
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)
