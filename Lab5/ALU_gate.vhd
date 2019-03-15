library ieee;
use ieee.std_logic_1164.all;

entity ALU_gate is
port( a: in std_logic;
      b: in std_logic;
	  cin: in std_logic;
	  op1: in std_logic;
	  op2: in std_logic;
	  cout: out std_logic;
      result: out std_logic
      );
end ALU_gate;

architecture struct of ALU_gate is

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
   
   component MUX_gate is
   port(  a: in std_logic;
		  b: in std_logic;
		  c: in std_logic;
		  d: in std_logic;
		  selone: in std_logic;
		  seltwo: in std_logic;
		  result: out std_logic
        );
   end component;
   
   component ADDER_gate is
   port(  a: in std_logic;
		  b: in std_logic;
		  cin: in std_logic;
		  sum: out std_logic;
		  cout: out std_logic
        );
   end component;
   
   signal andOut : std_logic;
   signal orOut : std_logic;
   signal adderOut : std_logic;

   
	

begin

	map_AND: AND_gate port map (a, b, andOut);
	map_OR: OR_gate port map (a, b, orOut);
	map_ADDER: ADDER_gate port map (a, b, cin, adderOut, cout);
	map_MUX: MUX_gate port map (andOut, orOut, adderOut, adderOut, op1, op2, result)

end struct;
