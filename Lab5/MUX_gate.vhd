library ieee;
use ieee.std_logic_1164.all;

entity MUX_gate is
port( a: in std_logic;
      b: in std_logic;
	  c: in std_logic;
	  d: in std_logic;
      result: out std_logic
      );
end MUX_gate;

architecture struct of MUX_gate is

   --use previously designed subcomponents
   component AND_gate is
   port( x: in std_logic;
         y: in std_logic;
         z: out std_logic
        );
   end component;

   component OR_gate is
   port( x: in std_logic;
         y: in std_logic;
         z: out std_logic
        );
   end component;
   
   component DECODER_2x4 is
   port( x: in std_logic;
		 y: in std_logic;
         z1: out std_logic;
		 z2: out std_logic;
		 z3: out std_logic;
		 z4: out std_logic
        );
   end component;
   
   signal exclusiveORofAB: std_logic; 
	

begin

	map_XOR_gate: XOR_gate port map (a, b, exclusiveORofAB); 

end struct;
