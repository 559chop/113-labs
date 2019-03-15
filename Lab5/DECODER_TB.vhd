library ieee;
use ieee.std_logic_1164.all;

entity DECODER_TB is
end DECODER_TB;

architecture TB of DECODER_TB is

   component DECODER_2x4 is
   port( 
		sel1: in std_logic;
		sel2: in std_logic;
		d1: out std_logic;
		d2: out std_logic;
		d3: out std_logic;
		d4: out std_logic
        );
   end component;

   signal sel1, sel2, d1, d2, d3, d4: std_logic;

   begin

      test_DECODER_TB: DECODER_2x4 port map (sel1, sel2, d1, d2, d3, d4);

   process 
      begin
         --case1
         sel1 <= '0';
         sel2 <= '0';
         wait for 10 ns;
		 assert(d1 ='1')
		 report "case 1 failed" severity error; --if not desired output
		 
		 --case1
         sel1 <= '0';
         sel2 <= '1';
         wait for 10 ns;
		 assert(d2 ='1')
		 report "case 1 failed" severity error; --if not desired output
		 
		 --case1
         sel1 <= '1';
         sel2 <= '0';
         wait for 10 ns;
		 assert(d3 ='1')
		 report "case 1 failed" severity error; --if not desired output
		 
		 --case1
         sel1 <= '1';
         sel2 <= '1';
         wait for 10 ns;
		 assert(d4 ='1')
		 report "case 1 failed" severity error; --if not desired output
		 
         wait;
   end process;

end TB;

configuration CFG_TB of DECODER_TB is 
   for TB
   end for;
end CFG_TB; --or, lower case is OK (end cfg_TB)

