library ieee;
use ieee.std_logic_1164.all;

entity ADDER_gate is
port( a: in std_logic;
      b: in std_logic;
      cin: in std_logic;
	  sum: out std_logic;
      cout: out std_logic
      );
end ADDER_gate;

architecture struct of ADDER_gate is

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
   
   component XOR_gate is
   port( x: in std_logic;
		 y: in std_logic;
         z: out std_logic
        );
   end component;

   signal exclusiveORofAB: std_logic; 
   signal andofAB: std_logic; 
   signal cinAndXorOfAB: std_logic; 

begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_XOR_gate: XOR_gate port map (a, b, exclusiveORofAB); 
   map_AND_gate: AND_gate port map (a, b, andofAB); 
   map_AND_gate2: AND_gate port map (cin, exclusiveORofAB, cinAndXorOfAB); 
   map_OR_gate:  OR_gate port map (andofAB, cinAndXorOfAB, cout); 
   map_XOR_gate2: XOR_gate port map (exclusiveORofAB, cin, sum);
end struct;
