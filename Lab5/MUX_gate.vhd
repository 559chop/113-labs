library ieee;
use ieee.std_logic_1164.all;

entity MUX_gate is
port( a: in std_logic;
      b: in std_logic;
	  c: in std_logic;
	  d: in std_logic;
	  selone: in std_logic;
	  seltwo: in std_logic;
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
   port( sel1: in std_logic;
		 sel2: in std_logic;
         d1: out std_logic;
		 d2: out std_logic;
		 d3: out std_logic;
		 d4: out std_logic
        );
   end component;
   
   signal dOut1 : std_logic;
   signal dOut2 : std_logic; 
   signal dOut3 : std_logic; 
   signal dOut4 : std_logic;
   
   signal andOut1 : std_logic;
   signal andOut2 : std_logic; 
   signal andOut3 : std_logic; 
   signal andOut4 : std_logic; 
   
   signal orOut1 : std_logic; 
   signal orOut2 : std_logic; 
   
	

begin

	map_DECODER: DECODER_2x4 port map (selone, seltwo, dOut1, dOut2, dOut3, dOut4); 
	map_AND1: AND_gate port map (a, dOut1, andOut1);
	map_AND2: AND_gate port map (b, dOut2, andOut2);
	map_AND3: AND_gate port map (c, dOut3, andOut3);
	map_AND4: AND_gate port map (d, dOut4, andOut4);
	map_OR1: OR_gate port map (andOut1, andOut2, orOut1);
	map_OR2: OR_gate port map (andOut3, andOut4, orOut2);
	map_ORfinal: OR_gate port map (orOut1, orOut2, result);

end struct;
